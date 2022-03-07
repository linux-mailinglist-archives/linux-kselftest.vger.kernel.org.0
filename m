Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995924D06B2
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Mar 2022 19:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244794AbiCGSkw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Mar 2022 13:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240323AbiCGSku (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Mar 2022 13:40:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04BAE4D63A
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Mar 2022 10:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646678394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9ZYITTVdz5E4+MP8QXGV8rdQvoNIDdLo/xFs/aMEjrI=;
        b=Ue/uiHYWByMxQmXTJK1ir1dy3J1MVsGs8DTYJDRpYuwGfXV3nZpvipfQZ5Vdf0gg6zCSju
        UQeVzTcd7cKPfdR993gSVnF8ttzXlFU8hciIKqDltvWXbiltvSD0mbqQHdqHrZTtosqqOH
        86chIa6SZv/0sCtlP8hE+vW7p+1Qbwc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-AWZ1QT9VPWia0LA7Bp88tA-1; Mon, 07 Mar 2022 13:39:52 -0500
X-MC-Unique: AWZ1QT9VPWia0LA7Bp88tA-1
Received: by mail-pl1-f200.google.com with SMTP id d14-20020a170902654e00b001518cc774d3so7840057pln.2
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Mar 2022 10:39:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ZYITTVdz5E4+MP8QXGV8rdQvoNIDdLo/xFs/aMEjrI=;
        b=pJCrywEwPJyGD3cLLQGbhX7FeMgdT14pM6cuTkASd2j4k3VD8A5tX5on/+lRefV8Kb
         uvQrpw+26GdqZOi4/AN/8O7/xl0Be23VAlyTBFNH1NUBSj76SoBPYghvQutkOIB1pFv1
         GjkPuEyN6qxfkEYM6U9xYLInQ9NshiWagstydM+4gLdoTMAry+AQLHMtrJt4d91cPkzT
         TJlX9IgAdOJ5TIe8nrEkfnDNXWjvobn8BjXyhiAgUPIYYGA56iEtr3o2Jg25zNgl08cr
         GEhrVi4/bvDezG/FaN1b5HvTRZVKJ9lVzBuSY4iuCazYeno3J0DQAskNpHBWEZQwCZqc
         ecQw==
X-Gm-Message-State: AOAM530dTnfnxvNxkfyWEnjokdIrwiHoh6ikk7I1YeQGXGbCRqTzstjU
        5ojjncLrUCLQRG7CSZnCj5jB7Acdvftugxqa4/g78Q6xMSx6Ka+ZotTdFS1Qj3Jin8ao5JnLkkI
        uikIC7JvjGIFH9VMaK0t7cEjffPW+BinFH/A+Y5aSQYVD
X-Received: by 2002:a17:90a:dac2:b0:1bd:fecf:6bd1 with SMTP id g2-20020a17090adac200b001bdfecf6bd1mr301664pjx.113.1646678391743;
        Mon, 07 Mar 2022 10:39:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDDHIBz07WN3CzLDgk3mGB0kBAncDY+MW2K8mom6cbKR7neISU8OXSB6QzhoWCCgjgI/vefNzYDogresVc6J4=
X-Received: by 2002:a17:90a:dac2:b0:1bd:fecf:6bd1 with SMTP id
 g2-20020a17090adac200b001bdfecf6bd1mr301626pjx.113.1646678391376; Mon, 07 Mar
 2022 10:39:51 -0800 (PST)
MIME-Version: 1.0
References: <20220304172852.274126-1-benjamin.tissoires@redhat.com>
 <20220304172852.274126-3-benjamin.tissoires@redhat.com> <CAPhsuW5CYF9isR4ffRdm3xA_n_FBoL+AGFkzNn4dn2LgRaQQkg@mail.gmail.com>
In-Reply-To: <CAPhsuW5CYF9isR4ffRdm3xA_n_FBoL+AGFkzNn4dn2LgRaQQkg@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 7 Mar 2022 19:39:40 +0100
Message-ID: <CAO-hwJKFE4Ps962BBubn8=1K0k9mC2qi8VerFbZo1sqpp6yekg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 02/28] bpf: introduce hid program type
To:     Song Liu <song@kernel.org>
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
        Joe Stringer <joe@cilium.io>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Mar 5, 2022 at 1:03 AM Song Liu <song@kernel.org> wrote:
