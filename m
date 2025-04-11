Return-Path: <linux-kselftest+bounces-30619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0874A8672E
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 22:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A9061B63DCA
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 20:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B075280CE6;
	Fri, 11 Apr 2025 20:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oPx3ze9z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD4E238150;
	Fri, 11 Apr 2025 20:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744403549; cv=none; b=r83GBejnjeY9tehWkBxM6oLWm7gGcexaXgdPLb5OJOdkHzty9MzzsDs0LFYOblwDsTihvXfHuyu0hXlr04uu/X0d8r56U3CNb+qswkMT4pJa3sQIgSqpsqfVg3haKWJT1fBGxrZSY6kygrv57SYS+ioFjCZzArndqX09VxbsOwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744403549; c=relaxed/simple;
	bh=Fa8wh9uhC0URoSLFROayn9gryDAur+8EBrlhQk3luFw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=H76ADTjbqdJSZ5XvuKbr+fZ8RAYjnRAxGyxHwfjZrfM95sjQNk+LvgeUSjZ6PzCpCzEj9oVlJ8qcPZIFdpMFksyhrhBwB2RgFcj1h2qzWetwbtRUq8zREuZKxYV4b9iKslf8UxjDtvZuWcw5VLdXgcoor2rlL5u+LNc1QDdmrh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oPx3ze9z; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4BC81439EA;
	Fri, 11 Apr 2025 20:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744403539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bCzKT+ja9Qq6jhqeVqHO2ah17zHLv4bpeMBebgEjtos=;
	b=oPx3ze9zCh1zd9PRfVvpKm6NNY5fsFrG+z93cd9OPNCnCduaa1P+BOncqHqxpgYddOh2Rx
	zpjdUEqZk4PvDyOpeGvTMZOLbiV3EyKYyG123nYkM5wShB6d9H2a8TCrbTQN/XhYAmxlG1
	V9kKHS1kpAU4lSvacr5hJC2SRYVPqzQjyPXcFWWaGoGsfzNLj2hY/YjtOAEGLFijGO68eZ
	bkqd1qgSJJ6hcGvTpkou6fDP7rm3NBYSwrZ5lCwRtUtAECVnwtpEAyOWP4tBMXGQLxYUrP
	1lM5L+DzV7A3ltBe+iAluzS6CPPf2ud27oiPUvOg5R0DYuF0L9x5eI7Ymm+eJQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH RFC bpf-next 0/4] bpf, arm64: support up to 12 arguments
Date: Fri, 11 Apr 2025 22:32:09 +0200
Message-Id: <20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEl8+WcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyMD3dzEvMr4xKL0YiCRa2aia5GUYmxuYp5qZmlioQTUVVCUmpZZATY
 xWinIzRkkllSQppuXWlGiFFtbCwADCrVOcgAAAA==
X-Change-ID: 20250220-many_args_arm64-8bd3747e6948
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 Xu Kuohai <xukuohai@huaweicloud.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Florent Revest <revest@chromium.org>
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 ebpf@linuxfoundation.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>, 
 Xu Kuohai <xukuohai@huawei.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddvjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthekredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhorucdlvgeurffhucfhohhunhgurghtihhonhdmuceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefhtdeggfdvkedvgfejhfefffejkeetffduudffgeekveduffefkeeuuefgueffveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhdplhhinhhugigsrghsvgdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehpdhhvghloheplgduledvrdduieekrddurdduleejngdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedupdhrtghpthhtohepshgufhesfhhomhhitghhvghvrdhmvgdprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidru
 ggvvhdprhgtphhtthhopeiguhhkuhhohhgriheshhhurgifvghitghlohhuugdrtghomhdprhgtphhtthhopehjohhlshgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehmhihkohhlrghlsehfsgdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgtohhquhgvlhhinhdrshhtmhefvdesghhmrghilhdrtghomh
X-GND-Sasl: alexis.lothore@bootlin.com

Hello,

