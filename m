Return-Path: <linux-kselftest+bounces-3882-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C470844934
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 21:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 583F928EF8C
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 20:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943CE383AA;
	Wed, 31 Jan 2024 20:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYDbUZ2D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6284738DD2;
	Wed, 31 Jan 2024 20:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706734448; cv=none; b=ZQSTA4hrMl8wFjSjniuIg/EzbitoIXKe1WzsbhV3pU865ugxZVxCiWh677U/AmDX07SNSQBHfwqvcweST0hLk3PRnNtuKcYwch+E6A5LYL/NSHVh0CxM0euQSG3vkLHcWeB6uXr/ClvQcw2oB+17GbzERJ0+9LH79LdJvmysk4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706734448; c=relaxed/simple;
	bh=NpDrXnTuE8BMzuC03lZTD2fYoKrXrjH6wcLbnZRrixs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bj6mjsTZh+o3R0dI0NU9JqBrWXdQqgypHoPso7KynGU3+k8Z3Br7VhSkw3XDS16Kj0AodWIRP87VyOUI03J8SrWtiRzIdE0tz0J+yWiAIWUeyeeJxJgACiZrSnICaLGdnCw0scVj8j20utnRc+LusAV65vy5SbwOklPnEujzRrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYDbUZ2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975B4C433C7;
	Wed, 31 Jan 2024 20:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706734447;
	bh=NpDrXnTuE8BMzuC03lZTD2fYoKrXrjH6wcLbnZRrixs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fYDbUZ2D4G8Ucpq43YFgIGuEfiMThY0LsPeeaIA52P88VbtH57oOMWzfuAtcjXfyr
	 BvjfU0FPX2PFTFQ5ylkvicZKJpXTsJcHF4l7uCwD70Jt+FmQdvdbPh8thxozH/Df6+
	 DIu8J/ooOROKIFpDTTlGy4iVIUzpqRxBrXMypwJuThQYxHSWMREGldwbVtHzrNUItT
	 wjd1GQ3iD/iNwz5msHrGcEtI14au9Ofef5iAEYLPGiJ/S0wiAJhsx5RqquVNC1nYqB
	 ewnoD2OrhPprAKwbYEciNYM8dNFv7rrCY9DT2Z01o5wjc3QQAvxOggMJUDJmwUVJ+S
	 XEBuwdouJOlMA==
Date: Wed, 31 Jan 2024 14:54:05 -0600
From: Rob Herring <robh@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/7] arm64: Unconditionally call
 unflatten_device_tree()
Message-ID: <20240131205405.GA2249327-robh@kernel.org>
References: <20240130004508.1700335-1-sboyd@kernel.org>
 <20240130004508.1700335-2-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130004508.1700335-2-sboyd@kernel.org>

On Mon, Jan 29, 2024 at 04:45:00PM -0800, Stephen Boyd wrote:
> Call this function unconditionally so that we can populate an empty DTB
> on platforms that don't boot with a firmware provided or builtin DTB.
> Override 'initial_boot_params' to NULL when ACPI is in use but the
> bootloader has loaded a DTB so that we don't allow both ACPI and DT to
> be used during boot. If there isn't a valid initial_boot_params dtb then
> unflatten_device_tree() returns early so this is fine.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  arch/arm64/kernel/setup.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 417a8a86b2db..ffb1942724ae 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -351,8 +351,11 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>  	/* Parse the ACPI tables for possible boot-time configuration */
>  	acpi_boot_table_init();
>  
> -	if (acpi_disabled)
> -		unflatten_device_tree();
> +	/* Don't use the FDT from boot if ACPI is in use */
> +	if (!acpi_disabled)
> +		initial_boot_params = NULL;

I still think this is a problem for kexec. See 
of_kexec_alloc_and_setup_fdt(). You see it uses initial_boot_params. At 
first glance it looks like it would just write out everything we need. 
But for UEFI boot, I think we need all the chosen properties like 
linux,uefi-mmap-start preserved from the current boot for the next 
kernel we kexec.

I think you'll have to check acpi_disabled in unflatten_device_tree() 
and unflatten the empty tree leaving initial_boot_params alone. That 
means our FDT and unflattened tree will be different DTs, but I think 
that's fine.

Rob

