Return-Path: <linux-kselftest+bounces-43310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4313BE2136
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 10:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E4084220AC
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 08:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC982FBDF8;
	Thu, 16 Oct 2025 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ty129H83"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CB52641D8;
	Thu, 16 Oct 2025 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760601738; cv=none; b=O7jm9Fq/6DGvwvGwhihNUG6BP7eslBwZbHk5hM558HqjPtTsoTfmTb422eA9g6qRvNAEZRxHY2DuGQGtYILw0FZMWmUyt9jZ+pr0sQB4Px+By2uZKB9gVavOqsg57T6cMLNoWR67z7tH179gJlatHklQmjgGulmfgmUqJU8mNOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760601738; c=relaxed/simple;
	bh=T/QAZeUOl1WroCJzhqOuuzeJ0heu4oxs6E+NuNYSyJ4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IyOHDrtAByExjNezsOkmnKIuxdyGc2YcEv7wpWsOMXG9EXkZEb4Vm8G4PZryfhOLZo/S3e1t12+lGHNBHR1W3r1Zkw5d7gt31kIcTKpAYMFKpS2R16o3F+mekCeHSJh1jI65s0L1ND7xS+hQPjdE+qkPTeKEnATWr/eaago/tKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ty129H83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2A4C4CEF1;
	Thu, 16 Oct 2025 08:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760601738;
	bh=T/QAZeUOl1WroCJzhqOuuzeJ0heu4oxs6E+NuNYSyJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ty129H83xsriYCQCtEDyF8wzp/ar6C6Ib5FFd7wTqimz3iGENAWUYHmSTehnbC/wq
	 LhCNUhxKGJXjVYxCa7i6nOT4pEH8CEVCGAVqFog7+Typi8flSNFXoUy51tp74l++uj
	 6wQp/KUN7qeqLH/Q6jwnhV6hyUy34r2AIUOLlMpW856vtyVHcMVpDbso6A/gsWbBJs
	 LN+SOz1tIlXv/oL2m7BK+KtQgW/0U/xlFhC3udqi+oc+vTTq9gslKu6vFmby17qyju
	 S/iGBjXRBFrmVX/MnCnb2PLlSVjKSF4i9PdMmAx31JM6c9b1GRf735QldRy8nPQz7X
	 T5PK50pcnMZtQ==
Date: Thu, 16 Oct 2025 17:02:12 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: lirongqing <lirongqing@baidu.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Lance Yang
 <lance.yang@linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-aspeed@lists.ozlabs.org>, <wireguard@lists.zx2c4.com>,
 <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Arnd Bergmann <arnd@arndb.de>, David
 Hildenbrand <david@redhat.com>, Florian Wesphal <fw@strlen.de>, Jakub
 Kacinski <kuba@kernel.org>, "Jason A . Donenfeld" <jason@zx2c4.com>, Joel
 Granados <joel.granados@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>, Liam Howlett
 <liam.howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, Pawan Gupta
 <pawan.kumar.gupta@linux.intel.com>, Petr Mladek <pmladek@suse.com>, Phil
 Auld <pauld@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, Russell King
 <linux@armlinux.org.uk>, Shuah Khan <shuah@kernel.org>, Simon Horman
 <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Steven Rostedt
 <rostedt@goodmis.org>
Subject: Re: [PATCH][v4] hung_task: Panic when there are more than N hung
 tasks at the same time
Message-Id: <20251016170212.65e2ad95b80cdeeb6f7d7ce3@kernel.org>
In-Reply-To: <20251015063615.2632-1-lirongqing@baidu.com>
References: <20251015063615.2632-1-lirongqing@baidu.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Oct 2025 14:36:15 +0800
lirongqing <lirongqing@baidu.com> wrote:

