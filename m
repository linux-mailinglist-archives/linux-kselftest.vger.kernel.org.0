Return-Path: <linux-kselftest+bounces-13977-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBF99385F3
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jul 2024 21:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4162BB20DA8
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jul 2024 19:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FB316B3AC;
	Sun, 21 Jul 2024 19:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ka3Y07O5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFEC166301;
	Sun, 21 Jul 2024 19:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721590404; cv=none; b=j8SIGq0KHoDdBmcBPsbg7/qgeD9XDc+TxEXppbp6FtfcC2Wj6Hz7dXJxD6akPDLftlXWu32ZI96RQC2wbhWiFHaJHePxeIkEflG5GeBJpQopjZLF0tuCUlli4MToN+qghaLK2xYtMe7ipP22hk4W8HXbc0RwbIi1vuBvfVqad6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721590404; c=relaxed/simple;
	bh=iAo487ia/wp3XezejlFMYb+izrM0mct6oShgF6NffGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DI/LzS+GM0Clk9qUaG0/KiJaVZj5d90FXhZOR8MfT7kD34roBpmQYVK2e6WVjrJ0h8CkE+Jcd+tj8AmcNzaci9aolYt7etfuviCAcy05Rli03rw5Pmt63DB/XXKDxmJ9/RHzNLGy8Pm5FO+AzrTcXJflaPg+fLzGEu6dljF26oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ka3Y07O5; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6FA1EE0002;
	Sun, 21 Jul 2024 19:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721590393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DsUX943pSWyx64jeqbX92/+5qMtvxBsUvtsU2xaH1MQ=;
	b=Ka3Y07O5CEay6bu5kGkLiKyAj3u6aVX9/R0IHgcFwJ1i2WHms1vWBqM8ImoJzJU/u8XqHj
	8BrfePTBs8f/68qwtdgh/ectnFvLSOtq/ut6VwL0hZv6/PBegfKqRgY/X9aEoIQSn69pnC
	/DBPl33IotFrxheA6bEhhYjXEErpB2c4M11QU2BX5ChcW7t9KBBAPDxvQ9DLSUqV5Npjor
	COjBqiOhbcyhofbm82XhmT6LfirHB2QDPVCt5+ZjAPqUgAvhtdlSRMCxGj87SQgDaePpJ2
	flp8HTDSEZUR0/Lf/g8+mJHEny+ZB89JiP5GPJ1g1X1bKs/ddF+APCrEKR2R/w==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Sun, 21 Jul 2024 21:33:03 +0200
Subject: [PATCH v4 1/2] selftests/bpf: update xdp_redirect_map prog
 sections for libbpf
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240721-convert_test_xdp_veth-v4-1-23bdba21b2f9@bootlin.com>
References: <20240721-convert_test_xdp_veth-v4-0-23bdba21b2f9@bootlin.com>
In-Reply-To: <20240721-convert_test_xdp_veth-v4-0-23bdba21b2f9@bootlin.com>
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
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: ebpf@linuxfoundation.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

xdp_redirect_map.c is a bpf program used by test_xdp_veth.sh, which is not
handled by the generic test runner (test_progs). To allow converting this
test to test_progs, the corresponding program must be updated to allow
handling it through skeletons generated by bpftool and libbpf.

Update programs section names to allow to manipulate those with libbpf.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/bpf/progs/xdp_redirect_map.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_redirect_map.c b/tools/testing/selftests/bpf/progs/xdp_redirect_map.c
index d037262c8937..682dda8dabbc 100644
--- a/tools/testing/selftests/bpf/progs/xdp_redirect_map.c
+++ b/tools/testing/selftests/bpf/progs/xdp_redirect_map.c
@@ -10,19 +10,19 @@ struct {
 	__uint(value_size, sizeof(int));
 } tx_port SEC(".maps");
 
-SEC("redirect_map_0")
+SEC("xdp")
 int xdp_redirect_map_0(struct xdp_md *xdp)
 {
 	return bpf_redirect_map(&tx_port, 0, 0);
 }
 
-SEC("redirect_map_1")
+SEC("xdp")
 int xdp_redirect_map_1(struct xdp_md *xdp)
 {
 	return bpf_redirect_map(&tx_port, 1, 0);
 }
 
-SEC("redirect_map_2")
+SEC("xdp")
 int xdp_redirect_map_2(struct xdp_md *xdp)
 {
 	return bpf_redirect_map(&tx_port, 2, 0);

-- 
2.45.2


