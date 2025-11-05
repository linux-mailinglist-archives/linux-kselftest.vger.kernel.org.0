Return-Path: <linux-kselftest+bounces-44788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8970C34718
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 09:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78608426726
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 08:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA9A285CB6;
	Wed,  5 Nov 2025 08:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0uGmkydb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4B5253B52
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762330983; cv=none; b=Jxpq3GlEY9MHiHBNU8wQRGuA0GwnZl3Cw2v79BwPRM3U+z3XKj7WMKa2gbM9nbbPnoBPZT21I1PeST9ApJGBaUlNDuZxqVd/14i0hDu0uailw8cHJgyN4EDEPE07XT624IB3Pl0qcbPdTyYvYGpEg+iuEU6THgAY2mtX2LNhCpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762330983; c=relaxed/simple;
	bh=LcR2LkXnFWSGBITUBtkwsX5fkKZ+X5d6dkgDfXGDJh8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FmhtkmiJi8jK+agpWpTX2Tojs9WCSii6i6Xy1I9TSzsP5YJVf2kKh2XcPfTxZRGBNHuL6UlunjhYgUEiBXAZtfA7BLYxd6zUJZiPcr42GSvBhp5kpYTF+vkeOShlaTWMxBqu2qEIf4OUMglXIm4h6at2RFVdGNFky38uoR/8fDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0uGmkydb; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AFFEBC0E62F;
	Wed,  5 Nov 2025 08:22:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 99DB460693;
	Wed,  5 Nov 2025 08:22:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1DA5C10B51AE2;
	Wed,  5 Nov 2025 09:22:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762330977; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=ZVBJaTLbdq1MYmCxVHkNfsdDAKKhkahrr7FSCMfrqV4=;
	b=0uGmkydb5ea4FmpHxXp6G7fCGCoDqeNeuz5/RhkZVBZ04xlcbhGRM1etUf0cEk3jJRgVYO
	rBhnTcy+c7C/e8TeJl6d6nzajHMUUwtlBOqPwk1OgovCOKMbN1+MzJ6JnCIOPGEZ59cNbN
	hpHNgZBvmPp2RXZ2HY4TvbauMRI0cNOUuRjYDtATDI6pj/bVMyDsXdBypf3uRry2TnY6UN
	MxgDiAWUctXRBO/dmLSn41qqzczmyfXZnSUKeEmO53Ci52K9g+8kTzYCOUCu67CdS9S4xW
	6NBCJR6YC5oFHt3tl0X4VG5QkwWWP11f5AygmtuokJSoFupRAD0CH1Qjai23iw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf-next 0/2] selftests/bpf: enfoce SO_REUSEADDR in basic
 test servers
Date: Wed, 05 Nov 2025 09:22:47 +0100
Message-Id: <20251105-start-server-soreuseaddr-v1-0-1bbd9c1f8d65@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFcJC2kC/x3MQQrCMBBG4auUWTvQxKmCVxEXqflbZ5OWmVgKp
 Xc3uHyL7x3kMIXTozvIsKnrUlqES0fvTyozWHNrin0cQuiFvSar3NQGY18MX0fK2RgiUeSGmK9
 3anw1TLr/108a14kL9kqv8/wBrg204XQAAAA=
X-Change-ID: 20251104-start-server-soreuseaddr-e442446e2d37
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Hello,
This small series is another follow-up to [1], in which I misunderstood
Martin's initial feedback (see [2]). I proposed to make tc-tunnel apply
SO_REUSEPORT once server is brought up. This series updates
start_server_addr to really apply Martin's proposal after his
clarification [3]

[1] https://lore.kernel.org/bpf/20251031-tc_tunnel_improv-v1-0-0ffe44d27eda@bootlin.com/
[2] https://lore.kernel.org/bpf/efa3540a-1f52-46ca-9f49-e631a5e3e48c@linux.dev/
[3] https://lore.kernel.org/bpf/4cbabdf1-af2c-490a-a41a-b40c1539c1cb@linux.dev/

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Alexis Lothoré (eBPF Foundation) (2):
      selftests/bpf: systematically add SO_REUSEADDR in start_server_addr
      selftests/bpf: use start_server_str rather than start_reuseport_server in tc_tunnel

 tools/testing/selftests/bpf/network_helpers.c      |  9 +++++++-
 .../selftests/bpf/prog_tests/test_tc_tunnel.c      | 27 ++++++++++++----------
 2 files changed, 23 insertions(+), 13 deletions(-)
---
base-commit: de0745f7cc98146c70a020bc3a1b73c7f3405282
change-id: 20251104-start-server-soreuseaddr-e442446e2d37

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


