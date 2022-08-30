Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF8F5A64C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Aug 2022 15:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiH3Nau (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 09:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiH3Nas (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 09:30:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4666FA50CE
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 06:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661866246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C071C0Fu4zpnzqm2GxjZqFKUf2VQ3Uu+K+WnKl/q7NU=;
        b=RR7oEeoI7hG5XRP6ANF68dsc5XgjBd3Dn24JOXkxw1KRRHXnSzlKqKAbbfiILnao7BPjgW
        iU2G8tKNUp311uf/DvNpb+cQtNDAtaLG6zmULZPbXlW3W65CnxF/NRjWIx5fmsfR1jAb5h
        1KixJN9bKsF2LGKNgIRKNUDKhi7tbLg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-115-ryTHt1UMORSBlqY-XwpDFg-1; Tue, 30 Aug 2022 09:30:38 -0400
X-MC-Unique: ryTHt1UMORSBlqY-XwpDFg-1
Received: by mail-pj1-f70.google.com with SMTP id gg12-20020a17090b0a0c00b001fbc6ba91bbso908956pjb.4
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 06:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=C071C0Fu4zpnzqm2GxjZqFKUf2VQ3Uu+K+WnKl/q7NU=;
        b=8Ef5/gNux1HyYbv/wzMMqpsTff3/QNIBIXcwKnZ/rsaNYurk4HJp3eof/pyuWaXkUr
         jOGcShvpOpVKC8I4ADF4X5ii9diW6+ekvf+Gbg5gpRtNL7xN+JYzN54eQkUicudPtvk4
         Iy7K68BOl4db2w/Xj7hi0OVOsAiQ1+YKuHK0cKcEOVxwA6zOGqogSAUIu3yghFK+sGwd
         rSRXkYt9Q5Y8MSzDWXuAv/mIRzJkqLBBbtVrBS4lsVKJ9aPXYv4cO50p4t1iVNDpHaQq
         nwhHBSJ6Xi6on+2d9vzFMtp2ImnYxpCpsiMRRcPZwZ1DwWDmTjQjFtn7Quk4WAVhkEeV
         rTzg==
X-Gm-Message-State: ACgBeo0wj5NPQMxpZ/B1iuy6hOutmefY7S2eeHFWs2O+gJM/sTxWtiiy
        MoKqYrrYkC/ISGZvcUyWR49X4uwqkOPhcW6uWqhGhjO6rOl1kS63BtUkiaJAB26sz2TOWLVj3uP
        1icEbVc9AsTQI9+3Q7QyYy1+X1f3/xJfOLG0nSx8uBrNE
X-Received: by 2002:a63:d10b:0:b0:41d:bd7d:7759 with SMTP id k11-20020a63d10b000000b0041dbd7d7759mr17929695pgg.196.1661866237882;
        Tue, 30 Aug 2022 06:30:37 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7CO92TZNx1/ZDyoq+lGXimNNYaqY6rNHmUopJlR2o2q6TOwVRYYUayx8+y1zHvUDGFjESrSTgnSoi2AHd+NLQ=
X-Received: by 2002:a63:d10b:0:b0:41d:bd7d:7759 with SMTP id
 k11-20020a63d10b000000b0041dbd7d7759mr17929681pgg.196.1661866237660; Tue, 30
 Aug 2022 06:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220721153625.1282007-1-benjamin.tissoires@redhat.com>
 <20220721153625.1282007-25-benjamin.tissoires@redhat.com> <YwbkC9v83gk0Eq/d@debian.me>
In-Reply-To: <YwbkC9v83gk0Eq/d@debian.me>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 30 Aug 2022 15:30:26 +0200
Message-ID: <CAO-hwJ+zJZzRXaj3ZGSaz9N3p7hE0mdcbsxTK04L-ep7_podFw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 24/24] Documentation: add HID-BPF docs
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
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
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 25, 2022 at 4:53 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On Thu, Jul 21, 2022 at 05:36:25PM +0200, Benjamin Tissoires wrote:
> > +When (and why) to use HID-BPF
> > +=============================
> > +
> > +We can enumerate several use cases for when using HID-BPF is better than
> > +using a standard kernel driver fix:
> > +
>
> Better say "There are several use cases when using HID-BPF is better
> than standard kernel driver fix:"

OK, included locally, and will send it in v10.

>
> > +When a BPF program needs to emit input events, it needs to talk HID, and rely
> > +on the HID kernel processing to translate the HID data into input events.
> > +
>
> talk to HID?

Replaced with "it needs to talk with the HID protocol".

>
> Otherwise the documentation LGTM (no new warnings caused by the doc).

Great, thanks a lot for the review :)

Cheers,
Benjamin

>
> --
> An old man doll... just what I always wanted! - Clara

