Return-Path: <linux-kselftest+bounces-22603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8279DB9C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 15:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94A63B20BB9
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 14:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDF31B0F01;
	Thu, 28 Nov 2024 14:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WgbJvPMX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0451AF0A3;
	Thu, 28 Nov 2024 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732804756; cv=none; b=i8IaXZ4mZ08i5S3ueCizoIjkgfTw+RA5lGtI6w1wglBPTSwmIu56wsOe8qkw6V/Uae3eKLX9fO1vwyew9hmni9tttbCAUBZ5Jp8D+DF/gojrCm7R7pmzN1j2EheStj4E7SV5utWwjIDuucejvr913EbIp4uWDIj2B99eZsmkMFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732804756; c=relaxed/simple;
	bh=lICUD5U4v1tYDpWpths86briaf8ss1zHzJxQmZLPJBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Y2tTT7VY5UN5TYMmTdscCc4DwnFhWn5WiWmPvGoao8uBsMoHBbZUSwFfRVWiYrRCVwKVTae5GSpxUtap73j76guEcFUIFUXaFAZ2UXVYCsrSRORr8QR9CpRH5JSQ5F0/R0ww+l/9pQMdVky5Okkbv6kkg+1MsMioPnEBEdvwkx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WgbJvPMX; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 26666FF802;
	Thu, 28 Nov 2024 14:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732804750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uVb9JEDc4YM1KllmCbqlKsdo3gFEbpEVba/VTnbtCyY=;
	b=WgbJvPMXIPkDqIrVsF7QcTxZmwjN9VWhqe4FLAqKVLwKx/Jhmv7b721BTVlphPGAr8I/rh
	DdgyAVP6wf4U8c9n8mcdi8+1M1efj/ia0mWI3+Q4UHmL4rhH/U8ix43cZgnqtD69pCSOa0
	gwl1gfhNgcrh4RQaWPvsIOIvj/AD0UEPqW7d20nYy+mDnIBsfE6BogF78+Ik4xhPSuaN06
	0OwS95oTGNyCgVxauy91MqnSNKf/gRD7NlBLHP6q159kNw+zzz7yzDYH0LLXPaMqkLLZ3H
	OmcP4UHm67dmZpGvIO+folLZB0voWjUeE4lSMg0ZfYKY1T010Rp9ho4lsCwaIA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 28 Nov 2024 15:38:43 +0100
Subject: [PATCH bpf-next] selftests/bpf: ensure proper root namespace
 cleanup when test fail
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241128-small_flow_test_fix-v1-1-c12d45c98c59@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAHKASGcC/x2M0QqEIBAAfyX2OSHNi+hXIsTz1lowC1cqiP79p
 McZmLmBMREyDNUNCQ9i2mIBWVfgFhtnFPQrDKpRWkrVC15tCMaH7TQZORtPl2jcp+2Utq3TDkq
 5Jyz6vY7w3b2IeGWYnucPp+oLoG8AAAA=
X-Change-ID: 20241128-small_flow_test_fix-0c53624a3c4c
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: alexis.lothore@bootlin.com

serial_test_flow_dissector_namespace manipulates both the root net
namespace and a dedicated non-root net namespace. If for some reason a
program attach on root namespace succeeds while it was expected to
fail, the unexpected program will remain attached to the root namespace,
possibly affecting other runs or even other tests in the same run.

Fix undesired test failure side effect by explicitly detaching programs
on failing tests expecting attach to fail. As a side effect of this
change, do not test errno value if the tested operation do not fail.

Fixes: 284ed00a59dd ("selftests/bpf: migrate flow_dissector namespace exclusivity test")
Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
This small fix addresses an issue discovered while trying to add a new
test in my recently merged work on flow_dissector migration. This new
test is still only present in bpf-next, hence this fix does not target
the bpf tree but the bpf-next tree.
---
 tools/testing/selftests/bpf/prog_tests/flow_dissector.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index 8e6e483fead3f71f21e2223c707c6d4fb548a61e..08bae13248c4a8ab0bfa356a34b2738964d97f4c 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -525,11 +525,14 @@ void serial_test_flow_dissector_namespace(void)
 	ns = open_netns(TEST_NS);
 	if (!ASSERT_OK_PTR(ns, "enter non-root net namespace"))
 		goto out_clean_ns;
-
 	err = bpf_prog_attach(prog_fd, 0, BPF_FLOW_DISSECTOR, 0);
+	if (!ASSERT_ERR(err,
+			"refuse new flow dissector in non-root net namespace"))
+		bpf_prog_detach2(prog_fd, 0, BPF_FLOW_DISSECTOR);
+	else
+		ASSERT_EQ(errno, EEXIST,
+			  "refused because of already attached prog");
 	close_netns(ns);
-	ASSERT_ERR(err, "refuse new flow dissector in non-root net namespace");
-	ASSERT_EQ(errno, EEXIST, "refused because of already attached prog");
 
 	/* If no flow dissector is attached to the root namespace, we must
 	 * be able to attach one to a non-root net namespace
@@ -545,8 +548,11 @@ void serial_test_flow_dissector_namespace(void)
 	 * a flow dissector to root namespace must fail
 	 */
 	err = bpf_prog_attach(prog_fd, 0, BPF_FLOW_DISSECTOR, 0);
-	ASSERT_ERR(err, "refuse new flow dissector on root namespace");
-	ASSERT_EQ(errno, EEXIST, "refused because of already attached prog");
+	if (!ASSERT_ERR(err, "refuse new flow dissector on root namespace"))
+		bpf_prog_detach2(prog_fd, 0, BPF_FLOW_DISSECTOR);
+	else
+		ASSERT_EQ(errno, EEXIST,
+			  "refused because of already attached prog");
 
 	ns = open_netns(TEST_NS);
 	bpf_prog_detach2(prog_fd, 0, BPF_FLOW_DISSECTOR);

---
base-commit: 04e7b00083a120d60511443d900a5cc10dbed263
change-id: 20241128-small_flow_test_fix-0c53624a3c4c

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


