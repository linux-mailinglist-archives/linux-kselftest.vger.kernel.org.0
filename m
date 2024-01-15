Return-Path: <linux-kselftest+bounces-3013-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD5482DEAF
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 18:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3321E2832B9
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 17:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECC418048;
	Mon, 15 Jan 2024 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p35Gl/yr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D4618AE0;
	Mon, 15 Jan 2024 17:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B96C433C7;
	Mon, 15 Jan 2024 17:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705341443;
	bh=thBhnHt9jZFGQePPNqkyQjdjPMKZmxdsMlzWKPj8+Jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p35Gl/yrY53OdCBI06PlYbOCPu8PAdffbIyGPu1B+JJ8LCI4uLoO8zCBoPhEbZDLS
	 2IuoXD/t8k77ozhb8mPOLhbNFyEP4GY8mx1XWU4y7yBIbDXxNC5TLZcXn4YQydXZb+
	 ihr5kYCGinap2g3Ra56/Q9Wdrh9KoWNBTljTqqTGVPXMUstYfVTqYHhmmbvqbuBaqQ
	 R0D0wrr1HgN2cQjEjJrRRpn7IK2XvNg/wtd9MvHtZWsxwRCZJ8BWJdfLf157zF8Ife
	 iEtCOl9+pCW2cWVL5OumkEzSAdDC5KxaFB7NfQJIEp+JhKI5bT6ZCPEyvbkuFrYfyK
	 obT1KF8SeUyhQ==
Date: Mon, 15 Jan 2024 11:57:20 -0600
From: Rob Herring <robh@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/6] arm64: Unconditionally call unflatten_device_tree()
Message-ID: <20240115175720.GA1017185-robh@kernel.org>
References: <20240112200750.4062441-1-sboyd@kernel.org>
 <20240112200750.4062441-2-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112200750.4062441-2-sboyd@kernel.org>

On Fri, Jan 12, 2024 at 12:07:44PM -0800, Stephen Boyd wrote:
> Call this function unconditionally so that we can populate an empty DTB
> on platforms that don't boot with a firmware provided or builtin DTB.
> There's no harm in calling unflatten_device_tree() unconditionally. If
> there isn't a valid initial_boot_params dtb then unflatten_device_tree()
> returns early.

There's always a valid DTB because that's the boot params even for ACPI 
systems. This does also create a userspace visible change that 
/proc/device-tree will be populated. I don't see an issue with that.

There was worry when ACPI was added that systems would pass both DT and 
ACPI tables and that the kernel must only use ACPI. That was more to 
force ACPI adoption, but I'm not sure if that actually exists in any 
early system. I think we're past forcing adoption now.

> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  arch/arm64/kernel/setup.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 417a8a86b2db..ede3d59dabf0 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -351,8 +351,7 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>  	/* Parse the ACPI tables for possible boot-time configuration */
>  	acpi_boot_table_init();
>  
> -	if (acpi_disabled)
> -		unflatten_device_tree();
> +	unflatten_device_tree();
>  
>  	bootmem_init();
>  
> -- 
> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
> https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
> 

