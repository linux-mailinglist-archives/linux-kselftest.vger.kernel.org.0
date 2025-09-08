Return-Path: <linux-kselftest+bounces-40937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A03B48C86
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 13:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8844716AF6B
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 11:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F9C2FF17D;
	Mon,  8 Sep 2025 11:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="susD5O2S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03D92FE584;
	Mon,  8 Sep 2025 11:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757332140; cv=none; b=U50UnoMYhRvo+l95+r+rf30xvxBGyPLNyISTQU0/vMwiHeVvL4pxp3fBbg0ruDyfvFE6dtTw/bJ5BPsFGYDJuXHRfWeantu4zlXLBZGHi8lfZIcW1atgpdWPEEu4A+vofkFaiBuKQ5zczkD/yrWmjrK5aXl+8LLVArliBQ3LfqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757332140; c=relaxed/simple;
	bh=t3zQW/6UKxcXwE/+3TcZ5iTAQI2PA6ExkDxdCG0M47Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slPStcDQLYOU8GxN6Yan0Jt6elGGIBgdxeR8ph3VlpcqRlK+nLo/8QCA6pohfZ+8GjNMilsAS+llrbF2bmUdu0nA0k4GxRBOKg++5xjKUZx45ldBGoBrReBMn3A0MBwvo0hd8qmIBesUdaxAqPDf+qGp+8w9YWqY2Dkq8O7vk7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=susD5O2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0B6C4CEFA;
	Mon,  8 Sep 2025 11:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757332139;
	bh=t3zQW/6UKxcXwE/+3TcZ5iTAQI2PA6ExkDxdCG0M47Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=susD5O2SmN/y4qjYpxUMDUc1XIjaNYKnPddSz0Mi/+3V27sbxQG7iyA/x5qtDHhZH
	 wxMgOB9RPXI4lSffEViv0Qr5E1z6mPx7MHEI4QtA+4EcGSBlAoCGdJIb3CrmjjbdzK
	 meFXu4/TjrYAuk0/7m8c90cinYL3sn3BbUz0sMh/IImkBInqkUznD1opfFKBUPnj5J
	 hOrlzxkbxAPGConTkgCaeDAxaPWOtQQ8csxU+V0UcuF1uyhnp760l0lUVHReafKItN
	 qN185wGxUfO4MeJU5IGQA1HZn2uV97VDgQaZbV0G7WvS1tFPbCSsugDyd0YfMVDrow
	 LPBqjc4lBo6yQ==
Date: Mon, 8 Sep 2025 12:48:52 +0100
From: Will Deacon <will@kernel.org>
To: Yicong Yang <yangyicong@huawei.com>
Cc: catalin.marinas@arm.com, maz@kernel.org, oliver.upton@linux.dev,
	corbet@lwn.net, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com, shuah@kernel.org,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	linuxarm@huawei.com, prime.zeng@hisilicon.com, xuwei5@huawei.com,
	yangyicong@hisilicon.com, tangchengchang@huawei.com,
	wangzhou1@hisilicon.com
Subject: Re: [PATCH v4 4/7] arm64: Provide basic EL2 setup for FEAT_{LS64,
 LS64_V} usage at EL0/1
Message-ID: <aL7CpFHAQ2mX2E2U@willie-the-truck>
References: <20250715081356.12442-1-yangyicong@huawei.com>
 <20250715081356.12442-5-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715081356.12442-5-yangyicong@huawei.com>

On Tue, Jul 15, 2025 at 04:13:53PM +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Instructions introduced by FEAT_{LS64, LS64_V} is controlled by
> HCRX_EL2.{EnALS, EnASR}. Configure all of these to allow usage
> at EL0/1.
> 
> This doesn't mean these instructions are always available in
> EL0/1 if provided. The hypervisor still have the control at
> runtime.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  arch/arm64/include/asm/el2_setup.h | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
> index 9f38340d24c2..46e085af7c98 100644
> --- a/arch/arm64/include/asm/el2_setup.h
> +++ b/arch/arm64/include/asm/el2_setup.h
> @@ -57,9 +57,19 @@
>          /* Enable GCS if supported */
>  	mrs_s	x1, SYS_ID_AA64PFR1_EL1
>  	ubfx	x1, x1, #ID_AA64PFR1_EL1_GCS_SHIFT, #4
> -	cbz	x1, .Lset_hcrx_\@
> +	cbz	x1, .Lskip_gcs_hcrx_\@
>  	orr	x0, x0, #HCRX_EL2_GCSEn
>  
> +.Lskip_gcs_hcrx_\@:
> +	/* Enable LS64, LS64_V if supported */
> +	mrs_s	x1, SYS_ID_AA64ISAR1_EL1
> +	ubfx	x1, x1, #ID_AA64ISAR1_EL1_LS64_SHIFT, #4
> +	cbz	x1, .Lset_hcrx_\@
> +	orr	x0, x0, #HCRX_EL2_EnALS
> +	cmp	x1, #ID_AA64ISAR1_EL1_LS64_LS64_V
> +	b.lt	.Lset_hcrx_\@
> +	orr	x0, x0, #HCRX_EL2_EnASR
> +

Acked-by: Will Deacon <will@kernel.org>

Will

