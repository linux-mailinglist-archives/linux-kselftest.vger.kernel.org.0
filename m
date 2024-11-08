Return-Path: <linux-kselftest+bounces-21678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F9B9C1EEE
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 15:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DCE01C22B4A
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 14:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD0E1EF0B9;
	Fri,  8 Nov 2024 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="O6f5Gh3+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF521E1C18;
	Fri,  8 Nov 2024 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731075211; cv=pass; b=QUpy2szw1MpuAkKT6kPT97lRhXGAWK2nAlkWRca0kW/kF4OkeWLvzZippjOWzw0UqnJWlSx1J04iwVFXeugy/p0RB06mSmOPkRfnhwLx5usTCJSBv+lfGFl3x0Vccc6yoOiqbnMdHG4S7eGN8MPJwvIh776llkyARi9ZnCQFF70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731075211; c=relaxed/simple;
	bh=IL6KIe28Rsk9XabwVUFnAnU2YLfm4d9kA3+3NWhGzR8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XdvxRoWpsIp/4NQd/r4IEI/X8FZwrS9viuyKXbMDNqWKE3uJMEnIYocHzIkne9/vaqD1Q83ZI5lnYYQMzD0DOpojGbp9Z69HAcFnK3hwuTDih5NFt9RAkO120DhPnwZea8QKw26BqB7gRded1RnztZ55dSYOAfrqp5VTaiyI40s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=O6f5Gh3+; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1731075193; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NwmT7/Pdl21xBFxBOyhq4+cLzeyqeFWIofzBjMhMGWF9ZqSdsINnOSpEQLnsXDeLyeQDmfAl3FuwamS7/OKdB/G1d/xJM97v9OQMgOuCM2t+yYsCti/2WoQ01g6cnUJg5wIBvR9PtRXAWS3PF9igpTll2ANHnq7CYQmLSgtQ9Xo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1731075193; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wLsbq45VP+QQQn7ywL3Aaz1egL8UHgg6/j8C4aCGAxc=; 
	b=ZO4LXMirHUpbJBSmZ+gkJY4vtQyJf7WDNRsslI4WDGgln9/9LUK1gmOUv9ABfLEqmmnp9d4/14W/ZI2vdW7zv7Zs3othbJPzald+cNRezWnvHxPXnWEAKdoQhC9lx2XQBy/BW0V2742EUM1UUSFCrY9ZP6biTGs844VQTbFXdcY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731075193;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=wLsbq45VP+QQQn7ywL3Aaz1egL8UHgg6/j8C4aCGAxc=;
	b=O6f5Gh3+9c+jVXqcKij73CEmPAyiYI4qjNuuhLdi1srnVxOquVpE2AHekhKa11o3
	f4Vn55H0yeBO6LLUCloatvJQUMLtT2ciEX37NDQpyJvLOoDkOVDQc3V52kcNJRapcGL
	EH3+AvSdZKAKVzVH9w3QVe3JU7H8VCAdnQtxnfu8=
Received: by mx.zohomail.com with SMTPS id 1731075192437247.0495706688124;
	Fri, 8 Nov 2024 06:13:12 -0800 (PST)
Message-ID: <ddabd00d-7bd8-40f1-9a1b-22a31b07fd8c@collabora.com>
Date: Fri, 8 Nov 2024 19:13:04 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, kernel@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: hugetlb_dio: Check for initial conditions to
 skip in the start
To: Donet Tom <donettom@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
References: <20241101141557.3159432-1-usama.anjum@collabora.com>
 <5883b1c0-13c6-4593-9dd5-17f34c1319fe@linux.ibm.com>
 <13a96176-1bfa-4567-8ce5-a2b75b110afc@linux.ibm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <13a96176-1bfa-4567-8ce5-a2b75b110afc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 11/8/24 3:49 PM, Donet Tom wrote:

> I think below changes are required.
> 
> iff --git a/tools/testing/selftests/mm/hugetlb_dio.c b/tools/testing/selftests/mm/hugetlb_dio.c
> index 60001c142ce9..4b52106b8124 100644
> --- a/tools/testing/selftests/mm/hugetlb_dio.c
> +++ b/tools/testing/selftests/mm/hugetlb_dio.c
> @@ -44,6 +44,9 @@ void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
>         if (fd < 0)
>                 ksft_exit_fail_perror("Error opening file\n");
>  
> +       /* Get the free huge pages before allocation */
> +       free_hpage_b = get_free_hugepages();
> +
>         /* Allocate a hugetlb page */
> 
>         orig_buffer = mmap(NULL, h_pagesize, mmap_prot, mmap_flags, -1, 0);
> 
>         if (orig_buffer == MAP_FAILED) {
Please can you send a fixup patch as you have working test setup?
Otherwise I'll take it up and try to test on working setup before
posting the fixup patch. Please let me know.

> 
>  With this change the tests are passing.
> 
> ./tools/testing/selftests/mm/hugetlb_dio
> 
> TAP version 131..4
> # No. Free pages before allocation : 100
> # No. Free pages after munmap : 100
> ok 1 : Huge pages freed successfully !
> # No. Free pages before allocation : 100
> # No. Free pages after munmap : 100
> ok 2 : Huge pages freed successfully !
> # No. Free pages before allocation : 100
> # No. Free pages after munmap : 100
> ok 3 : Huge pages freed successfully !
> # No. Free pages before allocation : 100
> # No. Free pages after munmap : 100
> ok 4 : Huge pages freed successfully !
> # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Thanks
> Donet
> 
> 

-- 
BR,
Muhammad Usama Anjum


