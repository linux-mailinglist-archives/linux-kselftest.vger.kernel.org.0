Return-Path: <linux-kselftest+bounces-12883-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCD391B0D0
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 22:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490DE287F09
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 20:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584EB19538D;
	Thu, 27 Jun 2024 20:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiHVlzMV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85B914D6EB;
	Thu, 27 Jun 2024 20:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719521223; cv=none; b=Lz+9k/LJw7EUPQyAcHxRVdElpH+Kw8tQShvsoG+E1YyykUhnAc2irLidsNpE0pTXdGqV6QmqRM30yd+SXfOQMqnPjErn/Y2wdRRdHfjSoliZalEr1LBcSDgrfi/P3+ZDX5z5Cz50FTlxzbAE1b41ZyUuNELsNWHhOEU2qzuHQgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719521223; c=relaxed/simple;
	bh=J8wNVkW9OKohBk0CThwH8fl/CaAJdYl/rgs+UdQZL7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iSOdoJ3pYwgUe18nk3PLCBxhvz0xWpgiezHhSEoj5gJGt5zyVEGVHHHH/Jg52ZkHrlhRwJw+KO38c7SQzqGPRacyrngpfen10H4Bj6O3+scUfAstQ+53IJPHeosRTuwCnwOet9tZXDlkcmo7/t5Hk8PnhC+1aj/Wn4Dg1JdPuEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiHVlzMV; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-363ba6070b1so322808f8f.0;
        Thu, 27 Jun 2024 13:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719521220; x=1720126020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y/Me/sbbhBxto6mnhtQrh+i2DsVi3fAKWy8wDnRaFHY=;
        b=UiHVlzMVR03D+A7sFhjmhjHRJDoICXwOejWCEXWNFVXiehnDaSAq3Y4CMcJ+++lGtN
         VDCkuA+VTy/YIR6OcqhOEIxu8jq6qePOAIDsbxnm2zdSHNnNC7me6sWMCQGN93pmS4pT
         Egbf/375X5kF37q9uftTzM0wqyown2xyMfdj1UIJxe9RCI1c1hOzzGCNxbcKLP8KLBEs
         7xugtdceI7nMaj2GRMZwND4olVoGg5AuGbz+34jxTarCyEgRfzhrWPt2El7AIMJjYll2
         /bZWrpRoh4ErdVWDgiy6ZSnam2YRiafFrk0UVTVMB0mAiLjHqXTEJAqQOEt3nYwmiebE
         5I5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719521220; x=1720126020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/Me/sbbhBxto6mnhtQrh+i2DsVi3fAKWy8wDnRaFHY=;
        b=imnPbafzRHSbkbsDq+8BhGxtfdTTJ+c9oULBnEAWmHyJt54dxBGE1Sne9a4qFBY53D
         ksJX26gnM4fjpKv0zMEhNcSb6uN4bxkCabMFtxfSwE+fk8vflmiFrLLATQZ6xTLYrn3o
         sExneWKyx1TC+Ee/a8yPBYcxYWGGeGQ4wavlWX0tEwCosAAIoDuqXBthu20XrkbGpYYy
         N2LxXVqvkDYXCz1n3GJDH5XgDxERZPmiwbBDzVUVh0C9CP2sS47t/sifvDNKzwILWzk5
         XYu6z3Ibu17VbM3XWQFYQpUiqJAZ/X+DJq6pjIosAGEuT5Byv8K81hS6gp2pZE7g7d9j
         Vi8g==
X-Forwarded-Encrypted: i=1; AJvYcCXN3bvPSKkanjtYDkyeca9+IthaYoUNEOqun6wmU8PCfVjMI1oebaAErH/sb/bLe9KEVUpokfSsjXKPZDHhiOoMpYBkMEz7iUOTn4Ovumxs+iwtzkP74m8w8210mdXh/6/gcwQ5MqKvQuXXIbk2
X-Gm-Message-State: AOJu0YyNkXn8s7UYUtxq/aNFNX5XJ5vpCQRlC6xX/wf7HyKTsMj9hXks
	5klQ00btgNs4B4ItKXhwXuqrBDkfDUhe6zt4NcQuCCYFsYk7XSmd
X-Google-Smtp-Source: AGHT+IF2026K0+YMF6WMPXg6qWK7Jt9C4b1hNOawNu/M2emVzus5D+Sxs8FcCnpa0u+mfx/k0/54/A==
X-Received: by 2002:a05:600c:4aa9:b0:425:5ed5:b416 with SMTP id 5b1f17b1804b1-4255ed5b5edmr42671975e9.1.1719521219646;
        Thu, 27 Jun 2024 13:46:59 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:d20e:7300:8731:b664:1f4a:5ab4? ([2a01:4b00:d20e:7300:8731:b664:1f4a:5ab4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b097b77sm6432615e9.33.2024.06.27.13.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 13:46:59 -0700 (PDT)
Message-ID: <c63690e7-53b6-4751-ab89-40469d68275d@gmail.com>
Date: Thu, 27 Jun 2024 21:46:58 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] kunit: Merge assertion test into kunit-test.c
To: Rae Moar <rmoar@google.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
References: <20240618170331.264851-1-ivan.orlov0322@gmail.com>
 <20240618170331.264851-6-ivan.orlov0322@gmail.com>
 <CA+GJov6u0+y-GBS4c2pvEmvUdoezMpXD-MJO3e_G90yefMV-iQ@mail.gmail.com>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <CA+GJov6u0+y-GBS4c2pvEmvUdoezMpXD-MJO3e_G90yefMV-iQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/21/24 22:38, Rae Moar wrote:
> On Tue, Jun 18, 2024 at 1:03 PM Ivan Orlov <ivan.orlov0322@gmail.com> wrote:
>>
>> Since assert_test covers the part of the KUnit core (the assertion
>> formatting functions), I believe it would be better to have it merged
>> into kunit-test (as it is done for other tests for the KUnit core).
>>
>> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> 
> Hello!
> 
> This looks good to me. I don't know if it was necessary to move the
> assert tests but I definitely see the reasoning. Happy with this as it
> is. There are a few checkpatch warnings I have mentioned below but I
> think the use case makes it necessary.
> 
> Reviewed-by: Rae Moar <rmoar@google.com>
> 
> Thanks!
> -Rae
> 

Hi Rae,

Thank you so much for the review, and sorry for the late reply ( I've 
been on vacation this week, and didn't have access to my inbox :( ).

And yes, since we want to get the actual pointer address "%px" is our 
only option :(

-- 
Kind regards,
Ivan Orlov


