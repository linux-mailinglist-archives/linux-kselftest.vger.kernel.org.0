Return-Path: <linux-kselftest+bounces-5597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F278186C0BB
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 07:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 932671F235F3
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 06:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051E33C482;
	Thu, 29 Feb 2024 06:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WAcKx9BD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F63326ACB
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 06:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709188502; cv=none; b=hciXURXgu8afFoO5uQYFSz6n7/5oxMw6X/5zw3VpJuTyl+XTx6rtNEQAyZvmgK49DZWQ14siOKaO/YAFKKyo6wtY8WfextAFg9NYcfUyt9uvVXlGhn+u21Lg0blEX6I7uVNV3hxw4RcuwMXd/56u6FVzI4D2Cf6ssC1+LQikoYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709188502; c=relaxed/simple;
	bh=swc6S+6Yo6A0fPMSHvrIlHvikCcbyQH5FEQv0jRzSdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hz2QmkqGaso00tqh7vbzd1D2gUB0DAKX/0yAaA6luJaYOWyYIxZLbqz/+xIrye7HF+i06ZRYOTv8DXpm7dr1h0ekWBSnedp0S8/Ov3FuNVtP22ziqhrAL8W4ASRZXESux0GT1VwEGbBX3jQpaUyw8LBREkcXExW2JlbqohDU+Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WAcKx9BD; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Feb 2024 06:34:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709188499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TTjPglRVl0w4hyzMuzLiZwXuKasvFFVk+iNhHkjufl4=;
	b=WAcKx9BDUlNys6P6xwDTTnNX85oOId7KD1Mp6WYwv3ie1zNnkbYXqlhh+/PlOw8KJpr7S7
	tyKniqORvtv2F5hUQBbtBFRvvi5nLW+NUUUIIOh/NBdIZ2+l+QSFfFZjAmmb46lRX4BCcB
	MBzSPAV4YqFUIUnakHFZP6j/pkbZlHY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Mark Brown <broonie@kernel.org>, Thomas Huth <thuth@redhat.com>,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Marc Zyngier <maz@kernel.org>,
	Aishwarya TCV <aishwarya.tcv@arm.com>,
	Shaoqin Huang <shahuang@redhat.com>
Subject: Re: [PATCH v3 3/8] KVM: selftests: Move setting a vCPU's entry point
 to a dedicated API
Message-ID: <ZeAlj14TCnpR-G15@linux.dev>
References: <20240208204844.119326-1-thuth@redhat.com>
 <20240208204844.119326-4-thuth@redhat.com>
 <501ac94d-11ab-4765-a25d-75013c021be6@sirena.org.uk>
 <Zd-JjBNCpFG5iDul@google.com>
 <Zd-jdAtI_C_d_fp4@google.com>
 <Zd-lzwQb0APsBFjM@linux.dev>
 <CAJHc60xqbrH5cgSm5URhxF1j-+X7PVD1WkqEBRKENo-GeQnsnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJHc60xqbrH5cgSm5URhxF1j-+X7PVD1WkqEBRKENo-GeQnsnQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 28, 2024 at 03:00:03PM -0800, Raghavendra Rao Ananta wrote:

[...]

> I sent out a patch in the past to get rid of them [1], but Shaoqin is
> currently making an effort to (fix and) use them in their tests [2].
> While we are still reviewing the series, we can apply [1] to unblock
> enabling -Werror and Shaqoqin can re-introduce the functions as
> needed. But, it's your call.

Thanks for the brief, now I remember :) Agreed, let's just delete these
upstream. These accessors are simple anyway, and easy to re-review in
Shaoqin's tests.

Sean -- I'm going to pick up [1] and throw it on the branch with your
cleanup.

-- 
Thanks,
Oliver

