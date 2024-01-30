Return-Path: <linux-kselftest+bounces-3743-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44274842634
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 14:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8AB11F2520E
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 13:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6516BB55;
	Tue, 30 Jan 2024 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Rbwg8Kdw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AB46BB47;
	Tue, 30 Jan 2024 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706621442; cv=none; b=OFQpgConghmidXZuRKfTUc6Zna0cv1214Ot9knDa6zBtE+knCZQEQopjc43kx0oXoDGnPkbXi9xY3+K2wOI5aGOx0Ck/prhPx6XU7j0ViaXWkmveOXlbxVQpy8GUrAiJG01OMKjwu9NkcOBIQs1643QAE+0bgmu9lGAQW5ZL5W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706621442; c=relaxed/simple;
	bh=rG8Dz1/ugp5YRl9zzSKL04gzMjWd9q4YlsAM4wMQHD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2HhrREkfyX5Bynktngb0MnR+JwL1wUSJkV339EtGQtCl/2usd4kTfzugsarL5dmyQCmXec4WMqR6UXN/Si2i1z8QMuGTG7HX1Mwmsou4hTzFfsUGuOewuBXQANrDLXEGxOfKpscqypQDAnIu17eq1D1BNnRDHkvHYcPW5W5D54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Rbwg8Kdw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id CE7A720541E0; Tue, 30 Jan 2024 05:30:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CE7A720541E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706621439;
	bh=ZLNex+omPb8kR2FC1v86zHkS3N/7w2iPpa2gpSI68QM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rbwg8KdwmuF0kHUacib13DpfzInP3vZHX/+hfW09KnFzo6Vlp6zTGDgLeji3qo5wH
	 b4tDmJq1rU3aTjakORccWuLGbjBkX/j2KQ4/5/hmdWBeR27ZNjM9JjRMnVELt7dv5F
	 PFpsMNrlrJPT6b4ufXNLB8DRaNpOLcVTCKPx4XYU=
Date: Tue, 30 Jan 2024 05:30:39 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org,
	Frank Rowand <frowand.list@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 3/7] x86/of: Unconditionally call
 unflatten_and_copy_device_tree()
Message-ID: <20240130133039.GA1444@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240130004508.1700335-1-sboyd@kernel.org>
 <20240130004508.1700335-4-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130004508.1700335-4-sboyd@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Jan 29, 2024 at 04:45:02PM -0800, Stephen Boyd wrote:
> Call this function unconditionally so that we can populate an empty DTB
> on platforms that don't boot with a firmware provided or builtin DTB.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: <x86@kernel.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  arch/x86/kernel/devicetree.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
> index afd09924094e..650752d112a6 100644
> --- a/arch/x86/kernel/devicetree.c
> +++ b/arch/x86/kernel/devicetree.c
> @@ -283,22 +283,24 @@ void __init x86_flattree_get_config(void)
>  	u32 size, map_len;
>  	void *dt;
>  
> -	if (!initial_dtb)
> -		return;
> +	if (initial_dtb) {
> +		map_len = max(PAGE_SIZE - (initial_dtb & ~PAGE_MASK), (u64)128);
>  
> -	map_len = max(PAGE_SIZE - (initial_dtb & ~PAGE_MASK), (u64)128);
> +		dt = early_memremap(initial_dtb, map_len);
> +		size = fdt_totalsize(dt);
> +		if (map_len < size) {
> +			early_memunmap(dt, map_len);
> +			dt = early_memremap(initial_dtb, size);
> +			map_len = size;
> +		}
>  
> -	dt = early_memremap(initial_dtb, map_len);
> -	size = fdt_totalsize(dt);
> -	if (map_len < size) {
> -		early_memunmap(dt, map_len);
> -		dt = early_memremap(initial_dtb, size);
> -		map_len = size;
> +		early_init_dt_verify(dt);
>  	}
>  
> -	early_init_dt_verify(dt);
>  	unflatten_and_copy_device_tree();
> -	early_memunmap(dt, map_len);
> +
> +	if (initial_dtb)
> +		early_memunmap(dt, map_len);
>  }
>  #endif
>  
> -- 
> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
> https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


Tested the series in Hyper-V environment. Please feel free to add:
Tested-by: Saurabh Sengar <ssengar@linux.microsoft.com>


