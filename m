Return-Path: <linux-kselftest+bounces-43072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7541BD768F
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 07:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B8773A96F0
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 05:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3561D2874E1;
	Tue, 14 Oct 2025 05:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p8leib+/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D2F279335
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 05:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760419464; cv=none; b=SiJ3QK3GYd1q2LCOPhnl15/7KaqJI+vS3a2w7BW42YwEPdWMsSFrxHKO1/C3SYKky39Eb906+0U7//ma6sbZ3zf1Sh6BWkoygq7RN3bBB6ohxFkpR/d0NUDQRZqxDgtJ7g8labr5mUD+91BFOnQ3R79B+f8AuhvotTOXcbHyz1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760419464; c=relaxed/simple;
	bh=BGq6gtuVw1ZkzpsV6xc9p1v0Lm/eZZH90GULnLK4vPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=fVRGWQ1aVQJSs4cQlvZQwNC8rm3UIB4kLoP1JPDDJYnfF7P/mCeFgqBbZ4w+rMIXpHD/H++k+A1Jq7dgV1ORwlLkw8yT+gnyl31LkSaqAeb4XHbsYfsU5IvfhUeX6slWn+Zj3YDfF10LXPBD+lTcUrINE4kWKYiTehGiSgnKACg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p8leib+/; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <588c1935-835f-4cab-9679-f31c1e903a9a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760419449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rpX3fKP+qE+Cx5wSUCGxJKl073ySrCz333lfcH4KD3U=;
	b=p8leib+/+Uzn8bRajg1xnIwVcJSrt3m0lLnVFEIkwQAkMvKJQmbU9EGJUvpUGsXfHbBKMz
	ViA1mGiVwlTmDegFHZtPQpjF1hQMZ/LGvEipWPUwAW24TAK7NbpWInZInaEKhsMcGnXez2
	/yS+HTRDNOUcLHOMcRQGei7svVjH4HY=
Date: Tue, 14 Oct 2025 13:23:58 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH][v3] hung_task: Panic after fixed number of hung tasks
Content-Language: en-US
To: lirongqing <lirongqing@baidu.com>
References: <20251012115035.2169-1-lirongqing@baidu.com>
Cc: wireguard@lists.zx2c4.com, linux-arm-kernel@lists.infradead.org,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, linux-doc@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Randy Dunlap <rdunlap@infradead.org>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-aspeed@lists.ozlabs.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Russell King <linux@armlinux.org.uk>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Shuah Khan <shuah@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
 Petr Mladek <pmladek@suse.com>, Joel Granados <joel.granados@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Phil Auld <pauld@redhat.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Simon Horman <horms@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
 Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Feng Tang <feng.tang@linux.alibaba.com>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20251012115035.2169-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Thanks for the patch!

I noticed the implementation panics only when N tasks are detected
within a single scan, because total_hung_task is reset for each
check_hung_uninterruptible_tasks() run.

So some suggestions to align the documentation with the code's
behavior below :)

On 2025/10/12 19:50, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> Currently, when 'hung_task_panic' is enabled, the kernel panics
> immediately upon detecting the first hung task. However, some hung
> tasks are transient and the system can recover, while others are
> persistent and may accumulate progressively.
> 
> This patch extends the 'hung_task_panic' sysctl to allow specifying
> the number of hung tasks that must be detected before triggering
> a kernel panic. This provides finer control for environments where
> transient hangs may occur but persistent hangs should still be fatal.
> 
> The sysctl can be set to:
> - 0: disabled (never panic)
> - 1: original behavior (panic on first hung task)
> - N: panic when N hung tasks are detected
> 
> This maintains backward compatibility while providing more flexibility
> for handling different hang scenarios.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
> Diff with v2: not add new sysctl, extend hung_task_panic
> 
>   Documentation/admin-guide/kernel-parameters.txt      | 20 +++++++++++++-------
>   Documentation/admin-guide/sysctl/kernel.rst          |  3 ++-
>   arch/arm/configs/aspeed_g5_defconfig                 |  2 +-
>   kernel/configs/debug.config                          |  2 +-
>   kernel/hung_task.c                                   | 16 +++++++++++-----
>   lib/Kconfig.debug                                    | 10 ++++++----
>   tools/testing/selftests/wireguard/qemu/kernel.config |  2 +-
>   7 files changed, 35 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a51ab46..7d9a8ee 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1992,14 +1992,20 @@
>   			the added memory block itself do not be affected.
>   
>   	hung_task_panic=
> -			[KNL] Should the hung task detector generate panics.
> -			Format: 0 | 1
> +			[KNL] Number of hung tasks to trigger kernel panic.
> +			Format: <int>
> +
> +			Set this to the number of hung tasks that must be
> +			detected before triggering a kernel panic.
> +
> +			0: don't panic
> +			1: panic immediately on first hung task
> +			N: panic after N hung tasks are detect

