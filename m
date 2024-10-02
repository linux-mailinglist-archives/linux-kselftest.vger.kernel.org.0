Return-Path: <linux-kselftest+bounces-18918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF94798E201
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 20:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28101C22CDB
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 18:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C501D1751;
	Wed,  2 Oct 2024 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="epDG35Aj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B937018B09
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Oct 2024 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727892016; cv=none; b=E6R4WvrD66m7IIm6cX8LmuVukcjbDM9N5zpd6JYe89JkWQL8ipp63qRU8D9o3tejusUclWlvOjfiRe9FQ92lw/iByLkHQI+jHoLqEMitqW+GbUHDvD3erzGOrXNVACLXEJbXpev3bJSuDTuabvg4T8+eznxu5hDX2oFEzTnOYZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727892016; c=relaxed/simple;
	bh=VXOOUNdnAEhPqciXyVZksZiXTp0bQQtRDANzdI1gkBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fr94gRWg5X4bgK28FOfbmPGBmsWC2hYqj71JQEEUtyX1mzuk4ZsFEhmmGTyf82XhAuQDhPSIGYrYb7RqTBfM8c093BlKKB1kTvvLBd3y3YHznK0sMw7opS3hpPksr0hPU6WIMOe//nqBzMeOworuMu7YFJDEugQkeMtPtI/AA/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=epDG35Aj; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82ce1cd202cso4864239f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2024 11:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727892013; x=1728496813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h2ii6GPB8LbcDkdZtu/vEyeCXjQrhQgW3fBbVs7hZZg=;
        b=epDG35AjWOTR3ZFt2UlUdU+I4KpFz+LfzyeqB6CdD/KXyxZ3f9DWXq33XR9yDNsN3D
         4BsYR7Lvr9rL+DKqEK10qyqPk4rCJQ3uz60fZ+B/jtwWgwFFivuyiTQdyb0V/DakKww/
         jGmgy0oroINrUs29ocEuxqfAYlFTjSxoH84nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727892013; x=1728496813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h2ii6GPB8LbcDkdZtu/vEyeCXjQrhQgW3fBbVs7hZZg=;
        b=CW7nHsMUqepXMYXNjAKtRy8zr7GkBjxGjUnQry92vLjM8h+GBBKJviCoxYzalTHYvH
         aP3rZzQ/r8uEkFafZm0MOgugdbe1RdGQ56zyOCStBpFYh2moWjQo9HgFWq5/i4hAHvGa
         VCOsx3HQFpQYCeNnnOV6sVoJAWZH/1Dds4qzXFe7Q7NZDU5GlTxz5rLqzrX6GGwd6OUM
         RWNzuSrj6DSsLCXIpxvRvu/n4snVnMr26ykqkfBng2UYzVR+aXChy07ldoagq0A2WxJA
         kkMoDNtCVuUV0O+/hUDlGb3P8moDQCOBKaxt43X4lhaxC1cetaYVQehF+70MqZdzBf65
         MRLA==
X-Forwarded-Encrypted: i=1; AJvYcCXddE0UuOoLxC/UFVFA+8aO3KnhPOU+lFuN19oMutgAbJP7dBu0Lv0IySFZ6SXgykcnnXDmzy/gpZnD8r2pcdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxocOe9Yay29ZoS933C2AGyYAcFWP8HXVnJTEui3eLDXKMQulHF
	PzFl32bKD9WrZulZZ71XQM8cMpes7s+k2M53ZmTUEYFOV1dusyqDRO+rEWUv0dk=
X-Google-Smtp-Source: AGHT+IFZG+oK4eRQhMYCZ+1EA/WngOtJ5AXbNw+nKvg+PAQy26l2faeXkJTKlKwWhIU/wZbdksh8gQ==
X-Received: by 2002:a05:6e02:1a6c:b0:3a0:9026:3b65 with SMTP id e9e14a558f8ab-3a365954e63mr38914205ab.25.1727892012800;
        Wed, 02 Oct 2024 11:00:12 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d888835090sm3187850173.15.2024.10.02.11.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 11:00:11 -0700 (PDT)
