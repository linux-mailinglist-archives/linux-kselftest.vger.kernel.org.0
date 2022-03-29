Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A984EAED9
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Mar 2022 15:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbiC2Nzm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Mar 2022 09:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbiC2Nzl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Mar 2022 09:55:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 982761C3902
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Mar 2022 06:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648562036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=un9l7/a+uEq1XogerESBiAijCYeuvtYw94AitMUuZ+M=;
        b=RcWUOvVIUP2cGJWMfV/ZI8xd8zZS36OghrbFN+RUNUTm+26nKcZ7VKCHemoRPpePP9YVWP
        yZXfoAoT6zHywE/q25Iic/rg5JJslR4t2/xcTM1JuLB5SVGyIMlSNLY5Ka5jkUg4YfHR16
        QS8wB3QiQz8+tz2s2H05w+NMFiBh6bw=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-r1qvGFohPGKpnNVqsuTm8A-1; Tue, 29 Mar 2022 09:53:54 -0400
X-MC-Unique: r1qvGFohPGKpnNVqsuTm8A-1
Received: by mail-pg1-f200.google.com with SMTP id q8-20020a656a88000000b003810f119b61so8581345pgu.10
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Mar 2022 06:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=un9l7/a+uEq1XogerESBiAijCYeuvtYw94AitMUuZ+M=;
        b=mGdnwiawZ8Tq9XQL3FJ9FLLK7zjDOfmMiXkK+H0B6N9EHDJuaEc9+P7eTJx33wVxlZ
         il0v0dcUtGyQJRl7HCD/f59PG6kdMZcL0mt9h8Q0M0NZc2ywNBDUJYkxDuuHdvNbrW/x
         fOrR11UPawPiZrtofiUBDBKir/VRTQ/dQ75b23OpuCJcMQge4TfkfuQSn1XO5xZjaDjd
         xIPNVtsoClbwbDdmZds10HQZGf5JVKdzU1r6PYBL/u4fFB6axPa+iVJUu34qHcZyf2Lu
         pmPPVxGQacrQLz4DxOjlBtUoW9vOwfqkyCiN+qJNAuKHifgCofbqNnbar+AJ/Z5a1mzO
         WQtQ==
X-Gm-Message-State: AOAM533T4Ra64A60fOSyA3bDYtoal++1tYNxMYzJzy4wf9OzVX4heJqk
        LVLs7OTnl/vJv4AN/ZzAbVykMTvgPS7uBfUxj2E2WyFppl+B6rvn+Xci0g7n2hMSzl+BKei5jjv
        pM/HweDRKBrEWGIczdClI2vjuwGv3i8lymWFkRp44RJF0
X-Received: by 2002:a63:6c0a:0:b0:398:6bd2:a16a with SMTP id h10-20020a636c0a000000b003986bd2a16amr2123295pgc.191.1648562033311;
        Tue, 29 Mar 2022 06:53:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGa8CCAa74guVnbIRav3BJCOquPXCu+LU4JQHK3SKWdmRtYE+byETFimsO7Lw1QDDW65u4gI5INxlQXDHGp68=
X-Received: by 2002:a63:6c0a:0:b0:398:6bd2:a16a with SMTP id
 h10-20020a636c0a000000b003986bd2a16amr2123264pgc.191.1648562032802; Tue, 29
 Mar 2022 06:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220318161528.1531164-1-benjamin.tissoires@redhat.com>
 <20220318161528.1531164-7-benjamin.tissoires@redhat.com> <CAADnVQLvhWxEtHETg0tasJ7Fp5JHNRYWdjhnxi1y1gBpXS=bvQ@mail.gmail.com>
 <CAO-hwJJXR3jtAvLF1phUa5pKZzVkDxAAHO5+7R50hL-fVhDYyA@mail.gmail.com>
 <CAEf4BzYVu9JVJvKZK3S9HGwpyPiWrwKPGsTz3wXC_+vmRYGdNw@mail.gmail.com>
 <CAO-hwJKPxKCzxCKGpH85j5VG3bQk+7axDYpxYoy-12yL7AQj2w@mail.gmail.com> <CAEf4BzZA7Wmg=N42ib_r9Jm8THXuGGR3CPgTqMyw9n2=gd_+Kg@mail.gmail.com>
