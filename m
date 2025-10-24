Return-Path: <linux-kselftest+bounces-43974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DEFC066DE
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 15:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5673B5F85
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 13:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D326E31A055;
	Fri, 24 Oct 2025 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Dpvtp3tw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC5A2C21EF
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761311517; cv=none; b=eURJqPZcSXX6ni8ji3tijY08dXbWL9IzKcUZTbCD15jPgrbmq/chbBzYGifoEoZ+inskHIlsbW/b91gK09JVwpIgqZNdIlItlX6up4xgzOnnXZvsJ5Dz9t71lbUeVbxY3THe2GNCzVTAN8OmFnRFvQgqMsrFlCnRqKsj1yqm3II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761311517; c=relaxed/simple;
	bh=FBFWpbkWMfdI/FNRU+A05kTFz8RxRqNbG4E+qckZ8ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HacH2PIVW8SdIEbfAbqcQreQ1mI846Ter8JgarNuqQf6pkfdMHdSWfP2hFnUC7e3dBn9yqNkypg+J64pRqW95jnn4jucAH+TacL9MpzW4NgjlxKzBsJeP1wlkID2BLjDBSsLHVP1l176bpFhaQCSWrzvZZsTC0bY3K/89coO4ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Dpvtp3tw; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63e0cec110eso3498522a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 06:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761311514; x=1761916314; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HUFjBoOvLfPTJUpNwq8FsuiPCzN1aQ2yq2Ml6/Jyk1k=;
        b=Dpvtp3tw4ex0ZbN6BjVWT02sYn/uiKMHnUzmD9GvvQJif9789d2iMrRVgZ26T0JUWy
         25fErwaGITN0vGmcbWZ8VDCH4vI+nCqs/YLStBV7sFi/JNbY+/ZP5IBkr2vvvTnlpPe0
         SvtfdfsAsU9sfJeW7Dij78Rmc5azz/DwTIOqiT/3Wmv6DOicYgytEAZtyJnkp7swoGob
         uwQupTx5l/kHtnp9rAO0Dqc+wVy6ZZ37OZpeYxxS0ZDbba2FXtS2364eUXjy+ETI3aLF
         cbypSUCWJN0kpGn/5sYMBGVqhxGQVNon+5Ce9jLRG0BmHyHKg605zmlq0vraVUo9hp6B
         nz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761311514; x=1761916314;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HUFjBoOvLfPTJUpNwq8FsuiPCzN1aQ2yq2Ml6/Jyk1k=;
        b=s/sWKwi8qmRwhti3u5b6+eAxqkqPvMU1BrjDrE9ki9QRofxmHh805L+/gt130bjDkJ
         wB+rcpE5HABg88A7B0UW3bXNJ2l9ckpnlo4Cb4Brgy7LMmmet2paOHpyEWlKCkcIiedc
         VwhPdpxJi5WChIVAAX8q2JooMhYfTSbnwh+T2c1RfjKLLBt0/ymMfuHvQJBl7V1pDtzB
         18jTHVbtNUe/q2wHSsVt4iqpyxR0vdWXVQy2VxGa4/2sjvYQh08LJVzgsjWL94OgA3QA
         TCG1QpDzi3YXXFUmz+v08GvNmbTwHCXB7Bseo9w3dV4YUCLhoQZuNHQvLIEHxpXxyZZh
         uo9g==
X-Forwarded-Encrypted: i=1; AJvYcCUJ96ZX9aKE+TZY7g9AA6QRVtdeDB7LVz+S4Dm8kxnRy2lu4hAk2qjjzj2Iy5wKcL6mxXLNwipRIDQzbaF9yn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyNBOoqE/wG9DBdVyMyPOEDRAwwHWo/WAxF61cnFXSgJFOUGbw
	0oMoUEm6cJVOLyVEY1uuArb6oavyp222VwzZUCdix6HbeOcciB4dqIK1om7PxvGAXYtMysNqYKH
	3eceOVFfOmMhQiu8deHvwErM1FIPiCBCRImiVMWAJuabuwkaGrl4Q
