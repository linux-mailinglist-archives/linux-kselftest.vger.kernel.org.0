Return-Path: <linux-kselftest+bounces-19576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FADB99AF6B
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 01:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B6D1C2101D
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 23:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9691E0B8D;
	Fri, 11 Oct 2024 23:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kcm7iTqR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1739D1DC182
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 23:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728689535; cv=none; b=jjdpkhtTokfEdB9WfjY5mLeHqt//An2nD7EwdWzA4bUxtPF3lTK72vFD+le5QZNGXg+VmzmeQwmsrEBICKhwBsGC5LFLBs/ZeFwy1HsVkSo8tTEDW2m5gY6AySKSk7PUGOIIF812KKhX58zZ1oYykBofJZMOzs6B+mupPfudJYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728689535; c=relaxed/simple;
	bh=BU61ZVZ2YgVL7S0DDn0oL3BMc0m6p/G/2uGrI5GKAq0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dHDbd60jIpNj5//C2obKhNm4OWmofQoX6RETx7J4BgjaidWY96j85+oaY3pA3aRWHwtDCAFD/XJ5e/qilvXlMxHNu3RhYb+MAPGHXTeqkrrElZPUIdXCLVMDT+zXzTX7jTpS4ZSeJWRV3CQm6B5Zh3p+eS7h7vRTkXHR56jUqHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kcm7iTqR; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-207510f3242so32320095ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 16:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728689533; x=1729294333; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nQXxRrnrV7O63nBn6aNSK0Ta44wyj59/3jigJZtHDdg=;
        b=Kcm7iTqRyqi4Zd25w749MGqSJ73zC7JtpCyD/bYafE7x+LvjLAtI7/pPxp3o9+zSB7
         3iTp2HOsKjWgNJhHp/acP5CKDnEioDM5e+T1PmpCBzl4my+IzF1qtYEQzJ3jDhll4bsp
         XeFjnjAzfnyKP7Kx6vXmEyVZhELeL/kELJ0qS+UDxW+x+3fRBh6/Gt1vtJt5z5Q5Skqo
         TiiMQ2BXmpqD4kMmokjInekICzEyyClVRz9jjsly6WTP1R77el+z4AWkOk47NVleyxSO
         J2KT3xBMD9x8+L8egokGbpSSE+9REDiV5Ad4kCgwFJD9vUGuG44Qie/6Ed2YikM1VXKI
         zDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728689533; x=1729294333;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQXxRrnrV7O63nBn6aNSK0Ta44wyj59/3jigJZtHDdg=;
        b=aaPW5/Q8pZfRsqZl/8MBDP0rGVXxxKMnBv9pvAFnka30WWOA4Km3Urdl+hFaefgff2
         npiDfCgWtWZs/FZIobosTf9ZD9g9ihXcwY9WXj8miTiCy9MTt40+a7eVr6H7pCzGuT31
         sXnqNVc6AsU4L3OCU4XJ5uyYOhE2iD66ABB8c6wZIUpcgrkAUb7OOh0RVDyJEenGJFMP
         AKLPv89y3bn1I0LopNBhM1Te5dL1PGJz6BUO5ltlrdaY55KmWhnIzTM6bjIg+6iGSTc7
         MzASbLCBGGqa56+MNMcthQH+lzHTl3brMGCz6efs62dq9nGVzHezakg0BPiBN0wkGbAi
         bTCg==
X-Forwarded-Encrypted: i=1; AJvYcCXdbcAgApVKruneKlqBinwn3QLi4B2WaL5ie+2mkA1UTflpG2r6Cr9+Gt5j9UAmjqgLHzSVGqoTBLtkw0u/oAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQZe5KtPZNXmwG/7X3eNUqHOy+VyfbaLCAiuvrsu+XAaJ+DVp5
	LNoxxuplq4kvu5pg4yn6xFktLpVOcQf3XQoH7MSgsF0DDzvj8SVnLa6Qirsl6c+pA4C1cY10mUX
	D3KOWe/qfPKEv/gXIH3QRpA==
X-Google-Smtp-Source: AGHT+IEr0SQ3XRg7hoB/1zJoRlSN31+WIwCwFTPdS0u4dzfqsgHYjCK/hMmgYKFzuCsnHMIZGemMQB8gxXvAks9d2g==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:146:b875:ac13:a9fc])
 (user=ackerleytng job=sendgmr) by 2002:a17:902:c942:b0:20b:4d4d:fd1e with
 SMTP id d9443c01a7336-20ca13dacc3mr442805ad.2.1728689532873; Fri, 11 Oct 2024
 16:32:12 -0700 (PDT)
Date: Fri, 11 Oct 2024 23:32:11 +0000
In-Reply-To: <Zwf7k1wmPqEEaRxz@x1n>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com> <bd163de3118b626d1005aa88e71ef2fb72f0be0f.1726009989.git.ackerleytng@google.com>
 <Zwf7k1wmPqEEaRxz@x1n>
Message-ID: <diqz8quunrlw.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH 26/39] KVM: guest_memfd: Track faultability within a
 struct kvm_gmem_private
