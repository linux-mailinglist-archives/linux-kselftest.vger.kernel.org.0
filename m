Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DA4707693
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 May 2023 01:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjEQXtW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 19:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjEQXtV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 19:49:21 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E163949DC
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 16:49:18 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-4d9b2045e1cso1701a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 16:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684367357; x=1686959357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEhi/F7IF7fOHVORB9HV9ejZFUaKkU7/Sl0HWjAsuNA=;
        b=iMl6xWrYH04mrV0CwDQLr2HB1DnGbBIP3kGTJhzYuIXJK+qigdo+veLe/w/Bx16rKM
         v4NN+MNO0tclMIFjUybEjY/qAJhzPVKNMzrrdhBY2dDucRH4CsibiP/fjoawx7cPMTkp
         pHun/ufQ5l0yKC/jZLt74ipxGm1is3NuTaNppXnUGCVxrD1uHTefMNeQ4ykJJ7x0ayD1
         8oXRBOs4PzUNqmCT0VXMSFYofRPLZeBRxm8gCDFzlql2qv0TKcSefwS3JJ/qdhx/dhoA
         8vlaUWAZo80i0ThsOttdquge6fWzWTtX7FBxk6SKP7mWpJF51FdkwmcsQRflvPFXYcaj
         imXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684367357; x=1686959357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEhi/F7IF7fOHVORB9HV9ejZFUaKkU7/Sl0HWjAsuNA=;
        b=Sq7zQwEViS1rsRrdl6Tfp1eCfmD+8wE4Y+zx5gUWc5egEGM2Xo8q+wJ8OtoxwjTP5J
         00R6PKX9netcxgAYokD2x8ohFil7XK43Fvg7er/8svSQo+Sps82vjkLDcyNdl0OoORge
         f/VpOkRxw8i9rGwZpu/ksRC3xbi4yAfBRZStjhAp0VIRXd3Qe9K8y2RxS+vbStGEE03s
         lfzmzHGtbZswu1ZO7RkhRJVvqLPdLklEOIlNaNMuuw5jv23XKFdg6iy+ZLnlSiDHcbbV
         1UUnYEpgC6OWrtR8R1A2MKWOcXXvacbanu7HUAyer9fnuMO8AlC9PR+YSH7sTb0IfINs
         XzvA==
X-Gm-Message-State: AC+VfDwEX7zKtWPaLjaIa/bGfdSPOiYZPxZALk9ukO0gtL4omWXvVNgC
        htLBf/ZqGU+xwrYRzlLZzaGjRKn+h+gXwrlaKDIqmA==
X-Google-Smtp-Source: ACHHUZ4XbKxbQOQLQG53OqE9dfOPzVmawUyUW2Ny+fMNBdc2uIPn3QUzAb17hrfujb59vMW5hnL59Bdx1QkYCl9hX6U=
X-Received: by 2002:a50:ccd6:0:b0:505:863:d85f with SMTP id
 b22-20020a50ccd6000000b005050863d85fmr46998edj.4.1684367357123; Wed, 17 May
 2023 16:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230515130553.2311248-1-jeffxu@chromium.org> <2bcffc9f-9244-0362-2da9-ece230055320@intel.com>
 <CAEAAPHYdRyZEMp97919errF7SDuYBJoSrD5i1wrTx1sMdr_ZdQ@mail.gmail.com>
 <fbe53dcf-6e21-e4cf-c632-4da8369d7e83@intel.com> <CAEAAPHa=zYyjV5RqvPryRsW7VqY9cJC_-CJW6HKczY0iVsy-bg@mail.gmail.com>
 <d8f2d5c2-6650-c2a6-3a20-25583eee579b@intel.com> <CALmYWFsnGjniVseJKuhKO6eet10Onyk_C0=KNe6ZzXoCiBKZOw@mail.gmail.com>
 <b69f6809-b483-158f-8be9-4976fad918d8@intel.com>
In-Reply-To: <b69f6809-b483-158f-8be9-4976fad918d8@intel.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Wed, 17 May 2023 16:48:00 -0700
Message-ID: <CALmYWFs5Vgosz2JUYWkoc4YwDbiB0tT32MFpo-y6aX4kwuoz8Q@mail.gmail.com>
Subject: Re: [PATCH 0/6] Memory Mapping (VMA) protection using PKU - set 1
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>,
        jeffxu@chromium.org, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, May 17, 2023 at 8:29=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 5/17/23 08:21, Jeff Xu wrote:
> >>> I=E2=80=99m not sure I follow the details, can you give an example of=
 an asynchronous
