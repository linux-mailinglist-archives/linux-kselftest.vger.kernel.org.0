Return-Path: <linux-kselftest+bounces-5434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA3586712E
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 11:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96C71C21AB6
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 10:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590711CD35;
	Mon, 26 Feb 2024 10:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="m1HjNlV1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E14C1CD2F;
	Mon, 26 Feb 2024 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942854; cv=none; b=VYGLR0wN1IW3y6DDLdDVOXtWki0KYvPuhhxTOl7u4yKBNehVk3ZnT8IHCw6etcdRomCbhpXUcOXLBvgYJ7n54604pb5VmUS9vu45u9hT5mujBRQ6UDGDPOBUcU5peIms6XwGutjcJw0BJ9HH8udKl4fCuY65pYhJ7cOZ7tGrxqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942854; c=relaxed/simple;
	bh=Q2Apks4OYwt/Qc7DfjpkV+EOr+jHuzuRd/7l1T5/5ic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GqRd7eXvpLTJn/ugefoCwLiwGpc3l7tJK8CThrnh7fcyUmEmiqSSOu8WmpkjE0s9f1PE5xknTw2f2RA3xdQYyLzYy+kWr3cEb31zqZRc634PYozH2u3egbueR9qQroAGdCJrE5OyPnLAJ/EKD3NjdPakDKhYPWD3Cl+3z+wcQMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=m1HjNlV1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708942850;
	bh=Q2Apks4OYwt/Qc7DfjpkV+EOr+jHuzuRd/7l1T5/5ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m1HjNlV1h5M9Q+csGYfVEh9lZRy2HsPys/cL9B64uvusYZ9QFu0w7uH/e0HHW12kN
	 Xr57jgHXRF/y8881bp5NSnvZtrttw5EOQhcB+/siK4LwM/jYwdFH3O7vMlektEr9qQ
	 DaJcu+DeeYkjR9GE7ufWd1kNcOEanmDJ0yRIwcKZuST2GLEtNQ98bHmvUyPvRPjL/3
	 6dw8m7t9lZhbQMzB6E1O7wyBsqu/dFhSBMAo4H3a50kW/2iLribNexUHwR5UuoxF15
	 6AanHxWs7ABeOLrg1WDVGDOPVyQ08eF2NXNyGENeOP1MIBRgSoGxJGy6wqLtcrPNk1
	 2HHOGUNKWxEoA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 80920378202B;
	Mon, 26 Feb 2024 10:20:49 +0000 (UTC)
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
Subject: Re: [PATCH v3] kselftest: Add basic test for probing the rust sample modules
Date: Mon, 26 Feb 2024 11:21:02 +0100
Message-Id: <20240226102102.292374-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <8fe544e1-ac1c-4edf-81e9-fc0992b6bbc4@linuxfoundation.org>
References: <8fe544e1-ac1c-4edf-81e9-fc0992b6bbc4@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shuah,

On 2/23/24 23:02, Shuah Khan wrote:
> On 2/23/24 14:48, Shuah Khan wrote:
>> On 2/22/24 09:29, Laura Nao wrote:
>>> Add new basic kselftest that checks if the available rust sample modules
>>> can be added and removed correctly.
>>>
>>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>>> Reviewed-by: Sergio Gonzalez Collado <sergio.collado@gmail.com>
>>> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>> Changes in v3:
>>> - Removed useless KSFT_PASS, KSFT_FAIL, KSFT_SKIP constants
>>> - Used ktap_finished to print the results summary and handle the 
>>> return code
>>> Changes in v2:
>>> - Added missing SPDX line
>>> - Edited test_probe_samples.sh script to use the common KTAP helpers 
>>> file
>>> ---
>>>   MAINTAINERS                                   |  1 +
>>>   tools/testing/selftests/Makefile              |  1 +
>>>   tools/testing/selftests/rust/Makefile         |  4 +++
>>>   .../selftests/rust/test_probe_samples.sh      | 34 +++++++++++++++++++
>>>   4 files changed, 40 insertions(+)
>>>   create mode 100644 tools/testing/selftests/rust/Makefile
>>>   create mode 100755 tools/testing/selftests/rust/test_probe_samples.sh
>>>
>>
>> Looks good to me. Don't you need a config file for this test?
>> Refer to config files for existing tests as a reference.
>>

Right, in order for the tests to not be skipped support for rust and its
sample modules need to be enabled.

I added the config file in v4: https://lore.kernel.org/linux-kselftest/20240226101646.291337-1-laura.nao@collabora.com/T/#u

> make kselftest TARGETS=rust
> or
> make run_tests
> 
> On Linux 6.8-rc5 give the following? Doesn't look right.
> 
> TAP version 13
> 1..1
> # timeout set to 45
> # selftests: rust: test_probe_samples.sh
> # ./test_probe_samples.sh: line 12: 
> /linux/linux_6.8/tools/testing/selftests/rust/../kselftest/ktap_helpers.sh: No such file or directory
> # ./test_probe_samples.sh: line 16: ktap_print_header: command not found
> # ./test_probe_samples.sh: line 18: ktap_set_plan: command not found
> # ./test_probe_samples.sh: line 22: ktap_test_skip: command not found
> # ./test_probe_samples.sh: line 22: ktap_test_skip: command not found
> # ./test_probe_samples.sh: line 34: ktap_finished: command not found
> not ok 1 selftests: rust: test_probe_samples.sh # exit=127
> 

This patch requires
https://lore.kernel.org/all/20240102141528.169947-1-laura.nao@collabora.com/T/#u
and
https://lore.kernel.org/all/20240131-ktap-sh-helpers-extend-v1-0-98ffb468712c@collabora.com/
, which are both scheduled for 6.9-rc1. Sorry I didn't mention it above!

Thanks,

Laura


