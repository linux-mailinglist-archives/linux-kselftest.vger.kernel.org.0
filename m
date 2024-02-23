Return-Path: <linux-kselftest+bounces-5383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C872B861F42
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 22:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46716B2287F
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 21:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BA51493B1;
	Fri, 23 Feb 2024 21:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D4d2EVXs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB888143C63
	for <linux-kselftest@vger.kernel.org>; Fri, 23 Feb 2024 21:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708724929; cv=none; b=BjZm8TMG+sjqRlZ4dhpEvKo8nyqxUZy/XS97Dc9pl8HQu+E5l60lmnKoZ/s10Hih7T9cUKTpotsPwt4WgEuvld1XcPVgZKYURGQrviTS1MbhhYMTNbQvv7EJ2TD37crVRnAR1vWHiPnHaAMhiy8ZpG3XIanVEkfU3fvL4oSNbYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708724929; c=relaxed/simple;
	bh=+R0lx7cXpWz3DPUbwrtZFVFbpiqFznCCdo8QxAaxkcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y8etWCb7CBT7U/iND7w7fidqBbbZ7vNp5yPd3nwk99uQHthGbYz9OH4E+m2K0SstS9ylspk3ym4ye3cA0KYUJ9KSADSuiLulzHXWVXvJrPv+Ky4KMTPej+JlGyz3eUHv4G32WneiLeqpZ0uNlvYpcIglXyAjdqgQH9lD7ozdnmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D4d2EVXs; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7bff8f21b74so11794939f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Feb 2024 13:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708724926; x=1709329726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lgO5+cJdjb0UoRYq8Dm6ib2PgTItfB8pOU+uEe02TMk=;
        b=D4d2EVXsRpuAGnFgu2mdaPbTZ8YlvGxDW3c54oTzujqRnkz/Wob/CDKPwzApv0jzV5
         m7xrKLeqaXa+Wefs9FuByFYh1lh1NsfaO94/dNq9TCBAg+6CSH3n1MiuXhNfoJJJ7wyO
         InG+62Wnj+/N+zaeBxqKf+wuw0Wt61Yj8whpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708724926; x=1709329726;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lgO5+cJdjb0UoRYq8Dm6ib2PgTItfB8pOU+uEe02TMk=;
        b=O7rj5qD9Rwpw9jJ0mb5K27fB0RCflYJwNlb5EpUlHao02CVJtiIzeE7JRK9M6CrW+t
         81W3qdn5pMC1gItQFQkj2pihMhOAAmK0h8dqJf07ZtW4FlDc9ieWGSwqhlDP6dVUFfK6
         bZb7lYgH802fs+53K68Q1pRHa/wh2NjN+ZrU4IffZ4DT23yWuIT9IWRloOGuQoF5s058
         GUNbFvgFDyNcUdsiEM6XseFoMbvsgQ69UgZvTbUoeCyk1cenQS2jjOaXar6SpU1ZXYgd
         UFo/Plmxjq3gqYtpwUF8SGzMuacK81yq6z2nlgOIrfid2TXo2CuX5lOJEXqePa9Tk95N
         1mCA==
X-Forwarded-Encrypted: i=1; AJvYcCUOFlyxtlTd4nJK9MlVThNrMdD+OaEAyC7OwSkOYIcPlJNSQ3b0XdycwVz6g8oNnLifxF6qTjkDNI2xRo5AxsgSMAMOY7RQ8IH/uFbr1EBN
X-Gm-Message-State: AOJu0Yxm5HdXZNYCbo+GccqvJDRwbvgOwKucvl59semMqo4BtKs3j6Oi
	OSdlYo9H2QN2u2OTgllKVI4luuTriAV0QpHlGKp/9EEU7ZYdtMtA5iyJnVCPGZQ=
X-Google-Smtp-Source: AGHT+IHn1LVW7rSzOBvud0IxNkrh5t1iJwM5tNw5xrwCNXE5KoZyAbguXmzSWX/cJz63abGxQJllTw==
X-Received: by 2002:a05:6e02:1c43:b0:365:25a2:1896 with SMTP id d3-20020a056e021c4300b0036525a21896mr1323164ilg.0.1708724926076;
        Fri, 23 Feb 2024 13:48:46 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id z7-20020a92cec7000000b00364b66eb5e3sm4840053ilq.24.2024.02.23.13.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 13:48:45 -0800 (PST)
Message-ID: <bb4c94f5-082d-48d8-9d4c-099375603f9f@linuxfoundation.org>
Date: Fri, 23 Feb 2024 14:48:44 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] kselftest: Add basic test for probing the rust sample
 modules
Content-Language: en-US
To: Laura Nao <laura.nao@collabora.com>, ojeda@kernel.org,
 alex.gaynor@gmail.com, wedsonaf@gmail.com, shuah@kernel.org
Cc: usama.anjum@collabora.com, a.hindborg@samsung.com, aliceryhl@google.com,
 benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org,
 kernel@valentinobst.de, Sergio Gonzalez Collado <sergio.collado@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240222162913.498197-1-laura.nao@collabora.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240222162913.498197-1-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/22/24 09:29, Laura Nao wrote:
> Add new basic kselftest that checks if the available rust sample modules
> can be added and removed correctly.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> Reviewed-by: Sergio Gonzalez Collado <sergio.collado@gmail.com>
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes in v3:
> - Removed useless KSFT_PASS, KSFT_FAIL, KSFT_SKIP constants
> - Used ktap_finished to print the results summary and handle the return code
> Changes in v2:
> - Added missing SPDX line
> - Edited test_probe_samples.sh script to use the common KTAP helpers file
> ---
>   MAINTAINERS                                   |  1 +
>   tools/testing/selftests/Makefile              |  1 +
>   tools/testing/selftests/rust/Makefile         |  4 +++
>   .../selftests/rust/test_probe_samples.sh      | 34 +++++++++++++++++++
>   4 files changed, 40 insertions(+)
>   create mode 100644 tools/testing/selftests/rust/Makefile
>   create mode 100755 tools/testing/selftests/rust/test_probe_samples.sh
> 

Looks good to me. Don't you need a config file for this test?
Refer to config files for existing tests as a reference.

thanks,
-- Shuah