The description should be more specific :)

N: panic after N hung tasks are detected in a single scan

Would it be better and cleaner?

>   
> -			A value of 1 instructs the kernel to panic when a
> -			hung task is detected. The default value is controlled
> -			by the CONFIG_BOOTPARAM_HUNG_TASK_PANIC build-time
> -			option. The value selected by this boot parameter can
> -			be changed later by the kernel.hung_task_panic sysctl.
> +			The default value is controlled by the
> +			CONFIG_BOOTPARAM_HUNG_TASK_PANIC build-time option. The value
> +			selected by this boot parameter can be changed later by the
> +			kernel.hung_task_panic sysctl.
>   
>   	hvc_iucv=	[S390]	Number of z/VM IUCV hypervisor console (HVC)
>   				terminal devices. Valid values: 0..8
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index f3ee807..0a8dfab 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -397,7 +397,8 @@ a hung task is detected.
>   hung_task_panic
>   ===============
>   
> -Controls the kernel's behavior when a hung task is detected.
> +When set to a non-zero value, a kernel panic will be triggered if the
> +number of detected hung tasks reaches this value

Hmm... that is also ambiguous ...

+When set to a non-zero value, a kernel panic will be triggered if the
+number of hung tasks found during a single scan reaches this value.

>   This file shows up if ``CONFIG_DETECT_HUNG_TASK`` is enabled.
>   
>   = =================================================
> diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
> index 61cee1e..c3b0d5f 100644
> --- a/arch/arm/configs/aspeed_g5_defconfig
> +++ b/arch/arm/configs/aspeed_g5_defconfig
> @@ -308,7 +308,7 @@ CONFIG_PANIC_ON_OOPS=y
>   CONFIG_PANIC_TIMEOUT=-1
>   CONFIG_SOFTLOCKUP_DETECTOR=y
>   CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
> -CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
> +CONFIG_BOOTPARAM_HUNG_TASK_PANIC=1
>   CONFIG_WQ_WATCHDOG=y
>   # CONFIG_SCHED_DEBUG is not set
>   CONFIG_FUNCTION_TRACER=y
> diff --git a/kernel/configs/debug.config b/kernel/configs/debug.config
> index e81327d..9f6ab7d 100644
> --- a/kernel/configs/debug.config
> +++ b/kernel/configs/debug.config
> @@ -83,7 +83,7 @@ CONFIG_SLUB_DEBUG_ON=y
>   #
>   # Debug Oops, Lockups and Hangs
>   #
> -# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
> +CONFIG_BOOTPARAM_HUNG_TASK_PANIC=0
>   # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
>   CONFIG_DEBUG_ATOMIC_SLEEP=y
>   CONFIG_DETECT_HUNG_TASK=y
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index b2c1f14..3929ed9 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -81,7 +81,7 @@ static unsigned int __read_mostly sysctl_hung_task_all_cpu_backtrace;
>    * hung task is detected:
>    */
>   static unsigned int __read_mostly sysctl_hung_task_panic =
> -	IS_ENABLED(CONFIG_BOOTPARAM_HUNG_TASK_PANIC);
> +	CONFIG_BOOTPARAM_HUNG_TASK_PANIC;
>   
>   static int
>   hung_task_panic(struct notifier_block *this, unsigned long event, void *ptr)
> @@ -218,8 +218,11 @@ static inline void debug_show_blocker(struct task_struct *task, unsigned long ti
>   }
>   #endif
>   
> -static void check_hung_task(struct task_struct *t, unsigned long timeout)
> +static void check_hung_task(struct task_struct *t, unsigned long timeout,
> +		unsigned long prev_detect_count)
>   {
> +	unsigned long total_hung_task;
> +
>   	if (!task_is_hung(t, timeout))
>   		return;
>   
> @@ -229,9 +232,11 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>   	 */
>   	sysctl_hung_task_detect_count++;
>   
> +	total_hung_task = sysctl_hung_task_detect_count - prev_detect_count;
>   	trace_sched_process_hang(t);
>   
> -	if (sysctl_hung_task_panic) {
> +	if (sysctl_hung_task_panic &&
> +			(total_hung_task >= sysctl_hung_task_panic)) {
>   		console_verbose();
>   		hung_task_show_lock = true;
>   		hung_task_call_panic = true;
> @@ -300,6 +305,7 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
>   	int max_count = sysctl_hung_task_check_count;
>   	unsigned long last_break = jiffies;
>   	struct task_struct *g, *t;
> +	unsigned long prev_detect_count = sysctl_hung_task_detect_count;
>   
>   	/*
>   	 * If the system crashed already then all bets are off,
> @@ -320,7 +326,7 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
>   			last_break = jiffies;
>   		}
>   
> -		check_hung_task(t, timeout);
> +		check_hung_task(t, timeout, prev_detect_count);
>   	}
>    unlock:
>   	rcu_read_unlock();
> @@ -389,7 +395,7 @@ static const struct ctl_table hung_task_sysctls[] = {
>   		.mode		= 0644,
>   		.proc_handler	= proc_dointvec_minmax,
>   		.extra1		= SYSCTL_ZERO,
> -		.extra2		= SYSCTL_ONE,
> +		.extra2		= SYSCTL_INT_MAX,
>   	},
>   	{
>   		.procname	= "hung_task_check_count",
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 3034e294..077b9e4 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1258,12 +1258,14 @@ config DEFAULT_HUNG_TASK_TIMEOUT
>   	  Keeping the default should be fine in most cases.
>   
>   config BOOTPARAM_HUNG_TASK_PANIC
> -	bool "Panic (Reboot) On Hung Tasks"
> +	int "Number of hung tasks to trigger kernel panic"
>   	depends on DETECT_HUNG_TASK
> +	default 0
>   	help
> -	  Say Y here to enable the kernel to panic on "hung tasks",
> -	  which are bugs that cause the kernel to leave a task stuck
> -	  in uninterruptible "D" state.
> +	  The number of hung tasks must be detected to trigger kernel panic.
> +
> +	  - 0: Don't trigger panic
> +	  - N: Panic when N hung tasks are detected

+	  - N: Panic when N hung tasks are detected in a single scan

With these documentation changes, this patch would accurately describe 
its behavior, IMHO.

>   
>   	  The panic can be used in combination with panic_timeout,
>   	  to cause the system to reboot automatically after a
> diff --git a/tools/testing/selftests/wireguard/qemu/kernel.config b/tools/testing/selftests/wireguard/qemu/kernel.config
> index 936b18b..0504c11 100644
> --- a/tools/testing/selftests/wireguard/qemu/kernel.config
> +++ b/tools/testing/selftests/wireguard/qemu/kernel.config
> @@ -81,7 +81,7 @@ CONFIG_WQ_WATCHDOG=y
>   CONFIG_DETECT_HUNG_TASK=y
>   CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
>   CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
> -CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
> +CONFIG_BOOTPARAM_HUNG_TASK_PANIC=1
>   CONFIG_PANIC_TIMEOUT=-1
>   CONFIG_STACKTRACE=y
>   CONFIG_EARLY_PRINTK=y


