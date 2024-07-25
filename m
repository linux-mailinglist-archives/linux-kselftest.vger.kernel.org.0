Return-Path: <linux-kselftest+bounces-14234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3378293C361
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 15:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64CA11C216D5
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 13:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0216619D07A;
	Thu, 25 Jul 2024 13:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k/o2ryKA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50CB19B5A6;
	Thu, 25 Jul 2024 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721915557; cv=none; b=MICRCl56nJNt3lpVVOrliK3Yr5809ZHj7fHkeb0qjU0xCzUf4wHZIZN7a7O2cmwDG9iZc45KtKU/hfmROSiJz0kRnIleIleiIJfUQrb32EByTt11ofKHvFDLHKmJTe9bIXrCnj3b49Cui1U0eCZDYdLea87Zy2gkIWGUTLlZ5OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721915557; c=relaxed/simple;
	bh=oeXA+JJTnK0Era8Y+Pw0D02FHnvmm599KsmhRAvwHJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xj6UoNVNczT+gKlZPexIRmKkXPDUxXCZLOkeUA9PO9j+S1FkpubUNQLreUj+3qzaIEaEk+qOOX71jp0sjiMtxwEYu2rAYTW1PuMkZpoGnU9yVGUbWlTfi5+EGh4KW/XAltAXGMIFvyg9HfnQNajv8G4IRMCk8CmlqLG9T1cLvNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k/o2ryKA; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A9D822000B;
	Thu, 25 Jul 2024 13:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721915553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=82Al0sPEZdS4t7rN57VPIR42+MxT3sjYqEuVz/Qs2Xc=;
	b=k/o2ryKAmKDcaGvTD+5k8DYKdLqF58lv32hu5Nl5xm4TtQPFad+kszn5JoXfpjYtMtIKqM
	RMebd23Prd1+HvBMukIm+/busPZU3MHpRNW2yKgoVFAD7zHtNxIKpfJif56gWd0GhlooO2
	87l8OL40bSkVPhYbqPqXSJZPmkyV4sPsFSlOqR41gvo/Rnb3Wfr3VfYmzUI+nE68jBPMGA
	GOtY3UZ89MNgMT7BQ86Loq7yEczv5qanofS/p6davYTlJT4FEB8sjX7Xm3NYjbcrvT0xhH
	MIyd4HWx+d+x2jLqNE4FADzV0wxxTkoYRzLbgChQNTEaN7jlKeiPuSwKjIrm0g==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 25 Jul 2024 15:51:11 +0200
Subject: [PATCH 3/3] selftests/bpf: add wrong type test to cgroup dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240725-convert_dev_cgroup-v1-3-2c8cbd487c44@bootlin.com>
References: <20240725-convert_dev_cgroup-v1-0-2c8cbd487c44@bootlin.com>
In-Reply-To: <20240725-convert_dev_cgroup-v1-0-2c8cbd487c44@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

Current cgroup_dev test mostly tests that device operation is accepted or
refused base on passed major/minor (and so, any operation performed during
test involves only char device)

Add a small subtest ensuring that the device type passed to bpf program
allows it to take decisions as well.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 tools/testing/selftests/bpf/prog_tests/cgroup_dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c b/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c
index 5112b99213ad..f0b6e5d9604b 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c
@@ -101,6 +101,9 @@ void test_cgroup_dev(void)
 	if (test__start_subtest("allow-mknod"))
 		test_mknod("/dev/test_dev_cgroup_null", S_IFCHR, 1, 3, 0);
 
+	if (test__start_subtest("deny-mknod-wrong-type"))
+		test_mknod("/dev/test_dev_cgroup_null_block", S_IFBLK, 1, 3, 1);
+
 	if (test__start_subtest("allow-read"))
 		test_read("/dev/urandom", 0);
 

-- 
2.45.2


