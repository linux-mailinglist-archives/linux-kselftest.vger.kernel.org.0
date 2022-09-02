Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D525AB1A9
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Sep 2022 15:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbiIBNh4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Sep 2022 09:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236241AbiIBNhO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Sep 2022 09:37:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7BDD99DE
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Sep 2022 06:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662124500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=10S2baNmGpvfbB3rWC8TV3GU8jc51um5+NmqwLplTxA=;
        b=bbnPFkQtBv7JPymZRoXwdz+lQun4uZkFf1l8XQ+jUrHqg/S9evJ3dug7DJQHZiIC3TJX6S
        NyPeGnqV+DigYEU2R97h4tgNaql/URtrnUPzwVHVo81JSgIIQ4dbF4xOF15MRtv50O/yis
        ZUfo3Ouuwm8J89Rl0zLozX9BHs/BpDg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-332-1ZYk_m5HOsGVaJxtU4wbEw-1; Fri, 02 Sep 2022 09:11:50 -0400
X-MC-Unique: 1ZYk_m5HOsGVaJxtU4wbEw-1
Received: by mail-pj1-f69.google.com with SMTP id u5-20020a17090a1d4500b001fad7c5f685so1118300pju.9
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Sep 2022 06:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=10S2baNmGpvfbB3rWC8TV3GU8jc51um5+NmqwLplTxA=;
        b=sA0wtc9qYhG5KQqiI/5WosJWtrp1PJsiVVrppbWQBduYUaEqUPMgdJ4V8qWlkny1Qs
         qnFb/JrTvDtIv+umNHi3CZvTYtzloE/Xt0qqTbUHLKN6Ri/5N+09I+nmU1A16CQl8VzR
         geA9WBsoIQGCvG4r0jML/d0fAYOiu9qMYPm4dwvkdMpmtuCPlNnr5a4jid1BhXWevC+0
         qUx6IOKaKQeO7J0xJWF8V0TbigiVJyg7ZQU9rrQ6JayyXa/KGvl8OsNhNf7kex4tCF3M
         Zi6ODHVrOFqfUcS8HnZh1HuHqnwwcUT3nX+6Pdy1n88uWgVDe0AVKkeeURtV0PvEeXxZ
         fczA==
X-Gm-Message-State: ACgBeo3eCPkV3gBgRNtr0dr0VZQEOW4dXupv26p3GdvO7MzDf4EXQIvX
        WsprL/22VANUmIYScBKCVEMQWQwb7hgR4M4nuPaHNLqkqDXTvZiJu0MdBI9g/+lg1AxvULDygWx
        ampJdlBRivruJY1itECaC1rK4CG72o8YmXLP3vuTGLiNa
X-Received: by 2002:a17:902:b58a:b0:16e:f91a:486b with SMTP id a10-20020a170902b58a00b0016ef91a486bmr36558491pls.119.1662124309710;
        Fri, 02 Sep 2022 06:11:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR72EpfhkEK4ko7qYW4nPa0blgG/78lQfqmeZeVLgOOiuWSw4Fu8+YGj6zLNMt/u79Hm3xPofVjqghC/L9D7cM4=
X-Received: by 2002:a17:902:b58a:b0:16e:f91a:486b with SMTP id
 a10-20020a170902b58a00b0016ef91a486bmr36558475pls.119.1662124309461; Fri, 02
 Sep 2022 06:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220824134055.1328882-1-benjamin.tissoires@redhat.com>
 <20220824134055.1328882-2-benjamin.tissoires@redhat.com> <CAADnVQKgkFpLh_URJn6qCiAONteA1dwZHd6=4cZn15g1JCAPag@mail.gmail.com>
 <CAP01T75ec_T0M6DU=JE2tfNsWRZuPSMu_7JHA7ZoOBw5eDh1Bg@mail.gmail.com>
 <CAO-hwJLd9wXx+ppccBYPKZDymO0sk++Nt2E3-R97PY7LbfJfTg@mail.gmail.com>
 <CAADnVQK8dS+2KbWsqktvxoNKhHtdD5UPiaWVfNu=ESdn_OHpgQ@mail.gmail.com>
 <CAO-hwJK9uHTWCg3_6jrPF6UKiamkNfj=cuH5mHauoLX+0udV9w@mail.gmail.com>
 <CAADnVQLuL045Sxdvh8kfcNkmD55+Wz8fHU3RtH+oQyOgePU5Pw@mail.gmail.com>
 <CAO-hwJJJJRtoq2uTXRKCck6QSH8SFDSTpHmvTyOieczY7bdm8g@mail.gmail.com> <CAP01T77SJyiDxv0A++_mNw7JZ-Mzh4B1FAM6zLiP6n75MNY0uQ@mail.gmail.com>
In-Reply-To: <CAP01T77SJyiDxv0A++_mNw7JZ-Mzh4B1FAM6zLiP6n75MNY0uQ@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 2 Sep 2022 15:11:38 +0200
Message-ID: <CAO-hwJLbbB0Abw3d4pJPnYTAzQNdtgBTpuNz4zVUTFXCbZEEbQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 01/23] bpf/verifier: allow all functions to
 read user provided context
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Joe Stringer <joe@cilium.io>, Jonathan Corbet <corbet@lwn.net>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 2, 2022 at 5:50 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Thu, 1 Sept 2022 at 18:48, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > [...]
> > If the above is correct, then yes, it would make sense to me to have 2
> > distinct functions: one to check for the args types only (does the
> > function definition in the problem matches BTF), and one to check for
> > its use.
> > Behind the scenes, btf_check_subprog_arg_match() calls
> > btf_check_func_arg_match() which is the one function with entangled
> > arguments type checking and actually assessing that the values
> > provided are correct.
> >
> > I can try to split that  btf_check_func_arg_match() into 2 distinct
> > functions, though I am not sure I'll get it right.
>
> FYI, I've already split them into separate functions in my tree
> because it had become super ugly at this point with all the new
> support and I refactored it to add the linked list helpers support
> using kfuncs (which requires some special handling for the args), so I
> think you can just leave it with a "processing_call" check in for your
> series for now.
>

great, thanks a lot.
Actually, writing the patch today with the "processing_call" was
really easy now that I have turned the problem in my head a lot
yesterday.

I am about to send v10 with the reviews addressed.

Cheers,
Benjamin

