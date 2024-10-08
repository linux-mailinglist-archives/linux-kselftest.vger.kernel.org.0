Return-Path: <linux-kselftest+bounces-19306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1434995BA1
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 01:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ABB3B21BA6
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 23:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC493217918;
	Tue,  8 Oct 2024 23:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1eLQbNq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFE12178FE;
	Tue,  8 Oct 2024 23:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728430063; cv=none; b=ZW/toIRWuWRDPkC7LE8AiUtgxDzUCub/yU51hORs8KTA2Lxr4S6cSDuSZYwk68bMzCJK5kMB9R3EQsw/ygtzrC6ilikpde8kHnmgHVRnHkuFi1PqII9Z8qgRjD1XR2htOq46FFcXHeX2JaVPfx937+pb/Bcm5nTWjcF2GQOXHNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728430063; c=relaxed/simple;
	bh=vdtEsmXJT3wve2O6pQuPZ14Hb482hs87xR59pTW8i5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEhLRhDbpL8EFE888ZwzPL5gWv8sMWxEHsVA/Yrc7sQzyTPjUglDfh7DQsrdYNt2MgzHwQficOrsS3eRlRPZ4Q6ePP6NzdAaWJR6dp+7yFCStCZxcYhkG/m2TNDgsJRm3u7v9GN1uGxvFAKimAv9v3o7k4+wX538m19scw7gwt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1eLQbNq; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e29522f0f1so672633a91.0;
        Tue, 08 Oct 2024 16:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728430061; x=1729034861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WPAgXuOBQUvSa+7Ar+VJpB36qiWIAixSpKmgUg69p94=;
        b=i1eLQbNq3mrQhu0Bq3QlWXSaNNObPhGJwWYpqREyrficHj3HSUEavfiWEx1Crkf91O
         s/YYt0axy/mWd1f05cgUife3757vvXcLhgfxnt1xuzh3gcNIUu01+E/uyvDHuFTZJu3a
         dDWWwSWlf8Y8c9d3M6Ob1ED9wf+WcN4aROqoNu8RGWy4SZEh4Hc74mwNhEo6BTGRSdXr
         9BPYgw+OsVPChjzsa3Lcsh7/3WcpCNP5u4lIVniAF/doGZM5pvw70fEXDgKSE2bq9YGz
         Ds0eYrHG6Er+zNM2/kcnSLybf+BMeZGHQHeuFQJr+4/A2j3L4hoqRXlWJbxkDiSNefzi
         K9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728430061; x=1729034861;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPAgXuOBQUvSa+7Ar+VJpB36qiWIAixSpKmgUg69p94=;
        b=hyRTZmJ49tEaq30GtRPzV7G2HyBWghzpiYctlRGsVhtXcmTGaamPy2DnU/v2Oi6HoP
         C3RqXF5HnVAuRt+IY+uLbg+YLLeKR91YFBzLahD4uKjd4b7iLRD6m8bWSPUCgRcXQ9qu
         Wq255SqpfluBxDf+2MDi4SjJVleNi0K1uBUapS9bGKMSS6PG3x6eX2HFYVc6e+eAsiWz
         IncjJymk4Y/5NTf+JOhsHuyVopJ0wBnEgPyeeQXy1jDBob04HsMRGV11JRq8CELf/ZRv
         Azq+rQbW6Ngkp5Zpe04Yv+ojkUctCwCQBUlMbDxzu27PUpTZTm6TBwNyAWWnIxpoWAqu
         B6Sw==
X-Forwarded-Encrypted: i=1; AJvYcCU44mDTWOLAmDPnuixx+MceV34L43RpqBcUyIUXtpiEkKIukxCh1v/eBUJRvXhElcDNBuM+ObMc0Paduhl3UGvX@vger.kernel.org, AJvYcCUSk0cwTAEuEV/q8Vm8xgk49gSHVMlABO6A5ONCUj/zwIV7gXv2i3i6hrZCVHCOdZX2Zct/J4UGZxKo@vger.kernel.org, AJvYcCUbvoKGrh5WyFvYWDQhximrlr8x4RnEer78ZF7GP5JqzX1GWcmOMiO6J5FDH0S8EdStvCzCDors5Lye53hB@vger.kernel.org, AJvYcCUdSjQq7a/+HsaxdoS2yy5vVXZxbof3MWZrMtnJ0rxOmKh1yv9OyEtq14XYQbjyGL+Di8fyhUZ5jq4x@vger.kernel.org
X-Gm-Message-State: AOJu0YxR5PnU4hPd3s+3HvXEXEqGMXCpNnZflq0EgAo4s3siYeWfRd5H
	a0Sjdt2GkaFrBD8tzzfQxRZ0AaIld5a3YHEPe5a9LHsNUwb0v6B8
