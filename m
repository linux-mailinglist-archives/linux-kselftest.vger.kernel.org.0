Return-Path: <linux-kselftest+bounces-2568-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD83821D97
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 15:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54F8FB20BD4
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 14:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF62010958;
	Tue,  2 Jan 2024 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="weIcn7xk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C3610A38;
	Tue,  2 Jan 2024 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704205506;
	bh=Q5TdwinC73cuLXTCvLj5CDlQo+9OecSMtSDZry2sjzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=weIcn7xkvss+5cT8YbmlvI9kaLv3IXYiZqPrcT7fbBhWCWRfH9G+MEbyaveoQ6VjD
	 ONQDn/J9BCwAS+0yRCSDrrCRxx0F7FJF7+tc3SP0RKtGfo8INbtSfo/ir4TgkU2pvL
	 2W+Uo4bdDYCvDzC+dpYVma9TZqCI6nDXbqKbzUL14AgCmq6soS/I9WupsLcaYeSbUl
	 LaPZsudHfExfuC1ConJgK42s4fvl513IQ0BB6MV94AR4vV3L6nQnX/a0kayqmxHEpK
	 yds5JOomKx0hLDdI/LtWwIw6OjVaAR55dBIowPiS08S2kBwwtZWJJDLZka8LBk4MqP
	 7VNCJCKtubqtA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5F52437802F2;
	Tue,  2 Jan 2024 14:25:05 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: a.hindborg@samsung.com,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	davidgow@google.com,
	gary@garyguo.net,
	kernel@collabora.com,
	laura.nao@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	shuah@kernel.org,
	wedsonaf@gmail.com
Subject: Re: [PATCH] kselftest: Add basic test for probing the rust sample modules
Date: Tue,  2 Jan 2024 15:25:14 +0100
Message-Id: <20240102142514.174562-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANiq72nAZ53fjsaMk8iYTwtqbvGo3LrTCpBCrh4zx6xLOFBP9w@mail.gmail.com>
References: <CANiq72nAZ53fjsaMk8iYTwtqbvGo3LrTCpBCrh4zx6xLOFBP9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/21/23 20:46, Miguel Ojeda wrote:
> On Fri, Dec 15, 2023 at 2:21 PM Laura Nao <laura.nao@collabora.com>
> wrote:
>>
>> Add new basic kselftest that checks if the available rust sample
>> modules
>> can be added and removed correctly.
>>
>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> 
> Thanks Laura!
> 
> Shuah: do you want that we pick this one? If so, your `Acked-by` would
> be nice -- thanks! Otherwise, please feel free to pick it up.
> 
> Cc'ing David too since it involves KTAP in case he has comments.
> 
>> diff --git a/tools/testing/selftests/rust/Makefile
>> b/tools/testing/selftests/rust/Makefile
> 
> Missing SPDX line? (it can be added when picking it up, though).
> 

Thanks for the feedback Miguel!

>> +$(OUTPUT)/ktap_helpers.sh:
>> +       cp $(top_srcdir)/tools/testing/selftests/dt/ktap_helpers.sh
>> $@
> 
> This may be something for another series, but should these helpers be
> factored out perhaps / provided by the framework? Does it work
> sourcing them from `dt` directly instead of copying meanwhile (to
> simplify)?
> 
>> +KSFT_PASS=0
>> +KSFT_FAIL=1
>> +KSFT_SKIP=4
> 
> Similarly, would it make sense for this kind of "common constants" be
> factored somehow? Or does that not make sense (I see other tests also
> define them "manually")?
> 

Sourcing the file from the `dt` folder does work when running the test
with `make -C tools/testing/selftests TARGETS=rust run_tests`, but fails
when the test is installed with `make -C tools/testing/selftests
TARGETS=rust install` and run with
`./tools/testing/selftests/kselftest_install/run_kselftest.sh` (unless
the dt kselftest is installed too).

I agree factoring out the helpers might be a better solution. I sent a
patch to move the ktap_helpers.sh file to the kselftest common
directory, so that kselftests written in bash can make use of the helper
functions more easily:

https://lore.kernel.org/linux-kselftest/20240102141528.169947-1-laura.nao@collabora.com/T/#u

If that patch is merged first, I'll rework this one and send a v2 with
the proper adjustments.

Best,

Laura 