this series is a revival of Xu Kuhoai's work to enable larger arguments
count for BPF programs on ARM64 ([1]). His initial series received some
positive feedback, but lacked some specific case handling around
arguments alignment (see AAPCS64 C.14 rule in section 6.8.2, [2]). There
as been another attempt from Puranjay Mohan, which was unfortunately
missing the same thing ([3]).  Since there has been some time between
those series and this new one, I chose to send it as a new series
rather than a new revision of the existing series.

To support the increased argument counts and arguments larger than
registers size (eg: structures), the trampoline does the following:
- for bpf  programs: arguments are retrieved from both registers and the
  function stack, and pushed in the trampoline stack as an array of u64
  to generate the programs context. It is then passed by pointer to the
  bpf programs
- when the trampoline is in charge of calling the original function: it
  restores the registers content, and generates a new stack layout for
  the additional arguments that do not fit in registers.

This new attempt is based on Xu's series and aims to handle the
missing alignment concern raised in the reviews discussions. The main
novelties are then around arguments alignments:
- the first commit is exposing some new info in the BTF function model
  passed to the JIT compiler to allow it to deduce the needed alignment
  when configuring the trampoline stack
- the second commit is taken from Xu's series, and received the
  following modifications:
  - the calc_aux_args computes an expected alignment for each argument
  - the calc_aux_args computes two different stack space sizes: the one
    needed to store the bpf programs context, and the original function
    stacked arguments (which needs alignment). Those stack sizes are in
    bytes instead of "slots"
  - when saving/restoring arguments for bpf program or for the original
    function, make sure to align the load/store accordingly, when
    relevant
  - a few typos fixes and some rewording, raised by the review on the
    original series
- the last commit introduces some explicit tests that ensure that the
  needed alignment is enforced by the trampoline

I marked the series as RFC because it appears that the new tests trigger
some failures in CI on x86 and s390, despite the series not touching any
code related to those architectures. Some very early investigation/gdb
debugging on the x86 side seems to hint that it could be related to the
same missing alignment too (based on section 3.2.3 in [4], and so the
x86 trampoline would need the same alignment handling ?). For s390 it
looks less clear, as all values captured from the bpf test program are
set to 0 in the CI output, and I don't have the proper setup yet to
check the low level details.  I am tempted to isolate those new tests
(which were actually useful to spot real issues while tuning the ARM64
trampoline) and add them to the relevant DENYLIST files for x86/s390,
but I guess this is not the right direction, so I would gladly take a
second opinion on this.

[1] https://lore.kernel.org/all/20230917150752.69612-1-xukuohai@huaweicloud.com/#t
[2] https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst#id82
[3] https://lore.kernel.org/bpf/20240705125336.46820-1-puranjay@kernel.org/
[4] https://refspecs.linuxbase.org/elf/x86_64-abi-0.99.pdf

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Alexis Lothoré (eBPF Foundation) (3):
      bpf: add struct largest member size in func model
      bpf/selftests: add tests to validate proper arguments alignment on ARM64
      bpf/selftests: enable tracing tests for ARM64

Xu Kuohai (1):
      bpf, arm64: Support up to 12 function arguments

 arch/arm64/net/bpf_jit_comp.c                      | 235 ++++++++++++++++-----
 include/linux/bpf.h                                |   1 +
 kernel/bpf/btf.c                                   |  25 +++
 tools/testing/selftests/bpf/DENYLIST.aarch64       |   3 -
 .../selftests/bpf/prog_tests/tracing_struct.c      |  23 ++
 tools/testing/selftests/bpf/progs/tracing_struct.c |  10 +-
 .../selftests/bpf/progs/tracing_struct_many_args.c |  67 ++++++
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |  50 +++++
 8 files changed, 357 insertions(+), 57 deletions(-)
---
base-commit: 91e7eb701b4bc389e7ddfd80ef6e82d1a6d2d368
change-id: 20250220-many_args_arm64-8bd3747e6948

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


