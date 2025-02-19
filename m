Return-Path: <linux-kselftest+bounces-27012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD2CA3C903
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 20:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8707A3A9421
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 19:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3040022A813;
	Wed, 19 Feb 2025 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Rw88Z40g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3434E1B0F33;
	Wed, 19 Feb 2025 19:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739994133; cv=none; b=TnAVxSkposQyXfnNXF5zKEnoSwRH8ZKIaQK7kWweCBEXO+eO1rCL70rQ4tPej0g2ilo+hxnctliZiYaGreW5d2sHRatDsPGJQ5CWKwGmtcRNHi6F/jieMhleaZaY1NO2Qs31w2yIR/iglBMHd2v1xmGDMrcBu7oBSu4ON3AmF1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739994133; c=relaxed/simple;
	bh=jpDV+E4FWsQEf6WnMfXYCuqqpKYDdvTvL7ljXSS8Tos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZNQkvMbap0XW602u7Zfg1UheAhdaGozDOkzGyIQLlaA6J1G3jTpxhpV0mN3jvgaOc+EUibF2Gt7RAvw4VeImrj4KyZHakT9TVU3x2sqbQMytNxz/H8sI9GllAlJiMpGxLTJByFoAR2aLV72ZDZ7KXHUh7TEgTVPjKGnoNi3S3zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Rw88Z40g; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4E166442D1;
	Wed, 19 Feb 2025 19:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739994122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Qu8bmC+bJMdyIbAzv6s6vSAzbmr6QSn1AGgHeToUVqk=;
	b=Rw88Z40gvyY5CqmwimK116YrV7tj5ntXdd7LTq0BemhllU/nDMfdQlbs4Ta2Ula/8NzVie
	ee07DdK4bNv3mdAxvsPzOYfMcp7RnOQU+D7mjOq7ga9ZtG+GLAIEVjOI6piQ+P+UQ7Zsc1
	/9mTBcXJLYbPLY/JFlGJPg2Y+pkEtNzWpmPziHXVGuyXRcOz+jf7/+j2v79j4XKnUh3NjE
	mC5RjZ8QfshPUC2qHzsHgsQwZyWNbb8E+6Fdv4+xobZCi+RIDiOg45iWgDMx+lz/oSzope
	XMW7+OEojQjfUaXPL0OZ0C1J/Ld0okk7zInXhCVhRdaKJqSvZIPv6BjKVtg97g==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 19 Feb 2025 20:41:39 +0100
Subject: [PATCH] selftests/bpf: DENYLIST.aarch64: enable kprobe_multi tests
 for ARM64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250219-enable_kprobe_multi_tests-v1-1-faeec99240c8@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAPIztmcC/x3MQQqDMBBG4avIrBvQhJTWq0gJmvxtBzVKJpaCe
 HeDy2/x3k6CxBBqq50Sfiy8xILmVpH/9vEDxaGYdK1trZunQuyHCW5c0zLAzduU2WVIFuUfwRp
 j7rA+UOnXhDf/r3f3Oo4TDjmk/WsAAAA=
X-Change-ID: 20250219-enable_kprobe_multi_tests-c8d53336e5cd
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeihedufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtkeertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrroculdgvuefrhfcuhfhouhhnuggrthhiohhnmdcuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepjefghfeiudduffetfeehueduffdtteeigeehvdeludetueffvedvfedttdekieevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehpdhhvghloheplgduledvrdduieekrddurdduleejngdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvhdprhgtphhtthhop
 ehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsughfsehfohhmihgthhgvvhdrmhgvpdhrtghpthhtohepvggsphhfsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvth
X-GND-Sasl: alexis.lothore@bootlin.com

The kprobe_multi feature was disabled on ARM64 due to the lack of fprobe
support.

The fprobe rewrite on function_graph has been recently merged and thus
brought support for fprobes on arm64.  This then enables kprobe_multi
support on arm64, and so the corresponding tests can now be run on this
architecture.

Remove the tests depending on kprobe_multi from DENYLIST.aarch64 to
allow those to run in CI. CONFIG_FPROBE is already correctly set in
tools/testing/selftests/bpf/config

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
The tests being enabled with this series have been run locally in an
ARM64 qemu environment, and in Github CI.

I only did some testing to ensure that the tests depending on kprobe_multi
now run correctly on arm64, it is fair to stress that all the hard
work has actually been done by M. Hiramatsu ([0])

[0] https://lore.kernel.org/bpf/173518987627.391279.3307342580035322889.stgit@devnote2/
---
 tools/testing/selftests/bpf/DENYLIST.aarch64 | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
index 901349da680fa67896d279d184db78e964d9ae27..6d8feda27ce9de07d77d6e384666082923e3dc76 100644
--- a/tools/testing/selftests/bpf/DENYLIST.aarch64
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -1,12 +1,3 @@
-bpf_cookie/multi_kprobe_attach_api               # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
-bpf_cookie/multi_kprobe_link_api                 # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
-kprobe_multi_bench_attach                        # needs CONFIG_FPROBE
-kprobe_multi_test                                # needs CONFIG_FPROBE
-module_attach                                    # prog 'kprobe_multi': failed to auto-attach: -95
 fentry_test/fentry_many_args                     # fentry_many_args:FAIL:fentry_many_args_attach unexpected error: -524
 fexit_test/fexit_many_args                       # fexit_many_args:FAIL:fexit_many_args_attach unexpected error: -524
 tracing_struct/struct_many_args                  # struct_many_args:FAIL:tracing_struct_many_args__attach unexpected error: -524
-fill_link_info/kprobe_multi_link_info            # bpf_program__attach_kprobe_multi_opts unexpected error: -95
-fill_link_info/kretprobe_multi_link_info         # bpf_program__attach_kprobe_multi_opts unexpected error: -95
-fill_link_info/kprobe_multi_invalid_ubuff        # bpf_program__attach_kprobe_multi_opts unexpected error: -95
-missed/kprobe_recursion                          # missed_kprobe_recursion__attach unexpected error: -95 (errno 95)

---
base-commit: d3417ac824b98e8773bc04b93e09c4b93c2c6cad
change-id: 20250219-enable_kprobe_multi_tests-c8d53336e5cd

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


