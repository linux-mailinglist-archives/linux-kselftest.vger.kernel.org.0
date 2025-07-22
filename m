Return-Path: <linux-kselftest+bounces-37839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F315BB0E03F
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 17:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61861173EC7
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 15:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E66E256C6D;
	Tue, 22 Jul 2025 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZ0MV35p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD7E256C8B
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Jul 2025 15:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753197535; cv=none; b=fby0InrSYTmZRTTQjdZg7rfD62zSGPlXK4jbqrvqCAvJ9b3fIdIAspOulGZE22ku5qJqMqQdjYdd1G2bvn5wyLlfyw3g7IvxqFwESwGa0b1AMhvdEd/1zbuLfdN/buBvCp8TaWQX23mGcP7f0HAdZq2Ei1A56I0ru2MtrROoJWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753197535; c=relaxed/simple;
	bh=/WcZ1CtXBk0PGDSvY/bmb4xGlyzv32cUyKEBqFYxoWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YrFhTDx/iRFa7LeBEvA4Oe0/7ZyaKXb7shOB1SXrNd8zFWkQKkyjKBUbQE2OOnn2N0NT2K39q3ewIcDvagrSfT6NSlcykQC4s3t1K23Ut5fP6fgDeeAprLkmWDL4b/2K/wPZp1yaT7I11mTCyQMkAay5C2+vnpdSOb/45xaXhGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LZ0MV35p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753197532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vPWTF5ngQjwKpl0CL91lanYqN0TafLkJwtT/q59+/yM=;
	b=LZ0MV35pEwAvDUXkaL/RMUm+nioeyMMtSl6m4h7eBLykbvACNtAamA3m0ljs/4GszG3iI+
	JtEJ1Sudw0nEAojcSP2BzLyy1VzZAxK6h7ZXzmaMqYBT0e0HM9vgll7YDkyz9wiIltAv77
	gkCLfkDUMqbFJLIrnlzYny0loQZbsa0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-JWVk6JtmOx2_fMSyEdUQ-g-1; Tue, 22 Jul 2025 11:18:51 -0400
X-MC-Unique: JWVk6JtmOx2_fMSyEdUQ-g-1
X-Mimecast-MFC-AGG-ID: JWVk6JtmOx2_fMSyEdUQ-g_1753197530
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f8192e2cso3335958f8f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Jul 2025 08:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753197530; x=1753802330;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vPWTF5ngQjwKpl0CL91lanYqN0TafLkJwtT/q59+/yM=;
        b=lTrjUyBROdyNeJHPM7prbcfhkuP6Tu9ciGhLyvOjXY801FN5t71tOSrUehzMedrdyd
         l5/5yYFmlItOtlQDEcp9V0/u7k+JSPeycTyM+TyuKGYNMK58Vzdm4MOYqfEDJI15jllO
         5Wv9UxFBDSoOJbhdNvDeZYAM8pUrgRaKhYbNPsg5M8X+PNIgV7aY1BpCdXb7d9XV+9ce
         n4sqK7GyFtdbPSFhutxy/Hlpr+Jculq6empKe/b+2saPLRMAOmKfiusW02VfFC7VuA8p
         MTtWjzk8OQrM4yOlR2oJVg1XwGshffGBNofGo0vxkZYRG+M+osr+3pAcVr0EiZrwwvQS
         ZXRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGxz6gej/34wUxALjfE/wmpLMKasVDBMFjNEHwqvQce8dLxnnOB6w6SuPrilYOFFMj4l+fzuSVcNwggg5lRM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/QLY+iaJg2Ur1qDs6Gv6K420ZoCT94xA0RbOZkSKN3/GF8Wdm
	6E4KR/KlMrGqWwTgCG6P7aCLaWWNxe786V0m4eZRyDh1+Oly3mbkUCqlKs2JdAzI3jHvHugr+yq
	mihjOp47EU45+kORe+oQVPA33tTeZoCxBM81f88TRmNYJmpulIOSKggURwOLJvoeNCkTICA==
