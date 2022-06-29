Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB34560D17
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jun 2022 01:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiF2XUJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Jun 2022 19:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiF2XUH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Jun 2022 19:20:07 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B111122509
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jun 2022 16:20:05 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 205-20020a1c02d6000000b003a03567d5e9so129740wmc.1
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jun 2022 16:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+sgKiiXbPvFwyYU8o7PbhLKBAM5khScy7fiUEj1PWbo=;
        b=ZS8pZ8AkCzaaVPMBMBlNMb7xmEcWyThMpKD4H9SxTn4aRlFL+W90lgmPz6YW6AqbTK
         az6lnnWR+9t97ButIT3JuiD5TuQ7VjYn19RAuDFGSrHNamK8if1SUysJ+ITjgK4tSHJi
         1GSlaNpR1IgPbvhoKBLigo1nSTHF/oMFj+7QVBiS93FHum9BPPx/cfy13jaj0mmZeBSe
         zOm9tqbWAwZ4ITlZMiIu/xcywPZWzBgma5twMf0dYBrIKBpvzJZOBsCw5XLqURKl6bVk
         JotXGD0fZz41OwPVNs1Q4qsbZYKIXdP64yXX0zAAeM5jRRvpwsRCJIO3yodRkRyxWVwV
         Ta6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+sgKiiXbPvFwyYU8o7PbhLKBAM5khScy7fiUEj1PWbo=;
        b=wt91FMz2VbOuyR8sjyml55fRu3ROgMiAWGexxzgWSvvzMLSurl6uzdHfTITuOrrg+M
         WvjeWg0ddFfgwF45SlroEWuSonFK9BZ1KKuxpQYpsZm9qgDgjeFo5nByvPxk5wMh6qy+
         TfU96jyKHiTj9LzCQb2tRnTnzyR6Wv0+Totts36CWQXnqPcMHMKiQ9zYYJdMUci1Ja/C
         vYpyzNJpleT/uLEWvT2fCW3pxkg6Z3vqcecxm9WKRQ3BXQxuIwlfaFWzhyANopQMVCIr
         U9qWPDhuzzbujYEDg1Ixbwpk6qUxxjqb8HuykjPSAR4Y24ERUWM4kv1m/poRLLi/AZOE
         zs6g==
X-Gm-Message-State: AJIora8I5Y4iXvQW1JyLFCl8WAF+HqweOWh+7dCIbxfA4A3FH1MX7e2y
        /g0sLYTXel8Azmd3BPO5M5Fs31uiCyDUTlGndQxevA==
X-Google-Smtp-Source: AGRyM1sfkNAdLMD1HYwGLNTvaIF0Dst/TgdO4rRRnXhlJE6YhvrqSGBP68be1nutxJacar9qONmUp2Galr2SkNF40y4=
X-Received: by 2002:a05:600c:4081:b0:3a0:47c4:8dd0 with SMTP id
 k1-20020a05600c408100b003a047c48dd0mr6134358wmh.178.1656544804063; Wed, 29
 Jun 2022 16:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220629161020.GA24891@lst.de> <Yrx6EVHtroXeEZGp@zx2c4.com>
 <20220629161527.GA24978@lst.de> <Yrx8/Fyx15CTi2zq@zx2c4.com>
 <20220629163007.GA25279@lst.de> <Yrx/8UOY+J8Ao3Bd@zx2c4.com>
 <YryNQvWGVwCjJYmB@zx2c4.com> <Yryic4YG9X2/DJiX@google.com>
 <Yry6XvOGge2xKx/n@zx2c4.com> <CAC_TJve_Jk0+XD7VeSJVvJq4D9ZofnH69B4QZv2LPT4X3KNfeg@mail.gmail.com>
 <YrzaCRl9rwy9DgOC@zx2c4.com>
In-Reply-To: <YrzaCRl9rwy9DgOC@zx2c4.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Wed, 29 Jun 2022 16:19:52 -0700
Message-ID: <CAC_TJvcEzp+zQp50wtj4=7b6vEObpJCQYLaTLhHJCxFdk3TgPg@mail.gmail.com>
Subject: Re: [PATCH] remove CONFIG_ANDROID
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, wireguard@lists.zx2c4.com,
        netdev@vger.kernel.org, rcu <rcu@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, sultan@kerneltoast.com,
        android-kernel-team <android-kernel-team@google.com>,
        John Stultz <jstultz@google.com>,
        Saravana Kannan <saravanak@google.com>, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 29, 2022 at 4:02 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Kalesh,
