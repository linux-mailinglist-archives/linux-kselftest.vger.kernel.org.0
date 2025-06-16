Return-Path: <linux-kselftest+bounces-35069-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9151ADB07F
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 14:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9A51664B9
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 12:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B170274420;
	Mon, 16 Jun 2025 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="VmpLgIGV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D974E322A
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Jun 2025 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750077956; cv=pass; b=dfWy+rOxst9vrc8upORMRgdaSocGHTpJSE3uE6dYZMkwcHKCFTaQNzNmCgsSaCqtAx22sjM44VTCzFw825yR3tdwuWI2tOUxDI1lLITSKqP5tvP8f+RBHUAESizOID+e+AgNAPrPYpbBJjW3u1vGwi/udK8tPzoZwSUO2nCdnsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750077956; c=relaxed/simple;
	bh=1lMo/Kx5w65g4hIhEhVM10x5Mmt++2HSgyD2ORTx0VY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aYxPnTfnotAMPm9/5jvy9N8Vzwc/EgT0DYNuqhK/QXqfi3cFgYz/ylDHQrV4J4ftCYsuj0LmncvE546yKKt18snTv37Ub/ksFJ0wqtkzWL4dlPUsUDo9MzSD7u9Y7v7FcAApUT/faKvoluZTBxlzFTr+S70HdN++OfyFg6t0OBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=VmpLgIGV; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750077913; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hOmbKRGlMK2EOh8d/SliteC93vpxi7ZpEH99Yu7/V2UqHIX4nK7gAODKJJqIBYsRc/CVUfc2l875QLZznxv/Wq4gFntFxYC4EJDAcaHo/ouUGQgik1X2JFSAd3qNKM2KaX3aFfKqCcJpt4vrm0DQJYXf69iaQHAN+RUWTg1QPGQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750077913; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9gLNoLcgtCNZMnfsCuMXgXWj6+7NoI6mXLggGfc1R38=; 
	b=i9OEEcttPq1MB7s0Rs7qG+o4LBZ53VT4xL6NsmXfcOKcmVSWeKiRIA7E2EYCejjrq+5iMkrtq6rIM36V0Qnt02IWbQxWxKxHCQhr6mDeZt10A7R0h/FBFLdqR7KscZxmCkY8aE+L9KMjG4TqlswHnZ2O4YGPjNDK312K+zt3jf8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750077913;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=9gLNoLcgtCNZMnfsCuMXgXWj6+7NoI6mXLggGfc1R38=;
	b=VmpLgIGVXD3LJmIl5ekaIpU7vMEZFkVWIwdw6AQHgByz4Jt7APgGWJhnbG/YznJr
	2eY4GyabWy8KXTOjhlAB6sCK6eru+egB9Z0X541lJRqxuxOlnjLkunl0W/ZhehnUHtQ
	tBpuNSHFKpqWdzrxSU8iFcygueWEz4AXn/rzl8c0=
Received: by mx.zohomail.com with SMTPS id 1750077902735804.2828728333874;
	Mon, 16 Jun 2025 05:45:02 -0700 (PDT)
Message-ID: <ff053978-78ce-4ac1-a406-32222bfbde05@collabora.com>
Date: Mon, 16 Jun 2025 17:44:55 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] selftests: print 0 if no test is chosen
To: Wei Yang <richard.weiyang@gmail.com>, shuah@kernel.org, kees@kernel.org,
 luto@amacapital.net, wad@chromium.org
Cc: linux-kselftest@vger.kernel.org, thomas.weissschuh@linutronix.de,
 skhan@linuxfoundation.org
References: <20250616122338.32678-1-richard.weiyang@gmail.com>
 <20250616122338.32678-3-richard.weiyang@gmail.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20250616122338.32678-3-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 6/16/25 5:23 PM, Wei Yang wrote:
> In case there is no test chosen, e.g -t non-exist, the following message
> would be printed at start.
> 
>     TAP version 13
>     1..0
> 
> Change it to print 0 if no test is chosen.
Please give reference from TAP format guidelines for this change.

> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>  tools/testing/selftests/kselftest.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
> index c3b6d2604b1e..9fcf76f0b702 100644
> --- a/tools/testing/selftests/kselftest.h
> +++ b/tools/testing/selftests/kselftest.h
> @@ -144,7 +144,7 @@ static inline void ksft_print_header(void)
>  static inline void ksft_set_plan(unsigned int plan)
>  {
>  	ksft_plan = plan;
> -	printf("1..%u\n", ksft_plan);
> +	printf("%u..%u\n", !plan ? 0 : 1, ksft_plan);
>  }
>  
>  static inline void ksft_print_cnts(void)


