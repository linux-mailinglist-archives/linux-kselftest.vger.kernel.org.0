Return-Path: <linux-kselftest+bounces-3996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AABB78469B9
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 08:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4907B1F23D75
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 07:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443771799D;
	Fri,  2 Feb 2024 07:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YNFcnHtJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E3617BB6;
	Fri,  2 Feb 2024 07:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706859906; cv=none; b=C6LV4YjPZqSZj9qdT4UWyOnhTIUTboKkRxQfZRuNjtiRB+xUMU/RCEO9mclD+8qIIv6yeMqla0BIU90vU6IIOtuqUow5HIh2Qw0WRLKIoMIvzc5uCn5KzQKXc98XFUtQtxMr8ynfIt5FT68ToqS/seImbFe5/LMdVamhpiZCS8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706859906; c=relaxed/simple;
	bh=zuxEjjnkyCiU2jxBsKwIXFDFrYt5ZXuz0QMOj8jPOOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovEvMQvv/94+iZXYKqn8Gh6zRLuH3yWkfYGIE45N34RBWJXo6LmcuO1TCKgROlHR1ghuxtEIJlEIGxLYy6KD9oJ4J+v8Bw6FRyIFtkDeA9tnZnjUt/fSdRxwE3Ua8yi6FzP2fs6aJKHIytdu/mh/b4grHRnhEEYMBzjLKBGNT/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YNFcnHtJ; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 2 Feb 2024 07:44:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706859901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yXYgbL9pawqCQfLD7tUkx2pUHhN7+ydoo6Ga24ca9gc=;
	b=YNFcnHtJlTgzMTxTop4NnZqSpbhk46tadJrsfBw04VBy206G8dAEJZT/TRYNnaYmxIeuDJ
	wV0/PJI96jbkEktFxfACqS8W3T45QyFRKLqLdXk9SMTRvcTMC6cg5tfsdY1d7MwyFFWlbt
	QLoXJAxqqHDaY1x/HuSN02rLDJu26Cc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Shaoqin Huang <shahuang@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev,
	Eric Auger <eauger@redhat.com>, Eric Auger <eric.auger@redhat.com>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] KVM: selftests: aarch64: Move pmu helper
 functions into vpmu.h
Message-ID: <ZbydeB5MEJIhxaw6@linux.dev>
References: <20240202025659.5065-1-shahuang@redhat.com>
 <20240202025659.5065-3-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202025659.5065-3-shahuang@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 01, 2024 at 09:56:51PM -0500, Shaoqin Huang wrote:
> -static uint64_t get_pmcr_n(uint64_t pmcr)
> -{
> -	return FIELD_GET(ARMV8_PMU_PMCR_N, pmcr);
> -}
> -
> -static void set_pmcr_n(uint64_t *pmcr, uint64_t pmcr_n)
> -{
> -	u64p_replace_bits((__u64 *) pmcr, pmcr_n, ARMV8_PMU_PMCR_N);
> -}
> -
> -static uint64_t get_counters_mask(uint64_t n)
> -{
> -	uint64_t mask = BIT(ARMV8_PMU_CYCLE_IDX);
> -
> -	if (n)
> -		mask |= GENMASK(n - 1, 0);
> -	return mask;
> -}

I don't see these helpers being used by your test, and they seem rather
specific to what the original test was trying to accomplish. Let's not
move this unnecessarily.

-- 
Thanks,
Oliver

