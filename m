Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA5E4D90F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Mar 2022 01:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236260AbiCOAND (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Mar 2022 20:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244848AbiCOAMw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Mar 2022 20:12:52 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244624131B
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Mar 2022 17:11:40 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id w12so30090333lfr.9
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Mar 2022 17:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wKU4ZRqHh+/7R0KNuwH0gJELjq2wS0wK12KdzbWieg8=;
        b=pdvGf9PQdPL+jc2z0MSpu+kjnnZ0nHo4cryyXO4GFzrOWzzVTepjpBoNHTaE5+75bw
         d4VQEWt7imtT/TZ1UoujoFiquSI+9E7m+ThkkWoyWi+NQdu+QjPDRjH5KIfNJ/ZJCqHe
         wjyXN2uVrnZm+UyCFSacS1mv7NDERQ6PhQESj4QO2FkimAccprmrU6pc52zKBsITFDja
         gC5Oaweu+0IukaAZaELGkgb/0HwzwXkztXvDRCSedoxtmzVa5na/Iqy+oufxaPnjMp//
         X2NpOHkJ2Xep3wu3lyieE5LytahX0zC0ab4HUWMmTOWR6NF6gC0IihKhyOGQSkwmUu/9
         EmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wKU4ZRqHh+/7R0KNuwH0gJELjq2wS0wK12KdzbWieg8=;
        b=5ZswseaPgovlV8Wo/tS5IwCT4U5wp4GO9bYHWtfINVs3o0vBgaGwVm3bNOECj3loWX
         7YRsRlabpPQ6X1zS5SN86iePGOY33YIQKU+Ni6IMAsa9wKMVKEcqlVXxjf6ITtEd+qF9
         aaEDLLFg/mSzhWu8RbfgLz6Q5QMsbzeqNd9fOoL0ABHquicSuQ7xXNPGw4357sHrClJa
         xlaZBybKQvVUMFyXGdV8amVbP45DDfdFECCGmwec/y1x7BEpTFb23k6uHUo2sUvBsdty
         aXKY11tIuP1kstyTOyLvCoR+SQK3U41IZiaAl9mTQha9j1+eYsbtEtQqMoflMvjSPQP/
         fIjw==
X-Gm-Message-State: AOAM530sq1SkcQvK7GapLe3VxOlgPc79i+WkVMi9zUcW+7h+VTvUqFl1
        MxbwC1SSFVKLEccxPVv4+3TIWECPCFo5TLJM33/jkQ==
X-Google-Smtp-Source: ABdhPJxPtvXRGpRay/asNi1i55O48lEOmE5yWTDcG4DlXbCoDcVr3r6f/V+w4+w607DlldBSh6to9lYM41nQDiqqXho=
X-Received: by 2002:ac2:5fe3:0:b0:448:5ba2:445f with SMTP id
 s3-20020ac25fe3000000b004485ba2445fmr15394525lfg.682.1647303098171; Mon, 14
 Mar 2022 17:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220309165222.2843651-1-tjmercier@google.com>
 <20220309165222.2843651-8-tjmercier@google.com> <CAHRSSEy5_h9LJB4q5_OJA7fSq=ROo68UaK+hdPz-Vj-wac1Qhg@mail.gmail.com>
 <CABdmKX1G0Rwmz7=BP1ER+TmtrnkGiE0nROsPTHKxnj=6bHhY3Q@mail.gmail.com>
In-Reply-To: <CABdmKX1G0Rwmz7=BP1ER+TmtrnkGiE0nROsPTHKxnj=6bHhY3Q@mail.gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Mon, 14 Mar 2022 17:11:25 -0700
Message-ID: <CAHRSSEx0ggFW5JqvQKJLzOLsSK4A4gERM62aXNU6XVkJn8QK7Q@mail.gmail.com>
Subject: Re: [RFC v3 7/8] binder: use __kernel_pid_t and __kernel_uid_t for userspace
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
        Kalesh Singh <kaleshsingh@google.com>, Kenny.Ho@amd.com,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
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

On Mon, Mar 14, 2022 at 4:45 PM T.J. Mercier <tjmercier@google.com> wrote:
>
> On Thu, Mar 10, 2022 at 11:33 AM Todd Kjos <tkjos@google.com> wrote:
> >
> > On Wed, Mar 9, 2022 at 8:52 AM T.J. Mercier <tjmercier@google.com> wrot=
e:
> > >
> > > The kernel interface should use types that the kernel defines instead=
 of
> > > pid_t and uid_t, whose definiton is owned by libc. This fixes the hea=
der
> > > so that it can be included without first including sys/types.h.
> > >
> > > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > > ---
> > >  include/uapi/linux/android/binder.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux=
/android/binder.h
> > > index 169fd5069a1a..aa28454dbca3 100644
> > > --- a/include/uapi/linux/android/binder.h
> > > +++ b/include/uapi/linux/android/binder.h
> > > @@ -289,8 +289,8 @@ struct binder_transaction_data {
> > >
> > >         /* General information about the transaction. */
> > >         __u32           flags;
> > > -       pid_t           sender_pid;
> > > -       uid_t           sender_euid;
> > > +       __kernel_pid_t  sender_pid;
> > > +       __kernel_uid_t  sender_euid;
> >
> > Are we guaranteed that this does not affect the UAPI at all? Userspace
> > code using this definition will have to run with kernels using the old
> > definition and visa-versa.
>
> A standards compliant userspace should be expecting a signed integer
> type here. So the only way I can think userspace would be affected is
> if:
> 1) pid_t is a long AND
> 2) sizeof(long) > sizeof(int) AND
> 3) Consumers of the pid_t definition actually attempt to mutate the
> result to make use of extra bits in the variable (which are not there)
>
> This seems extremely unlikely. For instance just on the topic of the
> first item, all of the C library implementations with pid_t
> definitions linked here use an int, except for Bionic which typdefs
> pid_t to __kernel_pid_t and Sortix which uses long.
> https://wiki.osdev.org/C_Library
>
> However I would argue this is already broken and should count as a bug
> fix since I can't do this:
>
> $ cat binder_include.c ; gcc binder_include.c
> #include <linux/android/binder.h>
> int main() {}
> In file included from binder_include.c:1:
> /usr/include/linux/android/binder.h:291:9: error: unknown type name =E2=
=80=98pid_t=E2=80=99
>   291 |         pid_t           sender_pid;
>       |         ^~~~~
> /usr/include/linux/android/binder.h:292:9: error: unknown type name =E2=
=80=98uid_t=E2=80=99
>   292 |         uid_t           sender_euid;
>       |         ^~~~~
>
> This is also the only occurrence of pid_t in all of
> include/uapi/linux. All 40+ other uses are __kernel_pid_t, and I don't
> see why the binder header should be different.

It looks like those other cases used to be pid_t, but were changed to
__kernel_pid_t.

Acked-by: Todd Kjos <tkjos@google.com>

>
>
> >
> > >         binder_size_t   data_size;      /* number of bytes of data */
> > >         binder_size_t   offsets_size;   /* number of bytes of offsets=
 */
> > >
> > > --
> > > 2.35.1.616.g0bdcbb4464-goog
> > >
