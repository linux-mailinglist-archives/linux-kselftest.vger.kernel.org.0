Return-Path: <linux-kselftest+bounces-26315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C90A30005
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 02:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106391886A6D
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 01:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1F5EC5;
	Tue, 11 Feb 2025 01:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TWY6QQlA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E471C5F26
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 01:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739236892; cv=none; b=hQySe/g0T6ryRrSox4kq7ezesOmJfrMTfU6EPylPwhlf4vhjjOxJ+ciAFiB8UEA3UcxCXvI/3zhPfsWu4WdDCh1zcdcghYTxLgZut3h+BFQ90kkyw0ELEuh+kKOoG3hvBW/dTprVIbl4ktul6htr/HdDgcf+vRK2F8bODOKVFeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739236892; c=relaxed/simple;
	bh=1+CP/0j5H4Ofk/3bPCDzaiFoFTi05OuEcXFurhjh+gQ=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Q1dqLzA3lJ+EdK1fLzFSQE8uw63S40ruPrI5nWBoI/5Y5ub+wGLyH7GJ1YJINTHCleHKdQ/AZ9rO4B+HfALbw/lf1ymPh5+fc0e9qUtep3g2+ZbqAVu43vdfQQpq6DDlyIiBUyhDJby/SgSM223xZLXTRdbAYy2PrRFXwV8Dmvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TWY6QQlA; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fa32e4044bso6944831a91.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 17:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739236891; x=1739841691; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KXiJPqLFhZmJ+5uRMCh6GlR02B9jDhDTB8hvWYZ7HM8=;
        b=TWY6QQlASdjlyix+mh1Kxk/+v7CU9oPD6Jy2DyTHAcGRI605lSEJT0VklbwwrkJx01
         jZMEdlah4Lw2tbSmS5istQqyyaDLSzlcAjHAuPWFDbFAT1TbzU1sao/R7sYgy5yehK5w
         Qqdq0xr2YUbwF7libACRPvAZeTBW39YH3HEC/6g7IeXXJ0vzCBsxXwyqBoTJS8YQJHkA
         DmHwDpyT/ZyTUHqT51eSj5Ouy3tXubFlmxL4FMq/X7D99cwFaLD6gtgiBzJA1KI5kFj0
         n5B1cb2/2eGmykncAz6o+dXcwrq/tZ2gSMs6mKNEMAcmqt3qhdzUNE/Ddjvrp4EngRaR
         nSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739236891; x=1739841691;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KXiJPqLFhZmJ+5uRMCh6GlR02B9jDhDTB8hvWYZ7HM8=;
        b=cFlYTJPrd5hQknhgGzDCWTtCPGkY/+MbT862xdzMSU22MP+kXBJqfrX/0Cn++K+FUI
         b6QpGhAFzrkvgQTQdWLhKL6pJfdI/hV7cCYWCwds8+62c//hKjqTgwR66ZZF8TFpXiPF
         IjTtdhR8j0uSFLimWE9x4qwgG2dhC/OHt8mZiT5LKSIyVa0+7xv8N5ijH67zTuX9Ldev
         xCRPtTDcXxE3V7BijEAGIj1d3Sw6Ag3VSP67rV791DNwZyez7pe+aCYn5cxxxhdeqI/u
         ObtJo75xFTgBMxrGodG4MvoPn+4ACW3kldd+twoZ3TP5j3ult77ODPmOKR+NgOCpRsDT
         AmjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvFNycQjBpee1Ur/GanGkExIOPxNATAFJF6j9Zdxbai1BXZurW8qYzMNBzatAbaVufF9NltonD3CufIsaEcMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHs2oVFuMQAE6cKCkW1d7YxEC+iuC6sfh50mvofjtAXDnUAuIw
	uEZ0VZCcCXAeA55i/zPKDHrIBAgu+PSFE25zNv8F4CxNrqCIbAn5igpQVBQuDeFJZ4xqVSuo4JO
	7ZsDExgFcxBvME5+Wwwz1Yw==
X-Google-Smtp-Source: AGHT+IGBXvp6T+YSqhTHXx6VwACzHeW293PgoXt8xsu6MLd7mgjChTS8grNkD+XDcOpNh+EjILD390ILsRlYtcl5Lw==
X-Received: from pgbdo12.prod.google.com ([2002:a05:6a02:e8c:b0:ad7:adb7:8c14])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:9211:b0:1e8:a374:ced7 with SMTP id adf61e73a8af0-1ee03a5b269mr28538029637.23.1739236890584;
 Mon, 10 Feb 2025 17:21:30 -0800 (PST)
Date: Tue, 11 Feb 2025 01:21:29 +0000
In-Reply-To: <b8fe391e-b573-8f84-0a4c-828e790dea34@intel.com> (message from
 Jun Miao on Wed, 30 Oct 2024 17:01:06 +0800)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <diqzo6z98eee.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH 15/39] KVM: guest_memfd: hugetlb: allocate and
 truncate from hugetlb
From: Ackerley Tng <ackerleytng@google.com>
To: Jun Miao <jun.miao@intel.com>
Cc: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk, 
	jgg@nvidia.com, peterx@redhat.com, david@redhat.com, rientjes@google.com, 
	fvdl@google.com, jthoughton@google.com, seanjc@google.com, 
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	isaku.yamahata@intel.com, muchun.song@linux.dev, mike.kravetz@oracle.com, 
	erdemaktas@google.com, vannapurve@google.com, qperret@google.com, 
	jhubbard@nvidia.com, willy@infradead.org, shuah@kernel.org, 
	brauner@kernel.org, bfoster@redhat.com, kent.overstreet@linux.dev, 
	pvorel@suse.cz, rppt@kernel.org, richard.weiyang@gmail.com, 
	anup@brainfault.org, haibo1.xu@intel.com, ajones@ventanamicro.com, 
	vkuznets@redhat.com, maciej.wieczor-retman@intel.com, pgonda@google.com, 
	oliver.upton@linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-fsdevel@kvack.org, 
	jun.miao@intel.com
Content-Type: text/plain; charset="UTF-8"

Jun Miao <jun.miao@intel.com> writes:

> Hi Ackerley,
> Due to actual customer requirements(such as ByteDance), I have added 
> support for NUMA policy based on your foundation.
> Standing on the shoulders of giants, please correct me if there is 
> anyting wrong.
>
> --- Thanks Jun.miao
>
> <snip>

Hi Jun,

Thank you for your email and sorry about the delayed reply, haven't had
a chance to look at NUMA support.

Shivank Garg just posted a series for NUMA mempolicy support [1], which
is dependent on mmap() and then mbind(). Does that work for your use
case, or must you have mempolicy set up at guest_memfd creation time?


Ackerley

[1] https://lore.kernel.org/all/20250210063227.41125-1-shivankg@amd.com/T/

