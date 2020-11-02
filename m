Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1272A36D4
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Nov 2020 23:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgKBW5N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Nov 2020 17:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgKBW5N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Nov 2020 17:57:13 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C510C061A47
        for <linux-kselftest@vger.kernel.org>; Mon,  2 Nov 2020 14:57:13 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id k1so14435787ilc.10
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Nov 2020 14:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hs0Us9Z/+TOb7bbHM2aFgqzh1cMhIoWjcZOjSZ5zWSk=;
        b=iedrl1z00k+9lh8fyTbrdFSKDBISSS7oXJpz6IXy2JAzvvnyCsqf8hk5/OPEu11sIP
         lyIRgD9vfQrZo1YMsWoFm1wNPvwBch1LrSvxgJUpSHUutusnzxbniPpcx0HD4DcvTUbz
         f8IHc30ExhJfNgMB13itTyp9U1tdNvLf7c0HTQ5WrAaCTh8V9ZQISuq6n4R2s/Hmd6Ye
         31jsWnHXfI35LzLYC0wcNdsZsAwNMFoQU3sNTR8gr1P944kLwvyVZM2VP1jEyzKCYNjk
         vjepaDhcLRknwVF7HbkJLtscqRjNZrp27yg6FYUjsRg8330fyDPfkcNFo3en4lH/MDF3
         IJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hs0Us9Z/+TOb7bbHM2aFgqzh1cMhIoWjcZOjSZ5zWSk=;
        b=eEV54eUVgvA6lj+9CUf/fC4pn/T2y1rtxXbF0Ww8rYrA4f9oQa89b8cV1a2c1gBxg/
         SCBDQv4yyPRAOIQ2qc2ofyV2+w6wR+nxAZ2Z8Jc2FGZp5hoFeW4Sxh4I8DTc0LFJU6ep
         93p6ZPQ8TDlH4m7TAjEwdAHXR05GGi8ghVQtxLycQVDGULnIgdjqoVo4HF4Sw/JSWKyP
         F32197+dxMJ1lyLTr4EpeczsCZScyIrF1Bl8IKTZAgIH9UDtpR2i7j2qzgZ8PXq3fEMg
         tM6Z0PzxYeS0J6v3jMO9U0e6h1ZcN2cddjLYaWPe0i/kCafsLv8qSM42eHmp5V9iIGiL
         vXFQ==
X-Gm-Message-State: AOAM530ykVJuhjlKHzYSTCAJiiSk1BdFRbVBZovm+D32/bltQtBJ8a8n
        jpkKma7ktiqL9elvDIDk3ZJkblFniT6YAgMrRg2nDg==
X-Google-Smtp-Source: ABdhPJyncfHHjmSOovj/7PcxKm7V8ID6ihZUdQi8S7WvMtbcILzGbwtcPQ9Ms0kcr8PyDXRvv5RWik2pzkaRiMay8JQ=
X-Received: by 2002:a05:6e02:bcb:: with SMTP id c11mr12118588ilu.285.1604357832569;
 Mon, 02 Nov 2020 14:57:12 -0800 (PST)
MIME-Version: 1.0
References: <20201027233733.1484855-1-bgardon@google.com> <20201027233733.1484855-2-bgardon@google.com>
 <20201102212358.GB20600@xz-x1>
In-Reply-To: <20201102212358.GB20600@xz-x1>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 2 Nov 2020 14:57:01 -0800
Message-ID: <CANgfPd9OYMRUMtLah7pQCqFVgCi8RQS_whbTHN3tgK+hxB_3gw@mail.gmail.com>
Subject: Re: [PATCH 1/5] KVM: selftests: Factor code out of demand_paging_test
To:     Peter Xu <peterx@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Huth <thuth@redhat.com>,
        Peter Feiner <pfeiner@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 2, 2020 at 1:24 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Oct 27, 2020 at 04:37:29PM -0700, Ben Gardon wrote:
> > Much of the code in demand_paging_test can be reused by other, similar
> > multi-vCPU-memory-touching-perfromance-tests. Factor that common code
> > out for reuse.
> >
> > No functional change expected.
>
> Is there explicit reason to put the common code in a header rather than
> perf_test_util.c?  No strong opinion on this especially this is test code,
> just curious.  Since iiuc .c file is still preferred for things like this.
>

I don't have a compelling reason not to put the common code in a .c
file, and I agree that would probably be a better place for it. I'll
do that in a v2.

> >
> > This series was tested by running the following invocations on an Intel
> > Skylake machine:
> > dirty_log_perf_test -b 20m -i 100 -v 64
> > dirty_log_perf_test -b 20g -i 5 -v 4
> > dirty_log_perf_test -b 4g -i 5 -v 32
> > demand_paging_test -b 20m -v 64
> > demand_paging_test -b 20g -v 4
> > demand_paging_test -b 4g -v 32
> > All behaved as expected.
>
> May move this chunk to the cover letter to avoid keeping it in every commit
> (btw, you mentioned "this series" but I feel like you meant "you verified that
> after applying each of the commits").

I can move the testing description to the cover letter. I can only
definitively say I ran those tests at the last commit in the series,
so I'll amend the description to specify that the commits were tested
all together and not one by one.

>
> Thanks,
>
> --
> Peter Xu
>
