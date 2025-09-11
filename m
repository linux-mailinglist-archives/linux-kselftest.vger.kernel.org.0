Return-Path: <linux-kselftest+bounces-41264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1942B53BFB
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 20:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305621C24B81
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 18:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE04241663;
	Thu, 11 Sep 2025 18:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I6QD9dGi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEE8221264
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Sep 2025 18:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757617078; cv=none; b=fZbgvyE61MI4w/b5EmTlx3cznj/D7PrmsdQsJiZf72BppQmunYanvNtTxpobSiCY+c0JRYYc3Q9/xY0J5Gs6HX1LfyrtlCbWXM0Sw6wJaGc4PZMrYYBwzZmptrp+x1/eImmAXEyfWQalh3MatQc12CUD9YIaZbGSlPp6yyYkvnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757617078; c=relaxed/simple;
	bh=YCGfhIV91IA+Q9p/eVdHX4XB159cjOB7AhqigmuJKIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLyYXz6d2TW7Bfrd8g7ubUHyMjgx2yMq97kzwhuqgWn2UQjZaFTD22fk3CLJc7b3FtHvSmf25zAX7/lOJcYClSV1UMv7nRrSWVDlWi3PJlh1nk1qPQPhmkUEKm0uEqXPPmOx3Ixj4ATPGfvbcrK4DuZMzXuuMwWXjcjDSClqDsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I6QD9dGi; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 11 Sep 2025 11:56:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757617064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4SQGKIlkipINvl+R90RuJAQdt11TIrJOgV4rbHAwlI=;
	b=I6QD9dGiUYM3bhHavuuokGgkfn2aw33ufD+qMrk74tUf/3fweSDpi4SADE59D35WlSLTsw
	acyEHKnhvh93iLBKEofeNyCplFpeBZ4i3N4UtjriguIONPSw6IPT6s6YHc0Hn7OrFw/61y
	nkVQuprWrsyVpLiuisZxOC4R9ithJcY=
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
Subject: Re: [PATCH 0/6] KVM ARM64 pre_fault_memory
Message-ID: <aMMba1r3AVdC9cQw@linux.dev>
References: <20250911134648.58945-1-jackabt.amazon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911134648.58945-1-jackabt.amazon@gmail.com>
X-Migadu-Flow: FLOW_OUT

Hi Jack,

On Thu, Sep 11, 2025 at 02:46:42PM +0100, Jack Thomson wrote:
> From: Jack Thomson <jackabt@amazon.com>
> 
> Overview:
> 
> This patch series adds ARM64 support for the KVM_PRE_FAULT_MEMORY
> feature, which was previously only available on x86 [1]. This allows
> a reduction in the number of stage-2 faults during execution. This is
> beneficial in post-copy migration scenarios, particularly in memory
> intensive applications, where high latencies are experienced due to
> the stage-2 faults when pre-populating memory via UFFD / memcpy.

Thanks for posting the series. More of a general comment on the UAPI
documentation:

  "... However, KVM does not mark any newly created stage-2 PTE as Accessed."

This behavior is x86-specific since kvm_pgtable_stage2_map() will lay
down PTEs with the AF set. Probably shouldn't have documented the
internal state of the stage-2 in the first place but oh well, please
just update the UAPI description to make it clear this is x86-specific.

Thanks
Oliver

