Return-Path: <linux-kselftest+bounces-25099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D286A1B7F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 15:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29594167C54
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 14:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A2C13AD11;
	Fri, 24 Jan 2025 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwPZ3fUx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A2C13AD20;
	Fri, 24 Jan 2025 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737729349; cv=none; b=mr2hzL9rvzLlAERkjwdNRt6Pk1x6oCkl3JWFxtJyDhrbU9W2bYbpd7Uz1QpZInMr76xWByoh6XgXdqS5IaNkoszNIoGTRu0zzhNJsZeCfR54lzBZraHvQN9ib7o2mMrGq8DigazMiiL3a1CwEHWa1FCWGswybDJYtLWNAnR747Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737729349; c=relaxed/simple;
	bh=40PukyPfhep4n+kZqIPY/40E0T4dG3demxbsls4t/jM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AfeVNA2yUFLSU8BOd+F95L25FILlYDOLRwvTuzyeXjXIB6Nq8FLIVrcUz7YsziCj+Yc5p4HHHHn+nRpLeOwgYmOx7K8IyfH1ps8IpR3CS334kcUhE+P3h8vuyNwPQOKG2rUZRVtdpJHU9wNVnpUR7OxbJj6twH98GWb4uTKKxJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwPZ3fUx; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436281c8a38so15513365e9.3;
        Fri, 24 Jan 2025 06:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737729346; x=1738334146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b5rVEKKiK44ITxyzKVGWZwAXtaJ1Sw2ESc38CfsaFbs=;
        b=OwPZ3fUxaA+qA0maofhl+p4tr+JWwfIqSG6xc1hE8uMYFnyAgWaoeQvH5sCjcPhNBj
         6UUQ4itkRaMl4Ap76Eo/jyuXqy/JkSTNaz5R0bASlOb5EM07lDW0MUxJI/Ye3WACzU+c
         VjT3m7XjHjYjbNZIOPZdjHT52/JmYD+U/V90uEKwxkJ8inwMi6lsu0nrmg2glPT9HoR9
         OsARc1xVby6xVXeQWz+ggDHFot7N7rJEd3F60ZYaSz/kCQCEX7ZPYArH9NDtQ1OryzWz
         mxmXqgW0rrOaHnoxCQMGw2xatWOE1oo190H46WlBgKH6UMncbMO6sMX/y14I5rgeLmlg
         G+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737729346; x=1738334146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b5rVEKKiK44ITxyzKVGWZwAXtaJ1Sw2ESc38CfsaFbs=;
        b=VJrQvSUBmTmnrxrCKYKUEdmYBM1itZ08qAdQfAETUwZjvbVOu+K83rXhiS8X/Ub8hh
         MYxT5hRTe7QbPICrr5RiLuCAXrgMc7GizOD7tQyDHldvv6H+Be6tZVGG+lACDd5S+WTG
         CpbTmqaalb7e6t2OOztERfYrR3GNjCAq11M+peiLReubzdLmrARC2DQ+ZokXej1AkUxt
         wJPg3+MRdZtujqdIWq6Jb0RsBPVajMjLccCauwtqlHUDc3a+M1R50HNQYnc25CASFsEa
         RJpppngFP063B9h7/X01E6A+HIr+Mq2LQwLGBJt3PcZ1mgkHrHLDmFeZL9ZNqoeIFGRN
         v+tA==
X-Forwarded-Encrypted: i=1; AJvYcCU7q6c2hAxky7IKxNxL6GwLbmr9sN2XCYpFX6A61BNirATwLepXMiqPZRVEaeiI6GB/VyTVhwujVIU1VpnTmuQ=@vger.kernel.org, AJvYcCVRlbL0nHKL2h9PQzw7Q08mc1cNfO2btwZGQuUEO33vdPkAV3naig1u0ELbQs6VlzskS5sKsYWI9uyDzkmwaUsc@vger.kernel.org, AJvYcCXDBnCA00KibTj9Zu+Yh1bJFYFIZSUAd+WkuahIr52AUoBCCZo9j4vINpf3nAuRK/fdbt5rHul6SYaUbJ72@vger.kernel.org
X-Gm-Message-State: AOJu0YzIO8gV/P2W798UGAfV64kLHkEhzIvBL1J26uqaMXhcRG0u44K6
	/N11fEvVjSSQ83wot4o6v626FVYJnQsUJsPf/UwAKVZxWwsQDHbB
X-Gm-Gg: ASbGncssOm4XajEm6igOP26Uftmj90YGdp8i3f/uKG4gFD9qFv4o9qLx6HV1/3BsDfT
	RlsttB9P8o13a0IcHAzX8RDcDmFiuKzgXamtPdIgdyl+2bdsoXaqtUgx2byvs/rhhl/NNIznmN2
	k5CmqQLeSw7nCF0iB2BG2ZGr10lpSY4WWBMY7mKGwi3mPnchnE8jdQ+kF/hTV0sURDxJjme+bgh
	YAJh23fI0CwLphlUYmJWKTxlyL7Skmo+Pk83LudnRyKaNarZ1JEZd1skP+8yQFxyx+s3iYBOMfM
	3oht+GnYTOajq/LI7Q1CjRKAK5YsWtq/
X-Google-Smtp-Source: AGHT+IFY3RKBRogyV0Z88W0dqHnNRmu41djNwwWhRDYwqecfTkmbtxi4XgbU4lZqIOwwKLoE7Mxa8w==
X-Received: by 2002:a05:600c:5112:b0:434:a5bc:70fc with SMTP id 5b1f17b1804b1-438913cfa0emr277742865e9.8.1737729346091;
        Fri, 24 Jan 2025 06:35:46 -0800 (PST)
Received: from [192.168.1.14] ([197.63.236.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4d34e3sm28434765e9.39.2025.01.24.06.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 06:35:45 -0800 (PST)
Message-ID: <d7c0995d-5159-47a8-9193-d9d29fdfeea0@gmail.com>
Date: Fri, 24 Jan 2025 16:35:43 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: tpm2: create a dedicated .gitignore
To: Jarkko Sakkinen <jarkko@kernel.org>, peterhuewe@gmx.de, jgg@ziepe.ca,
 shuah@kernel.org
Cc: linux-kernel-mentees@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250122065021.91814-1-khaledelnaggarlinux@gmail.com>
 <D79CVJJBY9KX.23K6C7S5BU8AV@kernel.org>
Content-Language: en-US
From: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
In-Reply-To: <D79CVJJBY9KX.23K6C7S5BU8AV@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/25 11:47 AM, Jarkko Sakkinen wrote: 
> Why?

Sorry I should have included v1 in the thread but I am still
new to the LKML process.

Basically tpm2 selftests have 2 leftover log files after running
(namely AsyncTest.log and SpaceTest.log). Only SpaceTest.log
is in selftests/.gitignore while AsyncTest.log appears untracked
with git status.

To solve this, one could either append AsyncTest.log to 
selftests/.gitignore or create a dedicated .gitignore for 
the tpm2 subsystem tests. The 2nd approach is better in order
to not clutter selftests/.gitignore and keep tpm2 isolated.

Shuah actually suggested the 2nd approach in reply to v1.

Would you like me to resubmit this patch with a clearer message?
Or include v1 in the thread?

Thanks
Khaled

