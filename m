Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1699A4C1C9B
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Feb 2022 20:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244530AbiBWTv0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Feb 2022 14:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236121AbiBWTv0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Feb 2022 14:51:26 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594D84BFDD
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 11:50:56 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b9so121447lfv.7
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 11:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=torvalds.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G7dJVDzzZAJjRauYjEJNaQl9t1I3SGJZFs1Isig0Hes=;
        b=GeBgaLL4eq9eWZjU0wevcBQGzUWXyZs/IOZ1JKX2Wlcns4sVMXgiLeyrLGgpiHwUKn
         RDUY8upu6aguSTlEQlDihMx04s66J0M2mWT+uKPfTUYJAfXZR8o5/5LJMY/bli20Fwlu
         aAozLHgIjRf7xB+BegArTfWC8qikwYo0dRBCsYlL1c1vHl/xaM61qUDWQb475nWLcdwf
         S6xIlLnLaqo8ThSnWPn81hyfA15ApEI9x0tXHomSEcBdFUeFdH4+nAubcZ4s7b3V4ozz
         4Mx+KwdM6vOp8WGoY3uplkxjoqiQpSo0+YSpgFOmK4uGOZreE8Titb0Bpmjy+0a4tSWq
         Za5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G7dJVDzzZAJjRauYjEJNaQl9t1I3SGJZFs1Isig0Hes=;
        b=sAxTgZnMsN3Oo74X2R8TEKllL5IdpKiKVO2WCXIQR4fIY1LgntI/2OFopdeTVioyta
         NYNdtqiX8+r3ib35+h2ol3NssldNi4niPxuRMSJLbIslJop4Uv9nfu21Osn8Z7tSo7nh
         DIK0BjJMjA/GyhljHBL5kRXzjQo6IYL2pRyatAjjvtn2JQjJx8o1X19E+u/kMcT2xjIg
         Stl9Is93cJ3Oc+wngWtv2mROy3vyUGVOIsdue7FmGcPd1Yc4MEcA0nKoTgTHtoRVhYLc
         pogBpodO9ICjAFI9K1lCtvmNXsnHyBPKEJ4/rDQ00nH1wnwS4lsOtFYRSBPQ5iYq+LQI
         F70Q==
X-Gm-Message-State: AOAM531tHX6kg6/t0HNKptRul9l7zAZ7kNJ1mcvgMiuAGNIcJgXE1ASf
        Uvze9kHKW+G4Ih8WPXMi0VhokcysnUg+vrzjDvz8YxePl+M=
X-Google-Smtp-Source: ABdhPJwfZqoTBuGz/LwZcWwTEfoQpwuBP2g/Wv44V2lw6nQa360AbwkzVRPbueqnWp95KpEfAiBlP8pw/J4hKZXyNs0=
X-Received: by 2002:ac2:4211:0:b0:438:2f1:83c4 with SMTP id
 y17-20020ac24211000000b0043802f183c4mr808431lfh.435.1645645854680; Wed, 23
 Feb 2022 11:50:54 -0800 (PST)
MIME-Version: 1.0
References: <20220207121800.5079-1-mkoutny@suse.com> <e9589141-cfeb-90cd-2d0e-83a62787239a@edechamps.fr>
 <20220215101150.GD21589@blackbody.suse.cz> <87zgmi5rhm.fsf@email.froward.int.ebiederm.org>
 <87fso91n0v.fsf_-_@email.froward.int.ebiederm.org>
In-Reply-To: <87fso91n0v.fsf_-_@email.froward.int.ebiederm.org>
From:   Linus Torvalds <linus@torvalds.org>
Date:   Wed, 23 Feb 2022 11:50:38 -0800
Message-ID: <CAHk-=wjX3VK8QRMDUWwigCTKdHJt0ESXh0Hy5HNaXf7YkEdCAA@mail.gmail.com>
Subject: Re: How should rlimits, suid exec, and capabilities interact?
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux API <linux-api@vger.kernel.org>,
        Etienne Dechamps <etienne@edechamps.fr>,
        Alexey Gladkov <legion@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Security Officers <security@kernel.org>,
        Neil Brown <neilb@cse.unsw.edu.au>, NeilBrown <neilb@suse.de>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 23, 2022 at 10:00 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Which brings us to the practical issues of how all of these things are
> wired together today.

I honestly think you should treat the limits as "approximate".

We do that for a number of reasons:

 - sometimes we have racy tests because we don't want to do excessive
locking just for a limit: nobody cares if you can go a couple of
entries past a limit because you were lucky, it's important that you
can't go *much* past the limit.

 - sometimes the limits themselves are fuzzy (example: time. it's
incremented by "ticks", but it's simply not that precise, and it
depends a bit when the ticks happen)

 - sometimes it's ambiguous who we're talking about.

I think suid execs tend to fall in that third category. Be generous.
If the limit doesn't trigger at the suid exec, nobody cares. You want
to make sure it triggers eventually.

For example, let's say that you are the admin, and you made a mistake,
and you had a runaway fork() bomb that was caught by the limits.

Optimally, you still want to be able to be able to log in (one process
that was root when it did the fork(), and did a 'setresuid()' or
similar to drop the things, and then one process that does 'sudo' to
get privileges to kill the darn fork bomb).

See how that 'user' technically went over the limit, and that was A-OK!

Basic rule: it's better to be too lenient than to be too strict.

                  Linus
