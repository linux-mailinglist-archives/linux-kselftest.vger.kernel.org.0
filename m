Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE72577DC5
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Jul 2022 10:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbiGRImh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Jul 2022 04:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbiGRImf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Jul 2022 04:42:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE85119C05
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Jul 2022 01:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658133752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jGouTsNv1lisIVuwecS9yzguYrksQ4eFIjfFj4TU4q0=;
        b=XbmJj2DXrJiZ43za/ZrcoBwZDpUkaW03ul6l7j2FN7093G/g7tHdfUUNxbO0NODx8YfGkt
        xEV7ViRE9aQOyNLEZgurH9UV7mlmkGyTjRDGtyU+IEARyXmCNur7U1GJofbT92aZAbmfFM
        DlZHe+ge2WTB549ZIgPTF6uSFcvRjxE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-vULWJj0tPGOthuJOGGSQJg-1; Mon, 18 Jul 2022 04:42:26 -0400
X-MC-Unique: vULWJj0tPGOthuJOGGSQJg-1
Received: by mail-pl1-f198.google.com with SMTP id p10-20020a170902e74a00b0016c3f3acb51so6414423plf.16
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Jul 2022 01:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jGouTsNv1lisIVuwecS9yzguYrksQ4eFIjfFj4TU4q0=;
        b=rO337jiupzm7RyfoNdrUyxJiZLWp4z93hCrb1VkuujH/I4Mr2M/2nUkAIFL4YBp2L/
         jykxPLiTsIe25xnxOvIr5iVy7v1lKBA0u7wr+YlQL6M103hTT8ZqoWqnzIXLQAZgSmOg
         HLy6hAANpajR7QvN+V1fiECvnU45t/9yrNMj5hrqt1llyzYx1VWV4GNtjNIvmbmFzwSK
         gKPEpudbQ71I14WFqYA48KkfvNx1hpbXPUIFzmBVdw3oTBja1kmD75WWTgYjSX6z4K09
         DWxWKgxbFwCJVKp/vUKmDaLYmgIciF9pvllG2k3C0grBy1UP4LUssf/tiz3PVI8oqXSs
         tskQ==
X-Gm-Message-State: AJIora9JcLb8xo3uXLTtynzf8r4DhGDDYz8sUmmUB5uFaw7XEpQfn7Nr
        D+AkpYb1zrxREDMBPzKyP1Y6ptY/GJm/ZLOhYxwr9+Pm8YRrEvk+cHqIbF0ysGTebzi2Nge3ORl
        DJFwChXvO86DJpEgKcuYKgvbolvIMencYtp8S6157x9D7
X-Received: by 2002:a17:90b:3c0c:b0:1ef:e647:ff48 with SMTP id pb12-20020a17090b3c0c00b001efe647ff48mr37022225pjb.173.1658133744859;
        Mon, 18 Jul 2022 01:42:24 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uQCNjvoDfxIqziZqYdDHzUlMEZYuKMP4alAW7pp2XL/lSwJYhrCgB6FbdmGe7ipEOiFq4GD15BG6v9tre5yow=
X-Received: by 2002:a17:90b:3c0c:b0:1ef:e647:ff48 with SMTP id
 pb12-20020a17090b3c0c00b001efe647ff48mr37022193pjb.173.1658133744537; Mon, 18
 Jul 2022 01:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220712145850.599666-1-benjamin.tissoires@redhat.com>
 <20220712145850.599666-7-benjamin.tissoires@redhat.com> <bf56b01d-4c05-0d0b-e85b-219e55606803@fb.com>
In-Reply-To: <bf56b01d-4c05-0d0b-e85b-219e55606803@fb.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 18 Jul 2022 10:42:13 +0200
Message-ID: <CAO-hwJJirS9S8TU9NMXhjmaTeL9PNxeQBg0oT3zLdd63uDp74g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 06/23] selftests/bpf: Add tests for kfunc
 returning a memory pointer
