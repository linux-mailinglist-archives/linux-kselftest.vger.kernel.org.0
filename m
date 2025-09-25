Return-Path: <linux-kselftest+bounces-42315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FA5B9F08C
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 13:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A0E1BC829B
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 11:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD7E2FDC25;
	Thu, 25 Sep 2025 11:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJkX5mhk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD202FBE07
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 11:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758801336; cv=none; b=HLhaVEbNlBJjDj0WNPaJDucjNvBMXRojBCTnygTG7D7K2LAh9rH2HTnRpQw0As2YBt5MmTLM0+ceO5ono3D/+iNfxy8OjBmcXpGE6MyP0bYf3Yk/2++HviIrDAlFqBvcwtDSliiyzQhCyJ+9wU3CVrlQZAgG9dbf/KhOczun28w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758801336; c=relaxed/simple;
	bh=+fP0M0ulLkKRfiYmi7kvzBtJSxdpLTHFIV0AyZ8rGr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WzxqK4VTfhbEtCMEVQTVMfRzVcJ9EsfDXLQ3h7o+p33iIe/74WwWXZ1wn1jJZNsIo3ZQFOmXyo/LWB60zQjxew1MNJUBEaMf3LCK67DNPe8MXD24cSbgG8VTJ1w6LOkEF1HAZIWUKFaYVPyHSF2Qjjyt83MiW6lmY8owk9MwrM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NJkX5mhk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758801333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SCbRU8MveS1pgXPDEzPy2kt340UB03o/vXxtaoaDWAc=;
	b=NJkX5mhkzxPQya2MmhiH+5FEF5FrSa/jZgUe0ZAhDzuxe1kxrRIy7OCxkqaQPJvWGNIy2o
	Ln6ICBCKbDUORdGzzvRKmYcNsmJMRT0hegRBfMGEQkzmnflfaFeXerfNE0c2O+Lq5XktxX
	KX5yI6nOhq4tmUqpUfNjulCHks6m+4I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-wnwT60ijMsu73P2glgM80g-1; Thu, 25 Sep 2025 07:55:32 -0400
X-MC-Unique: wnwT60ijMsu73P2glgM80g-1
X-Mimecast-MFC-AGG-ID: wnwT60ijMsu73P2glgM80g_1758801331
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45cb604427fso5133645e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 04:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758801331; x=1759406131;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCbRU8MveS1pgXPDEzPy2kt340UB03o/vXxtaoaDWAc=;
        b=bVvQPJsqV/k6v5phn55Frcp8Mz4UuSQ3vlfxTjohfCwTpVmW7171a3TMZfRHvza5lj
         SybrSuqPxge+bXV4YArU1m2hN2tXXNgnUEYxwTiQAc2/4jheVzWQvsJb8FCT6Dnxs2b3
         4lL3umqqeBP4jAoWq3yxkj2A96yuqClt+vDwkLCM/tkXSDmLsmZPcDN3TYEFPXdQe9Zi
         U2K11nN1FIhtGuHA9wxiu13Fd4o2fnEHXGpUOeyZD7/KwRjp5L9EZeP/SPunP10IAMP3
         /DYr6OxZpZcCe9tgyG5G8WFAuMrAhS2v9+qB17+HujmasUuepPb/mC6MVfoEqbt2LBKW
         xcJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv+3jnBm4q4/PfIipJ12HYqFTfX8+DTs+oX1JKDGo4wB2+FKCHj/YtxyCGGkp9Ly+H/5meBEUGn3eHbAOpPE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC+cOgaOG+HmDaM2RkSuvFDBqnrZJSx+gmqbpRecOmaxQkP+vO
	+1RzETSaeqLG9Bj+rSoc+R1IqAmqEKNv0fynI5KPatG916SXNZMMN+Ty0BgWYvlc08HL0NeUiZN
	AtRV54uZEwi/JZbjcQuCAxh0CcCPGPDFVO6w2Ix0dRe3VdacMhsq5ZEiaCxS3rzh758g3Nw==
X-Gm-Gg: ASbGncvzQ4YyIjZoh2U10uy9aGBf/w/p7zpzAauwAZnPNMvLbiLB2rOumGc3ou5tlo6
	wAk6pp6TehY85lz70VOpK+CSF6hkLW9QaEMddsJ+JB6446SWLnrqI95JWIx5gPXStpWq31k13J3
	L+XDRYwWGr/C/5gSsnsOwScTsfUuJEXW1oM85aqGr31mxB/ycoPbqEOUmiT8+0NWz/zwWGZ2mJ+
	rXYH0TivMeT1fiC3AWV1VWd4IJsqbWAHeLV4Tvn7Emg6Zrdne2b6IYBTQWHsGBmk9jn3T4okV9J
	+Mjt9n3PvHe/QOLY2/00EFTcvZ0L8MU1aDM6U0RCOnC1MxrEhKzBCy7NWOC+vzJ812OJWRiYUzN
	gbkicWLajiAPTq3McW/5DZ/DjOA18VfYRixaf4SfuRlOQJbDnRPDk+dBfvAR3CHEia3es
