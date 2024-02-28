Return-Path: <linux-kselftest+bounces-5507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3428E86A434
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 01:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43ACFB2A80B
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 00:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56297163;
	Wed, 28 Feb 2024 00:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="faslrYAr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C2123C2
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 00:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078516; cv=none; b=HlHuGWkZAhNxCbLD0iwBoOeWly+HLNX4PuNHzbSxLDgm2iyJaIklK2+sV5lKsCQOPfJ2M4dL56hwkataie41u/KNBjleYRFLiFwBjjT9IMtEA9fI0ezURe38UwBBnd0JOyL39Qmcw7Pn3LUbyphnUuplhbCThOP7sHfSF4G4H1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078516; c=relaxed/simple;
	bh=rJMJ2JMyWN+ZP1wfxJ61M7N5IzMgg95FlXOlFyiqAPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kuFiL7zpHp7IYMgl5JaMtmhdESBrvYRx0heJkSA6SkIBU9yWpXEWwx4YRM3g8rFiL/X9kuNVGCQdXOTsaGr3aD/oDmwbl+3pWEtrY2vOAsirYR6EwmUdoj9yG4GRMa0VkGUEiG14UNwANmkzqXMx3ec5M8hERZPgh3w1J7JETKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=faslrYAr; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-365b413549eso948155ab.1
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Feb 2024 16:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709078512; x=1709683312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vrK0eALq3CiAPH0N0ru8YW+DX4foq/ClBC0Geu6EPXo=;
        b=faslrYArGMUqphsHkdlrHW/26xGTlMIR+96BZYXQhsldVZryx8KimdmxYD1Uoqs3eu
         Ny1xe1jgzny6QGwgH6ppwp1DGdyYGaZsb8iRKJh5KerpZUFCIsdCMrVq/n73IjpOEmB8
         7M+V/fDIthXhle7+Bwyuxnqh+Z7XI5zJ7NMIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709078512; x=1709683312;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vrK0eALq3CiAPH0N0ru8YW+DX4foq/ClBC0Geu6EPXo=;
        b=i0QL5NwAeTtxwo2ftxOmNXShBto8gyfWW3jxpubihYBbffvFgXiM4LciEAqg1nH0mv
         9BvrWahigVTDJLQ0TisvmgW+RANreULo68KIrsh5NohiOviiOKO56IS9MG6Q4qybhGy7
         zhlRnSU3rDTiqI0c1nCrXcSjV+DL8nB75ff34Bg7vlTpUpTqp6evhwMRlHbgvrQpNe64
         JvIrrsG2ivQBVrf5/j5iNOQ/467FxgQS0dBiNrO62PwtszTwU+VqxUFhx8YPTHi71+IA
         aEEOh87DreccKW7iF/j2a6E077/2Bef3J+F96EstAeyejI6MvbCrhyOgpbk6N8KRZVb3
         awqA==
X-Forwarded-Encrypted: i=1; AJvYcCXJiJugvoZ2t3Z91bMTLpVhYDzAJBkwjkj2AnVdX0nukxHZ6kLuL0Kficj9zxC6l276Eh9R2ljQRXjt9/FIg08ICZ2HZwMJ6U+RYUOKFhEi
X-Gm-Message-State: AOJu0YwKQ+QoniLhWhLF33lQHewv8kI0jn5tqmpae8wQ1/+N/V/sLwPX
	4/Ew3s+a/CaDnQAB/wEa3DtiHw2bYZR9OEn43eX5sHqU/ZxvyyvgdTQoJ7Ee98o=
X-Google-Smtp-Source: AGHT+IEyFi+EbG1qEGArV61BbwDxrrUz63Oh268SNQYaoJn57jboMklRNZBRwVEQ0zclSCq1pIQTXg==
X-Received: by 2002:a6b:7e08:0:b0:7c7:f5ce:5d9b with SMTP id i8-20020a6b7e08000000b007c7f5ce5d9bmr797781iom.1.1709078512072;
        Tue, 27 Feb 2024 16:01:52 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id s9-20020a6bdc09000000b007c76a2d6a98sm1947667ioc.53.2024.02.27.16.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 16:01:51 -0800 (PST)
Message-ID: <5df7d5b1-1387-41f5-a9e9-29c9aefa448e@linuxfoundation.org>
Date: Tue, 27 Feb 2024 17:01:50 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] kselftest: Add basic test for probing the rust sample
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
References: <20240226101646.291337-1-laura.nao@collabora.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240226101646.291337-1-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Laura,

On 2/26/24 03:16, Laura Nao wrote:
> Add new basic kselftest that checks if the available rust sample modules
> can be added and removed correctly.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> Reviewed-by: Sergio Gonzalez Collado <sergio.collado@gmail.com>
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Depends on:
> - https://lore.kernel.org/all/20240102141528.169947-1-laura.nao@collabora.com/T/#u
> - https://lore.kernel.org/all/20240131-ktap-sh-helpers-extend-v1-0-98ffb468712c@collabora.com/
> Changes in v4:
> - Added config file
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
>   tools/testing/selftests/rust/config           |  5 +++
>   .../selftests/rust/test_probe_samples.sh      | 34 +++++++++++++++++++
>   5 files changed, 45 insertions(+)
>   create mode 100644 tools/testing/selftests/rust/Makefile
>   create mode 100644 tools/testing/selftests/rust/config
>   create mode 100755 tools/testing/selftests/rust/test_probe_samples.sh
> 

I ran test again and I still see the same. I would like to
see the script to handle error conditions.

> diff --git a/MAINTAINERS b/MAINTAINERS
>
> +
> +DIR="$(dirname "$(readlink -f "$0")")"
> +
> +source "${DIR}"/../kselftest/ktap_helpers.sh

It tries to source and keeps going. Why can't we test for
the file to exist and skip gracefully without printing
the following messages.

  ./test_probe_samples.sh: line 12: /linux/linux_6.8/tools/testing/selftests/rust/../kselftest/ktap_helpers.sh: No such file or director
# ./test_probe_samples.sh: line 16: ktap_print_header: command not found
# ./test_probe_samples.sh: line 18: ktap_set_plan: command not found
# ./test_probe_samples.sh: line 22: ktap_test_skip: command not found
# ./test_probe_samples.sh: line 22: ktap_test_skip: command not found
# ./test_probe_samples.sh: line 34: ktap_finished: command not found



not ok 1 selftests: rust: test_probe_samples.sh # exit=127


> +
> +rust_sample_modules=("rust_minimal" "rust_print")
> +
> +ktap_print_header
> +
> +ktap_set_plan "${#rust_sample_modules[@]}"
> +
> +for sample in "${rust_sample_modules[@]}"; do
> +    if ! /sbin/modprobe -n -q "$sample"; then
> +        ktap_test_skip "module $sample is not found in /lib/modules/$(uname -r)"
> +        continue

Why are we continuing here? Isn't this skip condition?

> +    fi
> +
> +    if /sbin/modprobe -q "$sample"; then
> +        /sbin/modprobe -q -r "$sample"
> +        ktap_test_pass "$sample"
> +    else
> +        ktap_test_fail "$sample"
> +    fi
> +done
> +
> +ktap_finished


I would like to see the test exit with skip code when RUST isn't
enabled. Please refer to existing tests that do this properly.

thanks,
-- Shuah

