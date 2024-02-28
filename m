Return-Path: <linux-kselftest+bounces-5558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B38586BABE
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 23:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC5ACB220DC
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 22:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038811361DF;
	Wed, 28 Feb 2024 22:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fFeEN9sg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8451361D6
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 22:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709159297; cv=none; b=jUzrxzASBlaaOQXut9CNju2E3iTnjTjQS8u8hD2P12lPxSeQcxAD2bM57KtbqUazrI8L9ZQurhEmj1WacQGWJaHTefTqI2owvKEThnBGyjp3Z7RyAYJgUwEMJ03SkgIxihkGxwk9v/lYBAtHkPlONyt+OvcIbXINJd8xSw2XTXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709159297; c=relaxed/simple;
	bh=m6A/EWeJIpp9RbJhxMwKTl8gxBs54HbkbZM1T+WLk1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=KucBEYhKYoYe9j6fDCz2cFKPzIpb+bORD2dXzJg0Dk367wKLi33sUjXKzuA3oocucQ7mP725c7jk30cuRiigrT3p7/10NZjn67uNv/kb7QhpT2IpFaoC//7ZHsEQx2rw5aBNDkK/wAdWiyCB7UD4V4gglAxzY4h5L5WL05EDFCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fFeEN9sg; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7bff8f21b74so3843339f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 14:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709159295; x=1709764095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LyZw8R4+HdFZm9vvl5s1fhgDJC1wyCJeRG7gkvvVYrA=;
        b=fFeEN9sgFiVFi4rykJQPd/rLNn+EZAvi9QO9uqdCpLDNHR15g6BBlxjDwNNZlDmYBv
         ynMqag8GhwV4oKJqdCEK1XPyQJ2ie1WDLBQ4F1AtzQMbNriyc+Rqz34OOFgSM5ha414I
         4QDrEoiCpkRUPf6TednbJ70Gqiz8CFULEcjBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709159295; x=1709764095;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LyZw8R4+HdFZm9vvl5s1fhgDJC1wyCJeRG7gkvvVYrA=;
        b=Cvs7Um3K8Yw9ek1MTlORzpIrKSITkYtN5Qv8stzZJivgAqvgDIA1vLHv97cKkwoaEa
         1HBgJIjOvYCDSqZ3rvryUZA4v2IvV0KpfOvlqk4ILPwWGJfNF0xCLCHGaucAlTdl35kH
         5uGfzYXGqFua20V+5rL99CBeYPD6eTeaOievCXuLX1U7kJfSxmOuK0/bQkzZ5kIL649P
         4dkpQFJMb3T15/MZVNcxJXua7BgVlDeWxWaTW7a2ILP/6A4QEmUp7fM1N4nOG0spItfX
         Q0gKxWLszm8lOhs8Acr+fgnhLeOeYU84PbSnIfIBUQvi0piMsuujfR2RpiNeIlCkbaP4
         3dKw==
X-Forwarded-Encrypted: i=1; AJvYcCXe5lanNkX/miEYBsau76yKqzHIEdLZYLX1C+GHnnL+NL9VWjKlwNFi3p4mXpj55MdwCHa759IKFSN94qMM6kjaoe1okuLLv/I+0OWeAUi3
X-Gm-Message-State: AOJu0Yz/6kIuJvrF1V5Sw4Ve6uqLfIiLA5qrar3arE58d6PGUO5Wv1eT
	H5Dn+k39Chc6U1dh1S8DXC9ioJb6K9FPtb4kC/Di/oS/efQzaJXzVgKPjkBBnDc=
X-Google-Smtp-Source: AGHT+IHgAsH+7ZpjB5g8fwP1m+/yM2hNFZxNncVRWqfnq+zmj91xye6JQ4GWLTwE+kLOJZWSPylvaw==
X-Received: by 2002:a6b:3ed6:0:b0:7c7:99f8:289a with SMTP id l205-20020a6b3ed6000000b007c799f8289amr471448ioa.2.1709159295010;
        Wed, 28 Feb 2024 14:28:15 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id bg6-20020a0566383c4600b00474b381c5e4sm21467jab.47.2024.02.28.14.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 14:28:14 -0800 (PST)
