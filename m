Return-Path: <linux-kselftest+bounces-43765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87727BFCE4A
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 17:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B4744F1846
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 15:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB043431F5;
	Wed, 22 Oct 2025 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qzi2YjJf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E070334DB60
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146889; cv=none; b=HXaYT9ZzwJHC3/5X/lkJ+bwmJfdny3JgwCU0nGf/1HYhcT3H1m1Jnlt0PboA+FmSgJxWReCkFRHKt9GUj1xbyVF2nP66oPPqUVWtuNic6Cs2jVt6RerDjk4jbPj92YFOyM/wW3tyQMKFzFqujKSNXtKIHziJdLcT2cWYjDAY/3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146889; c=relaxed/simple;
	bh=EI9+X88n4io6JI5x6JGStAPF9hZmzDq+AZMPDkKogZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mG4Mco+STOnl0XWKjJ6ThkMocaHeWz+C3XY0LvDFk93T7mFbNg0BZAANr7NgmIsLc2LgXS0PjOC1rXvUum6UW7O175kVXMWvwLMqutlo0oLpOCeZEpAvOxMm3lJUaTsuyGqP25GEKw1aV8j7KJ24uFd1iSuhqVzjuDNckN7k4X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qzi2YjJf; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-430c151ca28so27656295ab.2
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 08:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761146885; x=1761751685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UCyGNn9DqYHAJPTYEfOdDyskGHQO9IZaMQjWReSYYrU=;
        b=Qzi2YjJfCauUDDuPyGgc3Y63USylEs88+PtkMYWZ8lSbFlSwgKCBsWmf8izE/zAmaH
         zMqhVE7l3TN0x049wFFVnTDDPFxesNUXJPeEQtpB9w41age4htODr1IREIA0Y4PHifR3
         e9pcprKbu+BrSlg/cwz33hh0HbCxDn1y6jWpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761146885; x=1761751685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UCyGNn9DqYHAJPTYEfOdDyskGHQO9IZaMQjWReSYYrU=;
        b=m53uNxa/vi2HqxNB9xoEMZCuVsC+fY+wGY3Ba1JHfn4SV6MS+a2pBdd9IVwRFo+C+f
         H/SPr0ARz7mTFZe0TR9s3NKi9v+vliXkoQgxBbO8SrLjatLtUVHbslCcjrZ8D4odnllm
         x01SAKBoQOmD8dg0yrTOkqvNKqWip3wvX81YmQ1Gn2dM4bn9Cu5IyzPNN7N2GZM/aQyZ
         Rv+3+9vP/J8CeiXlKaO6wavBOwY0DWF16k0S/hwptsdIbZ8h4hZcBEOg+D9/L4a6kGHN
         qnfT2IV+0nmhPd6X2wLSp+8PiFq4udCI/hkFrzbN0umki8moFwUdadayqLNYskPDQQ3E
         4u3Q==
X-Gm-Message-State: AOJu0YwF48LJw2AwtOQ6OX7KvvdNGC23O+7PRVJnsQMFLSZ2E0xz81Mb
	gXZHungHn8fHDv+dzREZ7pD6UovAELjpO7DLDcsK3/mufbmbPAEq/j8xZTqZMHpQXE0=
X-Gm-Gg: ASbGncsm6tcr96ULaNH3iP4H4H4vqLmiEO/TosPySgvhrE1ZU8u7SZJndyzSVJfSj9T
	58QnEHLLvsjNf6hYgPrt7zf5CXXj2rHxF2NGNYG8DXicCl8+yKgLPu1HAjcxnJm+uaRRg/nPZ6W
	1utXIoC5oqop0LdKvMpx+iMppq8QVRi/VU2Zbz5aPOmAJbaVPKPGWSkedMPVLcI8MK7fcltQEvB
	6Kessth8TAfgJ35LmEdDUA6GQFsMfK+dpQjCVmDn6Mm062YGqRtxxgO+o06mmloq+AUy/dfnQvu
	JSpSdJ1EmLScL0/lKhBDBqFZ8H5Ng+ctt6PZw9z1x7kv+MJKCSYudzH8hg3e+XjEh0iHjYoNmX6
	YWKkwFc74nozsmlIL13/mijkAa41f2yKS5ht7MLHXQOrAJM09JczZBeAicYFwk4ErMcQm8oOI+n
	3w9vtLElXKn4tztPst5SQyC94=
X-Google-Smtp-Source: AGHT+IH0tUAY1DZnnn4LLpJ2tMQ7048bBL0pCZcMZSbVpsE+cqMSObTeG3mKxAlP47l/VeOFctL1aA==
X-Received: by 2002:a92:cd82:0:b0:426:39a:90f1 with SMTP id e9e14a558f8ab-430c527dc54mr290786465ab.18.1761146884652;
        Wed, 22 Oct 2025 08:28:04 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a961da08sm5303034173.16.2025.10.22.08.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:28:04 -0700 (PDT)
Message-ID: <d18f46d8-9f42-46a0-b5bb-4f1d16c868cb@linuxfoundation.org>
Date: Wed, 22 Oct 2025 09:28:03 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] selftests/cachestat: add tmpshmcstat file to
 .gitignore
To: Madhur Kumar <madhurkumar004@gmail.com>, nphamcs@gmail.com,
 hannes@cmpxchg.org, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251013095149.1386628-1-madhurkumar004@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251013095149.1386628-1-madhurkumar004@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 03:51, Madhur Kumar wrote:
> Add the tmpshmcstat file to .gitignore to avoid
> accidentally staging the build artifact
> 
> Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
> ---
>   tools/testing/selftests/cachestat/.gitignore | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/cachestat/.gitignore b/tools/testing/selftests/cachestat/.gitignore
> index d6c30b43a4bb..abbb13b6e96b 100644
> --- a/tools/testing/selftests/cachestat/.gitignore
> +++ b/tools/testing/selftests/cachestat/.gitignore
> @@ -1,2 +1,3 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   test_cachestat
> +tmpshmcstat

Applied to linux-ksefltest fixes branch for next rc.

thanks,
-- Shuah