X-Received: by 2002:a05:600c:c83:b0:46e:1c2d:bc84 with SMTP id 5b1f17b1804b1-46e329eb10emr33699245e9.17.1758801330667;
        Thu, 25 Sep 2025 04:55:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt88AWAVfrsW7XtYeqx9eAlzDx2ZLFWRXrQuLhkskEblyKaQxcWglP3fS9EKwD9xW0YpDiXg==
X-Received: by 2002:a05:600c:c83:b0:46e:1c2d:bc84 with SMTP id 5b1f17b1804b1-46e329eb10emr33698205e9.17.1758801329980;
        Thu, 25 Sep 2025 04:55:29 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08? (p200300d82f3ff800c1015c9f3bc93d08.dip0.t-ipconnect.de. [2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33b562d8sm31593705e9.0.2025.09.25.04.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 04:55:29 -0700 (PDT)
Message-ID: <b67dd7cd-2c1c-4566-badf-32082d8cd952@redhat.com>
Date: Thu, 25 Sep 2025 13:55:26 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kvm-next V11 4/7] KVM: guest_memfd: Use guest mem inodes
 instead of anonymous inodes
To: "Garg, Shivank" <shivankg@amd.com>,
 Sean Christopherson <seanjc@google.com>,
 Ackerley Tng <ackerleytng@google.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, pbonzini@redhat.com,
 shuah@kernel.org, vbabka@suse.cz, brauner@kernel.org,
 viro@zeniv.linux.org.uk, dsterba@suse.com, xiang@kernel.org,
 chao@kernel.org, jaegeuk@kernel.org, clm@fb.com, josef@toxicpanda.com,
 kent.overstreet@linux.dev, zbestahu@gmail.com, jefflexu@linux.alibaba.com,
 dhavale@google.com, lihongbo22@huawei.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 tabba@google.com, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 pvorel@suse.cz, bfoster@redhat.com, vannapurve@google.com,
 chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com,
 shdhiman@amd.com, yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com,
 thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com, jgg@nvidia.com,
 kalyazin@amazon.com, peterx@redhat.com, jack@suse.cz, hch@infradead.org,
 cgzones@googlemail.com, ira.weiny@intel.com, rientjes@google.com,
 roypat@amazon.co.uk, chao.p.peng@intel.com, amit@infradead.org,
 ddutile@redhat.com, dan.j.williams@intel.com, ashish.kalra@amd.com,
 gshan@redhat.com, jgowans@amazon.com, pankaj.gupta@amd.com,
 papaluri@amd.com, yuzhao@google.com, suzuki.poulose@arm.com,
 quic_eberman@quicinc.com, linux-bcachefs@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-coco@lists.linux.dev
References: <20250827175247.83322-2-shivankg@amd.com>
 <20250827175247.83322-7-shivankg@amd.com> <diqztt1sbd2v.fsf@google.com>
 <aNSt9QT8dmpDK1eE@google.com> <dc6eb85f-87b6-43a1-b1f7-4727c0b834cc@amd.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <dc6eb85f-87b6-43a1-b1f7-4727c0b834cc@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.09.25 13:44, Garg, Shivank wrote:
> 
> 
> On 9/25/2025 8:20 AM, Sean Christopherson wrote:
>> My apologies for the super late feedback.  None of this is critical (mechanical
>> things that can be cleaned up after the fact), so if there's any urgency to
>> getting this series into 6.18, just ignore it.
>>
>> On Wed, Aug 27, 2025, Ackerley Tng wrote:
>>> Shivank Garg <shivankg@amd.com> writes:
>>> @@ -463,11 +502,70 @@ bool __weak kvm_arch_supports_gmem_mmap(struct kvm *kvm)
>>>   	return true;
>>>   }
>>>
>>> +static struct inode *kvm_gmem_inode_create(const char *name, loff_t size,
>>> +					   u64 flags)
>>> +{
>>> +	struct inode *inode;
>>> +
>>> +	inode = anon_inode_make_secure_inode(kvm_gmem_mnt->mnt_sb, name, NULL);
>>> +	if (IS_ERR(inode))
>>> +		return inode;
>>> +
>>> +	inode->i_private = (void *)(unsigned long)flags;
>>> +	inode->i_op = &kvm_gmem_iops;
>>> +	inode->i_mapping->a_ops = &kvm_gmem_aops;
>>> +	inode->i_mode |= S_IFREG;
>>> +	inode->i_size = size;
>>> +	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
>>> +	mapping_set_inaccessible(inode->i_mapping);
>>> +	/* Unmovable mappings are supposed to be marked unevictable as well. */
>>> +	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
>>> +
>>> +	return inode;
>>> +}
>>> +
>>> +static struct file *kvm_gmem_inode_create_getfile(void *priv, loff_t size,
>>> +						  u64 flags)
>>> +{
>>> +	static const char *name = "[kvm-gmem]";
>>> +	struct inode *inode;
>>> +	struct file *file;
>>> +	int err;
>>> +
>>> +	err = -ENOENT;
>>> +	/* __fput() will take care of fops_put(). */
>>> +	if (!fops_get(&kvm_gmem_fops))
>>> +		goto err;
>>> +
>>> +	inode = kvm_gmem_inode_create(name, size, flags);
>>> +	if (IS_ERR(inode)) {
>>> +		err = PTR_ERR(inode);
>>> +		goto err_fops_put;
>>> +	}
>>> +
>>> +	file = alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR,
>>> +				 &kvm_gmem_fops);
>>> +	if (IS_ERR(file)) {
>>> +		err = PTR_ERR(file);
>>> +		goto err_put_inode;
>>> +	}
>>> +
>>> +	file->f_flags |= O_LARGEFILE;
>>> +	file->private_data = priv;
>>> +
>>> +	return file;
>>> +
>>> +err_put_inode:
>>> +	iput(inode);
>>> +err_fops_put:
>>> +	fops_put(&kvm_gmem_fops);
>>> +err:
>>> +	return ERR_PTR(err);
>>> +}
>>
>> I don't see any reason to add two helpers.  It requires quite a bit more lines
>> of code due to adding more error paths and local variables, and IMO doesn't make
>> the code any easier to read.
>>
>> Passing in "gmem" as @priv is especially ridiculous, as it adds code and
>> obfuscates what file->private_data is set to.
>>
>> I get the sense that the code was written to be a "replacement" for common APIs,
>> but that is nonsensical (no pun intended).
>>
>>>   static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>>>   {
>>> -	const char *anon_name = "[kvm-gmem]";
>>>   	struct kvm_gmem *gmem;
>>> -	struct inode *inode;
>>>   	struct file *file;
>>>   	int fd, err;
>>>
>>> @@ -481,32 +579,16 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>>>   		goto err_fd;
>>>   	}
>>>
>>> -	file = anon_inode_create_getfile(anon_name, &kvm_gmem_fops, gmem,
>>> -					 O_RDWR, NULL);
>>> +	file = kvm_gmem_inode_create_getfile(gmem, size, flags);
>>>   	if (IS_ERR(file)) {
>>>   		err = PTR_ERR(file);
>>>   		goto err_gmem;
>>>   	}
>>>
>>> -	file->f_flags |= O_LARGEFILE;
>>> -
>>> -	inode = file->f_inode;
>>> -	WARN_ON(file->f_mapping != inode->i_mapping);
>>> -
>>> -	inode->i_private = (void *)(unsigned long)flags;
>>> -	inode->i_op = &kvm_gmem_iops;
>>> -	inode->i_mapping->a_ops = &kvm_gmem_aops;
>>> -	inode->i_mode |= S_IFREG;
>>> -	inode->i_size = size;
>>> -	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
>>> -	mapping_set_inaccessible(inode->i_mapping);
>>> -	/* Unmovable mappings are supposed to be marked unevictable as well. */
>>> -	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
>>> -
>>>   	kvm_get_kvm(kvm);
>>>   	gmem->kvm = kvm;
>>>   	xa_init(&gmem->bindings);
>>> -	list_add(&gmem->entry, &inode->i_mapping->i_private_list);
>>> +	list_add(&gmem->entry, &file_inode(file)->i_mapping->i_private_list);
>>
>> I don't understand this change?  Isn't file_inode(file) == inode?
>>
>> Compile tested only, and again not critical, but it's -40 LoC...
>>
>>
> 
> Thanks.
> I did functional testing and it works fine.

I can queue this instead. I guess I can reuse the patch description and 
add Sean as author + add his SOB (if he agrees).

Let me take a look at the patch later in more detail.

-- 
Cheers

David / dhildenb


