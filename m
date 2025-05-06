Return-Path: <linux-kselftest+bounces-32526-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9FFAACDF6
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 21:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72AC216D76C
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 19:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E971EA7DD;
	Tue,  6 May 2025 19:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uUaswSTJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF67195FE8
	for <linux-kselftest@vger.kernel.org>; Tue,  6 May 2025 19:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746559371; cv=none; b=BGzykf/iINrw7u+waYPAheAyaV0TqjhgMpkyxTraIiRAwtkQ418QrX6J88AXa6bQ/tHurzVP2Be8132/gVtCx6t6WV0r4vZj6Qhf59FJGByZHg5/pRHAtDrh+w+tgk/VXmHSIq1qRKkXR5Grw9shF0fwDmzG0U8fOsmS14EsEew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746559371; c=relaxed/simple;
	bh=adViIxT4K+8OILyTBF/w5gsHiQUH4RC4i3QZNQkAnEE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ysj4wO+6B/YnJC2FA3Wwl12tYxuWwGA86eLqxZM4oazgNUgBcIv3J6Cpng7Vt1n7roaDq42J2LMM3oNMLHrvE1PXMEJbXmXCK9jyIvrZk5r3IyL5bJIOBi7aq5NP6NTB3o05tsrwWh5DaHSr2YC+N+frXy/ROyz2BXDWH1ebKkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uUaswSTJ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-73dcce02a5cso3572691b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 06 May 2025 12:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746559369; x=1747164169; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YdVfAUAmDEBQ8JFX7fJFifwcWORGf91hOm42i7pODPI=;
        b=uUaswSTJjmb1FQo3fau9BMJ+wOuLnRKen5mr6LtEv4UH1TYO5KySFZgUoF6vYRC7Ho
         5SCmkOFM18Jqv6a8Eo4CqE671a9RU15WqQBqHN18jMnk+s7s8qK1b1yu6VSxAahL73OA
         nyBaiXXapSnK2j/P3XUJ12c1Ulz1WIXS3RScjfCAbpmMC02pjR4RRCMvoAmHjn3V1JQB
         3FhQ9fWzJjons3hGUFGYIxPQPUIOCi26kAWUyPq7ByhGXanFNBRAKUkRyVnwow5Z4mCs
         ZB7ugRkPCtqOnWrFZOVLfQUuAy86fEvg8cLTz3QGNSGL5lmaRJqnRh8rI57mHWObise9
         9GsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746559369; x=1747164169;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YdVfAUAmDEBQ8JFX7fJFifwcWORGf91hOm42i7pODPI=;
        b=n5xfC8tdOyNSyz6i3MzpWp54+TBUVkLJxxE26SJT7WA9XncL1SK2WJIzxjN/tEASIp
         zRlFOMyReSxbt9/6X7IPgVkCuPMD6aoYK/2O1boMnc33pUIE+ltKGx9E2Qk21xwOIQdJ
         ZTsCuDWTsWvJp8QYjRTL7BzvDH5CE/822rduFNaqp2TE3lS5Igcc7QFhMvBsC3EfEKJ6
         WXQJlt7eAwtfixcVhDM1eec2oH4C5oSRTk5R+rAeEF0ehkY6Ljpvk5jhyyWA6q3OrGyo
         eRTjgC+/JLygpNNZOWS5P3O2ll21nfEWTXCBUsYn+YBsRtgsv+b4HmhG5yn+7CZ/ZW0U
         iFPA==
X-Forwarded-Encrypted: i=1; AJvYcCXF8+XRuu1AaJ20+OVcGgCZlLFBO+/vrKSi7WFB5tpCAUom8bPPvSZUauhwwtgOWn6S/P9q0idJ2re6HFzA+3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4O2akSzGqr7JxauUobqzL8+65U10DCzGoxlI3AUR457VCaydl
	o84z8db5nhGHSAlz+xd2TZMNx7HAKJxxWrlFPm3pKelXp7joACciKazL313uVEGMCruqHM0D5/m
	13oxr+nfsioSyOunMdv9iKg==
