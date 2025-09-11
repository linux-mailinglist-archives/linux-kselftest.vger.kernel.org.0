Return-Path: <linux-kselftest+bounces-41262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4696CB53B58
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 20:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A791CC5905
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 18:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EE3368083;
	Thu, 11 Sep 2025 18:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m66MoVbH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ED81C54A9
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Sep 2025 18:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757615270; cv=none; b=bEEIb7npitOo/uS9jl8drkimjnNOzvMujh1Gy9S7OfKhYwIT6c9LcUHbYKC+zPQXWCC4clU1lYYvJcCqxm/P/ZPsl2hqXvPzbQcyZmiQwSkRODj5XQgW7gyYDo76fhTQwyUFoVAZO+bGaSQwCCkk5/0jYH/TIvoX9nnJmWUGipE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757615270; c=relaxed/simple;
	bh=dMozuue/sJaEdI+2v0oGtDcTdVocJ4ZzaVwH4WcwWac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUL8a5x6GpZdRUfoy9V81wZRBoe1/JcTvLB4bwdpY7AfSU9qyL8MMnvVKIqyIVSlaL4Ue3eY3M5diA6WDoTk73WOhug54CYeDczEQgN7wBlmr1eICMTlRDOznYiKNpSGrtYqhXG/HKmzkiLkOczj4wsZR9WoBq6KjzQ21+Wn/bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m66MoVbH; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 11 Sep 2025 11:27:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757615256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1PEqqMkQCCsIIK80US5++EkJbtoh1psej63veCBFsh0=;
	b=m66MoVbHAakOQHxhknbRV0aEtrzLIl0zCY5MZnXw/n2GB/8mMD2z8KI6sr7j6Zg2VMz5fZ
	LrEYbqoS2fE1sJyLz+JwXmPOOsVm1xe52j/yNKp+vJUnkU92KRcLd/H0qB2d1zMQk7NV3/
	0LIJakGffNrD7vjzin8Tacb4DAiuocM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Jack Thomson <jackabt.amazon@gmail.com>
Cc: maz@kernel.org, pbonzini@redhat.com, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	isaku.yamahata@intel.com, roypat@amazon.co.uk,
	kalyazin@amazon.co.uk, jackabt@amazon.com
Subject: Re: [PATCH 1/6] KVM: arm64: Add __gmem_abort and __user_mem_abort
Message-ID: <aMMUiyPLd1-_-V5p@linux.dev>
References: <20250911134648.58945-1-jackabt.amazon@gmail.com>
 <20250911134648.58945-2-jackabt.amazon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911134648.58945-2-jackabt.amazon@gmail.com>
X-Migadu-Flow: FLOW_OUT

Hi Jack,

On Thu, Sep 11, 2025 at 02:46:43PM +0100, Jack Thomson wrote:
> From: Jack Thomson <jackabt@amazon.com>
> 
> Adding __gmem_abort and __user_mem_abort that preserve -EAGAIN results.
> These will be used by the pre-fault implementation which needs to retry
> on -EAGAIN.

-EAGAIN is a pretty clear signal that another vCPU has faulted on this
memory and is in the middle of installing a mapping. Why bother with
retrying?

If we conceptually treat this thing as a synthetic stage-2 abort then it
should use the same EAGAIN handling as a literal stage-2 abort.

Thanks,
Oliver

