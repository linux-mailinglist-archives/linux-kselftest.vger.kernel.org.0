Return-Path: <linux-kselftest+bounces-25659-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A5BA26FB3
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 11:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759071885316
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 11:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C2020B1EF;
	Tue,  4 Feb 2025 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KGDs7jNm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDE720AF9A;
	Tue,  4 Feb 2025 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738666792; cv=none; b=atsd6lt97jAVfwZPKquX460AzH/E6uGiKgvz2xROSvN4JNYkQV+JQWC9rGjhxDlyqo9PPs9c1MJphNfNtoeKihSnMvrc3V8KK4bCuO0devsoW1XHdG4HoDKxBKLDIQdxsboLxuYVXZ1l3X338YuBJwVWzO0SD8xwGXbhjxQn+1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738666792; c=relaxed/simple;
	bh=JNsr/7RBe3vPFw81J3RBQjyvUzlCjE+Og1IZuVfbHNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OPxV15NqL9SuCcXyKBRbIlW/Vc0jjQlMmXZweFVKj4G8Q446Gr3jUMu8cZeJdUKFvoKrncRqS6FdTvRWYSpEFWhX0D57ubTWSjUYqt5zaEEAAKHJgOSKq4vvIGBfdOi4iwDerJAEaeNdfKbGVyD/HK0wbuGVTaNyO6tS/nuWrM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KGDs7jNm; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 51FC642CCD;
	Tue,  4 Feb 2025 10:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738666787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1nrOiBu4WBrNhYnKgXb0/WmtNOK7mKrU0gfnoU2BLCs=;
	b=KGDs7jNm5J9Ub3xYrY/kRAwo/dwfU5g5ueO4H2pMwubzqckuvPJf+gaH3EUliY7QVIMd8r
	t5WdPsTFipFz+lOTbK1jRWA2mCM+BzZ70PwvFhO24HlURQJ8b2GAWGq0eYLuEvDzKBGffE
	CjHb/8Ts5x9CJD/ggTsM+xYGZPQxgppUEsaJ9dBMEoMCqbvbGcvEEy5UoPr68MTuRB56Lz
	A2UOnZyZzocAjD34Zn28FKdWcb3rAvOu0p5NwK5ikEmSwLb8XBQB9qN/U1nekpfVx4s2ip
	7hHNHQv/n8i4RmLdXhIKd12KiaV7Mru3Y1pwrhwluO+bltN2eAeY7+6axPhmpQ==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Tue, 04 Feb 2025 11:59:43 +0100
Subject: [PATCH bpf-next] selftests/bpf: Remove with_addr.sh and
 with_tunnels.sh
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-with-v1-1-387a42118cd4@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAB/zoWcC/x3MQQqAIBBA0avErBNGJYquEi3UxpqNiUoF0t2Tl
 g8+v0KmxJRh7iokujjzGRpk34E7TNhJ8NYMCtWAUqO4uRxCT5MdlfHOOoSWxkSen3+zgI1eBHo
 KrO/7AUe4wwtgAAAA
X-Change-ID: 20250130-with-388b72afcbc0
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeffecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpedfuegrshhtihgvnhcuvehurhhuthgthhgvthculdgvuefrhfcuhfhouhhnuggrthhiohhnmddfuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepjeegffejjeegtdeggeehheejvdejiefhjeetgffggeeitdelueduieehfefgffelnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudegngdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopehsughfsehfohhmihgthhgvvhdrmhgvpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidruggvvhdprhgtphhtthhopegsphhfsehvghgvr
 hdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehmhihkohhlrghlsehfsgdrtghomhdprhgtphhtthhopeihohhnghhhohhnghdrshhonhhgsehlihhnuhigrdguvghv
X-GND-Sasl: bastien.curutchet@bootlin.com

