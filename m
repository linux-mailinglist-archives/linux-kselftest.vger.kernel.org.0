Return-Path: <linux-kselftest+bounces-6235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DF2878BCF
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 01:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31CF1F218C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 00:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC15B197;
	Tue, 12 Mar 2024 00:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QptglPgs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDA7A928;
	Tue, 12 Mar 2024 00:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710202223; cv=none; b=IBDoI+VdR+lGP1jS4Crc+YTSD1fjx8Tpzf1VFvYTD8VTHH3IYJEMflZABVcBrfviagtS4sUqsD84GgSsBY4ziGd1sWsY8SvE6hNV78HYzK7pX7sFqUHfuaJJPgQeRJ4GzahQ+lbAaHPZl+1p5uLYLMctqKVkx1uPf1QFoJobke4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710202223; c=relaxed/simple;
	bh=pPkeMy7fBltTdNYOZZoPxSZoY5kmxQRciVH9Q0F3/DI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gmIxdLMQkuOJwWZ0kOefcAamkApeji6EOy52mNdpc9P3sG6iuqOOUYttL17fB1bNpCHrskFHqidBsNYBfmQQIHZYT/nFFML8Br0HgKc7LwQ2D3c4Fwi2nCSiAJmsQS0W6P2q0YAJKwWCGZQOcKYXzyEy/i7gEjYw2l2V4dcsz+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QptglPgs; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710202222; x=1741738222;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pPkeMy7fBltTdNYOZZoPxSZoY5kmxQRciVH9Q0F3/DI=;
  b=QptglPgsyZ4kpZ4sDJYpjFv2H0Kgnl6yyYGJeol1LIoiwGPRL2FYSOKZ
   lplEt5Zqs4GZSKzCYtqptuIW8NMm4ekIrbxm0c9JDayNvgYmvz+27B+SM
   DagBbuMBet1dzLKkGMbh+0PaO7XonTRzFsx9uKZJRE5bOHF3DxU6MKBtg
   hOqKrIPBdjF13ahC+rSFmDkgVvrevAo7nfldNINuDFVDI8cyLByQOtf19
   46036+tSEhulFVX8TG1bAPHZwz3uFP2KweBGdTDD1oYKM7qssXe4zBM3k
   xkDM/ZmOgo2oPm53Y4twvVyopKVP0E/jXeLm9r8CSsMwtQ4snP4lgujGs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="22409287"
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="22409287"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 17:10:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="48797633"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.125.242.247]) ([10.125.242.247])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 17:10:17 -0700
Message-ID: <bf4cb384-97ce-4782-b6b9-e75780cdf167@linux.intel.com>
Date: Tue, 12 Mar 2024 08:10:14 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: x86: skip the tests if prerequisites aren't
 fulfilled
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, "Chang S. Bae" <chang.seok.bae@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Weihong Zhang <weihong.zhang@intel.com>, angquan yu <angquan21@gmail.com>,
 kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240307183730.2858264-1-usama.anjum@collabora.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20240307183730.2858264-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/8/2024 2:37 AM, Muhammad Usama Anjum wrote:
> diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
> index 215b8150b7cca..c0f016f45ee17 100644
> --- a/tools/testing/selftests/x86/lam.c
> +++ b/tools/testing/selftests/x86/lam.c
> @@ -1183,7 +1183,7 @@ int main(int argc, char **argv)
>   
>   	if (!cpu_has_lam()) {
>   		ksft_print_msg("Unsupported LAM feature!\n");
> -		return -1;
> +		return KSFT_SKIP;
>   	}
>   
>   	while ((c = getopt(argc, argv, "ht:")) != -1) {
Looks good to me.
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

