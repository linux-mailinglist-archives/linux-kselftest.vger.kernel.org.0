Return-Path: <linux-kselftest+bounces-13887-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE12D93502B
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 17:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83629282842
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 15:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D411442FD;
	Thu, 18 Jul 2024 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XXoQeCYH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CAD7D3EF
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Jul 2024 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721317798; cv=none; b=jLzR/zT39s+RQ4C+Z54msE+6VuCGWl1JbhwKcRSSO5OCLy+dx74D342+9u6g6MFAL5wXaimqvRAHuvytvWtUXhzj68lPI1CO0dnaX0Jm1zGMOzx8V3iTZc0HHaAseHw2JzsfFcUYywd/IF1OdFhMFpElzVVNKjmx3glsMQhfH44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721317798; c=relaxed/simple;
	bh=K6uWnfuv142hlHOwyPvV9QaMIF3hOqI8R61T7G6sy70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Smaltt1Fmuss42jw3004OyxeJp4ZrFS8daNRm72BVM/yi03l6EBbBtBwziJsYdcw5bUNOCbXWlRxm4/xtedEDjWGTwFOWVWoqb7N8mAyUYnhRnrrgjJZERFeqftFMGZziq2hwa+sjccRSIHdzF7PQdziK4vQHnE3dWvqnTMQEVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XXoQeCYH; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-38252b3a90eso455455ab.0
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Jul 2024 08:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721317796; x=1721922596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9eyHkRuLKLIt7CJvpBlLgR3VZUiSSFQM6pSNtuomMfA=;
        b=XXoQeCYHw3aTZAeLODFAZpggTv2AohjEO0befitX441EvB4IJ7JXs2ocHDG5n0CnJt
         DVgN4BKqEKMeBFvPqtG4xqwqrRql+yF6RNswCL7nd5VlmsZ5zPLCqIfzkpfrLdIiNmU0
         OgmFMFcn3OotMwHdIsHGvfGehf/taxd213L5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721317796; x=1721922596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9eyHkRuLKLIt7CJvpBlLgR3VZUiSSFQM6pSNtuomMfA=;
        b=OYovnrfww+Ux9SegAGmYk/fTDcTpsercZt9LABA3G27cuqYwjq5JUJfUEj5CnMxFkh
         Ju3i73+WBRyF6P8VCVp9fuKnSbC2CylZeZvF7/+skOzhppORBGEX8U+fx4BfEaCctUB5
         jyle4AFhor/KfPf0zCudFeXAQBKon3v5xtF6fN15gMJwMoTpkcUqZ/0P0m6IaqBiw/4E
         8ezHU9aWQXjMqQ2Hsi65CmjII2cQyCyB6LowGSPlqH4hrt9DuHI1MLf50RDZXSE1Vlnv
         CEgx0kBRuJ4lfJJMcxQ+j/AhxA2DFsXNF67w9WwBDCyZeW8BdNtK1yVd9GyEEYRjn2LF
         wkzA==
X-Forwarded-Encrypted: i=1; AJvYcCUaF7h9IGW9uRT5Ahvdzr8hj1j5D2bDXKKG4+ivezNS+lXzel2AOBJOkMBXCfSqUsdgeOR1IKyNbebQkOyQTHav7xoRaxBjRhXsrNAIwav6
X-Gm-Message-State: AOJu0YwjGFxvc1iU9Vwy6rCXMz05OrJQ65TzzmolJ/HaPuodhwBdaRCE
	t0IM6b6HsxV+K2UmujvM4Ns2avUS9P8+zl6XZOyj6acDxgPl5O/e0//4MIozezc=
X-Google-Smtp-Source: AGHT+IGYVhzxctOAfexOX7dw/ZA1MYSWwnjpUm6O3VzclkmAK0Ta8nPrxGaK2sLPC/XIQG20xNaCow==
X-Received: by 2002:a05:6602:1dca:b0:80a:9c66:3842 with SMTP id ca18e2360f4ac-817124ec4ffmr365322539f.3.1721317796336;
        Thu, 18 Jul 2024 08:49:56 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c210c3aeb6sm1566811173.51.2024.07.18.08.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 08:49:56 -0700 (PDT)
Message-ID: <10a3905c-d9b0-4d26-bd8a-104851773745@linuxfoundation.org>
Date: Thu, 18 Jul 2024 09:49:54 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] selftest: x86: improve tests
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, "Chang S . Bae" <chang.seok.bae@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240718113222.867116-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240718113222.867116-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/18/24 05:32, Muhammad Usama Anjum wrote:
> Changes since v1:
> - Correct the description of patches with what improvements they are
>    bringing and why they are required
> 
> Changes since v2:
> - Update descriptions of patches and add output before/after
> 
> Muhammad Usama Anjum (4):
>    selftests: x86: check_initial_reg_state: remove manual counting and
>      increase maintainability
>    selftests: x86: corrupt_xstate_header: remove manual counting and
>      increase maintainability
>    selftests: x86: fsgsbase_restore: remove manual counting and increase
>      maintainability
>    selftests: x86: entry_from_vm86: remove manual counting and increase
>      maintainability
> 
>   .../selftests/x86/check_initial_reg_state.c   |  24 ++--
>   .../selftests/x86/corrupt_xstate_header.c     |  30 +++--
>   tools/testing/selftests/x86/entry_from_vm86.c | 109 ++++++++--------
>   .../testing/selftests/x86/fsgsbase_restore.c  | 117 +++++++++---------
>   4 files changed, 139 insertions(+), 141 deletions(-)
> 

I am still not convinced what how these changes improve reporting
over running "make kselftest TARGETS=x86"

thanks,
-- Shuah

