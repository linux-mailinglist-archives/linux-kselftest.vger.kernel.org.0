Return-Path: <linux-kselftest+bounces-15502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 747BE954ACA
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 15:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC031F224C8
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 13:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F4F1B8E9B;
	Fri, 16 Aug 2024 13:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JinFHMBn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C341B86EA
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723813920; cv=none; b=JsCjzAxvgAv2cAjyCIIqfPONDdehm/qzSo8WfyLzfZIXW/4q9zfCAkEZ/mfBqMJBiLt3QeW0Ljj8UgMdFCKml53qjk2MMJou9dCfcFmWr3ywq3SxY17ChFdWWrbDkf/8YuBJI2WCEhaqycsIdAcFmOFMryCKR7e4uOcgJMS1Ov0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723813920; c=relaxed/simple;
	bh=a2pNSwOsHeYx6QGFyVQdg47h34GFh7KMP5VSyGB2LdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j6b5qkxIpzBtYhV+sQDtjoKw7f3NQLFuH77LdGlwH4Ms55ZXtYtFksuSCzpjK80gzGg3oYeTgufhUTm4wkDFz0HNe2UCjL5c9u+QGCg2oidGq6Ry/2bXggzW9QUDG3jV0Nbod3MhltNSmp8ot0BIjoVJnYWPcvvghh1t6IDX/VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JinFHMBn; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d3c99c5d69so273576a91.1
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 06:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723813917; x=1724418717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jOOjcc/L4SG2Qbq5m2R9Isfxtm2CkUpxlVXdKeLZs+Q=;
        b=JinFHMBnHYsHGTQY+Y/FkSft8PRhB6e8OX/6KmX8x0fLvftKVHmew3WyiPP66XtIvN
         dU2Smxt94x4MRGDomJ3ritCJLr28xsb/2josNRzN7GwWsXMX0bZP9sBxGLB2KQcR9Ay3
         hHi6LIz8UtInqn0687qvz7EHXC19bvCya5vT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723813917; x=1724418717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jOOjcc/L4SG2Qbq5m2R9Isfxtm2CkUpxlVXdKeLZs+Q=;
        b=Foyne9F7YUvJwwZY9nRou6/JkzKOV9sggzRGh4ecoM11dHuLBZO3jWVBVdDyWg9zzQ
         mmBxSYut5Uxt4BGGrbE3KXcHFpVZlaB0tlCXVyuTtHgDrTBJfwlQTUO2q0s9KlEnGpSm
         nPJqy/H6ShAnuo4efRrT8RfVotLhNXG5S2kyY7pd5Wrx9NFI6sL2JR/jEtmCJ0HvSZ98
         G4XcrqaebyYrrGqumsaKlaInsHZ3rEWI6QdQAyVQYozXaMWgzQA4ey7RDJkRHhswo+LK
         txBNb48VuYl3QhEpgqkG655zGvbfhgqBLwyIubtmQT7386P129GpDRses/9GgtuTODY1
         vxzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU33+EawkKaMdD1EtimNnJTvnTzam2iAHSejEK21uB7gAxoAWVqZjChquso0b5CXW1CCgaNnYNZfFZzRmHRe4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB3IZktBC+hWlbjQsqX8O15S1Wj/kIdeldbIVRWvPspgUQTU2n
	VcOi0XUsZOltBzeQ9D0L08dBGEnMM9YviDEATMeeePt347lalI7TYT6ny+Qh3pY=
X-Google-Smtp-Source: AGHT+IFFrYUA3iTX/XjR8/496QJemxRxgGWHBVG0pZ5Q3Lhm7IFVlLwH2Y002fRnr3Yd951mHQ1gMA==
X-Received: by 2002:a17:90b:3d7:b0:2d3:c2a3:2383 with SMTP id 98e67ed59e1d1-2d3e1733fe9mr1784597a91.0.1723813916944;
        Fri, 16 Aug 2024 06:11:56 -0700 (PDT)
Received: from [192.168.23.95] ([126.249.175.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac856c64sm5562018a91.55.2024.08.16.06.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 06:11:56 -0700 (PDT)
Message-ID: <5fd97d54-fa64-4c03-865f-961ed4596a6e@linuxfoundation.org>
Date: Fri, 16 Aug 2024 07:11:54 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: filesystems: fix warn_unused_result build
 warnings
To: Abhinav Jain <jain.abhinav177@gmail.com>, shuah@kernel.org,
 brauner@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: javier.carrasco.cruz@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240810135333.672845-1-jain.abhinav177@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240810135333.672845-1-jain.abhinav177@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/10/24 07:53, Abhinav Jain wrote:
> Add return value checks for read & write calls in test_listmount_ns
> function. This patch resolves below compilation warnings:
> 
> ```
> statmount_test_ns.c: In function ‘test_listmount_ns’:
> 
> statmount_test_ns.c:322:17: warning: ignoring return value of ‘write’
> declared with attribute ‘warn_unused_result’ [-Wunused-result]
> 
> statmount_test_ns.c:323:17: warning: ignoring return value of ‘read’
> declared with attribute ‘warn_unused_result’ [-Wunused-result]
> ```
> 
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
> ---
>   .../selftests/filesystems/statmount/statmount_test_ns.c    | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c b/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
> index e044f5fc57fd..70cb0c8b21cf 100644
> --- a/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
> +++ b/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
> @@ -319,8 +319,11 @@ static void test_listmount_ns(void)
>   		 * Tell our parent how many mounts we have, and then wait for it
>   		 * to tell us we're done.
>   		 */
> -		write(child_ready_pipe[1], &nr_mounts, sizeof(nr_mounts));
> -		read(parent_ready_pipe[0], &cval, sizeof(cval));
> +		if (write(child_ready_pipe[1], &nr_mounts, sizeof(nr_mounts)) !=
> +					sizeof(nr_mounts))
> +			ret = NSID_ERROR;
> +		if (read(parent_ready_pipe[0], &cval, sizeof(cval)) != sizeof(cval))
> +			ret = NSID_ERROR;
>   		exit(NSID_PASS);
>   	}
>   

Hi Christian,

Let me know if it is okay to take this patch through kselftest tree.
The change looks good to me.

thanks,
-- Shuah