Those two scripts were used by test_flow_dissector.sh to setup/cleanup
the network topology before/after the tests. test_flow_dissector.sh
have been deleted by commit 63b37657c5fd ("selftests/bpf: remove
test_flow_dissector.sh") so they aren't used anywhere now.

Remove the two unused scripts and their Makefile entries.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/Makefile        |  4 +--
 tools/testing/selftests/bpf/with_addr.sh    | 54 -----------------------------
 tools/testing/selftests/bpf/with_tunnels.sh | 36 -------------------
 3 files changed, 2 insertions(+), 92 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 6722080b2107a56c1500bab4d7b638f5bcde2a82..e9dfd96fa48c98a736c7b39356757b1b3680220a 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -117,8 +117,8 @@ TEST_PROGS := test_kmod.sh \
 	test_xsk.sh \
 	test_xdp_features.sh
 
-TEST_PROGS_EXTENDED := with_addr.sh \
-	with_tunnels.sh ima_setup.sh verify_sig_setup.sh \
+TEST_PROGS_EXTENDED := \
+	ima_setup.sh verify_sig_setup.sh \
 	test_xdp_vlan.sh test_bpftool.py
 
 TEST_KMODS := bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
diff --git a/tools/testing/selftests/bpf/with_addr.sh b/tools/testing/selftests/bpf/with_addr.sh
deleted file mode 100755
index ffcd3953f94cf2301f0e5158d141ccb48b2fb1c0..0000000000000000000000000000000000000000
--- a/tools/testing/selftests/bpf/with_addr.sh
+++ /dev/null
@@ -1,54 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-#
-# add private ipv4 and ipv6 addresses to loopback
-
-readonly V6_INNER='100::a/128'
-readonly V4_INNER='192.168.0.1/32'
-
-if getopts ":s" opt; then
-  readonly SIT_DEV_NAME='sixtofourtest0'
-  readonly V6_SIT='2::/64'
-  readonly V4_SIT='172.17.0.1/32'
-  shift
-fi
-
-fail() {
-  echo "error: $*" 1>&2
-  exit 1
-}
-
-setup() {
-  ip -6 addr add "${V6_INNER}" dev lo || fail 'failed to setup v6 address'
-  ip -4 addr add "${V4_INNER}" dev lo || fail 'failed to setup v4 address'
-
-  if [[ -n "${V6_SIT}" ]]; then
-    ip link add "${SIT_DEV_NAME}" type sit remote any local any \
-	    || fail 'failed to add sit'
-    ip link set dev "${SIT_DEV_NAME}" up \
-	    || fail 'failed to bring sit device up'
-    ip -6 addr add "${V6_SIT}" dev "${SIT_DEV_NAME}" \
-	    || fail 'failed to setup v6 SIT address'
-    ip -4 addr add "${V4_SIT}" dev "${SIT_DEV_NAME}" \
-	    || fail 'failed to setup v4 SIT address'
-  fi
-
-  sleep 2	# avoid race causing bind to fail
-}
-
-cleanup() {
-  if [[ -n "${V6_SIT}" ]]; then
-    ip -4 addr del "${V4_SIT}" dev "${SIT_DEV_NAME}"
-    ip -6 addr del "${V6_SIT}" dev "${SIT_DEV_NAME}"
-    ip link del "${SIT_DEV_NAME}"
-  fi
-
-  ip -4 addr del "${V4_INNER}" dev lo
-  ip -6 addr del "${V6_INNER}" dev lo
-}
-
-trap cleanup EXIT
-
-setup
-"$@"
-exit "$?"
diff --git a/tools/testing/selftests/bpf/with_tunnels.sh b/tools/testing/selftests/bpf/with_tunnels.sh
deleted file mode 100755
index e24949ed3a20813e34bd69bdd634b0f32b7a26e9..0000000000000000000000000000000000000000
--- a/tools/testing/selftests/bpf/with_tunnels.sh
+++ /dev/null
@@ -1,36 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-#
-# setup tunnels for flow dissection test
-
-readonly SUFFIX="test_$(mktemp -u XXXX)"
-CONFIG="remote 127.0.0.2 local 127.0.0.1 dev lo"
-
-setup() {
-  ip link add "ipip_${SUFFIX}" type ipip ${CONFIG}
-  ip link add "gre_${SUFFIX}" type gre ${CONFIG}
-  ip link add "sit_${SUFFIX}" type sit ${CONFIG}
-
-  echo "tunnels before test:"
-  ip tunnel show
-
-  ip link set "ipip_${SUFFIX}" up
-  ip link set "gre_${SUFFIX}" up
-  ip link set "sit_${SUFFIX}" up
-}
-
-
-cleanup() {
-  ip tunnel del "ipip_${SUFFIX}"
-  ip tunnel del "gre_${SUFFIX}"
-  ip tunnel del "sit_${SUFFIX}"
-
-  echo "tunnels after test:"
-  ip tunnel show
-}
-
-trap cleanup EXIT
-
-setup
-"$@"
-exit "$?"

---
base-commit: ab4839cd3b4d65bffd574035a02568809c54a5b6
change-id: 20250130-with-388b72afcbc0

Best regards,
-- 
Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>


