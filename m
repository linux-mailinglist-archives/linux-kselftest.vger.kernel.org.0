Return-Path: <linux-kselftest+bounces-40339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 084F2B3C303
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 21:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9915A607A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 19:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7145A23C8C5;
	Fri, 29 Aug 2025 19:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QX5/upAJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEAD1E1DF2;
	Fri, 29 Aug 2025 19:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756495645; cv=none; b=fEAjjIHeoL8e8OvMkto6pgcTuTGcs6TmSYXPH9ccE536+R2FoCGOVVM3bGj+E8ohj6TQBORxNpt0KOXHjNvEU7AKtSRoKE3PiH9oqsL9sePjCC4tDJG2TGuxh/4ocS0S3oyw1YBuDlYfMJ2er27ExQZBFdLXJ6+DBf4fJGxpiGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756495645; c=relaxed/simple;
	bh=6+scZTwDdTy9yhhOUqqnHbH2AzCvEbvYzIRW1vMbLts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ly6TrwjTqOek8LAvdBZzyEo9kdJ/DlPxHxAVIE5bSCwhAKg8J5QUGcKMJmuM+xOL+iiONMrq+bIFlLcZJMA7Tmc9T5PD70igB9T9TY9x6d1vZfDGRZVzCLrVDjQf1lbyzWrMBx6frmtE9ODSkUoxXPJF0elgM6MPWD0IAFb+fLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QX5/upAJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=7wOxqJMXtmV0NLjiAR5YZOzR5c7Xx4v0Kz9dydp8JLo=; b=QX5/upAJZCm7FStLqNRhAi7Jv2
	q8cza5vd6JAgZLipApkPS8gt9ScAA493cu3dkm75/sddfqPkxnvmxGV8CtntbAx5EaJttUA5p3RlX
	928V5WFhjQEHOqWFctqi9XAmFpHF8639sX8PkItmqcAyPlQ5T+izo0dnzd550xJvn7aV3m/zQdDXK
	S7uhiL2va2GFiwcZpOZs4Wa8GmYn6r3CpiykLRTx5c8+ZqkH0PEpNtrRX5sGTvl0Q0OXCX6pqBSUQ
	zJWxZ1YfuprhDMwbMstI0e9il3pkxlXd+Arigw8nanL0pWEqlc7bKm9mK9mstq9T1wwUG4SFPrdzF
	vp+ziOHQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1us4kr-00000006k8m-1zXX;
	Fri, 29 Aug 2025 19:27:21 +0000
Message-ID: <9ab8ba29-84ae-43bb-89d0-bb07195e76d0@infradead.org>
Date: Fri, 29 Aug 2025 12:27:20 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/15] iommupt: Add map_pages op
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Justin Stitt <justinstitt@google.com>,
 Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
 Bill Wendling <morbo@google.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Shuah Khan <shuah@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 James Gowans <jgowans@amazon.com>, Michael Roth <michael.roth@amd.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
References: <7-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
 <c17f0cf1-9a80-4f1a-94a1-8869b8ed0a53@infradead.org>
 <20250829192324.GI79520@nvidia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250829192324.GI79520@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/29/25 12:23 PM, Jason Gunthorpe wrote:
> On Tue, Aug 26, 2025 at 04:20:54PM -0700, Randy Dunlap wrote:


>> We don't really have a way to document parameters of a callback function
>> inside a struct, but for now kernel-doc.py won't complain about it.
>> (Somehow kernel-doc.pl did once upon a time and then that became dead code.)
> 
> Seems like we should :)

Yeah, no argument there.

-- 
~Randy


