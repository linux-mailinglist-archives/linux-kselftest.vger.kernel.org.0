Return-Path: <linux-kselftest+bounces-9424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 531CF8BB3F3
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 21:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FACF1C23A15
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 19:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9027F15887C;
	Fri,  3 May 2024 19:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UK9hUteV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C72363CF
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 19:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764422; cv=none; b=udUjjRq9vxFjux0rUB3dnK6KMFpYWYYkQHnHA/0KBNJ6ju7gTpsYmOgOGMvWPYpkwCPUHIBhrYaaWqZXK15tkcedUOMMIDUaSTxLDfDLArJYHR6JO0QxEL+KQewBAMBEZzHb01ewJAUrGWU2yzM3773+2srJtpGZGxVo7DdBH3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764422; c=relaxed/simple;
	bh=WvNlFxi7iBYAtjMjEa//mHPsqvxt5LdVHnEKn83dCEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VSJFA0URStQiTDh0NnrOKyoLBWm+hijAEYobKdV4RadJGywUvITyJxJvWTxnNA64C0Uz2DtkrGR2tfl6fdj1ONq8VI4qRWG6gXNo8Ah47E5TEi5ydyK+7lGZol/kReT3GwG4QVjXl4PAQrT9ekfE+uq2yjBYidJg2bgwLcbDGbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UK9hUteV; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7dec804bd19so60939f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 03 May 2024 12:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1714764419; x=1715369219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2KX9yLukoPi6iAtAAYiont6LefTtRljJSxxqAFKOfPw=;
        b=UK9hUteVzUapAXjPw5PdHDU3VXwiskHRGQlEVGkPiMoJCAIFuZr1Ikw5XTJy17HIeN
         TSQXYDq1g3mxkVys1wx4l+ISIqbvYTJI0DgcmAiuLB697W20k2gKO+zg4LtbD4BJSJto
         4Yn1a5YK/vMotMYocaNwf2huDgzDcI4pcqaew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714764419; x=1715369219;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2KX9yLukoPi6iAtAAYiont6LefTtRljJSxxqAFKOfPw=;
        b=kdeBytNhpLm3pzYTWUbGRrgTOocSHBk+FzuDGbcQGYtmDx7HSTCN90Xq3mo2ICk7Zp
         0TKc4PCh8sBQntC4/dm5b5A6J7Hdq2T9s84Hvc5t9JIYaTMISNVw3CZ9HT1pRBAxGS3s
         0Lp7yEAq/o/aQnYpVZaG2PBkabvQNdn0LAVn2GihFYgdJC25/rhEyDB5YPARLzXd0iPI
         Ad5PSTB36Yccn+AuTdh9iiISb3z0DA6R/esxMjw1kSRLAyqO4XhyX1GYXboeFdMVp/de
         2azwE5oxXEYIW79omKdgIbngqgdhlwz4PHKH04juN16HtPZ9HE7u5xGKPip+KEO7GSdo
         DnAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXt3tGOj5lJ2eQ7Ij+XIbdwO9pDlTB2tBY0T53sy2AQa9jKZ08ikjRT3JkMvNjnk7LA8YCJ+VP+aszYorW5onNQlF69IplB4DJ+XnCb52tV
X-Gm-Message-State: AOJu0Yz6xu4TYUMsBFa9Z7Y73p57c4T8L2lAOfFA4E6UOpTnE6Jez58R
	iD4bkmE1IIfcrbuBdZ7ypASAgHe4Xn3upsryvKav57IA0ACnR6eH8nzFPnXDwys=
X-Google-Smtp-Source: AGHT+IFoJvN6WDjavGp1uTSV43HqVeCXcSZGG+uXNfqWRiXEfwPFUMuzOtNwWJNtKWyqMxEa9EpoIw==
X-Received: by 2002:a5d:8454:0:b0:7de:e04b:42c3 with SMTP id w20-20020a5d8454000000b007dee04b42c3mr3590661ior.0.1714764419230;
        Fri, 03 May 2024 12:26:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id g6-20020a056602150600b007deeb2d7c4csm790790iow.12.2024.05.03.12.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 12:26:58 -0700 (PDT)
Message-ID: <66bc5c54-d785-41c9-b0cf-3e6efe78d723@linuxfoundation.org>
Date: Fri, 3 May 2024 13:26:57 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/resctrl: fix clang build failure: use
 LOCAL_HDRS
To: Reinette Chatre <reinette.chatre@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Valentin Obst <kernel@valentinobst.de>,
 linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 llvm@lists.linux.dev, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20240503021712.78601-1-jhubbard@nvidia.com>
 <977ebfe0-4c12-4631-8309-a10d92e33fbd@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <977ebfe0-4c12-4631-8309-a10d92e33fbd@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/3/24 12:39, Reinette Chatre wrote:
> 
> 
> On 5/2/2024 7:17 PM, John Hubbard wrote:
>> First of all, in order to build with clang at all, one must first apply
>> Valentin Obst's build fix for LLVM [1]. Once that is done, then when
>> building with clang, via:
>>
>>      make LLVM=1 -C tools/testing/selftests
>>
>> ...the following error occurs:
>>
>>     clang: error: cannot specify -o when generating multiple output files
>>
>> This is because clang, unlike gcc, won't accept invocations of this
>> form:
>>
>>      clang file1.c header2.h
>>
>> Fix this by using selftests/lib.mk facilities for tracking local header
>> file dependencies: add them to LOCAL_HDRS, leaving only the .c files to
>> be passed to the compiler.
>>
>> [1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/
>>
>> Fixes: 8e289f454289 ("selftests/resctrl: Add resctrl.h into build deps")
>> Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
> 
> Thank you.
> 
> Acked-by: Reinette Chatre <reinette.chatre@intel.com>
> 
> Reinette
> 

Thank you. Applied to linux-kselftest next for Linux 6.10-rc1

thanks,
-- Shuah

