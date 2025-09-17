Return-Path: <linux-kselftest+bounces-41641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F33FAB7C3D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 13:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CEC1777C1
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 00:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485EEAD23;
	Wed, 17 Sep 2025 00:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YF8WLnmW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FA41388
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 00:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758067595; cv=none; b=tsik8KUAtbbPWR/iIHJfz6kFt2XvFfmeUgY62JChKTY9CAa9vl7SK9Wy8lIzgMhul94t7i0kEfN1qNxuhmkdTDIckb//LTEy6LrWpRRJ2tov3rmrXYCyx6dDhpj7Iqrj+O+2cEDryZoTE8fMMIHFh0DsxJG2hPc5f7Y+fIGaeK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758067595; c=relaxed/simple;
	bh=ngJ4kkJ7aphmAfgCY+dWMJwxPcmplYJ6YWrKkonh64U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AzNavCCaVdqBoPUnnT7qlTPimgo5qHAfKIluinRFWNEMPfX08Z5ZisJrx3N0c+5/+grWYrN5tdy8EIt+lvAKeetlkKJZEFnWZIxUrF5pivL4AscALD5Q0v4UGR3535XRMfJIgHWj9Ne3hn2nluiWSyxJ/OAzfq3vUWkdEPQao14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YF8WLnmW; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8276e579242so345149985a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 17:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758067591; x=1758672391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i6mI7kMMJCYUaZU1FUYIKeSfbHM2lLryh9bTV5PX1CI=;
        b=YF8WLnmWg2kLtLqc9AX6/3+NaOSgCpq5kLQAUnwU5Nc8rtEji9suXSIeQKDerjue8Y
         9sTJRTE8ipMf7ZM9HrtXOC5ThFDPKoOVVqYpJImweH9R6s5dmhy3EVZFl7fRxk+Yyvgh
         2lJeuwBtOGZKpAPJJSMS61lAFdDpIFgUEvEnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758067591; x=1758672391;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i6mI7kMMJCYUaZU1FUYIKeSfbHM2lLryh9bTV5PX1CI=;
        b=poYEPPqSwgEM4BS/8ptfxldrXRlytHKEPVOYt4Pw8El52frSEWnwsX8HsDWekANA/9
         kgyogEHGxfuM4OhhdmvE2LPLIJnsxKF8Hlc72R/pbxh4ZqeNoyd5vPAFMblNpX9AE5W/
         sm4b3sPdQ9fJT7vHBSNSCyOWq/VHC1PHN+LOTgu7R/PuQ88TXHew6fG2KiAw4r44HEXJ
         lOGRlOqv/EvpNXW5c9DL9iu4ZhdGeoePfSLNJHqUg3wJ3USmydinNR00ErNXIJ8tYAQm
         rjXoYmwXKXAJl9zOzOdPsfdbs1/h0cGx4NmVyUvBpnvhC3oP6oxaHWo5U43pIdPI6Gxw
         BNlw==
X-Forwarded-Encrypted: i=1; AJvYcCXHLl7H9LSAF8qOYmQ/z1lGpDg9wThvCow5J05RkZv4iTBHR1wA/gUMSO+XvMq3Y2uuSLDhRwc7CGmN0sSJDoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoFbJ4zwlBo6Pj65zgoF2dIF7BryBQc73ezLok+FwLtEoAqS2z
	o8JDrcvB2pCBsjhoAGFKyhGrS/L8KSib4s2k1TQqlIQ1hOQ4VEqOQl5taqfWgv+fPxM=
X-Gm-Gg: ASbGncuElJ1XH19dO7TVXGcLHWyyYahhCt1WY2NQ5LELKNvrh7+eftDML5GaJF0iDkJ
	bApbozqdI0pVwK6bM4QBVAIF8aDCpvFuyWi9CC0+6/zbBUvUBCTBHAsMP/zXAI9fLSKDZEXHgVP
	Cw//MyxqBj9HqyDnEEBE0+Nze4+cHzSAmNMS+pUuYokVBgaLSh0Y96+tc2qj64mdz11HbTQrtw7
	/uGDR45V34JOiLWmOeFFH+TtenxC1aJtwFhZ+8TiSJbL5cSySGbldGiVqeCzCnZ9+bXm0zxQWUe
	gGSSS2EC0v6JjVOI8jacjCpfP0W8c3/a2RKPb3aK7S1Y0LGcsKXWdNakma81mzCHmMxL60aY7Wi
	ES219xCKMUb/URviYy3j0QxP6zbfq9nTpbtkKckY2yx98ME4c0IT59YdIWcILAG5puwN0UhzaR9
	xeWEiCOJnGxxz/9xy5hC4a8k36kVjN7wFcfTRqSvQHM/I=
X-Google-Smtp-Source: AGHT+IH5c4maWyfkVF5FZpUNfpUKnCiWWiu0hC91XpGrz9njbNR8U16fgNo/b40+XvnCWlfU+uhSmw==
X-Received: by 2002:a05:620a:4607:b0:82b:988:11bb with SMTP id af79cd13be357-831162653fdmr28239185a.73.1758067591381;
        Tue, 16 Sep 2025 17:06:31 -0700 (PDT)
Received: from [192.168.226.35] (207-181-222-53.s5939.c3-0.hnc-cbr1.chi-hnc.il.cable.rcncustomer.com. [207.181.222.53])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-82b19347ef5sm285484585a.44.2025.09.16.17.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 17:06:30 -0700 (PDT)
Message-ID: <39da8772-a44f-466b-ba2e-425ae464abb2@linuxfoundation.org>
Date: Tue, 16 Sep 2025 18:06:29 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/kselftest_harness: Add
 harness-selftest.expected to TEST_FILES
To: Yi Lai <yi1.lai@intel.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, wad@chromium.org,
 luto@amacapital.net, kees@kernel.org, thomas.weissschuh@linutronix.de,
 usama.anjum@collabora.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20250909082619.584470-1-yi1.lai@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250909082619.584470-1-yi1.lai@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/9/25 02:26, Yi Lai wrote:
> The harness-selftest.expected is not installed in INSTALL_PATH.
> Attempting to execute harness-selftest.sh shows warning:
> 
> diff: ./kselftest_harness/harness-selftest.expected: No such file or
> directory
> 
> Add harness-selftest.expected to TEST_FILES.
> 
> Fixes: df82ffc5a3c1 ("selftests: harness: Add kselftest harness selftest")
> Signed-off-by: Yi Lai <yi1.lai@intel.com>
> Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   tools/testing/selftests/kselftest_harness/Makefile | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/kselftest_harness/Makefile b/tools/testing/selftests/kselftest_harness/Makefile
> index 0617535a6ce4..d2369c01701a 100644
> --- a/tools/testing/selftests/kselftest_harness/Makefile
> +++ b/tools/testing/selftests/kselftest_harness/Makefile
> @@ -2,6 +2,7 @@
>   
>   TEST_GEN_PROGS_EXTENDED := harness-selftest
>   TEST_PROGS := harness-selftest.sh
> +TEST_FILES := harness-selftest.expected
>   EXTRA_CLEAN := harness-selftest.seen
>   
>   include ../lib.mk

Applied to linux-kselftest next for Linux 6.18-rc1

thanks,
-- Shuah

