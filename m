Return-Path: <linux-kselftest+bounces-25465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E812AA239DE
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 08:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 291E67A2C14
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 07:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7778014F117;
	Fri, 31 Jan 2025 07:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="M5/cazeK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E024683;
	Fri, 31 Jan 2025 07:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738308111; cv=none; b=S5zEFwPEMJGeRLI038buyX9sXuBiD1D8YN47cIAty5I5ZGhwFrGCbHekaHntN6IwedCp8pqkr82ySNx8ThQe6E0/aeXtcpVmFXHIjAKiKhrvEArnvstEHfgblAixeWhGb8JlX//yTGCIPda4UEt7b0LGhPYq+F9kM03RmTU2Rho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738308111; c=relaxed/simple;
	bh=G1mQtbBezYR4g2FL8YenYsWn2FkBkKbc/L95NOOsMLM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Xy5+V32yo4JyNdn6VCOg0TXNSWXqnwfCuwH69S26Bkrm02HuXefqDYeXVaOaWHz/04R4eogxos9nolWJzv7+r473E511xlOr+HkgV6XKXDFnWU9k3UGPHWK1JYw0gRM9vLaVI2yB7UaowN+JAoD6R2uQKiHGfv6dxoA0M4ApEu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=M5/cazeK; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 53A63442CD;
	Fri, 31 Jan 2025 07:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738308106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qvRMOflZcE1Dy/k3AvNk+EOJWj9DfDs/QUCF/RGgSbQ=;
	b=M5/cazeKMja7vJfG5KJVTfua089HROREBbHVMizhcY+iY5yuxpE9zMIIH6ue1tTOmaC0eU
	Ix/U68mP2EI6BoaDp2Eg+zLEvghGXXQ+KrqU5+zoHh7wVjlTcmx4oZZUP7WSFP3oc48+6/
	d++zVCryn4P32HAVnE1ur9MH8cIDGj5g7iHWX6qYCAqYKRTltOyQsC98Y4bNO6rPdkrb6G
	+D+//LfaVh85DS2kAWYcfmyspLZoN79y4U3MnpTOEnXhSeYZw1gQr07G5nNw02DxkaV3ig
	4QeaCF6nDv4U1fLZJqPrXVDokf4nA5FWUqzm8/bUoqXscffqYqeC4eDJ0bEBWw==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Subject: [PATCH bpf-next v4 00/14] selftests/bpf: Migrate
 test_xdp_redirect_multi.sh to test_progs
Date: Fri, 31 Jan 2025 08:21:39 +0100
Message-Id: <20250131-redirect-multi-v4-0-970b33678512@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAR6nGcC/33NQQ6CMBQE0KuYrq1pC0Vx5T2MC/r5lZ8AJW0lG
 MLdbXCjkricTObNzAJ6wsDOu5l5HCmQ61PI9zsGTdXfkVOdMlNCaSFFxj3W5BEi7x5tJK5yXRd
 YWaNrydJo8GhpWsErM4PlPU6R3VLTUIjOP9enUa79G1XyFx0lF9woqTHT1mqhL8a52FJ/ANet2
 Kj+AyoBFkqooDJQGLUFsk/gtAGyBIAELMqyPIKQ38CyLC8iF7R4OgEAAA==
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomhepfdeurghsthhivghnucevuhhruhhttghhvghtucdlvgeurffhucfhohhunhgurghtihhonhdmfdcuoegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefhgfehkeduheegudeiudefvedtjeejvdffkefftedujeeigfekgfeiueehfedtjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudegngdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvgedprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomhdpr
 hgtphhtthhopehhrgholhhuohesghhoohhglhgvrdgtohhmpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtoheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhg
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
 - PATCH 1 Add an helper to generate unique names
 - PATCH 2 to 9 rework test_xdp_veth to make it more generic and allow to
   configure different test cases
 - PATCH 10 adds test cases for 'classic' bpf_redirect_map()
 - PATCH 11 and 12 cover the broadcast flags
 - PATCH 13 covers the XDP egress programs
 - PATCH 14 removes test_xdp_redirect_multi.sh

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
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
Bastien Curutchet (eBPF Foundation) (14):
      selftests/bpf: helpers: Add append_tid()
      selftests/bpf: test_xdp_veth: Remove unused defines
      selftests/bpf: test_xdp_veth: Remove unecessarry check_ping()
      selftests/bpf: test_xdp_veth: Use int to describe next veth
      selftests/bpf: test_xdp_veth: Split network configuration
      selftests/bpf: test_xdp_veth: Rename config[]
      selftests/bpf: test_xdp_veth: Add prog_config[] table
      selftests/bpf: test_xdp_veth: Add XDP flags to prog_configuration
      selftests/bpf: test_xdp_veth: Use unique names
      selftests/bpf: test_xdp_veth: Add new test cases for XDP flags
      selftests/bpf: Optionally select broadcasting flags
      selftests/bpf: test_xdp_veth: Add XDP broadcast redirection tests
      selftests/bpf: test_xdp_veth: Add XDP program on egress test
      selftests/bpf: Remove test_xdp_redirect_multi.sh

 tools/testing/selftests/bpf/Makefile               |   2 -
 tools/testing/selftests/bpf/network_helpers.c      |  17 +
 tools/testing/selftests/bpf/network_helpers.h      |  12 +
 .../selftests/bpf/prog_tests/test_xdp_veth.c       | 588 ++++++++++++++++-----
 .../testing/selftests/bpf/progs/xdp_redirect_map.c |  89 ++++
 .../selftests/bpf/progs/xdp_redirect_multi_kern.c  |  41 +-
 .../selftests/bpf/test_xdp_redirect_multi.sh       | 214 --------
 tools/testing/selftests/bpf/xdp_redirect_multi.c   | 226 --------
 8 files changed, 615 insertions(+), 574 deletions(-)
---
base-commit: 421ec9c8f46a25743870a8cbaff76de293752e00
change-id: 20250103-redirect-multi-245d6eafb5d1

Best regards,
-- 
Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>


