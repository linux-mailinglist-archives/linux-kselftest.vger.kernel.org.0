Return-Path: <linux-kselftest+bounces-14818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2498948547
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 00:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602D91F2353C
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 22:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E9E16C696;
	Mon,  5 Aug 2024 22:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gZtJvkt6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE1C155351
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Aug 2024 22:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722895681; cv=none; b=eil8dNEGaO0aYH4nBNyZxepREZLLsYkdAK0yHmAdDbkSF+suiMT26dAXCSMcVYX6s30HhYqpTt1ObHmj+Bjn5wJTUQd0AlORNyR+6uks4Tcc+8XT70i02Q5Q1pU1AbuMhLf769RQqgRUZYQxgeKG/Wm7gpdMtvooXgyauif5XqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722895681; c=relaxed/simple;
	bh=U4J3FzJ/j6UlXBl1SDUKqstnQBbHFmk+w3DXKJ+vGw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m3TChOXdkZyE3g8Ic02n0zmFRxhBqs+GVCmzb+iwVgqU4TU0QvaJI1q2q1yFdbGrdnX7KOngnSB7mHPPnXcLzTzyBRaEXx5eEtYxR4G/JVDpf2WlZn+Y0Hv6u8O6MEk/cIWSG3b4L1q+4sWk9D7IrQ5LLqKiOGHxj1frs7MsONM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gZtJvkt6; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-81f7faff04dso370039f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Aug 2024 15:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722895679; x=1723500479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jMlYsZhKej2PxVHpyW2LcZaOqCZDJpfHcgQxGaH7HcU=;
        b=gZtJvkt6teJFV0iTnwA5m9xvB4CxoQY9Iw1hKux+0GAGhFZEMeygsuEKE8yvRXYvOm
         yrrHUfoepy9B9/yIjBvNsPVoUogr9tXnYsbIcGsaI/l9E/BXgRnxpIGiri/FfkxsiGR8
         zhvvbGQ8XGR7IkoQQiuNTlETY3w0LL6pUyPDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722895679; x=1723500479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jMlYsZhKej2PxVHpyW2LcZaOqCZDJpfHcgQxGaH7HcU=;
        b=Q2jh6OOzGwDRcpI+6R75wxvTURwpl0scJmTodPNRJkJMLJWQmswFhpli6zGMyn8KXX
         ejEqGhxoZSWAQyIDfjJDAaadOkvk33AUyGvlmaTZz76zxkIKmVwkW+YlKrSlDE7PyU2l
         S8/xeo5cDM4wzVCyY/EFBrS815V8ovNEfRfrPF2YAP+qnlQD/9GaQ5Z80E42d2ZsM4rq
         J00MLaHLtBpT9EzMgWgNLVreeYuSVmPVFrgYJSGPxoSyhhVw+vy287geMPxgEweVgRM4
         uxQSTokHAZhAkGbKo2S7/RZGUM2Vgo2uiDQVoZ+LFllXjqcWmAlxlBhJn/KTsuiW/gbq
         Sf9Q==
X-Gm-Message-State: AOJu0YxK8Ub2aVq7T9wpHo7KQ7aVDqiUhtVZcPP2xhKa6Dm40rC/4NzD
	/EMoRHbwb2mrIY5ckILXKWTkv4vp0Z/rcPznuUNToL0PhmhS6KZlRk+M1sP+7SSO2BtrEg8rITq
	q
X-Google-Smtp-Source: AGHT+IFvh0bshiOD89+mdd8yvM145zffYxh0bObuw4NtQ/Z9pYep6bZ5A/17MM6f8GUt5Iti22210Q==
X-Received: by 2002:a5d:8185:0:b0:80a:9c66:3842 with SMTP id ca18e2360f4ac-81fd43d5bf1mr743191139f.3.1722895678776;
        Mon, 05 Aug 2024 15:07:58 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d6a5c329sm1875989173.169.2024.08.05.15.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 15:07:58 -0700 (PDT)
Message-ID: <602cf3ba-7d42-4c3f-a672-573f19b946fb@linuxfoundation.org>
Date: Mon, 5 Aug 2024 16:07:56 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kselftest/devices/probe: Fix SyntaxWarning in regex
 strings for Python 3
To: Alessandro Zanni <alessandro.zanni87@gmail.com>, shuah@kernel.org,
 gregkh@linuxfoundation.org, nfraprado@collabora.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240805103742.10844-1-alessandro.zanni87@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240805103742.10844-1-alessandro.zanni87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/5/24 04:37, Alessandro Zanni wrote:
> Insert raw strings to prevent Python3 from interpreting string literals as Unicode strings
> and, consequently, '\d' as an invalid escaped sequence.
> Avoid the 'SyntaxWarning: invalid escape sequence '\d'' warning for Python versions greater than 3.6.
> 

Change log lines shouldn't exceed 76 chars - Refer the to following doc

Documentation/process/submitting-patches.rst

Include the exact warning you are seeing when you run the script.

> Fixes: dacf1d7a78bf ("kselftest: Add test to verify probe of devices from discoverable buses")
> 
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> ---
> 
> Notes:
>      v2: Imperative mode description for the inserted changes, added previous commit tag fixed by this patch
> 
>   .../selftests/devices/probe/test_discoverable_devices.py      | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/devices/probe/test_discoverable_devices.py b/tools/testing/selftests/devices/probe/test_discoverable_devices.py
> index d94a74b8a054..d7a2bb91c807 100755
> --- a/tools/testing/selftests/devices/probe/test_discoverable_devices.py
> +++ b/tools/testing/selftests/devices/probe/test_discoverable_devices.py
> @@ -45,7 +45,7 @@ def find_pci_controller_dirs():
>   
>   
>   def find_usb_controller_dirs():
> -    usb_controller_sysfs_dir = "usb[\d]+"
> +    usb_controller_sysfs_dir = r"usb[\d]+"
>   
>       dir_regex = re.compile(usb_controller_sysfs_dir)
>       for d in os.scandir(sysfs_usb_devices):
> @@ -91,7 +91,7 @@ def get_acpi_uid(sysfs_dev_dir):
>   
>   
>   def get_usb_version(sysfs_dev_dir):
> -    re_usb_version = re.compile("PRODUCT=.*/(\d)/.*")
> +    re_usb_version = re.compile(r"PRODUCT=.*/(\d)/.*")
>       with open(os.path.join(sysfs_dev_dir, "uevent")) as f:
>           return int(re_usb_version.search(f.read()).group(1))
>   

thanks,
-- Shuah