To:     Yonghong Song <yhs@fb.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
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
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jul 16, 2022 at 6:34 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 7/12/22 7:58 AM, Benjamin Tissoires wrote:
> > We add 2 new kfuncs that are following the RET_PTR_TO_MEM
> > capability from the previous commit.
> > Then we test them in selftests:
> > the first tests are testing valid case, and are not failing,
> > and the later ones are actually preventing the program to be loaded
> > because they are wrong.
> >
> > To work around that, we mark the failing ones as not autoloaded
> > (with SEC("?tc")), and we manually enable them one by one, ensuring
> > the verifier rejects them.
> >
> > To be able to use bpf_program__set_autoload() from libbpf, we need
> > to use a plain skeleton, not a light-skeleton, and this is why we
> > also change the Makefile to generate both for kfunc_call_test.c
> >
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >
> > ---
> >
> > new in v6
> > ---
> >   include/linux/btf.h                           |  4 +-
> >   net/bpf/test_run.c                            | 22 +++++
> >   tools/testing/selftests/bpf/Makefile          |  5 +-
> >   .../selftests/bpf/prog_tests/kfunc_call.c     | 48 ++++++++++
> >   .../selftests/bpf/progs/kfunc_call_test.c     | 89 +++++++++++++++++++
> >   5 files changed, 165 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > index 31da4273c2ec..6f46ff2128ae 100644
> > --- a/include/linux/btf.h
> > +++ b/include/linux/btf.h
> > @@ -422,7 +422,9 @@ static inline int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dt
> >
> >   static inline bool btf_type_is_struct_ptr(struct btf *btf, const struct btf_type *t)
> >   {
> > -     /* t comes in already as a pointer */
> > +     if (!btf_type_is_ptr(t))
> > +             return false;
>
> Why we have a change here?

Definitely a mistake while fixing/rebasing the series.

Will bring this hunk in the previous patch in the next revision.

Thanks for the review!

Cheers,
Benjamin

>
> > +
> >       t = btf_type_by_id(btf, t->type);
> >
> >       /* allow const */
> > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > index 9da2a42811e8..0b4026ea4652 100644
> > --- a/net/bpf/test_run.c
> > +++ b/net/bpf/test_run.c
> > @@ -606,6 +606,24 @@ noinline void bpf_kfunc_call_memb1_release(struct prog_test_member1 *p)
> >       WARN_ON_ONCE(1);
> >   }
> >
> > +static int *__bpf_kfunc_call_test_get_mem(struct prog_test_ref_kfunc *p, const int size)
> > +{
> > +     if (size > 2 * sizeof(int))
> > +             return NULL;
> > +
> > +     return (int *)p;
> > +}
> > +
> > +noinline int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p, const int rdwr_buf_size)
> > +{
> > +     return __bpf_kfunc_call_test_get_mem(p, rdwr_buf_size);
> > +}
> > +
> > +noinline int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size)
> > +{
> > +     return __bpf_kfunc_call_test_get_mem(p, rdonly_buf_size);
> > +}
> > +
> >   noinline struct prog_test_ref_kfunc *
> >   bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **pp, int a, int b)
> >   {
> > @@ -704,6 +722,8 @@ BTF_ID(func, bpf_kfunc_call_memb_acquire)
> >   BTF_ID(func, bpf_kfunc_call_test_release)
> >   BTF_ID(func, bpf_kfunc_call_memb_release)
> >   BTF_ID(func, bpf_kfunc_call_memb1_release)
> > +BTF_ID(func, bpf_kfunc_call_test_get_rdwr_mem)
> > +BTF_ID(func, bpf_kfunc_call_test_get_rdonly_mem)
> >   BTF_ID(func, bpf_kfunc_call_test_kptr_get)
> >   BTF_ID(func, bpf_kfunc_call_test_pass_ctx)
> >   BTF_ID(func, bpf_kfunc_call_test_pass1)
> > @@ -731,6 +751,8 @@ BTF_SET_END(test_sk_release_kfunc_ids)
> >   BTF_SET_START(test_sk_ret_null_kfunc_ids)
> >   BTF_ID(func, bpf_kfunc_call_test_acquire)
> >   BTF_ID(func, bpf_kfunc_call_memb_acquire)
> > +BTF_ID(func, bpf_kfunc_call_test_get_rdwr_mem)
> > +BTF_ID(func, bpf_kfunc_call_test_get_rdonly_mem)
> >   BTF_ID(func, bpf_kfunc_call_test_kptr_get)
> >   BTF_SET_END(test_sk_ret_null_kfunc_ids)
> >
> [...]
>

