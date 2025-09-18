Return-Path: <linux-kselftest+bounces-38528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE47FB1DEE8
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 23:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD072179B82
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 21:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B4A23817C;
	Thu,  7 Aug 2025 21:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qPzDoJY8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E24E21D3E4
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 21:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754602467; cv=none; b=IWlb7w6dN+ieoyp71Q1PAY5ZjGt03wqjIk0JknpuDEmx+OifK9p74HrEeqQApFLAgzWLYaKxXJQOsl/jclXlkf+jUCvMfRgpOqGDITvUOiAyZATis4AH54YpUmmefYQcch/X2ggYczct8hvceLfiOzd6OeSwob4ru5wAbOfI9Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754602467; c=relaxed/simple;
	bh=JlG1vtTJvdw82uvVilSW6OkfU8OcNVk2IJUHb+2IkTk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Oj2o6O7AN3RJDApxOjAUUkVAnJSwPXmjYzJTQCWza1XhOBgie7Q9l9EmlYvwLbSgjXweFTOcP6hiuSzCGaDJa7DF2jnsSZSgRJFMCbilrfo31uLXoIX1Od3X3mhihIXcuLa+sV6PyKDXe4NIQYla6m1+Y2+Gto+0aWMxGHmY5k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qPzDoJY8; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b3f33295703so2147102a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Aug 2025 14:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754602465; x=1755207265; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=euT/8AA//Jz5ZAvA5q9RKbxUinHczFI9QPq5RPbWgzY=;
        b=qPzDoJY8D4xuocYnV5uVVyVvxgMNYTJSRpGmhnx/GP4hoHGaQqJhfcCLpLXU7Phja7
         JYFq+jhYHyp1nPRTkxJ8itPcyRX096GXbIsXzinaRmfmOpJLf6YpBCaniuGsr7Hh+YD0
         S7h0DriDhMd/yOmQVwEkE3Cu5lFxWM8x5bp8+HPp/ZE/Z7eaGnWSVYTJmIWfjohtn2FV
         QW3eJPKIfTVIaktAtO2mYHW3yPZoDCDHhBhtHd9TJ29C/DH8BRNusw98OwbT/WYuXd8B
         WDDu0PjK5o78CtegaLbTnjZWzpn7pWfiKGKPbQyaogD+r6Rs0MNifKMA54oVE8lB7ffm
         0/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754602465; x=1755207265;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=euT/8AA//Jz5ZAvA5q9RKbxUinHczFI9QPq5RPbWgzY=;
        b=QruFegOneJ4sbs/jRJsZUNKRkTPPNjvbet+agJ0DV1W/XLfJHaM4fhEjqBrl/BXBvu
         m7Wf0TFtSns8ToX5ZeHdYP91NRrvzZbelyaeMhc4zbFQcfHjju3aNgd6FRVE/c0ipvnA
         HZGq0eSqne60zT+eL/b/Kqir4xg0OQDYlozSmnHU5EUe6psWe44WNJX/6Z4zO0E7FJ++
         tU+Q2uwR3yz0sK2PosJK/Vi4UvEMda9G5hqA8Y6hyihVZ252WQjCzngwK7SwkHbBlXbV
         AfwBWktk0F9TZ3qZ3fypoIr5/fZ0aVmdtgeQuGtgCRlUuWJjKh8jPNCL+8dxF+PxF3N2
         jSpg==
X-Forwarded-Encrypted: i=1; AJvYcCUG1vtrOf0I3LdH1jRK/tSLeI6E/u06jqHzNfDFRy+GlXOrlHfpskwbiZsF0aWoCCsEr/SPI9gDyTCW8mGvuUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Ddbe3BNG7NVU++yl4qeU5ikIsa5yABU+K3Mko9Qm19PlBEww
	TB/XdI5r0chN7pshdr/iw1/iTW1WLqaZgCWIF5NP82wORiksFzs1XBtlB35J6udLkmTEZzOipCm
	YWhH0w7fy0o/ofOO8U+/OuUImCg==
X-Google-Smtp-Source: AGHT+IHT05ItRE3IEgvLcZ+lHAyFN+6DaRgxPxErhggbmCLRvoYXLPmLesz+SqrwGnv72L7qbCLUCgFDzQ08eW50HQ==
X-Received: from plbko5.prod.google.com ([2002:a17:903:7c5:b0:23f:e9a5:d20a])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ef0a:b0:235:f459:69c7 with SMTP id d9443c01a7336-242c225dbfemr7374775ad.52.1754602464480;
 Thu, 07 Aug 2025 14:34:24 -0700 (PDT)
