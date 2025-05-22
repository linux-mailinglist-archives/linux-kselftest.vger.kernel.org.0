Return-Path: <linux-kselftest+bounces-33517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755ACAC15DF
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 23:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2380A4E7F82
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 21:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E06725524A;
	Thu, 22 May 2025 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IbHUkve6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A084255245
	for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 21:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747949229; cv=none; b=eVfklugI1Ug/odSZnkoYdmq48NzXvyMdTdPvacwcq6aGjNei6qbVeMgTvE7xzgItzTcvWpzVysWi2Tw6TVe0vB/ZLxeSdSPKia+pWKj3oREbHHi+9GIhPOAqdOuj/Wq4SrsjMV/VxXjjGVTEC1xED7BB2Hum+fZrllak6UE/Ens=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747949229; c=relaxed/simple;
	bh=us3iKQhRkalRsD/BdhzsJnzgFym5+0ASy5QVjxwWNRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=so23nHhIXhDP2ualpYteIzdU9GFMMSUKGB4sD632fWSsgqiw8r9wz9MX4shrycc/VC8FSdEDNgrmlH+N+8teOnvJiFAxn0CpApbklgcyLQiQrJrkpExwyLbpg5VlDfS6zMhUVtW2z7zyymAL4+rkqzU4kmNRF4Ub97joEdF2nZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IbHUkve6; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d817bc6eb0so50399355ab.1
        for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 14:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747949226; x=1748554026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tPrRYdkJWlMyJE3e8/1vBPYSRNP9akBhDsTfTw7hzKQ=;
        b=IbHUkve6squdhF+m9oMoJbc9Zpxb0V3Ml8cioGhtGKkhwK/af5jVntYyJwhgw5dTAK
         +ckHg1vgTaJAO/eLd/I+0DMScTyamEPA8OS6Ea7b8BvueGvKttyUwbSU+gkxzGMEb6D2
         +ABpikm80NPTZI8/cy0nMF6sfWnzd3ekUJWc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747949226; x=1748554026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tPrRYdkJWlMyJE3e8/1vBPYSRNP9akBhDsTfTw7hzKQ=;
        b=cZPUVxLBd9nflbumtP56W89bpTkNOQhdCqDBD0Njyde/x9Zftg9POMnI4d4g9thNRt
         g+CQz6zcH10fao0AVGPBjv0NAc7+/SG37bj9miZaQZVw78n9asEunJ0/xGRkk5Qx1IE9
         2Z0YaJS4IvRr5REilZRwyfG/bxBDhnMX+4H5o+7QGMYYXtPc/kkw6PLq8uKtIwp79Heg
         bq9XPJ3DqkrT21COX4MLOIcSQxf18Y05mgKYxoXlarkO2T3CiadOSTCz47vC+ApmG4uO
         pnIdtvD3QcHboEPep16e2lKF5Ww/sbn8pGqGPoL+C+/ycwHJ5vhm7mZzNzXyr6P+RZ85
         qjKg==
X-Gm-Message-State: AOJu0YwoUHwRp7YTPM197w1ONQIAS41lVx8zoIAOVTyPQjVJRbqOPHJF
	gvjjxeqBRQFKwK0Y2UkWM2Ac1TChpOiGidRG5sbPhaXzT7YhPnQzGAGC6GMhQ1BRdBiTX+6gX69
	Mp5sB
X-Gm-Gg: ASbGncsPZaej4y1c/1q47uVDsLbbpv3Vem1Fc/eLmsEj460WXgZPrkTRv2G/GMU+mc8
	vdSTPC8+YT1IcXuw342M9xBIUdc8Gq4SLhQBupnZnJLa6EzWA+olSdDgp7E+z+PYnVH0GTzw1mY
	pEgdv8WrI5mghCEWdrq0kA45klGbv5p52SHc+sw6D8hhhejQRNMaOk0jegwGavFF9sktcbhsQTE
	tlVxyT0JdjMq5Q5Kvad/kxVsl7Xk/NWoLDXbMl00YfTpMxhqOeOM06zpzKtencOWVMujQiWVbMJ
	BQpqJNGguU5z+ldjQEgZnbTQ5Xg04Rb0bQWisc0vfjPmRiyrr64zgBKcv6kQMA==
X-Google-Smtp-Source: AGHT+IGF9kkHq2D7sAhTSbY7gkGLf+579rCp+JAYlJuNdBfKaUKaUnINA0WTF8k6WQgBZE7m8pZOpQ==
X-Received: by 2002:a05:6e02:3181:b0:3d8:1d0e:5308 with SMTP id e9e14a558f8ab-3db85737862mr271861965ab.6.1747949226326;
        Thu, 22 May 2025 14:27:06 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc4b3b55sm3280486173.131.2025.05.22.14.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 14:27:05 -0700 (PDT)
Message-ID: <e2ad679c-7c68-44c1-b4fb-20b3d02a7c35@linuxfoundation.org>
Date: Thu, 22 May 2025 15:27:03 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: acct: fix grammar and clarify output messages
To: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>, shuah@Kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
References: <20250513221426.303691-1-Abdelrahmanfekry375@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250513221426.303691-1-Abdelrahmanfekry375@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/25 16:14, Abdelrahman Fekry wrote:
> This patch improves the clarity and grammar of output messages in the acct()
> selftest. Minor changes were made to user-facing strings and comments to make
> them easier to understand and more consistent with the kselftest style.
> 
> Changes include:
> - Fixing grammar in printed messages and comments.
> - Rewording error and success outputs for clarity and professionalism.
> - Making the "root check" message more direct.
> 
> These updates improve readability without affecting test logic or behavior.
> 
> Signed-off-by: Abdelrahman Fekry <Abdelrahmanfekry375@gmail.com>

Did you run checkpatch on this patch? I am seeing

CHECK: From:/Signed-off-by: email comments mismatch: 'From: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>' != 'Signed-off-by: Abdelrahman Fekry <Abdelrahmanfekry375@gmail.com>'

Please fix it and send v2.

thanks,
-- Shuah

