Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E311573669
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jul 2022 14:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiGMMca (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Jul 2022 08:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbiGMMc3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Jul 2022 08:32:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1142FEB004
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jul 2022 05:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657715547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bXRPU0M/Hx+9lHfOL9LxYIk0tOoUqE9PtXfSvp6NKH4=;
        b=hHxmyDMY7GxUsiFRW9Gf0Da5IpJzYty0dTTYiXpk7ft+hsZlxOLs+zVqPpdvjzDizwvrJA
        y59j4xAtQBkPVL5fb5m9CNkZ3mphd+twYjsk1tUCsht8CD6BSnqHvqxFW4hA1MRjnARdrJ
        eY0nsrwGCjvehVnvxOVVaeFvKxPLACc=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-604-dErw5v2lNNiQxewxRyTEIg-1; Wed, 13 Jul 2022 08:32:26 -0400
X-MC-Unique: dErw5v2lNNiQxewxRyTEIg-1
Received: by mail-pg1-f200.google.com with SMTP id x17-20020a631711000000b0041240801d34so5156744pgl.17
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jul 2022 05:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bXRPU0M/Hx+9lHfOL9LxYIk0tOoUqE9PtXfSvp6NKH4=;
        b=5OgBHRgDKO1ixg+r8VneUE6f/nqpuUPLiLZCnlxEPk2oh4v6+pG+6RQ5oSUnzwHPO5
         FWa8+rojUmHJm4OxM7mkKKKeHyEkN8zMuxK+QoAkTW1hz9b3oHeFdBdBuoDp2VJc1RYd
         LQlksZKNr6h/iPObckVSBIwJYqoc6VEuP+Dvb3tOeStX2FeSM/RmxPjplfXg1ehonS7H
         0Fl9wwd5jFMsuBySrGl3HCZRBYumXuVnQGKsxJYgsZmYzRPliD8MEgNHWQ0dbJgditsu
         vFq2zrGrg2onnW/dvE83vDaPNZGTVeLiny5RODHYsARuetUHNP/sCeGxVQ5y0gWs1Qpo
         IGcg==
X-Gm-Message-State: AJIora94uQllDdx1C75wJUN7Ry8N8xy+R1flqdMlhEEJM8Y5xgxYQJWE
        wclrTaXo1I1egOl2XuZuTazfJVRXa4AYzpQejSE2u+C1uA7snmK+1Qk7sck+QLhc4PJgvXukIWL
        vbKPlD4GNCedKuvqEHGXxv4VzrkB+KG9L7JnIUDI17bv0
X-Received: by 2002:a63:5b16:0:b0:416:1b3b:9562 with SMTP id p22-20020a635b16000000b004161b3b9562mr2825454pgb.146.1657715544985;
        Wed, 13 Jul 2022 05:32:24 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t9uWNYHyTapK2q1N1e3wCrLFwPd90gcSU2/P3W7avhJlby/nfPUHw1idL6GYPgQCA5GzKprWxsedAv0ocYYfA=
X-Received: by 2002:a63:5b16:0:b0:416:1b3b:9562 with SMTP id
 p22-20020a635b16000000b004161b3b9562mr2825431pgb.146.1657715544728; Wed, 13
 Jul 2022 05:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220712145850.599666-1-benjamin.tissoires@redhat.com>
 <20220712145850.599666-22-benjamin.tissoires@redhat.com> <Ys61XcZL4Fh/VQu1@codewreck.org>
In-Reply-To: <Ys61XcZL4Fh/VQu1@codewreck.org>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 13 Jul 2022 14:32:13 +0200
Message-ID: <CAO-hwJJPN=joJdQtfJ6qYxvkkgq3Ytp0yq6O=uUm4iCJCa47Ww@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 21/23] samples/bpf: add new hid_mouse example
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
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
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 13, 2022 at 2:16 PM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Benjamin Tissoires wrote on Tue, Jul 12, 2022 at 04:58:48PM +0200:
> > diff --git a/samples/bpf/hid_mouse.c b/samples/bpf/hid_mouse.c
> > new file mode 100644
> > index 000000000000..f6e5f09026eb
> > --- /dev/null
> > +++ b/samples/bpf/hid_mouse.c
> > @@ -0,0 +1,150 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright (c) 2022 Benjamin Tissoires
> > + */
> > +
> > +/* not sure why but this doesn't get preoperly imported */
>
> typo: properly
>
> > +#define __must_check
>
> But more usefully, I don't think it should be needed -- we don't use
> __must_check at all in uapi includes; if this is needed that means some
> of the include here uses the kernel internal includes and that shouldn't
> be needed as they're not normally installed.

Indeed, I must have had the issue in the early days of development.
Removing the line still makes the program compile, so I'll remove it
in v7.

Thanks a lot!

Cheers,
Benjamin

>
> Didn't actually try to see but taking the compilation line that fails
> and running it with -E will probably show where that must_check comes
> from
>
> --
> Dominique Martinet | Asmadeus,
> just passing by
>

