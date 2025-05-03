Return-Path: <linux-kselftest+bounces-32271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 914C0AA7E43
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 May 2025 05:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6393C1BC3A45
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 May 2025 03:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CA51607A4;
	Sat,  3 May 2025 03:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="jVUbotxL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB12713DDBD
	for <linux-kselftest@vger.kernel.org>; Sat,  3 May 2025 03:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746242672; cv=none; b=uqGH8qPSiKZbZxCD7QrRQGSF0i7A/bkOejxmhD0ngj4IvU+hmDlI3NiymusXjhjHPUJQtcDKCApSTjSHI4vTyCVPTt+oBDRiD9o114R5ABE387PMN4uiAm0y41gskRK8sJYLj0/lthzR49azRrPrBGodpBYFwmBTmhgq7uvrc7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746242672; c=relaxed/simple;
	bh=yu/6Tg8ZTq+DttRgp7CeLbDw8imhFFEHXPhv+8viRAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZyTkbqPluJZp8pPjw4rnLOgngcf1vq7yRiMNo0W9LJl5HOJ1wAc4VnzazFzliIBZ7KD4akUfgKFJWH8b4DhlEByFZD3O6n8exramGcdgjLl0h6ifj6A+O1Yd3WdW8+pvTmmGjrR52Te+/md6JXzP6LCTvIIfjXUuc7fM1ZChu+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=jVUbotxL; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-73712952e1cso2895979b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 May 2025 20:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1746242670; x=1746847470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=01S3EXrUvAFlfKl+vJu+6SWulW0bTDiNVSLWcw/lkYE=;
        b=jVUbotxLQ1dYYHuno/x4fTS2wePS9KHd7cLAiG4zWi8KtjFWyK83h4oHG62QqY1Ab1
         /Fdz87VC5CqmBRBo+LejCx7kH7PDiwPgmcwyc5TUqriy79hRwK6zXrH6y5x9Q3pN5AYf
         tkhOGMdQMLH4FZsa7Lv6sfp8NYrFEJfdN0ORGbt9UgBfFaFC6sqZY/ZgPpUhgRgLxlUS
         06pbLiTa81oV47swLcPKxMd7xgupHAQcyPLa3jqJzMe4dd1jTqKzHXwPUjvR5x0swMHn
         0LXaIWMrJ+/4wbjQY0E2zamKBKxa8Tq+Do8bnurZxCu/RfAIykR1u2rh07iXN+PvWPb2
         cDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746242670; x=1746847470;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=01S3EXrUvAFlfKl+vJu+6SWulW0bTDiNVSLWcw/lkYE=;
        b=OzmbDPtaiDURr/7SWyQfcIsRHWCe7bQJXlApQtjDwW9wXdA8RaDmfIo+bukNwTIg5z
         zVHdlXjYiRqKV951uYUFrX+19obIZ1sLfuwd4zRyih5l/wP+IuAo8EOEcPep1n2EraAG
         Issv7QU0PLFjdgN67m5EjOUeYOkuC8NVJMHPOit1Xhwv4rc8WUTgupgN3qJFIpH2vzZN
         9LZJA2KDQoEev8dMiANpu0FNnFs85EsLtFLCHO/pAywQUn3lmMgEaF9OV9f3R3eGzEBK
         +Deh0a4ADgOJAFpRqp/glFdWNAAfFHqJ/vkoR0sATjKFlw0TfdzoQhXUJs6P2xrb1CbR
         2dwg==
X-Forwarded-Encrypted: i=1; AJvYcCWBRHWelDvqe93d/P7xRgccT4lOS9aicPfv/jkjzNtGdF9YqHemwjieC7aPnvrEFShSXed73eZEx1gxsHur0jk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+BOS6bZhToD5Ok7XgVCP4nl9CaV3P6PkIUpXae+em3a35FYZJ
	mVi4W4lrpN+ERNtep8Oyqk13plTc6QuJfWJt44ACrR1sR1Da7QZCR+V+ESoiB4E=
X-Gm-Gg: ASbGnctYBhgCkrGYmHfJZu9LGqiIicW3kLckWjSon424dg6OPm4XA6afdUfKXgcp6OZ
	wXM/aWuekWPviEM5M9XzRVcC+LLnJV4JDCTeImUmdx+R2i9mK1jL/AGSQRS+3Ok1yxxuzvTeNNt
	PrI6gNwKYnj8mZSqAYMjJO4seSSFdxOZwaNne8bTcNR6JCK2CPUVfIbghPwieKVdU53g7EIolgz
	91rWbSOgLMMc6O1VSzZ0FW4l9ifML5AgOKHJabtkmsRHddbqNBm8y9CEeTbAoT5iW7i1XbLEHn9
	LqjUTR9rJ3dFyGuzKEeXDiaH74v/Us1gQz7wjFkpnXEbB8c=
X-Google-Smtp-Source: AGHT+IGKyyY6b5IkmssEe4hWWkvxqqRx2LJ7Sz66T8MoGjg3QVXwsluSYcL6JIqsHdUYbBH02YKfRQ==
X-Received: by 2002:a05:6a20:c90a:b0:201:2834:6c62 with SMTP id adf61e73a8af0-20cdef3e7d8mr8316564637.25.1746242670102;
        Fri, 02 May 2025 20:24:30 -0700 (PDT)
Received: from [192.168.1.21] ([97.126.136.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058d7a397sm2414292b3a.28.2025.05.02.20.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 20:24:29 -0700 (PDT)
Message-ID: <12ecd375-441d-440d-bb63-d83651cbb049@davidwei.uk>
Date: Fri, 2 May 2025 20:24:28 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] selftests: iou-zcrx: Clean up build warnings
 for error format
To: Haiyue Wang <haiyuewa@163.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Simon Horman <horms@kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250502175136.1122-1-haiyuewa@163.com>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250502175136.1122-1-haiyuewa@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/2/25 10:50, Haiyue Wang wrote:
> Clean up two build warnings:
> 
> [1]
> 
> iou-zcrx.c: In function ‘process_recvzc’:
> iou-zcrx.c:263:37: warning: too many arguments for format [-Wformat-extra-args]
>    263 |                         error(1, 0, "payload mismatch at ", i);
>        |                                     ^~~~~~~~~~~~~~~~~~~~~~
> 
> [2] Use "%zd" for ssize_t type as better
> 
> iou-zcrx.c: In function ‘run_client’:
> iou-zcrx.c:357:47: warning: format ‘%d’ expects argument of type ‘int’, but argument 4 has type ‘ssize_t’ {aka ‘long int’} [-Wformat=]
>    357 |                         error(1, 0, "send(): %d", sent);
>        |                                              ~^   ~~~~
>        |                                               |   |
>        |                                               int ssize_t {aka long int}
>        |                                              %ld
> 
> Signed-off-by: Haiyue Wang <haiyuewa@163.com>

> ---
> v2:
>    - Dont't wrap the build warning message to make scripts/checkpatch.pl happy,
>      keep it as for readability.
>    - Change the format for ssize_t from "%ld" to "%zd" as Simon suggested.
>    - Change the target to net-next tree.
> v1: https://lore.kernel.org/netdev/20250502042240.17371-1-haiyuewa@163.com/

Thanks for the cleanups. But next time please note that there is a 24h
cooldown on respins in netdev.

Reviewed-by: David Wei <dw@davidwei.uk>

