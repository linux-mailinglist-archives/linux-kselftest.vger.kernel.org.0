Return-Path: <linux-kselftest+bounces-25281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1280A207E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 10:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648BC16990B
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 09:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303741A08A4;
	Tue, 28 Jan 2025 09:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nr7r1reF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B26617A586;
	Tue, 28 Jan 2025 09:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738058265; cv=none; b=DBi/zc9I5zqUKT+L24fc1pBskXPCwHPBdn8XtaSUhELhyUy2xnVNCq+sR78pFiN3Yt5IyNlxxqY4meGPKINN1YHqXUI11ZZlwYH/8eLUsX9F14BtXKAaZYdyjh/UOqnNfs+brdBpqLOol9R8nH9qDKrXt9RI8DahaA3lJPNcZrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738058265; c=relaxed/simple;
	bh=pvcBYlilfh6EjDdkBXswet3ARC1sdM5NTxxZ6PVjyNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cwZ4YbM5HPNGhclYyajA/18/aB7WoF/aNmUloh0S2Fv2h+IIDbfKrk729sXFWy+X8TIMAREnM4+3sYwdgHx/JVglUsKb8uSvFl/Ca+laSvsLMIxLkRWf4SK/I09MI1dZKw7xXHMDDFmpULK1c77Cv1NOp7WIDHlbw/lWWys454M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nr7r1reF; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8EAD21C0010;
	Tue, 28 Jan 2025 09:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738058260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GOes+KfBv8/upgtkhPOaazc7B2nfbC7ly3LGHebWJ5k=;
	b=nr7r1reFYXnKdz6+SnJmoFHlx95rN4GriFJHGKTMxzPWhcYf++4wwc6FdeIdZ7XHCwqjBf
	Xz/JIPT+DicVU3RTD7Hi3j2cdgVTUjfO4Fk3bDdNEtcFRD9hF7R0DBKzO0W4aLbhGmD4aW
	BZPLpliDWzRruKO/VZeIDeCiACtpUeoO98bQDbMVVum6kEcLS36JTZ1APooeE9oAgW08s4
	DwMU5mqLqdr1EzJ9s1+NkvOWDvJZD4KRv/Uq6RTP7jPgLkgnT3iRkOcjv6r140posEl7Vf
	BUnN/gLpiDPWyN/fw2I2vx5ViNMc02B+W1J5sjLV3AcYSrRFbmNh4P+JxBPK3A==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Tue, 28 Jan 2025 10:57:26 +0100
Subject: [PATCH bpf-next v3 02/14] selftests/bpf: test_xdp_veth: Remove
 unused defines
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-redirect-multi-v3-2-c1ce69997c01@bootlin.com>
References: <20250128-redirect-multi-v3-0-c1ce69997c01@bootlin.com>
In-Reply-To: <20250128-redirect-multi-v3-0-c1ce69997c01@bootlin.com>
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
X-GND-Sasl: bastien.curutchet@bootlin.com

IP_CMD_MAX_LEN and NS_SUFFIX_LEN aren't used anywhere.

Remove these unused defines

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
index 8d75424fe6bc8b2d4eeabe3ec49b883284c834e9..95e1791ea7e0f950609607b30d35f78da82e058b 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
@@ -25,11 +25,9 @@
 #include "xdp_tx.skel.h"
 
 #define VETH_PAIRS_COUNT	3
-#define NS_SUFFIX_LEN		6
 #define VETH_NAME_MAX_LEN	16
 #define IP_SRC				"10.1.1.11"
 #define IP_DST				"10.1.1.33"
-#define IP_CMD_MAX_LEN		128
 
 struct skeletons {
 	struct xdp_dummy *xdp_dummy;

-- 
2.47.1