Date: Thu, 07 Aug 2025 14:34:23 -0700
In-Reply-To: <1e37e4e7-aa7b-4a2a-b1aa-1243f8094dcb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250713174339.13981-2-shivankg@amd.com> <20250713174339.13981-4-shivankg@amd.com>
 <1e37e4e7-aa7b-4a2a-b1aa-1243f8094dcb@redhat.com>
Message-ID: <diqz4iui4y00.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [PATCH V9 1/7] KVM: guest_memfd: Use guest mem inodes instead of
 anonymous inodes
From: Ackerley Tng <ackerleytng@google.com>
To: David Hildenbrand <david@redhat.com>, Shivank Garg <shivankg@amd.com>, seanjc@google.com, 
	vbabka@suse.cz, willy@infradead.org, akpm@linux-foundation.org, 
	shuah@kernel.org, pbonzini@redhat.com, brauner@kernel.org, 
	viro@zeniv.linux.org.uk
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz, 
	bfoster@redhat.com, tabba@google.com, vannapurve@google.com, 
	chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com, 
	shdhiman@amd.com, yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, 
	thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, 
	kalyazin@amazon.com, peterx@redhat.com, jack@suse.cz, rppt@kernel.org, 
	hch@infradead.org, cgzones@googlemail.com, ira.weiny@intel.com, 
	rientjes@google.com, roypat@amazon.co.uk, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, kent.overstreet@linux.dev, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, chao.p.peng@intel.com, 
	amit@infradead.org, ddutile@redhat.com, dan.j.williams@intel.com, 
	ashish.kalra@amd.com, gshan@redhat.com, jgowans@amazon.com, 
	pankaj.gupta@amd.com, papaluri@amd.com, yuzhao@google.com, 
	suzuki.poulose@arm.com, quic_eberman@quicinc.com, 
	aneeshkumar.kizhakeveetil@arm.com, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

David Hildenbrand <david@redhat.com> writes:

> On 13.07.25 19:43, Shivank Garg wrote:
>> From: Ackerley Tng <ackerleytng@google.com>
>> 
>> guest_memfd's inode represents memory the guest_memfd is
>> providing. guest_memfd's file represents a struct kvm's view of that
>> memory.
>> 
>> Using a custom inode allows customization of the inode teardown
>> process via callbacks. For example, ->evict_inode() allows
>> customization of the truncation process on file close, and
>> ->destroy_inode() and ->free_inode() allow customization of the inode
>> freeing process.
>> 
>> Customizing the truncation process allows flexibility in management of
>> guest_memfd memory and customization of the inode freeing process
>> allows proper cleanup of memory metadata stored on the inode.
>> 
>> Memory metadata is more appropriately stored on the inode (as opposed
>> to the file), since the metadata is for the memory and is not unique
>> to a specific binding and struct kvm.
>> 
>> Co-developed-by: Fuad Tabba <tabba@google.com>
>> Signed-off-by: Fuad Tabba <tabba@google.com>
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> Signed-off-by: Shivank Garg <shivankg@amd.com>
>> ---
>
> [...]
>
>>   
>>   #include "kvm_mm.h"
>>   
>> +static struct vfsmount *kvm_gmem_mnt;
>> +
>>   struct kvm_gmem {
>>   	struct kvm *kvm;
>>   	struct xarray bindings;
>> @@ -388,9 +392,51 @@ static struct file_operations kvm_gmem_fops = {
>>   	.fallocate	= kvm_gmem_fallocate,
>>   };
>>   
>> -void kvm_gmem_init(struct module *module)
>> +static const struct super_operations kvm_gmem_super_operations = {
>> +	.statfs		= simple_statfs,
>> +};
>> +
>> +static int kvm_gmem_init_fs_context(struct fs_context *fc)
>> +{
>> +	struct pseudo_fs_context *ctx;
>> +
>> +	if (!init_pseudo(fc, GUEST_MEMFD_MAGIC))
>> +		return -ENOMEM;
>> +
>> +	ctx = fc->fs_private;
>> +	ctx->ops = &kvm_gmem_super_operations;
>
> Curious, why is that required? (secretmem doesn't have it, so I wonder)
>

Good point! pseudo_fs_fill_super() fills in a struct super_operations
which already does simple_statfs, so guest_memfd doesn't need this.

>> +
>> +	return 0;
>> +}
>> +
>> +static struct file_system_type kvm_gmem_fs = {
>> +	.name		 = "kvm_guest_memory",
>
> It's GUEST_MEMFD_MAGIC but here "kvm_guest_memory".
>
> For secretmem it's SECRETMEM_MAGIC vs. "secretmem".
>
> So naturally, I wonder if that is to be made consistent :)
>

I'll update this to "guest_memfd" to be consistent. 

>> +	.init_fs_context = kvm_gmem_init_fs_context,
>> +	.kill_sb	 = kill_anon_super,
>> +};
>> +
>> +static int kvm_gmem_init_mount(void)
>> +{
>> +	kvm_gmem_mnt = kern_mount(&kvm_gmem_fs);
>> +
>> +	if (IS_ERR(kvm_gmem_mnt))
>> +		return PTR_ERR(kvm_gmem_mnt);
>> +
>> +	kvm_gmem_mnt->mnt_flags |= MNT_NOEXEC;
>> +	return 0;
>> +}
>> +
>> +int kvm_gmem_init(struct module *module)
>>   {
>>   	kvm_gmem_fops.owner = module;
>> +
>> +	return kvm_gmem_init_mount();
>> +}
>> +
>> +void kvm_gmem_exit(void)
>> +{
>> +	kern_unmount(kvm_gmem_mnt);
>> +	kvm_gmem_mnt = NULL;
>>   }
>>   
>>   static int kvm_gmem_migrate_folio(struct address_space *mapping,
>> @@ -472,11 +518,71 @@ static const struct inode_operations kvm_gmem_iops = {
>>   	.setattr	= kvm_gmem_setattr,
>>   };
>>   
>> +static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
>> +						      loff_t size, u64 flags)
>> +{
>> +	struct inode *inode;
>> +
>> +	inode = anon_inode_make_secure_inode(kvm_gmem_mnt->mnt_sb, name, NULL);
>> +	if (IS_ERR(inode))
>> +		return inode;
>> +
>> +	inode->i_private = (void *)(unsigned long)flags;
>> +	inode->i_op = &kvm_gmem_iops;
>> +	inode->i_mapping->a_ops = &kvm_gmem_aops;
>> +	inode->i_mode |= S_IFREG;
>> +	inode->i_size = size;
>> +	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
>> +	mapping_set_inaccessible(inode->i_mapping);
>> +	/* Unmovable mappings are supposed to be marked unevictable as well. */
>> +	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
>> +
>> +	return inode;
>> +}
>> +
>> +static struct file *kvm_gmem_inode_create_getfile(void *priv, loff_t size,
>> +						  u64 flags)
>> +{
>> +	static const char *name = "[kvm-gmem]";
>> +	struct inode *inode;
>> +	struct file *file;
>> +	int err;
>> +
>> +	err = -ENOENT;
>> +	if (!try_module_get(kvm_gmem_fops.owner))
>> +		goto err;
>
> Curious, shouldn't there be a module_put() somewhere after this function 
> returned a file?
>

This was interesting indeed, but IIUC this is correct.

I think this flow was basically copied from __anon_inode_getfile(),
which does this try_module_get().

The corresponding module_put() is in __fput(), which calls fops_put()
and calls module_put() on the owner.

>> +
>> +	inode = kvm_gmem_inode_make_secure_inode(name, size, flags);
>> +	if (IS_ERR(inode)) {
>> +		err = PTR_ERR(inode);
>> +		goto err_put_module;
>> +	}
>> +
>> +	file = alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR,
>> +				 &kvm_gmem_fops);
>> +	if (IS_ERR(file)) {
>> +		err = PTR_ERR(file);
>> +		goto err_put_inode;
>> +	}
>> +
>> +	file->f_flags |= O_LARGEFILE;
>> +	file->private_data = priv;
>> +
>>
>
> Nothing else jumped at me.
>

Thanks for the review!

Since we're going to submit this patch through Shivank's mempolicy
support series, I'll follow up soon by sending a replacement patch in
reply to this series so Shivank could build on top of that?

> -- 
> Cheers,
>
> David / dhildenb