From: Ackerley Tng <ackerleytng@google.com>
To: Peter Xu <peterx@redhat.com>
Cc: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk, 
	jgg@nvidia.com, david@redhat.com, rientjes@google.com, fvdl@google.com, 
	jthoughton@google.com, seanjc@google.com, pbonzini@redhat.com, 
	zhiquan1.li@intel.com, fan.du@intel.com, jun.miao@intel.com, 
	isaku.yamahata@intel.com, muchun.song@linux.dev, erdemaktas@google.com, 
	vannapurve@google.com, qperret@google.com, jhubbard@nvidia.com, 
	willy@infradead.org, shuah@kernel.org, brauner@kernel.org, bfoster@redhat.com, 
	kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org, 
	richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com, 
	ajones@ventanamicro.com, vkuznets@redhat.com, maciej.wieczor-retman@intel.com, 
	pgonda@google.com, oliver.upton@linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Peter Xu <peterx@redhat.com> writes:

> On Tue, Sep 10, 2024 at 11:43:57PM +0000, Ackerley Tng wrote:
>> The faultability xarray is stored on the inode since faultability is a
>> property of the guest_memfd's memory contents.
>> 
>> In this RFC, presence of an entry in the xarray indicates faultable,
>> but this could be flipped so that presence indicates unfaultable. For
>> flexibility, a special value "FAULT" is used instead of a simple
>> boolean.
>> 
>> However, at some stages of a VM's lifecycle there could be more
>> private pages, and at other stages there could be more shared pages.
>> 
>> This is likely to be replaced by a better data structure in a future
>> revision to better support ranges.
>> 
>> Also store struct kvm_gmem_hugetlb in struct kvm_gmem_hugetlb as a
>> pointer. inode->i_mapping->i_private_data.
>
> Could you help explain the difference between faultability v.s. the
> existing KVM_MEMORY_ATTRIBUTE_PRIVATE?  Not sure if I'm the only one who's
> confused, otherwise might be good to enrich the commit message.

Thank you for this question, I'll add this to the commit message to the
next revision if Fuad's patch set [1] doesn't make it first.

Reason (a): To elaborate on the explanation in [1],
KVM_MEMORY_ATTRIBUTE_PRIVATE is whether userspace wants this page to be
private or shared, and faultability is whether the page is allowed to be
faulted in by userspace.

These two are similar but may not be the same thing. In pKVM, pKVM
cannot trust userspace's configuration of private/shared, and other
information will go into determining the private/shared setting in
faultability.

Perhaps Fuad can elaborate more here.

Reason (b): In this patch series (mostly focus on x86 first), we're
using faultability to prevent any future faults before checking that
there are no mappings.

Having a different xarray from mem_attr_array allows us to disable
faulting before committing to changing mem_attr_array. Please see
`kvm_gmem_should_set_attributes_private()` in this patch [2].

We're not completely sure about the effectiveness of using faultability
to block off future faults here, in future revisions we may be using a
different approach. The folio_lock() is probably important if we need to
check mapcount. Please let me know if you have any ideas!

The starting point of having a different xarray was pKVM's requirement
of having separate xarrays, and we later realized that the xarray could
be used for reason (b). For x86 we could perhaps eventually remove the
second xarray? Not sure as of now.

>
> The latter is per-slot, so one level higher, however I don't think it's a
> common use case for mapping the same gmemfd in multiple slots anyway for
> KVM (besides corner cases like live upgrade).  So perhaps this is not about
> layering but something else?  For example, any use case where PRIVATE and
> FAULTABLE can be reported with different values.
>
> Another higher level question is, is there any plan to support non-CoCo
> context for 1G?

I believe guest_memfd users are generally in favor of eventually using
guest_memfd for non-CoCo use cases, which means we do want 1G (shared,
in the case of CoCo) page support.

However, core-mm's fault path does not support mapping at anything
higher than the PMD level (other than hugetlb_fault(), which the
community wants to move away from), so core-mm wouldn't be able to map
1G pages taken from HugeTLB.

In this patch series, we always split pages before mapping them to
userspace and that's how this series still works with core-mm.

Having 1G page support for shared memory or for non-CoCo use cases would
probably depend on better HugeTLB integration with core-mm, which you'd
be most familiar with.

Thank you for looking through our patches, we need your experience and
help! I've also just sent out the first 3 patches separately, which I
think is useful in improving understandability of the
resv_map/subpool/hstate reservation system in HugeTLB and can be
considered separately. Hope you can also review/comment on [4].

> I saw that you also mentioned you have working QEMU prototypes ready in
> another email.  It'll be great if you can push your kernel/QEMU's latest
> tree (including all dependency patches) somewhere so anyone can have a
> closer look, or play with it.

Vishal's reply [3] might have been a bit confusing. To clarify, my team
doesn't work with Qemu at all (we use a custom userspace VMM internally)
so the patches in this series are tested purely with selftests.

The selftests have fewer dependencies than full Qemu and I'd be happy to
help with running them or explain anything that I might have missed out.

We don't have any Qemu prototypes and are not likely to be building any
prototypes in the foreseeable future.

>
> Thanks,
>
> -- 
> Peter Xu

[1] https://lore.kernel.org/all/20241010085930.1546800-3-tabba@google.com/
[2] https://lore.kernel.org/all/f4ca1711a477a3b56406c05d125dce3d7403b936.1726009989.git.ackerleytng@google.com/
[3] https://lore.kernel.org/all/CAGtprH-GczOb64XrLpdW4ObRG7Gsv8tHWNhiW7=2dE=OAF7-Rw@mail.gmail.com/
[4] https://lore.kernel.org/all/cover.1728684491.git.ackerleytng@google.com/T/

