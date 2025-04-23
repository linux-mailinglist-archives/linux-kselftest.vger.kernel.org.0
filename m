Return-Path: <linux-kselftest+bounces-31460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD817A99B38
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 00:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F4168188DA60
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 22:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFFB1EB5E1;
	Wed, 23 Apr 2025 22:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j7gins0y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EC038382
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 22:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745446030; cv=none; b=E9vSKX8nSnFgf2+jkFwvcRWP7JmLA674oe5BdfGDAfG8/aUY66ZjEH2ajm+Ps28HExEfsJ/CtS3mWv48DAmOjVR9egvSU/TxReeXv5Y8WIxd4HG+RCuBmUJE0L0VGMVyWPa5s2MOsdxwQrqVOL+94RqoXcWSJDEKyGoawBJB+2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745446030; c=relaxed/simple;
	bh=bp28noHFXI39rusqUs8gwSpotivluw23XX7A5HKSIyY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=otyrIxIAIeksNcGrsLFLo9VJ1R7M8puUhuKg/oHzNqUwkX9wNy4qVN8/nIOW0RSjZykkl/+KZwfoBZRwGQCHri6WyL0Pv4IWiCPdfHroZBRQu+Y6Gh0ZEQ90uEjyHizq7OmDOar9Y+jEPfE7G5xfYRvnvpXHTqQdbV+zcscRVR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j7gins0y; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7398d70abbfso354874b3a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 15:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745446028; x=1746050828; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=utY/3ZiZMMWfdAOVaunsuvsNTPOFiHttGwR5vylAKHw=;
        b=j7gins0yjzcNXk2k7aYPdxq5dLq+fcHbYDtm944oh6TIvVs4R5h7S+4qj0XOde7EKx
         9YqoUoQbUjtp3oc27Lsd0UKN0/WD3hiauZ6GqblzkPZ37dH+jI785SVuAJko0NxyBwSk
         nU6pG4bPxxZuatrKWE8LLww11QQZpS4jCuYYQ6I32eBafBVQ0Z32jf85Isk6LWbOMOf/
         BT/jdgH77gxvyJKF6TFv2F6g8MKEzfT2+X2GOOye568qXeUUBGEHOXocpwf1IQmry5I4
         u4sSrq85/NqcuLCOVDPoegVkeACP1HN1LXVXslqbS5fZ6hghVX/VZiAfM+TsIKA3WS9h
         VJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745446028; x=1746050828;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=utY/3ZiZMMWfdAOVaunsuvsNTPOFiHttGwR5vylAKHw=;
        b=sg6mERkw5Kf/1T5Lg9vD7rRkHV6VnZiinVQDXaWQb8h0C1NRvUbE2TpyXRtQVVni84
         byoli63bc9qaCHfIVRdSVB03JBtFRPK/NwI0tcvrLDpOl7n4QcCv+xC/f7t/k6YB8F/P
         yNSZPIu/67RFfX+1YPOU2xsAxO/aCBI4546wYEwJwa5swARhWcFGVZc6eOewr1MmAJE/
         X441/827xkV5SBfGCnWQmgG6ZWrhQtLNDMCVyo90IRodo+3ixk/aVnEmMM0/88XVGP4t
         RUQ89ib7cE3T0pay71PFFTXbAVHRiYKfwDCguGR/xcP3jxuiHCZBt+e1msICgmRMfx+E
         HgmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO+Fh0cfLl2s47mnSgswBqRY+bzRl1leTzMS1elodFGtQVcFLP9wWLBMst0zo9ETN+k/ofde8p4lRZ8bnoINI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZj8fkUJOmR9ujs8Ryj0hjq8MbbOvUjO0ah4trE9mh24woUqD2
	P7Eq3eKXUUc5JXc+YlZ0nOB83zfRRJHkfzcWMYEUaRnD3I5jekFIbstHAKnfn3vvB5+mLaO93xz
	4ALIqzhTnCg6VUbSV7pDmrQ==
X-Google-Smtp-Source: AGHT+IGY+pnHq2DQX/HQySosr6MoIfIEbH4ov9YBubqcg0pcHfTCmXDOga+QBFHTjyVSBCstaBHNJFn3Q1wqnKPotg==
X-Received: from pfx55.prod.google.com ([2002:a05:6a00:a477:b0:736:4ad6:1803])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3018:b0:736:4e02:c543 with SMTP id d2e1a72fcca58-73e245e3bc0mr500238b3a.9.1745446027829;
 Wed, 23 Apr 2025 15:07:07 -0700 (PDT)
Date: Wed, 23 Apr 2025 15:07:06 -0700
In-Reply-To: <Z74p8-l6BhOmR1B_@x1.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com> <bd163de3118b626d1005aa88e71ef2fb72f0be0f.1726009989.git.ackerleytng@google.com>
 <Z74p8-l6BhOmR1B_@x1.local>
Message-ID: <diqzecxizg51.fsf@ackerleytng-ctop.c.googlers.com>
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
>> @@ -1079,12 +1152,20 @@ static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
>>  	if (err)
>>  		goto out;
>>  
>> +	err = -ENOMEM;
>> +	private = kzalloc(sizeof(*private), GFP_KERNEL);
>> +	if (!private)
>> +		goto out;
>> +
>>  	if (flags & KVM_GUEST_MEMFD_HUGETLB) {
>> -		err = kvm_gmem_hugetlb_setup(inode, size, flags);
>> +		err = kvm_gmem_hugetlb_setup(inode, private, size, flags);
>>  		if (err)
>> -			goto out;
>> +			goto free_private;
>>  	}
>>  
>> +	xa_init(&private->faultability);
>> +	inode->i_mapping->i_private_data = private;
>> +
>>  	inode->i_private = (void *)(unsigned long)flags;
>
> Looks like inode->i_private isn't used before this series; the flags was
> always zero before anyway.  Maybe it could keep kvm_gmem_inode_private
> instead? Then make the flags be part of the struct.
>
> It avoids two separate places (inode->i_mapping->i_private_data,
> inode->i_private) to store gmem private info.
>

Weakly-held opinion: I think the advantage of re-using inode->i_private
to store flags is that in some cases, e.g. non-hugetlb, we might be able
to avoid an allocation (of kvm_gmem_inode_private).

Does anyone else have any thoughts on this?

>>  	inode->i_op = &kvm_gmem_iops;
>>  	inode->i_mapping->a_ops = &kvm_gmem_aops;
>> @@ -1097,6 +1178,8 @@ static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
>>  
>>  	return inode;
>>  
>> +free_private:
>> +	kfree(private);
>>  out:
>>  	iput(inode);
>>  
>> -- 
>> 2.46.0.598.g6f2099f65c-goog
>> 
>
> -- 
> Peter Xu

