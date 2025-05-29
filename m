Return-Path: <linux-kselftest+bounces-33991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC42CAC7C5B
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 13:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DACA43B9B7D
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 11:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEED52882A5;
	Thu, 29 May 2025 11:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bT4PDFxS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5471B20E6E3;
	Thu, 29 May 2025 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748516664; cv=none; b=uMjPcPo2EloMIXpDg3blLNcx3coZ5AJrCznnCxEAjWf/OyaNDZKHWI3r3UAFVlC3NwXEQVl775FYdRfxojLMJYDkWyjF5Csj8LOZBxSF0411C5LpUyP0ImBeEq3rJHszguCoSSmOx0aEKW9hYsZZQASkA0nx7ODvPBRbjjLxwT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748516664; c=relaxed/simple;
	bh=bjFdJf+Dm1UZ3P8YltWnNwfPAQJXnYFs0CGmDjW+6gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rMvp+qcPDUgTNS/094+akJup6pWoOUT1f4LEqsk8YsBchB7Q+ArCKxkXfMV76Yn/hS+XUffIIXMj4g6tnEetZRf8LoH7P8V9br2sDsN3ckjMtK+Cun3XwDMNWep2a0EGzR8e/aydwc2tg2ofvjQ4Ivvbt3mqMFHLOjDTyHCrbXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bT4PDFxS; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74264d1832eso717091b3a.0;
        Thu, 29 May 2025 04:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748516662; x=1749121462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=elb0IQnO73maUG0NJbzoI/IOVIfGmzvtWXJxilsL9mo=;
        b=bT4PDFxSfvmgLjkax8HlZpNGFRpXvuXbiHB4brlQ/s0/cILmS+My+pcUm17A5Lo/Uz
         yCmaQqe+05VHFUkdLx4rP4SDBMgawtLQhkNXQgUAZm0VGdGydWYiMoNOb3HQhFVzxbGX
         cwxNrafds7eHeKtT3zcQXFmRMZI5URVHpKigPvoTMjtant5d5v/1cO7mM4C0bK7DDzXi
         yIGIa2780WJzbtz3nyaxqepERLpRq4Hl7l/cihqlLmdnHMkjTTySEQLWUMlKuGRWHfDh
         D+DlZXPXLa+/ZXHRdz4EAx3Z8RccVDAkOWJE4LCB8JHh48MA8thrTnE5zBpT130xAYpj
         SOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748516662; x=1749121462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=elb0IQnO73maUG0NJbzoI/IOVIfGmzvtWXJxilsL9mo=;
        b=jKtnVl0OGaSKguIopFcsdOPst1VUjE5plURlL14KsJ820NtqmOu+9f0IGvbd1emXDq
         MBR8vENCgdVcVkyNGapxYCTs1YHRBZd1bFPzbbJOfle3S2R5T0fgQcgiAYG6Ts+krW/2
         Mfdmm7hD/gTOiOdB/RyCGd8MhP1B4jIPGc+S4MRHD0PdOIDqN3skJRV87cHxqPZjJwBC
         sOztgsh1ZBs8QWjQrAEJcwjfjXlSMgujcNo66Lby8KDALF334d0Iw2Fqg8qQhJeBVObs
         Q6lcLWvgexEVIiYEsH7Rh6MurOGczLoQIxcAbdj1tMqjlOZ6FpvPQBfCdlDMqQyi2jLi
         sFcA==
X-Forwarded-Encrypted: i=1; AJvYcCVOwjXxKw0Tt4z6QzdTG0haL1QNuHKCot9btggVc2GP+KVf1yQwWMxQoBaAIHtqB3KsEMuWLYhb4UR1Mfc=@vger.kernel.org, AJvYcCXkX8Se80XbVneWKXCK7mj1cAsyfQ+/qChwGQS+8NoojgJkOZUXe6TVVg1DxXxVKGi+jq0YMfDhwvyP+TlB8jJ6@vger.kernel.org
X-Gm-Message-State: AOJu0YwCayYqIfIQRl0m4Xvli86UjgmxUu1JiaoM/MrfwrvWYxcfk6LL
	4pZsbcEsBFBNtOlSp8FFP1sJdvn1ZB/QPQZAWD9Dr1OzxAuIGaU1BgF8
X-Gm-Gg: ASbGncthwXx2fhalPIgfb/Q3IzMRX34RA9oOsAgO+6Aimur99+XKtx3rTE4Z9azkSOs
	WS2b6nGqBDrrdGqnOojqP2iq9wWRFlmRHtQ5LCl+S+Q1m+GIB+CV4lD3+UlxTGBE+E6rUZAGDb4
	AsLvMDior48m2toj9grPooK1KmTADYDteOk3v7vc+vMXAusKq1czhFx2mV9HvGyjV8XSOrIpwSt
	kpXbMK1pV11G2Rh5B/Ni4cuu2M+y+u0Q5Ic2B8FJIMAFZqLudW554ROgGeFhWcOwrVPSACzs7p+
	r8T0e1lI0H/Cy0WyfkPetyV2Yh9oL4B9fUVYMQ01mkWLgNbyShG1D7DbJHGOYIXnVcLMn31CeXt
	VOWuT0LmY+fGylYvLASazzmjTbTYpDf8zAp4j8M31
X-Google-Smtp-Source: AGHT+IH5zfeo/HBOiXWizEuXHO3WU2MEzyWgONfZvWvMMvUVOiVgGFx3iOqK4PF3pd4B0YjP702rFQ==
X-Received: by 2002:a05:6a00:1381:b0:740:9d7c:8f5c with SMTP id d2e1a72fcca58-745fe036213mr33229676b3a.18.1748516662427;
        Thu, 29 May 2025 04:04:22 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:d434:b1b6:e451:f5d9? ([2001:ee0:4f0e:fb30:d434:b1b6:e451:f5d9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affafb44sm1113913b3a.107.2025.05.29.04.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 04:04:21 -0700 (PDT)
Message-ID: <da0339d6-b6a3-44d8-8ed4-b99249fa0fd1@gmail.com>
Date: Thu, 29 May 2025 18:04:17 +0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: net: build net/lib dependency in all
 target
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Philip Li <philip.li@intel.com>, oliver.sang@intel.com,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250529070536.84491-1-minhquangbui99@gmail.com>
 <20250529103221.GN1484967@horms.kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20250529103221.GN1484967@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/29/25 17:32, Simon Horman wrote:
> On Thu, May 29, 2025 at 02:05:36PM +0700, Bui Quang Minh wrote:
>> Currently, we only build net/lib dependency in install target. This
>> commit moves that to all target so that net/lib is included in in-tree
>> build and run_tests.
> Hi,
>
> The above describes what is being done.
> I think it would be good to also describe why.

Hi,

Currently, when building net related selftests, we need to

     make install

so that the net/lib is compiled. In case we do

     make

or

     make run_tests

the net/lib is not compiled. So I move the INSTALL_DEP_TARGETS which is 
net/lib if the selftests is net related to all. As a result, all 
make/make install/make run_tests will have the net/lib compiled.

Thanks,
Quang Minh.

