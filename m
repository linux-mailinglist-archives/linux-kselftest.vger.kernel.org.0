Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C614DA2E3
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Mar 2022 20:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351278AbiCOTEN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Mar 2022 15:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351243AbiCOTEH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Mar 2022 15:04:07 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DEA50E3E
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Mar 2022 12:02:49 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bi12so43622832ejb.3
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Mar 2022 12:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nYOjHF+WhaOll744zl3KXczQ6UnybRfVr7cW3I5uN/U=;
        b=eWq9aQSnpFSM7gGPtqgzIwr8bb/qKsDMvo0mIbS4s59AMIIHEMyCDMwhpLWRS+EYBR
         qN4oTEZNXWPjiFCM5wbN4L3FVB0yMfHlzKy9DLlhHVCdkUAg+H8m96o6+l6phOAtZZtL
         HqEaabMV1A231GA5THyiGjQn+CcdPV6Wcj7+UPW4PCAGWku/81HP+8C5q//5lWvhO0Pu
         3zeib+NRZoI9eWeTsoj34Li0T9JVhg3Z1kUYOR1XGxD8A2nRmcx8ve9PFlZCqJIC6N4E
         zEz1m0vSJoc3+NJsHrbvJr8ATMwQ+P3zv+QChYRQcRSYL4oNsBWZ06rrB2G0G0fVIJ1p
         NQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nYOjHF+WhaOll744zl3KXczQ6UnybRfVr7cW3I5uN/U=;
        b=cN4tiFCMako7532hUX5zlbXWveM8edxEYI8GXo1/74DTiVm+Xm5BA/AgNOKIlDF4bw
         trehgZTWFsvj+87TTJMIHoeQ5Ee5eBJxHa3I7EWR9ubTRV6Dv6SHoexcxoykvAhaHfyu
         jy7OfYTK8g8KPCk+81edvSDbm7m44cDyXFv4LbSEaeXzCEsgpzFbenYMV5stNv7TIOzx
         QmJJ0d8wzPjNxuanRbpCOJcpEvEu/p0ko9v/ulPWI9+tGMm/LJyur+HcNuHR02wklvMf
         ERWIJhtDiv2jtiJx0aADVANE2Cm/KsNYHHOP+KnpiN3woAqormeP5VcyJn39W5wXRPLA
         4Q4A==
X-Gm-Message-State: AOAM531P2TUgId+YqN7xBoNZQIIrNuYfCtDH76TnEtaKsmBGOcIaBwZh
        TgLCVG2G1CDWjftSqykDmWc2CE+6dmZWpZW1AFqPVQ==
X-Google-Smtp-Source: ABdhPJxRVh2ZUD0Nbieh2mZpcZVRDFfmA10fIZydckRgsnzTb2ustxoM9NqZuPCgmtI1mueDRq1Ne12Wp4MutQ+KdLw=
X-Received: by 2002:a17:907:7f2a:b0:6d6:df12:7f57 with SMTP id
 qf42-20020a1709077f2a00b006d6df127f57mr23761361ejc.122.1647370967391; Tue, 15
 Mar 2022 12:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220309165222.2843651-1-tjmercier@google.com>
 <20220309165222.2843651-8-tjmercier@google.com> <CAHRSSEy5_h9LJB4q5_OJA7fSq=ROo68UaK+hdPz-Vj-wac1Qhg@mail.gmail.com>
 <CABdmKX1G0Rwmz7=BP1ER+TmtrnkGiE0nROsPTHKxnj=6bHhY3Q@mail.gmail.com> <a365a5f6c7864a879b133b99d1f43fb2@AcuMS.aculab.com>
In-Reply-To: <a365a5f6c7864a879b133b99d1f43fb2@AcuMS.aculab.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Tue, 15 Mar 2022 12:02:35 -0700
Message-ID: <CABdmKX3NEm8+pDBj2VG-r8E91CVHwQ+gGcKhG8D=5MgWcgincg@mail.gmail.com>
Subject: Re: [RFC v3 7/8] binder: use __kernel_pid_t and __kernel_uid_t for userspace
To:     David Laight <David.Laight@aculab.com>
Cc:     Todd Kjos <tkjos@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        "Kenny.Ho@amd.com" <Kenny.Ho@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
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

On Tue, Mar 15, 2022 at 12:56 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: T.J. Mercier
> > Sent: 14 March 2022 23:45
> >
> > On Thu, Mar 10, 2022 at 11:33 AM Todd Kjos <tkjos@google.com> wrote:
> > >
> > > On Wed, Mar 9, 2022 at 8:52 AM T.J. Mercier <tjmercier@google.com> wrote:
> > > >
> > > > The kernel interface should use types that the kernel defines instead of
> > > > pid_t and uid_t, whose definiton is owned by libc. This fixes the header
> > > > so that it can be included without first including sys/types.h.
> > > >
> > > > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > > > ---
> > > >  include/uapi/linux/android/binder.h | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
> > > > index 169fd5069a1a..aa28454dbca3 100644
> > > > --- a/include/uapi/linux/android/binder.h
> > > > +++ b/include/uapi/linux/android/binder.h
> > > > @@ -289,8 +289,8 @@ struct binder_transaction_data {
> > > >
> > > >         /* General information about the transaction. */
> > > >         __u32           flags;
> > > > -       pid_t           sender_pid;
> > > > -       uid_t           sender_euid;
> > > > +       __kernel_pid_t  sender_pid;
> > > > +       __kernel_uid_t  sender_euid;
> > >
> > > Are we guaranteed that this does not affect the UAPI at all? Userspace
> > > code using this definition will have to run with kernels using the old
> > > definition and visa-versa.
> >
> > A standards compliant userspace should be expecting a signed integer
> > type here. So the only way I can think userspace would be affected is
> > if:
> > 1) pid_t is a long AND
> > 2) sizeof(long) > sizeof(int) AND
> > 3) Consumers of the pid_t definition actually attempt to mutate the
> > result to make use of extra bits in the variable (which are not there)
>
> Or the userspace headers have a 16bit pid_t.

Since the kernel uses an int for PIDs, wouldn't a 16 bit pid_t already
be potentially broken (overflow) on systems where int is not 16 bits?
On systems where int is 16 bits, there is no change here except to
achieve uniform use of __kernel_pid_t in the kernel headers and fix
the include problem.

>
> I can't help feeling that uapi headers should only use explicit
> fixed sized types.
> There is no point indirecting the type names - the sizes still
> can't be changes.

I think it's still unlikely to be an actual problem. For example there
are other occasions where a switch like this was made:
https://github.com/torvalds/linux/commit/694a58e29ef27c4c26f103a9decfd053f94dd34c
https://github.com/torvalds/linux/commit/269b8fd5d058f2c0da01a42b20315ffc2640d99b

And also since Binder's only known user is Android through Bionic
which already expects the type of pid_t to be __kernel_pid_t.


>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
