Return-Path: <linux-kselftest+bounces-18453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A548987F62
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 09:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91530285B78
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 07:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAF71865F5;
	Fri, 27 Sep 2024 07:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="gg8YXmla"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9D217E000;
	Fri, 27 Sep 2024 07:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727421928; cv=pass; b=pshDaKdxp+Kc8cHnva/4WRBrDq6lSKnOutsU4lDprEd834yfx4YvpxuWskrp0E1/GlNBMWjS8xKerwP3rxdpBfnmET4CrHVcFIduHtMxtEtNFvSTP0LbTeJ7o4S1/9n8euMh9KoCm2DUdMlxnJfiRQx2Q084bZxj5vmL7lf7gQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727421928; c=relaxed/simple;
	bh=fnJGccxYf+ZX3GMW5Oymu3JwVno2xWPcwvqy+tiiT0I=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=r3ho+d7JYtUAxxAKcoizk8MT6OFu2wgVfi/XzSs9LiKKMXdNXskCHiiqk/kyc+vBoJto5VfnPUQO5f+pUMN9QaOwdJJjonv5sGbCO0tOsiY/zZQUUPvPeGCzjGHBPKqROrgA5O+YQE8AtI5+QyxPtOCAs56d41MVTC6BI45DBB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=gg8YXmla; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1727421914; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TtmE2KMW469q5De9PwLR5QBK2XSBNOYmh33iO0FhOc2Ouji65rQrZHln8G4XbsjyuIg1spmYemGow95YwqA9/y7epSYxl1ONnNiWTnX2WES83fB5Qhu68e19rA0hLxSNRg6KdmKwQIrngdRZCIcQPSe4eDwCKrke54SfyoY6Pw4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1727421914; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JBEcpv3YHSVlk1Wp65VWtKfznpwDm9l9nfMi/ye6i/I=; 
	b=ciRNdoL04zKMZBDJgG/JPY889Bb3DGIvboYsRTGZU+Py1oF20wxFtIPzmxAmp4we3Pyu6l3GT8UjUG1c/9zckkNu51KnDDLko8EEhqjxXfMxtNnCp3Gw2nY0Jo9k7nbwopBKXj3/jDIZ/6DKdrn5XI0SlGfmhZ1KXn5Belhfp4M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1727421914;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=JBEcpv3YHSVlk1Wp65VWtKfznpwDm9l9nfMi/ye6i/I=;
	b=gg8YXmlaw/p6I1VYpkNysJ9jSLmbwXF8lpWpVr8Suf9lSIiVc3DQogqLS6YZBOYU
	HTbdSgHNyyKHc6NoKBZjy8rUDlVnwFQE3FBxjq/5CQQzUoLeq8Ao+GxcucmCWBVMxLF
	7HhYsYYYYxv45HK0Eww/+oL2KShKgTxFvJMIh2lE=
Received: by mx.zohomail.com with SMTPS id 172742191298275.66141873135632;
	Fri, 27 Sep 2024 00:25:12 -0700 (PDT)
Message-ID: <87b06c82-5e59-404b-889d-baa1293bd160@collabora.com>
Date: Fri, 27 Sep 2024 12:25:07 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, shuah@kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: Add missing free.
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, akpm@linux-foundation.org
References: <20240927030114.3792-1-zhangjiao2@cmss.chinamobile.com>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20240927030114.3792-1-zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 9/27/24 8:01 AM, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> There is a memory leak in mkdirty, just free src before return.
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
Please find the first patch which missed this free() and add fixes-by tag.

> ---
>  tools/testing/selftests/mm/mkdirty.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/mm/mkdirty.c b/tools/testing/selftests/mm/mkdirty.c
> index 1db134063c38..af2fce496912 100644
> --- a/tools/testing/selftests/mm/mkdirty.c
> +++ b/tools/testing/selftests/mm/mkdirty.c
> @@ -280,6 +280,7 @@ static void test_uffdio_copy(void)
>  	dst = mmap(NULL, pagesize, PROT_READ, MAP_PRIVATE|MAP_ANON, -1, 0);
>  	if (dst == MAP_FAILED) {
>  		ksft_test_result_fail("mmap() failed\n");
> +		free(src);
>  		return;
>  	}
>  

-- 
BR,
Muhammad Usama Anjum


