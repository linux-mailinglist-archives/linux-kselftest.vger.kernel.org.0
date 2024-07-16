Return-Path: <linux-kselftest+bounces-13772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE26D9323A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 12:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2A0284BF9
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 10:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF0A198A36;
	Tue, 16 Jul 2024 10:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Pr/LHb61"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FBD44369;
	Tue, 16 Jul 2024 10:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721124828; cv=none; b=Hwb49tl1DA1fNKMeaq25i4p4l2YZrjz0kUc/32AQ36cxryX13W7uJ5KcC/s3STWfwyfUqQtMSsgk/EaI4CHHlhefEnlM8hZR9eVDAk0nQpJsBbxThfSrxXKv1U43EmU8PveFFkuzQrTl/OfAj0g3nZTO0GYmoj++memTKsBEK9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721124828; c=relaxed/simple;
	bh=QkKZPvqT0eyR2OvLR46yzphiuja6KmQG5tGOto8GD08=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hKff6x/39NVIeKhD/uJBKN+hgqgs5sWNR1VgONCcAcl+oqP1lCiVc/7OTs64n/VAzHsjrTpjA+833ETlyHE57Y9fVqqcEPh4ZRBQVZt3MC6HT8B4aD9hLECulIwv8YAMjupSkRQrI0OvNoAaU1haQtJbSEeA/PU1jP4b9gZcLPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Pr/LHb61; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 20AE1FF802;
	Tue, 16 Jul 2024 10:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721124823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ONom7AaKA2Oa3vVjyFp69etExX2LlCp4bGg9AjwYrzY=;
	b=Pr/LHb61i9qFWOaDU5ceIEmmNNdY/ctzjE0jJQr6Icrc20uMqAT33hExPnXfMQXSL5Bvn9
	3bErNmTK0OpSvVakg05XvCGzfu+Dcm8Dj9dtwTiMu5ClxwktRq53YfpOd8z+6d2a0D7yZ4
	ondVsGjNr7WIcpzqySKsCo1kocTeK6Phxn/WiH/f39rElwHPHWf9sQ9qTX+wzE1rV+J96Z
	Ccmt6H/dlbYYAp/XEV2QSYfJOqkM6Z/YpgVOZPNkDEz6PHTzxGSLi3j9BpSconDqlTl+W/
	5RAgLXigGAtSmSaMQ/JgqccH7hwlkDbhSg1zdNAmmNr9J4HEL+e8g3jzTCZ+aw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH v3 0/2] selftests/bpf: convert test_xdp_veth to test_progs
 framework
Date: Tue, 16 Jul 2024 12:13:27 +0200
Message-Id: <20240716-convert_test_xdp_veth-v3-0-7b01389e3cb3@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMdHlmYC/3XN0QqDIBTG8VcJr+c4usy2q73HGFF6WsKmoSKN6
 N1nwWC76PL/wfmdmQT0BgO5FDPxmEwwzuY4HQqihtY+kBqdm3DgJUgGVDmb0McmYojNpMcmYRw
 olEqB6IUQUpN8O3rszbS5t3vuwYTo/Ht7k9i6fkW2IyZGgdZV3SrVQSu5vHbOxaexR+VeZDUT/
 3XEnsOzU1b8DF3N+0rzf2dZlg9/aHPVBAEAAA==
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

Hello everyone,

this small series is a first step in a larger effort aiming to help improve
eBPF selftests and the testing coverage in CI. It focuses for now on
test_xdp_veth.sh, a small test which is not integrated yet in test_progs.
The series is mostly about a rewrite of test_xdp_veth.sh to make it able to
run under test_progs, relying on libbpf to manipulate bpf programs involved
in the test.

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
Changes in v3:
- Fix doc style in the new test
- Collect acked-by tags
- Link to v2: https://lore.kernel.org/r/20240715-convert_test_xdp_veth-v2-0-46290b82f6d2@bootlin.com

Changes in v2:
- fix many formatting issues raised by checkpatch
- use static namespaces instead of random ones
- use SYS_NOFAIL instead of snprintf() + system ()
- squashed the new test addition patch and the old test removal patch
- Link to v1: https://lore.kernel.org/r/20240711-convert_test_xdp_veth-v1-0-868accb0a727@bootlin.com

---
Alexis Lothoré (eBPF Foundation) (2):
      selftests/bpf: update xdp_redirect_map prog sections for libbpf
      selftests/bpf: integrate test_xdp_veth into test_progs

 tools/testing/selftests/bpf/Makefile               |   1 -
 .../selftests/bpf/prog_tests/test_xdp_veth.c       | 211 +++++++++++++++++++++
 .../testing/selftests/bpf/progs/xdp_redirect_map.c |   6 +-
 tools/testing/selftests/bpf/test_xdp_veth.sh       | 121 ------------
 4 files changed, 214 insertions(+), 125 deletions(-)
---
base-commit: 4837cbaa1365cdb213b58577197c5b10f6e2aa81
change-id: 20240710-convert_test_xdp_veth-04cc05f5557d

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


