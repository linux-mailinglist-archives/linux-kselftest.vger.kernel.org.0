Return-Path: <linux-kselftest+bounces-31448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC8EA99958
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 22:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72AC1B8437E
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 20:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6820268FF6;
	Wed, 23 Apr 2025 20:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hHQqEXr9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A7D1ACED5
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 20:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745439724; cv=none; b=GQk6TV7233dmJWhxgNGE9ZRU/QXr6AIgNF3/kbUcSTQDo4Gv12uIKYaTlgO9pKQ3c/Gtwt4GVohVcCqAMo0O1Lw3NR/OKHL4KxzEJ3z1C+SYa0qrVQfe8h7Bkj/t8a6Dk7HyHgoJmO3nqgUvpiVPLocXFLaXj+fRfqijVNFnpIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745439724; c=relaxed/simple;
	bh=IZnu6wdyPtClzTpUQpTWkf4YSITWNNs3ibqRNmz2PFA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kTzDeqnm8ALCUNlknyCRxfIOLi/VV8x2OJEJyZGOdLXR2kUXPcjArBPpmqtYYCc1E8R/LSgtsi3p8+Cf5gXBr+45w0ypkPwRXrT8TX3sJKh9m5Vk1rhRmq00JmNpmEnaLVBGFg3T/4N0EYo9XH+cuKLnk4FKI70nsyRGoDBYfdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hHQqEXr9; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736cd36189bso216838b3a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 13:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745439722; x=1746044522; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lb5Hj4079cmmz08gkncfU6HRHYwb2cTW68BpAu1pjpA=;
        b=hHQqEXr9+PCQ4471VW3+obysjcFBHCpHjIV3G5mc7ikxmkVFgjbFw0kd6heprsAb5E
         4SpRiAMULhDilLQdu5wJZpoGZrGz14err+IAB+Cg+9YjHzAQWuh9TEBAKM6ScOiGhQiV
         xyfd123JGEHSExNY+Zc4dNGUwQOlQ/AvV+mkiP0r1CP7Nolv+ugWrJsSmMaN2Zz/mRlt
         LbN6JuQ9354SJozUlEo3yqvZLR80idSITei1f0wBs3JlL0WOerfdZc1PKIMJrthWDXPY
         2NY6sRGVQRD9cHHYt2YbAv0vc8qS9wFxAdsZZXsglKMujjAAF9Q2RNrl/UMvPSaTRs0M
         TvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745439722; x=1746044522;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lb5Hj4079cmmz08gkncfU6HRHYwb2cTW68BpAu1pjpA=;
        b=malZnOl6kYyuM4b1H7rE35pJY38vkAc+uU5cdPANilPx6H19VRlvC2x6nQ5zGp1B1t
         fJ9VfUjLVGHSCThJ+qjiXcL1Zwac9r1ri0oo9pcvFojI07TVSh1DyIqTpRp5NDvKNTun
         mn+cdQ+CmeQ0fByHZzvqKMg0o77xTOFmcyCFmWSdPbA/o/XqbtDsYucq4ASWJ1fkuvOD
         9DFi4lAzpC6QE5EcQTUW4W49toEhywXuqZU4uya+1oWfv0TbZBzKGf6fqwIi4iOUWT/1
         64PZP4911M+cN9lwOBGVLgxEYCqSrIwEX4lQJnZI4QnMhJbhnsVhWygMBJU0N56iEWxP
         xItg==
X-Forwarded-Encrypted: i=1; AJvYcCUPRunKyGEjdZtiEY52Rg2z/tOrGqj7gvHWG5CniejJIctgipiWFYOMAfrZ2ardhgJ4g8W2wuJUwRfBRb2mYnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdJSH8fC/O5WDtNMx8Eh9mAR33krBH0QcUHDhw8Kq3l8aTWq9e
	IS03odTWw/ua6H7bl7XOTV/y1wWxq8TWWIr0eEKfNgO5r1XlflXB3oQTtESGNqclToOq7wEs/Nv
	+g60QIC8cfa6uY0eGGfgI+g==
