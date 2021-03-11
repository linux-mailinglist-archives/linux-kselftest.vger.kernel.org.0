Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A67337F4A
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Mar 2021 21:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCKUx1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Mar 2021 15:53:27 -0500
Received: from jptosegrel01.sonyericsson.com ([124.215.201.71]:7420 "EHLO
        JPTOSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229520AbhCKUxE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Mar 2021 15:53:04 -0500
X-Greylist: delayed 1210 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Mar 2021 15:53:03 EST
Subject: Re: [PATCH v5 5/8] security/brute: Mitigate a brute force attack
To:     John Wood <john.wood@gmx.com>, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>, Shuah Khan <shuah@kernel.org>
CC:     "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        <kernel-hardening@lists.openwall.com>
References: <20210227153013.6747-1-john.wood@gmx.com>
 <20210227153013.6747-6-john.wood@gmx.com>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <5419ebe6-bb82-9b66-052b-0eefff93e5ae@sony.com>
Date:   Thu, 11 Mar 2021 21:32:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210227153013.6747-6-john.wood@gmx.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=fqOim2wf c=1 sm=1 tr=0 a=9drRLWArJOlETflmpfiyCA==:117 a=IkcTkHD0fZMA:10 a=dESyimp9J3IA:10 a=7YfXLusrAAAA:8 a=WXpgeRTL1FoQa_35La8A:9 a=QEXdDO2ut3YA:10 a=SLz71HocmBbuEhFRYD3r:22
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/27/21 4:30 PM, John Wood wrote:
> In order to mitigate a brute force attack all the offending tasks involved
> in the attack must be killed. In other words, it is necessary to kill all
> the tasks that share the fork and/or exec statistical data related to the
> attack. Moreover, if the attack happens through the fork system call, the
> processes that have the same group_leader that the current task (the task
> that has crashed) must be avoided since they are in the path to be killed.
>
> When the SIGKILL signal is sent to the offending tasks, the function
> "brute_kill_offending_tasks" will be called in a recursive way from the
> task_fatal_signal LSM hook due to a small crash period. So, to avoid kill
> again the same tasks due to a recursive call of this function, it is
> necessary to disable the attack detection for the involved hierarchies.

Would it not be useful for forensic reasons to be able to send SIGABRT and get the a coredump?


> To disable the attack detection, set to zero the last crash timestamp and
> avoid to compute the application crash period in this case.
>
> Signed-off-by: John Wood <john.wood@gmx.com>
> ---
>  security/brute/brute.c | 141 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 132 insertions(+), 9 deletions(-)
>
> diff --git a/security/brute/brute.c b/security/brute/brute.c
> index 0a99cd4c3303..48b07d923ec7 100644
> --- a/security/brute/brute.c
> +++ b/security/brute/brute.c
> @@ -22,6 +22,7 @@
>  #include <linux/math64.h>
>  #include <linux/netdevice.h>
>  #include <linux/path.h>
> +#include <linux/pid.h>
>  #include <linux/printk.h>
>  #include <linux/refcount.h>
>  #include <linux/rwlock.h>
> @@ -64,7 +65,7 @@ struct brute_cred {
>   * @lock: Lock to protect the brute_stats structure.
>   * @refc: Reference counter.
>   * @faults: Number of crashes.
> - * @jiffies: Last crash timestamp.
> + * @jiffies: Last crash timestamp. If zero, the attack detection is disabled.
>   * @period: Crash period's moving average.
>   * @saved_cred: Saved credentials.
>   * @network: Network activity flag.
> @@ -566,6 +567,125 @@ static inline void print_fork_attack_running(void)
>  	pr_warn("Fork brute force attack detected [%s]\n", current->comm);
>  }
>
> +/**
> + * brute_disabled() - Test if the brute force attack detection is disabled.
> + * @stats: Statistical data shared by all the fork hierarchy processes.
> + *
> + * The brute force attack detection enabling/disabling is based on the last
> + * crash timestamp. A zero timestamp indicates that this feature is disabled. A
> + * timestamp greater than zero indicates that the attack detection is enabled.
> + *
> + * The statistical data shared by all the fork hierarchy processes cannot be
> + * NULL.
> + *
> + * It's mandatory to disable interrupts before acquiring the brute_stats::lock
> + * since the task_free hook can be called from an IRQ context during the
> + * execution of the task_fatal_signal hook.
> + *
> + * Context: Must be called with interrupts disabled and brute_stats_ptr_lock
> + *          held.
> + * Return: True if the brute force attack detection is disabled. False
> + *         otherwise.
> + */
> +static bool brute_disabled(struct brute_stats *stats)
> +{
> +	bool disabled;
> +
> +	spin_lock(&stats->lock);
> +	disabled = !stats->jiffies;
> +	spin_unlock(&stats->lock);
> +
> +	return disabled;
> +}
> +
> +/**
> + * brute_disable() - Disable the brute force attack detection.
> + * @stats: Statistical data shared by all the fork hierarchy processes.
> + *
> + * To disable the brute force attack detection it is only necessary to set the
> + * last crash timestamp to zero. A zero timestamp indicates that this feature is
> + * disabled. A timestamp greater than zero indicates that the attack detection
> + * is enabled.
> + *
> + * The statistical data shared by all the fork hierarchy processes cannot be
> + * NULL.
> + *
> + * Context: Must be called with interrupts disabled and brute_stats_ptr_lock
> + *          and brute_stats::lock held.
> + */
> +static inline void brute_disable(struct brute_stats *stats)
> +{
> +	stats->jiffies = 0;
> +}
> +
> +/**
> + * enum brute_attack_type - Brute force attack type.
> + * @BRUTE_ATTACK_TYPE_FORK: Attack that happens through the fork system call.
> + * @BRUTE_ATTACK_TYPE_EXEC: Attack that happens through the execve system call.
> + */
> +enum brute_attack_type {
> +	BRUTE_ATTACK_TYPE_FORK,
> +	BRUTE_ATTACK_TYPE_EXEC,
> +};
> +
> +/**
> + * brute_kill_offending_tasks() - Kill the offending tasks.
> + * @attack_type: Brute force attack type.
> + * @stats: Statistical data shared by all the fork hierarchy processes.
> + *
> + * When a brute force attack is detected all the offending tasks involved in the
> + * attack must be killed. In other words, it is necessary to kill all the tasks
> + * that share the same statistical data. Moreover, if the attack happens through
> + * the fork system call, the processes that have the same group_leader that the
> + * current task must be avoided since they are in the path to be killed.
> + *
> + * When the SIGKILL signal is sent to the offending tasks, this function will be
> + * called again from the task_fatal_signal hook due to a small crash period. So,
> + * to avoid kill again the same tasks due to a recursive call of this function,
> + * it is necessary to disable the attack detection for this fork hierarchy.
> + *
> + * The statistical data shared by all the fork hierarchy processes cannot be
> + * NULL.
> + *
> + * It's mandatory to disable interrupts before acquiring the brute_stats::lock
> + * since the task_free hook can be called from an IRQ context during the
> + * execution of the task_fatal_signal hook.
> + *
> + * Context: Must be called with interrupts disabled and tasklist_lock and
> + *          brute_stats_ptr_lock held.
> + */
> +static void brute_kill_offending_tasks(enum brute_attack_type attack_type,
> +				       struct brute_stats *stats)
> +{
> +	struct task_struct *p;
> +	struct brute_stats **p_stats;
> +
> +	spin_lock(&stats->lock);
> +
> +	if (attack_type == BRUTE_ATTACK_TYPE_FORK &&
> +	    refcount_read(&stats->refc) == 1) {
> +		spin_unlock(&stats->lock);
> +		return;
> +	}
> +
> +	brute_disable(stats);
> +	spin_unlock(&stats->lock);
> +
> +	for_each_process(p) {
> +		if (attack_type == BRUTE_ATTACK_TYPE_FORK &&
> +		    p->group_leader == current->group_leader)
> +			continue;
> +
> +		p_stats = brute_stats_ptr(p);
> +		if (*p_stats != stats)
> +			continue;
> +
> +		do_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_PID);
> +		pr_warn_ratelimited("Offending process %d [%s] killed\n",
> +				    p->pid, p->comm);
> +	}
> +}
> +
>  /**
>   * brute_manage_fork_attack() - Manage a fork brute force attack.
>   * @stats: Statistical data shared by all the fork hierarchy processes.
> @@ -581,8 +701,8 @@ static inline void print_fork_attack_running(void)
>   * since the task_free hook can be called from an IRQ context during the
>   * execution of the task_fatal_signal hook.
>   *
> - * Context: Must be called with interrupts disabled and brute_stats_ptr_lock
> - *          held.
> + * Context: Must be called with interrupts disabled and tasklist_lock and
> + *          brute_stats_ptr_lock held.
>   * Return: The last crash timestamp before updating it.
>   */
>  static u64 brute_manage_fork_attack(struct brute_stats *stats, u64 now)
> @@ -590,8 +710,10 @@ static u64 brute_manage_fork_attack(struct brute_stats *stats, u64 now)
>  	u64 last_fork_crash;
>
>  	last_fork_crash = brute_update_crash_period(stats, now);
> -	if (brute_attack_running(stats))
> +	if (brute_attack_running(stats)) {
>  		print_fork_attack_running();
> +		brute_kill_offending_tasks(BRUTE_ATTACK_TYPE_FORK, stats);
> +	}
>
>  	return last_fork_crash;
>  }
> @@ -778,8 +900,10 @@ static void brute_manage_exec_attack(struct brute_stats *stats, u64 now,
>  	if (fork_period == exec_period)
>  		return;
>
> -	if (brute_attack_running(exec_stats))
> +	if (brute_attack_running(exec_stats)) {
>  		print_exec_attack_running(exec_stats);
> +		brute_kill_offending_tasks(BRUTE_ATTACK_TYPE_EXEC, exec_stats);
> +	}
>  }
>
>  /**
> @@ -895,10 +1019,9 @@ static void brute_task_fatal_signal(const kernel_siginfo_t *siginfo)
>  	read_lock(&tasklist_lock);
>  	read_lock_irqsave(&brute_stats_ptr_lock, flags);
>
> -	if (WARN(!*stats, "No statistical data\n"))
> -		goto unlock;
> -
> -	if (!brute_threat_model_supported(siginfo, *stats))
> +	if (WARN(!*stats, "No statistical data\n") ||
> +	    brute_disabled(*stats) ||
> +	    !brute_threat_model_supported(siginfo, *stats))
>  		goto unlock;
>
>  	last_fork_crash = brute_manage_fork_attack(*stats, now);
> --
> 2.25.1
>