> From: Li RongQing <lirongqing@baidu.com>
> 
> Currently, when 'hung_task_panic' is enabled, the kernel panics
> immediately upon detecting the first hung task. However, some hung
> tasks are transient and allow system recovery, while persistent hangs
> should trigger a panic when accumulating beyond a threshold.
> 
> Extend the 'hung_task_panic' sysctl to accept a threshold value
> specifying the number of hung tasks that must be detected before
> triggering a kernel panic. This provides finer control for environments
> where transient hangs may occur but persistent hangs should be fatal.
> 
> The sysctl now accepts:
> - 0: don't panic (maintains original behavior)
> - 1: panic on first hung task (maintains original behavior)
> - N > 1: panic after N hung tasks are detected in a single scan
> 
> This maintains backward compatibility while providing flexibility for
> different hang scenarios.

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Florian Wesphal <fw@strlen.de>
> Cc: Jakub Kacinski <kuba@kernel.org>
> Cc: Jason A. Donenfeld <jason@zx2c4.com>
> Cc: Joel Granados <joel.granados@kernel.org>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Lance Yang <lance.yang@linux.dev>
> Cc: Liam Howlett <liam.howlett@oracle.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
> Cc: "Paul E . McKenney" <paulmck@kernel.org>
> Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Phil Auld <pauld@redhat.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> ---
> diff with v3: comments modification, suggested by Lance, Masami, Randy and Petr
> diff with v2: do not add a new sysctl, extend hung_task_panic, suggested by Kees Cook
> 
>  Documentation/admin-guide/kernel-parameters.txt      | 20 +++++++++++++-------
>  Documentation/admin-guide/sysctl/kernel.rst          |  9 +++++----
>  arch/arm/configs/aspeed_g5_defconfig                 |  2 +-
>  kernel/configs/debug.config                          |  2 +-
>  kernel/hung_task.c                                   | 15 ++++++++++-----
>  lib/Kconfig.debug                                    |  9 +++++----
>  tools/testing/selftests/wireguard/qemu/kernel.config |  2 +-
>  7 files changed, 36 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a51ab46..492f0bc 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1992,14 +1992,20 @@
>  			the added memory block itself do not be affected.
>  
>  	hung_task_panic=
> -			[KNL] Should the hung task detector generate panics.
> -			Format: 0 | 1
> +			[KNL] Number of hung tasks to trigger kernel panic.
> +			Format: <int>
> +
> +			When set to a non-zero value, a kernel panic will be triggered if
> +			the number of detected hung tasks reaches this value.
> +
> +			0: don't panic
> +			1: panic immediately on first hung task
> +			N: panic after N hung tasks are detected in a single scan
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
>  	hvc_iucv=	[S390]	Number of z/VM IUCV hypervisor console (HVC)
>  				terminal devices. Valid values: 0..8
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index f3ee807..0065a55 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -397,13 +397,14 @@ a hung task is detected.
>  hung_task_panic
>  ===============
>  
> -Controls the kernel's behavior when a hung task is detected.
> +When set to a non-zero value, a kernel panic will be triggered if the
> +number of hung tasks found during a single scan reaches this value.
>  This file shows up if ``CONFIG_DETECT_HUNG_TASK`` is enabled.
>  
> -= =================================================
> += =======================================================
>  0 Continue operation. This is the default behavior.
> -1 Panic immediately.
> -= =================================================
> +N Panic when N hung tasks are found during a single scan.
> += =======================================================
>  
>  
>  hung_task_check_count
> diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
> index 61cee1e..c3b0d5f 100644
> --- a/arch/arm/configs/aspeed_g5_defconfig
> +++ b/arch/arm/configs/aspeed_g5_defconfig
> @@ -308,7 +308,7 @@ CONFIG_PANIC_ON_OOPS=y
>  CONFIG_PANIC_TIMEOUT=-1
>  CONFIG_SOFTLOCKUP_DETECTOR=y
>  CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
> -CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
> +CONFIG_BOOTPARAM_HUNG_TASK_PANIC=1
>  CONFIG_WQ_WATCHDOG=y
>  # CONFIG_SCHED_DEBUG is not set
>  CONFIG_FUNCTION_TRACER=y
> diff --git a/kernel/configs/debug.config b/kernel/configs/debug.config
> index e81327d..9f6ab7d 100644
> --- a/kernel/configs/debug.config
> +++ b/kernel/configs/debug.config
> @@ -83,7 +83,7 @@ CONFIG_SLUB_DEBUG_ON=y
>  #
>  # Debug Oops, Lockups and Hangs
>  #
> -# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
> +CONFIG_BOOTPARAM_HUNG_TASK_PANIC=0
>  # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
>  CONFIG_DEBUG_ATOMIC_SLEEP=y
>  CONFIG_DETECT_HUNG_TASK=y
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index b2c1f14..84b4b04 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -81,7 +81,7 @@ static unsigned int __read_mostly sysctl_hung_task_all_cpu_backtrace;
>   * hung task is detected:
>   */
>  static unsigned int __read_mostly sysctl_hung_task_panic =
> -	IS_ENABLED(CONFIG_BOOTPARAM_HUNG_TASK_PANIC);
> +	CONFIG_BOOTPARAM_HUNG_TASK_PANIC;
>  
>  static int
>  hung_task_panic(struct notifier_block *this, unsigned long event, void *ptr)
> @@ -218,8 +218,11 @@ static inline void debug_show_blocker(struct task_struct *task, unsigned long ti
>  }
>  #endif
>  
> -static void check_hung_task(struct task_struct *t, unsigned long timeout)
> +static void check_hung_task(struct task_struct *t, unsigned long timeout,
> +		unsigned long prev_detect_count)
>  {
> +	unsigned long total_hung_task;
> +
>  	if (!task_is_hung(t, timeout))
>  		return;
>  
> @@ -229,9 +232,10 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>  	 */
>  	sysctl_hung_task_detect_count++;
>  
> +	total_hung_task = sysctl_hung_task_detect_count - prev_detect_count;
>  	trace_sched_process_hang(t);
>  
> -	if (sysctl_hung_task_panic) {
> +	if (sysctl_hung_task_panic && total_hung_task >= sysctl_hung_task_panic) {
>  		console_verbose();
>  		hung_task_show_lock = true;
>  		hung_task_call_panic = true;
> @@ -300,6 +304,7 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
>  	int max_count = sysctl_hung_task_check_count;
>  	unsigned long last_break = jiffies;
>  	struct task_struct *g, *t;
> +	unsigned long prev_detect_count = sysctl_hung_task_detect_count;
>  
>  	/*
>  	 * If the system crashed already then all bets are off,
> @@ -320,7 +325,7 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
>  			last_break = jiffies;
>  		}
>  
> -		check_hung_task(t, timeout);
> +		check_hung_task(t, timeout, prev_detect_count);
>  	}
>   unlock:
>  	rcu_read_unlock();
> @@ -389,7 +394,7 @@ static const struct ctl_table hung_task_sysctls[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= SYSCTL_ZERO,
> -		.extra2		= SYSCTL_ONE,
> +		.extra2		= SYSCTL_INT_MAX,
>  	},
>  	{
>  		.procname	= "hung_task_check_count",
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 3034e294..3976c90 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1258,12 +1258,13 @@ config DEFAULT_HUNG_TASK_TIMEOUT
>  	  Keeping the default should be fine in most cases.
>  
>  config BOOTPARAM_HUNG_TASK_PANIC
> -	bool "Panic (Reboot) On Hung Tasks"
> +	int "Number of hung tasks to trigger kernel panic"
>  	depends on DETECT_HUNG_TASK
> +	default 0
>  	help
> -	  Say Y here to enable the kernel to panic on "hung tasks",
> -	  which are bugs that cause the kernel to leave a task stuck
> -	  in uninterruptible "D" state.
> +	  When set to a non-zero value, a kernel panic will be triggered
> +	  if the number of hung tasks found during a single scan reaches
> +	  this value.
>  
>  	  The panic can be used in combination with panic_timeout,
>  	  to cause the system to reboot automatically after a
> diff --git a/tools/testing/selftests/wireguard/qemu/kernel.config b/tools/testing/selftests/wireguard/qemu/kernel.config
> index 936b18b..0504c11 100644
> --- a/tools/testing/selftests/wireguard/qemu/kernel.config
> +++ b/tools/testing/selftests/wireguard/qemu/kernel.config
> @@ -81,7 +81,7 @@ CONFIG_WQ_WATCHDOG=y
>  CONFIG_DETECT_HUNG_TASK=y
>  CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
>  CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
> -CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
> +CONFIG_BOOTPARAM_HUNG_TASK_PANIC=1
>  CONFIG_PANIC_TIMEOUT=-1
>  CONFIG_STACKTRACE=y
>  CONFIG_EARLY_PRINTK=y
> -- 
> 2.9.4
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

