Return-Path: <linux-kselftest+bounces-13254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C27928E13
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 22:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF94F1C21BC5
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 20:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857AD16D9D7;
	Fri,  5 Jul 2024 20:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RJo0o3xA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1548A13E3EA
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Jul 2024 20:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720210602; cv=none; b=AJDdJQ9HAFVnBUgvqwrJZlrKAzF/j33qP4Y5miJM1ef1Ruh3sfMyXrDYE4bkwG+0ZzDnWQ3zIvNqjMWduNxW0w1MTBHwuAmO6Nb7NhZIwQdm1wO+0remT1Cn8fI2pDuQljv/BK2FimvEFoC7QB8yE4ItoDRyBuNpJyqdFPrY65A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720210602; c=relaxed/simple;
	bh=T0Yezoe/XJwes714mKbKM0egw+ZynvAnNMtDEZXPuzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SyIiHE6AE4bNr1nPI8sAQO4V0odkxIHvz2N4/nRLg2eHR1gqUMttX0DKvGWXT8upBJG+PUgOkLjtnlzP3kQ8YuKYaYMPHkRMV0IVnVmCW77GyNgsT7j3xJGay97DmftZ2+10USvV5jtYzDGyBVWHTDjyd7in0GuT59/lG3e0FTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RJo0o3xA; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-380d8ba4548so1327805ab.1
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Jul 2024 13:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720210600; x=1720815400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hICKxoDUywMdQbtGCI28pRH9+4hLvJaqbu+wfwSzwBU=;
        b=RJo0o3xAfO3V80L/4O1LzcmbaqVQffRTJr122T5a/pRCo3AcPOL/4Hafaz7EXskuUV
         4GuzzIM4FoTQo0zOw/IlrN6kq2VLfkuf/1Qn7HYOTXsTywHhfMU2T91wrWPM5xIRcZ1n
         xKCuEuqzq9/X9r6TZJOYYubPdqkyTLRPwdVmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720210600; x=1720815400;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hICKxoDUywMdQbtGCI28pRH9+4hLvJaqbu+wfwSzwBU=;
        b=O5AgNnbL3Eidq/XLit7JphJdPGEvaF2k2ZNXUoX8j3/bOsEs7f17fJSYS/W//kDtoO
         BA59O5f7n03Wu6yRJ3fdhPdrsnbIRkT0qy0qkUnhyNzU4a2izycZDAzxOvzZGcReBwuR
         jbxk0Mq9MwvAjJxVIhalyWu3HsYxMv2s+Z/yKCbpiTWlORD/by0KV/EKLodiOGWzZ1f4
         NO/a0jynpQhNDu+mbdVqktum/lIeGfOeGf6YHA9JP2+AhTgn3cYOmkIWtf8zTRpnPmF7
         aVUC4zyGNtJU0DXqX+Qa6mXTdVXt0JP5EyrTTXf0i/kEG9//aoeZCpdwlihBdG0udOzi
         b1XA==
X-Forwarded-Encrypted: i=1; AJvYcCVbMejrhY6fXcX3ch8WMOoE+CDJrlcsr1/wvw6uHVJGl40Y+ao6/3WsHrngmi1mgdG4gKtnobwpr1XOrJRBWRWUMJD9CFY+uNcrR9x+hIX2
X-Gm-Message-State: AOJu0YxoB6T4TlOm2664hX/KzNFy6fqzvvp5+Osnu13tahs+gwcm2B3B
	4iPLwep3lvvGTMxGvbBnUaeQzNBQz6OhQD4TaxldK2lVmgz26kIko5S7YCZv01g=
X-Google-Smtp-Source: AGHT+IFxJeifz5EcUyoQ7zGXVAt/YfV1u/9+SuLU0gHe+drTSap9H+MC4G0IQtB9rf9SBDEaRTKPgA==
X-Received: by 2002:a05:6e02:128c:b0:382:56bd:dfb8 with SMTP id e9e14a558f8ab-38398710577mr53428745ab.1.1720210600102;
        Fri, 05 Jul 2024 13:16:40 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ad22cb6b2sm40055505ab.14.2024.07.05.13.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 13:16:39 -0700 (PDT)
Message-ID: <d99a1e3b-1893-4fac-bf05-bcb60ca7f89c@linuxfoundation.org>
Date: Fri, 5 Jul 2024 14:16:39 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] selftests/vDSO: fix clang build errors, and
 Makefile cleanup
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>, Andy Lutomirski
 <luto@kernel.org>, Mark Brown <broonie@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Colin Ian King <colin.i.king@gmail.com>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240705195736.34039-1-jhubbard@nvidia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240705195736.34039-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/5/24 13:57, John Hubbard wrote:
> Hi Shuah,
> 
> These are for 6.10, as we just discussed.
> 
> Changes since v4:
> 
> 1) Subject line on patch #2/3: s/mm/vDSO/
> 
> 2) Added Muhammad's review tag.
> 

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/?h=fixes
for Linux 6.10

thanks,
-- Shuah

