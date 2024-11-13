Return-Path: <linux-kselftest+bounces-21966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3061D9C7B42
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 19:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0656EB3AA8C
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 18:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963FA2036EF;
	Wed, 13 Nov 2024 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ATqvQirm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEBD200B88
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Nov 2024 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731522810; cv=none; b=aU5cKduipz1FKn4oD1pkDQ5TKkQTWj+HQEje5z1t90y9FNEzaULzmg9gpj3rtDEsuXu2aYLI/byovC6jaw+kkBDzU6j1n4S5E42JadUDlSPBPthY1X26FHRvBOMM7dgnHkYTaKtgqEUmLVdHx9FbgWoPPryQrqTsSl7TT7HjN4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731522810; c=relaxed/simple;
	bh=EwSuFwBGsabC+tAlOx5Rv9AU2s0XjyQ/FTIZjCDU7Pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mpq5aGeLqEV40c8OsYN3NQLN/XIoJhYIaOFu2StQNHvs+6GT8LjvzaQgcZ1lH0VlpXOqFbiUeofeO6bfdoBrG+5yBa7z/xy19nMlihQKMS9RwLZ1R4D711Cgy63UW99/gz0dcvIfhccjMFWozSCFrbE3o1XSuBBSCmk1kPOFDSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ATqvQirm; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a3b8b34be9so24201855ab.2
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Nov 2024 10:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1731522808; x=1732127608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S/GfcE9OCxBYPDcXgZTJGY+00HlR32HbeFGA4TmMb3U=;
        b=ATqvQirmpKrMw09bjzWkYnq/1oWeIJn4Zf8mdt3n+lqGht6WXZMkXnkWwQScb5qoiX
         Fnzr+bK3HOGM3CvpcnbtW/WY+6mxKSY+8D++X4Sz4keC/50U/s+vM2UoFVLlba3Y/T5Z
         eXIfk6FzwPEv1GEVSKT6Cjw9ZhpDZtcx3JpAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731522808; x=1732127608;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S/GfcE9OCxBYPDcXgZTJGY+00HlR32HbeFGA4TmMb3U=;
        b=mWdyM9ZT0lcD2umkf/CU7fpwv9g2iLAo5TjBAVe2yIwAmnaAczDToDW7g6O6zpWVD6
         stUoVuy5UvbcD3vgB0Rcmp7bTqMgcP4xcPsZdqDzxdF9wm4268+qXQKQ0C+Uvb2mqF48
         VUT7+rLIc/F8J+c6jx3Bq8H2UveyCUliyQxYFFs9XBKe7/dx/QrMzGx7b3PI4/+6LrQa
         tIab57QS21RfGFgm6B4fareKm+7hDZ0n8TOIQN6rJBJsDXrnSlRT2lb4JEk2c9WX7pTY
         3slcnsPunh/3t60CUe5zCaAoS6sUrnh9WO7u56VcmmC5ZVlDeT3fmcICOI0SVQIsCFkB
         nXrw==
X-Forwarded-Encrypted: i=1; AJvYcCVu6+fYJWKXsqpGntnDY7LicRhyu38gbQrmGPceXPBx8NCgBiHgm9gAZgaIzmWMEGuMIreusArCK3yjOYhmNNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1q+jOEBFZYxH/RWT6RjFFteSWWTEhaPBhz6RfqLS1Jzw9TjXq
	7GBarF9D8nQavv3bts6A8M8/YHsc2Xa8KlNOGFY16BRWcILyamqaf9QBd9SzL90=
X-Google-Smtp-Source: AGHT+IE6+B0pqn4ka7/F5/EGXwdqPuSVqy6MB8CNkXsjUaGm6LtPddAhvAayt3JB1jye48dzpCDhJA==
X-Received: by 2002:a92:ca4b:0:b0:3a7:1891:c5f2 with SMTP id e9e14a558f8ab-3a71891c6d4mr34823225ab.1.1731522807654;
        Wed, 13 Nov 2024 10:33:27 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6f9838240sm31570215ab.23.2024.11.13.10.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 10:33:27 -0800 (PST)
Message-ID: <eb4b9c05-66a2-4a14-b59b-37149beba3b2@linuxfoundation.org>
Date: Wed, 13 Nov 2024 11:33:26 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LKFT CI: improving Networking selftests results when validating
 stable kernels
