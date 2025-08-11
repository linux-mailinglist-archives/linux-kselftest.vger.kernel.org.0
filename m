Return-Path: <linux-kselftest+bounces-38684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FBEB2109A
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 18:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D2D3B4367
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 15:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BE12E7167;
	Mon, 11 Aug 2025 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dh/LHX1J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2F22D4815
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926445; cv=none; b=ee7P04fNeVAdufyVe4ldLBOED9bui7HQ1vqXQSrFBt5rhgWlJk5ToPSabOid7BTTD1BR+XA7ODgY1BwduV4Wx+/HyTVWELy/ygOh/qT4hnI8BPa/jc9BD1Bk4Dfz90xElL/gTdc0bOstssDZM7E93CUBg4R+NSzvuZShn7r/JVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926445; c=relaxed/simple;
	bh=x3Gjjg/HNG+YNIf+BJSKZ7zx9EJlyvS9DJ5A8csDFq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tknd1sIjNwk1CnTwc8+sldmCrvNnxlHusdp6RV8b/WF6xbkEYAsJKQg1CEs7otb/N8XUoeLDs2SFa04NSVlnxdz7l2yBvuNpAEPWTWdgP6ipvwQRX7Nzz8OgPiuhFlSOI8xoOiyp6Sc28q78SxdeGmELndaCm3VtbBmJFeEQzMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dh/LHX1J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754926441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UlyMvpUnFPwPIrW3E7xZ89HT91V0N5XoNHgGKm394UY=;
	b=Dh/LHX1JKysEGLodY7EdveyqnDz+HVGARQ4STcNFW8a1ksEhVLXkV1gMPo05MSgE9PQ8b/
	4dE+I0/db/eKvktUA3QX9hapRgx9VIAJS6RHwRkhD2gnqmkgVcZ3STKDT4j47NL5EjidhF
	NTckDpn8xrJpBK6grhmGvPiYJPRO8rk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-fd0cQzm-NIeymP6JU7wItQ-1; Mon, 11 Aug 2025 11:34:00 -0400
X-MC-Unique: fd0cQzm-NIeymP6JU7wItQ-1
X-Mimecast-MFC-AGG-ID: fd0cQzm-NIeymP6JU7wItQ_1754926439
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-459d7da3647so38262935e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 08:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754926439; x=1755531239;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UlyMvpUnFPwPIrW3E7xZ89HT91V0N5XoNHgGKm394UY=;
        b=nAglt8PQvTExbT3AXaOtIM7K/Ub5b0EYy5JxS/e6xpJI8w1g2k7QH9TSyoIgbYIR05
         5aiPy9eKd13mFRcXGC9VF7YRPnJIiqLzUDyBg4i1gQg43NVPr5Js9iNqhkxjaZ5JQOo3
         MPNm1rOyJrx8nTmOu1/pzRysgRUhxMXyTtQJaBN2qQlKAvSXI0BmuK/+iMnFHT+FTlsZ
         NN6hdqT2I6UM0KSJiN+eUuIObOn44QxMp6j8YoHIaaDcRVH3UCVoVdoJ2xghh2Y/hTQA
         z81h46nMyDuD3ZwihxfgYJwdZ8r5SQttryS5L0UNXA5pUj9pv6DjkNZA+bochnmGSYzu
         uXgg==
X-Forwarded-Encrypted: i=1; AJvYcCWkttB9PXkzmkfXsTCvwQ2MzDsDcx9fXsGYoNA3bflLE/SCbRsDuT+DXkKSDmo26Ledz9q7DZte6P4Urjbg0cU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwenLLU45namCSMU25v+hWoDKxjsehPY6EKsSBSM79lurafSOLc
	HSXS+7l4ElOQSTmVcPTlRzElkNV3U8SZNKqZjYlx0LuPy6Kgmf9Cf8tyi5Y4y8m/3sAWi3nMXIt
	qdlRLn8hS4WqfQTuUzPG3fU/pEF+DrQdLXDpeiig6cZpzxyz4hexZD2c/HvVz5CJ6H5e6KQ==
X-Gm-Gg: ASbGncthKlRUs1Q1FNbQszYU/zP00m6ZJZaVrS9csrx997MhQexK+7+SSR3MOQJtvHt
	U6YisnGXQcWzMgwM+bUGUM4SViUISgAlDxWl2tCdVXFiLTTpMDAY+xQUqzwWSXKKNuS2trFttmI
	lgqsOQcyr3WK4Dh22Ig4polHCwxXgFvp4UA1LKLYytK2vn2hJiImIwc3+70bYOVjpMN1hVFE2la
	V9F+TTw35HWzgXeP6cp8WRYns8vmpgM7Pn9T54cnrOepuDdhNpReF22EMxUeyhRGKmodu+pRaD8
	glgN6x8zhcjmK4KttEdDYFaC8+91ZEmFn+D/NnPSFW+E0Ati2EUrl7Er8Kx4noYwh+vPyUWSkyz
	RKYb+9BwURoqoPanabOvQnID/yhGe3gz01/tcF9y0AoOFmpeO+qSX1No8Z4x1wF7JIEE=
X-Received: by 2002:a05:600c:1d02:b0:43c:fe5e:f03b with SMTP id 5b1f17b1804b1-459f4fc25cfmr136879115e9.30.1754926438481;
        Mon, 11 Aug 2025 08:33:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHINfJIfd1vEQZgbnQNpr4RSjW8SQx0Umc0SOrTSEmk4pWketl28AJxCUWIgT4ujrBbIgNggA==
X-Received: by 2002:a05:600c:1d02:b0:43c:fe5e:f03b with SMTP id 5b1f17b1804b1-459f4fc25cfmr136878395e9.30.1754926437911;
        Mon, 11 Aug 2025 08:33:57 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f06:a600:a397:de1d:2f8b:b66f? (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58542f3sm257349755e9.10.2025.08.11.08.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 08:33:57 -0700 (PDT)
Message-ID: <cee2e489-d3c9-46d4-8d34-37c637c7bbd8@redhat.com>
Date: Mon, 11 Aug 2025 17:33:54 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V10 4/7] KVM: guest_memfd: Use guest mem inodes
 instead of anonymous inodes
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
References: <20250811090605.16057-2-shivankg@amd.com>
 <20250811090605.16057-10-shivankg@amd.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250811090605.16057-10-shivankg@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.08.25 11:06, Shivank Garg wrote:
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
>   static int kvm_gmem_migrate_folio(struct address_space *mapping,
> @@ -463,11 +503,71 @@ bool __weak kvm_arch_supports_gmem_mmap(struct kvm *kvm)
>   	return true;
>   }
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

Maybe add a comment here when the module reference will get
dropped. And maybe we should just switch to fops_get() + fops_put?

/* __fput() will take care of fops_put(). */
if (!fops_get(&kvm_gmem_fops))
	goto err;

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
> +out:
> +	return file;
> +
> +err_put_inode:
> +	iput(inode);
> +err_put_module:
> +	module_put(kvm_gmem_fops.owner);

fops_put(&kvm_gmem_fops);

?


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


