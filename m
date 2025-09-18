Return-Path: <linux-kselftest+bounces-41887-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9541B86609
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 20:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90A2A547A92
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 18:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721D12C1780;
	Thu, 18 Sep 2025 18:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N9KivoIk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F5F208A7
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 18:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218822; cv=none; b=JQTX958hzR96g5Y53XQBPKG+y11L+PwfBlLJgOCE+w/YDxWXpP+bLFAqkWj7689YUItdtXeQ/LPVRgR2om5vkc6My/b2rH/+s7UgJV1mMvAqjImYG1AiZRpU3tCeYaarjtGcicvOfdylcmLRwyjPHPO6wz4bHkmLIzo9a35aRBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218822; c=relaxed/simple;
	bh=b1VI56OWvK1tmwsX2dbcopiTFH8Zr46g+PeA7taEl/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrkY52bxW21nMIAugJkmHZauJ6doMfkdGwcuTtEklfePkMqtd/Tk+mZuTJ3j/4s8fKpP4d5I/Y0Bz3kxwxl7RSp2/LfptGqa6QtKvOWCadr+HgkFd64x9unC+uMP2MICoRIBQ6VakVGvQWJNQeLu9SG0w+zHetvVhdCJ4L6eNvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N9KivoIk; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-7960d69f14bso4893936d6.2
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 11:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758218818; x=1758823618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mPBEn4/fueUrJT4RnliR6Zn3+7CEMnoE1lnAFIQBudU=;
        b=N9KivoIka+dKRgzWt96FZT7HBlZSFZMnelXRrjkDAo59HIf3aH9HxRL08dK1r3SImB
         PqhZKZL7cZRRS1PkvRiZYbs7njh+fpTGh3FzJAzy7ExF0ibmMdSMtPB9XjKxpuPNNiQl
         zRn81F5wc667GlBqynLWLElcgs96yxPVhEfEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758218818; x=1758823618;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mPBEn4/fueUrJT4RnliR6Zn3+7CEMnoE1lnAFIQBudU=;
        b=P96oY3sED+6r3l6Expo83DaWf4FUtzBvpTc5OndpXH/aBTuuJweYLKxs37UnJPc9Hq
         VV/WFhvoydlnSJqR02FT60HiWExnpWGRqfohmh9EV6n2LUbAHBQqxJ8z3sZUy/a8uUzn
         Bh+xk7eeIFvAzzy8vyZ0XsXaQDYlW+iNhZewUv2SRppJQVhlKXA8PHOgpWWka6ULrOMC
         RedpH5xUiyeC3xrwn42AahdI5qWuXUkrp0YnxlmIH2/uJyZAIDlht3mCp7T3VID4t7Gp
         JaFRddj8t6wvNohB+5OvdFPqueAlGGrVoq/DGSMkaabJvzOn/kd3qv+1U56o8Ctpw2rP
         FgHQ==
X-Gm-Message-State: AOJu0YwWmlyYfyv5KW2sMk9EiuDv5iUz1hjqF0C8FJMZEk5ybRXo6OwA
	jyOTh5RbhQFm2zrkDC17Dn60+Q19ERnsqOPsyUqncJnxoG3tsDg72/KsMlRxVUCxLRQ=
X-Gm-Gg: ASbGnctbgcHEBBuJw5ijkAh0YqsH3GTBvkqPDqCD7qgMzUJyJYbTdS5FFryneKJ3jer
	NVtg//eEQNRZKr51eyheFHfum4TBb5UG6ayqTWeCQPATO5hIXW0YT/5bSeRu0w5A+5isK7wGQ7P
	iliDn4p4OZq2gbOqiRlqIbn/7i/Td+ON7hgkl3mDTrpIY9t+NGQZ75FcBDlXVb+28GJp4NGv8v0
	t8HHT47Jhqnu9yaUYdLWSm8+tBZw3kGFsxW/VHvzOcuQcWRG9dMhiLz44aDT67IIMTNsUyUTZK9
	Ib3YaVgLlD4eZs907oS/h9nYK2SAmCd81LPH1wmjFXvwE9wzCkdU6SPy29epO+gcGsh0e+wLr6c
	oonSv3yMshftq6L24c/XYpwYw7cxR58/34wIqZO5JhksBo57zuMaKFCjxoEV1QIvyalbCqUrsXI
	SIEaOVIGj+RilD/R+mHkFO2YnRb+oAW3RTzCqPpAxWcm77TsdhkTkgaR/VDtuA
X-Google-Smtp-Source: AGHT+IEYz4mCFMtgI1U2y62M08ruBZjhmxD/qpb8wLHUyuXItNye5CldaDF1VaKgqhs6Ma/cWnWPow==
X-Received: by 2002:a05:6214:2462:b0:711:75c9:1766 with SMTP id 6a1803df08f44-7991c124caemr4124536d6.40.1758218817573;
        Thu, 18 Sep 2025 11:06:57 -0700 (PDT)
Received: from [192.168.1.239] (207-181-222-53.s5939.c3-0.hnc-cbr1.chi-hnc.il.cable.rcncustomer.com. [207.181.222.53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-79351f70e9esm16735056d6.42.2025.09.18.11.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 11:06:57 -0700 (PDT)
Message-ID: <53ec38e9-5ba2-4a5e-9bfb-ba43e411be7f@linuxfoundation.org>
Date: Thu, 18 Sep 2025 12:06:56 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: always install UAPI headers to the correct
 directory
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250918-kselftest-uapi-out-of-tree-v1-1-f4434f28adcd@linutronix.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250918-kselftest-uapi-out-of-tree-v1-1-f4434f28adcd@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/18/25 03:56, Thomas Weißschuh wrote:
> Currently the UAPI headers are always installed into the source directory.
> When building out-of-tree this doesn't work, as the include path will be
> wrong and it dirties the source tree, leading to complains by kbuild.
> 
> Make sure the 'headers' target installs the UAPI headers in the correctly.
> 
> The real target directory can come from multiple places. To handle them all
> extract the target directory from KHDR_INCLUDES.
> 
> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> Closes: https://lore.kernel.org/lkml/20250917153209.GA2023406@nvidia.com/
> Fixes: 1a59f5d31569 ("selftests: Add headers target")
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   tools/testing/selftests/lib.mk | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 

Applied to linux-kselftest next branch for Linux 6.18-rc1

thanks,
-- Shuah