>
> On Fri, Mar 4, 2022 at 9:31 AM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > HID is a protocol that could benefit from using BPF too.
>
> [...]
>
> > +#include <linux/list.h>
> > +#include <linux/slab.h>
> > +
> > +struct bpf_prog;
> > +struct bpf_prog_array;
> > +struct hid_device;
> > +
> > +enum bpf_hid_attach_type {
> > +       BPF_HID_ATTACH_INVALID = -1,
> > +       BPF_HID_ATTACH_DEVICE_EVENT = 0,
> > +       MAX_BPF_HID_ATTACH_TYPE
>
> Is it typical to have different BPF programs for different attach types?
> Otherwise, (different types may have similar BPF programs), maybe
> we can pass type as an argument to the program (shared among
> different types)?

Not quite sure I am entirely following you, but I consider the various
attach types to be quite different and thus you can not really reuse
the same BPF program with 2 different attach types.

In my view, we have 4 attach types:
- BPF_HID_ATTACH_DEVICE_EVENT: called whenever we receive an IRQ from
the given device (so this is net-like event stream)
- BPF_HID_ATTACH_RDESC_FIXUP: there can be only one of this type, and
this is called to change the device capabilities. So you can not reuse
the other programs for this one
- BPF_HID_ATTACH_USER_EVENT: called explicitly by the userspace
process owning the program. There we can use functions that are
sleeping (we are not in IRQ context), so this is also fundamentally
different from the 3 others.
- BPF_HID_ATTACH_DRIVER_EVENT: whenever the driver gets called into,
we get a bpf program run. This can be suspend/resume, or even specific
request to the device (change a feature on the device or get its
current state). Again, IMO fundamentally different from the others.

So I'm open to any suggestions, but if we can keep the userspace API
being defined with different SEC in libbpf, that would be the best.

>
> [...]
>
> > +struct hid_device;
> > +
> > +enum hid_bpf_event {
> > +       HID_BPF_UNDEF = 0,
> > +       HID_BPF_DEVICE_EVENT,           /* when attach type is BPF_HID_DEVICE_EVENT */
> > +};
> > +
> > +struct hid_bpf_ctx {
> > +       enum hid_bpf_event type;        /* read-only */
> > +       __u16 allocated_size;           /* the allocated size of data below (RO) */
>
> There is a (6-byte?) hole here.
>
> > +       struct hid_device *hdev;        /* read-only */
> > +
> > +       __u16 size;                     /* used size in data (RW) */
> > +       __u8 data[];                    /* data buffer (RW) */
> > +};
>
> Do we really need hit_bpf_ctx in uapi? Maybe we can just use it
> from vmlinuxh?

I had a thought at this context today, and I think I am getting to the
limit of what I understand.

My first worry is that the way I wrote it there, with a variable data
field length is that this is not forward compatible. Unless BTF and
CORE are making magic, this will bite me in the long run IMO.

But then, you are talking about not using uapi, and I am starting to
wonder: am I doing the things correctly?

To solve my first issue (and the weird API I had to introduce in the
bpf_hid_get/set_data), I came up to the following:
instead of exporting the data directly in the context, I could create
a helper bpf_hid_get_data_buf(ctx, const uint size) that returns a
RET_PTR_TO_ALLOC_MEM_OR_NULL in the same way bpf_ringbuf_reserve()
does.

This way, I can directly access the fields within the bpf program
without having to worry about the size.

But now, I am wondering whether the uapi I defined here is correct in
the way CORE works.

My goal is to have HID-BPF programs to be CORE compatible, and not
have to recompile them depending on the underlying kernel.

I can not understand right now if I need to add some other BTF helpers
in the same way the access to struct xdp_md and struct xdp_buff are
converted between one and other, or if defining a forward compatible
struct hid_bpf_ctx is enough.
As far as I understand, .convert_ctx_access allows to export a stable
uapi to the bpf prog users with the verifier doing the conversion
between the structs for me. But is this really required for all the
BPF programs if we want them to be CORE?

Also, I am starting to wonder if I should not hide fields in the
context to the users. The .data field could be a pointer and only
accessed through the helper I mentioned above. This would be forward
compatible, and also allows to use whatever available memory in the
kernel to be forwarded to the BPF program. This way I can skip the
memcpy part and work directly with the incoming dma data buffer from
the IRQ.

But is it best practice to do such a thing?

Cheers,
Benjamin

>
> [...]
>
> > +
> > +static bool hid_is_valid_access(int off, int size,
> > +                               enum bpf_access_type access_type,
> > +                               const struct bpf_prog *prog,
> > +                               struct bpf_insn_access_aux *info)
> > +{
> > +       /* everything not in ctx is prohibited */
> > +       if (off < 0 || off + size > sizeof(struct hid_bpf_ctx) + HID_BPF_MIN_BUFFER_SIZE)
> > +               return false;
>
> Mabe add the following here to fail unaligned accesses
>
>         if (off % size != 0)
>                 return false;
> [...]
>

