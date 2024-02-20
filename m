Return-Path: <linux-kselftest+bounces-5090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDB885CC3D
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 00:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3530B23133
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 23:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26771154C17;
	Tue, 20 Feb 2024 23:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZfoSCKhd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BD440BFD
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 23:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708472908; cv=none; b=Y6UwNWi3kslofx9s/G3ScAmfngnYlzi2WlTLg+49dw06kMT3gKppiAva3aSZWrNdudy31vT8Ibs1AZP1/vCliKO2ZmpenmBiERbQGEkzJieog8LoYGV4oz/B3NE/htzM13uio7VVPnknFeNBr+yZm4cXi7AmepbBC+NtxfOx1MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708472908; c=relaxed/simple;
	bh=fuZAkR5PdVfbhinQGJnIwa3pfKCNONLXu9eWT6fsxgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZrF7KIdq8XKwerD+93HTqu2bofZNTtWrbmEXJigXAFnoPZEFKMrX/SMs8ZMQGYi6GXBLRJ/R6z5QfOQYXcvf5I9Vsrnm/kSqOs3JeSXC8ougyHluOkfl1MfILOa0PjH0OAQxvtlmKWmm2o+SfsPtlGOyv2OmecedgnxGn7HA7es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZfoSCKhd; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7c3d923f7cbso57505839f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 15:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708472904; x=1709077704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fzGo2UXBP96YP7eP8g0RXTRce65881jHCZhTyNQV5lI=;
        b=ZfoSCKhdfxb7beLGm7UbomGOtsQrlgU9jJHWs0K8YA8ohO4+AMq8Jvte0wPpeBQnzL
         wJGyp/0/iZ5ZGhIVyIL0UACc3bqNmT/OiBnl9EHn7UgXbtz7i90lOaY5Y+vI3xAEbHPn
         z5d3PM983/0DvZxR+Dh0akM5vGiMs1yi8cecQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708472904; x=1709077704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fzGo2UXBP96YP7eP8g0RXTRce65881jHCZhTyNQV5lI=;
        b=gflV1W3GDS95ELr+cONdKtTGi+QNP+PMmmiKJygNeHk6URo/32ustPa4U+3EYvggUe
         JwvYgmWCqrCwaWKBhhU/DWmfEDZ7yUeID+6EA8F4PlSzxucorEP4GF+san/ptzylejG+
         WrWaCOhkCVZOGdUopMeEtwCGUlj8AkHVJ8POZrswXyi4+Ih853lkGr4Z4VSKxJxqo6Gr
         7Il+6xIWI3IvLF3YWIJGJUnab24ETPIIMqQ+4YeqTu9GqqDgHvRihONymzkvxqBr72nG
         tEytoTVJHLx6396GwkKn1Z1DqadwKjs+duTpqBhaOtsAArVcfdknKx1Erv0pFGk322q9
         vEJg==
X-Forwarded-Encrypted: i=1; AJvYcCWoRlDAe1UVURjYKgPc40fgAn94nIFTRKfdqLZeloYVfKwjBvv1hiHUgYH2HOZERJtZgsixoPwR2CJo4LJo/mCUDrKHepCReLQ20Iwss2/B
X-Gm-Message-State: AOJu0YxbQjCD5Tsoqbiiqx/18IXWW9Y4+V10cklxp9pAZ5rTlSouqJWr
	fDPOMwudDLcMluN8WqHHy3VbXPcuZsnhIwl4tomnrFbavyLkegP3FPxSiv+9NGc=
X-Google-Smtp-Source: AGHT+IG1/1YsYMnsXtLZYferRX3hzBw3i766CbakualEEmFaQUQJ5dVX7b3CtPz35h5oGrEX7elUdA==
X-Received: by 2002:a05:6e02:1d96:b0:365:2bd4:2f74 with SMTP id h22-20020a056e021d9600b003652bd42f74mr7351422ila.0.1708472904537;
        Tue, 20 Feb 2024 15:48:24 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id j11-20020a056e020eeb00b00364f14861ffsm3036971ilk.76.2024.02.20.15.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 15:48:24 -0800 (PST)
Message-ID: <6e31af22-b1b5-43d6-85ee-6818dc8e8eac@linuxfoundation.org>
Date: Tue, 20 Feb 2024 16:48:23 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: selftests: Remove unnecessary semicolons
Content-Language: en-US
To: Thorsten Blum <thorsten.blum@toblux.com>, Shuah Khan <shuah@kernel.org>
Cc: Mykola Lysenko <mykolal@fb.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240213122317.1883-2-thorsten.blum@toblux.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240213122317.1883-2-thorsten.blum@toblux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/24 05:23, Thorsten Blum wrote:
> Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
> semantic patch at scripts/coccinelle/misc/semicolon.cocci.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>   tools/testing/selftests/bpf/benchs/bench_local_storage_create.c | 2 +-
>   tools/testing/selftests/kvm/access_tracking_perf_test.c         | 2 +-
>   tools/testing/selftests/timers/nanosleep.c                      | 2 +-
>   tools/testing/selftests/timers/nsleep-lat.c                     | 2 +-
>   tools/testing/selftests/timers/set-timer-lat.c                  | 2 +-
>   5 files changed, 5 insertions(+), 5 deletions(-)
> 

Thank you for finding the problems and fixing them.

Please split these up and generate separate patches.
Run getmaintainers.pl to get the right people to send the
patch.

Taking all these changes in one single patch will result in
conflicts between the trees and more importantly if changes
to one file have to reverted for some reason, it makes it
easier have separate patches.

thanks,
-- Shuah

