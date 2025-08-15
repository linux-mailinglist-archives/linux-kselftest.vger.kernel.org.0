Return-Path: <linux-kselftest+bounces-39086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0D0B27CFF
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 11:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1196C7A3855
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 09:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1183D2D3A7D;
	Fri, 15 Aug 2025 09:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LfhCM6nX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956842D0C71;
	Fri, 15 Aug 2025 09:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755249948; cv=none; b=c3qUWYrp05G3ZVbiz5WYoULVJEhWS/fhIF9WBVro5VLnvfUzAaORzrsfM7RRXkBmKgB0PEZ7LHnfhuUKs3Qbg8sMMI3YYFAKe3MvOBNXynnH3EM/iiRaNZeHDCDRVc9A8iiWgDwfYEAYxKAV4gSm2s8fSZ4iThaN0XQj1zDpN+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755249948; c=relaxed/simple;
	bh=SKzsQ5kDdbEdWpeRFn3oezKFQhkL/mEcXsebwxwrWbg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O5LC5T9wyb00JEzbuSoFt+hnIZSe7+xD8ccimZQJc7JWlPSssOvWPq7oUBY4ir8tEE6SQQaB42UCcIMB97l+z1xsYM32iwUim94Bld9bPYprruAcNz4eIyLHnrGyCweSkyM9luJJ+1UmMnFtVYNNN6H9qFA+SVTNVn08VVSyUXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LfhCM6nX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755249943;
	bh=SKzsQ5kDdbEdWpeRFn3oezKFQhkL/mEcXsebwxwrWbg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=LfhCM6nXrQz55JnV+NwdQhFNHKH/Lut19NhlzJkW3XDhPcBweh/uMfbaBSl2y8gKb
	 WzAaD3W4aOPygIpVmN/GkV1QVN1JtshloLN4bT6mh2nUwGqNssU20cd9BJ4VBsMf1I
	 Y7QmT1pbrkw4Yih9XAGUxWb4aAHNy/3hZ9yDek0B80OjJz5cQjGskQvOb2O8xSXqQo
	 FNEv4g85YGPtbENMBVCFR0qBXSlcTrK2+g/xeKvnG/xsDc3gDOLVM2Mj2k2SpuAxiZ
	 R8azZPozKQRaae++AMAb3MPhwzHkp6H0Ee5eH7gwAMvIWXsTGFPPT8d3KNtnVPBXCx
	 RVIPi7ybyflWw==
Received: from [192.168.100.50] (unknown [103.151.43.82])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0C5CB17E0020;
	Fri, 15 Aug 2025 11:25:41 +0200 (CEST)
Message-ID: <96edb039-1bb8-480b-b871-754bdab6fb8b@collabora.com>
Date: Fri, 15 Aug 2025 14:25:40 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com
Subject: Re: [PATCH] selftests/kselftest_harness: Add
 harness-selftest.expected to TEST_FILES
To: Yi Lai <yi1.lai@intel.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, wad@chromium.org,
 luto@amacapital.net, kees@kernel.org, thomas.weissschuh@linutronix.de
References: <20250815091032.802171-1-yi1.lai@intel.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20250815091032.802171-1-yi1.lai@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/25 2:10 PM, Yi Lai wrote:
> The harness-selftest.expected is not installed in INSTALL_PATH.
> Attempting to execute harness-selftest.sh shows warning:
> 
> diff: ./kselftest_harness/harness-selftest.expected: No such file or
> directory
This is a bug. Please try to find which patch had broken this and
add a fixes tag?

> 
> Add harness-selftest.expected to TEST_FILES.
> 
> Signed-off-by: Yi Lai <yi1.lai@intel.com>
> ---
>  tools/testing/selftests/kselftest_harness/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/kselftest_harness/Makefile b/tools/testing/selftests/kselftest_harness/Makefile
> index 0617535a6ce4..d2369c01701a 100644
> --- a/tools/testing/selftests/kselftest_harness/Makefile
> +++ b/tools/testing/selftests/kselftest_harness/Makefile
> @@ -2,6 +2,7 @@
>  
>  TEST_GEN_PROGS_EXTENDED := harness-selftest
>  TEST_PROGS := harness-selftest.sh
> +TEST_FILES := harness-selftest.expected
>  EXTRA_CLEAN := harness-selftest.seen
>  
>  include ../lib.mk


---
Thanks,
Usama

