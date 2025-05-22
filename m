Return-Path: <linux-kselftest+bounces-33518-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5139AC15E1
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 23:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 199491C00ECA
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 21:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5AC25525F;
	Thu, 22 May 2025 21:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZVcyd9o4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0EF253F06
	for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 21:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747949257; cv=none; b=lEMKuts0IlwVlrpgiiCoK5qQLiw//jRL2Lb9gJOuD3/+MXLanjOoqGZe51AunAVfHtHzJQdmhVNLQHM6DrBj5nN44FcAjCCYX1PwGlLmeBP8aKCqgFSBU0bQFOqboFmVx49uEVPvl7j/clE3zZwmLjEPGrpCOQLC7ZB3i+KrU8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747949257; c=relaxed/simple;
	bh=mnpr6INuI/cGWSdGC0aPhOUbXzMBiTFczrqe4wiWxDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lcoyMcFWmUOgxiHc9Swod4pPtid1OKdZTSiMQfkrjqZtifK5cSMwxR+GPSFeVkFrHe5odFB6QBG+XWgdWCLAtWpe8sQYtaQAhvKyrCe3lLMCSsb5W0s68CdzorRptfU/sFR3dC/dT/kJJZA5Ze4ZDxHDljAtrIm4yrSF2qiIuPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZVcyd9o4; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-86a464849c2so11785439f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 14:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747949254; x=1748554054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C5LAw2cg//rNcmP3BjiXQppUkP46hdY49wjLPrnMOFU=;
        b=ZVcyd9o4rXsBCWzfxIWo0jHd8OC9aCQ3XF/uA8OpLewZImPlxuggSyAgWjSPjtE6zd
         xszFDhUsVIX+4NyZdonZD2tx0aSfegmZrL+rThj5FKgReeY3ER5cL1jHyVGd790kNSW9
         Zfshxbxd7Y0eQ36Bm9TXAM+QGplPGTVJ04Acs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747949254; x=1748554054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C5LAw2cg//rNcmP3BjiXQppUkP46hdY49wjLPrnMOFU=;
        b=o91mUidP2auU1vBk2lYYq4WTB4W3iBRofaaIODVKyADFiyjiShSKYYXrjxfhjfVLnC
         HPN25JFAkk0aADDRI2jj7gMh+EMO5jtYHWGvDvkF6RknHqTjUbrUrgiS9OIVXIxacBIb
         5ITFteVbiT7D5Uf2H0MWRQ+3MTIEOcxGYxvKMM4JZKq2LuZ1smLpDs1E6vDZiRByhX5R
         2Ujq5LCX7ppVAlIWBcAkbTzdPgahC4ytKOQ23HT5Siuc8q+yHW6Cq/iQ+NLvISi//hDE
         pR4806qlV0f+8wSwiqqSqzyRuLUY0u90fZrSsEosPyJ58M7vZFoW1cQDr6hjsnAXMDg2
         eT4Q==
X-Gm-Message-State: AOJu0YxFkEajK2PKdCSva88LdO/Hem0Pmyy6FD3/iNElriINqxeNEQvq
	y5ps9e4idrXFR30KtRuXJJb3jDBnex5RftmnvvbCJ/GMJ4tm0yeTCiobo2kdpB040fk=
X-Gm-Gg: ASbGncueSpzVuFiXsVXoO0tq4n+IdpWKxTNQ20KpRXN1jq4S77/x508k+qYxQSjUOeE
	e9tz8TGEiQ8IcrZlR4nJxHDnPRa9/EStrk7HkYr7pSj9L/TmRTgkHdJf3zSCa3o5raFnWhm1tv/
	n8RLTrlT06OJRiq4LGSDbtOvhTdqJizbZiR/78ql6nAgX2fGsRKy95lPiJSTo+Gig59WqCPhgr8
	Z3AV7z7kX1bsvxr7uGZ6mp8CFnY5Yev/ZzHMaDvPELQ1tKP7XGlUg5j0jnyv3uOsosi8xHh3OxP
	J+Ol7D8l+Cep53zni7ay7dXvB/Vfn3qJAsQHSkCnXKc8d8SGxO3AI2kMYNpiig==
X-Google-Smtp-Source: AGHT+IGYqTZwAOxSAwQ4MLoRuJW2OgxBpFdPfc1Yu/NwmS2TEYIdKzXmQezEmiO33MvZvH+Dx3+K+g==
X-Received: by 2002:a05:6602:2351:b0:85e:dbe3:137f with SMTP id ca18e2360f4ac-86cad951849mr123626439f.0.1747949254440;
        Thu, 22 May 2025 14:27:34 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc38a5a0sm3313676173.25.2025.05.22.14.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 14:27:34 -0700 (PDT)
Message-ID: <3a73cef3-83f0-4e26-b8ff-3c289a7cd52f@linuxfoundation.org>
Date: Thu, 22 May 2025 15:27:33 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: size: fix grammar and align output formatting
To: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>, shauh@Kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20250513214438.300430-1-Abdelrahmanfekry375@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250513214438.300430-1-Abdelrahmanfekry375@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/25 15:44, Abdelrahman Fekry wrote:
> Improve the grammar in the test name by changing "get runtime memory use"
> to "get runtime memory usage". Also adjust spacing in output lines
> ("Total:", "Free:", etc.) to ensure consistent alignment and readability.
> 
> Signed-off-by: Abdelrahman Fekry <AbdelrahmanFekry375@gmail.com>

Did you run checkpatch on this patch? I am seeing

CHECK: From:/Signed-off-by: email comments mismatch: 'From: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>' != 'Signed-off-by: Abdelrahman Fekry <Abdelrahmanfekry375@gmail.com>'

Please fix it and send v2.

thanks,
-- Shuah