X-Gm-Gg: ASbGncu6oucPcI0RDqmwaIl34OhS9Pr7Tko/gRiGGTGps2zw0uYJl526VobqO/K2MOZ
	jGNdq28c3bz/c4Kivt3jTJPOotbXcJUfCnl2vqv1SK8jlutuTB2/05NxBemWdPv19KjI4PAru9n
	Xw0zLd/P3H/ktcKqTF2XvHBlu5b8SsfYe+AqG7dhJ5zaZdV5jfZ2wSsNm/8U9XMM9RN3A3bHg5k
	b5E8KfFuJD8AeM7uoU02E30B3wSNmFInvDIB789l/Uh9bvNzZpiqy4+4hjqM7PriNrHHyothKRp
	YqMaxTMM8qN0XDcG47phUAKxykl22hiKHvaQ2Q6o65l6PZUo8VEi6zjw4O7yMKc4IhYl5bzbned
	3m7SufG/UeyBi7kBd/GgRL9xdeQBhV+Q14w1Fk7voHQO7egxBvkLwHMfKEG12cOvlJCM=
X-Received: by 2002:a05:6000:40d9:b0:3b4:4876:9088 with SMTP id ffacd0b85a97d-3b60e510003mr19315475f8f.46.1753197529252;
        Tue, 22 Jul 2025 08:18:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRxjtA5vVT+h5NsfGd2wOVYh5rvJSzktGMXJjPKH1XZUXenLSFb1S6kEQiO5Y9viU/4gAJBg==
X-Received: by 2002:a05:6000:40d9:b0:3b4:4876:9088 with SMTP id ffacd0b85a97d-3b60e510003mr19315421f8f.46.1753197528555;
        Tue, 22 Jul 2025 08:18:48 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:de00:1efe:3ea4:63ba:1713? (p200300d82f28de001efe3ea463ba1713.dip0.t-ipconnect.de. [2003:d8:2f28:de00:1efe:3ea4:63ba:1713])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2bf82sm13809742f8f.26.2025.07.22.08.18.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 08:18:48 -0700 (PDT)
Message-ID: <1e37e4e7-aa7b-4a2a-b1aa-1243f8094dcb@redhat.com>
Date: Tue, 22 Jul 2025 17:18:45 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 1/7] KVM: guest_memfd: Use guest mem inodes instead of
 anonymous inodes
To: Shivank Garg <shivankg@amd.com>, seanjc@google.com, vbabka@suse.cz,
 willy@infradead.org, akpm@linux-foundation.org, shuah@kernel.org,
 pbonzini@redhat.com, brauner@kernel.org, viro@zeniv.linux.org.uk
Cc: ackerleytng@google.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com, tabba@google.com,
 vannapurve@google.com, chao.gao@intel.com, bharata@amd.com, nikunj@amd.com,
 michael.day@amd.com, shdhiman@amd.com, yan.y.zhao@intel.com,
 Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com, michael.roth@amd.com,
 aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com, peterx@redhat.com,
 jack@suse.cz, rppt@kernel.org, hch@infradead.org, cgzones@googlemail.com,
 ira.weiny@intel.com, rientjes@google.com, roypat@amazon.co.uk,
 ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 kent.overstreet@linux.dev, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 chao.p.peng@intel.com, amit@infradead.org, ddutile@redhat.com,
 dan.j.williams@intel.com, ashish.kalra@amd.com, gshan@redhat.com,
 jgowans@amazon.com, pankaj.gupta@amd.com, papaluri@amd.com,
 yuzhao@google.com, suzuki.poulose@arm.com, quic_eberman@quicinc.com,
 aneeshkumar.kizhakeveetil@arm.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-coco@lists.linux.dev
References: <20250713174339.13981-2-shivankg@amd.com>
 <20250713174339.13981-4-shivankg@amd.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250713174339.13981-4-shivankg@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.07.25 19:43, Shivank Garg wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> guest_memfd's inode represents memory the guest_memfd is
> providing. guest_memfd's file represents a struct kvm's view of that
> memory.
> 
> Using a custom inode allows customization of the inode teardown
> process via callbacks. For example, ->evict_inode() allows
> customization of the truncation process on file close, and
> ->destroy_inode() and ->free_inode() allow customization of the inode
> freeing process.
> 
> Customizing the truncation process allows flexibility in management of
> guest_memfd memory and customization of the inode freeing process
> allows proper cleanup of memory metadata stored on the inode.
> 
> Memory metadata is more appropriately stored on the inode (as opposed
> to the file), since the metadata is for the memory and is not unique
> to a specific binding and struct kvm.
> 
> Co-developed-by: Fuad Tabba <tabba@google.com>
> Signed-off-by: Fuad Tabba <tabba@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---

[...]