X-Google-Smtp-Source: AGHT+IF6xVKxxuyEiNYi+0vPcETYSLwUkqiD4tqqqh48d1N2zs7IMgRp17ja4z+L+OzOmL3DebRn7uSN+uZhGnUzFw==
X-Received: from pfcg7.prod.google.com ([2002:a05:6a00:23c7:b0:730:8e17:ed13])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:ab05:b0:730:9946:5973 with SMTP id d2e1a72fcca58-7409cf1e873mr452083b3a.5.1746559369363;
 Tue, 06 May 2025 12:22:49 -0700 (PDT)
Date: Tue, 06 May 2025 12:22:47 -0700
In-Reply-To: <aBlkplRxLNojF4m1@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aA7UXI0NB7oQQrL2@yzhao56-desk.sh.intel.com> <diqz4iy5xvgi.fsf@ackerleytng-ctop.c.googlers.com>
 <aBlkplRxLNojF4m1@yzhao56-desk.sh.intel.com>
Message-ID: <diqz1pt1sfw8.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH 39/39] KVM: guest_memfd: Dynamically split/reconstruct
 HugeTLB page
From: Ackerley Tng <ackerleytng@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: vannapurve@google.com, chenyi.qiang@intel.com, tabba@google.com, 
	quic_eberman@quicinc.com, roypat@amazon.co.uk, jgg@nvidia.com, 
	peterx@redhat.com, david@redhat.com, rientjes@google.com, fvdl@google.com, 
	jthoughton@google.com, seanjc@google.com, pbonzini@redhat.com, 
	zhiquan1.li@intel.com, fan.du@intel.com, jun.miao@intel.com, 
	isaku.yamahata@intel.com, muchun.song@linux.dev, erdemaktas@google.com, 
	qperret@google.com, jhubbard@nvidia.com, willy@infradead.org, 
	shuah@kernel.org, brauner@kernel.org, bfoster@redhat.com, 
	kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org, 
	richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com, 
	ajones@ventanamicro.com, vkuznets@redhat.com, maciej.wieczor-retman@intel.com, 
	pgonda@google.com, oliver.upton@linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Yan Zhao <yan.y.zhao@intel.com> writes:

>> > <snip>
>> >
>> > What options does userspace have in this scenario?
>> > It can't reduce the flag to KVM_GUEST_MEMFD_HUGE_2MB. Adjusting the gmem.pgoff
>> > isn't ideal either.
>> >
>> > What about something similar as below?
>> >
>> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> > index d2feacd14786..87c33704a748 100644
>> > --- a/virt/kvm/guest_memfd.c
>> > +++ b/virt/kvm/guest_memfd.c
>> > @@ -1842,8 +1842,16 @@ __kvm_gmem_get_pfn(struct file *file, struct kvm_memory_slot *slot,
>> >         }
>> >
>> >         *pfn = folio_file_pfn(folio, index);
>> > -       if (max_order)
>> > -               *max_order = folio_order(folio);
>> > +       if (max_order) {
>> > +               int order;
>> > +
>> > +               order = folio_order(folio);
>> > +
>> > +               while (order > 0 && ((slot->base_gfn ^ slot->gmem.pgoff) & ((1 << order) - 1)))
>> > +                       order--;
>> > +
>> > +               *max_order = order;
>> > +       }
>> >
>> >         *is_prepared = folio_test_uptodate(folio);
>> >         return folio;
>> >
>> 
>> Vishal was wondering how this is working before guest_memfd was
>> introduced, for other backing memory like HugeTLB.
>> 
>> I then poked around and found this [1]. I will be adding a similar check
>> for any slot where kvm_slot_can_be_private(slot).
>>
>> Yan, that should work, right?
> No, I don't think the checking of ugfn [1] should work.
>
> 1. Even for slots bound to in-place-conversion guest_memfd (i.e. shared memory
> are allocated from guest_memfd), the slot->userspace_addr does not necessarily
> have the same offset as slot->gmem.pgoff. Even if we audit the offset in
> kvm_gmem_bind(), userspace could invoke munmap() and mmap() afterwards, causing
> slot->userspace_addr to point to a different offset.
>
> 2. for slots bound to guest_memfd that do not support in-place-conversion,
> shared memory is allocated from a different backend. Therefore, checking
> "slot->base_gfn ^ slot->gmem.pgoff" is required for private memory. The check is
> currently absent because guest_memfd supports 4K only.
>
>