X-Gm-Gg: ASbGncveSwl43AJ61w3Zx/pkM+0gp2ApU4d1gkbkTiwtejkfvFpDaP9nWRyDGUusI3s
	4iyrEDiKf/0UAemmvtTHcQoiHR74JgwaRCJTHK2L1e2nJU2ZR+Xe8a3XdMVRVHtVNNdVpSNpI0Q
	HvO29G0mRZcPTU5kg6s3ISHIskeIR+qfnCXxIzdZmPFDlG2gRffUsPOzsUAKd0Qv9QcWXGPgoVi
	wNb4WUyClAr55Nx2rCZ8GgMxY7Jd/IdP2shvHHRYIDxvP0P6mco0XhsFw==
X-Google-Smtp-Source: AGHT+IH9rsE8M2MY/COIAjepb78sZJfunMk8EVwR7yVf5O/90QQr0+6a+OVf7DIz8KsKgykJe6HVYhzJZDMVC3FYg8s=
X-Received: by 2002:aa7:c958:0:b0:636:a789:beb9 with SMTP id
 4fb4d7f45d1cf-63c1f6dc078mr18925767a12.37.1761311513782; Fri, 24 Oct 2025
 06:11:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
 <20251022005719.3670224-4-pasha.tatashin@soleen.com> <mafs0ikg7fbez.fsf@kernel.org>
In-Reply-To: <mafs0ikg7fbez.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 24 Oct 2025 09:11:16 -0400
X-Gm-Features: AWmQ_bn6L1OcjOCSKybf_c3mHT-I2GiF2haRrAMI3CbUcf4To6YoULyp-vpHjEg
Message-ID: <CA+CK2bDrrg0UoJXpeN+Au2-sreYrZ+DHVcEUidzPw2Qk60orgg@mail.gmail.com>
Subject: Re: [PATCHv7 3/7] kho: drop notifiers
To: Pratyush Yadav <pratyush@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