X-Google-Smtp-Source: AGHT+IEZQzaRzavelSAVxJna7z3rzv2eWOXWrhC8lNuigMph7H21lihWm3EaY9BgIQuvCBgTk8eHqn8ZKABOoog4TQ==
X-Received: from pglc21.prod.google.com ([2002:a63:d15:0:b0:b14:9718:f939])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:ce48:b0:1f5:709d:e0c6 with SMTP id adf61e73a8af0-203cbd418efmr30504920637.42.1745439722591;
 Wed, 23 Apr 2025 13:22:02 -0700 (PDT)
Date: Wed, 23 Apr 2025 13:22:00 -0700
In-Reply-To: <Z+y2nU7KDmRpuISM@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com> <d1940d466fc69472c8b6dda95df2e0522b2d8744.1726009989.git.ackerleytng@google.com>
 <Z+y2nU7KDmRpuISM@yzhao56-desk.sh.intel.com>
Message-ID: <diqzselyzl07.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH 13/39] KVM: guest_memfd: Make guest mem use guest mem
 inodes instead of anonymous inodes
From: Ackerley Tng <ackerleytng@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
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

Yan Zhao <yan.y.zhao@intel.com> writes:

> Hi Ackerley,
>
> Not sure if below nits have been resolved in your latest code.
> I came across them and felt it's better to report them anyway.
>
> Apologies for any redundancy if you've already addressed them.

No worries, thank you so much for your reviews!

>
> On Tue, Sep 10, 2024 at 11:43:44PM +0000, Ackerley Tng wrote:
>> +static void kvm_gmem_init_mount(void)                                         
>> +{                                                                             
>> +     kvm_gmem_mnt = kern_mount(&kvm_gmem_fs);                                 
>> +     BUG_ON(IS_ERR(kvm_gmem_mnt));                                            
>> +                                                                              
>> +     /* For giggles. Userspace can never map this anyways. */                 
>> +     kvm_gmem_mnt->mnt_flags |= MNT_NOEXEC;                                   
>> +}                                                                             
>> +                                                                              
>>  static struct file_operations kvm_gmem_fops = {                               
>>       .open           = generic_file_open,                                     
>>       .release        = kvm_gmem_release,                                      
>> @@ -311,6 +348,8 @@ static struct file_operations kvm_gmem_fops = {            
>>  void kvm_gmem_init(struct module *module)                                     
>>  {                                                                             
>>       kvm_gmem_fops.owner = module;                                            
>> +                                                                              
>> +     kvm_gmem_init_mount();                                                   
>>  } 
> When KVM is compiled as a module, looks "kern_unmount(kvm_gmem_mnt)" is
> missing in the kvm_exit() path.
>
> This may lead to kernel oops when executing "sync" after KVM is unloaded or
> reloaded.
>

Thanks, Fuad will be addressing this in a revision of [1].

> BTW, there're lots of symbols not exported under mm.
>

Thanks again, is there a good way to do a build test for symbols not
being exported?  What CONFIG flags do you use?

>> +static struct file *kvm_gmem_inode_create_getfile(void *priv, loff_t size,
>> +						  u64 flags)
>> +{
>> +	static const char *name = "[kvm-gmem]";
>> +	struct inode *inode;
>> +	struct file *file;
>> +
>> +	if (kvm_gmem_fops.owner && !try_module_get(kvm_gmem_fops.owner))
>> +		return ERR_PTR(-ENOENT);
>> +
>> +	inode = kvm_gmem_inode_make_secure_inode(name, size, flags);
>> +	if (IS_ERR(inode))
> Missing module_put() here. i.e.,
>
> -       if (IS_ERR(inode))
> +       if (IS_ERR(inode)) {
> +               if (kvm_gmem_fops.owner)
> +                       module_put(kvm_gmem_fops.owner);
> +
>                 return ERR_CAST(inode);
> +       }
>

Thanks, Fuad will be addressing this in a revision of [1].

>> +		return ERR_CAST(inode);
>> +
>> +	file = alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR,
>> +				 &kvm_gmem_fops);
>> +	if (IS_ERR(file)) {
>> +		iput(inode);
>> +		return file;
>> +	}
>> +
>> +	file->f_mapping = inode->i_mapping;
>> +	file->f_flags |= O_LARGEFILE;
>> +	file->private_data = priv;
>> +
>> +	return file;
>> +}
>> +
>
> Thanks
> Yan

[1] https://lore.kernel.org/all/20250328153133.3504118-2-tabba@google.com/

