Return-Path: <linux-kselftest+bounces-33806-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0ABAC42BB
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 18:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B327178546
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 16:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D825421420A;
	Mon, 26 May 2025 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCxvVceT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABDC15E5BB
	for <linux-kselftest@vger.kernel.org>; Mon, 26 May 2025 16:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748275303; cv=none; b=fREJ4iQS315ouFPtlgoBGJ9K2J1q3jU9lqoy1Qvs8buJSvq84B0Yvd0iR9Ui9TWxuvdQn4nKrKX025Av+fzlmfobk564HCfLtT+a3jAN69zI0ihozaxrPfJjyMw9g59B4+B0kBTFwFd90EKO0HPVutfzBrabamovSFv44A2ry8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748275303; c=relaxed/simple;
	bh=FTqaI7t8RxcXrVZU9VUNxiCBtuV0no5S+yCRZG/CB3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OtRwBNVLZavCCT9fiA7uU1mm9RpES6e0KXzbw18bHZyMeDpOS7IvCLxsfNuXnWklQqLy+JFJZgpgIGQy++IUd3iUmOWq+zoS/F/Oq7rQyVaJ4rbYZyS5lzZLxQ+gBF92iuE5RLT7NpMpAD+aHHQGfztTirPHTRHnZ16FngKDPoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MCxvVceT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748275301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WT8Ho/edJj/b07n6d4X1kH3ehVgioTniu78IFWGtIt8=;
	b=MCxvVceTxItb/1iyvqqP3kdHVuDx+q5JHEOUTRSU9Zp+3+R6Szta573mG3Mypvlj+/9e1w
	nYyGDo0eLHZuazTv5be7IUy62M3pPm5dFUQ+8zYWvrvkWNgcM/BeuwTSvJNNOLLUNxif2o
	9MnR2Ix3gXw0gKRQuqMxKYmuJRcVYW0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-Qt96OiYjMmed-lXIFmad1g-1; Mon, 26 May 2025 12:01:39 -0400
X-MC-Unique: Qt96OiYjMmed-lXIFmad1g-1
X-Mimecast-MFC-AGG-ID: Qt96OiYjMmed-lXIFmad1g_1748275298
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43f251dc364so13623585e9.2
        for <linux-kselftest@vger.kernel.org>; Mon, 26 May 2025 09:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748275298; x=1748880098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WT8Ho/edJj/b07n6d4X1kH3ehVgioTniu78IFWGtIt8=;
        b=K6EowHfH7m51JrMpSoLnl8aTRaxzrC3CvRBwJW/UiqC6VJilcaP/UkAql5qpLO7hHR
         qO8Qu1zz1EvpZrAqakVGupYnR1VpjBEaqz+DGZhCbOiAd1K/1LElcLXwceml2sPaCugy
         cDqjGCm5MfDsWB+DIzK/24TMPp+kNaSNQCegtFQ2hWR5hu2WNU5kPdxnt6Ok0V06ICxs
         zFSFCPLkadAdhZUrF9QVC5uDH/ohKGJF+pK78BekpVX505odS6KqGQMN9MNLf/4L1qIK
         9bfntD8ZXh4mY8AJQt3mmf4ANHL7YmAKHxTll4bviksSRpIISFO5bzosUV4POmtynXk4
         Vy2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXq/QgcxnpCgjFTC6KCmBD4X7VAQYKYuAzli1LlQ0v6ui4CnurOZejCgLhnpQQ1oWNgDZShzkBkbZoTt7lrcHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEP5x/2FHa0UhOKZSu1GzKOTFJzaW68W0FpoYCKdOAO9Bthexo
	HFb60j7qyrZkRSqEl89Dq36tiBZ1oEwj+uOIzuj9prRIKoPrd8IjCUPRZ0NeBDBvb6cx1nGxcmh
	TyK28tJM7u60M7uoc2O86/7P+39EixSpuO9cdwbLRsUVntb7u4gxXu7mXCpK3eqBhT0g8NQ==
X-Gm-Gg: ASbGncsoCr5Ghr+080AeVDc4bj4RU4X1WISBh+PQ8rdSa8JxQpS7GSNfTo6agUsoNOU
	o5Bki9NY6zq5avd/a9HrWTPSsOD8YSVdR8n5vMOwE4SoZKgE4UCog6ZE61fEze3AstQeLq6Ijaa
	syPOtJnuC/uWW1oRLqPNGPqePf3DnRKFNQG1TXjM7Sl2MJgbHQXWpZ0+26NKxlTEoJhEStPAcKH
	h7j7yPxxptW/r5Rh1lqA1BSR1Ay2YB2VbtPvPzM7LRunBSz8fBTfTANNd/mFTIgaVKaRjStNW9g
	fuxOoiE3wIrxXiYpjg4=
X-Received: by 2002:a05:600c:1c27:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-44c92f21e2amr65777635e9.20.1748275298236;
        Mon, 26 May 2025 09:01:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+50k3T5CMDiIgdqAVfAROx0cJKvW/edB5JJA880McrxNIY+zCPmgbCIcKfpwxoGKBgbrzcg==
X-Received: by 2002:a05:600c:1c27:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-44c92f21e2amr65777155e9.20.1748275297711;
        Mon, 26 May 2025 09:01:37 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810::f39? ([2a0d:3344:2728:e810::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f78aeb56sm236658915e9.27.2025.05.26.09.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 09:01:37 -0700 (PDT)
Message-ID: <18051f57-37c7-4994-8859-d0c41ef6fb7d@redhat.com>
Date: Mon, 26 May 2025 18:01:35 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] selftests: nettest: Fix typo in log and error
 messages for clarity
To: Alok Tiwari <alok.a.tiwari@oracle.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, darren.kenny@oracle.com
References: <20250526151636.1485230-1-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250526151636.1485230-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/26/25 5:16 PM, Alok Tiwari wrote:
> This patch corrects several logging and error message typos in nettest.c:
> - Corrects function name in log messages "setsockopt" -> "getsockopt".
> - Closes missing parentheses in "setsockopt(IPV6_FREEBIND)".
> - Replaces misleading error text ("Invalid port") with the correct
>   description ("Invalid prefix length").
> - remove Redundant wording like "status from status" and clarifies
>   context in IPC error messages.
> 
> These changes improve readability and aid in debugging test output.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
> Resending: Previous email used incorrect address for David S. Miller

You should have waited the 24h grace period before resending:

https://elixir.bootlin.com/linux/v6.15/source/Documentation/process/maintainer-netdev.rst#L15

---
## Form letter - net-next-closed

The merge window for v6.16 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens after June 8th.

RFC patches sent for review only are obviously welcome at any time.



