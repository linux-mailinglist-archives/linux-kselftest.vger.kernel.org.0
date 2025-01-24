Return-Path: <linux-kselftest+bounces-25117-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8690A1BA14
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 17:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C72B188CEAC
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 16:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D75416F8E9;
	Fri, 24 Jan 2025 16:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PVQWpoiq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47154170A1A;
	Fri, 24 Jan 2025 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737735293; cv=none; b=BjvkW5SuRvgdLMYD3E3r0lDT/MRi2WsLamqUjtvHJuJg0NyyeGPNJUrfP4WQ38HOd3gpkMUknhKlcIv7dEY5cb0zNP3nGq39VJep8wcgZGbb/swSIKKxNAmof+Y2KK4xP+ejnX9ianKsFY2wDwxgHipn1lNRsQUH54WH0g1870k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737735293; c=relaxed/simple;
	bh=EMyKj4qAgU79jB6W29kVz8yWO8ei9MR4MtSguh9Raqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UaOH3U/1tUHBjWa8bEstADFrCTfrjD3M1DRk4xwVC5R/+QJYwrqebQVRxUvRxEx+n/wi7JpO3hgVpA4WyhI1bOIMuJA9NpGGUjDWSYIs/rDSe9FfSHTWq5ovpQUvn2rKtl3saW/2LmsaO3sgdaukxoxZC1/PUFVAHCuVUeDUkcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PVQWpoiq; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737735291; x=1769271291;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EMyKj4qAgU79jB6W29kVz8yWO8ei9MR4MtSguh9Raqc=;
  b=PVQWpoiqOv72dbtId33tiCIW3EM49MRItPyDnDzPgoTz9c1lnxpQ8Ext
   G72QsHfxoJN/1bg9zXPqsiRXkFYKs9rmdByOFAmXX+wBMOGQkm1y+ozUZ
   x5VQzLTTgKkk+1omrEJsRbm5i4+wT7f6i2FV1Om/ecVlTCmk9IrTmgaoK
   6MplpsW4NJew3UXRmrQd8a4lt06UrAkjdB/BmTcLA+p5ZpKw/IpoaiRce
   zjhKZ+LX4SGZeq76MKPTz3H6wXdZva/os+oiP8w7Xu8Gp7GViwJlpPIEF
   pn2xAl5bSPH+dQSTpnzoUqVDk7oSllPixdYIizg/nsaUeCBxt8fVNkpeI
   A==;
X-CSE-ConnectionGUID: iAamJLs1RIiYeHjDmJJqqw==
X-CSE-MsgGUID: 56hcim4IQnKQujheJ4zz3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="38162698"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; 
   d="scan'208";a="38162698"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 08:14:50 -0800
X-CSE-ConnectionGUID: 4PNvicWNSFCmi+gnFaNKjw==
X-CSE-MsgGUID: Jk+kiPGnRCCewLdXMu/I+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108238575"
Received: from unknown (HELO [10.247.119.253]) ([10.247.119.253])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 08:14:44 -0800
Message-ID: <e1aefeca-8f85-48c9-8972-1c23b34aea7b@intel.com>
Date: Fri, 24 Jan 2025 08:14:41 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] selftests/lam: Move cpu_has_la57() to use cpuinfo
 flag
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 shuah@kernel.org, hpa@zytor.com, x86@kernel.org,
 dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
 tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kirill@shutemov.name, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1732728879.git.maciej.wieczor-retman@intel.com>
 <63f8fa8ac016f9f294230657e9069a616bce6141.1732728879.git.maciej.wieczor-retman@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <63f8fa8ac016f9f294230657e9069a616bce6141.1732728879.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/27/24 09:35, Maciej Wieczor-Retman wrote:
> -/* Check 5-level page table feature in CPUID.(EAX=07H, ECX=00H):ECX.[bit 16] */
>  static inline int cpu_has_la57(void)
>  {
> -	unsigned int cpuinfo[4];
> -
> -	__cpuid_count(0x7, 0, cpuinfo[0], cpuinfo[1], cpuinfo[2], cpuinfo[3]);
> -
> -	return (cpuinfo[2] & (1 << 16));
> +	return !system("grep -wq la57 /proc/cpuinfo");
>  }

I would rather we find another way.

First, we've documented the behavior a bit in here:

	https://docs.kernel.org/arch/x86/cpuinfo.html

The important part is:

	"The absence of a flag in /proc/cpuinfo by itself means almost
	nothing to an end user."

Even worse, let's say there's a CPU bug and we say define a bug bit:

	bugs		: spectre_v1 spectre_v2 ... la57_is_broken

How is that grep going to work out? ;)

Could you poke around and see if there is any existing ABI that we can
use to query LA57 support? Maybe one of the things KVM exports, or some
TASK_SIZE_MAX comparisons?


