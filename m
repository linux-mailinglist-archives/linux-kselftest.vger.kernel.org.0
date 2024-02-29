Return-Path: <linux-kselftest+bounces-5655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2D986CE8B
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 17:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361C41C2169C
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 16:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3292A757EC;
	Thu, 29 Feb 2024 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SLOHzFi/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6940370AEA;
	Thu, 29 Feb 2024 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709222218; cv=none; b=L4WML5I7oIfA7Fb/8xNC45pYRZaa2Ov3JFx5905+Y50EG2GwoZICdZWkAQNZH6w+ws8bpQzaq0EDtWje3hq3tZy5ch7ELDv0C03lPLLvUA/BK3DO9ZBaFgC2Yf+eCnbevugiqOGWmWStlVWiIjypRyiMRwWh3pr+oTUxVz+/Xa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709222218; c=relaxed/simple;
	bh=5MqajYlBTM2LyYGI8UKIlYOD9w76TbGbBDQ6lJ9+XIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=emmj/c7Kj1xVIg93AWFHXB/sxjjqhwaMWblJg6l0l9haHjYLyrF7xpDXn9kWIdPzrI6Gcnn9sLP9z1JtxL5g3b4kN+EdTHNtzQBLm8ctbCCNijoZrFh0yD2j2F1VTRTfylFe0WTDAOY0sXZH2cXF/46TU3ToZDpRAG1wgHqoyq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SLOHzFi/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709222214;
	bh=5MqajYlBTM2LyYGI8UKIlYOD9w76TbGbBDQ6lJ9+XIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SLOHzFi/zyXXDMV/LqPpin3I1xwtXEQwW7aJgazuhKXrn8L43/zthAJlXMPYgl4Z6
	 ve+OrsmMFl1hqmD1YoF/5wcUCTbLDw2NZ29lRB5N/2X0ZMf8KWdKzpZDkuR+KXMvvV
	 A3WdWjWnSjsZ9BVbz4uKWXDZXMfryye6R5LAXgTk4lpC5I8ImiyN3RcxTSanWpnzXM
	 F2pW5gqDnqMNalRqOxEAE1zQS0zuw7/3o5u/5vuZbIqkTCq1lZ3GJtzr97gZ7iXbuN
	 B+NOkXrX50lbXnPVf1jhVkEQovzTY6ZzcZ6KgZypeOqdiOjc+54iVwStTF5ZISknv1
	 kYCmilskX/1Cw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 77DD337810EF;
	Thu, 29 Feb 2024 15:56:52 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: skhan@linuxfoundation.org
Cc: a.hindborg@samsung.com,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	kernel@collabora.com,
	kernel@valentinobst.de,
	laura.nao@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	sergio.collado@gmail.com,
	shuah@kernel.org,
	usama.anjum@collabora.com,
	wedsonaf@gmail.com
Subject: Re: [PATCH v4] kselftest: Add basic test for probing the rust sample modules
Date: Thu, 29 Feb 2024 16:57:11 +0100
Message-Id: <20240229155711.264231-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <5df7d5b1-1387-41f5-a9e9-29c9aefa448e@linuxfoundation.org>
References: <5df7d5b1-1387-41f5-a9e9-29c9aefa448e@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shuah,

On 2/28/24 01:01, Shuah Khan wrote:
> Hi Laura,
> 
> On 2/26/24 03:16, Laura Nao wrote:
>> Add new basic kselftest that checks if the available rust sample modules
>> can be added and removed correctly.
>>
>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>> Reviewed-by: Sergio Gonzalez Collado <sergio.collado@gmail.com>
>> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Depends on:
>> - 
>> https://lore.kernel.org/all/20240102141528.169947-1-laura.nao@collabora.com/T/#u
>> - 
>> https://lore.kernel.org/all/20240131-ktap-sh-helpers-extend-v1-0-98ffb468712c@collabora.com/
>> Changes in v4:
>> - Added config file
>> Changes in v3:
>> - Removed useless KSFT_PASS, KSFT_FAIL, KSFT_SKIP constants
>> - Used ktap_finished to print the results summary and handle the 
>> return code
>> Changes in v2:
>> - Added missing SPDX line
>> - Edited test_probe_samples.sh script to use the common KTAP helpers file
>> ---
>>   MAINTAINERS                                   |  1 +
>>   tools/testing/selftests/Makefile              |  1 +
>>   tools/testing/selftests/rust/Makefile         |  4 +++
>>   tools/testing/selftests/rust/config           |  5 +++
>>   .../selftests/rust/test_probe_samples.sh      | 34 +++++++++++++++++++
>>   5 files changed, 45 insertions(+)
>>   create mode 100644 tools/testing/selftests/rust/Makefile
>>   create mode 100644 tools/testing/selftests/rust/config
>>   create mode 100755 tools/testing/selftests/rust/test_probe_samples.sh
>>
> 
> I ran test again and I still see the same. I would like to
> see the script to handle error conditions.
> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>>
>> +
>> +DIR="$(dirname "$(readlink -f "$0")")"
>> +
>> +source "${DIR}"/../kselftest/ktap_helpers.sh
> 
> It tries to source and keeps going. Why can't we test for
> the file to exist and skip gracefully without printing
> the following messages.
> 
>   ./test_probe_samples.sh: line 12: 
> /linux/linux_6.8/tools/testing/selftests/rust/../kselftest/ktap_helpers.sh: No such file or director
> # ./test_probe_samples.sh: line 16: ktap_print_header: command not found
> # ./test_probe_samples.sh: line 18: ktap_set_plan: command not found
> # ./test_probe_samples.sh: line 22: ktap_test_skip: command not found
> # ./test_probe_samples.sh: line 22: ktap_test_skip: command not found
> # ./test_probe_samples.sh: line 34: ktap_finished: command not found
> 
> 
> 
> not ok 1 selftests: rust: test_probe_samples.sh # exit=127
> 
> 

Sorry, I misunderstood the request in your previous reply on v3 - will 
do.

>> +
>> +rust_sample_modules=("rust_minimal" "rust_print")
>> +
>> +ktap_print_header
>> +
>> +ktap_set_plan "${#rust_sample_modules[@]}"
>> +
>> +for sample in "${rust_sample_modules[@]}"; do
>> +    if ! /sbin/modprobe -n -q "$sample"; then
>> +        ktap_test_skip "module $sample is not found in 
>> /lib/modules/$(uname -r)"
>> +        continue
> 
> Why are we continuing here? Isn't this skip condition?
>

At first, I hadn't planned for the kselftest to skip entirely if only
one of the two sample modules was missing. However, considering that 
this kselftest is designed to test all available sample modules, and 
given that both are enabled with the provided configuration file, I 
believe it's more logical to verify the presence of both modules before 
running the test. If either of them is missing, then we exit the test 
with a skip code. This also covers the case where rust is not available.

>> +    fi
>> +
>> +    if /sbin/modprobe -q "$sample"; then
>> +        /sbin/modprobe -q -r "$sample"
>> +        ktap_test_pass "$sample"
>> +    else
>> +        ktap_test_fail "$sample"
>> +    fi
>> +done
>> +
>> +ktap_finished
> 
> 
> I would like to see the test exit with skip code when RUST isn't
> enabled. Please refer to existing tests that do this properly.
> 

Sent a v5 with the changes mentioned above: https://lore.kernel.org/linux-kselftest/20240229155235.263157-1-laura.nao@collabora.com/T/#u

Thanks!

Laura

