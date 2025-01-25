Return-Path: <linux-kselftest+bounces-25172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A61F3A1C252
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 09:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21B0A7A352A
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 08:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34EC207DF0;
	Sat, 25 Jan 2025 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1/0iT90"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193031E480;
	Sat, 25 Jan 2025 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737795529; cv=none; b=J/Er5AHVA+WzipE7wRRpuyx3iiRxsOlRQfbvE3UVJmojxkRctcDDlF55fPnr0zMSz8Ss5px9lzOIXtZdH959EYynWthsmHPsrQ6unrjFUh0DRq7iU7FV2bdRIgAg4sKJcvUPbkf/tcxyw/IZ20Cp8o9RCJNtFJ8s/tIOfADuaxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737795529; c=relaxed/simple;
	bh=TFLJTGQH+IfghEQHwQQQY305r9PjDiYbPFl+QY0G8IM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uxt4cTAD6xK35XhyBKi7ZhR/A7k/MOTCdFzYUqHhrhLSIltR+2Ln9II0D/VPl2QlepGOpH1FdJvGxFUpFM+l+nB55IBEA2wSB7Rd3x64+BS07bw4/FLkKdnAnGBt0Z6qylSnKf0UMVnZyXWj9raqWW4Az2kryxSUyS/QQxMif7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1/0iT90; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4361c705434so20061025e9.3;
        Sat, 25 Jan 2025 00:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737795525; x=1738400325; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lmwGPPNzlJtZJRego8Mf9GW0LIkhJZd2o2VD3LR/nh0=;
        b=B1/0iT90/KZw/gYnr1vrwyXLLG3cX0YDWoBDg7VDuDoxplAIbdf3gOUK7vL/JzWvmh
         kTlJHZVJz24IxpXa4cxnAm3Tv6iHg0U/qkDXORjtcBLyYsRXSU1+xh+AEszdUIKQlXDe
         4ZWWlbKjZCM+dWpBHXI5k7lcFhCRj6MjjKPmh4cLtzu074lLR7+32EmTiCVKlWHl5q3e
         gxuaslm84xqAe83cC7rUnSiHNHY2wYHzgOzPnW16SZtVbhh9cvPbR6bjhawB5FFYU99i
         4SNQWyDCBopof2aqwK8iwDkZz/nsRytbDipJnLeTRamZxdIv23vJEaROKFwA9jY8wvep
         ff/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737795525; x=1738400325;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lmwGPPNzlJtZJRego8Mf9GW0LIkhJZd2o2VD3LR/nh0=;
        b=A1PFHmq3BAlOOvWRZsiq2WVFxjZqLCknApIARLzfqGcRMBZQb0XN2Yu+bU38BvTpM5
         c+Swv2lN5Cn/3XRFvEfsSNgWAFcfMm+8t9YyE0NRFB0hP7u026Gn36WOlOO4ZDQvbxqH
         o1cwsWXMCzFjNdoLgoxJhXrEX9dUyUSo73n8ag/tutnUgOWqH2Ml3xZNx/RAN6VFXkrQ
         2ZW1m00oLfxsMD7Vaev7qAzZRiBVt3kqjjCQehNUyt5tEni3PrHgOMzAmAMtgGrqmTdc
         zxAdmkklLOikO0ptiPPMSK7LkKavnbFpGd17qFXMf5mjgcvAWh4nBiPqa7AGpZo74YkE
         l+LQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4hlghrB7qPQS/30NX+YFEQipgaqlB4TECPYhvTeZ6rQig7/TZlTz9I0Zd8JmjpC3FDFoTd0WpxV3pj1E=@vger.kernel.org, AJvYcCVs0bsXC/vzPQVfjuO5tC0AyIITkUEF4H5+/lk+9/i5mL4I+UYkffsYfZFeFgaTWapVVXy31woUltxNscY+KSkH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8eyUirOvsgqwxaF4iXx++YPJ9Bnore6JwTzC9WKwoZ3Aga6x/
	/F1aHcyRUXMWa5xQ6ZsTvctq+98S2AJuIa+egBzqHXiH6BuoCMxE
X-Gm-Gg: ASbGncuM3QYl5lZ94XXIq30l72P1BG7eWSs4/oZskjlzGoLpRydkyu4WvdecLpc7Oj8
	naYmdiUsznWNqbg35kcjZ9Kt99hubVSFI7dEFrfAmIvRQ423/BC1APUe0yqWc9YczCXrxj2T/MB
	X3HDp7T9ZzVe8R6rsxZsDWoYcjVIwV9X8UR/mBaNVKq4HmPaE01HCfAT80ZPukzr+WjXokQmwLa
	TGjyIViNV5NhtWAIYiKtEQkdEzb+uOJX/HtD91fPXwPK5ecXtyfa6Z44KCDyfkxxyX+YAwnRHHR
	N0CoWk0XhPq09EK1Dcfiaw==
X-Google-Smtp-Source: AGHT+IEkPmayOMbCgrecuRx9ckGS5dq3Zg+z1tS6+pEg63yu93KOXX9JemlG6tTnhvFbmGOVqkBuQA==
X-Received: by 2002:a05:600c:510c:b0:434:a1e7:27b0 with SMTP id 5b1f17b1804b1-438913ccd4amr387244395e9.11.1737795525059;
        Sat, 25 Jan 2025 00:58:45 -0800 (PST)
Received: from [192.168.1.14] ([197.63.236.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd54c0ecsm54661695e9.30.2025.01.25.00.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2025 00:58:44 -0800 (PST)
Message-ID: <518c6b84-63f0-4192-89a1-af0e8000318c@gmail.com>
Date: Sat, 25 Jan 2025 10:58:42 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: tpm2: create a dedicated .gitignore
To: Jarkko Sakkinen <jarkko@kernel.org>, peterhuewe@gmx.de, jgg@ziepe.ca,
 shuah@kernel.org
Cc: linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250122065021.91814-1-khaledelnaggarlinux@gmail.com>
 <D79CVJJBY9KX.23K6C7S5BU8AV@kernel.org>
 <d7c0995d-5159-47a8-9193-d9d29fdfeea0@gmail.com>
 <D7AG8K6T8KRI.LZFD4J6OFGGZ@kernel.org>
 <D7AGBYQ5T2P2.3L3HM84HUCS1V@kernel.org>
Content-Language: en-US
From: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
In-Reply-To: <D7AGBYQ5T2P2.3L3HM84HUCS1V@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/24/25 6:42 PM, Jarkko Sakkinen wrote:

> Shortest ever commit message tutorial:
> 
> 1. Problem
> 2. Motivation
> 3. Solution with explanation how it will map on addressing the problem.
> 
> Do this for every possible commit and you will get it right 99%
> of time. I can admit that even today I don't always get this myself
> fully right but I try my best ;-) That does not mean you could not
> do better than me.
> 
> And generally, depending on subsystem tho, people usually feel more
> confortable with "imperative form" rather than "science paper" form.
> 
> BR, Jarkko

Ah great, thank you for the review the tutorial.
Hopefully, I will do better in v3 :)

Many thanks,
Khaled