X-Google-Smtp-Source: AGHT+IE7vJl5NwmkITb5nr7A6xWeqUgwaHStS4JpHCRMULaY96hgbBwFCRXGZ6E/b/2vgw5IdT0SVw==
X-Received: by 2002:a17:90a:68c7:b0:2e1:92bb:54a9 with SMTP id 98e67ed59e1d1-2e2a23343b7mr689757a91.12.1728430061030;
        Tue, 08 Oct 2024 16:27:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a5965e9csm151387a91.41.2024.10.08.16.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 16:27:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <594e8e50-8322-480e-ae34-3f8e14f3fe18@roeck-us.net>
Date: Tue, 8 Oct 2024 16:27:37 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/8] clk: Add KUnit tests for clks registered with
 struct clk_parent_data
To: Stephen Boyd <sboyd@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 patches@lists.linux.dev, kunit-dev@googlegroups.com,
 linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J.Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>, Daniel Latypov
 <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>,
 Geert Uytterhoeven <geert+renesas@glider.be>
References: <20240718210513.3801024-1-sboyd@kernel.org>
 <ba88a29c-f05e-4ca3-82d1-0a634613caee@roeck-us.net>
 <4216b852-11a2-41ae-bb01-5f9b578ee41b@roeck-us.net>
 <879831a8-2039-4cdb-bce2-aefdeb7ab25f@linuxfoundation.org>
 <da260b77-2ecb-4486-90cb-6db456d381ef@linuxfoundation.org>
 <f5f1c42d-77c0-48c7-ac52-3d4a3b5c2b47@roeck-us.net>
 <4a8abb5f501279de7907629f4dd6be24.sboyd@kernel.org>
 <3e1de608-008c-4439-acd2-647a288dcdc0@roeck-us.net>
 <cd31493888acc2b64a4986954dfa43ae.sboyd@kernel.org>
 <cb1e0119-6e3e-4fd2-92ea-3fec18f5843d@roeck-us.net>
 <ccd372f2754e80d6c01e38a9596bed34.sboyd@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ccd372f2754e80d6c01e38a9596bed34.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/24 16:12, Stephen Boyd wrote:
> Quoting Guenter Roeck (2024-10-03 21:52:09)
>> On 10/3/24 17:42, Stephen Boyd wrote:
>>>
>>> Can you please describe how you run the kunit test? And provide the qemu
>>> command you run to boot arm64 with acpi?
>>>
>>
>> Example command line:
>>
>> qemu-system-aarch64 -M virt -m 512 \
>>        -kernel arch/arm64/boot/Image -no-reboot -nographic \
>>        -snapshot \
>>        -bios /opt/buildbot/rootfs/arm64/../firmware/QEMU_EFI-aarch64.fd \
>>        -device virtio-blk-device,drive=d0 \
>>        -drive file=rootfs.ext2,if=none,id=d0,format=raw \
>>        -cpu cortex-a57 -serial stdio -monitor none -no-reboot \
>>        --append "kunit.stats_enabled=2 kunit.filter=speed>slow root=/dev/vda rootwait earlycon=pl011,0x9000000 console=ttyAMA0"
>>
>> That works fine for me. Configuration is arm64 defconfig plus various
>> debug and kunit options. I built the efi image myself from sources.
>> The root file system is from buildroot with modified init script.
>> kunit tests are all built into the kernel and run during boot.
> 
> Thanks. I figured out that I was missing enabling CONFIG_ACPI. Here's my
> commandline
> 
> ./tools/testing/kunit/kunit.py run --arch=arm64 \
> 	--kunitconfig=drivers/of \
> 	--qemu_args="-bios /usr/share/qemu-efi-aarch64/QEMU_EFI.fd -smp 2" \
> 	--kconfig_add="CONFIG_ACPI=y" \
> 	--kernel_args="earlycon=pl011,0x9000000"
> 
> Now I can boot and reproduce the failure, but there's another problem.
> ACPI disables itself when it fails to find tables.
> 
>   ACPI: Unable to load the System Description Tables
> 
> This calls disable_acpi() which sets acpi_disabled to 1. This happens
> before the unit test runs, meaning we can't reliably use 'acpi_disabled'
> as a method to skip.
> 
> The best I can come up with then is to test for a NULL of_root when
> CONFIG_ARM64 and CONFIG_ACPI are enabled, because the tests
> intentionally don't work when both those configs are enabled and the
> 'of_root' isn't populated. In all other cases the 'of_root' missing is a
> bug. I'll probably make this into some sort of kunit helper function in
> of_private.h and send it to DT maintainers.

Sounds good. Thanks a lot for tracking this down.

That makes me wonder though why only arm64 has that restriction. Both
riscv and loongarch have ACPI enabled in their defconfig files but call
unflatten_device_tree() unconditionally.

Oh well ...

Thanks,
Guenter


