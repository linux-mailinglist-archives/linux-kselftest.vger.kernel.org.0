Return-Path: <linux-kselftest+bounces-28342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7B3A50D9A
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 22:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9606D188D9E2
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 21:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E919A257AF1;
	Wed,  5 Mar 2025 21:35:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A29256C96;
	Wed,  5 Mar 2025 21:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210518; cv=none; b=AkKbZEzzg3SJGLQcV/AZJcIKROfcO4zi+Dnt0S7fek4CyRsMORIDKKsEVuC98LBmklCEEipcscZksIGOvkRSxeTsvha9e+cnh/ORidLvcMDSt9H1PFqVxXX7tTdDvgax67Qwv/6+teKXjC4uXgLO/hnNAywvuHyO1Jifn/pZuIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210518; c=relaxed/simple;
	bh=OMOreM1cnybdYTyWQTos8XjLNRAgWcU8N+Qf7aXzNm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HFAkWfwV3FfbV/vHWxQrc6mxR4o8bhPVyXw6tQ9ZwDVYXEtn0eVo1TAa6AIBxWl2Kvs2hcO1qgHQkSmkTNOjGKyDqYNLwRqNLgK7CbUz4ySKV9aKZo3OtU2Coa5sQEGUKv7dXMnquaXawHZ7CcXQvS91Dk9KDgxwosSGG4nnI84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tpwO3-000K1R-IS; Wed, 05 Mar 2025 22:34:43 +0100
Received: from [78.47.5.107] (helo=sdn-nic-test01..)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tpwO2-000MHO-1n;
	Wed, 05 Mar 2025 22:34:43 +0100
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
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	marcus.wichelmann@hetzner-cloud.de,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH bpf-next v5 6/6] selftests/bpf: fix file descriptor assertion in open_tuntap helper
Date: Wed,  5 Mar 2025 21:34:38 +0000
Message-ID: <20250305213438.3863922-7-marcus.wichelmann@hetzner-cloud.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305213438.3863922-1-marcus.wichelmann@hetzner-cloud.de>
References: <20250305213438.3863922-1-marcus.wichelmann@hetzner-cloud.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: marcus.wichelmann@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27568/Wed Mar  5 10:48:48 2025)

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
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index fcee2c4a637a..29541d486c5e 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -554,7 +554,7 @@ int open_tuntap(const char *dev_name, bool need_mac)
 	struct ifreq ifr;
 	int fd = open("/dev/net/tun", O_RDWR);
 
-	if (!ASSERT_GT(fd, 0, "open(/dev/net/tun)"))
+	if (!ASSERT_GE(fd, 0, "open(/dev/net/tun)"))
 		return -1;
 
 	ifr.ifr_flags = IFF_NO_PI | (need_mac ? IFF_TAP : IFF_TUN);
-- 
2.43.0


