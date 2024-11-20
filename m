Return-Path: <linux-kselftest+bounces-22319-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C09779D344D
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 08:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AEC51F22DBF
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 07:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F8116EB7C;
	Wed, 20 Nov 2024 07:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CD6qGQI3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F85515533F;
	Wed, 20 Nov 2024 07:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732088613; cv=none; b=iKaejunu/kcoOh7fqaIBxMp7d936Ea5ic5E9wa0Grh0iLlfbMhVIfoj9kzsz23dN2+56fZwNFfG3f9GSPxLjd0oMUdelrazuQZmd7EKYNWOu7DrJHdK0UBnnCBVUNaqyBXeJtdzRDMqhY6I5ejAGQ8oKPeR28wSZWaYHGi+6Iz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732088613; c=relaxed/simple;
	bh=0CdquCFaES4KDH1W2g2KxERpmc7esmrg9IkJD3SUXD4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eQAEvPw8Pk7GXm+VhMgWGjDVyUtJexX7DHbG2bAIvRsbra7csGOfsj730/EiM/pq2UYstNb9uAdMzEyTxEwoUlzrHGaSMXztF8KhKynGuCc9hPA2uk1D9t/6C4y2299Rqv+Z844cK36HLW7Qc3AUur9d5kxBC3nkvYE6PxmTW9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CD6qGQI3; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E5F38240003;
	Wed, 20 Nov 2024 07:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732088606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KMZdNfbUY+BAlC109d0n5H3KzVea6UjxKkrWS1zAHd8=;
	b=CD6qGQI3r+u88yac/u7L4e2TEA148/TLyUabiSBOlRDttm6mESPVamNyqqiaFyIKZIONAS
	YYYKl6eBPFzZ9puZLLpQ8scbm4EHDlM/+GwtdDkfvDSzsnbMQZsN3Kdlk4i7LjhviMMR5b
	DlPt7MIfjo/2kXlzFnmWtBhMrtSfE3kWbbg6o9xG4+3Y54gcNKTI9ixQr39M4letDsaKh/
	c2ee8srL00HgHHeyhoLzAX+8xgk1bod6+MfgsYJB7A8K8KWGiUWjcDo30zxlei35AenKxO
	JiV6Qmx5+2fvczBg2gbA/AZThDmoIDA7YcDbtEUyFlrqs01coSzeX/Wh5ihFTg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf-next v3 00/14] selftests/bpf: migrate
 test_flow_dissector.sh to test_progs
Date: Wed, 20 Nov 2024 08:43:10 +0100
Message-Id: <20241120-flow_dissector-v3-0-45b46494f937@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAA6TPWcC/2XNywqDMBQE0F+Ru25KXip21f8opZjkpgaskURSi
 /jvDVn1sRyGObNBxOAwwqnaIGBy0fkpB3GoQA/9dEfiTM7AKZeMso7Y0T9vxsWIevGBCFRU09Z
 q1gjIozmgdWsBL6BmSyZcF7jmZnAxD17lKbHSF5Qx8YsmRijhrZbG0rrjRp+V98vopqP2j4Il/
 gnIP4BnAFH2QqEw2NTfwL7vb2w1GNr5AAAA
X-Change-ID: 20241019-flow_dissector-3eb0c07fc163
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: alexis.lothore@bootlin.com

Hello,
this is the revision 3 of test_flow_dissector_migration.sh into
test_progs. This revision addresses comments from Stanislas, especially
about proper reuse of pseudo-header checksuming in new network helpers.

There are 2 "main" parts in test_flow_dissector.sh:
- a set of tests checking flow_dissector programs attachment to either
  root namespace or non-root namespace
- dissection test

