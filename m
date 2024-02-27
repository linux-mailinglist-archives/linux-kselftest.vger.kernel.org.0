Return-Path: <linux-kselftest+bounces-5489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF60869C8D
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 17:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBAB5285178
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 16:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9579220DD3;
	Tue, 27 Feb 2024 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dwoo1/r8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5081EB40
	for <linux-kselftest@vger.kernel.org>; Tue, 27 Feb 2024 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052088; cv=none; b=m6GdgoRKREDfENagRSErE8qKyKzqbi7jIx+ZDL/iqYnItv0G939LmcnfM/pmCn1Ou649dwkoeguf4nFRWN+lgJdmOUzyvPCLkaLriHphY8eP3fzpi3rQ+NYFF5yClt71OzHJGsyUb6pvY+Jm/3sqXoRFUp6ZddMKobbGK2s6TLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052088; c=relaxed/simple;
	bh=/drlaqNP34djKRMPww7Fy9vfeScYwuCh547zTKPR7TY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=noDv93tRp74tqowz+PR8NXzzU8VZT5iGg1uhsInwpzb1JnB8g1CCMtg+VAhgZzsp6g00kE8MLjEL2M/Ytiv3tLadK8CtoVyU2jSkI4PBangrh1rFmMoUqCwo+ZiMaRP08Zs+xDacYqck+zITtAIAFlvYg4os/tIk9qlHofppGO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dwoo1/r8; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e4857d93ebso1364541a34.0
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Feb 2024 08:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709052085; x=1709656885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cj7Czl12HamAEioeVvBO9DiukTU/zhT4MfnATWo179Y=;
        b=Dwoo1/r89EOVOjAjfR9mHhZe6H8WKo+0Q/0K0G3RiLg+xq46NCE4n4zzchXh9SPGiC
         mXwij9heY8JtqHbmPnWxFkRDKE5DnweKOeOcdpN6asYYzf3go+/nMo8WrxzFXBjYDK58
         AFtu/jT641TwLkRqCpiLAFEznG5RMXgu9WuJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709052085; x=1709656885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cj7Czl12HamAEioeVvBO9DiukTU/zhT4MfnATWo179Y=;
        b=pPcX4lLkv8Gw0+nGeUGw/5PyOtBKTbZvD45zRsqTXbyk9UEvSyXC0/XpthUYyqr+2c
         H8MOg9r+QsvA6eX8R9xkObI92csXV6NpkzfWRoKirL2BBGEMHDi6PeXP5YP0tQ/8B0K1
         HvVDxEVNi3wDEdXKx1O1nCcJmY2nNrRgVc/dg5xicfRHyGR/VT3CpTENL+8UeXJIPKIZ
         ng0cD2De5jqrJlNXsasL7VHklC+JO9XNEtkt0bZDmdLG6RwhfOtqlfmKRx0BJDTOaULA
         J+Wti7SfY4NBWGfl7RNqBXJrGz2/qsXsLXOLRfjR8dCZezAuGjmnIW8mNWgDS1QtTh29
         QJng==
X-Forwarded-Encrypted: i=1; AJvYcCXAgV751AAuoMOz3uT8RUPxoxob1ePoL4FFNV0PmHU10F18h49tBQu+xubX0wktPOMYKDL1f1PqC1iweFWIW0vKc4C1B9YtRujoz327XNAc
X-Gm-Message-State: AOJu0Yy3Gw07Wap1gaNZMZhwqGQr6umBrOCdAxwP24L/lNxrDo7aq7yq
	1lc+X9nV2+pXQEf0HOZoDd9w0EXPYmQDp3xxUFJ5xVsRzmDd2ZprDPraD8HTHNk=
X-Google-Smtp-Source: AGHT+IHbpcRP3SYOp6TthHDLPxhDxQntg2dWl5/P/9lzYYvGOMon4J/GdfdlbHWeBuNjMwcMVhHFVw==
X-Received: by 2002:a05:6820:2c8e:b0:5a0:4d78:975d with SMTP id dx14-20020a0568202c8e00b005a04d78975dmr9529006oob.1.1709052084818;
        Tue, 27 Feb 2024 08:41:24 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id v11-20020a056820004b00b005a0a8e661d3sm456853oob.42.2024.02.27.08.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 08:41:24 -0800 (PST)
Message-ID: <2aaa2a61-f753-4434-8c92-886fc4bb9aef@linuxfoundation.org>
Date: Tue, 27 Feb 2024 09:41:23 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] selftests/overlayfs: fix compilation error in
 overlayfs
Content-Language: en-US
To: Meng Li <li.meng@amd.com>, Andrei Vagin <avagin@google.com>,
 Huang Rui <ray.huang@amd.com>, linux-pm@vger.kernel.org
Cc: Nathan Fontenot <nathan.fontenot@amd.com>,
 Deepak Sharma <deepak.sharma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <Perry.Yuan@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Borislav Petkov <bp@alien8.de>,
 linux-kernel@vger.kernel.org,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20240227074204.3573450-1-li.meng@amd.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240227074204.3573450-1-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 00:42, Meng Li wrote:
> make -C tools/testing/selftests, compiling dev_in_maps fail.
> In file included from dev_in_maps.c:10:
> /usr/include/x86_64-linux-gnu/sys/mount.h:35:3: error: expected identifier before numeric constant
>     35 |   MS_RDONLY = 1,                /* Mount read-only.  */
>        |   ^~~~~~~~~
> 
> That sys/mount.h has to be included before linux/mount.h.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>   tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

I don't see this problem when I build it on my system when
I run:

make -C tools/testing/selftests
or
make -C tools/testing/selftests/filesystems/overlayfs

Are you running this after doing headers_install?

thanks,
-- Shuah






