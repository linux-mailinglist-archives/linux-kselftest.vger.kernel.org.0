Return-Path: <linux-kselftest+bounces-25974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EBFA2BB50
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 07:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D45DA3A68A8
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 06:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970A4176AB5;
	Fri,  7 Feb 2025 06:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cCXP40jK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087791552F5
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Feb 2025 06:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738909564; cv=none; b=CI3toMKwM9Ye/FKQ47ziE2rVB94Bm6ydjAfl0uxDp1fiuW7IVVObf76dt65wtfbhbSubcX5u5i1a4wuthGcHM308khDnQT/pg+XtGdarmDzTX2ohoRBjdGnR7YVcAgcIw0y5QK23jfNxnXJV2HmtK+eYvFVYGhd3uCX5k9HIHXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738909564; c=relaxed/simple;
	bh=4OA6Vgbf5mmHaHK2XX87TxyNvNbPNA/LoqBpZuhF07s=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=EI3GiKrn9tSU8OjCAkSLoHa0b6OlzEI9rG1SfHwhpLbZrQt9wmh/DaqtS2nxO9Kmz65va2aeFwi+TZo/E3zkohajZ7wZdlqMv+h7XKMGxVvm9bLFJe1oKaKGE/waPJBr8gY33Iyshh893RYhwU2ElYLOgfbOQwNzmB9SKEfi1YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cCXP40jK; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21f40f40788so30766705ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Feb 2025 22:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738909562; x=1739514362; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pVBLx5GIpN7LjdmT+CcHUgO81qGH5daXphk7+y3Ogdw=;
        b=cCXP40jKzfy5XvZx1xuB4aJJZqm5MN1MLU/bKvDhe8uGywAqayB+r/zyW41T4rIQfe
         yz1dHyOjg15/v2KVtr8RgQKu96K37s2ioZ5Pg9+XdQxnzoAZMLp/TLNj4h9E8HDBVKli
         LSf80eEqkiM0DqQLG+/hiqNK1FyNl7l1iznvNLg3CIEYxJ4X8yEbc+BpxVmSmd8N2PjI
         r27mNgU9pEt/IjTiKi3xrnPoz4Ooy/LtvrYIIQyRnoPK5UUBo1JsMJwGKjWYfF5dbs3+
         uHyVDj1mjgfAJKu+zDQ3pXOIof7jJsjijPQeqBMUHdLytenAvOQsH9PHoE4Gdg90gg6J
         hIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738909562; x=1739514362;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pVBLx5GIpN7LjdmT+CcHUgO81qGH5daXphk7+y3Ogdw=;
        b=FC8Y6whxVTXN1ChTYjUpqDq6IaELVN2JGeTkTPJwynlwxcamUTvMxlGBZZ5nXMJPTP
         ic1Avp2t4GlNu0bd42G+3tQ/4tz8gVeOFpeioD+ONWQObltG4j+AgR1z4oL+FU/h0sKa
         oTbGhti4mPn03XfhHVn/ktCTrX3/f6hNRZOSNn3IVJKlagncqaBbPSjK7YWXex1s17+H
         9mLnA/NapnvxLQyJXMV+s2eo5uSaxPfUlWrAAkxTVGPfcDEnvV1ExtMkg2g2Gwff7lCv
         IhhqeDLD6OKIfILGS8sXMr5ZCliNNaKYSCx8PUnVKJkallmFliwR24AxdmENxKYWIHyE
         /Stg==
X-Forwarded-Encrypted: i=1; AJvYcCWHki69uYO7tbsXfvBv1vmY7VDMdsVdnJzmBBgAWiiIg8JNmYSp3UnZpBBQAzNCrVrxJENgQWtQJft85n5FIgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YweiTwUQ+g9/dfNU3DVG1IZhFsQj5Xw2By4foH3CoUQq1gdEas/
	t4gtrAodkwWB9UYlpOOQ0gWt3qy2/0GNX5QVfk8Nns1/7mqx6HVn8MdZx5bm1wWpY1GvmQndciK
	DSlZx2tGlks733+IsmjCRIQ==
X-Google-Smtp-Source: AGHT+IHXNTs3kgTobb4JCthlwm4Jfzsw4vmzDv2oF+RkKfjY2IbUGXQW6QU/6emUQ2gWCi0WeScassVHI7XwDeeNyw==
X-Received: from pjtd16.prod.google.com ([2002:a17:90b:50:b0:2ef:d136:17fc])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ce84:b0:21f:c13:89a9 with SMTP id d9443c01a7336-21f4e75d8a7mr38698485ad.35.1738909562300;
 Thu, 06 Feb 2025 22:26:02 -0800 (PST)
