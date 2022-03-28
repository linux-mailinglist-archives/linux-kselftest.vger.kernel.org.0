Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8D44E8E7D
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Mar 2022 08:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238618AbiC1G6m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Mar 2022 02:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238602AbiC1G6l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Mar 2022 02:58:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFD904F9F8
        for <linux-kselftest@vger.kernel.org>; Sun, 27 Mar 2022 23:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648450620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GXnAjkr/2A5EMowmWRXznPohqOX2kcPUCHlbiRHmv8Q=;
        b=M7cgIBJMrCaYudaAvqFNDfhbGdJH7Bl9Q/7wZ7EEh5v6UwocPZ7/0EKG2HWNwL7RBtkqaK
        5/SkWj+O9gp0+REAmaYE39NIeJKFoxgCnMO0gj8g2VTezvGlED2M15xTOCxtWUPHQMoCOv
        oGLh+9sk1Rkxr1onGAlTNTNbR8nQfnM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-225-_wL_gT3YMma8t0RGZyFi-g-1; Mon, 28 Mar 2022 02:56:59 -0400
X-MC-Unique: _wL_gT3YMma8t0RGZyFi-g-1
Received: by mail-pj1-f72.google.com with SMTP id gk23-20020a17090b119700b001c65a1baa01so6859762pjb.5
        for <linux-kselftest@vger.kernel.org>; Sun, 27 Mar 2022 23:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GXnAjkr/2A5EMowmWRXznPohqOX2kcPUCHlbiRHmv8Q=;
        b=NGGo9QTK7y96fRh6CnahmoUO8VFAbQ/IsTUIDRI61Kk68w+cF3d5jI4shh0NlJJTxN
         r/Ivbx5oFmS3zdZCS/CGfoqs+hKYC2gPewSBPQYcQDFsWMHTxoVInkI95X3IJkxRZSzK
         6ghuSs72aQeyAmcKGdrjiDvIhboNNWtcUA7wUnzxq4AhgYQYQevSIM+rLiN7TAybQ9Un
         VuVG2h8KM5ov3ikNiWqEu91oMMSfHQ7OgIMhfB4iGn/8TkG3EsElPAWp44qDasCXexSI
         yQwVeEYiyJqezkOVTZvE37fhZdOClnFauNFGQVL3+V38eutNeJ3KGEvAlnEnxjDtW6fT
         Tz+w==
X-Gm-Message-State: AOAM531hMrZtltbNK3Kt5cCMKHY+kaakgvrZArPW02tbUEDAO1T0M2YO
        YQCypeMtXmP1PARtV4ES2BSY4VXCMidQ9RGMhtkRsJ1ZyCzqyWlL05hiIT0NOuFsHz1za54IPgd
        4D9YnJBT5Js4GUIY30FUoKUgsNqU7BGF+TtQWOUYrGMYv
X-Received: by 2002:a65:5bc3:0:b0:378:4f82:d73d with SMTP id o3-20020a655bc3000000b003784f82d73dmr9382946pgr.191.1648450617850;
        Sun, 27 Mar 2022 23:56:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDGbONhbKlNHbKmZvjyqzr931S0/Je+LVeiwY6d3dsfsR2Cx5iTxfjSUu6T4LVTWjACMclHlLj0nzrfl8wGhM=
X-Received: by 2002:a65:5bc3:0:b0:378:4f82:d73d with SMTP id
 o3-20020a655bc3000000b003784f82d73dmr9382922pgr.191.1648450617255; Sun, 27
 Mar 2022 23:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220318161528.1531164-1-benjamin.tissoires@redhat.com>
 <20220318161528.1531164-7-benjamin.tissoires@redhat.com> <CAADnVQLvhWxEtHETg0tasJ7Fp5JHNRYWdjhnxi1y1gBpXS=bvQ@mail.gmail.com>
 <CAO-hwJJXR3jtAvLF1phUa5pKZzVkDxAAHO5+7R50hL-fVhDYyA@mail.gmail.com> <CAEf4BzYVu9JVJvKZK3S9HGwpyPiWrwKPGsTz3wXC_+vmRYGdNw@mail.gmail.com>
In-Reply-To: <CAEf4BzYVu9JVJvKZK3S9HGwpyPiWrwKPGsTz3wXC_+vmRYGdNw@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 28 Mar 2022 08:56:46 +0200
Message-ID: <CAO-hwJKPxKCzxCKGpH85j5VG3bQk+7axDYpxYoy-12yL7AQj2w@mail.gmail.com>
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

