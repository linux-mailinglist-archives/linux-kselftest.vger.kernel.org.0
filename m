Return-Path: <linux-kselftest+bounces-48912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E91BD1D564
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 10:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AC3F3051C54
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 08:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7F63803D2;
	Wed, 14 Jan 2026 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ba5S0DKy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B4D37F8DD;
	Wed, 14 Jan 2026 08:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381180; cv=none; b=Gnmba53vCqbkE03yNmwZsEebMoHyjWp2g7zABdTfXcw+eUErQDYt99QTl8To8R1VwM2VReRXrfO4uB7w3yY25xzrdBfkvBW5fHiKWOZ/H5VWGplNBHGLhvzjEb7vG7gfqzmWLMySU0LE9VLvG5bXSFa5PlsZxwneD6yJRWkMlvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381180; c=relaxed/simple;
	bh=jfPUqQWJZGU7oG961vK3ZEupMQb+g/O94lcjCffp6XU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fUDQRMwPPUiobfdRO5WGPYzzQ2H7OVutrPlhZ3vVTNs4sm0bk/2f4e1J35CDn1Rahe5JbfNZyxm4YB4S1KuHy+N67WFBxeBOEw0EAigqVVKQ8S6DyUVzRYERIWcvAm1S2SAexPSUcjd1KUTflJ/Zg7DB6A9zzDdK5AqxkbPEEnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ba5S0DKy; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DA8C21A27E1;
	Wed, 14 Jan 2026 08:59:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id ADC8B6074A;
	Wed, 14 Jan 2026 08:59:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 629C4103C837F;
	Wed, 14 Jan 2026 09:59:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768381172; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=CIZkjM+GKPvZOdvW+Eej6zqqEW+j2hg9Gu+RLdmF8KU=;
	b=Ba5S0DKyFhwErG2v3M4yxWon9i1wcixUGx7nMFLxqGhXSIMuEafc0Lzob9RxX3kNSjlCcj
	djwiBMJvHrGZBTRRSaMkx0GkqfHDgjTLqlq6bvawl2S/K+dlCIrUjbE6klyJhOE2ilLyq0
	VdUg5f2wE8Vahe1dAD+YUlLgajex0xEC4vNj7FhRQwD5BkEnvval5TH9C+hAwdqc5U7pxP
	vkRuzKgyZyjGyHSa9Q4KzrzINHBYaE28/RDy3h40MHGVI2MQgGO4Znvqxb/VP9aVzI50/t
	H3X3DP2rt5Lm7VctYXITN5MpEeu0Q1vSeLuEoTq8XtQAj7OC2/tuP0R0BUWnUg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf-next 0/4] selftests/bpf: add a new runner for bpftool
 tests
Date: Wed, 14 Jan 2026 09:59:11 +0100
Message-Id: <20260114-bpftool-tests-v1-0-cfab1cc9beaf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7biGlIvpKdEhbayE0XIlA/HvSc
 WBmMghFJoG5yRDpYeHgK6i2AXtu/iDkvTLoTg9KK43mdimECxNJEjRGjYPtrSUzQW3uSI7f/7d
 AVdHTm2At5QMLdWl9aQAAAA==
X-Change-ID: 20251212-bpftool-tests-bb165c4cceb8
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
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Hello,
this series is part of the larger effort aiming to convert all
standalone tests to the CI runners so that they are properly executed on
patches submission.

Some of those tests are validating bpftool behavior(test_bpftool_map.sh,
test_bpftool_metadata.sh, test_bpftool_synctypes.py, test_bpftool.py...)
and so they do not integrate well in test_progs. This series proposes to
introduce a new runner to support those tests. This new runner is
heavily inspired from test_progs, with slightly less features.

- First commit move the assert macros exposed by test_progs into a
  shared header so that they can be used by the new runner
- Second commit introduces the new runner, as well as a first test
- Third commit adds a second test
- Fourth commit drops the legacy scripts corresponding to those new
  tests

The series only adds the runner, but it is not enough to have it running
in CI. The github actions need to be updated both in [1] and [2], and I
am not sure how it si supposed to be contributed (the part needed in [1]
must likely be integrated in the commit that is systematically brought
on top of the bpf-next_base branch). Still, an example of test_bpftool
run can be found in [3], in which I have forked and updated the needed
Github actions ([4])

[1] https://github.com/kernel-patches/bpf.git
[2] https://github.com/libbpf/ci
[3] https://github.com/kernel-patches/bpf/pull/10711
[4] https://github.com/Tropicao/libbpf-ci

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Alexis Lothoré (eBPF Foundation) (4):
      bpf/selftests: move assert macros into a dedicated header
      bpf/selftests: introduce bptool test runner and a first test
      selftests/bpf: add bpftool map manipulations tests
      selftests/bpf: remove converted bpftool test scripts

 tools/testing/selftests/bpf/.gitignore             |   1 +
 tools/testing/selftests/bpf/Makefile               |  16 +-
 tools/testing/selftests/bpf/assert_helpers.h       | 231 ++++++++++++
 tools/testing/selftests/bpf/bpftool_helpers.c      | 114 ++++++
 tools/testing/selftests/bpf/bpftool_helpers.h      |  19 +
 .../testing/selftests/bpf/bpftool_tests/.gitignore |   2 +
 .../bpf/bpftool_tests/bpftool_maps_access.c        | 370 +++++++++++++++++++
 .../selftests/bpf/bpftool_tests/bpftool_metadata.c | 128 +++++++
 tools/testing/selftests/bpf/test_bpftool.c         | 126 +++++++
 tools/testing/selftests/bpf/test_bpftool.h         |  36 ++
 tools/testing/selftests/bpf/test_bpftool_map.sh    | 398 ---------------------
 .../testing/selftests/bpf/test_bpftool_metadata.sh |  85 -----
 tools/testing/selftests/bpf/test_progs.h           | 226 +-----------
 13 files changed, 1041 insertions(+), 711 deletions(-)
---
base-commit: 807cd0dc688b0e7314f53dc3a594f247bb3b665b
change-id: 20251212-bpftool-tests-bb165c4cceb8

Best regards,
-- 
Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>


