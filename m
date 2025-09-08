Return-Path: <linux-kselftest+bounces-40916-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 942C8B4842D
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 08:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98FEE18931F4
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 06:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A562C224AF0;
	Mon,  8 Sep 2025 06:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTjb1j48"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E542F32;
	Mon,  8 Sep 2025 06:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757312895; cv=none; b=XuS/jdIsOKAp8Een79NYWckIC0oZSPOKkITQk2ClLtAU4SSbUne6NxM4lOeVwMiXTAa7TecDM2G5DEr4mlWQnxxUZZJZpRqMpLnqdZtioTMBsYRnxy1aM4Jd1CIm0TTIpx55xVAWYbIn0S+hpsJyvSZ4njWRQHHfzo3qUMPnLEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757312895; c=relaxed/simple;
	bh=ltGHhRsnNNUL4vfR88eApK9XsH3PP6Rb9TOxCfR95AI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AFfMJTjhIt4gxNsil6CNYBu1POEUByglAU64i5jUieH4lzPIw2UidpNIlbGrDUFScFSNJMbJNCAdqUSewT+mCb9zZ/62ptBh8v6bVLkqr1FhyCmXQnN8lVjhiuKglqszUoNCGm1YRZeEx+l4ijrcPTGuA9T7v6OamZO20acQ4h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTjb1j48; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32d3e17d95dso1246283a91.3;
        Sun, 07 Sep 2025 23:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757312893; x=1757917693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RPBc83npyM3oZ6IcL9QGJfiYXUzPVNexDH9DXNnsPF0=;
        b=jTjb1j48hnXycaNtBZ/HJTnonueCfkRM3eV7s/eN9TWv6B8PXivpx0gkMI749ZrOg/
         H4YICqrvGAgQQwrLTnog+of+BACK/PKcSkrjH2mqkBCoOUvTAWsN0ny9KMU9rDpgO7oy
         DQk4eFd2dBMsZQDUM1F4bWrTzUTnzgkhnTAVgQgim5ZJfzakKzSbU4hj2V9pC/gR+q7C
         03kch70l5Y9QiW/5enary7NGV8xI3batJ5QYsoqB9MiHjSiyhwirlhOXGAN3Wgq2QBrR
         dIPEiCJzwKIqSn7YLfMqHxEQkpq2H8HOps48HlxOvhHcpuuWAw/nRH2WvxU0v8mxL613
         7cGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757312893; x=1757917693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RPBc83npyM3oZ6IcL9QGJfiYXUzPVNexDH9DXNnsPF0=;
        b=s3stKCiGLiiAnHAWStECiL95cPYiMrpOGgMTPDk1gIqA5ipq5PaCfNCkic90i1pkve
         ywWSj6mnTNDu3mpoon35f+IUIWrjEK0/gi45x8WeVOHFe4GNpliIINcVnp7767XKZM4j
         uxE5vbBpWY9zx+LqfyshGe5VM3WaCY/TQ1WSjfVT5CrfwRUMWf+vUoIL/EhJ4qs49QFk
         kz2GB+0oUItXbb4s/G1tqD8FerdMmyKtWztt6kLoIt1KNQyD3PDcSfqFujO11WRmnBQy
         Ejc+xCQdmC8LdWd7POVsUqoNb400EgJzHsIxm1aMBSACYJCcPdhXdjVrRTj8eS/u+wVb
         hY/g==
X-Forwarded-Encrypted: i=1; AJvYcCWei8fVuPL9GiNhIKMWDaMyeA+8sosxEqpxkBJ7lAsbGpIDTAWXfhs0a9EgB9M67EOgBK7jhVGZrd5OdeX4AI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz61p4fmTj1XPqnfIidzF6c5JGjm9fYvMUTIPosqLq8CFTzl3P+
	9kAc32ndO83T0/NN+QKR47LjPQDgshWuVGq+H/1PCbqLnwv41Iylh+irUeIywn/gmB0=
X-Gm-Gg: ASbGncsWiBeOJE8NJI2MI/cNwJTOvz/s3Llgg46RMchlfmq95sbAGPOxHDv85Jkok4i
	IShLF71qx701DgXsrz/JeB8edSM9xVLTa32Bkfckf8CYXM1HR10nD8cL+mrQtJsGdmKhR9AebTs
	fNtFZ+n5aBwm5G89LvaSshkjyXq9OWFb2AYJGX6FjlaoHzWc5yHpuGXc56Liyov5BZmnrtz8TjR
	juWPUWgI6TDEIuN7Xie0+Y2wCgMAgrcv9UNR83sSoVyVNNGrA7HjlFI+mPdlI5vCOlBXlhNGqEk
	q8nkXoyhvvV07YGN4d4rjh/CR04MF7iun+5aiQjzFBV6iV4VAS3O0rd5isqExdMypVRxxLG1xuX
	hOz1hYotqRXYw2AKtl7uWcfjGFbPa0Gx9+4HIWKpilcht9C2ZcyLW
X-Google-Smtp-Source: AGHT+IHRigGTvVKHGEqRM0ROOHKESyBE3/7Gz5SURVLP42ZMjdI3RsJVoxtkV7TRC+SmuLwHOLnpaQ==
X-Received: by 2002:a17:90b:3c08:b0:329:e9da:35dd with SMTP id 98e67ed59e1d1-32d43f77076mr9091997a91.27.1757312892633;
        Sun, 07 Sep 2025 23:28:12 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77285bb2614sm13134974b3a.58.2025.09.07.23.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 23:28:12 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	David Wilder <wilder@us.ibm.com>
Subject: [PATCHv2 1/2] bonding: don't set oif to bond dev when getting NS target destination
Date: Mon,  8 Sep 2025 06:28:01 +0000
Message-ID: <20250908062802.392300-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike IPv4, IPv6 routing strictly requires the source address to be valid
on the outgoing interface. If the NS target is set to a remote VLAN interface,
and the source address is also configured on a VLAN over a bond interface,
setting the oif to the bond device will fail to retrieve the correct
destination route.

Fix this by not setting the oif to the bond device when retrieving the NS
target destination. This allows the correct destination device (the VLAN
interface) to be determined, so that bond_verify_device_path can return the
proper VLAN tags for sending NS messages.

Reported-by: David Wilder <wilder@us.ibm.com>
Closes: https://lore.kernel.org/netdev/aGOKggdfjv0cApTO@fedora/
Suggested-by: Jay Vosburgh <jv@jvosburgh.net>
Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---

v2: split the patch into 2 parts, the kernel change and test update (Jay Vosburgh)

---
 drivers/net/bonding/bond_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 257333c88710..30cf97f4e814 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3355,7 +3355,6 @@ static void bond_ns_send_all(struct bonding *bond, struct slave *slave)
 		/* Find out through which dev should the packet go */
 		memset(&fl6, 0, sizeof(struct flowi6));
 		fl6.daddr = targets[i];
-		fl6.flowi6_oif = bond->dev->ifindex;
 
 		dst = ip6_route_output(dev_net(bond->dev), NULL, &fl6);
 		if (dst->error) {
-- 
2.50.1


