Return-Path: <linux-kselftest+bounces-24922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5091A18F58
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 11:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA51F1631B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 10:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FCF21129A;
	Wed, 22 Jan 2025 10:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NmhQaMN2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2C81F7914;
	Wed, 22 Jan 2025 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737540703; cv=none; b=gmgLuJ/8aW+qMvwmrMP10R4X2U1sil6bxM9wXWWhclXqb6YOhmjXyOWEirVtQDBJuAdAOQKbpwysLvcpTfzOF0hCEKGpnYMgfwTGFOXDg2rVGwoU9qI2ut/tlKdCZCyZ78BCyaEiWU0YTF7BwzlC/vZ9qO2QRuPDjyDWpf3EVBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737540703; c=relaxed/simple;
	bh=6p0ZNiaedPTstsjUOKB/bKroZewqExukBImhrr1HPaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7ZMFzn0Hr6N0FFyxeqqKY6mAoeHxrdOGrTnpGG04b2zvtUneq3iRjy0YcBtaRO0kk1UoFEabSluRlZ9uHfzx6F1hUxA799ACSZNIRCqMtk3BgCWZo749wEv+6xF9airaIcDA3EDOPnUg/cRxwp5mwrfr/fzD3mAvv57xTei8tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NmhQaMN2; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=QfD0x
	ORTJ6sdWkpnFOeE2wnXCWQvBYF6SlJ27tlulQ4=; b=NmhQaMN2bVMWQH2mkJTxF
	e6LCWMYTylebD+llO5dZTdCTgSEv4rnJiN0psi1YhUbzC5pAIDB4uhiTInscJKu7
	zMnF5K45iibe5Ez1AKwXNpW1I5LefNq4C2LToEsw8zIcmYFhFGRBnNypooXbX4O3
	ovxmfjO/nImXUuKKj1lQRk=
Received: from localhost.localdomain (unknown [47.252.33.72])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAHUcjUw5Bn_UIhKA--.64788S6;
	Wed, 22 Jan 2025 18:10:23 +0800 (CST)
From: Jiayuan Chen <mrpre@163.com>
To: bpf@vger.kernel.org,
	jakub@cloudflare.com,
	john.fastabend@gmail.com
Cc: netdev@vger.kernel.org,
	martin.lau@linux.dev,
	ast@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	song@kernel.org,
	andrii@kernel.org,
	mhal@rbox.co,
	yonghong.song@linux.dev,
	daniel@iogearbox.net,
	xiyou.wangcong@gmail.com,
	horms@kernel.org,
	corbet@lwn.net,
	eddyz87@gmail.com,
	cong.wang@bytedance.com,
	shuah@kernel.org,
	mykolal@fb.com,
	jolsa@kernel.org,
	haoluo@google.com,
	sdf@fomichev.me,
	kpsingh@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Jiayuan Chen <mrpre@163.com>
Subject: [PATCH bpf v9 4/5] selftests/bpf: fix invalid flag of recv()
Date: Wed, 22 Jan 2025 18:09:16 +0800
Message-ID: <20250122100917.49845-5-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250122100917.49845-1-mrpre@163.com>
References: <20250122100917.49845-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAHUcjUw5Bn_UIhKA--.64788S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF4DCF45tFW5tFy5Xr1UWrg_yoW8GF1kpa
	40y34YkFWSvF1aqa1kJrsruF4rGr98Xws0kF4DWry8Ar1kJrn2qF4xKay5tFn7WrZ3Z34r
	Zwn3KFWrWw48WwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEYFAQUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDxrcp2eQus6v2AAAsa

SOCK_NONBLOCK flag is only effective during socket creation, not during
recv. Use MSG_DONTWAIT instead.

Signed-off-by: Jiayuan Chen <mrpre@163.com>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_basic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 884ad87783d5..0c51b7288978 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -522,8 +522,8 @@ static void test_sockmap_skb_verdict_shutdown(void)
 	if (!ASSERT_EQ(err, 1, "epoll_wait(fd)"))
 		goto out_close;
 
-	n = recv(c1, &b, 1, SOCK_NONBLOCK);
-	ASSERT_EQ(n, 0, "recv_timeout(fin)");
+	n = recv(c1, &b, 1, MSG_DONTWAIT);
+	ASSERT_EQ(n, 0, "recv(fin)");
 out_close:
 	close(c1);
 	close(p1);
@@ -628,7 +628,7 @@ static void test_sockmap_skb_verdict_fionread(bool pass_prog)
 	ASSERT_EQ(avail, expected, "ioctl(FIONREAD)");
 	/* On DROP test there will be no data to read */
 	if (pass_prog) {
-		recvd = recv_timeout(c1, &buf, sizeof(buf), SOCK_NONBLOCK, IO_TIMEOUT_SEC);
+		recvd = recv_timeout(c1, &buf, sizeof(buf), MSG_DONTWAIT, IO_TIMEOUT_SEC);
 		ASSERT_EQ(recvd, sizeof(buf), "recv_timeout(c0)");
 	}
 
-- 
2.43.5


