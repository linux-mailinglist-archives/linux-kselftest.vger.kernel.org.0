Return-Path: <linux-kselftest+bounces-31450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6390A99971
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 22:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0837B7A2F9E
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 20:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4AC26B941;
	Wed, 23 Apr 2025 20:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BxISFlk9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C641FC10E
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 20:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745440110; cv=none; b=JebSW04fkyAmPOYcjl8RE/S3yVxGp4Z50FVCxMtxPa2c/bmxWZOO1f6nKn0goyPZFS+a/Uifg9twJOLY6rNAGO947mwRLILrb1kUVBz+2idzgGir3l23bz7sOzr5f4e9MpSlEn/yBwcZ1LWB9S3My8+G0bJLpMin7ZEt1/ZMJ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745440110; c=relaxed/simple;
	bh=2RjA3K+20hOlo+w2EtMfB5HnfDnpGVGbjQV0yf7+ROI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=roYhW2M52KId03gxyO1kbmEjZ/CzHFkwSpo/5Ya9V0mv4JOTv9WCY4She4gDB4Y+6H3Uv0mgtxSZEhDh7kmSNMdl4JVGdl4A2blw0UDMZcmLwdIIj/VxdflBSxbbRYQ2jp8X37cAn+ozeCj2k3qAWW2V5LpCFDPPtEKSQIFSlKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BxISFlk9; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2254e0b4b85so2604305ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 13:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745440108; x=1746044908; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ah6zkuRCc/Z7s5oeCTOt9XwXTfn1W/VtyormqwMBFB4=;
        b=BxISFlk998XDIFbFaLcYNxmAuoEIeYq3Z8AVHzfM6nq6bJwV7qcWrzDUMzB67F1vTP
         u8tzA4/42VgDnbJ/Fc1zQx/zcggdRM+0sLt8K6myJU33xE3V79RBgRE5rjlpy0aTaK3G
         Nu0wcXI7MDdWsOeXMYxKdA7ZZqApPiJZgUVhYsnBhRWdcsJDfdhaeU9oBgNKiDYamPvi
         E5PciGTzDRUQp/KUPg/n84EU8hDSQItfNwTKwXycFihatIFIL7r7YTyDWZvAilwVVs8p
         a9Ep8IZmUsiReLuvEZlR7UUCGS+DvS/+pTjpvf9S3HtDe6PlyF9NltxkpAol/hanJYZA
         qG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745440108; x=1746044908;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ah6zkuRCc/Z7s5oeCTOt9XwXTfn1W/VtyormqwMBFB4=;
        b=lsnNtDuhmI18FVa5eUvP/UWBUsNByJCemt1iFpdOuROYRnSpc+b84x8k0lEL6fAU0R
         GDaI6GnUJhGsdJtXCGdsbImZAlstio4Zk5u/lLDmvXFagQRj/doboRbYmAOCA6j7xI8b
         QSJfwKn4Vu9zhznc3FbSfOhZ22E5wNfIEIYVZn/VgrjWDC4cfmR6yspoiZBFdAL8eJdO
         VcUDV1d31JMwcorEU1MEQuoSVMoKywiveEWx5Fv+Y9rXzKlXabQIu606ccbIkQySel7Y
         MZ+JYUTrG5/+r2R2m1kHuirm9lRZ2FxgUrE8M8PTbARE8HEgeMZnDDHFWUXen3zuzxxk
         u07A==
X-Forwarded-Encrypted: i=1; AJvYcCWUK9YtMZMXxQpXpTGkw1X0WEQFbHr3L1rIstEjhi+qxU42srmfiicpCWCABtTj0zSynkg0Y7inqpC7CzKy514=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2PJESxcle/8rlf+qCle+alFe50PXqaxgBju7emKUQ1aSlXjmK
	+y+Lai1NonWWaeLeMa2BrUeMr2FEMmriRQfYuElLYYzuAO1YFCoZA47NgcEma1HpJNpL0lQEWbG
	10weNCVqxv70GSjs26TuShQ==
