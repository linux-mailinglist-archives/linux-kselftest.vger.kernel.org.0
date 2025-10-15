Return-Path: <linux-kselftest+bounces-43266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A925BBE0DA5
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 23:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F28363BC743
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 21:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D362A302CC9;
	Wed, 15 Oct 2025 21:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SO/erE3w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62082C234E
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 21:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760564764; cv=none; b=W9rDwb++75hqYK5TEcR8Z6OmR4VQC56CN1Zrd2+MQTEeFqidNkO1qjWvigVy4wAgUm24BBWChKWu2p1cW4KGD9o4NkYC8fmO/78+stg54SqVYa+A2qyA0B6drwyNq1kw6gTHhbthoXdCTq8QzDTfitK2ojGogVb6ntbZEN5zNQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760564764; c=relaxed/simple;
	bh=4aIc9dx+BqTIrEkxhdIkDUsdv2I7S3jqyih5WAzO4pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjiSjWey9r1XdwHYijncmzX0+8FcKQKbUQvEcSEUplf5Gesibwiz7MCCT3qYMC/0dM0NuZ/BDRGGbyeWvgpgM4ChoQOw9AsqbsMftyRhCUC4qQ9M9lrZ36PCf2CgJ1WFsNgZ49MOuqCgHnHAg3jUTNjJO+zY5h3j9s1qSuEFByk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SO/erE3w; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-85ed0a1b35dso5189385a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 14:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760564762; x=1761169562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L3FMg1FEv7ZUbFziIBjfrlMH5r4d6/IdcxKlJL9nOzQ=;
        b=SO/erE3wHFHNuhgXeAZMBhu+vRvj7I6znm+CPL4BUW4goPdcy4g1QHzQL69WLJ2s8q
         E9XIlB5UDV6XaLXR+adHFPpFzFQAPnRiZz6c1pVa3Vsf+/ObMAds6HiemfQpTm77nYiX
         I6v+DY9WOXM1LxV1Fv/BRfRPH1bdCqOMm+9RClKU2i2IGD4sGuWvM/C120Vfy9E5poDt
         k+j7Bgbt+84RvIqxSqPtJtsBhEKo8Y+qfc05eLBmKC6Etw8GH5T2DQp1zPzMIAxWDB06
         +L7Y9jibEw/rFQ+iPZIo5d0xG27yM1nM0UtT98rjkS1AB30KI0SO5nAuyvgshUiJahfv
         QRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760564762; x=1761169562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3FMg1FEv7ZUbFziIBjfrlMH5r4d6/IdcxKlJL9nOzQ=;
        b=j/A/gzR75bs6YkKnY5IN97GOnpF5CxRHdKs5vfyfSOBLfoO6d1gQgVkoo42S6L2jeE
         uxtmSESBu4QUKYtSJtlbxayKpBEr6dwhknnhTCuiK+c8Lexnssuw0gRpT4wJkprlNMe0
         VLbgMkt9eNsQcFKqxsbrK0eRJqwZlqA3Xh46NjEC5EKdqi7WIZIQ/g42YddPXHq8PJG6
         IS8QWwzP2HkJhPg+Ed4qG4cc5IACDq0BxPzd7IEUV1oxPyviTpe99dZNkhddw7NFu8va
         fQ4ylmd8tV3HT/F6n/F7xf84vKPyVdBkksr9dwjQH6la2PCHrW7qaxUC2UzeBN8Dq/ml
         9eog==
X-Forwarded-Encrypted: i=1; AJvYcCUgE13Lk1WwptSNXgvoY4aHQoHDuYXzDB9n72/RlgO6526+jYHCZLzscnUSPgDG8niq0GDWA0G0yqy3ljq2MYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdPVxhB2qlUqfdENSI2WuPm0q/dbUHjfw+6J+EOT4lSXohGCoE
	arZuUg19or2xTErSs1SSxN3KvwgmHrmNWSff8aNM/9XezTSCuYqeUFrjA1NUqWvYSBI=
X-Gm-Gg: ASbGncucyPS+zTF6ApKsnxYMhV1OuV4SQO3NiTM2pHBPgv0DvfXtsLb2nQzoH605i/g
	sJkh6fYx3dcG/qmodpBL0TLpUfOWSsWjZvKUb+ggOWZoL6KnywvqcV6REviF7ivPKx59x2+1ckT
	uhT4Dt7ofnMHCIF4L43etSEyts9QaEgSyjt/WPy7GssGvm3fC47mSFVodTKAvQm8VEKDAV/Lsg6
	k64mfC8/t2TpDp1bPVwcOxAMhVWkeKhqK247Q+dsKS3A9D5uXfsWb4IVhN8UErL+f2iW2c/FJqD
	fvsOq/v4LXWHI+fSFu0WBaw17pWOxW8Hnqu2ytZs15RHuDhdGxCmV2E8bit6YqWmT3r4ln+dgp4
	546QHaP/1b7DCzFpgI8IrJ82wkN10YeM3iY5WSzeBbhlDUzUGkfLkhxZ7y/bHzgJ4jUGW8fKYKC
	ffy6v6U7tj2Fz5idUhi6ezOC9L3h0Z9Fr4pdIvjkB3q0IdSeaRtReqO5L3r9J1JdRhem0epQ==