Let me clarify, I meant these changes:

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4b64ab3..d0dccf1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12938,6 +12938,11 @@ int memslot_rmap_alloc(struct kvm_memory_slot *slot, unsigned long npages)
        return 0;
 }
 
+static inline bool kvm_is_level_aligned(u64 value, int level)
+{
+       return IS_ALIGNED(value, KVM_PAGES_PER_HPAGE(level));
+}
+
 static int kvm_alloc_memslot_metadata(struct kvm *kvm,
                                      struct kvm_memory_slot *slot)
 {
@@ -12971,16 +12976,20 @@ static int kvm_alloc_memslot_metadata(struct kvm *kvm,
 
                slot->arch.lpage_info[i - 1] = linfo;
 
-               if (slot->base_gfn & (KVM_PAGES_PER_HPAGE(level) - 1))
+               if (!kvm_is_level_aligned(slot->base_gfn, level))
                        linfo[0].disallow_lpage = 1;
-               if ((slot->base_gfn + npages) & (KVM_PAGES_PER_HPAGE(level) - 1))
+               if (!kvm_is_level_aligned(slot->base_gfn + npages, level))
                        linfo[lpages - 1].disallow_lpage = 1;
                ugfn = slot->userspace_addr >> PAGE_SHIFT;
                /*
-                * If the gfn and userspace address are not aligned wrt each
-                * other, disable large page support for this slot.
+                * If the gfn and userspace address are not aligned or if gfn
+                * and guest_memfd offset are not aligned wrt each other,
+                * disable large page support for this slot.
                 */
-               if ((slot->base_gfn ^ ugfn) & (KVM_PAGES_PER_HPAGE(level) - 1)) {
+               if (!kvm_is_level_aligned(slot->base_gfn ^ ugfn, level) ||
+                   (kvm_slot_can_be_private(slot) &&
+                    !kvm_is_level_aligned(slot->base_gfn ^ slot->gmem.pgoff,
+                                          level))) {
                        unsigned long j;
 
                        for (j = 0; j < lpages; ++j)

This does not rely on the ugfn check, but adds a similar check for gmem.pgoff.

I think this should take care of case (1.), for guest_memfds going to be
used for both shared and private memory. Userspace can't update
slot->userspace_addr, since guest_memfd memslots cannot be updated and
can only be deleted.

If userspace re-uses slot->userspace_addr for some other memory address
without deleting and re-adding a memslot,

+ KVM's access to memory should still be fine, since after the recent
  discussion at guest_memfd upstream call, KVM's guest faults will
  always go via fd+offset and KVM's access won't be disrupted
  there. Whatever checking done at memslot binding time will still be
  valid.
+ Host's access and other accesses (e.g. instruction emulation, which
  uses slot->userspace_addr) to guest memory will be broken, but I think
  there's nothing protecting against that. The same breakage would
  happen for non-guest_memfd memslot.

p.s. I will be adding the validation as you suggested [1], though that
shouldn't make a difference here, since the above check directly
validates against gmem.pgoff.

Regarding 2., checking this checks against gmem.pgoff and should handle
that as well.

[1] https://lore.kernel.org/all/aBnMp26iWWhUrsVf@yzhao56-desk.sh.intel.com/

I prefer checking at binding time because it aligns with the ugfn check
that is already there, and avoids having to check at every fault.

>> [1] https://github.com/torvalds/linux/blob/b6ea1680d0ac0e45157a819c41b46565f4616186/arch/x86/kvm/x86.c#L12996
>> 
>> >> >> Adding checks at binding time will allow hugepage-unaligned offsets (to
>> >> >> be at parity with non-guest_memfd backing memory) but still fix this
>> >> >> issue.
>> >> >> 
>> >> >> lpage_info will make sure that ranges near the bounds will be
>> >> >> fragmented, but the hugepages in the middle will still be mappable as
>> >> >> hugepages.
>> >> >> 
>> >> >> [1] https://lpc.events/event/18/contributions/1764/attachments/1409/3706/binding-must-have-same-alignment.svg

