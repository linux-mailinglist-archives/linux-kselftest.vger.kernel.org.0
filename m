Return-Path: <linux-kselftest+bounces-14593-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4933943956
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 01:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 217EDB20BE9
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 23:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB46216D9C5;
	Wed, 31 Jul 2024 23:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W1AQGcum"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C0E16C695
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 23:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722467989; cv=none; b=VmBflPjNjDMAi+MXvukw6fY6eboHjr1sNDWX272DWWTnu0FkXVCP+BibMxQHjlKg6LMy6u0NwHY+le+CZcGprHVsz40rHhwbyK01wIq5IEUDv9YesVv04jFdcveSqJlu7RjgsEaPEtI2tmerdxqxssNnV2WTrmJSYZi+WHW7Xho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722467989; c=relaxed/simple;
	bh=4GwoRzclfzlo85zAvolfapd+CWdm9DU8Te+Ql1cnl+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZUfvRXwiDsYTfCxNZdEBSTGCvSvJIQIUSgPL2oHXSYw9H3Xna0IPXuk9GmTdTJt7RoL7qgUHrlI0H2N7XoWgaicy+BcDfxnrIschy49BENKMi1VB/hM07aFWITPL7pLG+M/FOzW6jP5PPVeHmToVtGl7TrZnymEwQGERvXod6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W1AQGcum; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3d1b5f32065so313906b6e.2
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 16:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722467987; x=1723072787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=etMvppMi7evDPjhbMsnAWhZBTxb0fCzMenZG1uh9MDE=;
        b=W1AQGcumAdhz6pJvWBBECkFBj7aecrDK8r8/UmUyktw2cCrDWTxj9usPq66vxcY0uz
         R2DJQOXm+7uZmyelMYs5IE4+1NbXHR1UYgLJ3eiO7GHCsElRhMh6oYbvkbxIoC6CdfRx
         ZOSePiErkenbM8MFWnOHmoxfwG90lYQoVBeXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722467987; x=1723072787;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=etMvppMi7evDPjhbMsnAWhZBTxb0fCzMenZG1uh9MDE=;
        b=OcGcoOS8xoBSxAZ4lSq2T0HYq8xMkKrUwLU2l7KPGQsh8WmQ+QmmUBp/tOzj2gndHq
         RWJpMCWppBLZfD/iqv+QjS1g5d+Bu9OPD4BGkx+6BNL8wxsuumX97AWzPIjnszHzyY0q
         E71nLpcU0/B1GXQQFc1vX8Haz6y58K4ya0r2QylMJ0Qb+dfFhn0TIW0gCkE2bIRtfN0n
         62Ii/6yXbKCUR/cy8mQd2TaHzG27uNiIYgz/SyU2FK+9ONvE61g3oEUGacXWqpA+x/9a
         EJ+Yy1oKTbK4WqGhCKQaKrXPTCbo8Tz5PE305UTbo7G0gMZY18OhDtSg0NENWU5A3WsQ
         +cZw==
X-Forwarded-Encrypted: i=1; AJvYcCURHRfZr5gUNNRQ++h0KxnBGINmCwdDnMFfr4J3AK/QTYfHw78jGevi1XEYCMmZyKPzXXwIr0ZsLgAW+3T6ArQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkdz9XXpnGkFX7g8+jrLtGSZwXUbBPObF+bCLRuKCAgpPkaz2U
	vxzSOycoLUN9sH6ODokFofAqykISpMXCZFSEVw44xzWdfEb4c3fiul1uHCUWq7o=
X-Google-Smtp-Source: AGHT+IGrdIeXgyWgztwjLDx8NrHnJ/zPFKpv/zS8lGiCJLsiszTxwKrySbmn38HXtASjPox9Bk+Ljw==
X-Received: by 2002:a05:6808:2205:b0:3db:42d0:7387 with SMTP id 5614622812f47-3db5122ed5cmr360052b6e.5.1722467986996;
        Wed, 31 Jul 2024 16:19:46 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db417ee4a9sm878004b6e.10.2024.07.31.16.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 16:19:46 -0700 (PDT)
Message-ID: <9d0b73ce-704c-4633-bb11-06ca4cb7a9a1@linuxfoundation.org>
Date: Wed, 31 Jul 2024 17:19:45 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] kselftest: devices: Add test to detect missing
 devices
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Shuah Khan <shuah@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Bird, Tim" <Tim.Bird@sony.com>, Laura Nao <laura.nao@collabora.com>,
 Saravana Kannan <saravanak@google.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 kernel@collabora.com, kernelci@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240724-kselftest-dev-exist-v1-1-9bc21aa761b5@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240724-kselftest-dev-exist-v1-1-9bc21aa761b5@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/24/24 15:40, Nícolas F. R. A. Prado wrote:
> Introduce a new test to identify regressions causing devices to go
> missing on the system.
> 
> For each bus and class on the system the test checks the number of
> devices present against a reference file, which needs to have been
> generated by the program at a previous point on a known-good kernel, and
> if there are missing devices they are reported.

Can you elaborate on how to generate reference file? It isn't clear.

> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> Hi,
> 
> Key points about this test:
> * Goal: Identify regressions causing devices to go missing on the system
> * Focus:
>    * Ease of maintenance: the reference file is generated programatically
>    * Minimum of false-positives: the script makes as few assumptions as possible
>      about the stability of device identifiers to ensure renames/refactors don't
>      trigger false-positives
> * How it works: For each bus and class on the system the test checks the number
>    of devices present against a reference file, which needs to have been
>    generated by the program at a previous point on a known-good kernel, and if
>    there are missing devices they are reported.
> * Comparison to other tests: It might be possible(*) to replace the discoverable
>    devices test [1] with this. The benefits of this test is that it's easier
>    to setup and maintain and has wider coverage of devices.
> 
> Additional detail:
> * Having more devices on the running system than the reference does not cause a
>    failure, but a warning is printed in that case to suggest that the reference
>    be updated.
> * Missing devices are detected per bus/class based on the number of devices.
>    When the test fails, the known metadata for each of the expected and detected
>    devices is printed and some simple similitarity comparison is done to suggest
>    the devices that are the most likely to be missing.
> * The proposed place to store the generated reference files is the
>    'platform-test-parameters' repository in KernelCI [2].

How would a user run this on their systems - do they need to access
this repository in KernelCI?

This is what I see when I run the test on my system:

make -C tools/testing/selftests/devices/exist/ run_tests
make: Entering directory '/linux/linux_6.11/tools/testing/selftests/devices/exist'
TAP version 13
1..1
# timeout set to 45
# selftests: devices/exist: exist.py
# TAP version 13
# # No matching reference file found (tried './LENOVO,20XH005JUS.yaml')
# # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: devices/exist: exist.py # exit=1
make: Leaving directory '/linux/linux_6.11/tools/testing/selftests/devices/exist'

thanks,
-- Shuah