The first set is integrated in flow_dissector.c, which already contains
some existing tests for flow_dissector programs. This series uses the
opportunity to update a bit this file (use new assert, re-split tests,
etc)
The second part is migrated into a new file under test_progs,
flow_dissector_classification.c. It uses the same eBPF programs as
flow_dissector.c, but the difference is rather about how those program
are executed:
- flow_dissector.c manually runs programs with BPF_PROG_RUN
- flow_dissector_classification.c sends real packets to be dissected, and
  so it also executes kernel code related to eBPF flow dissector (eg:
__skb_flow_bpf_to_target)

---
Changes in v3:
- Keep new helpers name in sync with kernel ones
- Document some existing network helpers
- Properly reuse pseudo-header csum helper in transport layer csum
  helper
- Drop duplicate assert
- Use const for test structure in the migrated test
- Simplify shutdown callchain for basic test
- collect Acked-by
- Link to v2: https://lore.kernel.org/r/20241114-flow_dissector-v2-0-ee4a3be3de65@bootlin.com

Changes in v2:
- allow tests to run in parallel
- move some generic helpers to network_helpers.h
- define proper function for ASSERT_MEMEQ
- fetch acked-by tags
- Link to v1: https://lore.kernel.org/r/20241113-flow_dissector-v1-0-27c4df0592dc@bootlin.com

---
Alexis Lothoré (eBPF Foundation) (14):
      selftests/bpf: add a macro to compare raw memory
      selftests/bpf: use ASSERT_MEMEQ to compare bpf flow keys
      selftests/bpf: replace CHECK calls with ASSERT macros in flow_dissector test
      selftests/bpf: re-split main function into dedicated tests
      selftests/bpf: expose all subtests from flow_dissector
      selftests/bpf: add gre packets testing to flow_dissector
      selftests/bpf: migrate flow_dissector namespace exclusivity test
      selftests/bpf: Enable generic tc actions in selftests config
      selftests/bpf: move ip checksum helper to network helpers
      selftests/bpf: document pseudo-header checksum helpers
      selftests/bpf: use the same udp and tcp headers in tests under test_progs
      selftests/bpf: add network helpers to generate udp checksums
      selftests/bpf: migrate bpf flow dissectors tests to test_progs
      selftests/bpf: remove test_flow_dissector.sh

 tools/testing/selftests/bpf/.gitignore             |   1 -
 tools/testing/selftests/bpf/Makefile               |   3 +-
 tools/testing/selftests/bpf/config                 |   1 +
 tools/testing/selftests/bpf/network_helpers.c      |   2 +-
 tools/testing/selftests/bpf/network_helpers.h      |  96 +++
 .../selftests/bpf/prog_tests/flow_dissector.c      | 323 +++++++--
 .../bpf/prog_tests/flow_dissector_classification.c | 792 +++++++++++++++++++++
 .../testing/selftests/bpf/prog_tests/sockopt_sk.c  |   2 +-
 .../testing/selftests/bpf/prog_tests/xdp_bonding.c |   2 +-
 .../selftests/bpf/prog_tests/xdp_do_redirect.c     |   2 +-
 .../selftests/bpf/prog_tests/xdp_flowtable.c       |   2 +-
 .../selftests/bpf/prog_tests/xdp_metadata.c        |  21 +-
 .../selftests/bpf/progs/test_cls_redirect.c        |   2 +-
 .../selftests/bpf/progs/test_cls_redirect.h        |   2 +-
 .../selftests/bpf/progs/test_cls_redirect_dynptr.c |   2 +-
 tools/testing/selftests/bpf/test_flow_dissector.c  | 780 --------------------
 tools/testing/selftests/bpf/test_flow_dissector.sh | 178 -----
 tools/testing/selftests/bpf/test_progs.c           |  15 +
 tools/testing/selftests/bpf/test_progs.h           |  15 +
 tools/testing/selftests/bpf/xdp_hw_metadata.c      |   2 +-
 20 files changed, 1176 insertions(+), 1067 deletions(-)
---
base-commit: 8e403f7465a7c73e3a8ef62bba8cd75ef525e4b1
change-id: 20241019-flow_dissector-3eb0c07fc163

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


