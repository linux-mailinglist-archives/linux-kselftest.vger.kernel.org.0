Return-Path: <linux-kselftest+bounces-27150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 649F1A3F150
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 11:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A58E3B598F
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 10:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EEF2054F5;
	Fri, 21 Feb 2025 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FmCWste0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAED200136;
	Fri, 21 Feb 2025 10:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740132312; cv=none; b=O/Yx9sitpC4WkYoSeVVHPlTpX9rqBfv8wy3gIeTgvapAMBBdk1Qzo60m0viwHEZRFuAWBxNdsglNCJszJu1CGRR4/uLg7fuK6e8TltVM+DA2KUypQq8RlGN6pIusikg0gLZ56jqQyyKOIF8Xz4PNegYoPYdgniYHv8FtTSg9woM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740132312; c=relaxed/simple;
	bh=bG4YiUZhhAGVeJK8BxWkjCeKlFET2CtsX7oZ+wgQvyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lvQdLMTp+p7lzyTlTMjVeq8Rb6tdAGjJQogDAb4gq8O8LWFWw/tfxdO8i6pMLdsfXlw3acBMuUhcIsUzSXXptSxB785tJVcJJSO9IRl6YDuXrDEXSTYbA+jRkZvyuLl9fg08OXsmV+Cl5a2euNHTL0iOvp0nTbn/InCLsAgx8YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FmCWste0; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B2C6044365;
	Fri, 21 Feb 2025 10:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740132301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fbN6pcO0ps5lplxOQ8pMgv5k+9/MV/0YYxBD57sWs08=;
	b=FmCWste0aiWwruTqRt0pkmCVJN093WbcYTcdTtO/O9Jss4V/jNqMgfpjwAkEnjOZHGhQ/5
	JoszFfrQxUIDH0tbMro/hgU1CoD+CDqmDCwQQ58ZnMtmBtjH2Nb7KMq8gpo+mIpdRcpdyx
	A3jUEAOMI492uRZ1OBAm3SYhLDflOkcfe7r+woP247HC54hKxDL8zdL9DNYh6hNcTRcPoC
	e2myJpVlxmxFrkOC2ZDJyW4ARvt3Ye9bjRAY4cweE7LM7JtImtjn5HsJIXBRfYL1ZTfzWu
	Ski+Mu9OywtMk2zpVG2jS2cQoVVrEGd2N7fxwgWEW7VT82GeK3t5hb6PWQadIA==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Fri, 21 Feb 2025 11:04:57 +0100
Subject: [PATCH bpf-next 1/2] selftests/bpf: test_xdp_vlan: Rename BPF
 sections
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-xdp_vlan-v1-1-7d29847169af@bootlin.com>
References: <20250221-xdp_vlan-v1-0-7d29847169af@bootlin.com>
In-Reply-To: <20250221-xdp_vlan-v1-0-7d29847169af@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Mykola Lysenko <mykolal@fb.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeileejhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpedfuegrshhtihgvnhcuvehurhhuthgthhgvthculdgvuefrhfcuhfhouhhnuggrthhiohhnmddfuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeefudfhuedttdeiffetffeljeffkeevveeiuddtgeejleeftdejgedtjedttdfhnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudegngdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvgedprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhpshhinhhghheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguugihi
 iekjeesghhmrghilhdrtghomhdprhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhihkhholhgrlhesfhgsrdgtohhmpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: bastien.curutchet@bootlin.com

The __load() helper expects BPF sections to be names 'xdp' or 'tc'

Rename BPF sections so they can be loaded with the __load() helper in
upcoming patch.
Rename the BPF functions with their previous section's name.
Update the 'ip link' commands in the script to use the program name
instead of the section name to load the BPF program.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/progs/test_xdp_vlan.c | 20 ++++++++++----------
 tools/testing/selftests/bpf/test_xdp_vlan.sh      |  6 +++---
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_xdp_vlan.c b/tools/testing/selftests/bpf/progs/test_xdp_vlan.c
index a7588302268d5bc911c5f20a79263959824f83a7..a80cc5f2f4f2d89907b04e529572c47e714a7b29 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_vlan.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_vlan.c
@@ -102,8 +102,8 @@ bool parse_eth_frame(struct ethhdr *eth, void *data_end, struct parse_pkt *pkt)
 #define TESTVLAN 4011 /* 0xFAB */
 // #define TO_VLAN  4000 /* 0xFA0 (hint 0xOA0 = 160) */
 
