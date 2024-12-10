Return-Path: <linux-kselftest+bounces-23112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FA09EB77D
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 18:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ECD018875B6
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 17:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521E523278D;
	Tue, 10 Dec 2024 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gt3CEPNK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931A11F2385
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Dec 2024 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850585; cv=none; b=X4Wa6TQwTIqGKPey3lfqWdBpGYjpuxSakXddh4qYy/Nm/+7JlkOlxzEmZU/eNUI3Gt1jjQBPPzs3zA5bqEIag2RGTkQXncafgS26MY0ppd5GKxs9JT+PyBDtR6U5f+4eb4BPqanIkZ9+6fi/TYG8IY3cOSq4KnBkiIUzgmx/9FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850585; c=relaxed/simple;
	bh=tKekrqKeGf6d9vYVMyQ3P703Igc2K4qbjZIE5eQv+pY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gYJ61ZPa6EtioZ0uGjLHOTZ3n8vw+d2Qud6YTIir86q769HzVO8+S2JARmaSFR0SRfp1p8sltLAQt0VufM5etcNEkzf5xxj/X7xr7iO+TakYAB3L37yXwMaZJneEwtegdK64uGM+B/NsVh6DYd3g7HmZnPVlr/p5oQ87yYcXb1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gt3CEPNK; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-84197c469cfso180395139f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Dec 2024 09:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733850582; x=1734455382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mW0gDbfd7x2YjOT5s67ijl4s8F1BicI07drWQ2jAwxI=;
        b=Gt3CEPNKO+mh0ZmNvoyBkrcKMecaV+/lUC0lLD8wXt2YbpHiCdf7JA5ZEa4TTzVzVi
         l2TqiJZyRgdm9XoEHT41RzDHZHEibvGhos3U6JHCHjtSdcz2nm0Ybie1JH9SJWQBR9zr
         O9ZUe2qD2vAedKRqUNQV7jDuw23mzbuN/i0/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733850582; x=1734455382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mW0gDbfd7x2YjOT5s67ijl4s8F1BicI07drWQ2jAwxI=;
        b=c/+5FSrWkmO6QXUXzZ9Uu0Rdd6c+HvU6djaKc0oaIIJ7QVeIyYA78GGbETWi5j6mRo
         bH6ffq7X6t+NO0W3VY0ccslwQKFf1M613vk1ZJtwCe+lbDVleLz+yA9noPa93zGGNtx1
         HIG306CFr2RVSC/qymWVxfcnpqpCJEyEjpmL09xBztfNW0rs5SQAUhW6FGPbMVw3PT62
         2QqPeC2RP5so/szGIAO1WVjq5KhRdyoVkSTS2iQ2japwC6Ap4lnqKGI6SJwaFgCi2qAR
         d+cys4uNcY3o78kPzk3HyAps3jpit5GVBO7M7fjB6AfRoqrGsXGOXxnmph1E1/Kt1vCI
         USqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSt7mQzMH7eB8l6SpAP0dFI4LImDD54PtRrj571hhBVJ/qSIJBSBr7zCTEPV/hXDhcaKxE47nKevjAaxJfeFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg8CC0I1j4LdJ9grUJ1Gtu6LWKJBHqW5x9RJUD23jg+zg+j29+
	1Q3d8w5ul8ZL/J0ICxviYgTTgrsZ3/kRsFkr8ONBpV6OA1unsx1tm8RSa99Vdtc=
X-Gm-Gg: ASbGncs5BECqp9QMFLbohpMXyimmSbgqBaqFFaOf3lCw7YaXmm0ZMKwUzidN/h4m6/f
	aGGQ79tXW2hGiANdenCq6/8jhLHIRJyovDH1WR7A7t1sNt57cqTlmrGzQweURsryvc6NgGCwdwy
	UUh3ILZeggTNyegf+Zlluob1LtBXdsNMbVnifwHW8XlZNU4eLVY6weLFD2k0B0+vuBpvb1hk9Lp
	wwY46+yqhHxuy/RPUE+H/asoxUgE2PeES/V22SFCPnUuHlUUoTzYGdvB04rypUjvw==
X-Google-Smtp-Source: AGHT+IGWgeP8na4CqUGSLInUNKTCqSBVH8PPSLnNTomVYr/Tb4GqyreTLn1kP9mkki1218RqwK5WQw==
X-Received: by 2002:a05:6602:134b:b0:83a:639b:bc44 with SMTP id ca18e2360f4ac-844cb5bc021mr4606839f.3.1733850582516;
        Tue, 10 Dec 2024 09:09:42 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2c0635f98sm1095839173.9.2024.12.10.09.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 09:09:42 -0800 (PST)
Message-ID: <d139fee4-aadc-4c04-8e1a-1fb8751c7734@linuxfoundation.org>
Date: Tue, 10 Dec 2024 10:09:41 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3] selftests/zram: gitignore output file
To: Li Zhijian <lizhijian@fujitsu.com>, linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241122074935.1583747-1-lizhijian@fujitsu.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241122074935.1583747-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/22/24 00:49, Li Zhijian wrote:
> After `make run_tests`, the git status complains:
> Untracked files:
>      (use "git add <file>..." to include in what will be committed)
>          zram/err.log
> 
> This file will be cleaned up when execute 'make clean'
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> Hello,
> Cover letter is here.
> 
> This patch set aims to make 'git status' clear after 'make' and 'make
> run_tests' for kselftests.
> ---
> V3:
>    Add Copyright description
> V2:
>     split as a separate patch from a small one [0]
>     [0] https://lore.kernel.org/linux-kselftest/20241015010817.453539-1-lizhijian@fujitsu.com/
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>   tools/testing/selftests/zram/.gitignore | 2 ++
>   1 file changed, 2 insertions(+)
>   create mode 100644 tools/testing/selftests/zram/.gitignore
> 
> diff --git a/tools/testing/selftests/zram/.gitignore b/tools/testing/selftests/zram/.gitignore
> new file mode 100644
> index 000000000000..088cd9bad87a
> --- /dev/null
> +++ b/tools/testing/selftests/zram/.gitignore
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +err.log


I am seeing duplicate signature warning on this patch. Please
fix and send a correct patch.

thanks,
-- Shuah

