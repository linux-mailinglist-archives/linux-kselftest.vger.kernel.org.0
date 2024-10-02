Return-Path: <linux-kselftest+bounces-18928-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB6998E44D
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 22:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB041C218CD
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 20:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957E6216A21;
	Wed,  2 Oct 2024 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gr9bn852"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AF91D1739
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Oct 2024 20:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727901583; cv=none; b=qlAUoDPa+IVB0dr4Ax/CPofI8r2n8FfleuDB1bi9jcTXNLxxmDqVnTqRI6IjNYldswF/Gjf1R638mGGxPwyowkFvSB/8ORX5LCHA79oY9SCwUem3gykJHjfMqGoHWpHHYqKDi3CH/5H3UH24eiiexgcWn8LwcvkYR1Tuz9E2MLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727901583; c=relaxed/simple;
	bh=w2ZD0+YIPjKopFJ/fFPeXxClssMJBJqEeAoVQ/XgxsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1foeJqyqWbky8tpjBcp5A1p0x4IBGqnQuRgCt+qaGMUyiGbkhOLeWwUGnc6sjUMrRQs80otyjOz8h124X7Mec2KPKO7z+edscuTqdZ3zulgBEToaRo1BcrgKAUZIG2oJnzH6g83dgsaJMeX999IBYZT5Z/3LitsUsEldVghX+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gr9bn852; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a0c9ff90b1so914305ab.0
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2024 13:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727901581; x=1728506381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tKdE3ZYSRzWzEBdecF3TYnrD5ck9Yz/T8utWruczAjQ=;
        b=gr9bn852z3M3Vm+/L8uTm2m5hLmKcNfFO8usJiSvxTMdPV0sMTpyAqvcGY6I86FyhS
         rqJgY2+TJyPrZm3FVTevI/U2NgZaOE4rr01nNY/uX3V4pIFs558VeIX1eoV1NyWNrX6b
         lypBNorxnWQ5swTSDCVq1dnl6UxiVltmPDtV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727901581; x=1728506381;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tKdE3ZYSRzWzEBdecF3TYnrD5ck9Yz/T8utWruczAjQ=;
        b=PlI9uALPcSOlA/S6ccl2XF4rb8fygSOZ9cyYovrh+Rz/nH3aS+G3nyiuxmkCBF9DBG
         ivTE8AtU4/s2wSCX8D3b2wHgLlLFmiR+46QhrchEpaGZYG+ers0570gw623Oxn78dcEj
         7z0+aMWN0ibQnSelW3fPcUCgDCfXfCi9P4k9Qca7RxY3sffN+bWiQ1OJ/7nBYGZ3WO2J
         OBdTafcI1OD3cEibVcaStv9ewfzKR1+EE67eEDp828TnJyzAIfs0mDjHxDTIRxKk1rpR
         0titUEOmrEf6154pCQnd0C+79yRTPdxlIRiomhWfI+dobCGLB2llNo/olDrKBpecFnyP
         0ycg==
X-Forwarded-Encrypted: i=1; AJvYcCUQdbeFEGsa5upUFbcpxF4wmIMx7kmXdRYW9Y/jp3UHV9O+1Xd2tdbsvhHwHLLa2npUh3rrfDlGXtp8IOecEhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH7IAbuibOHXhlkUPTTwht8bM5fTF/cdHGV70qAJfDrpt1T2wi
	OK11K479inTg+Xpz78hLSZEDiWEfBrfns8RuZxEMvyGIy9aNHCuqWjoJDEGidUQ=
X-Google-Smtp-Source: AGHT+IFpMa24H9qgWYeUopGct4f/5GP33n2RJ9cR5Tkp8zcUx51HIJcsjkUoCPmlaNQQnkBRPOX7jA==
X-Received: by 2002:a92:b710:0:b0:3a3:67b1:3080 with SMTP id e9e14a558f8ab-3a367b131b3mr27415165ab.7.1727901580791;
        Wed, 02 Oct 2024 13:39:40 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d888835090sm3239656173.15.2024.10.02.13.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 13:39:40 -0700 (PDT)
Message-ID: <6b46f75a-cfef-4426-bab7-68959d044978@linuxfoundation.org>
Date: Wed, 2 Oct 2024 14:39:39 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "list: test: fix tests for list_cut_position()"
To: Jacob Keller <jacob.e.keller@intel.com>,
 Guenter Roeck <linux@roeck-us.net>, David Gow <davidgow@google.com>
Cc: akpm@linux-foundation.org, davidgow@google.com,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, richard120310@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240922150507.553814-1-linux@roeck-us.net>
 <dd9b940d-c5a6-46aa-ab00-73cbb3cab635@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <dd9b940d-c5a6-46aa-ab00-73cbb3cab635@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/24 17:18, Jacob Keller wrote:
> 
> 
> On 9/22/2024 8:05 AM, Guenter Roeck wrote:
>> This reverts commit e620799c414a035dea1208bcb51c869744931dbb.
>>
>> The commit introduces unit test failures.
>>
>>       Expected cur == &entries[i], but
>>           cur == 0000037fffadfd80
>>           &entries[i] == 0000037fffadfd60
>>       # list_test_list_cut_position: pass:0 fail:1 skip:0 total:1
>>       not ok 21 list_test_list_cut_position
>>       # list_test_list_cut_before: EXPECTATION FAILED at lib/list-test.c:444
>>       Expected cur == &entries[i], but
>>           cur == 0000037fffa9fd70
>>           &entries[i] == 0000037fffa9fd60
>>       # list_test_list_cut_before: EXPECTATION FAILED at lib/list-test.c:444
>>       Expected cur == &entries[i], but
>>           cur == 0000037fffa9fd80
>>           &entries[i] == 0000037fffa9fd70
>>
>> Revert it.
>>
>> Fixes: e620799c414a ("list: test: fix tests for list_cut_position()")
>> Cc: I Hsin Cheng <richard120310@gmail.com>
>> Cc: David Gow <davidgow@google.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
> 
> I ran into this as well.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> 

Please take a look and let me know if you are okay with this patch.

thanks,
-- Shuah


