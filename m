Return-Path: <linux-kselftest+bounces-9602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857628BE68A
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 16:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75351C230F6
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 14:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A7916079C;
	Tue,  7 May 2024 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gYABk+YV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C879016078C
	for <linux-kselftest@vger.kernel.org>; Tue,  7 May 2024 14:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093355; cv=none; b=mZj/DjiuquzrTLalGLYKgDlIbuaAh3aabDFIh5RDFD6NrdsCHp5FLS5XQP6sqHY587ZX93rQElWkDFzsBwaV41p6/d9TkqtGN33Zyv2Qf5QzGcz062yLgoXdi1DSPpnhI90HFzm93zicF5+EbgYQ8mbgh4/6Oc86EHTyQeRe7CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093355; c=relaxed/simple;
	bh=+pN9162UviCuz7peFbRpfdTcSTh1AIlmGxocrXqavm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdsec8sYmagB0ZeQJkHxQvSCJZGwnQjLMa9H/QxIviMu5pfJJgw7px+bnVDeSqr87QpLueryxpvYq8Y0T7fU+aBhBbO0yoLuu+pr2Sx+fPAorF7ElDoVk3e2Z94bRN5Fsol2aoT/AgIUw4m2KdIifUswdwn2mWGTdb7cDoNmrmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gYABk+YV; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 7 May 2024 14:49:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715093351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=379ckmIQo78wMttlgmZPaMlSsF8YL1GtmZvMW1rK+pA=;
	b=gYABk+YVOg0KcQleerHWTUo3y6JJ6enbSO7Fr2W1tHSiZmbbJPOa/7dmho1GCuHNEawWBq
	m02NeSWf3xpliVA9tfualVnS+CLbYsaeMKHwtxtVJPNDMbL7Wp/2uDP007s4+5wdvXAYdZ
	CXSzzXADB7UnBb0bqN3TRtev71EWjYM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Eric Auger <eauger@redhat.com>
Cc: Shaoqin Huang <shahuang@redhat.com>, Marc Zyngier <maz@kernel.org>,
	kvmarm@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 2/3] KVM: selftests: aarch64: Introduce
 pmu_event_filter_test
Message-ID: <Zjo_Yj9_dkZiQIBT@linux.dev>
References: <20240409030320.182591-1-shahuang@redhat.com>
 <20240409030320.182591-3-shahuang@redhat.com>
 <acbc717e-5f7b-405b-9674-e03d315726cb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acbc717e-5f7b-405b-9674-e03d315726cb@redhat.com>
X-Migadu-Flow: FLOW_OUT

Hi,

On Tue, May 07, 2024 at 10:45:24AM +0200, Eric Auger wrote:
> On 4/9/24 05:03, Shaoqin Huang wrote:
> > +#define GICD_BASE_GPA	0x8000000ULL
> > +#define GICR_BASE_GPA	0x80A0000ULL
> in v4 Oliver suggested "Shouldn't a standardized layout of the GIC
> frames go with the rest of the GIC stuff?"
> 

Just a heads up, commit 1505bc70f80d ("KVM: selftests: Standardise layout
of GIC frames") will do exactly this, which is currently on /next.

-- 
Thanks,
Oliver

