Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384944D675F
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Mar 2022 18:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350655AbiCKRSG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Mar 2022 12:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350733AbiCKRSC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Mar 2022 12:18:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F57A1CCB25
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Mar 2022 09:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647019016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=frwFvW2tLrfwUW5MlUItxAYVS1OlBuCXSXlaKG/ZWrY=;
        b=D7t2NDgIwBAscg9E+P9qzcalwvUCekev5uGdlObxChDQ73PO67yZz8qJWomVE/CYFG0Jdq
        OEXxyMvlw7ZYadqwxXZ3I/87+gOIUTNXcQIu762KbH6H/H/0CRWEUH0/cBxPfPoNhoJmim
        DpQgBgLRfSUrkA7mt/UTEqSvsq0e3G0=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-6etXDwYqMU-iNVUmrcGI5w-1; Fri, 11 Mar 2022 12:16:55 -0500
X-MC-Unique: 6etXDwYqMU-iNVUmrcGI5w-1
Received: by mail-pf1-f198.google.com with SMTP id k130-20020a628488000000b004f362b45f28so5554513pfd.9
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Mar 2022 09:16:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=frwFvW2tLrfwUW5MlUItxAYVS1OlBuCXSXlaKG/ZWrY=;
        b=AwvZiD9Fd+n3BxwKbhOh/WEmxoCpw4RNr2Uk/fMP5n0OSRyQy81VXhWJZITj+U7aaw
         7d3hRXz8fJQdJ+h9msKk7A+FHeNgRMAY4WPcAkHg/q8Hh4BiDNeQilDii4mO4qWdJNxW
         gWkVwuXAYcuKIaQeqOVIQX2itetzgRy52sTK2dqDMskuJ5+0AJjuwZIdxNsDVxdCW1w7
         UyLbsaeeSsGffobszBgi9ghU0pgx/a605u2TMmECP3rVA03Tz7c+O9jbuxAypAiNFc4a
         09hcN9NxuP7kDV7O6oax/udmRp6nvpNVVcdHdnrgEbRfNI5V1Qj3HswY5nkLcjmzZxvM
         Ah9Q==
X-Gm-Message-State: AOAM533XS7Y2fR/ZkUVrh0aHkUKY6TmR3kA33sG+YP7gwtFXeavYfdKR
        puiSduhyza5wVca/Ik8EmklzHFL/U6GmHetVkLEzsigrRkhRhoWDs4Mpj+cHDhxSFRroWuK7XL1
        akyouYlyBIxeB6Raqhbxwgb2Eh1mE+i+yDe2aqO0OlDqN
X-Received: by 2002:a05:6a00:781:b0:4f4:2a:2d89 with SMTP id g1-20020a056a00078100b004f4002a2d89mr11163639pfu.13.1647019014137;
        Fri, 11 Mar 2022 09:16:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzPh5TEv/N8dkshOhalRMOWLJrT3ebEgXJmia3lDbjepQA4T4UD7accir427L3UKac1apLvpE0byE6hTlKuywg=
X-Received: by 2002:a05:6a00:781:b0:4f4:2a:2d89 with SMTP id
 g1-20020a056a00078100b004f4002a2d89mr11163607pfu.13.1647019013797; Fri, 11
 Mar 2022 09:16:53 -0800 (PST)
MIME-Version: 1.0
References: <20220304172852.274126-1-benjamin.tissoires@redhat.com>
 <20220304172852.274126-3-benjamin.tissoires@redhat.com> <CAPhsuW5CYF9isR4ffRdm3xA_n_FBoL+AGFkzNn4dn2LgRaQQkg@mail.gmail.com>
 <CAO-hwJKFE4Ps962BBubn8=1K0k9mC2qi8VerFbZo1sqpp6yekg@mail.gmail.com>
 <CAPhsuW5mZQ-N7RCndxP0RNi669RU5Tbu-Uu0M-KW2-mPYZbbng@mail.gmail.com> <CAO-hwJ+_aZDdKguze-BC+Ok9=HccAYSUFrNJmQBZfX3oufRGUQ@mail.gmail.com>
