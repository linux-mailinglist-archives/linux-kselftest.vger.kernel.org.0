Return-Path: <linux-kselftest+bounces-15997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0713995AD9A
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 08:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF70A283973
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 06:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6FE149DFD;
	Thu, 22 Aug 2024 06:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ceYXTkL/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774073F9F9
	for <linux-kselftest@vger.kernel.org>; Thu, 22 Aug 2024 06:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308547; cv=none; b=GOCyUrV55nNoxmLzHRlKbrtmuiX48guMSOO1Fz3lmJviWLh8LSIdCVWwOrgvzL9IO1wonNrtdidhCJ3OvBvzVkBb2pn56eo1ba6AVb1eJFyPcT4LiQ8gKeD5Fhs9WTCGRogY9cM4B/WcL2svuXrCFr/Jc5JPyrXPHcerVcSBNbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308547; c=relaxed/simple;
	bh=b1Rjn/LoT4SVNUvdIbtF5xG4HCH2Vh03+ZvfsoT+6QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sVjiI1k/Ce6E5MTHJIzn5FOi74Ow2RhjUIMFuh3Q3u5ig3RCM/eZw7rOJ+TLfP1tPYOmRSpiuUHQFATjm7o403qXGX9XqxwFPIAgoDxmZZ0J5sySKBkmIrcBtmZbCeM9YzdJHADeaYAiYdl03mZEjvkuugBMxJGlBxYjcv39D5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ceYXTkL/; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7141b04e7a3so361813b3a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 23:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724308544; x=1724913344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZBvE2aI2i9bgj0oTunHmmcWZsTQKUBCqSDTMQZFxlBk=;
        b=ceYXTkL/a8YyxPp7tYM2LM0CpsvJ7S3/d2fFXq0NoDisg43fTl6uc4an/CnbD1Wnwn
         kYkjyri/4n8mRGg7lkpcfr/vKKjT7fM/Ar8IqGhdDibdoHh1kuKVZ+nn6KvvVu1OU9lJ
         jyWh9Z4Z6Envzokr1pdmjjtpdokeUrhtAcm/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724308544; x=1724913344;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBvE2aI2i9bgj0oTunHmmcWZsTQKUBCqSDTMQZFxlBk=;
        b=BdjMYVpgWcmRUPO0u0NIXhgt3yPbkxq/Aqd/0zDJmnR+miV1a8srMeKkJJXzbNDARH
         CGDUb7qX88jFdE+oA47plnJuuKyz4kslWIROejdWsTTmUEjbE6U3fhIBDI/coHfMyh5U
         kG3B1d7t5EQNmo+FOtNnewEQ6JXlMbg5v98Wxvi6W089B01W14Y5i62AfEoajC7QvDiD
         MPUxT44xFDnNjr90kahci1nrPECV+rR8rCCxcGYcy21QQpAVyZ1TzAAdAqApD9T5qRmm
         JFSvY/wHNFmu/B4zce9QP1NOr/K88i6+RmgxxJL7nDQIrjRRhGK2iCLABcFZ1Xzg8kwg
         DH9Q==
X-Gm-Message-State: AOJu0Ywk9hIQVAF/nDHeQl3sLJvMF502d1dQGO8S85zSwCqVT0JlR/g3
	YgC79Q+1kdkPWUX2l/wA3CDE1zTYrQNjQKw8ZGM6tMpGA5JOKr0w5Jc/x1N/QMw=
X-Google-Smtp-Source: AGHT+IER0WQ+/su1lz1ifCQxR447du9FfvrK0RFQYuNrUA4Yvo/ANK+eRZi8xzBprVPl4EDdhqPgwQ==
X-Received: by 2002:a05:6a21:9786:b0:1c6:fbf3:a0ef with SMTP id adf61e73a8af0-1cada177b21mr5940374637.44.1724308543509;
        Wed, 21 Aug 2024 23:35:43 -0700 (PDT)
Received: from [172.20.0.208] ([218.188.70.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434335e69sm676348b3a.194.2024.08.21.23.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 23:35:42 -0700 (PDT)
Message-ID: <875a6d1b-31ba-497f-90bd-a36c18f015a7@linuxfoundation.org>
Date: Thu, 22 Aug 2024 00:35:35 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] selftests:tdx:Use min macro
To: Yan Zhen <yanzhen@vivo.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240822044630.1267500-1-yanzhen@vivo.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240822044630.1267500-1-yanzhen@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/21/24 22:46, Yan Zhen wrote:
> Using the min macro is usually more intuitive and readable.

How did you find this problem?

> 
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> ---
>   tools/testing/selftests/tdx/tdx_guest_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/tdx/tdx_guest_test.c b/tools/testing/selftests/tdx/tdx_guest_test.c
> index 81d8cb88e..d7ddf5307 100644
> --- a/tools/testing/selftests/tdx/tdx_guest_test.c
> +++ b/tools/testing/selftests/tdx/tdx_guest_test.c
> @@ -118,7 +118,7 @@ static void print_array_hex(const char *title, const char *prefix_str,
>   	printf("\t\t%s", title);
>   
>   	for (j = 0; j < len; j += rowsize) {
> -		line_len = rowsize < (len - j) ? rowsize : (len - j);
> +		line_len = min((len - j), rowsize);
>   		printf("%s%.8x:", prefix_str, j);
>   		for (i = 0; i < line_len; i++)
>   			printf(" %.2x", ptr[j + i]);

Did you compile this patch and test it? I am seeing warnings during
build.

tdx_guest_test.c:121:28: warning: implicit declaration of function ‘min’ [-Wimplicit-function-declaration]
   121 |                 line_len = min((len - j), rowsize);
       |                            ^~~

thanks,
-- Shuah

