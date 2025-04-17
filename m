Return-Path: <linux-kselftest+bounces-31038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C431EA9151B
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 09:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA25446068
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 07:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162CD21ADAB;
	Thu, 17 Apr 2025 07:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YwTsQGIt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743302192FA
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 07:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744874791; cv=none; b=ru4ItquBjE4YaZEWsEFS63L/SIWGudvhMsk63SJbJj7smH9FDdxRm5D8cxnmXxJTD4Ey2qmxBdmga77157HkkFZzrZxRRSQ6Hs0QviHQCaGpAoauLBg0PUDd5Nx+692UWDwQztThnglUUOnIzRfOoEtK3kybBx8VDS65Z9XSGQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744874791; c=relaxed/simple;
	bh=Pt4wMjTOPxLyncUhsljlu78aefYEy0zJC2OQzWrprQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F14M/5SkGfHlqdfL/q3JsW8t6gRB39Kt3x6qocY8L3crzOX6zTLnDNp8LajJOCmIy2VxwR2mrjVYwugx6goD27BCYtQdeTyXD8drUhkGs6G/7rCH6jWlkw6h22L9dwbQMfx50VxjF/a6PGsjhVotUNZe39da2jAr0yztGfMBS80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YwTsQGIt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744874788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Udp20JCu0lxnLB5nbtOFfZ2GpP06hSOWr1XwI2XNqTs=;
	b=YwTsQGItdi6+imIMzgmeMpHYDQE+ULd34i8Ptza9OWjt+4UlGyl1S1qe9qVCGhmuhp1DPm
	sraAHv4IYTEWH3eU4P5sJHREnG1L73yUCRUmGJYpsQSWwoZ9nRq1kVGiljSQLcsC//iNbL
	9qvXXAGgaQKHmnxVYn2bWpi9GhqltM8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-TD0FWqpXNg6X0bNQK86y9A-1; Thu, 17 Apr 2025 03:26:25 -0400
X-MC-Unique: TD0FWqpXNg6X0bNQK86y9A-1
X-Mimecast-MFC-AGG-ID: TD0FWqpXNg6X0bNQK86y9A_1744874784
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-391492acb59so243749f8f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 00:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744874784; x=1745479584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Udp20JCu0lxnLB5nbtOFfZ2GpP06hSOWr1XwI2XNqTs=;
        b=JTUx1JB+sGbdu4NxQTHsvms3gh9LMfZnhtfXhHREphpeyR6yOy5bxu/ur9t5EEq/97
         xWO2NM/K/jjTxhgoI3Uz3Wyaqi5otyq+OP0P5+3lATZcGjiyWFVsE/AU80mA1sAvTbiJ
         YLyGMJENJdPvnAXbSxGndZJyd7QolneYjS1ebcje5JKyaj3RGgQ6llWitMp/kofeGryn
         R4y1KQ6ArjklZIYITiSikjiP8HlzhJ5J/c5XGs7ls93Vl4Xh8YtrQx50qRgSdH9FYxD9
         qaXP/6fwiJri/eSLZgx5VXWDbdmmeEQYyZicL1s6snBfSL8oeerhB6XwwZX2moklUMFq
         OuTA==
X-Forwarded-Encrypted: i=1; AJvYcCUi1mYzGWJvHWpE0vp3EWrDlrHIsxotbg6R1GQZtfmRGwHqPT7TfYXTYBx8QHm2xlKqQ7AHDyhO/CL7ybYjcrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsW6ng/7wNextK9avk/WDVWC6+LTxn/zJOLM65HZ7eIYD08PI2
	eb/asMxh3/RB1LyUrkaQ4RtjTwBiakEWem3sK5CHaRZG2hAM7QRGys0MZHXUJOitBudTLJOcZd/
	ChHqdIu3ndskjX3xdZS6unTIDDVvbSvU67cgFKouBuawI7T39R1ZEdTiu8sVw00lT/g==
X-Gm-Gg: ASbGncv4HFyWmIyCkZqfLLEwTYAtbKhoJRmBUNUtzc0Gvz4VEHgACBObD01BonYRnz2
	rZfSQAIt4F3FOhxkgHLDwT9fF91HqLNqB1ueu90xptNONonXdgAprospgcx9aqM8WDW+60P5cUD
	cHJtfA4jr/t8567/OZdq0zH3eRMLWqD33b5XgwQR1HO1VgzdJ6lBMN15m5XmeGxKp7Pjq1kw5iF
	1f4YfVFU1KRp0O67QJyEefdX3rOiPPkXq3x0RIQavq7f7CJB1BrqEYqGXj4Uke1LW2V5zRVjq6g
	8JKOJ2SPd9FDE/W1aeyJkxqvDFHg0XafG+XqzxE4aA==
X-Received: by 2002:a05:6000:144f:b0:391:241d:a13e with SMTP id ffacd0b85a97d-39ee5b9f5b6mr4191468f8f.48.1744874784108;
        Thu, 17 Apr 2025 00:26:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX40ws3+eqraZDVy9FNzNzHM8/7zc1TFMhaZr7xBFr7xp/tveKs9AoQ1WnxQPtgH7HvwyHGw==
X-Received: by 2002:a05:6000:144f:b0:391:241d:a13e with SMTP id ffacd0b85a97d-39ee5b9f5b6mr4191442f8f.48.1744874783782;
        Thu, 17 Apr 2025 00:26:23 -0700 (PDT)
Received: from [192.168.88.253] (146-241-55-253.dyn.eolo.it. [146.241.55.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae96c03dsm18792656f8f.24.2025.04.17.00.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 00:26:23 -0700 (PDT)
Message-ID: <b1fa9607-f9bd-4feb-a22f-55453a9403e9@redhat.com>
Date: Thu, 17 Apr 2025 09:26:22 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/4] selftests: drv-net: Test that NAPI ID is
 non-zero
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 "open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)"
 <bpf@vger.kernel.org>
References: <20250417013301.39228-1-jdamato@fastly.com>
 <20250417013301.39228-5-jdamato@fastly.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250417013301.39228-5-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/25 3:32 AM, Joe Damato wrote:
> diff --git a/tools/testing/selftests/drivers/net/napi_id.py b/tools/testing/selftests/drivers/net/napi_id.py
> new file mode 100755
> index 000000000000..aee6f90be49b
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/napi_id.py
> @@ -0,0 +1,24 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +from lib.py import ksft_run, ksft_exit
> +from lib.py import ksft_eq, NetDrvEpEnv
> +from lib.py import bkg, cmd, rand_port, NetNSEnter
> +
> +def test_napi_id(cfg) -> None:
> +    port = rand_port()
> +    listen_cmd = f'{cfg.test_dir / "napi_id_helper"} {cfg.addr_v['4']} {port}'

Not really a full review, but this is apparently causing self-tests
failures:

# selftests: drivers/net: napi_id.py
#   File
"/home/virtme/testing-17/tools/testing/selftests/drivers/net/./napi_id.py",
line 10
#     listen_cmd = f'{cfg.test_dir / "napi_id_helper"} {cfg.addr_v['4']}
{port}'
#                                                                   ^
# SyntaxError: f-string: unmatched '['
not ok 1 selftests: drivers/net: napi_id.py # exit=1

the second "'" char is closing the python format string, truncating the
cfg.addr_v['4'] expression.

Please run the self test locally before the next submission, thanks!

/P


