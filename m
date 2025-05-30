Return-Path: <linux-kselftest+bounces-34074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB7DAC944A
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 19:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A55150538B
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 17:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09803236A73;
	Fri, 30 May 2025 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fqpf5xuy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B332367C2
	for <linux-kselftest@vger.kernel.org>; Fri, 30 May 2025 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748624401; cv=none; b=ngg5BrjeubrOMuK0uLAIcGOhcQYLuehGELaCGQ5qdFYhXctcSC/o6O/5rMnWvxxjZ5BBQU5imgkRG86D5Zmw0PWC4rTEJ6jX4AzjiBFRK3B8QpVNCT1HvxqSr8ngo0P0tvhOqF/IKtuMBVBtn5WT85ZGfsB6W86/OJgati1zLh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748624401; c=relaxed/simple;
	bh=axRDZgvY2GgwmyIwDUVk2F5YlPTdQTs7CTN9EuKnbtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gOa2c7i1cJHv43+h/3AApYxJgo3guY0k2noU51+xRn9P+1URZo0B5fCktBJR2XR4hbts83B2k8l1aEB8BzRCOA9L/xY85Bs3Qy6oTQrkcduSmkyNr0hyefw5LYP2NCgrwgpdq7OOkCIHP4tOrFw3V6KsaRlAm1zZzlYaKOPNts8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fqpf5xuy; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3dca299003cso19405015ab.3
        for <linux-kselftest@vger.kernel.org>; Fri, 30 May 2025 09:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748624397; x=1749229197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xJ5Qzrxnd8/9rJ2f2dpkzgJuqVyXVOpeZBzrV+6d9Q4=;
        b=fqpf5xuyyE+6igPJF0jtZ4/GCvkhjEsiQxe0tsO0I7D5QCBTRCmTglV7a4xImch0c9
         nS4vsaAFDFTZDRmztCMI6eZ+w+SSiUEcHRDnFWWBaj+d1LD7KAXMoWFA2waPeW7DMJFP
         GNlIMfo1E+qfvqoIZ+5g0Qqx21UJTGIGJqxnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748624397; x=1749229197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJ5Qzrxnd8/9rJ2f2dpkzgJuqVyXVOpeZBzrV+6d9Q4=;
        b=QzeA6UjtLK7Xk834Jg3kqYmq+vWumUaDt1rJM3IfBcokZznNqV+0p63FxLHh06FnVQ
         Eby5+bqqMYoalkWyvh6On7TLf+E8KbFPmql+ZOAEptoCELk0tWJtAdG5W/nvf55ewSpr
         uuw8ImCx4iZlOPilUB2LrT0lyks6sc2FmQtujlWw52QMr+8eIVwGf6jymFhZXZhFQGNN
         M9cQYrJCkuLKTFbPtcfbvD48Q+are8KaESvtYQhh3b1mQx7oVJwp30Asl/OWDDjVXFkC
         LP7UcpnzwCAOdkVumq+QcD5zsW/sTkob3eFfmmV0l7+xsI9XnUiIIyDBzZgIH81SoT6X
         6iMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA6Wu2EHgsGzUPD81wYXwxXL33VJutga788hQcul/6KL1ddmuMCTOLa0M44zzIn5sawSl/354iyu6I60ZuDHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWVf+jGOiaM4QMwprFlG+TNr5mfSyo8nMTJemjiNmm74WtOns1
	fCn2ZzUjonLfBHs/zHOy6sNKHamFu7hMxygeUXfbtj7u7+36uC1FKGZhFwd9hmKVslc=
X-Gm-Gg: ASbGncur+OEt8Fkf1g6ysBf4yP12V+0EOCc67urGMcJPBapmL5/tY0FH1IMBR+hJyg8
	/e4kxgxBHGA1dYOnK9809WgBQmwomb1urIc+rB8XadUrHnqAClgFo8JrD/RK4pNMyJGbUzaTobn
	tHWG/bQaDjPXufGZ4J9xnC0gOQlCux7HWleSsG8nphIwUM6YBUcZF/K2vorarIeejLUlyCsp2OX
	DgH4r6JBXGLcUVFcW+J6jyHvsORLgg0PENufJ2xAiDV3LgAniZkwg+bvM8w/SGuJUGJ5s4AFpKg
	zbvqNnOnrNcaLwpyOov2Eu88dR5sGymHuypf6cnDIHK8trT+zMag2B8WGZl9vg==
X-Google-Smtp-Source: AGHT+IHsGPRkTkGv7aXnmE6lJ9pON+LbbaKMmDiii9f2uif9iEVehs1Q/fSiIa2h5IJJmslXDoy9+w==
X-Received: by 2002:a05:6e02:144b:b0:3da:7cb7:79c with SMTP id e9e14a558f8ab-3dd99bed1bamr42223305ab.13.1748624396833;
        Fri, 30 May 2025 09:59:56 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fdd7e280acsm538551173.43.2025.05.30.09.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 09:59:56 -0700 (PDT)
Message-ID: <9628c61e-234f-45af-bc30-ab6db90f09c6@linuxfoundation.org>
Date: Fri, 30 May 2025 10:59:54 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Revert "kunit: configs: Enable
 CONFIG_INIT_STACK_ALL_PATTERN in all_tests"
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, brendan.higgins@linux.dev, davidgow@google.com,
 rmoar@google.com, broonie@kernel.org, rf@opensource.cirrus.com,
 mic@digikod.net, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20250530135800.13437-1-kuba@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250530135800.13437-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/30/25 07:58, Jakub Kicinski wrote:
> This reverts commit a571a9a1b120264e24b41eddf1ac5140131bfa84.
> 
> The commit in question breaks kunit for older compilers:
> > $ gcc --version
>   gcc (GCC) 11.5.0 20240719 (Red Hat 11.5.0-5)
> 
> $ ./tools/testing/kunit/kunit.py run  --alltests --json --arch=x86_64
>   Configuring KUnit Kernel ...
>   Regenerating .config ...
>   Populating config with:
>   $ make ARCH=x86_64 O=.kunit olddefconfig


>   ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
>   This is probably due to unsatisfied dependencies.
>   Missing: CONFIG_INIT_STACK_ALL_PATTERN=y

Does adding config option work for you?
./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_INIT_STACK_ALL_PATTERN


> 
> Link: https://lore.kernel.org/20250529083811.778bc31b@kernel.org
> Fixes: a571a9a1b120 ("kunit: configs: Enable CONFIG_INIT_STACK_ALL_PATTERN in all_tests")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> I'd like to take this in via netdev since it fixes our CI.
> We'll send it to Linus next week.
> 

I am good with reverting it for now.

David, Brendan,
We will have to enable this at a later time. Also we saw this problem
before with other configs. Anyway way to fix this for alltests case?

thanks,
-- Shuah