>   
>   #include "kvm_mm.h"
>   
> +static struct vfsmount *kvm_gmem_mnt;
> +
>   struct kvm_gmem {
>   	struct kvm *kvm;
>   	struct xarray bindings;
> @@ -388,9 +392,51 @@ static struct file_operations kvm_gmem_fops = {
>   	.fallocate	= kvm_gmem_fallocate,
>   };
>   
> -void kvm_gmem_init(struct module *module)
> +static const struct super_operations kvm_gmem_super_operations = {
> +	.statfs		= simple_statfs,
> +};
> +
> +static int kvm_gmem_init_fs_context(struct fs_context *fc)
> +{
> +	struct pseudo_fs_context *ctx;
> +
> +	if (!init_pseudo(fc, GUEST_MEMFD_MAGIC))
> +		return -ENOMEM;
> +
> +	ctx = fc->fs_private;
> +	ctx->ops = &kvm_gmem_super_operations;

Curious, why is that required? (secretmem doesn't have it, so I wonder)

> +
> +	return 0;
> +}
> +
> +static struct file_system_type kvm_gmem_fs = {
> +	.name		 = "kvm_guest_memory",

It's GUEST_MEMFD_MAGIC but here "kvm_guest_memory".

For secretmem it's SECRETMEM_MAGIC vs. "secretmem".

So naturally, I wonder if that is to be made consistent :)

> +	.init_fs_context = kvm_gmem_init_fs_context,
> +	.kill_sb	 = kill_anon_super,
> +};
> +
> +static int kvm_gmem_init_mount(void)
> +{
> +	kvm_gmem_mnt = kern_mount(&kvm_gmem_fs);
> +
> +	if (IS_ERR(kvm_gmem_mnt))
> +		return PTR_ERR(kvm_gmem_mnt);
> +
> +	kvm_gmem_mnt->mnt_flags |= MNT_NOEXEC;
> +	return 0;
> +}
> +
> +int kvm_gmem_init(struct module *module)
>   {
>   	kvm_gmem_fops.owner = module;
> +
> +	return kvm_gmem_init_mount();
> +}
> +
> +void kvm_gmem_exit(void)
> +{
> +	kern_unmount(kvm_gmem_mnt);
> +	kvm_gmem_mnt = NULL;
>   }
>   
>   static int kvm_gmem_migrate_folio(struct address_space *mapping,
> @@ -472,11 +518,71 @@ static const struct inode_operations kvm_gmem_iops = {
>   	.setattr	= kvm_gmem_setattr,
>   };
>   
> +static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
> +						      loff_t size, u64 flags)
> +{
> +	struct inode *inode;
> +
> +	inode = anon_inode_make_secure_inode(kvm_gmem_mnt->mnt_sb, name, NULL);
> +	if (IS_ERR(inode))
> +		return inode;
> +
> +	inode->i_private = (void *)(unsigned long)flags;
> +	inode->i_op = &kvm_gmem_iops;
> +	inode->i_mapping->a_ops = &kvm_gmem_aops;
> +	inode->i_mode |= S_IFREG;
> +	inode->i_size = size;
> +	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
> +	mapping_set_inaccessible(inode->i_mapping);
> +	/* Unmovable mappings are supposed to be marked unevictable as well. */
> +	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
> +
> +	return inode;
> +}
> +
> +static struct file *kvm_gmem_inode_create_getfile(void *priv, loff_t size,
> +						  u64 flags)
> +{
> +	static const char *name = "[kvm-gmem]";
> +	struct inode *inode;
> +	struct file *file;
> +	int err;
> +
> +	err = -ENOENT;
> +	if (!try_module_get(kvm_gmem_fops.owner))
> +		goto err;

Curious, shouldn't there be a module_put() somewhere after this function 
returned a file?

> +
> +	inode = kvm_gmem_inode_make_secure_inode(name, size, flags);
> +	if (IS_ERR(inode)) {
> +		err = PTR_ERR(inode);
> +		goto err_put_module;
> +	}
> +
> +	file = alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR,
> +				 &kvm_gmem_fops);
> +	if (IS_ERR(file)) {
> +		err = PTR_ERR(file);
> +		goto err_put_inode;
> +	}
> +
> +	file->f_flags |= O_LARGEFILE;
> +	file->private_data = priv;
> +
>

Nothing else jumped at me.

-- 
Cheers,

David / dhildenb