In-Reply-To: <CAEf4BzZA7Wmg=N42ib_r9Jm8THXuGGR3CPgTqMyw9n2=gd_+Kg@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 29 Mar 2022 15:53:41 +0200
Message-ID: <CAO-hwJKnnVkJPG6wtLJ6t7ojv5=vS0NGt14un6+nRmxzj+xifw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 06/17] HID: allow to change the report
 descriptor from an eBPF program
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 28, 2022 at 11:35 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Mar 27, 2022 at 11:57 PM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > On Fri, Mar 25, 2022 at 6:00 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Mar 23, 2022 at 9:08 AM Benjamin Tissoires
> > > <benjamin.tissoires@redhat.com> wrote:
> > > >
> > > > Hi Alexei,
> > > >
> > > > On Tue, Mar 22, 2022 at 11:51 PM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Fri, Mar 18, 2022 at 9:16 AM Benjamin Tissoires
> > > > > <benjamin.tissoires@redhat.com> wrote:
> > > > > >
> > > > > > +u8 *hid_bpf_report_fixup(struct hid_device *hdev, u8 *rdesc, unsigned int *size)
> > > > > > +{
> > > > > > +       int ret;
> > > > > > +       struct hid_bpf_ctx_kern ctx = {
> > > > > > +               .type = HID_BPF_RDESC_FIXUP,
> > > > > > +               .hdev = hdev,
> > > > > > +               .size = *size,
> > > > > > +       };
> > > > > > +
> > > > > > +       if (bpf_hid_link_empty(&hdev->bpf, BPF_HID_ATTACH_RDESC_FIXUP))
> > > > > > +               goto ignore_bpf;
> > > > > > +
> > > > > > +       ctx.data = kmemdup(rdesc, HID_MAX_DESCRIPTOR_SIZE, GFP_KERNEL);
> > > > > > +       if (!ctx.data)
> > > > > > +               goto ignore_bpf;
> > > > > > +
> > > > > > +       ctx.allocated_size = HID_MAX_DESCRIPTOR_SIZE;
> > > > > > +
> > > > > > +       ret = hid_bpf_run_progs(hdev, &ctx);
> > > > > > +       if (ret)
> > > > > > +               goto ignore_bpf;
> > > > > > +
> > > > > > +       if (ctx.size > ctx.allocated_size)
> > > > > > +               goto ignore_bpf;
> > > > > > +
> > > > > > +       *size = ctx.size;
> > > > > > +
> > > > > > +       if (*size) {
> > > > > > +               rdesc = krealloc(ctx.data, *size, GFP_KERNEL);
> > > > > > +       } else {
> > > > > > +               rdesc = NULL;
> > > > > > +               kfree(ctx.data);
> > > > > > +       }
> > > > > > +
> > > > > > +       return rdesc;
> > > > > > +
> > > > > > + ignore_bpf:
> > > > > > +       kfree(ctx.data);
> > > > > > +       return kmemdup(rdesc, *size, GFP_KERNEL);
> > > > > > +}
> > > > > > +
> > > > > >  int __init hid_bpf_module_init(void)
> > > > > >  {
> > > > > >         struct bpf_hid_hooks hooks = {
> > > > > >                 .hdev_from_fd = hid_bpf_fd_to_hdev,
> > > > > >                 .pre_link_attach = hid_bpf_pre_link_attach,
> > > > > > +               .post_link_attach = hid_bpf_post_link_attach,
> > > > > >                 .array_detach = hid_bpf_array_detach,
> > > > > >         };
> > > > > >
> > > > > > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > > > > > index 937fab7eb9c6..3182c39db006 100644
> > > > > > --- a/drivers/hid/hid-core.c
> > > > > > +++ b/drivers/hid/hid-core.c
> > > > > > @@ -1213,7 +1213,8 @@ int hid_open_report(struct hid_device *device)
> > > > > >                 return -ENODEV;
> > > > > >         size = device->dev_rsize;
> > > > > >
> > > > > > -       buf = kmemdup(start, size, GFP_KERNEL);
> > > > > > +       /* hid_bpf_report_fixup() ensures we work on a copy of rdesc */
> > > > > > +       buf = hid_bpf_report_fixup(device, start, &size);
> > > > >
> > > > > Looking at this patch and the majority of other patches...
> > > > > the code is doing a lot of work to connect HID side with bpf.
> > > > > At the same time the evolution of the patch series suggests
> > > > > that these hook points are not quite stable. More hooks and
> > > > > helpers are being added.
> > > > > It tells us that it's way too early to introduce a stable
> > > > > interface between HID and bpf.
> > > >
> > > > I understand that you might be under the impression that the interface
> > > > is changing a lot, but this is mostly due to my poor knowledge of all
> > > > the arcanes of eBPF.
> > > > The overall way HID-BPF works is to work on a single array, and we
> > > > should pretty much be sorted out. There are a couple of helpers to be
> > > > able to communicate with the device, but the API has been stable in
> > > > the kernel for those for quite some time now.
> > > >
> > > > The variations in the hooks is mostly because I don't know what is the
> > > > best representation we can use in eBPF for those, and the review
> > > > process is changing that.
> > >
> > > I think such a big feature as this one, especially that most BPF folks
> > > are (probably) not familiar with the HID subsystem in the kernel,
> > > would benefit from a bit of live discussion during BPF office hours.
> > > Do you think you can give a short overview of what you are trying to
> > > achieve with some background context on HID specifics at one of the
> > > next BPF office hours? We have a meeting scheduled every week on
> > > Thursday, 9am Pacific time. But people need to put their topic onto
> > > the agenda, otherwise the meeting is cancelled. See [0] for
> > > spreadsheet and links to Zoom meeting, agenda, etc.
> >
> > This sounds like a good idea. I just added my topic on the agenda and
> > will prepare some slides.
> >
>
> Great! Unfortunately I personally have a conflict this week and won't
> be able to attend, so I'll have to catch up somehow through word of
> mouth :( Next week's BPF office hours would be best, but I don't want
> to delay discussions just because of me.

OK. FWIW, I'll have slides publicly available once I'll do a final
roundup on them. Hopefully that will give you enough context on HID to
understand the problem.
If there are too many conflicts we can surely delay by a week, but I
would rather have the discussion happening sooner :/

Cheers,
Benjamin

> >
> > >
> > >   [0] https://docs.google.com/spreadsheets/d/1LfrDXZ9-fdhvPEp_LHkxAMYyxxpwBXjywWa0AejEveU
> > >
> > > [...]
> > >
> >
>

