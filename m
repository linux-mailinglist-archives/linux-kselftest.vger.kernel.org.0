Return-Path: <linux-kselftest+bounces-22779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F249E2E6B
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 22:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D2B3281C1C
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 21:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463DF209684;
	Tue,  3 Dec 2024 21:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="THG2c1gZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856741F8906
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Dec 2024 21:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262622; cv=none; b=ul1UXhG0bYzimJK5/zQAcEFL59VZ4v2AEjD35UV07gZW1RBlC82kpiswP8OIRq5/A5UYbu5H/WobOSz+C6aG9CpgatRRcMTgQ7LeLHbe1ytG+54sszwT7b3m/9tctA6S1rfShIxcI3/5bxah+vhTcB9SDZIfm3tI2Qj2nN5q43M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262622; c=relaxed/simple;
	bh=ECPBHbiegD8JbXydWk2OBAJymkl00PiX260yQZspDVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j2VneoJBsrF+zkwxY3mIikckhpU05JuAHStqSHYmGNR8nxqc/utrTUSKOZiN54U/eS2iwHujBPO/OQ4Z6gpdbOv9p0tU5jZTikDLiBCXqIhKivT6D+gLyTverLKg2sX19xWilWEooD/BguN0PH4qUparnH7CY70i+rYRIPSf0JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=THG2c1gZ; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a7de25942bso15315855ab.2
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Dec 2024 13:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733262618; x=1733867418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zhF1TSIpiDnDO1ss7QPfLqqIBrxMtPOq9kWp98JCdA8=;
        b=THG2c1gZtrh7Nt4TfPcpCor1NDNBhsLiNPuNJYSwJ2+5jtk6Ucck9MZv/9+0SjHsFI
         cIHzxp2l7UtVCzH0JckIWCymc7Ywq4YhdCUcHAf+z+D9K2Di9kGx/9loIzfuf2T4+XoP
         PnUNF30xhKEL18/1hc/dsOMHSg0Yx2zc71fB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262618; x=1733867418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zhF1TSIpiDnDO1ss7QPfLqqIBrxMtPOq9kWp98JCdA8=;
        b=YGy4Nek60cOY9uHNVP2Z37Omb1nLjrBsHljsJsrGkd87EncFDE74ixMSFQD7xQpuz+
         Zo3YYSh4n1txL0/Xrdhdz/QZnB7RWOVPLdIy9yeJYCkCs7ni795D9WtLpshoUe3Ldmgx
         TE1wCJPESYD8f5e0KAj7Gt8jooj9FjpoxV0exEn1tok4AidL3DoFMNs2BWJnpFuJ9kD7
         6noEn/6h0xWOq9/zTd9sKgt4BC6Mygm/gJEV/onVgu8hNjOGqwxqTYsgXZIKElY5cLbo
         BV3NRA/6EVlOlQxRxl3/7j1DL2PeBnwt0Y5VtVh8wMpRQmjN/zNb0Qmtdd4WQXMPrgD1
         7Z+g==
X-Gm-Message-State: AOJu0YzcWF9BbAcI/+3iWoEznlwX4sHIE4qcl2cZWHVbNvTq0loK41FK
	pfkixbD5jZn1U3peppwEX3RNuAgZEF2K9GO8a9TgXeCQ4WTATHBY+QbHkJTIuEFvKb97WIp9N6j
	w
X-Gm-Gg: ASbGnct5k6+YNKnqhb+xq/lRG/udCfuE115B0hmvyAK8ZF6bAJnELJOzqOXfVqA+kAl
	gwktE7GFgVTRnwzWLnOUHW6+Ii2TuGHqO09DOioLZMRsQ3ZRgPvz30Jw+EkY7oKiNABmSMZAPFn
	5uOoqEHNOYTtNuhFZERbX9qrA+AeTNsSoJxoE4unMmqVwW3u5U70SRZwk+hcOT4sl1FYYrhB555
	Nkj5XuikRIj66+HmlMVwkMqprWln4SK/CL/0Eerop5/RuNz9nuJGPrcgfb1WA==
X-Google-Smtp-Source: AGHT+IE4KQboi9ErKWinbYCH6Z/vNSaAcEIyRgGgfhFgXJKVUu3tOxpqb4sddr38iHqq+kfIPDfBZQ==
X-Received: by 2002:a05:6e02:178d:b0:3a7:7124:bd2c with SMTP id e9e14a558f8ab-3a7f9a97fc8mr49953145ab.19.1733262618667;
        Tue, 03 Dec 2024 13:50:18 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e230e908b4sm2688367173.158.2024.12.03.13.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 13:50:18 -0800 (PST)
Message-ID: <35238cbe-7f4e-4486-915e-ab13ca0120de@linuxfoundation.org>
Date: Tue, 3 Dec 2024 14:50:17 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] kselftest: tmpfs: Add ksft macros and skip if no
 root
To: Shivam Chaudhary <cvam0000@gmail.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241112143056.565122-1-cvam0000@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241112143056.565122-1-cvam0000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/24 07:30, Shivam Chaudhary wrote:
> This version 5 patch series replace direct error handling methods with ksft
> macros, which provide better reporting.Currently, when the tmpfs test runs,
> it does not display any output if it passes,and if it fails
> (particularly when not run as root),it simply exits without any warning or
> message.
> 
> This series of patch adds:
> 
> 1. Add 'ksft_print_header()' and 'ksft_set_plan()'
>     to structure test outputs more effectively.
> 
> 2. Error if not run as root.

This should be a skip - not a fail.

> 
> 3. Replace direct error handling with 'ksft_test_result_*',
>     'ksft_exit_fail_msg' macros for better reporting.


> 
> v4->v5:
>           - Remove unnecessary pass messages.
>           - Remove unnecessary use of KSFT_SKIP.
>           - Add appropriate use of ksft_exit_fail_msg.
> 
> v4 1/2: https://lore.kernel.org/all/20241105202639.1977356-2-cvam0000@gmail.com/
> v4 2/2: https://lore.kernel.org/all/20241105202639.1977356-3-cvam0000@gmail.com/
> 
> v3->v4:
>           - Start a patchset
>           - Split patch into smaller patches to make it easy to review.
>    Patch1 Replace  'ksft_test_result_skip' with 'KSFT_SKIP' during root run check.
>    Patch2 Replace  'ksft_test_result_fail' with 'KSFT_SKIP' where fail does not make sense,
>           or failure could be due to not unsupported APIs with appropriate warnings.
> 
> 
> v3: https://lore.kernel.org/all/20241028185756.111832-1-cvam0000@gmail.com/
> 
> v2->v3:
>          - Remove extra ksft_set_plan()
>          - Remove function for unshare()
>          - Fix the comment style
> v2: https://lore.kernel.org/all/20241026191621.2860376-1-cvam0000@gmail.com/
> 
> v1->v2:
>          - Make the commit message more clear.
> v1: https://lore.kernel.org/all/20241024200228.1075840-1-cvam0000@gmail.com/T/#u
> 
> 
> thanks
> Shivam
> 
> Shivam Chaudhary (2):
>    selftests: tmpfs: Add Test-fail if not run as root
>    selftests: tmpfs: Add kselftest support to tmpfs
> 
>   .../selftests/tmpfs/bug-link-o-tmpfile.c      | 60 ++++++++++++-------
>   1 file changed, 37 insertions(+), 23 deletions(-)
> 

thanks,
-- Shuah