-SEC("xdp_drop_vlan_4011")
-int  xdp_prognum0(struct xdp_md *ctx)
+SEC("xdp")
+int xdp_drop_vlan_4011(struct xdp_md *ctx)
 {
 	void *data_end = (void *)(long)ctx->data_end;
 	void *data     = (void *)(long)ctx->data;
@@ -144,8 +144,8 @@ Load prog with ip tool:
 /* Changing VLAN to zero, have same practical effect as removing the VLAN. */
 #define TO_VLAN	0
 
-SEC("xdp_vlan_change")
-int  xdp_prognum1(struct xdp_md *ctx)
+SEC("xdp")
+int xdp_vlan_change(struct xdp_md *ctx)
 {
 	void *data_end = (void *)(long)ctx->data_end;
 	void *data     = (void *)(long)ctx->data;
@@ -178,8 +178,8 @@ int  xdp_prognum1(struct xdp_md *ctx)
 #endif
 #define VLAN_HDR_SZ	4	/* bytes */
 
-SEC("xdp_vlan_remove_outer")
-int  xdp_prognum2(struct xdp_md *ctx)
+SEC("xdp")
+int xdp_vlan_remove_outer(struct xdp_md *ctx)
 {
 	void *data_end = (void *)(long)ctx->data_end;
 	void *data     = (void *)(long)ctx->data;
@@ -224,8 +224,8 @@ void shift_mac_4bytes_32bit(void *data)
 	p[1] = p[0];
 }
 
-SEC("xdp_vlan_remove_outer2")
-int  xdp_prognum3(struct xdp_md *ctx)
+SEC("xdp")
+int xdp_vlan_remove_outer2(struct xdp_md *ctx)
 {
 	void *data_end = (void *)(long)ctx->data_end;
 	void *data     = (void *)(long)ctx->data;
@@ -254,8 +254,8 @@ int  xdp_prognum3(struct xdp_md *ctx)
  * The TC-clsact eBPF programs (currently) need to be attach via TC commands
  */
 
-SEC("tc_vlan_push")
-int _tc_progA(struct __sk_buff *ctx)
+SEC("tc")
+int tc_vlan_push(struct __sk_buff *ctx)
 {
 	bpf_skb_vlan_push(ctx, bpf_htons(ETH_P_8021Q), TESTVLAN);
 
diff --git a/tools/testing/selftests/bpf/test_xdp_vlan.sh b/tools/testing/selftests/bpf/test_xdp_vlan.sh
index fbcaa9f0120b20829757968a9a668907afa809be..7f672a040b312952679348721a5a17b8703cfc4b 100755
--- a/tools/testing/selftests/bpf/test_xdp_vlan.sh
+++ b/tools/testing/selftests/bpf/test_xdp_vlan.sh
@@ -204,7 +204,7 @@ export BPF_FILE=test_xdp_vlan.bpf.o
 
 # First test: Remove VLAN by setting VLAN ID 0, using "xdp_vlan_change"
 export XDP_PROG=xdp_vlan_change
-ip netns exec ${NS1} ip link set $DEVNS1 $XDP_MODE object $BPF_FILE section $XDP_PROG
+ip netns exec ${NS1} ip link set $DEVNS1 $XDP_MODE object $BPF_FILE program $XDP_PROG
 
 # In ns1: egress use TC to add back VLAN tag 4011
 #  (del cmd)
@@ -212,7 +212,7 @@ ip netns exec ${NS1} ip link set $DEVNS1 $XDP_MODE object $BPF_FILE section $XDP
 #
 ip netns exec ${NS1} tc qdisc add dev $DEVNS1 clsact
 ip netns exec ${NS1} tc filter add dev $DEVNS1 egress \
-  prio 1 handle 1 bpf da obj $BPF_FILE sec tc_vlan_push
+  prio 1 handle 1 bpf da obj $BPF_FILE program tc_vlan_push
 
 # Now the namespaces can reach each-other, test with ping:
 ip netns exec ${NS2} ping -i 0.2 -W 2 -c 2 $IPADDR1
@@ -226,7 +226,7 @@ ip netns exec ${NS1} ping -i 0.2 -W 2 -c 2 $IPADDR2
 #
 export XDP_PROG=xdp_vlan_remove_outer2
 ip netns exec ${NS1} ip link set $DEVNS1 $XDP_MODE off
-ip netns exec ${NS1} ip link set $DEVNS1 $XDP_MODE object $BPF_FILE section $XDP_PROG
+ip netns exec ${NS1} ip link set $DEVNS1 $XDP_MODE object $BPF_FILE program $XDP_PROG
 
 # Now the namespaces should still be able reach each-other, test with ping:
 ip netns exec ${NS2} ping -i 0.2 -W 2 -c 2 $IPADDR1

-- 
2.48.1


