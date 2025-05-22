Return-Path: <linux-kselftest+bounces-33502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E82AC0993
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 12:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54BCF1BA45DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 10:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08348288C9E;
	Thu, 22 May 2025 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U5kiFUO6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79E2288CBE;
	Thu, 22 May 2025 10:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747908911; cv=none; b=tRR7wYG3avkDAdo1Crc5sECYSoT1tA9X2J3ARC4UrcsIy/poY8bzFpro6i1jBMf+XWJPgC6EZBvREFF93MAWScGUoWh2ZpWpro0q8n0j2Tv11eMsxZz2O89/qOtSYywxWxFLOhsXPmFCQtKsqke1kmPNyhFF3jIz0CsUt5mUR1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747908911; c=relaxed/simple;
	bh=Mp5hhsQk/BVM8idJglUG8IKK6i/o1HxpuCiN2vWcKrg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g4YkfDzVZyn2mpmBF2bzPJkrs39ogqQbPWUSm4PHSRdxMpvpgEQBWdzbbfOh1qLrXbpCcksGie+W1ZHumDci0ga1ai/WUiQXYoe3k65qCaFDM5V5hXfkOwTtLw9cGMYXin/NFUguZ+USb3oRWRIVguH26XlkY/aXNOmPVsEbTX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U5kiFUO6; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 561DC1FCEF;
	Thu, 22 May 2025 10:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747908907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+r7J1xhws6aDU6U1m+dl2K9Zh5x/cHIxtpt6U5qcUxs=;
	b=U5kiFUO6++yJX3ypo91Fl4X7mUP9Sa/hCyWHKJxXAIUJzA0hGe62i5QjAtxHTC6hJPwQMh
	Dmq8nNbv5+Z3TZ2mPxAdW0inOfamKXXS7C2FYZI4fPj/x7mdEl4JcsTBZ0838/iER0w19a
	ww9BPo34dIJzU8eDf9PnZFPG2v0PnK+xzdCTUHpGDn2Xk1mUNVlNEPsI2baCp7PVgoGiwQ
	5LNcZ5y0XduQoK9iu424EtwDNWvJeCiVO+QZq/QC9dpmdUPib1y77bZ99FZ197rJnS9pyU
	sZynPQuN1Sk6Q/fPeeQ6LsWxxhG0Pwa3QSJeLVvB3GmmnZmoC4pc55wsamiOdg==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf-next v2 0/2] bpf, arm64: support up to 12 arguments
Date: Thu, 22 May 2025 12:14:39 +0200
Message-Id: <20250522-many_args_arm64-v2-0-d6afdb9cf819@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAA/5LmgC/2WNywqDMBREf0XuuinJTeqjq/5HkRL1qoGaSBJEE
 f+9IdtuBg7DnDkhkDcU4Fmc4GkzwTibAG8F9LO2EzEzJAbk+OCInC3aHh/tp5BiKRWru0FWqqK
 yUTWk1eppNHs2vqFbR2Zpj9CmZjYhOn/kq03kPluVEH/WTTDOuJY4UoVSNvTqnItfY++9W6C9r
 usHhr1ZJ7oAAAA=
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdehieelucdltddurdegfedvrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthekredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhoruceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefffedvleeltdefkeduledvkedvueffudeiveekvdeitdegfeeuhefgvdeutdfhueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrvddungdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedupdhrtghpthhtoheplhhinhhugidqkhhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrt
 ghpthhtohepgihukhhuohhhrghisehhuhgrfigvihgtlhhouhgurdgtohhmpdhrtghpthhtohepjhholhhsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhpshhinhhghheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgihukhhuohhhrghisehhuhgrfigvihdrtghomhdprhgtphhtthhopegvsghpfheslhhinhhugihfohhunhgurghtihhonhdrohhrgh
X-GND-Sasl: alexis.lothore@bootlin.com

Hello,

this is the v2 of the many args series for arm64, being itself a revival
of Xu Kuhoai's work to enable larger arguments count for BPF programs on
ARM64 ([1]).

The discussions in v1 shed some light on some issues around specific
cases, for example with functions passing struct on stack with custom
packing/alignment attributes: those cases can not be properly detected
with the current BTF info. So this new revision aims to separate
concerns with a simpler implementation, just accepting additional args
on stack if we can make sure about the alignment constraints (and so,
refusing attachment to functions passing structs on stacks). I then
checked if the specific alignment constraints could be checked with
larger scalar types rather than structs, but it appears that this use
case is in fact rejected at the verifier level (see a9b59159d338 ("bpf:
Do not allow btf_ctx_access with __int128 types")). So in the end the
specific alignment corner cases raised in [1] can not really happen in
the kernel in its current state. This new revision still brings support
for the standard cases as a first step, it will then be possible to
iterate on top of it to add the more specific cases like struct passed
on stack and larger types.

[1] https://lore.kernel.org/all/20230917150752.69612-1-xukuohai@huaweicloud.com/#t

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v2:
- remove alignment computation from btf.c
- deduce alignment constraints directly in jit compiler for simple types
- deny attachment to functions with "corner-cases" arguments (ie:
  structs on stack)
- remove custom tests, as the corresponding use cases are locked either
  by the JIT comp or the verifier
- drop RFC
- Link to v1: https://lore.kernel.org/r/20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com

---
Alexis Lothoré (eBPF Foundation) (1):
      selftests/bpf: enable many-args tests for arm64

Xu Kuohai (1):
      bpf, arm64: Support up to 12 function arguments

 arch/arm64/net/bpf_jit_comp.c                | 234 ++++++++++++++++++++-------
 tools/testing/selftests/bpf/DENYLIST.aarch64 |   2 -
 2 files changed, 180 insertions(+), 56 deletions(-)
---
base-commit: 9435138c069117cd59a4912b5ea2ae44cc2c5ffa
change-id: 20250220-many_args_arm64-8bd3747e6948

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


