Return-Path: <linux-kselftest+bounces-14241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD2993C6C1
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 17:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187651F26131
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 15:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7551C19D895;
	Thu, 25 Jul 2024 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M90wUF+V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9964A19D88C
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jul 2024 15:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721922473; cv=none; b=HF62j1a8EOPUSA5/JLwKN5MNSt2jS/pLTOLYONceVodkgyWQOSxzXW5nAUCrx8SuPTWWugoq2v7VOy5Lq+8H7iE7kJjY1Jv9t9zEO0E9E311hKN3HWQUmDGJnpRcRbGiOb3qEhZsWuqkTFgmlM1gnLoS7LCbn5hph2M+ixp2G3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721922473; c=relaxed/simple;
	bh=a6L0odqZVwjkz0+te8beRwJPik4vgylRtT86OIwZmeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M13zuZ4Cnb9iHKrjnt12ApjIUYCwlGGgp6YkijJnEKv1IM5FmclaQi5sPRghmwEN8ASMM378SaTpWv1Z1PNfB8QPa+j1jXo4zJuxWpDyxkjPRFm+42Fm32wmaV4+7eHdBvUrwa72749hxBiROCLe2x3RlQV8zJnx5w2ucw6XFRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M90wUF+V; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-81d05359badso2391639f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jul 2024 08:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721922471; x=1722527271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NY/wK/SC2b9qRhcTcT3biDroJ9aSTfxnDkIOXmpCheI=;
        b=M90wUF+VJ+vzwQ2tPGdXs75e8r24AyZj4r+yIvIWukz3V44SS7uLPlYi/Mn0EXugo+
         saMucJvoBD/pzShxBSMZFXdl/ycPIZE0MBXIaFvk3BIVN4YzyV1df0Bi9ZQYFYFy+fG2
         eQMfjyMmssrN7b5IpXIzjP4DLWbu/46SN1myU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721922471; x=1722527271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NY/wK/SC2b9qRhcTcT3biDroJ9aSTfxnDkIOXmpCheI=;
        b=CsQfjjue60XD/1x9lInqzrseRSTE0+OHXj3YYGhakUSBK3YRNF2y0f3kjRGxE/uYfn
         kHL9kMAXgmP4wc8sv9rcn9PS2B/MBbcnRQYSiMMTPE2Nct058FKl9wRnJc9EbJXUgGJ4
         66oq8trL1blGd+aUZGzJadiAbOHS9c/OLBVkdkxa6I6zQz8SPsAm3eTWgw6IKSUe6rH1
         GUZgMtsPihmambhgjhiWMWWcmE4pCemTnP9HOxHMdoVVS8HCxt3pnVNG5Fg8A5D47AyV
         iuVDqB4u61mPSY4qBSSPGs+HVuX/PyeuJKJV3GX5UcIMt2pMMsa0/HVkC4GLJXpaE0UU
         KhPw==
X-Forwarded-Encrypted: i=1; AJvYcCViOqdKbTtmLVZ92BthJXPIx/BAS2mCe9NS1Xlv8U0Q2Wi52BhnBzBPP0m9Gxs5zRfNmgEn2XuCnH64/umwxZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/uUenQMDv/9mbKAcE1Ht6ZA8UuoTjEMqsorZdBxQCUITH8HU0
	v7tkPuV6nNFXyYA6obfZanaK0CL0Q5us4HhKR9+JsaqoasHXEB980ngpTOKAd0s=
X-Google-Smtp-Source: AGHT+IFumxL+NQewlVU6VWvbnkaABDGEKgAZN3NMaqG5tjXbRd/nh/urjJZNUu6iIk/u0UMcs0HeDg==
X-Received: by 2002:a05:6e02:156e:b0:38e:cdf9:601b with SMTP id e9e14a558f8ab-39a22d399fbmr20010045ab.4.1721922470594;
        Thu, 25 Jul 2024 08:47:50 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39a22ea5fd4sm6830685ab.48.2024.07.25.08.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 08:47:50 -0700 (PDT)
Message-ID: <9bffb45a-7b06-498f-b168-c68506cb82ea@linuxfoundation.org>
Date: Thu, 25 Jul 2024 09:47:49 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] Add kselftest to detect boot event slowdowns
To: Laura Nao <laura.nao@collabora.com>, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel@collabora.com, kernelci@lists.linux.dev, tim.bird@sony.com,
 mhiramat@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240725110622.96301-1-laura.nao@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240725110622.96301-1-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 05:06, Laura Nao wrote:
