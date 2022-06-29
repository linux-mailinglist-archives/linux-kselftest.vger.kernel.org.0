Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065ED560DBA
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jun 2022 01:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiF2XwV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Jun 2022 19:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiF2XwS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Jun 2022 19:52:18 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B98124090
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jun 2022 16:52:16 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3176b6ed923so163507597b3.11
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jun 2022 16:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jj2bErexLgV1A9YIdvzx3PGjusAMI02AE7tzIDJ1M5A=;
        b=Y2Tu2OdDzMgyWgz7uI6wnDGVdXiBPwT0tk13f7mVdOKDysVRR/kbruRKXKz2I5+Mni
         GQx6RMKlgx3jTU8tqKusqnJzX0RL/HtsP7Km6NeANpCcKuitYurgmkGIZxyd81D0b7c4
         M6hgkp/CS/Lan4c8MCYn+6RBduyK3MXC1Q5hpln09l+yFeWTrPqOilPtanfcysyDmduD
         1QqYZFTcDH7Rj6fKdLgMxiOspYiBUK9DkBCSjd2QsNvE7OGJUY1fr6YAUMEzUMi16PcV
         Pr19C5xIMVz6otGKDdAXazhClNibtSR2AR9TjfOL7WIpf1a3vQmUpvWxoW405WHuZuXJ
         zzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jj2bErexLgV1A9YIdvzx3PGjusAMI02AE7tzIDJ1M5A=;
        b=lf76+f1CRGOMoKZKY4zhU/T8WNSqGD1ij75R4i4Bw1uM1ly4f+vtPQPWzHnOcQPwhC
         mtNwctTrXias9sh/i6vKLjSSdXqHLjUargXgsJzBoty+G/RXFiWdsrhJ8PjSZjKngDbG
         zumPUtpml9LPv1Pu9kNcqg+qaff3BeLwfC9nnPEDlwjSca1qj4lBE6TV3RjrTcqS0jL5
         1LI6EyLhFlYm1yWn0OgPtjhcI7eOkfg28ZYEAqsD1lt1axzNg6zNvqRcDzQpWcJkZFvt
         cyxK7TF5LBOli2P6XRaH1Bnrvvgq22PZ4oE1IS8O5iYKotm4LHis+Qqp4g773edcFZ9l
         Qi5Q==
X-Gm-Message-State: AJIora9ITkhzTECEQshQK3yjxp5bXtpkL1Lb72epQK97j+8nKthdrNVR
        4/xz3AOPfX++wPeTEGeOpj5W93eAXR9qobgv7oaB
X-Google-Smtp-Source: AGRyM1v1n7EWs3fcbJobS/0qoUyUpaOGXwj1JxcVbNWxYIvJDEF/meItbXW0LeimAccioancoaiWdGtPrhVNyLhYnGY=
X-Received: by 2002:a81:8d08:0:b0:317:a4cd:d65d with SMTP id
 d8-20020a818d08000000b00317a4cdd65dmr6750642ywg.329.1656546735690; Wed, 29
 Jun 2022 16:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220629161020.GA24891@lst.de> <Yrx6EVHtroXeEZGp@zx2c4.com>
 <20220629161527.GA24978@lst.de> <Yrx8/Fyx15CTi2zq@zx2c4.com>
 <20220629163007.GA25279@lst.de> <Yrx/8UOY+J8Ao3Bd@zx2c4.com>
 <YryNQvWGVwCjJYmB@zx2c4.com> <Yryic4YG9X2/DJiX@google.com>
 <Yry6XvOGge2xKx/n@zx2c4.com> <CAC_TJve_Jk0+XD7VeSJVvJq4D9ZofnH69B4QZv2LPT4X3KNfeg@mail.gmail.com>
 <YrzaCRl9rwy9DgOC@zx2c4.com>
In-Reply-To: <YrzaCRl9rwy9DgOC@zx2c4.com>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 29 Jun 2022 16:52:05 -0700
Message-ID: <CANDhNCpRzzULaGmEGCbbJgVinA0pJJB-gOP9AY0Hy488n9ZStA@mail.gmail.com>
Subject: Re: [PATCH] remove CONFIG_ANDROID
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Kalesh Singh <kaleshsingh@google.com>,
        Christoph Hellwig <hch@lst.de>,
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
        Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Jason: Thanks for raising this issue and sharing this patch to avoid
breakage! I really appreciate it.

My only concern with this change introducting a userspace knob set at
runtime, vs a (hopefully more specific than _ANDROID) kernel config is
that it's not exactly clear what the flag really means (which is the
same issue CONFIG_ANDROID has). And more problematic, with this it
would be an ABI.

So for this we probably need to have a very clear description of what
userland is telling the kernel. Because I'm sure userlands behavior
will drift and shift and we'll end up litigating what kind of behavior
is really userspace_autosleeping vs userspace_sortof_autosleeping. :)

Alternatively, maybe we should switch it to describe what behavior
change we are wanting the kernel take (instead of it hinting to the
kernel what to expect from userland's behavior)? That way it might be
more specific.

Again, really appreciate your efforts here!

thanks
-john
