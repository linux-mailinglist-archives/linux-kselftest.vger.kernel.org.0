Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41C94D9095
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Mar 2022 00:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236682AbiCNXqy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Mar 2022 19:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343741AbiCNXqx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Mar 2022 19:46:53 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA4C3E5EF
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Mar 2022 16:45:41 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a8so37586179ejc.8
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Mar 2022 16:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mMcKlcLkl25csYGtmWB99GmowZ54MQeoPUbWxxcyFU0=;
        b=bp+YoIVGfFN/43D3vqHErY1NhIRJApUAhtw6o/hQeIyaDBqIfE66EIhFuNlzouKqsM
         ICMTNUqtiRAq88ITvYxr1uiF5OmdPGah32szvxsrVE8+TbWCoOGxOG6L25aPWaho7kdy
         3FU/jNh6QDkaRKObZiMMOkBlD8Aqv99swKSc8YZ9bFy6T0F/mbML6sVVYqbR6qCMVE6H
         bYhE/ZUbxEYhn6H6a+/VharXFDIBFPo45r3fdwvvEZ51SgbTUi25vilSjvica56rkM6I
         xTjLcOE3UXJzEYpLAj8t0ISFMLBTpHiYS87O0Yj4+2ZJb/rKhYVFzvJMGee+en585/rw
         GBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mMcKlcLkl25csYGtmWB99GmowZ54MQeoPUbWxxcyFU0=;
        b=chYL0Y4kWK1gGqgYnTvOjp+nqtxdKnUgXFAVfWWhOH1OAKj7tZ80gRrNeslEeAGwgJ
         P6TwkBZ+iiOGS0ao3ZeQFHlqyaYNCh+0CwrPbW7gtIyxPW2mpvUBNWXCkMM0w25OmsXM
         UcLX553H6RvB3nfSZpzOl42kg6eh35B5L1gbAjUnOE4WhthjGdX8Eh5TNwUTFkjCRMv3
         fiMJIbod8W+UTQa+WIj4A4h95t3ZYgDXfm6wCfwYkKkIM/UmqrAiuCp5blNmYDbUFvMS
         wqFHt+iSFAiIOPFtglHqFwbxDFP3ZTaxXDHqMlfPbxZDYeBQ5Vo9K4fDROmKjh1YBtsa
         2tPA==
X-Gm-Message-State: AOAM5312iPnWHsZSciEXpB7rPJR73fxcDddcc5Kul0M3C85nlqOq6TLB
        /q8e8rRzEFMhT3f4DIwBSJSFV6+a5pRTp8URicD/FA==
X-Google-Smtp-Source: ABdhPJzivdKSx3a2ptS01jjlhP74llQ2PdFx6OA83cn+BAtPtg6OtNsv++AhnKe1mUMAW8amvG7lkgIAO9oTvOh6yGc=
X-Received: by 2002:a17:906:5d08:b0:6da:b4ea:937 with SMTP id
 g8-20020a1709065d0800b006dab4ea0937mr20516098ejt.446.1647301539672; Mon, 14
 Mar 2022 16:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220309165222.2843651-1-tjmercier@google.com>
 <20220309165222.2843651-8-tjmercier@google.com> <CAHRSSEy5_h9LJB4q5_OJA7fSq=ROo68UaK+hdPz-Vj-wac1Qhg@mail.gmail.com>
In-Reply-To: <CAHRSSEy5_h9LJB4q5_OJA7fSq=ROo68UaK+hdPz-Vj-wac1Qhg@mail.gmail.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Mon, 14 Mar 2022 16:45:28 -0700
Message-ID: <CABdmKX1G0Rwmz7=BP1ER+TmtrnkGiE0nROsPTHKxnj=6bHhY3Q@mail.gmail.com>
Subject: Re: [RFC v3 7/8] binder: use __kernel_pid_t and __kernel_uid_t for userspace
To:     Todd Kjos <tkjos@google.com>
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

On Thu, Mar 10, 2022 at 11:33 AM Todd Kjos <tkjos@google.com> wrote:
>
> On Wed, Mar 9, 2022 at 8:52 AM T.J. Mercier <tjmercier@google.com> wrote:
> >
> > The kernel interface should use types that the kernel defines instead o=
f
> > pid_t and uid_t, whose definiton is owned by libc. This fixes the heade=
r
> > so that it can be included without first including sys/types.h.
> >
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > ---
> >  include/uapi/linux/android/binder.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/a=
ndroid/binder.h
> > index 169fd5069a1a..aa28454dbca3 100644
> > --- a/include/uapi/linux/android/binder.h
> > +++ b/include/uapi/linux/android/binder.h
> > @@ -289,8 +289,8 @@ struct binder_transaction_data {
> >
> >         /* General information about the transaction. */
> >         __u32           flags;
> > -       pid_t           sender_pid;
> > -       uid_t           sender_euid;
> > +       __kernel_pid_t  sender_pid;
> > +       __kernel_uid_t  sender_euid;
>
> Are we guaranteed that this does not affect the UAPI at all? Userspace
> code using this definition will have to run with kernels using the old
> definition and visa-versa.

A standards compliant userspace should be expecting a signed integer
type here. So the only way I can think userspace would be affected is
if:
1) pid_t is a long AND
2) sizeof(long) > sizeof(int) AND
3) Consumers of the pid_t definition actually attempt to mutate the
result to make use of extra bits in the variable (which are not there)

This seems extremely unlikely. For instance just on the topic of the
first item, all of the C library implementations with pid_t
definitions linked here use an int, except for Bionic which typdefs
pid_t to __kernel_pid_t and Sortix which uses long.
https://wiki.osdev.org/C_Library

However I would argue this is already broken and should count as a bug
fix since I can't do this:

$ cat binder_include.c ; gcc binder_include.c
#include <linux/android/binder.h>
int main() {}
In file included from binder_include.c:1:
/usr/include/linux/android/binder.h:291:9: error: unknown type name =E2=80=
=98pid_t=E2=80=99
  291 |         pid_t           sender_pid;
      |         ^~~~~
/usr/include/linux/android/binder.h:292:9: error: unknown type name =E2=80=
=98uid_t=E2=80=99
  292 |         uid_t           sender_euid;
      |         ^~~~~

This is also the only occurrence of pid_t in all of
include/uapi/linux. All 40+ other uses are __kernel_pid_t, and I don't
see why the binder header should be different.


>
> >         binder_size_t   data_size;      /* number of bytes of data */
> >         binder_size_t   offsets_size;   /* number of bytes of offsets *=
/
> >
> > --
> > 2.35.1.616.g0bdcbb4464-goog
> >
