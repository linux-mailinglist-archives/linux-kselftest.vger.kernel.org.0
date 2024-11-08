Return-Path: <linux-kselftest+bounces-21683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB44E9C1FDB
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 15:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BFD41F22F2B
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 14:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649B81F4FAC;
	Fri,  8 Nov 2024 14:59:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8D71F4730
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Nov 2024 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731077948; cv=none; b=Hxmy7SWdxEb2eZB4y2Cpmbyg5lE+rhfcoxqRC3iHJyrMQpJQfe3WWNkKm06AtkhDPxq6utd1AYTXeuq5V6csrUxBb4g0oPz/HtHMJqnSIdt5aoMzhHxg0N+9BoNyt3HbkgscrG7b4p+nCwH3tvXi1WLRZncfxhZHleX2K4yRRQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731077948; c=relaxed/simple;
	bh=aFhbFWNiK+95ZoLgU++f8sLsz1Lko9jv7Q765RsTHMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPWju77rDnHal7jmWf5R6I8NSkNnnx4rZ4vfmBiZjAAQHcm4ISHJRXriEE41iLLVmKuwXgVVj0Hg+gsfyhWEgyze/ZbKwQYhmz0o8KvHk6L6QbinvKsyXClOXYKo70jRrIzZ3rpNbd2pDlJcN2j3vKw7uCAlu6Uum02nKhAPV3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E21C4CECD;
	Fri,  8 Nov 2024 14:59:06 +0000 (UTC)
Date: Fri, 8 Nov 2024 14:59:04 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 4/4] kselftest/arm64: Fix compilation of SME instructions
 in the arm64 fp tests
Message-ID: <Zy4nONl6Ia7B7nLq@arm.com>
References: <20241108134920.1233992-1-catalin.marinas@arm.com>
 <20241108134920.1233992-5-catalin.marinas@arm.com>
 <15526a78-b9ad-46d2-b451-013dd3b8356b@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15526a78-b9ad-46d2-b451-013dd3b8356b@sirena.org.uk>

On Fri, Nov 08, 2024 at 02:53:29PM +0000, Mark Brown wrote:
> On Fri, Nov 08, 2024 at 01:49:20PM +0000, Catalin Marinas wrote:
> > SMSTOP/SMSTART require the SME arch extension for the assembler. Add
> > '.arch_extension sme' to za-test.S and zt-test.S.
> 
> I've got an alternative, more idiomatic fix for this running through my
> testing - SME is still relatively recent so we can't rely on people's
> toolchains having it and we should use a .inst instead.  The issue was
> that the toolchain I'm using locally appears to default to a full fat
> version of the architecture and happily assembled the SMSTART even
> though we don't have a .inst macro for it like we do with SMSTOP (which
> is why that didn't error).  We only have SMSTART SM and SMSTART ZA.

It makes sense. Please post yours and I'll drop this one.

-- 
Catalin