In-Reply-To: <CAO-hwJ+_aZDdKguze-BC+Ok9=HccAYSUFrNJmQBZfX3oufRGUQ@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 11 Mar 2022 18:16:42 +0100
Message-ID: <CAO-hwJJqP5iivQZOu0LTYa1D5OuM_aVi=LH27Udc_VYkbFsrww@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 8, 2022 at 10:20 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Tue, Mar 8, 2022 at 1:57 AM Song Liu <song@kernel.org> wrote:
> >
> > On Mon, Mar 7, 2022 at 10:39 AM Benjamin Tissoires
> > <benjamin.tissoires@redhat.com> wrote:
> > >
> > > On Sat, Mar 5, 2022 at 1:03 AM Song Liu <song@kernel.org> wrote:
> > > >
> > > > On Fri, Mar 4, 2022 at 9:31 AM Benjamin Tissoires
> > > > <benjamin.tissoires@redhat.com> wrote:
> > > > >
[...]
> > > > > +struct hid_bpf_ctx {
> > > > > +       enum hid_bpf_event type;        /* read-only */
> > > > > +       __u16 allocated_size;           /* the allocated size of data below (RO) */
> > > >
> > > > There is a (6-byte?) hole here.
> > > >
> > > > > +       struct hid_device *hdev;        /* read-only */
> > > > > +
> > > > > +       __u16 size;                     /* used size in data (RW) */
> > > > > +       __u8 data[];                    /* data buffer (RW) */
> > > > > +};
> > > >
> > > > Do we really need hit_bpf_ctx in uapi? Maybe we can just use it
> > > > from vmlinuxh?
> > >
> > > I had a thought at this context today, and I think I am getting to the
> > > limit of what I understand.
> > >
> > > My first worry is that the way I wrote it there, with a variable data
> > > field length is that this is not forward compatible. Unless BTF and
> > > CORE are making magic, this will bite me in the long run IMO.
> > >
> > > But then, you are talking about not using uapi, and I am starting to
> > > wonder: am I doing the things correctly?
> > >
> > > To solve my first issue (and the weird API I had to introduce in the
> > > bpf_hid_get/set_data), I came up to the following:
> > > instead of exporting the data directly in the context, I could create
> > > a helper bpf_hid_get_data_buf(ctx, const uint size) that returns a
> > > RET_PTR_TO_ALLOC_MEM_OR_NULL in the same way bpf_ringbuf_reserve()
> > > does.
> > >
> > > This way, I can directly access the fields within the bpf program
> > > without having to worry about the size.
> > >
> > > But now, I am wondering whether the uapi I defined here is correct in
> > > the way CORE works.
> > >
> > > My goal is to have HID-BPF programs to be CORE compatible, and not
> > > have to recompile them depending on the underlying kernel.
> > >
> > > I can not understand right now if I need to add some other BTF helpers
> > > in the same way the access to struct xdp_md and struct xdp_buff are
> > > converted between one and other, or if defining a forward compatible
> > > struct hid_bpf_ctx is enough.
> > > As far as I understand, .convert_ctx_access allows to export a stable
> > > uapi to the bpf prog users with the verifier doing the conversion
> > > between the structs for me. But is this really required for all the
> > > BPF programs if we want them to be CORE?
> > >
> > > Also, I am starting to wonder if I should not hide fields in the
> > > context to the users. The .data field could be a pointer and only
> > > accessed through the helper I mentioned above. This would be forward
> > > compatible, and also allows to use whatever available memory in the
> > > kernel to be forwarded to the BPF program. This way I can skip the
> > > memcpy part and work directly with the incoming dma data buffer from
> > > the IRQ.
> > >
> > > But is it best practice to do such a thing?
> >
> > I think .convert_ctx_access is the way to go if we want to access the data
> > buffer without memcpy. I am not sure how much work is needed to make
> > it compatible with CORE though.

I spent the week working on that, and I am really amazed at how smart
and simple the .convert_ctx_access is working.

With that in place, I can hide the internal fields and export
"virtual" public fields that are remapped on the fly by the kernel at
load time :)

> >
> > To make sure I understand the case, do we want something like
> >
> > bpf_prog(struct hid_bpf_ctx *ctx)
> > {
> >     /* makes sure n < ctx->size */
> >     x = ctx->data[n]; /* read data */
> >     ctx->data[n] = <something>; /* write data */
> >     ctx->size = <something <= n>; /* change data size */
> > }
> >
> > We also need it to be CORE, so that we may modify hid_bpf_ctx by
> > inserting more members to it before data.
> >
> > Is this accurate?
> >

I have been trying to implement that, based on the PTR_TO_PACKET implementation.
It works, but is kind of verbose while using it because we need to
teach the verifier about the size of the arrays.

For instance, I have the following:

int bpf_prog(struct hid_bpf_ctx *ctx)
{
  /* we need to store a pointer on the stack to store its accessible size */
  __u8 *data = ctx->data;

  if (data + 3 > ctx->data_end)
    return 0; /* EPERM, bounds check */

  data[1] = data[0] + 3;

  return 0;
}

This is OK, but it gets worse if I want to access a random offset:

__s64 offset = 0;
int bpf_prog(struct hid_bpf_ctx *ctx)
{
  __u8 *data = ctx->data;
  __u16 *x;

  /* first assign the size of data */
  if (data + 4 > ctx->data_end)
    return 0; /* EPERM, bounds check */

  /* teach the verifier the range of offset (needs to be a s64) */
  if (offset >= 0 && offset < 2) {
    x = (__u16 *)&data[offset];

    /* now store the size of x in its register */
    if (x + 2 > ctx->data_end)
      return 0;

    /* finally we can read/write the data */
    *x += 1;
  }

  return 0;
}

OTOH, I managed to define a simpler helper that allows me to return a
pointer to the internal data:

BPF_CALL_3(bpf_hid_get_data, struct hid_bpf_ctx_kern*, ctx, u64,
offset, u64, size)
  {
          if (!size)
                  return (unsigned long)0;

          if (offset + size > ctx->data_end - ctx->data)
                  return (unsigned long)0;

          return (unsigned long)(ctx->data + offset);
  }

  static const struct bpf_func_proto bpf_hid_get_data_proto = {
          .func      = bpf_hid_get_data,
          .gpl_only  = true,
          .ret_type  = RET_PTR_TO_ALLOC_MEM_OR_NULL,
          .arg1_type = ARG_PTR_TO_CTX,
          .arg2_type = ARG_ANYTHING,
          .arg3_type = ARG_CONST_ALLOC_SIZE_OR_ZERO,
  };

 Which makes the previous bpf code into:

__u64 offset = 0;
int bpf_prog(struct hid_bpf_ctx *ctx)
{
  __u16 *x = bpf_hid_get_data(ctx, offset, 2);

  if (!x)
    return 0; /* EPERM, bounds check */

  *x += 1;

  return 0;
}

The advantage of both of those solutions is that they are removing the
need for bpf_hid_{get|set}_bytes().

The second solution is much simpler in terms of usage, but it doesn't
feel "right" to have to reimplement the wheel when we should have
direct array accesses.
OTOH, the first solution with the packet implementation is bulky and
requiring users to do that for every single access of the data is IMO
way too much...

Any thoughts?

Cheers,
Benjamin

