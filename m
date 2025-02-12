Return-Path: <linux-kselftest+bounces-26454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3A0A3245B
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 12:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B550188BE36
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 11:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B057320A5C6;
	Wed, 12 Feb 2025 11:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Td59oa9R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C480B209F56;
	Wed, 12 Feb 2025 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739358679; cv=none; b=cVl5iMu2P5FscqtzrdBlZ6ChEq2qm+tNIvnDnvZT+0UFzNNiC0qWw8b+UHAUbWCL20r06LkIFVDMcGvNp5jrftdiTOlS4KyzQOJ2tMplSVsgar13DxvUcAMeFeshsQlG37Mro2naMoOXtcNax8+hdKrWpj9gUa422bjOPyZPtZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739358679; c=relaxed/simple;
	bh=wUU9BuhvpxZBcTIwnsLVEXUVvjAklXnSQRrDc9l7VUE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QM0zbf7L6fP8VEQXqwcDFFlhl1o2J+dxm+MVds83o7a2YcFLOb0INaymdmMbWW8TMogABYYa7P/Sj95qciHNA+IjPAXzXS0djL2+/5Cx9Ze2CO88bTnPx9ZPmHqwDYOB/NzBtxVdblZ/VZ/A6hrlBVff8CjIx7JgOSjCK6plmNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Td59oa9R; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 605BD44299;
	Wed, 12 Feb 2025 11:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739358675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=omQDXMGVb3oQ42k0VzhRvN8t1Jk6DGJh2gcERMPFs80=;
	b=Td59oa9R8jyiK584Hzaw/IdLWH2V3ltbvPULGBiOhPADjTD3J+1sI8u9mRCb/Vyrllp6Jm
	PLHcpx6bE01drbngKyKNIls7UDxIlxwD9J9wNJyW058nXEIdOXqmiJgJIO3VOe+i5C4XeH
	hAYKq3WuKZUeiQGlDsvo5n7kvb72yYnPXzij5lS9EA2NhPI+bjGD//W3MjJDI0phLj6iaf
	cftZBpKH82wGcqbi5Sqsjob7WCSf+cEogUNGE4HxAIXd7Lt9XJQjdu53Vc5FvzWMlKPmhI
	1oDSwgXJiwPX3FTmLHyZnh2YyIf8+ynNL1eZHkxjmhR7ZY+ZD5mwvmwTthAD+A==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Subject: [PATCH bpf-next v5 0/6] selftests/bpf: Migrate
 test_xdp_redirect_multi.sh to test_progs
Date: Wed, 12 Feb 2025 12:11:08 +0100
Message-Id: <20250212-redirect-multi-v5-0-fd0d39fca6e6@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMyBrGcC/33OQWrDMBAF0KsEraugkTx21FXvEbqwxqNmILGCr
 JiU4LtXuJsQQ5afz7z5DzVxFp7U5+6hMs8ySRprwI+dolM//rCWoWZljUUDxunMg2Smoi+3cxF
 tGxxa7mPAAVQ9umaOcl/BowrXqEe+F/Vdm5NMJeXf9dMMa/+PWnhFZ9BGBwvIDmNEg18hpXKWc
 U/psmKzfQ/YCkTy1FMfqA12C7hn4LABXAUIiFvvfUcGtkDzBLjtgqYCvjPBubY7ILwsWJblDyG
 Ynt17AQAA
X-Change-ID: 20250103-redirect-multi-245d6eafb5d1
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Alexis Lothore <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeejvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpedfuegrshhtihgvnhcuvehurhhuthgthhgvthculdgvuefrhfcuhfhouhhnuggrthhiohhnmddfuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephffgheekudehgeduiedufeevtdejjedvffekffetudejiefgkefgieeuheeftdejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrheegngdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvgedprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsughfsehfohhmihgthhgvvhdrmhgvpdhrtghpthhtohephhgrfihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmp
 dhrtghpthhtohepmhihkhholhgrlhesfhgsrdgtohhmpdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehkphhsihhnghhhsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi all,

This patch series continues the work to migrate the *.sh tests into
prog_tests framework.

test_xdp_redirect_multi.sh tests the XDP redirections done through
bpf_redirect_map().

This is already partly covered by test_xdp_veth.c that already tests
map redirections at XDP level. What isn't covered yet by test_xdp_veth is
the use of the broadcast flags (BPF_F_BROADCAST or BPF_F_EXCLUDE_INGRESS)
and XDP egress programs.

Hence, this patch series add test cases to test_xdp_veth.c to get rid of
the test_xdp_redirect_multi.sh:
 - PATCH 1 & 2 Rework test_xdp_veth.c to avoid using the root namespace
 - PATCH 3 and 4 cover the broadcast flags
 - PATCH 5 covers the XDP egress programs

NOTE: While working on this iteration I ran into a memory leak in
net/core/rtnetlink.c that leads to oom-kill when running ./test_progs in
a loop. This leak has been fixed by commit 1438f5d07b9a ("rtnetlink:
fix netns leak with rtnl_setlink()") in the net tree.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
Changes in v5:
- Remove the patches that were applied from previous iteration
- Add PATCH 1 & 2 to avoid using the root namespace so the veth indexes
don't get incremented on every ./test_progs call
- PATCH 3: Remove unnecessary <linux/ip.h> header
- Link to v4: https://lore.kernel.org/r/20250131-redirect-multi-v4-0-970b33678512@bootlin.com

Changes in v4:
- Remove the NO_IP #define
- append_tid() takes string's size as input to ensure there is enough
  space to fit the thread ID at the end
- Fix PATCH 12's commit log
- Link to v3: https://lore.kernel.org/r/20250128-redirect-multi-v3-0-c1ce69997c01@bootlin.com

Changes in v3:
- Add append_tid() helper and use unique names to allow parallel testing
- Check create_network()'s return value through ASSERT_OK()
- Remove check_ping() and unused defines
- Change next_veth type (from string to int)
- Link to v2: https://lore.kernel.org/r/20250121-redirect-multi-v2-0-fc9cacabc6b2@bootlin.com

Changes in v2:
- Use serial_test_* to avoid conflict between tests
- Link to v1: https://lore.kernel.org/r/20250121-redirect-multi-v1-0-b215e35ff505@bootlin.com

---
Bastien Curutchet (eBPF Foundation) (6):
      selftests/bpf: test_xdp_veth: Create struct net_configuration
      selftests/bpf: test_xdp_veth: Use a dedicated namespace
      selftests/bpf: Optionally select broadcasting flags
      selftests/bpf: test_xdp_veth: Add XDP broadcast redirection tests
      selftests/bpf: test_xdp_veth: Add XDP program on egress test
      selftests/bpf: Remove test_xdp_redirect_multi.sh

 tools/testing/selftests/bpf/Makefile               |   2 -
 .../selftests/bpf/prog_tests/test_xdp_veth.c       | 435 ++++++++++++++++++---
 .../testing/selftests/bpf/progs/xdp_redirect_map.c |  88 +++++
 .../selftests/bpf/progs/xdp_redirect_multi_kern.c  |  41 +-
 .../selftests/bpf/test_xdp_redirect_multi.sh       | 214 ----------
 tools/testing/selftests/bpf/xdp_redirect_multi.c   | 226 -----------
 6 files changed, 491 insertions(+), 515 deletions(-)
---
base-commit: 36ab3d3de536753a4b9b2b4c4ce26af41917a378
change-id: 20250103-redirect-multi-245d6eafb5d1

Best regards,
-- 
Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>