Message-ID: <a304f03b-7b2d-4c6d-9c11-4f4b1cda589c@linuxfoundation.org>
Date: Wed, 28 Feb 2024 15:28:14 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kselftest/next kselftest-livepatch: 1 runs, 1 regressions
 (v6.8-rc1-56-g539cd3f4da3f)
Content-Language: en-US
To: "kernelci.org bot" <bot@kernelci.org>, kernelci-results@groups.io,
 linux-kselftest@vger.kernel.org, Marcos Paulo de Souza <mpdesouza@suse.com>
References: <65dedf13.630a0220.f8b2d.9280@mx.google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <65dedf13.630a0220.f8b2d.9280@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/28/24 00:21, kernelci.org bot wrote:
> kselftest/next kselftest-livepatch: 1 runs, 1 regressions (v6.8-rc1-56-g539cd3f4da3f)
> 
> Regressions Summary
> -------------------
> 
> platform        | arch | lab           | compiler | defconfig                    | regressions
> ----------------+------+---------------+----------+------------------------------+------------
> imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+kselftest | 1
> 
>    Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.8-rc1-56-g539cd3f4da3f/plan/kselftest-livepatch/
> 
>    Test:     kselftest-livepatch
>    Tree:     kselftest
>    Branch:   next
>    Describe: v6.8-rc1-56-g539cd3f4da3f
>    URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
>    SHA:      539cd3f4da3fdbe7dc353634e004e4b0e725c35a
> 
> 
> Test Regressions
> ----------------
> 
> 
> platform        | arch | lab           | compiler | defconfig                    | regressions
> ----------------+------+---------------+----------+------------------------------+------------
> imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+kselftest | 1
> 
>    Details:     https://kernelci.org/test/plan/id/65ded1d5c2aa34249963703c
> 
>    Results:     1 PASS, 1 FAIL, 0 SKIP
>    Full config: multi_v7_defconfig+kselftest
>    Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 20210110)
>    Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-56-g539cd3f4da3f/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-livepatch-imx6q-sabrelite.txt
>    HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-56-g539cd3f4da3f/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-livepatch-imx6q-sabrelite.html
>    Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-kselftest/20240129.0/armhf/initrd.cpio.gz
> 
> 
>    * kselftest-livepatch.shardfile-livepatch: https://kernelci.org/test/case/id/65ded1d5c2aa34249963703e
>          failing since 13 days (last pass: v6.8-rc1, first fail: v6.8-rc1-32-g345e8abe4c355)
> 
>      2024-02-28T06:26:05.757140  / #
> 
>      2024-02-28T06:26:05.767314
> 
>      2024-02-28T06:26:10.908349  / # export NFS_ROOTFS='/var/lib/lava/dispatcher/tmp/12885469/extract-nfsrootfs-c33w8jjk'
> 
>      2024-02-28T06:26:10.925782  export NFS_ROOTFS='/var/lib/lava/dispatcher/tmp/12885469/extract-nfsrootfs-c33w8jjk'
> 
>      2024-02-28T06:26:13.149970  / # export NFS_SERVER_IP='192.168.201.1'
> 
>      2024-02-28T06:26:13.161626  export NFS_SERVER_IP='192.168.201.1'
> 
>      2024-02-28T06:26:13.280972  / # #
> 
>      2024-02-28T06:26:13.289584  #
> 
>      2024-02-28T06:26:13.405920  / # export SHELL=/bin/bash
> 
>      2024-02-28T06:26:13.417269  export SHELL=/bin/bash
>   
>      ... (112 line(s) more)
>    

Hi Marco,

Please take a look at this regression. I applied your patch
series that fixed the problems found in o-day bot. Is this
a different problem?

thanks,
-- Shuah

