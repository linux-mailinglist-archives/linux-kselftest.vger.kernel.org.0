Return-Path: <linux-kselftest+bounces-23324-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CEE9F1060
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 16:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBB1916758C
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 15:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AE11E25EC;
	Fri, 13 Dec 2024 15:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EkjO5/iw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773EA1E25EB;
	Fri, 13 Dec 2024 15:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102458; cv=none; b=Dt3+10SkzQOO45UnR5A6bTJut1u7kHEOmeWw9jdtqXRMfOPyM4yVDt9UBHEn7T82k5Ao3spqmGYsjO5e2hgknkT9lpAzQ9R7q391svYcvjzamZUL3F7u+6yIbwLbfgUgUoLmtdIlGM79Sd7cyQpFbg3TGTJCsiPsXTlkP229HCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102458; c=relaxed/simple;
	bh=3QTAY3tHRim+xpPMr64cLamv+dItOKpaRcDuO8Bv/Yo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jA3LABr3UIXYh++WInNZBtDW3iHLzKuyZPMz4hgDHbf25vFFg/V5b/gLFMq+XM0RhlL8YxDmnKKSBNm/6lvR8O1Wh01JvaktW4hzCxpfJbeTG8eb/8TdlLOdcBkJY4vJmqiEIr7tblKrxqnSumpLiH7geKigIVOSlDJ71dWFS5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EkjO5/iw; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0F1FA40007;
	Fri, 13 Dec 2024 15:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734102447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cu/2fTCydb7q5G79TX/BssWpRTXcIiIiUTZtaHt1tHc=;
	b=EkjO5/iwoE91KBRR+NpjoTTCB7e4d3WoqdBMymCs0LWQP5qQbUvumOvj4JHaL6yR1Y270U
	G4f2fkhRoEqTaTiHgdLFn2Ogmp6nOcJnlSZ7NgN8CGZZ+5k5AcfzTMt8jpQkY6q2UAcXR2
	2bgzusorJMMH7691OjgTahJjwdzUZ/QJb/5kIcvmbITAki5Rwj7bG8QTGkMSlZvxzHYAfT
	V/eMC7Ax44/KF1v5i+rFp3c0DapNpVM8n4O74mbLtWAoB2fV53mb5eagZyeMnXN++unFBI
	jVsHBos0cmHq4MGtPC1C4Tk/Fc1Qgcwdh1ztgxOwUQWUz1O9tJv+8Np/Pe/nIQ==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH bpf-next v2 0/2] selftests: bpf: Migrate test_xdp_meta.sh
 to test_progs
Date: Fri, 13 Dec 2024 16:06:19 +0100
Message-Id: <20241213-xdp_meta-v2-0-634582725b90@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGtNXGcC/0WNQQqDMBBFryKzbsok1tS66j2KFI1jHaiJJEEsk
 rs3SKHLx/u8v0MgzxSgKXbwtHJgZzOoUwFm6uyLBA+ZQaG6SIWl2IblOVPsRK3rEq9mQMIS8nz
 xNPJ2pB7QL6OwtEVos5k4ROc/x8cqD//L6X9ulQJFZWSFWtajptu9dy6+2Z6Nm6FNKX0Bn1HZc
 KwAAAA=
X-Change-ID: 20241203-xdp_meta-868307cd0e03
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
 Bastien Curutchet <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi all,

This patch series continues the work to migrate the script tests into
prog_tests.

test_xdp_meta.sh uses the BPF programs defined in progs/test_xdp_meta.c
to do a simple XDP/TC functional test that checks the metadata
allocation performed by the bpf_xdp_adjust_meta() helper.

This is already partly covered by two tests under prog_tests/:
- xdp_context_test_run.c uses bpf_prog_test_run_opts() to verify the
validity of the xdp_md context after a call to bpf_xdp_adjust_meta()
- xdp_metadata.c ensures that these meta-data can be exchanged through
an AF_XDP socket.

However test_xdp_meta.sh also verifies that the meta-data initialized
in the struct xdp_md is forwarded to the struct __sk_buff used by BPF
programs at 'TC level'. To cover this, I add a test case in
xdp_context_test_run.c that uses the same BPF programs from
progs/test_xdp_meta.c.

---
Changes in v2:
- Add missing close_netns()
- Use a unique 'close' label
- Link to v1: https://lore.kernel.org/r/20241206-xdp_meta-v1-0-5c150618f6e9@bootlin.com

---
Bastien Curutchet (2):
      selftests/bpf: test_xdp_meta: Rename BPF sections
      selftests/bpf: Migrate test_xdp_meta.sh into xdp_context_test_run.c

 tools/testing/selftests/bpf/Makefile               |  1 -
 .../bpf/prog_tests/xdp_context_test_run.c          | 87 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  |  4 +-
 tools/testing/selftests/bpf/test_xdp_meta.sh       | 58 ---------------
 4 files changed, 89 insertions(+), 61 deletions(-)
---
base-commit: 0c30734c4f35c4784d3d3ca1bb89d9779045878c
change-id: 20241203-xdp_meta-868307cd0e03

Best regards,
-- 
Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>