>
> On Wed, Jun 29, 2022 at 03:26:33PM -0700, Kalesh Singh wrote:
> > Thanks for taking a look. I'm concerned holding the sys/power/state
> > open would have unintentional side effects. Adding the
> > /sys/power/userspace_autosuspender seems more appropriate. We don't
> > have a use case for the refcounting, so would prefer the simpler
> > writing '0' / '1' to toggle semantics.
>
> Alright. So I've cooked you up some code that you can submit, since I
> assume based on Christoph's bristliness that he won't do so. The below
> adds /sys/power/pm_userspace_autosleeper, which you can write a 0 or a 1
> into, and fixes up wireguard and random.c to use it. The code is
> untested, but should generally be the correct thing, I think.
>
> So in order of operations:
>
> 1. You write a patch for SystemSuspend.cpp and post it on Gerrit.
>
> 2. You take the diff below, clean it up or bikeshed the naming a bit or
>    do whatever there, and submit it to Rafael's PM tree, including as a
>    `Link: ...` this thread and the Gerrit link.
>
> 3. When/if Rafael accepts the patch, you submit the Gerrit CL.
>
> 4. When both have landed, Christoph moves forward with his
>    CONFIG_ANDROID removal.
>
> Does that seem like a reasonable way forward?

Sounds like a plan. I'll clean up and repost your patch once the
Gerrit change is ready.

Thanks,
Kalesh
>
> Jason
>
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index e3dd1dd3dd22..c25e3be10d9c 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -756,7 +756,7 @@ static int random_pm_notification(struct notifier_block *nb, unsigned long actio
>
>         if (crng_ready() && (action == PM_RESTORE_PREPARE ||
>             (action == PM_POST_SUSPEND &&
> -            !IS_ENABLED(CONFIG_PM_AUTOSLEEP) && !IS_ENABLED(CONFIG_ANDROID)))) {
> +            !IS_ENABLED(CONFIG_PM_AUTOSLEEP) && !pm_userspace_autosleeper_enabled))) {
>                 crng_reseed();
>                 pr_notice("crng reseeded on system resumption\n");
>         }
> diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
> index aa9a7a5970fd..1983e0fadb6e 100644
> --- a/drivers/net/wireguard/device.c
> +++ b/drivers/net/wireguard/device.c
> @@ -69,7 +69,7 @@ static int wg_pm_notification(struct notifier_block *nb, unsigned long action, v
>          * its normal operation rather than as a somewhat rare event, then we
>          * don't actually want to clear keys.
>          */
> -       if (IS_ENABLED(CONFIG_PM_AUTOSLEEP) || IS_ENABLED(CONFIG_ANDROID))
> +       if (IS_ENABLED(CONFIG_PM_AUTOSLEEP) || pm_userspace_autosleeper_enabled)
>                 return 0;
>
>         if (action != PM_HIBERNATION_PREPARE && action != PM_SUSPEND_PREPARE)
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 70f2921e2e70..0acff26f87b4 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -498,6 +498,7 @@ extern void ksys_sync_helper(void);
>  /* drivers/base/power/wakeup.c */
>  extern bool events_check_enabled;
>  extern suspend_state_t pm_suspend_target_state;
> +extern bool pm_userspace_autosleeper_enabled;
>
>  extern bool pm_wakeup_pending(void);
>  extern void pm_system_wakeup(void);
> @@ -537,6 +538,8 @@ static inline void pm_system_irq_wakeup(unsigned int irq_number) {}
>  static inline void lock_system_sleep(void) {}
>  static inline void unlock_system_sleep(void) {}
>
> +#define pm_userspace_autosleeper_enabled (false)
> +
>  #endif /* !CONFIG_PM_SLEEP */
>
>  #ifdef CONFIG_PM_SLEEP_DEBUG
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index e3694034b753..08f32a281010 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -120,6 +120,23 @@ static ssize_t pm_async_store(struct kobject *kobj, struct kobj_attribute *attr,
>
>  power_attr(pm_async);
>
> +bool pm_userspace_autosleeper_enabled;
> +
> +static ssize_t pm_userspace_autosleeper_show(struct kobject *kobj,
> +                               struct kobj_attribute *attr, char *buf)
> +{
> +       return sprintf(buf, "%d\n", pm_userspace_autosleeper_enabled);
> +}
> +
> +static ssize_t pm_userspace_autosleeper_store(struct kobject *kobj,
> +                                   struct kobj_attribute *attr,
> +                                   const char *buf, size_t n)
> +{
> +       return kstrtobool(buf, &pm_userspace_autosleeper_enabled);
> +}
> +
> +power_attr(pm_userspace_autosleeper);
> +
>  #ifdef CONFIG_SUSPEND
>  static ssize_t mem_sleep_show(struct kobject *kobj, struct kobj_attribute *attr,
>                               char *buf)
> @@ -869,6 +886,7 @@ static struct attribute * g[] = {
>  #ifdef CONFIG_PM_SLEEP
>         &pm_async_attr.attr,
>         &wakeup_count_attr.attr,
> +       &pm_userspace_autosleeper.attr,
>  #ifdef CONFIG_SUSPEND
>         &mem_sleep_attr.attr,
>         &sync_on_suspend_attr.attr,
>
