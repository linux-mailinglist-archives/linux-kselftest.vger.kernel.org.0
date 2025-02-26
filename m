Return-Path: <linux-kselftest+bounces-27645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8385AA46AEE
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 20:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9291E3A4456
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 19:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF01A236A70;
	Wed, 26 Feb 2025 19:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="IsHfiaQS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F9D41C71
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 19:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740597862; cv=none; b=dXGJSfNiHsDyHyxmla6F2L1OLooJduUBcakQ7LtKt0m491H/lKmSGl73YG3hk3NcKGSW7HTVGgoB/iD8tdIv9llCu5r4KppVWFCWLJyXRGBo8GwAfmtK1MDdP32No8lNHAPkfQyXtE0Vfjp9sqCxt2C2bj/8cWaKUkpmfr2z6es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740597862; c=relaxed/simple;
	bh=+MPxJiszOeCmFsn8+9MqxMgk4It36YrHrcETxZymxZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHDYw6J25SD9CIjsSxXQ0or2CdZBfK48lzRFDSHYYfWVyREd+GTr8pzLmJPm2FtIpiQ2ZOFoks/RzP+lrpWJL9f/r0D+C86//DuVVREVpg1qAmPdcTJDkXfUBhUKhjbV7EI3KzpT0AlyvkTtBsDsD7UEv7XscvYgfSqYYw/bZXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=IsHfiaQS; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220e6028214so2635355ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 11:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1740597861; x=1741202661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/sflnpIC6yKwseTfHm3vT9z2UOLJa7dEKR1pgDETj+Y=;
        b=IsHfiaQS04ZUz/3DCH5S0DOwiRC7GjFG/TLqvpLRYM6MtZgPsmMMchJo7hM34E9dzp
         GYY1nVx32t9BWNt4Cge9fW7lnvbsmNg9JvUk8UJRdnw7+4pC9Q8OxIY5zhd73G/T9t3f
         1FUy8KyIGv1r6p/3lonrpTJ0I969LTDxq3By3DoslF0xmJ1kD983XlJBMA+Q7o3ipqjF
         TGAEobrE1aJwwIaomr8zPADA8ZUSOULcM+nfxR8dpkynLZfUxNP6j1+AWcyyTjqbg4lu
         cj1LCALJNC7GvavlWfD4SwW0ScnPMoT66gRBPpyhgiOUJKsFMoDBWJvRp2A5PRzkjtLZ
         3+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740597861; x=1741202661;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/sflnpIC6yKwseTfHm3vT9z2UOLJa7dEKR1pgDETj+Y=;
        b=RdCA9ZTPtikdrax6/3VZKx6v7wm3YcbhS0CZNmuX8v84jspPbVzjFdAGdLkiAEoXhK
         a7DPBua7sOwsqQtAsz5Dmpr1HrKh3cYimECs/fRPTpBYL98Nl9Va0GI4FSptu0D9wp8k
         gU+d28be/snWuhgw6cCKRjvcx7xSO/Ht1PGkLoDBHLmB64OtIWkAjyIUPUwXZUcLA4j8
         YzbHh0e2lPw3s33dgNkKBWdWsTjVzqkQnyJUSz7RSVe2ZEnNnP5roAbPp3/n95l9r8st
         MME5AKVgIUbncEEu8Ah59Sca6GrV1p3bhgrbfT+AMpLojliK687GMdKGMOhLQU4zz7AC
         lwtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQVoeg2LPEqTPraGOaym7PcduoTfjh6J4sn35ZZrYYvS2VDAQeRIFymTa4lVJ2OEdFwqvT3m37bHQciVMCL54=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNVKSIz9COe2NPSzh0A01RicgTCJGbBoKvwlrtN3WoJlvvN0mO
	Vzat+H2P7z2rw7ivKBb7FaaWhqbS9a5Cgq67KmWia96S4UzdQKAUcnNYOWoAVKE=
X-Gm-Gg: ASbGncsOboMEYQULImTy1WyIPS+Xj9DAW3H1KB6G8L3kZeKnVW8SY5Q5XPg0OhiDWAP
	JLiqgiSVRXTQJcEbysodb5ejQIMSDvHQNxQg2xcCiI9N8xdA8L+Xu57JR72hofPbFrite2sQQ09
	UROjAHbxAt+Sh79mghbiCwnOvTOEoqxCEupAbVWibOKs+ll5ZrXwTnSL3MuXwgC4lWhzYHu+LOJ
	6svMR8yGH/7GLqJ7kFrsRFvh9cIgWmkUAprYzFJwY1yYqJ43WxTpdKnDUG3980rKwY7NuBFt5W2
	EsfneLSToTL69bmQL9xvw1mXKPU/K8+b/cYeEq39sfbflJPFc8+uGB9zN/FhEpnAZGzRZA==
X-Google-Smtp-Source: AGHT+IG0kO7k4eegwSBS0bGAJzlZ+5QciSS8EYAlWnYhxBYs9Vs7ZY1jsyhgzaQSgGTs4piCQxxvzw==
X-Received: by 2002:a17:902:f60b:b0:216:725c:a137 with SMTP id d9443c01a7336-2219ffb8b58mr407759205ad.28.1740597859464;
        Wed, 26 Feb 2025 11:24:19 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:18cb:90d0:372a:99ae? ([2620:10d:c090:500::4:af20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0908eesm36470885ad.124.2025.02.26.11.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 11:24:19 -0800 (PST)
Message-ID: <35c55f5b-7c1c-46cf-8d6c-50ee2479bbda@davidwei.uk>
Date: Wed, 26 Feb 2025 11:24:16 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] selftests: drv-net: Check if combined-count exists
Content-Language: en-GB
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org
Cc: gerhard@engleder-embedded.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250226181957.212189-1-jdamato@fastly.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250226181957.212189-1-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-02-26 10:19, Joe Damato wrote:
> Some drivers, like tg3, do not set combined-count:
> 
> $ ethtool -l enp4s0f1
> Channel parameters for enp4s0f1:
> Pre-set maximums:
> RX:		4
> TX:		4
> Other:		n/a
> Combined:	n/a
> Current hardware settings:
> RX:		4
> TX:		1
> Other:		n/a
> Combined:	n/a
> 
> In the case where combined-count is not set, the ethtool netlink code
> in the kernel elides the value and the code in the test:
> 
>   netnl.channels_get(...)
> 
> With a tg3 device, the returned dictionary looks like:
> 
> {'header': {'dev-index': 3, 'dev-name': 'enp4s0f1'},
>  'rx-max': 4,
>  'rx-count': 4,
>  'tx-max': 4,
>  'tx-count': 1}
> 
> Note that the key 'combined-count' is missing. As a result of this
> missing key the test raises an exception:
> 
>  # Exception|     if channels['combined-count'] == 0:
>  # Exception|        ~~~~~~~~^^^^^^^^^^^^^^^^^^
>  # Exception| KeyError: 'combined-count'
> 
> Change the test to check if 'combined-count' is a key in the dictionary
> first and if not assume that this means the driver has separate RX and
> TX queues.
> 
> With this change, the test now passes successfully on tg3 and mlx5
> (which does have a 'combined-count').
> 
> Fixes: 1cf270424218 ("net: selftest: add test for netdev netlink queue-get API")
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  v2:
>    - Simplify logic and reduce indentation as suggested by David Wei.
>      Retested on both tg3 and mlx5 and test passes as expected.
> 
>  v1: https://lore.kernel.org/lkml/20250225181455.224309-1-jdamato@fastly.com/

Thanks Joe.

Reviewed-by: David Wei <dw@davidwei.uk>

