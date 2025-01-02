Return-Path: <linux-kselftest+bounces-23833-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1164BA000E9
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 22:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAB0B162DB3
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 21:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1DC18801A;
	Thu,  2 Jan 2025 21:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PhFstcPE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17717149E00
	for <linux-kselftest@vger.kernel.org>; Thu,  2 Jan 2025 21:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735854857; cv=none; b=aKK46KqFVlmukhGa9NSMyJwmOVlR28xXXZYsmF0PTRF6qmCFKfjwjy6aZAojbcLcDbq4ke816WHWeROwy6kdDitBCTLffG7dyex8WOzFm9OnambmUWsBjFnS6/EZW7pKYVF3v3gFMYgtw0gR3UYX9TcmrHcONJ4F4LFHar10gPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735854857; c=relaxed/simple;
	bh=kU78mF5kW5Hnjdg5dql7EbsehEbH28SrZSV1y3nzFjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QF8kQqyqXDNpu3SrEdTfHl1/Wvz5qLACR/nlhMNbrtSUAjYGRzSh9He40yCc4/JvmuJkldvCXUT0AqMAqV7O4viY26xYqJDB/gptcjF/roMdqW8jKZZe5zCH2apYRVgBZU6mxkrPwppOGWF1flFK0uif4ODQM/Nsb2TWlX2G3jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PhFstcPE; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-844e61f3902so1000597539f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Jan 2025 13:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1735854855; x=1736459655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vb+CXmVQcYCCcJ0o1VYUo5pG2EeQUuCscBXbBLRES9A=;
        b=PhFstcPE5c75lGbwHWNHQMzHhilP2nBn9RlNAz2pGrP23oyZeoWwstOjAKNvZKOI74
         /dgwDDYnuUCeuwkdAcG9em2vDz9E7imDz1EUiEcMAIMKvZfy0NZWptmYV8eVvrPxUsn9
         H3oUu2Ttv0Nycs/ElRM6+Dxqb0ZMPDKOUFpeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735854855; x=1736459655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vb+CXmVQcYCCcJ0o1VYUo5pG2EeQUuCscBXbBLRES9A=;
        b=J5cUd8e0yL3NQBpdJ/9rJEPRM2O/kEaMSxK5rRhPHiSxn0aMaNFuU64fGpRYhqv/3C
         EUHScbdyzBHH8M/hh+0fxCTIVWy0ZDX3GMaaUyFn0qiBpHVwpADYz36S24h5ob951ASb
         DyL0n+ipSojAd3qSDxIZ8+A5vKJRe89JVfDanngKiSuSW5mVwlDRFvMNLGCuGvVLHcd7
         mbvfOR+llJ17EqN4jmkMi8LbKDh9lpKhVtc4Kmc8oEaLUd5tPHeZd/h0XhgdHTfrr5tp
         DPU7iCf2XV0f7Pf2zhRDjDwaH2dfbioootWuPvdcS/sWMihepSnATG7CRM05D0mZyH7o
         9KuQ==
X-Gm-Message-State: AOJu0YxDeqsB3tmRCCms1N8aivtrQEBAAvUt2vAKPxCR8sjnPFGNrsRQ
	lSVy++wGaPEXcSWm6/qVOMvYekdqplou+wYJt37SBI33nfbYZ9s16MMj832Qr+w=
X-Gm-Gg: ASbGncuZ4Y2hIeX+bdRcn9U3rbPepQJndJZFR0MMsvyhWqR0cSjGyFjO/hkeoVIzHlu
	1qxG+6Lge0Snn4mdxiiDiHXYEX7WytfPGw/E0FjfCovbvHFzPOwcRmivvGA32AIq2MjgX6YS3Np
	eD1yCledBn91kugnf8+zAkYb0G+/3WASCB2hUHXapFQoI59u1mHfGrMw9bVg4cx+9ncdGljIAEH
	MYGL4Gmjok0UUTy/XavPV2BOZ7j6smUfc58Sf12FO9LXabAuIjFqQ1XDevanORU64IQ
X-Google-Smtp-Source: AGHT+IHaLfxeIIY1Sz5oN2E/SvXU88uIehaexVkthT0Qs/ehjc/U1cko+D3KTDf3tL9QaZ+WGKbrRw==
X-Received: by 2002:a05:6e02:174d:b0:3a7:dd45:bca1 with SMTP id e9e14a558f8ab-3c2d514f31bmr352252115ab.17.1735854855069;
        Thu, 02 Jan 2025 13:54:15 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf4f539sm7425519173.23.2025.01.02.13.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 13:54:14 -0800 (PST)
Message-ID: <e6d8cb36-089b-41cc-8ab7-90338bcda8de@linuxfoundation.org>
Date: Thu, 2 Jan 2025 14:54:14 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] selftests: tmpfs: Add Test-skip if not run as root
To: Shivam Chaudhary <cvam0000@gmail.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250102100459.1291426-1-cvam0000@gmail.com>
 <20250102100459.1291426-2-cvam0000@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250102100459.1291426-2-cvam0000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/2/25 03:04, Shivam Chaudhary wrote:
> Add 'ksft_exit_skip()', if  not run as root, with an appropriate
> Warning.
> 
> Add 'ksft_print_header()' and 'ksft_set_plan()' to structure test
> outputs more effectively.
> 
> Test logs:
> 
> Before Change:
> - Without root
>   error: unshare, errno 1
> 
> - With root
>   No, output
> 
> After change:
> 
> - Without root
> TAP version 13
> 1..1
> ok 2 # SKIP This test needs root to run!
> Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
> 
> - With root
> TAP version 13
> 1..1

How are you running this test to see the before ad after
results?

thanks,
-- Shuah



