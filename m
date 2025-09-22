Return-Path: <linux-kselftest+bounces-42088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D715B93860
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 00:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D63F17119E
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 22:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C91B2C21D8;
	Mon, 22 Sep 2025 22:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpcw6JrB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D3B26B779
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Sep 2025 22:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758581857; cv=none; b=WW51rKn9FDSG++qZrQfN9JDUth2wDArX7X+nHwF4Dzat+jfoyg7KLhFEJgmDvUgEQbCPGiwkaQTC1b2iXkGnObRuE2iqZxn7M4ZVJAoKi7j8nRsKD0yraTOFY7SWMPvCEVdwShqZP2Z/S6ifSUIG2IwiJpOO/nPRL9945StY948=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758581857; c=relaxed/simple;
	bh=wJcpJFENZM3XJoASue2WgV0KmkWQXXkTgGWB1tLNT3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LeX5OC4fgxc3xAtF0i34bmC8cA7Zr5AKORbqKesZBg0/6v76y+w2pBJFb8ojCtaG/3HfT7K7gkqY1GhC4DgUccQdSlVoZKz4o5JSPZeN20ZZelgzq4HWAFFJeK3uHh1WhiPCXymLvtMUWWvvQHIMgPvMJGpClvcAjp3cUq1MZIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpcw6JrB; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-89018ea5625so1410036241.0
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Sep 2025 15:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758581855; x=1759186655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4PmeTUZt1oKPH7ak6kJVKMIBti4fjRyL0GgGscNM+JY=;
        b=dpcw6JrBZONtlfbZf9OG2m5/KRfsla9uLol1Tw++vgQFsv4TrT1yqfiOFt+Opzb4sx
         UyDRxhFZfPTEhKGXkQphaBcbCYkEduUOw961fGxkhOhyQ0dMDJ3Fa7jwB/HlnuD4WNK9
         eFPod4Nweq0sRavkxwnG5bRwV/89OHwxH36A5qL7rdZuGUoaFk2K4BnwDAEnlqLc4gaA
         vjX3U1sqBImFkDs6t0XHjhhyYiISdWR9Qz4rb5hghmBGbsDxRjfPnq54xihREHycdMtn
         vN5ueZQzw7ZhKX4rE3OBtmKuCjWWU7umQQz1nBQr9Ms9IW4+Lc7SpxDZAcmdMEzf1vUz
         lFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758581855; x=1759186655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4PmeTUZt1oKPH7ak6kJVKMIBti4fjRyL0GgGscNM+JY=;
        b=kyy8v8hw9nxURwesNv6hC2OiJ2uRCvIeMEbqz6hQVGFnSXpdpNlX+a16t7A9db5xuw
         wODSuTDyU7uUvd6aIyEOvIiGYVCdDm7bkjVThTydzzuG8yi1BCSq6RhoCtt90SqzZXue
         Kei0E/tXWnim41pxMUxAkYKUblmciLKS0EmOabaLZCXxZtCJKXejWim8BtPtM0Hw/imv
         AJtYWgxM2TXXiLL0XJsoJWEL35deC/ZSkdJyeeXxYnJwhYBZKhy+aEl1o0qeaJEu9c+p
         h7CazaNCTlj9DO7A4vNcS+CfnfPzHpmNTRpfLE361gVlnXnJAS6EqInoO2xvVFoPehAv
         ZTMA==
X-Gm-Message-State: AOJu0Yz+9BsJ7XHy50EIdx1gSXA3KhGiFSYfv0G0JoF5QlYUpY9jBflf
	VXioEV7FB4P5NeUANMRyXeLMqXMuB5NIQjV05uDLx1IKSh/JnZE1ZuWm
X-Gm-Gg: ASbGnctOt4WQHTSA9f6rtr7q6cxUFrMvKQboq5ta2IJDzIJXVwWs0yC9nYtWVPEGhxt
	S2i38lpKGITyK2rWPzrrpSqxpJ1u3QlhYt7Al9/UJkpT/wkPTZcDtUtyrEb7K0vgnusAQh5odIO
	K7tiCiIWwPLEWpcV3rD1lDMxmxWKpdrpfR7+K4hYCdp0aw0LTSZ7vn7RKcfaNDBMkdonvG8rLgO
	y2oVwHI1Sfl4dUOyBuG9fgn55UyVgcS5mmD12MCOwgWSoF6VIgIhhO7PlsQgqgA2Plp4uc0mxvd
	YtBOWNstpI2lzUZpMLVaq1JSMDaibSQ1xoQ8wS2fTrGfRfO7qg6FghB66MU88yLgzYPrHyg9ipW
	s+umx4x93cywXOb83xIEySsR/ImX0znBGe8pHUKQ=
X-Google-Smtp-Source: AGHT+IEvT9aPO8VQeqDviuBf3xOmqzdNdU8B4VMjX/6iETFgk5faqYljbrRsv10VslcAQOzyPiUIlA==
X-Received: by 2002:a05:6122:3187:b0:539:1dbf:3148 with SMTP id 71dfb90a1353d-54bcadf84e4mr233297e0c.2.1758581855238;
        Mon, 22 Sep 2025 15:57:35 -0700 (PDT)
Received: from [192.168.1.145] ([104.203.11.126])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a72974f24sm2963990e0c.19.2025.09.22.15.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 15:57:34 -0700 (PDT)
Message-ID: <29f30ca3-cf45-44fc-aec7-1db6f9694e5f@gmail.com>
Date: Mon, 22 Sep 2025 18:57:33 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: Fix Makefile to run targets even the ones in
 SKIP_TARGETS
To: I Viswanath <viswanathiyyappan@gmail.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
References: <20250920041914.7253-1-viswanathiyyappan@gmail.com>
Content-Language: en-US
From: David Hunter <david.hunter.linux@gmail.com>
In-Reply-To: <20250920041914.7253-1-viswanathiyyappan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/20/25 00:19, I Viswanath wrote:

> Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
> ---
> make --silent summary=1 TARGETS="bpf size" kselftest
> 
> make[3]: Entering directory '/home/user/kernel-dev/linux-next/tools/testing/selftests/bpf'
> 
> Auto-detecting system features:
> ...                                    llvm: [ OFF ]
> 

Hi Viswaneth,

After the "---" usually the change log is placed. The change log
contains the changes from version 1. Also if this is a version 2 patch,
it is best to note it in the subject line. The v2 helps people keep up
with which patch is the most recent.

Thanks,
David Hunter