> > -int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt)
> > +int kho_add_subtree(const char *name, void *fdt)
> >  {
> > -     int err = 0;
> > -     u64 phys = (u64)virt_to_phys(fdt);
> > -     void *root = page_to_virt(ser->fdt);
> > +     struct kho_sub_fdt *sub_fdt;
> > +     int err;
> >
> > -     err |= fdt_begin_node(root, name);
> > -     err |= fdt_property(root, PROP_SUB_FDT, &phys, sizeof(phys));
> > -     err |= fdt_end_node(root);
> > +     sub_fdt = kmalloc(sizeof(*sub_fdt), GFP_KERNEL);
> > +     if (!sub_fdt)
> > +             return -ENOMEM;
> >
> > -     if (err)
> > -             return err;
> > +     INIT_LIST_HEAD(&sub_fdt->l);
> > +     sub_fdt->name = name;
> > +     sub_fdt->fdt = fdt;
> >
> > -     return kho_debugfs_fdt_add(&kho_out.dbg, name, fdt, false);
> > +     mutex_lock(&kho_out.fdts_lock);
> > +     list_add_tail(&sub_fdt->l, &kho_out.sub_fdts);
> > +     err = kho_debugfs_fdt_add(&kho_out.dbg, name, fdt, false);
>
> I think you should remove sub_fdt from the list and kfree() it on error
> here. Otherwise we signal an error to the caller and they might free
> sub_fdt->fdt, which will later result in a use-after-free at
> __kho_finalize().

I think, it is better to simply do:
WARN_ON_ONCE(kho_debugfs_fdt_add(...));
Now debugfs is optional, and there is no reason to return an error to
a caller if kho_debugfs_fdt_add() fails

>
> > +     mutex_unlock(&kho_out.fdts_lock);
> > +
> > +     return err;
> >  }
> >  EXPORT_SYMBOL_GPL(kho_add_subtree);
> >
> > -int register_kho_notifier(struct notifier_block *nb)
> > +void kho_remove_subtree(void *fdt)
> >  {
> > -     return blocking_notifier_chain_register(&kho_out.chain_head, nb);
> > -}
> > -EXPORT_SYMBOL_GPL(register_kho_notifier);
> > +     struct kho_sub_fdt *sub_fdt;
> > +
> > +     mutex_lock(&kho_out.fdts_lock);
> > +     list_for_each_entry(sub_fdt, &kho_out.sub_fdts, l) {
>
> list_for_each_entry_safe() here since we delete.

Not needed, we are breaking from the iterator when deleting.


> >  bool kho_finalized(void)
> > @@ -1232,15 +1248,17 @@ static __init int kho_init(void)
> >  {
> >       int err = 0;
> >       const void *fdt = kho_get_fdt();
> > +     struct page *fdt_page;
> >
> >       if (!kho_enable)
> >               return 0;
> >
> > -     kho_out.ser.fdt = alloc_page(GFP_KERNEL);
> > -     if (!kho_out.ser.fdt) {
> > +     fdt_page = alloc_page(GFP_KERNEL);
> > +     if (!fdt_page) {
> >               err = -ENOMEM;
> >               goto err_free_scratch;
> >       }
> > +     kho_out.fdt = page_to_virt(fdt_page);
> >
> >       err = kho_debugfs_init();
> >       if (err)
> > @@ -1268,8 +1286,8 @@ static __init int kho_init(void)
> >       return 0;
> >
> >  err_free_fdt:
> > -     put_page(kho_out.ser.fdt);
> > -     kho_out.ser.fdt = NULL;
> > +     put_page(fdt_page);
> > +     kho_out.fdt = NULL;
> >  err_free_scratch:
> >       for (int i = 0; i < kho_scratch_cnt; i++) {
> >               void *start = __va(kho_scratch[i].addr);
> > @@ -1280,7 +1298,7 @@ static __init int kho_init(void)
> >       kho_enable = false;
> >       return err;
> >  }
> > -late_initcall(kho_init);
> > +fs_initcall(kho_init);
>
> Is this change related to this patch? Also, why fs_initcall?
>
> >
> >  static void __init kho_release_scratch(void)
> >  {
> > @@ -1416,7 +1434,7 @@ int kho_fill_kimage(struct kimage *image)
> >       if (!kho_out.finalized)
> >               return 0;
> >
> > -     image->kho.fdt = page_to_phys(kho_out.ser.fdt);
> > +     image->kho.fdt = virt_to_phys(kho_out.fdt);
> >
> >       scratch_size = sizeof(*kho_scratch) * kho_scratch_cnt;
> >       scratch = (struct kexec_buf){
> > diff --git a/kernel/kexec_handover_debugfs.c b/kernel/kexec_handover_debugfs.c
> > index a91b279f1b23..46e9e6c0791f 100644
> > --- a/kernel/kexec_handover_debugfs.c
> > +++ b/kernel/kexec_handover_debugfs.c
> > @@ -61,14 +61,17 @@ int kho_debugfs_fdt_add(struct kho_debugfs *dbg, const char *name,
> >       return __kho_debugfs_fdt_add(&dbg->fdt_list, dir, name, fdt);
> >  }
> >
> > -void kho_debugfs_cleanup(struct kho_debugfs *dbg)
> > +void kho_debugfs_fdt_remove(struct kho_debugfs *dbg, void *fdt)
> >  {
> > -     struct fdt_debugfs *ff, *tmp;
> > -
> > -     list_for_each_entry_safe(ff, tmp, &dbg->fdt_list, list) {
> > -             debugfs_remove(ff->file);
> > -             list_del(&ff->list);
> > -             kfree(ff);
> > +     struct fdt_debugfs *ff;
> > +
> > +     list_for_each_entry(ff, &dbg->fdt_list, list) {
>
> list_for_each_entry_safe() here too.

Not needed, we are breaking out on delete/free.


> >  static int kho_test_save_data(struct kho_test_state *state, void *fdt)
> >  {
> >       phys_addr_t *folios_info __free(kvfree) = NULL;
> > @@ -102,6 +86,9 @@ static int kho_test_save_data(struct kho_test_state *state, void *fdt)
> >       if (!err)
> >               state->folios_info = no_free_ptr(folios_info);
> >
> > +     if (!err)
> > +             err = kho_test();
>
> This name is very undescriptive. Also, not the right place to add the
> subtree since the FDT isn't finished yet. I think it should be done from
> kho_test_save() instead. This patch is also missing removing the subtree
> at exit, and that can cause a UAF.
>
> I sent you a patch earlier with my take on how it should be done. I
> still think that is the way to go:
> https://lore.kernel.org/all/mafs0347woui2.fsf@kernel.org/

Sure, I updated to use your suggested changes.

