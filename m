Return-Path: <linux-kselftest+bounces-31820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52392A9FACB
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 22:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A48047A49D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 20:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4F91EE7B7;
	Mon, 28 Apr 2025 20:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q8GXL0ym"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD081C3F0C
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Apr 2025 20:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745873573; cv=none; b=FGy4h6I+ZSxa2uG7mh0VhIDO6bG+9KJADgY8gtGTAhF6zCaExa26ozKO6+0/qdqVln3NUusM8w6nKSKKgV9LDyEnno6Vlde85OB8L1ubmJzosrYZ6sl4NE1dRQySjNf4/6AXXQPpwUO/v0FmnaYzIGD6P/YV3JCyPG/bufW2B9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745873573; c=relaxed/simple;
	bh=tjrYcU9uVFptq9iJHiRo0QN4YPZwxDPD5XCtsqRXx5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PFy2Oz7A3+DxkA1mMe23HDMy8b4LKPH90T1pR///lcWSpsbkh25JWaqJwlzZ4U9ticyfaQeYrL1Lq79LKoex9etyYSd97qY58wPcFXjbIDVrKexxfzvmLQN6UFvXvi/EfE1CoF8ur6/XBv1cUGxThOKMrApoHFOpxzXVWxjoyhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q8GXL0ym; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-86142446f3fso154635239f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Apr 2025 13:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1745873569; x=1746478369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dcDtVGAhlphd/tncj+riHC+G43pGAkk8UJpFdiFQW/s=;
        b=Q8GXL0ymPxIe6UiBfDgkNKQ0t691gUYchyBzmo6fBgvVRR/DMU1RsxHweil5zute/E
         dU3Ua9F6SlxEG1QEqUxX45RfyLIHa3YUkOxQDKF/q5ixTLi7ScMpMOsbskNbng9V965d
         6dkS+BlrrwEV+svE+6oYVUyfockuE83Eu3Ee8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745873569; x=1746478369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcDtVGAhlphd/tncj+riHC+G43pGAkk8UJpFdiFQW/s=;
        b=Harqq205fELhWdzcdhEM7NVEDRyhsOtboNuh9/cQZsFoV9ftLjQB/uDXybfnK9Zmg2
         57IE/cxyOoee1h7I2eZ4muR2g+XumD0p80afOeZtDO3lXrSYd9hCDof3R2gdIi3/8Ncp
         KDDb5YEivj7AH7b8amYyBzk8x595xLlyD88bLH032IC5h60L+Sww1qiNmtkT0f3TXclU
         F8vrJHT9pNDskDfD7l5h6JwtO8yZyDgtEujpTtqamM1/UsEHZoffKLVOCmEQLsTJfe+n
         OnplaOW7WAgfLudn/pCmQb1IU/YoyrTkVpIN08za4dWVjrGN8dsM63n4jB66JbICsK+l
         G74w==
X-Forwarded-Encrypted: i=1; AJvYcCV+wvey7vw4rqN+wdcxgAJvzVlYZAwg7twxXMjSaXLhv/kqBRvNI9nSkatz04Zu+xKQ0A3yNIF2xpBKvlF+6+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFIx1dCKM0Z4DouM3QCePv+gkh8kicJwnKLPBl/SZ9pAFbDakS
	/LwZIMNuARREOn9tYn/8LQNTwJV7rt+Y9e2XjCQttgv8GxrkO8LA/4qE8pg66zzZguUy7fYRRhu
	C
X-Gm-Gg: ASbGnct0vmSljWcQ1ZoBKV/WaeALfXGO2B3Q7xODYu5glGSHpsd4pcoTA6Lx8s7tkw2
	s6GCFlb5Jy16xVFIqKZXvkmQmDL/xS3LjFQFRlGOcg9eF8wCd8FIAUn4lRGcO830tztDz/iFYR1
	UBa7o74krFozMjcOWAVMnMLjfiVbSARz5XHVnbCfD+8e+68bATfhK0vshJpZ5lnM0h4hWR6jFnd
	5IbWq/hNoci3UwqwNF8K6/XWwlBVPsKZcK6G1XK7Vjsq6PHJgcs+TTAkwN535HT2yTcntoVh2Ox
	/0h3lOID73IAVes+JGasKFlF0dEO7csROpoPBh74UGajoJzRUUM=
X-Google-Smtp-Source: AGHT+IHuVCa7ftwum0bcOD/BwQjJ/dsD+zy7/8BHyFsV+Zia1WrEWcO7lXnM2yRRbPzpsnmNb91JAg==
X-Received: by 2002:a05:6602:4743:b0:861:7237:9021 with SMTP id ca18e2360f4ac-86488516c08mr180354239f.3.1745873569298;
        Mon, 28 Apr 2025 13:52:49 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f824ba0f52sm2385467173.114.2025.04.28.13.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 13:52:48 -0700 (PDT)
Message-ID: <4ab0a88e-672f-4ffd-8642-53159f942355@linuxfoundation.org>
Date: Mon, 28 Apr 2025 14:52:48 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix(script): improve safety and formatting for
 WRITES_STRICT restore
To: Alexander Shatalin <sashatalin03@gmail.com>,
 linux-kselftest@vger.kernel.org
References: <CAKWAyW=nV1CNh4Pv3Uj00djOmxynBJpbSseZkTjMvcxTbE0j1g@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAKWAyW=nV1CNh4Pv3Uj00djOmxynBJpbSseZkTjMvcxTbE0j1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/25 02:32, Alexander Shatalin wrote:
> From: Alexander Shatalin <sashatalin03@gmail.com <mailto:sashatalin03@gmail.com>>
> 
> This patch improves the safety when restoring WRITES_STRICT by ensuring:
> - The variable is not empty (`-n`)
> - The target file is writable (`-w`)
> Also improves formatting by quoting variables and following shell best practices.
> 
> Signed-off-by: Alexander Shatalin <sashatalin03@gmail.com <mailto:sashatalin03@gmail.com>>

No attachments please. Send a proper patch with correct short log
and change log.

Check submitting patches documentation for details.

thanks,
-- Shuah

