Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB431EB72E
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jun 2020 10:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgFBIQ6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Jun 2020 04:16:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:38818 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgFBIQ6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Jun 2020 04:16:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F24DDAC64;
        Tue,  2 Jun 2020 08:16:57 +0000 (UTC)
Date:   Tue, 2 Jun 2020 10:16:55 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Yannick Cote <ycote@redhat.com>
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        joe.lawrence@redhat.com
Subject: Re: [PATCH 1/4] selftests/livepatch: rework test-klp-callbacks to
 use completion variables
Message-ID: <20200602081654.GI27273@linux-b0ei>
References: <20200528134849.7890-1-ycote@redhat.com>
 <20200528134849.7890-2-ycote@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528134849.7890-2-ycote@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu 2020-05-28 09:48:46, Yannick Cote wrote:
> From: Joe Lawrence <joe.lawrence@redhat.com>
> 
> The test-klp-callbacks script includes a few tests which rely on kernel
> task timings that may not always execute as expected under system load.
> These will generate out of sequence kernel log messages that result in
> test failure.
> 
> Instead of using sleep timing windows to orchestrate the test, rework
> the test_klp_callbacks_busy module to use completion variables.
> 
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> Signed-off-by: Yannick Cote <ycote@redhat.com>
> ---
>  lib/livepatch/test_klp_callbacks_busy.c       | 42 +++++++++++++++----
>  .../selftests/livepatch/test-callbacks.sh     | 29 +++++++------
>  2 files changed, 47 insertions(+), 24 deletions(-)
> 
> diff --git a/lib/livepatch/test_klp_callbacks_busy.c b/lib/livepatch/test_klp_callbacks_busy.c
> index 40beddf8a0e2..c3df12f47e5e 100644
> --- a/lib/livepatch/test_klp_callbacks_busy.c
> +++ b/lib/livepatch/test_klp_callbacks_busy.c
> @@ -5,34 +5,58 @@
>  
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> +#include <linux/sched.h>
>  #include <linux/workqueue.h>
>  #include <linux/delay.h>
>  
> -static int sleep_secs;
> -module_param(sleep_secs, int, 0644);
> -MODULE_PARM_DESC(sleep_secs, "sleep_secs (default=0)");
> +/* load/run-time control from sysfs writer  */
> +static bool block_transition;
> +module_param(block_transition, bool, 0644);
> +MODULE_PARM_DESC(block_transition, "block_transition (default=false)");
>  
>  static void busymod_work_func(struct work_struct *work);
> -static DECLARE_DELAYED_WORK(work, busymod_work_func);
> +static DECLARE_WORK(work, busymod_work_func);
> +static DECLARE_COMPLETION(busymod_work_complete);
>  
>  static void busymod_work_func(struct work_struct *work)
>  {
> -	pr_info("%s, sleeping %d seconds ...\n", __func__, sleep_secs);
> -	msleep(sleep_secs * 1000);
> +	bool early_complete = block_transition;
> +
> +	pr_info("%s enter\n", __func__);
> +
> +	/*
> +	 * When blocking the livepatch transition, set completion flag
> +	 * early so subsequent test commands see the transition.
> +	 */
> +	if (early_complete)
> +		complete(&busymod_work_complete);

I have to say that the code is really confusing. A completion called
"work_complete" is completed when the work gets actually. It is
completed later when the work is done immediately.

Do we need the completion at all? See below.

> +
> +	while (block_transition)

The compiler might optimize the code and avoid the re-reads. Please, use:

	/* Re-read variable in each cycle */
	while (READ_ONCE(block_transition))


> +		msleep(1000);

Nit: This is still a busy wait even though there is a big
delay between waits. The right solution would be using wait_event().
But feel free to keep msleep(). It is good enough for selftests.

> +
>  	pr_info("%s exit\n", __func__);
> +
> +	/*
> +	 * In non-blocking case, wait until we're done to complete to
> +	 * ensure kernel log ordering
> +	 */
> +	if (!early_complete)
> +		complete(&busymod_work_complete);
>  }
>  
>  static int test_klp_callbacks_busy_init(void)
>  {
>  	pr_info("%s\n", __func__);
> -	schedule_delayed_work(&work,
> -		msecs_to_jiffies(1000 * 0));
> +	schedule_work(&work);
> +	wait_for_completion(&busymod_work_complete);

IMHO, the completion is not needed when using:

	schedule_work(&work);
	/*
	 * Print all messages from the work before returning from init().
	 * It helps to serialize messages from the loaded modules.
	 */
	if (!block_transition)
		flush_work(&work);

> +
>  	return 0;
>  }
>  
>  static void test_klp_callbacks_busy_exit(void)
>  {
> -	cancel_delayed_work_sync(&work);
> +	block_transition = false;

The compiler could move this assignment after the following
call. Please, use:

	/* Make sure that the variable is set before flushing work. */
	WRITE_ONCE(block_transition, false);


> +	cancel_work_sync(&work);

The work is not longer canceled. flush_work() better fits here.
Also I would do this only when the transition is blocked:

	if (block_transition) {
		/* Make sure that the variable is set before flushing work. */
		WRITE_ONCE(block_transition, false);
		flush_work(&work);
	}


Otherwise this is a nice improvement.

Best Regards,
Petr
