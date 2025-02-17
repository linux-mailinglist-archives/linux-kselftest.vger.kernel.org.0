Return-Path: <linux-kselftest+bounces-26791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA059A38AB3
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 18:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E736169132
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 17:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90F8229B26;
	Mon, 17 Feb 2025 17:39:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0AB21A421;
	Mon, 17 Feb 2025 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739813961; cv=none; b=d7oCyS+mVYEwW0QbbRI/dXDKweI1ow2UE328GHuxu5pDOKEFRSs4dr7c44GaljJ7as6MWoN6W7xQdoJSPwROeFibR8K+/sIcWm/BYJUEZWmyHkY3IrTcRupIjP3gt+pjjNx3MVMge6s2rxc1zl6wwyot41p6uBw2v5wmuUXihFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739813961; c=relaxed/simple;
	bh=Hln9MLJLWvBratba7o3z+my4SMXxNPfe/RNLjHyo04k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCTRyxtI3w407e7KOMGh9n5CgXKepBcTwgh7pRl+S9+WaeERSnY3WQOW1/8lpzESKSHNY0qntMANU5oezd2LD6bfZSVescZKcZUPP3aifn8zBbiulOQeUkrYCRkgeDG5PNV4rAkYUDiqWyN9GusbF5RrkHY0VZkyqo4+Q2ePMf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tk4pu-0001wu-7V; Mon, 17 Feb 2025 18:23:14 +0100
Received: from [78.47.5.107] (helo=sdn-nic-test01..)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tk4pt-000Opa-39;
	Mon, 17 Feb 2025 18:23:13 +0100
From: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	hawk@kernel.org,
	marcus.wichelmann@hetzner-cloud.de
Subject: [PATCH bpf-next v2 6/6] selftests/bpf: fix file descriptor assertion in open_tuntap helper
Date: Mon, 17 Feb 2025 17:23:08 +0000
Message-ID: <20250217172308.3291739-7-marcus.wichelmann@hetzner-cloud.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217172308.3291739-1-marcus.wichelmann@hetzner-cloud.de>
References: <20250217172308.3291739-1-marcus.wichelmann@hetzner-cloud.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: marcus.wichelmann@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27552/Mon Feb 17 10:47:21 2025)

The open_tuntap helper function uses open() to get a file descriptor for
/dev/net/tun.

The open(2) manpage writes this about its return value:

  On success, open(), openat(), and creat() return the new file
  descriptor (a nonnegative integer).  On error, -1 is returned and
  errno is set to indicate the error.

This means that the fd > 0 assertion in the open_tuntap helper is
incorrect and should rather check for fd >= 0.

When running the BPF selftests locally, this incorrect assertion was not
an issue, but the BPF kernel-patches CI failed because of this:

  open_tuntap:FAIL:open(/dev/net/tun) unexpected open(/dev/net/tun):
  actual 0 <= expected 0

Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
---
 tools/testing/selftests/bpf/network_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index e1cfa1b37754..9b59bfd5d912 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -571,7 +571,7 @@ int open_tuntap(const char *dev_name, bool need_mac)
 	struct ifreq ifr;
 	int fd = open("/dev/net/tun", O_RDWR);
 
-	if (!ASSERT_GT(fd, 0, "open(/dev/net/tun)"))
+	if (!ASSERT_GE(fd, 0, "open(/dev/net/tun)"))
 		return -1;
 
 	ifr.ifr_flags = IFF_NO_PI | (need_mac ? IFF_TAP : IFF_TUN);
-- 
2.43.0