Message-ID: <0040a842-de9c-4f9c-9d61-c1bfbd010470@linuxfoundation.org>
Date: Wed, 2 Oct 2024 12:00:10 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: dev-tools: Add documentation for the device focused
 kselftests
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernelci@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241001-kselftest-device-docs-v1-1-be28b70dd855@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241001-kselftest-device-docs-v1-1-be28b70dd855@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/1/24 09:43, Nícolas F. R. A. Prado wrote:
> Add documentation for the kselftests focused on testing devices and
> point to it from the kselftest documentation. There are multiple tests
> in this category so the aim of this page is to make it clear when to run
> each test.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> This patch depends on patch "kselftest: devices: Add test to detect
> missing devices" [1], since this patch documents that test.
> 
> [1] https://lore.kernel.org/all/20240928-kselftest-dev-exist-v2-1-fab07de6b80b@collabora.com
> ---
>   Documentation/dev-tools/kselftest.rst       |  9 ++++++
>   Documentation/dev-tools/testing-devices.rst | 47 +++++++++++++++++++++++++++++

The new file needs to be added to Documentation/dev-tools/index.rst

Docs make should have warned about this?

>   2 files changed, 56 insertions(+)
> 
> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> index f3766e326d1e..fdb1df86783a 100644
> --- a/Documentation/dev-tools/kselftest.rst
> +++ b/Documentation/dev-tools/kselftest.rst
> @@ -31,6 +31,15 @@ kselftest runs as a userspace process.  Tests that can be written/run in
>   userspace may wish to use the `Test Harness`_.  Tests that need to be
>   run in kernel space may wish to use a `Test Module`_.
>   
> +Documentation on the tests
> +==========================
> +
> +For documentation on the kselftests themselves, see:
> +
> +.. toctree::
> +
> +   testing-devices
> +
>   Running the selftests (hotplug tests are run in limited mode)
>   =============================================================
>   
> diff --git a/Documentation/dev-tools/testing-devices.rst b/Documentation/dev-tools/testing-devices.rst
> new file mode 100644
> index 000000000000..ab26adb99051
> --- /dev/null
> +++ b/Documentation/dev-tools/testing-devices.rst
> @@ -0,0 +1,47 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. Copyright (c) 2024 Collabora Ltd
> +
> +=============================
> +Device testing with kselftest
> +=============================
> +

Get rid of the extra blank line.

> +
> +There are a few different kselftests available for testing devices generically,
> +with some overlap in coverage and different requirements. This document aims to
> +give an overview of each one.
> +
> +Note: Paths in this document are relative to the kselftest folder
> +(``tools/testing/selftests``).
> +
> +Device oriented kselftests:
> +
> +* Devicetree (``dt``)
> +
> +  * **Coverage**: Probe status for devices described in Devicetree
> +  * **Requirements**: None
> +
> +* Error logs (``devices/error_logs``)
> +
> +  * **Coverage**: Error (or more critical) log messages presence coming from any
> +    device
> +  * **Requirements**: None
> +
> +* Discoverable bus (``devices/probe``)
> +
> +  * **Coverage**: Presence and probe status of USB or PCI devices that have been
> +    described in the reference file
> +  * **Requirements**: Manually describe the devices that should be tested in a
> +    YAML reference file (see ``devices/probe/boards/google,spherion.yaml`` for
> +    an example)
> +
> +* Exist (``devices/exist``)
> +
> +  * **Coverage**: Presence of all devices
> +  * **Requirements**: Generate the reference (see ``devices/exist/README.rst``
> +    for details) on a known-good kernel
> +
> +Therefore, the suggestion is to enable the error log and devicetree tests on all
> +(DT-based) platforms, since they don't have any requirements. Then to greatly
> +improve coverage, generate the reference for each platform and enable the exist
> +test. The discoverable bus test can be used to verify the probe status of
> +specific USB or PCI devices, but is probably not worth it for most cases.
> 
> ---
> base-commit: cea5425829f77e476b03702426f6b3701299b925
> change-id: 20241001-kselftest-device-docs-6c8a411109b5
> 
> Best regards,

thanks,
-- Shuah