Date: Fri, 07 Feb 2025 06:25:59 +0000
In-Reply-To: <f8030dfc5086e4e4e3709d6fcdab1e38f01fc38d.camel@infradead.org>
 (message from Amit Shah on Thu, 06 Feb 2025 12:07:58 +0100)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <diqzh656p8y0.fsf@ackerleytng-ctop-specialist.c.googlers.com>
Subject: Re: [RFC PATCH 00/39] 1G page support for guest_memfd
From: Ackerley Tng <ackerleytng@google.com>
To: Amit Shah <amit@infradead.org>
Cc: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk, 
	jgg@nvidia.com, peterx@redhat.com, david@redhat.com, rientjes@google.com, 
	fvdl@google.com, jthoughton@google.com, seanjc@google.com, 
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev, 
	mike.kravetz@oracle.com, erdemaktas@google.com, vannapurve@google.com, 
	qperret@google.com, jhubbard@nvidia.com, willy@infradead.org, 
	shuah@kernel.org, brauner@kernel.org, bfoster@redhat.com, 
	kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org, 
	richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com, 
	ajones@ventanamicro.com, vkuznets@redhat.com, maciej.wieczor-retman@intel.com, 
	pgonda@google.com, oliver.upton@linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-fsdevel@kvack.org
Content-Type: text/plain; charset="UTF-8"

Amit Shah <amit@infradead.org> writes:

>> <snip>
>> 
>> Thanks all your help and comments during the guest_memfd upstream
>> calls,
>> and thanks for the help from AMD.
>> 
>> Extending mmap() support from Fuad with 1G page support introduces
>> more
>> states that made it more complicated (at least for me).
>> 
>> I'm modeling the states in python so I can iterate more quickly. I
>> also
>> have usage flows (e.g. allocate, guest_use, host_use,
>> transient_folio_get, close, transient_folio_put) as test cases.
>> 
>> I'm almost done with the model and my next steps are to write up a
>> state
>> machine (like Fuad's [5]) and share that.

Thanks everyone for all the comments at the 2025-02-06 guest_memfd
upstream call! Here are the 

+ Slides: https://lpc.events/event/18/contributions/1764/attachments/1409/3704/guest-memfd-1g-page-support-2025-02-06.pdf
+ State diagram: https://lpc.events/event/18/contributions/1764/attachments/1409/3702/guest-memfd-state-diagram-split-merge-2025-02-06.drawio.svg
+ For those interested in editing the state diagram using draw.io:
  https://lpc.events/event/18/contributions/1764/attachments/1409/3703/guest-memfd-state-diagram-split-merge-2025-02-06.drawio.xml

>> 
>> I'd be happy to share the python model too but I have to work through
>> some internal open-sourcing processes first, so if you think this
>> will
>> be useful, let me know!
>
> No problem.  Yes, I'm interested in this - it'll be helpful!

I've started working through the internal processes and will update here
when I'm done!

>
> The other thing of note is that while we have the kernel patches, a
> userspace to drive them and exercise them is currently missing.

In this and future patch series, I'll have selftests that will exercise
any new functionality.

>
>> Then, I'll code it all up in a new revision of this series (target:
>> March 2025), which will be accompanied by source code on GitHub.
>> 
>> I'm happy to collaborate more closely, let me know if you have ideas
>> for
>> collaboration!
>
> Thank you.  I think currently the bigger problem we have is allocation
> of hugepages -- which is also blocking a lot of the follow-on work. 
> Vishal briefly mentioned isolating pages from Linux entirely last time
> - that's also what I'm interested in to figure out if we can completely
> bypass the allocation problem by not allocating struct pages for non-
> host use pages entirely.  The guest_memfs/KHO/kexec/live-update patches
> also take this approach on AWS (for how their VMs are launched).  If we
> work with those patches together, allocation of 1G hugepages is
> simplified.  I'd like to discuss more on these themes to see if this is
> an approach that helps as well.
>
>
> 		Amit

Vishal is still very interested in this and will probably be looking
into this while I push ahead assuming that KVM continues to use struct
pages. This was also brought up at the guest_memfd upstream call on
2025-02-06, people were interested in this and think that it will
simplify refcounting for merging and splitting.

I'll push ahead assuming that we use hugetlb as the source of 1G pages,
and assuming that KVM continues to use struct pages to describe guest
private memory.

The series will still be useful as an interim solution/prototype even if
other allocators are preferred and get merged. :)

