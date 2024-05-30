Return-Path: <linux-kselftest+bounces-10935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE438D520B
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 21:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A331E1F21DFC
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 19:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82D156760;
	Thu, 30 May 2024 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QMPlwtAB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593DE56740
	for <linux-kselftest@vger.kernel.org>; Thu, 30 May 2024 19:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717095808; cv=none; b=iKp0CnkuS0uNLH+b0F32RpRRmcLiaHvsLmhc1Kpn5vV49W6tb7tDfoT9nBb+ujMJvdiTA6OXc/WLeA1AQ8p79xryf9VsIvCwE9xRwAcC+ay+F2ThTg1K9XYcnK003DnSdngrdqZX+K6z4P91OGzbeogiTRXsGD4HL59Tdjuy8Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717095808; c=relaxed/simple;
	bh=gVV3+IFYD1OxH/Wqhf1iWQFzYnfj7Ay2H+idOty2pyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uK2fHIVhp1nOQyZ0ocxYeKSWLxGnlqlpNRHxDEBQ0f7QpIeRCCo140nE5sqdM3jG7eOyIxFlv0lg9hKythjZRznqotH6Rl32oKMuD6MpGBE1EnRlmIjhWszzvQ+Fseev3avH0+CPElWIpdPiVnd5XWc48RblBCkWBsLmlRFnA0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QMPlwtAB; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7e24aa659abso6971039f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 30 May 2024 12:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717095805; x=1717700605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ypmVzNDeZplp2odL/zLGgH80NvTjOKRz+Qmx+RXyRY=;
        b=QMPlwtABxb6varGIhZXdwk8f3EDnI1006FUZPLFIKKF4WFUZ0ajsRmAx3Y8YeDUc6/
         pEKSrZveI7r7KVAyTnfFEZFwI8W1IB9Byry98YkCRKEbUqC92RDPTzFnqta33dw8iXRu
         mcBmoCY26bFlGuyVzqV4eEC4Mu1A+qowzCgTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717095805; x=1717700605;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ypmVzNDeZplp2odL/zLGgH80NvTjOKRz+Qmx+RXyRY=;
        b=BplTo4FIv6DGv9Fv/YMd5duQ5Qhpw+TK0gNsZ8b2xMZX6P8a6kdSztWjVhcuL3wGMv
         Oag2U8nWT5oe+BGkJgKqxFnRil5jS8hsFUP6ubX1+Xc5W73ZTLUKsZT8bBRYaffAx0MD
         8O+LV5urBAU82GuTMrYpugEMDmbwbp9EXQOs14XqN8i4VIvzkBk3bA67dY9PME00XRLb
         4jLZu5q7TdFTMhVGEPk87j7+FDpj50ohCREQaSUXLoDeAOSOwUqfz//5Pfr4I6+/m3ez
         ZeNsTV/coCmNjZbQiryv1fBMkZu/1rIreixBTBzU0H8UxVSncKvbGPzBc2CAUCYIaAy+
         QNNg==
X-Forwarded-Encrypted: i=1; AJvYcCVOzfZjsMNxlJwH5ltFsfZDOCoGz7fQ9FRWKOGu4UhhFTOSvmn7prh5Ka+osa20PL4JmhsznlyAF8Hy7n/S370K/5Z2ljZlUYyNlrUVK7MV
X-Gm-Message-State: AOJu0YwZF5CW10djq+pKIllkc0E0kHIRconJWHI7CPGhKt9WsXv8hzgI
	GSKrrpIsrwMVGANd1perC5BoePcBgMxaF1DGWFacjGySMilm+8k0daSt/ZPhyvU=
X-Google-Smtp-Source: AGHT+IHL2RIktWzDYsXqMYxWTYOSCdmd0gSX4cuLtu57cIFNBVH+YBART6vih1ekHP9lPpA0zCGiCg==
X-Received: by 2002:a05:6602:3344:b0:7de:b279:fb3e with SMTP id ca18e2360f4ac-7eaf5d6865bmr293265239f.1.1717095804736;
        Thu, 30 May 2024 12:03:24 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b48b8a6db0sm61826173.98.2024.05.30.12.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 12:03:24 -0700 (PDT)
Message-ID: <ceb9182e-b6d4-4f6d-bb53-87efe5337230@linuxfoundation.org>
Date: Thu, 30 May 2024 13:03:23 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] selftests/futex: don't redefine .PHONY targets
 (all, clean)
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Edward Liaw <edliaw@google.com>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Nysal Jan K . A" <nysal@linux.ibm.com>, Mark Brown <broonie@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240529022938.129624-1-jhubbard@nvidia.com>
 <20240529022938.129624-2-jhubbard@nvidia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240529022938.129624-2-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/24 20:29, John Hubbard wrote:
> The .PHONY targets "all" and "clean"  are both defined in the file that
> is included in the very next line: ../lib.mk.
> 

What problems are you seeing without this patch?
If I recall correctly, futex needs these defined.

Please provide information on why this change is
needed.

> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/futex/Makefile | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/futex/Makefile b/tools/testing/selftests/futex/Makefile
> index 11e157d7533b..78ab2cd111f6 100644
> --- a/tools/testing/selftests/futex/Makefile
> +++ b/tools/testing/selftests/futex/Makefile
> @@ -3,8 +3,6 @@ SUBDIRS := functional
>   
>   TEST_PROGS := run.sh
>   
> -.PHONY: all clean
> -
>   include ../lib.mk
>   
>   all:

thanks,
-- Shuah