To: Matthieu Baerts <matttbe@kernel.org>,
 Linux Kernel Functional Testing <lkft@linaro.org>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: Shuah Khan <shuah@kernel.org>,
 Kernel Selftests <linux-kselftest@vger.kernel.org>,
 Netdev <netdev@vger.kernel.org>, Linux Kernel
 <linux-kernel@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 Naresh Kamboju <naresh.kamboju@linaro.org>, Ido Schimmel
 <idosch@nvidia.com>, stable@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <ff870428-6375-4125-83bd-fc960b3c109b@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ff870428-6375-4125-83bd-fc960b3c109b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/24 11:21, Matthieu Baerts wrote:
> Hello LKFT maintainers, CI operators,
> 
> First, I would like to say thank you to the people behind the LKFT
> project for validating stable kernels (and more), and including some
> Network selftests in their tests suites.
> 
> A lot of improvements around the networking kselftests have been done
> this year. At the last Netconf [1], we discussed how these tests were
> validated on stable kernels from CIs like the LKFT one, and we have some
> suggestions to improve the situation.
> 
> 
> KSelftests from the same version
> --------------------------------
> 
> According to the doc [2], kselftests should support all previous kernel
> versions. The LKFT CI is then using the kselftests from the last stable
> release to validate all stable versions. Even if there are good reasons
> to do that, we would like to ask for an opt-out for this policy for the
> networking tests: this is hard to maintain with the increased
> complexity, hard to validate on all stable kernels before applying
> patches, and hard to put in place in some situations. As a result, many
> tests are failing on older kernels, and it looks like it is a lot of
> work to support older kernels, and to maintain this.
> 

This is from the Documentation/dev-tools/kselftest.rst:
----
Kselftest from mainline can be run on older stable kernels. Running tests
from mainline offers the best coverage. Several test rings run mainline
kselftest suite on stable releases. The reason is that when a new test
gets added to test existing code to regression test a bug, we should be
able to run that test on an older kernel. Hence, it is important to keep
code that can still test an older kernel and make sure it skips the test
gracefully on newer releases.
----

As it states, running tests from mainline increases the coverage when new
tests are added to regression test an existing kernel feature in a stable
release.

It also says that when mainline tests are running on an older kernel, the
test should detect missing features and report skips.

The above paragraph addresses test developers and users. I would say the
policy regarding the test development will not change. We want to keep
it the same, continuing to take measures to skip tests when a feature
isn't supported in the kernel the tests are running on. This addresses
not just a kernel and test revision mismatch, but also when a feature
isn't enabled when kernel and test revisions match.

This policy helps us find bugs in the tests failing when they should
skip. If test rings move to a new policy, our ability to find bugs
like this goes down.

As per users and test ring maintainers, they need to be aware of the
reduced coverage if they revision match kernel and tests.
Revision matching example: 6.11.8 tests on 6.11.8 stable

Greg KH and other stable maintainers can weigh in on whether they would
like LKFT to go from running mainline tests on stable releases to
revision matching.

> Many networking tests are validating the internal behaviour that is not
> exposed to the userspace. A typical example: some tests look at the raw
> packets being exchanged during a test, and this behaviour can change
> without modifying how the userspace is interacting with the kernel. The
> kernel could expose capabilities, but that's not something that seems
> natural to put in place for internal behaviours that are not exposed to
> end users. Maybe workarounds could be used, e.g. looking at kernel
> symbols, etc. Nut that doesn't always work, increase the complexity, and
> often "false positive" issue will be noticed only after a patch hits
> stable, and will cause a bunch of tests to be ignored.
> 
> Regarding fixes, ideally they will come with a new or modified test that
> can also be backported. So the coverage can continue to grow in stable
> versions too.
> 

The assumption that new tests can be backported is incorrect. It goes
against the stable rules. We backport fixes and not new features and
new tests.

Running kselftests from the same release will reduce coverage when a new
test is added to regression test a 6.11 feature. This happens more often
than not.
Revision matching example: 6.11.8 tests on 6.11.8 stable

  
> Do you think that from the kernel v6.12 (or before?), the LKFT CI could
> run the networking kselftests from the version that is being validated,
> and not from a newer one? So validating the selftests from v6.12.1 on a
> v6.12.1, and not the ones from a future v6.16.y on a v6.12.42.
> 

It is expected that there will be more skipped tests as you run tests
from mainline on stable releases. You will see more skips on older
stables.

An alternative would be to revision match for older stables. New tests
could be written for 6.12 which should be run on 6.11 and maybe not on
6.1 depending on missed coverage.

Before changing the current approach, it is important to understand that
running mainline tests on stable releases increases test coverage and that
newer tests will not be backported and that the coverage gap will increase
overtime.

thanks,
-- Shuah