On Fri, Mar 25, 2022 at 6:00 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Mar 23, 2022 at 9:08 AM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > Hi Alexei,
> >
> > On Tue, Mar 22, 2022 at 11:51 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Mar 18, 2022 at 9:16 AM Benjamin Tissoires
> > > <benjamin.tissoires@redhat.com> wrote:
> > > >
> > > > +u8 *hid_bpf_report_fixup(struct hid_device *hdev, u8 *rdesc, unsigned int *size)
> > > > +{
> > > > +       int ret;
> > > > +       struct hid_bpf_ctx_kern ctx = {
> > > > +               .type = HID_BPF_RDESC_FIXUP,
> > > > +               .hdev = hdev,
> > > > +               .size = *size,
> > > > +       };
> > > > +
> > > > +       if (bpf_hid_link_empty(&hdev->bpf, BPF_HID_ATTACH_RDESC_FIXUP))
> > > > +               goto ignore_bpf;
> > > > +
> > > > +       ctx.data = kmemdup(rdesc, HID_MAX_DESCRIPTOR_SIZE, GFP_KERNEL);
> > > > +       if (!ctx.data)
> > > > +               goto ignore_bpf;
> > > > +
> > > > +       ctx.allocated_size = HID_MAX_DESCRIPTOR_SIZE;
> > > > +
> > > > +       ret = hid_bpf_run_progs(hdev, &ctx);
> > > > +       if (ret)
> > > > +               goto ignore_bpf;
> > > > +
> > > > +       if (ctx.size > ctx.allocated_size)
> > > > +               goto ignore_bpf;
> > > > +
> > > > +       *size = ctx.size;
> > > > +
> > > > +       if (*size) {
> > > > +               rdesc = krealloc(ctx.data, *size, GFP_KERNEL);
> > > > +       } else {
> > > > +               rdesc = NULL;
> > > > +               kfree(ctx.data);
> > > > +       }
> > > > +
> > > > +       return rdesc;
> > > > +
> > > > + ignore_bpf:
> > > > +       kfree(ctx.data);
> > > > +       return kmemdup(rdesc, *size, GFP_KERNEL);
> > > > +}
> > > > +
> > > >  int __init hid_bpf_module_init(void)
> > > >  {
> > > >         struct bpf_hid_hooks hooks = {
> > > >                 .hdev_from_fd = hid_bpf_fd_to_hdev,
> > > >                 .pre_link_attach = hid_bpf_pre_link_attach,
> > > > +               .post_link_attach = hid_bpf_post_link_attach,
> > > >                 .array_detach = hid_bpf_array_detach,
> > > >         };
> > > >
> > > > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > > > index 937fab7eb9c6..3182c39db006 100644
> > > > --- a/drivers/hid/hid-core.c
> > > > +++ b/drivers/hid/hid-core.c
> > > > @@ -1213,7 +1213,8 @@ int hid_open_report(struct hid_device *device)
> > > >                 return -ENODEV;
> > > >         size = device->dev_rsize;
> > > >
> > > > -       buf = kmemdup(start, size, GFP_KERNEL);
> > > > +       /* hid_bpf_report_fixup() ensures we work on a copy of rdesc */
> > > > +       buf = hid_bpf_report_fixup(device, start, &size);
> > >
> > > Looking at this patch and the majority of other patches...
> > > the code is doing a lot of work to connect HID side with bpf.
> > > At the same time the evolution of the patch series suggests
> > > that these hook points are not quite stable. More hooks and
> > > helpers are being added.
> > > It tells us that it's way too early to introduce a stable
> > > interface between HID and bpf.
> >
> > I understand that you might be under the impression that the interface
> > is changing a lot, but this is mostly due to my poor knowledge of all
> > the arcanes of eBPF.
> > The overall way HID-BPF works is to work on a single array, and we
> > should pretty much be sorted out. There are a couple of helpers to be
> > able to communicate with the device, but the API has been stable in
> > the kernel for those for quite some time now.
> >
> > The variations in the hooks is mostly because I don't know what is the
> > best representation we can use in eBPF for those, and the review
> > process is changing that.
>
> I think such a big feature as this one, especially that most BPF folks
> are (probably) not familiar with the HID subsystem in the kernel,
> would benefit from a bit of live discussion during BPF office hours.
> Do you think you can give a short overview of what you are trying to
> achieve with some background context on HID specifics at one of the
> next BPF office hours? We have a meeting scheduled every week on
> Thursday, 9am Pacific time. But people need to put their topic onto
> the agenda, otherwise the meeting is cancelled. See [0] for
> spreadsheet and links to Zoom meeting, agenda, etc.

This sounds like a good idea. I just added my topic on the agenda and
will prepare some slides.

Cheers,
Benjamin

>
>   [0] https://docs.google.com/spreadsheets/d/1LfrDXZ9-fdhvPEp_LHkxAMYyxxpwBXjywWa0AejEveU
>
> [...]
>