> >>> mechanism to do this? E.g. would this be the kernel writing to the me=
mory in a
> >>> syscall for example?
> >> I was thinking of all of the IORING_OP_*'s that can write to memory or
> >> aio(7).
> > IORING is challenging from security perspectives, for now, it is
> > disabled in ChromeOS. Though I'm not sure how aio is related ?
>
> Let's say you're the attacking thread and you're the *only* attacking
> thread.  You have three things at your disposal:
>
>  1. A benign thread doing aio_read()
>  2. An arbitrary write primitive
>  3. You can send signals to yourself
>  4. You can calculate where your signal stack will be
>
> You calculate the address of PKRU on the future signal stack.  You then
> leverage the otherwise benign aio_write() to write a 0 to that PKRU
> location.  Then, send a signal to yourself.  The attacker's PKRU value
> will be written to the stack.  If you can time it right, the AIO will
> complete while the signal handler is in progress and PKRU is on the
> stack.  On sigreturn, the kernel restores the aio_read()-placed,
> attacker-provided PKRU value.  Now the attacker has PKRU=3D=3D0.  It
> effectively build a WRPKRU primitive out of those other pieces.
>
>
Ah, I understand the question now, thanks for the explanation.
Signalling handling is the next project that I will be working on.

I'm leaning towards saving PKRU register to the thread struct, similar
to how context switch works. This will address the attack scenario you
described.
However, there are a few challenges I have not yet worked through.
First, the code needs to track when the first signaling entry occurs
(saving the PKRU register to the thread struct) and when it is last
returned (restoring the PKRU register from the thread struct). One way
to do this would be to add another member to the thread struct to
track the level of signaling re-entry. Second, signal is used in
error handling, including the kernel's own signaling handling code
path. I haven't worked through this part of code logic completely.

If the first approach is too complicated or considered intrusive,  I
could take a different approach. In this approach, I would not track
signaling re-entry. Instead, I would modify the PKRU saved in AltStack
during handling of the signal, the steps are:
a> save PKRU to tmp variable.
b> modify PKRU to allow writing to the PKEY protected AltStack
c> XSAVE.
d> write tmp to the memory address of PKRU in  AltStack at the
correct offset.
Since the thread's PKRU is saved to stack, XRSTOR will restore the
thread's original PKRU during sigreturn in normal situations. This
approach might be a little hacky because it overwrites XSAVE results.
If we go with this route, I need someone's help on the overwriting
function, it is CPU specific.
However this approach will not work if an attacker can install its own
signaling handling (therefore gains the ability to overwrite PKRU stored
in stack, as you described), the application will want to install all the
signaling handling with PKEY protected AltStack at startup time, and
disallow additional signaling handling after that, this is programmatically
achievable in V8, as Stephan mentioned.

I would appreciate getting more comments in the signaling handling
area on those two approaches, or are there  better ways to do what we
want? Do you think we could continue signaling handling discussion
from the original thread that Kees started [1] ? There were already
lots of discussions there about signalling handling,  so it will be
easier for future readers to understand the context. I can repost
there. Or I can start a new thread for signaling handling, I'm
worried that those discussions will get lengthy and context get lost
with patch version update.

Although the signaling handling project is related,  I think VMA
protection using the PKRU project can stand on its own. We could solve
this for V8 first then move next to Signaling handling, the work here
could also pave the way to add mseal() in future, I expect lots of
code logic will be similar.

[1] https://lore.kernel.org/all/202208221331.71C50A6F@keescook/

Thanks!
Best regards,
-Jeff Xu








On Wed, May 17, 2023 at 8:29=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 5/17/23 08:21, Jeff Xu wrote:
> >>> I=E2=80=99m not sure I follow the details, can you give an example of=
 an asynchronous
> >>> mechanism to do this? E.g. would this be the kernel writing to the me=
mory in a
> >>> syscall for example?
> >> I was thinking of all of the IORING_OP_*'s that can write to memory or
> >> aio(7).
> > IORING is challenging from security perspectives, for now, it is
> > disabled in ChromeOS. Though I'm not sure how aio is related ?
>
> Let's say you're the attacking thread and you're the *only* attacking
> thread.  You have three things at your disposal:
>
>  1. A benign thread doing aio_read()
>  2. An arbitrary write primitive
>  3. You can send signals to yourself
>  4. You can calculate where your signal stack will be
>
> You calculate the address of PKRU on the future signal stack.  You then
> leverage the otherwise benign aio_write() to write a 0 to that PKRU
> location.  Then, send a signal to yourself.  The attacker's PKRU value
> will be written to the stack.  If you can time it right, the AIO will
> complete while the signal handler is in progress and PKRU is on the
> stack.  On sigreturn, the kernel restores the aio_read()-placed,
> attacker-provided PKRU value.  Now the attacker has PKRU=3D=3D0.  It
> effectively build a WRPKRU primitive out of those other pieces.
>
>