> Add a new kselftest to detect and report slowdowns in key boot events. The
> test uses ftrace to track timings for specific boot events and compares
> these timestamps against reference values provided in YAML format.
> 
> The test includes the following files:
> 
>    - `bootconfig` file: configures ftrace and lists reference key boot
>     events.
>    - `config` fragment: enables boot time tracing and attaches the
>      bootconfig file to the kernel image.
>    - `kprobe_timestamps_to_yaml.py` script: parses the current trace file to
>      extract event names and timestamps and writes them to a YAML file. The
>      script is intended to be run once to generate initial reference values;
>      the generated file is not meant to be stored in the kernel sources but
>      should be provided as input to the test itself. YAML format was chosen
>      to allow easy integration with per-platform data used in other tests,
>      such as the discoverable devices probe test in
>      tools/testing/selftests/devices. Another option is to use JSON, as the
>      file is not intended for manual editing and JSON is already supported
>      by the Python standard library.
>    - `test_boot_time.py` script: parses the current trace file and compares
>      timestamps against the values in the YAML file provided as input.
>      Reports a failure if any timestamp differs from the reference value by
>      more than the specified delta.
>    - `trace_utils.py` file: utility functions to mount debugfs and parse the
>      trace file to extract relevant information.
> 
> The bootconfig file provided is an initial draft with some reference kprobe
> events to showcase how the test works. I would appreciate feedback from
> those interested in running this test on which boot events should be added.
> Different key events might be relevant depending on the platform and its
> boot time requirements. This file should serve as a common ground and be
> populated with critical events and functions common to different platforms.
> 
> Feedback on the overall approach of this test and suggestions for
> additional boot events to trace would be greatly appreciated.
> 

You don't need a cover letter for a single patch btw.

Please take a look at the tools/power/pm-graph
bootgraph.py and sleepgraph.py to see if you can leverage
them - bootgraph detects slowdowns during boot.

> Example output with a deliberately small delta of 0.01 to demonstrate failures:
> 
>    TAP version 13
>    1..4
>    ok 1 populate_rootfs_begin
>    # 'run_init_process_begin' differs by 0.033990 seconds.
>    not ok 2 run_init_process_begin
>    # 'run_init_process_end' differs by 0.033796 seconds.
>    not ok 3 run_init_process_end
>    ok 4 unpack_to_rootfs_begin
>    # Totals: pass:2 fail:2 xfail:0 xpass:0 skip:0 error:0
> 
> This patch depends on "kselftest: Move ksft helper module to common
> directory":
> https://lore.kernel.org/all/20240705-dev-err-log-selftest-v2-2-163b9cd7b3c1@collabora.com/
> which was picked through the usb tree and is queued for 6.11-rc1.

This tool does need some improvements based on the thread
that includes skips.

> 
> Best,
> 
> Laura
> 
> Laura Nao (1):
>    kselftests: Add test to detect boot event slowdowns
As mentioned earlier take a look at the tools/power/pm-graph
bootgraph.py and sleepgraph.py to see if you can leverage
them - bootgraph detects slowdowns during boot.

We don't want to add duplicate scripts if the other one
serves the needs. Those can be moved to selftests if it
make sense.

What are the dependencies if any for this new test to work?
Please do remember that tests in default run needs to have
minimal dependencies so they can run on systems that have
minimal support.

> 
>   tools/testing/selftests/Makefile              |  1 +
>   tools/testing/selftests/boot-time/Makefile    | 17 ++++
>   tools/testing/selftests/boot-time/bootconfig  |  8 ++
>   tools/testing/selftests/boot-time/config      |  4 +
>   .../boot-time/kprobe_timestamps_to_yaml.py    | 55 +++++++++++
>   .../selftests/boot-time/test_boot_time.py     | 94 +++++++++++++++++++
>   .../selftests/boot-time/trace_utils.py        | 63 +++++++++++++
>   7 files changed, 242 insertions(+)
>   create mode 100644 tools/testing/selftests/boot-time/Makefile
>   create mode 100644 tools/testing/selftests/boot-time/bootconfig
>   create mode 100644 tools/testing/selftests/boot-time/config
>   create mode 100755 tools/testing/selftests/boot-time/kprobe_timestamps_to_yaml.py
>   create mode 100755 tools/testing/selftests/boot-time/test_boot_time.py
>   create mode 100644 tools/testing/selftests/boot-time/trace_utils.py
> 
> --
> 2.30.2
> 

thanks,
-- Shuah

