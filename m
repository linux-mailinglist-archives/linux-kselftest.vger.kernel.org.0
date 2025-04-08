Return-Path: <linux-kselftest+bounces-30391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CCBA81978
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 01:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31EE4A8935
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 23:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53542566EC;
	Tue,  8 Apr 2025 23:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gKAZVqtg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8D4253B41
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Apr 2025 23:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744155750; cv=none; b=tE7a1M4RTgQkgKoATJ/sXq9CbAygSKCjvLHB+gYc6sIWGJJ32t5mwmTquzzgEZaaKWOool6i4SjlA7kKaM/c67jE3j5TulI4z7NpOswjBHvuPUWbM+VTKwPzvd2pZZ08kJxQLV6bRtCTNV6VbIBXhmDyMvAVCJVTkZ2gkojMTAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744155750; c=relaxed/simple;
	bh=QawIOHkjI/e9GYLGv/6vEDIfvEoUkpivlRFHlFS48gA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GGgM8RuMmMJk6X2O9htSEaz1Wuta51DLSUKuMuFFVMkV1y4DpKpL5OyUbuvsiw2FsNdJ/LtF5JzNuSIu2rbW6B1Mw+s2gyx/nj0rqt09d7elBBTyHWVPbGVyssuNtGFgtIix9bizt3sTNNVEXb+qKEuGIJvowZj/pcnb8DjTxss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gKAZVqtg; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-85b40c7d608so529812339f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Apr 2025 16:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1744155747; x=1744760547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ekJQffKB8/7ZuHnBMLZ3Kh7ve3h4vdHzrDy8dSOOOf8=;
        b=gKAZVqtgVE8MXuecyBfBo4qeLu41ZZmlDSV+JP9cAOqApaM2nWR2w1hrbg073LEovJ
         S02PQlbzqpig34aKdnLg5dNBoIGTuMTp5zkitVrcptrCAWCdoYC724TZu/iIFtaWB7VK
         12ee2kLk8YEuRH9ley3HcANUX6t+v3kTq7KUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744155747; x=1744760547;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ekJQffKB8/7ZuHnBMLZ3Kh7ve3h4vdHzrDy8dSOOOf8=;
        b=VgPrueO39IoJ998IiWtd0YKeEQdYrqArt+4wbY6dNjucMlDC4TUcJsZOl8khTtfdlf
         hY5XarkaugaSryY9DsqPlxCr5Vw6yc7P2CZ+zCV25aJuKpoJq3gammwPWwqWdbkL0Z03
         PmzZi1o0w6XNTU5WAMKQ6vdEAHHQj45gIAEC/xrxcZd9vsYPYq9Qj3mRVGDY5VmAiy9a
         zWRgdcltU+4sDyFLrhZnFLHWhFzqUpVYjfCQu7a+gXzgM9xg/YBoXbOVpkPW9eR8pnIX
         Mcie7kCwsUDWOhHctlLXwjNTXIy2+A7gf3WKBjkZOJ6HyOa1RrJjmUc6fgNAuV0hPqil
         4xUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3phSEKYUUzn/CAZTDa7BZU9O3nMoBfNU8h08DTRyKFOiLpm6kbI+vEh7396QNvxKb/0MkUfvq0WwXP3XRCwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmTocP/FVea6qCfKBtMiLV9564TBJhppuF1g2QDrILZG0lCeYB
	+gtTbkGoH1+b7UCC9gkHGH9TrYlpoyO/7vB0ObbF3jFyxfgUpRUXe2FMILbgZtk=
X-Gm-Gg: ASbGncuFhGwlRUaoxO86Iv/3uyS7/5XIpf9g2nzrPIHNvtrWbmyL421MNFXsiB7LsH2
	l97tfDPT5zY5NCnbe+oVLEV7I/RoZJMKaz+lf5wsacmHIMUmv2bELiTREnq0iHkzED4DH9c1GR4
	uXRA4sk/A5pVMPgkQLQpbdOHXH4fXIqb9wC3nVhyDpUXvobyLA6vkahh2S8TqZ5gW2POIPVqjbS
	Op6GSLHsOUqqJcYMrC0Bmxk6Z5h87Y+cHu38W0aei0CcPNiPICR81W7j/IDeydPVeYPh64ccNeq
	Fizep81738jiXO3m2LTi+5ckSKkQYgHE//xQtBF8cYWFh/49jnA8KJc=
X-Google-Smtp-Source: AGHT+IGbVeKrajarjGB+9bC8KXSatVvqdjhnMpiEAtkcDOsFqT+WrbIoe/18XBwH39oOyisdqiiXig==
X-Received: by 2002:a05:6e02:310d:b0:3d5:d71f:75b3 with SMTP id e9e14a558f8ab-3d77c2b1678mr11223415ab.15.1744155747348;
        Tue, 08 Apr 2025 16:42:27 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d703b7ed77sm7053115ab.21.2025.04.08.16.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 16:42:26 -0700 (PDT)
Message-ID: <8aa78b76-b9f9-4d23-a009-97b26aefcf33@linuxfoundation.org>
Date: Tue, 8 Apr 2025 17:42:26 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] unshare_test: set nr_open using soft limit
To: lufei <lufei@uniontech.com>, pvorel@suse.cz, viro@zeniv.linux.org.uk
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org
References: <20250401015557.113872-1-lufei@uniontech.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250401015557.113872-1-lufei@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/31/25 19:55, lufei wrote:
> Set maximum file descriptor number limit by rlimit.rlim_max than
> nr_open(hard limit). Hard limit may cause dup2 fail.
> 
> Signed-off-by: lufei <lufei@uniontech.com>

Petr, Al,

Okay to take this patch?

thanks,
-- Shuah