X-Google-Smtp-Source: AGHT+IFiQVdxeBhTsiJOg9dL2jv2xFuiQooZC1rWX975oVPQU0mYN3lKF6SuxLR/yO5H1PbpNGLjnT3cV40FkFG7uQ==
X-Received: from pftb21.prod.google.com ([2002:a05:6a00:2d5:b0:730:7b0c:592c])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6d8e:b0:201:8a06:6e3b with SMTP id adf61e73a8af0-204447b1cb0mr161140637.9.1745440107858;
 Wed, 23 Apr 2025 13:28:27 -0700 (PDT)
Date: Wed, 23 Apr 2025 13:28:26 -0700
In-Reply-To: <Z+y4E3tcOCOJxCiS@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com> <5a05eb947cf7aa21f00b94171ca818cc3d5bdfee.1726009989.git.ackerleytng@google.com>
 <Z+y4E3tcOCOJxCiS@yzhao56-desk.sh.intel.com>
Message-ID: <diqzmsc6zkph.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH 27/39] KVM: guest_memfd: Allow mmapping guest_memfd files
From: Ackerley Tng <ackerleytng@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk, 
	jgg@nvidia.com, peterx@redhat.com, david@redhat.com, rientjes@google.com, 
	fvdl@google.com, jthoughton@google.com, seanjc@google.com, 
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev, 
	erdemaktas@google.com, vannapurve@google.com, qperret@google.com, 
	jhubbard@nvidia.com, willy@infradead.org, shuah@kernel.org, 
	brauner@kernel.org, bfoster@redhat.com, kent.overstreet@linux.dev, 
	pvorel@suse.cz, rppt@kernel.org, richard.weiyang@gmail.com, 
	anup@brainfault.org, haibo1.xu@intel.com, ajones@ventanamicro.com, 
	vkuznets@redhat.com, maciej.wieczor-retman@intel.com, pgonda@google.com, 
	oliver.upton@linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"

Yan Zhao <yan.y.zhao@intel.com> writes:

> On Tue, Sep 10, 2024 at 11:43:58PM +0000, Ackerley Tng wrote:
>> guest_memfd files can always be mmap()ed to userspace, but
>> faultability is controlled by an attribute on the inode.
>> 
>> Co-developed-by: Fuad Tabba <tabba@google.com>
>> Signed-off-by: Fuad Tabba <tabba@google.com>
>> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> 
>> ---
>>  virt/kvm/guest_memfd.c | 46 ++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 44 insertions(+), 2 deletions(-)
>> 
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index b603518f7b62..fc2483e35876 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -781,7 +781,8 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
>>  {
> Hi Ackerley,
>
> If userspace mmaps a guest_memfd to a VA when a GFN range is shared, it looks
> that even after the GFN range has been successfully converted to private,
> userspace can still call madvise(mem, size, MADV_REMOVE) on the userspace VA.
> This action triggers kvm_gmem_punch_hole() and kvm_gmem_invalidate_begin(),
> which can zap the private GFNs in the EPT.
>
> Is this behavior intended for in-place conversion, and could it potentially lead
> to private GFN ranges being accidentally zapped from the EPT?
>
> Apologies if I missed any related discussions on this topic.

No worries and thank you for your review! The next revision will not be
requiring userspace to do madvise(MADV_REMOVE), because memory could be
mapped in multiple processes, so unmapping from the kernel saves the
trouble of coordination in userspace between multiple processes.

>
> Thanks
> Yan
>
>>  	struct list_head *gmem_list = &inode->i_mapping->i_private_list;
>>  	pgoff_t start = offset >> PAGE_SHIFT;
>> -	pgoff_t end = (offset + len) >> PAGE_SHIFT;
>> +	pgoff_t nr = len >> PAGE_SHIFT;
>> +	pgoff_t end = start + nr;
>>  	struct kvm_gmem *gmem;
>>  
>>  	/*
>> @@ -790,6 +791,9 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
>>  	 */
>>  	filemap_invalidate_lock(inode->i_mapping);
>>  
>> +	/* TODO: Check if even_cows should be 0 or 1 */
>> +	unmap_mapping_range(inode->i_mapping, start, len, 0);
>> +
>>  	list_for_each_entry(gmem, gmem_list, entry)
>>  		kvm_gmem_invalidate_begin(gmem, start, end);
>>  