X-Google-Smtp-Source: AGHT+IGFaJmIXEF9qOWREfnISohaPtcOawCiX32gOo0axLN0cRb3DCKNrFn66v9UE7KAPGfO0N4wTQ==
X-Received: by 2002:a05:620a:1a02:b0:88e:86a3:98f1 with SMTP id af79cd13be357-88e86a39b78mr380325385a.45.1760564761659;
        Wed, 15 Oct 2025 14:46:01 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-88f37e50ebasm56360985a.31.2025.10.15.14.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:46:00 -0700 (PDT)
Date: Wed, 15 Oct 2025 17:45:57 -0400
From: Gregory Price <gourry@gourry.net>
To: Sean Christopherson <seanjc@google.com>
Cc: Shivank Garg <shivankg@amd.com>, jgowans@amazon.com, mhocko@suse.com,
	jack@suse.cz, kvm@vger.kernel.org, david@redhat.com,
	linux-btrfs@vger.kernel.org, aik@amd.com, papaluri@amd.com,
	kalyazin@amazon.com, peterx@redhat.com, linux-mm@kvack.org,
	clm@fb.com, ddutile@redhat.com, linux-kselftest@vger.kernel.org,
	shdhiman@amd.com, gshan@redhat.com, ying.huang@linux.alibaba.com,
	shuah@kernel.org, roypat@amazon.co.uk, matthew.brost@intel.com,
	linux-coco@lists.linux.dev, zbestahu@gmail.com,
	lorenzo.stoakes@oracle.com, linux-bcachefs@vger.kernel.org,
	ira.weiny@intel.com, dhavale@google.com, jmorris@namei.org,
	willy@infradead.org, hch@infradead.org, chao.gao@intel.com,
	tabba@google.com, ziy@nvidia.com, rientjes@google.com,
	yuzhao@google.com, xiang@kernel.org, nikunj@amd.com,
	serge@hallyn.com, amit@infradead.org, thomas.lendacky@amd.com,
	ashish.kalra@amd.com, chao.p.peng@intel.com, yan.y.zhao@intel.com,
	byungchul@sk.com, michael.day@amd.com, Neeraj.Upadhyay@amd.com,
	michael.roth@amd.com, bfoster@redhat.com, bharata@amd.com,
	josef@toxicpanda.com, Liam.Howlett@oracle.com,
	ackerleytng@google.com, dsterba@suse.com, viro@zeniv.linux.org.uk,
	jefflexu@linux.alibaba.com, jaegeuk@kernel.org,
	dan.j.williams@intel.com, surenb@google.com, vbabka@suse.cz,
	paul@paul-moore.com, joshua.hahnjy@gmail.com, apopple@nvidia.com,
	brauner@kernel.org, quic_eberman@quicinc.com, rakie.kim@sk.com,
	cgzones@googlemail.com, pvorel@suse.cz,
	linux-erofs@lists.ozlabs.org, kent.overstreet@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, pankaj.gupta@amd.com,
	linux-security-module@vger.kernel.org, lihongbo22@huawei.com,
	linux-fsdevel@vger.kernel.org, pbonzini@redhat.com,
	akpm@linux-foundation.org, vannapurve@google.com,
	suzuki.poulose@arm.com, rppt@kernel.org, jgg@nvidia.com
Subject: Re: [f2fs-dev] [PATCH kvm-next V11 6/7] KVM: guest_memfd: Enforce
 NUMA mempolicy using shared policy
Message-ID: <aPAWFQyFLK4EKWVK@gourry-fedora-PF4VCD3F>
References: <20250827175247.83322-2-shivankg@amd.com>
 <20250827175247.83322-9-shivankg@amd.com>
 <aNVQJqYLX17v-fsf@google.com>
 <aNbrO7A7fSjb4W84@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNbrO7A7fSjb4W84@google.com>

On Fri, Sep 26, 2025 at 12:36:27PM -0700, Sean Christopherson via Linux-f2fs-devel wrote:
> > 
> > static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
> > 					     unsigned long addr, pgoff_t *pgoff)
> > {
> > 	*pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> > 
> > 	return __kvm_gmem_get_policy(GMEM_I(file_inode(vma->vm_file)), *pgoff);
> 
> Argh!!!!!  This breaks the selftest because do_get_mempolicy() very specifically
> falls back to the default_policy, NOT to the current task's policy.  That is
> *exactly* the type of subtle detail that needs to be commented, because there's
> no way some random KVM developer is going to know that returning NULL here is
> important with respect to get_mempolicy() ABI.
> 

Do_get_mempolicy was designed to be accessed by the syscall, not as an in-kernel ABI.

get_task_policy also returns the default policy if there's nothing
there, because that's what applies.

I have dangerous questions:

why is __kvm_gmem_get_policy using
	mpol_shared_policy_lookup()
instead of
	get_vma_policy()

get_vma_policy does this all for you

struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
                                 unsigned long addr, int order, pgoff_t *ilx)
{
        struct mempolicy *pol;

        pol = __get_vma_policy(vma, addr, ilx);
        if (!pol)
                pol = get_task_policy(current);
        if (pol->mode == MPOL_INTERLEAVE ||
            pol->mode == MPOL_WEIGHTED_INTERLEAVE) {
                *ilx += vma->vm_pgoff >> order;
                *ilx += (addr - vma->vm_start) >> (PAGE_SHIFT + order);
        }
        return pol;
}

Of course you still have the same issue: get_task_policy will return the
default, because that's what applies.

do_get_mempolicy just seems like the completely incorrect interface to
be using here.

~Gregory

