Return-Path: <linux-kselftest+bounces-20035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DEF9A2D76
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 21:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22F5D1C230BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 19:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FAC21D640;
	Thu, 17 Oct 2024 19:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7hm5upB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15C521D194
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 19:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729192281; cv=none; b=G5oAqi7LbdmS8/K9gYWmasissPaxo8TkoNbtxeTonqkguprt8hRc9+BSYhRzUw9xO6GmtY0B+U4PzNg53gfdC8+1vjnI7FXBU5b4k1IdY+jnFJoCnK/PzWXWpPN1RgXeOCYlGQwHLP5Un9qWahxbDbS0R3vW8p5yF4XLAjW8NcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729192281; c=relaxed/simple;
	bh=hcSnhusDnzekwr4ikkkXoQOJfK5bGeBFS4Sx6s5jV2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phlMTRMgrsQYyzOjs1iW2bp11zwOMslG01X2SL13hXrQS9sdQfhkBOIJn2jajRk2STtWmrdNp4Wbd6GMGeP/KRrBzQkEPjmBh33jJU9jX71dGCvA0rz1IDuBAGyo/uxpTgDUJUFMayYKSv2zN4kUrV3EAEFJqaLlnWgZ0533QV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A7hm5upB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729192278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ENOjaNeBX4g+6hbHPWlxkYnjEgbpAhFHbENRWbsgfbY=;
	b=A7hm5upBMwy6xajwd4vLf85GDl+eChuK9rghLPB2LHRmwkA+rx5D2m3XPD8cgx6bu+bOrg
	kHPSbxo6HMLRj1rjkY21GhIb0G2BFHPzECbBKS1Ni7ntEEzLJsltYmpuvRenfbGQmV1trL
	5rDgvBjm9s3ZBfWBTR87zJTVgMI100A=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-evyTKpsyPY6ogZHacbnRKg-1; Thu, 17 Oct 2024 15:11:17 -0400
X-MC-Unique: evyTKpsyPY6ogZHacbnRKg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6cc01327930so17039856d6.3
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 12:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729192277; x=1729797077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENOjaNeBX4g+6hbHPWlxkYnjEgbpAhFHbENRWbsgfbY=;
        b=YLkPqC8LGvexIsQpCijz8/AeS49CWnaK3+epWtn5VcpWCpGy9wHBZVZIjKXkoU5/Yj
         QaAe/XKB9SZJM3eEIMzdgJKOjIVjdhZxpRWp/NdtCxEygzxyoY8CfheaxOQkLJzHKw1U
         vc3i2O3riM+O2ItnCHCUMushNC9Jzap83SMWZgrIpsDAwfq7fT1NfMuIGb7kohJ+BMK1
         71jTt+7jrfB1RO8k/DGQVE2Hk/PTMMNCINuZrfnMD4wOs+mPXEvu6Hmn9I+BHYyAJE/F
         DHo4zPnfSb9NRz+oAJdS9YVh35uQJCmY7tJ2to3n3XMH8k+3P21BPCozEe6HiszRgIcm
         EXAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUq0vGzlAi56hmj8yyBV6mZOCG6Jfwqf7uvOWi1mjyu0VLHQW140R25K37F/+KxzTeiUqhM6Us4Z7HrTb4IwSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Qdk63H3UfF5Dbg+k2IjqiIxQfsILWyr7Hyqo+9H7YarqEt4s
	jBblB34Uf1ObKsVaHUus7W/H4K6gB2tU10b5qjkkMgoj9hR2bC+o5DYuOvlARg6Eh7D2AxbG2HW
	cdhIOo3moOm551Nq+I4JhYyYWKdcuBuXtoQJT4o+yI1jZ05Nvg4oq8LmKHgFpoGtsTw==
X-Received: by 2002:a05:6214:4984:b0:6cb:d583:3765 with SMTP id 6a1803df08f44-6cbf0003300mr291066466d6.1.1729192277036;
        Thu, 17 Oct 2024 12:11:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8+4MNI4FqCiYZuqBBeWgc19wifz1OLKYbCakcqMhYRU1GwBxzDpLpZYujB2+NGQzmuJpFGw==
X-Received: by 2002:a05:6214:4984:b0:6cb:d583:3765 with SMTP id 6a1803df08f44-6cbf0003300mr291065846d6.1.1729192276677;
        Thu, 17 Oct 2024 12:11:16 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc22959ae2sm30837856d6.93.2024.10.17.12.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 12:11:14 -0700 (PDT)
Date: Thu, 17 Oct 2024 15:11:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>,
	Ackerley Tng <ackerleytng@google.com>, tabba@google.com,
	quic_eberman@quicinc.com, roypat@amazon.co.uk, rientjes@google.com,
	fvdl@google.com, jthoughton@google.com, seanjc@google.com,
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com,
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev,
	erdemaktas@google.com, vannapurve@google.com, qperret@google.com,
	jhubbard@nvidia.com, willy@infradead.org, shuah@kernel.org,
	brauner@kernel.org, bfoster@redhat.com, kent.overstreet@linux.dev,
	pvorel@suse.cz, rppt@kernel.org, richard.weiyang@gmail.com,
	anup@brainfault.org, haibo1.xu@intel.com, ajones@ventanamicro.com,
	vkuznets@redhat.com, maciej.wieczor-retman@intel.com,
	pgonda@google.com, oliver.upton@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 26/39] KVM: guest_memfd: Track faultability within a
 struct kvm_gmem_private
Message-ID: <ZxFhTtEs2Mz7Dj-O@x1n>
References: <diqz1q0hndb3.fsf@ackerleytng-ctop.c.googlers.com>
 <1d243dde-2ddf-4875-890d-e6bb47931e40@redhat.com>
 <ZxAfET87vwVwuUfJ@x1n>
 <20241016225157.GQ3559746@nvidia.com>
 <ZxBRC-v9w7xS0xgk@x1n>
 <20241016235424.GU3559746@nvidia.com>
 <ZxEmFY1FcrRtylJW@x1n>
 <20241017164713.GF3559746@nvidia.com>
 <ZxFD3kYfKY0b-qFz@x1n>
 <20241017171010.GK3559746@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241017171010.GK3559746@nvidia.com>

On Thu, Oct 17, 2024 at 02:10:10PM -0300, Jason Gunthorpe wrote:
> > If so, maybe that's a non-issue for non-CoCo, where the VM object /
> > gmemfd object (when created) can have a flag marking that it's
> > always shared and can never be converted to private for any page
> > within.
> 
> What is non-CoCo? Does it include the private/shared concept?

I used that to represent the possible gmemfd use cases outside confidential
computing.

So the private/shared things should still be around as fundamental property
of gmemfd, but it should be always shared and no convertion needed for the
whole lifecycle of the gmemfd when marked !CoCo.

Basically, that's the KVM-only hugetlbfs v2.. especially if this series
will move on with hugetlb allocators, that's even closer.. which makes some
sense to me at least for now to avoid reinvent the wheels all over the
places over cgroup/pool/meminfo/etc.

-- 
Peter Xu


