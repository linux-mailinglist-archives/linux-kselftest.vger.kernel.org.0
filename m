Return-Path: <linux-kselftest+bounces-28906-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AC5A5F140
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 11:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4FB189689B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 10:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277C826560B;
	Thu, 13 Mar 2025 10:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="D6XLiGB1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6FE1FC0E4;
	Thu, 13 Mar 2025 10:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862896; cv=none; b=BhP52Ce7h03XkAsPejZLocoI9EadJG1PlsIvXX0f0Y/VdGhZs2Tp++i3tuJbY7MrQfwzRBkWyNC4i34rX5AEywaSYxUu+e7a+v3mCT6oM6dhKLA59Lpm68vl0v8R1oUI5GsMvjFOw6E0pDn7VLmvfWUyQ8oW28jxDFDuNXa9K8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862896; c=relaxed/simple;
	bh=6Lf1troAP9KqYLhWMFdF9HEEcjTeV97lTmAmZqT/Iys=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UMALSHWUqUoEhi1ZHJub3clIbCvaqmDOFjSO4VbuTB19gByQ/DJgJuUf3a1zVt4ank7iSHzJEX+1NhiKtT8IOrKuedyyRjsgBkgEpNY6Ec965P94v+APIsd+6VmvnE5EYw/dX62V2svNEb54741cA1OPcCmgHUn32NGKfEPfgx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D6XLiGB1; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3BEE543216;
	Thu, 13 Mar 2025 10:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741862884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4hicPeni8A/CBo8QgIdsI2yFoQfcCpiKN+FCEFEiVsQ=;
	b=D6XLiGB1VOZuDEaDi8XNKYFittsq58spmjvd4JkkvamjA75lQ37rSOwOlCepNAPvL+aNh0
	Li7+rt/xLYlLQ8NhkrToA1cO08uw9/fqCX5vH7bbdRX2iHLBCwvi8KAEfrGMAEtCdCV5td
	tuTdjFXXTxfyJXlm/5PuXCuhR3bl5g4nt86dE2gI7XgXgvI8D3D+jryw2ODZ6f2HGxr0sX
	9ADGjT+Ls6/IxjbEbOrWE3dnjAE5GuYy6AR924ItE0wfLymb7h1JzE86c2EGfXrmt3zPTq
	lbWzIzxkNvWD5jQMD+9LYyOCU16iWFbiRKVCwui5sKIdQ9ILF3iJFP5JDXe61Q==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Subject: [PATCH 00/13] selftests/bpf: Integrate test_xsk.c to test_progs
 framework
Date: Thu, 13 Mar 2025 11:47:58 +0100
Message-Id: <20250313-xsk-v1-0-7374729a93b9@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN630mcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0ML3YribF2D5DRLg1RLc9MUQxMloMqCotS0zAqwKdGxtbUApABBClU
 AAAA=
X-Change-ID: 20250218-xsk-0cf90e975d14
To: =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jonathan Lemon <jonathan.lemon@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdejjeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomhepfdeurghsthhivghnucevuhhruhhttghhvghtucdlvgeurffhucfhohhunhgurghtihhonhdmfdcuoegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeektdekgfettdegkefhudejveefhfdvtefgudduieefvdfhvdfgfeethefhvdevhfenucfkphepvdgrtddumegtsgduleemkedvheefmeguuddttdemfhelvgdumeeftgejudemjeeitdgtmedutggsrgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekvdehfeemugdutddtmehflegvudemfegtjedumeejiedttgemudgtsggrpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvkedprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhrtghpthhto
 hepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhihkhholhgrlhesfhgsrdgtohhmpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvhdprhgtphhtthhopehmrghgnhhushdrkhgrrhhlshhsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomh
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi all,

This patch series continues the work to migrate the script tests into
prog_tests.

The test_xsk.sh script tests lots of AF_XDP use cases. The tests it uses
are defined in xksxceiver.c. As this script is used to test real
hardware, the goal here is to keep it as is and only integrate the
tests on veth peers into the test_progs framework.
Three tests are flaky on s390 so they won't be integrated to test_progs
yet (I'm currently trying to make them more robust).

PATCH 1 & 2 fix some small issues xskxceiver.c
PATCH 3 to 9 rework the xskxceiver to ease the integration in the
test_progs framework. Two main points are addressed in them :
 - wrap kselftest calls behind macros to ease their replacement later
 - handle all errors to release resources instead of calling exit() when
   any error occurs.
PATCH 10 extracts test_xsk[.c/.h] from xskxceiver[.c/.h] to make the
tests available to test_progs
PATCH 11 enables kselftest de-activation
PATCH 12 isolates the flaky tests
PATCH 13 integrate the non-flaky tests to the test_progs framework

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
Bastien Curutchet (eBPF Foundation) (13):
      selftests/bpf: test_xsk: Initialize bitmap before use
      selftests/bpf: test_xsk: Fix memory leaks
      selftests/bpf: test_xsk: Wrap ksft_*() behind macros
      selftests/bpf: test_xsk: Add return value to init_iface()
      selftests/bpf: test_xsk: Don't exit immediately when xsk_attach fails
      selftests/bpf: test_xsk: Don't exit immediately when gettimeofday fails
      selftests/bpf: test_xsk: Don't exit immediately when workers fail
      selftests/bpf: test_xsk: Don't exit immediately if validate_traffic fails
      selftests/bpf: test_xsk: Don't exit immediately on allocation failures
      selftests/bpf: test_xsk: Split xskxceiver
      selftests/bpf: test_xsk: Make kselftest dependency optional
      selftests/bpf: test_xsk: Isolate flaky tests
      selftests/bpf: test_xsk: Integrate test_xsk.c to test_progs framework

 tools/testing/selftests/bpf/Makefile              |   13 +-
 tools/testing/selftests/bpf/prog_tests/test_xsk.c | 2416 ++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/test_xsk.h |  299 +++
 tools/testing/selftests/bpf/prog_tests/xsk.c      |  178 ++
 tools/testing/selftests/bpf/xskxceiver.c          | 2543 +--------------------
 tools/testing/selftests/bpf/xskxceiver.h          |  153 --
 6 files changed, 3021 insertions(+), 2581 deletions(-)
---
base-commit: 720c696b16a1b1680f64cac9b3bb9e312a23ac47
change-id: 20250218-xsk-0cf90e975d14

Best regards,
-- 
Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>


