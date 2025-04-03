Return-Path: <linux-kselftest+bounces-30048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D69A79F4D
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 11:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B95D18947F0
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 09:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6AE24889A;
	Thu,  3 Apr 2025 08:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDpAu/RW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC32A24C068;
	Thu,  3 Apr 2025 08:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743670767; cv=none; b=uHl98DXK7QNxHV2IMkLwHm+bkJ4jylpQ6/CjYzlcKziwXBAffMFpWW3dMpF9UK+ppF/CLUSP9NoJ2tifuwhrY65LvJUGmc7y4z/GJ/1zeO3T5DzfRF2Z6dnAhlmC65IKlcgXtgVDsLtx25TsyvtkZ81eXHw2u3UfSIYN8rads+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743670767; c=relaxed/simple;
	bh=7OBjvtHyUhTF6MNy6mRvRdm9dkZZOWdlgICQgFQOr6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aqvmSWX7pJBFgUEVa4Ye8Ci9z7p4X9wSWdCVry914X5JQ1UuP5WT6JtywHhookY18jFPnouE0PRkc3IcJHzOwYr5XFf62pLKEpuEZlc9HWppemkbtP4lVJy9s6H0Kz0iM8Fqh1q16FoR2pa0dpaps6QWsPnvO9oZ5gQYAzGsgrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDpAu/RW; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-301e05b90caso640428a91.2;
        Thu, 03 Apr 2025 01:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743670755; x=1744275555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5xpa71uhLpTbv8JgRd8W4cBk6pMnjix5xeb4Ai3Fe4o=;
        b=TDpAu/RWFK8BR35eP0q0fBLdD4ewxYx5sAmZcO2RJJebyxlYpoNWYuOFrzuwM4EI11
         RLzJoQ1ZfuktZy1IiioFq/y67UhNsv1RLcdA2TsXmWwSkxX+oi3F6XSSIOjzjrmT+wwQ
         OlCFV46/QHLzPnX1lMxjVwSwxPyHaGhf5brl+Dbrc49CUi5Sp+LFcwGE4J5hItl4OjNO
         gyAH2YpP4NwxyJ5c6FVbesdNGeB9iZp22rR6C6HeL4b5VOrnxfcI53SZX3I7X9ZfOL+h
         /N6SjlUKES0/FLNI7qva/SoFvUz0dJj8GEsGQj2yryHbrqNyl/r1GBgm+ORYO12O//0G
         HzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743670755; x=1744275555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xpa71uhLpTbv8JgRd8W4cBk6pMnjix5xeb4Ai3Fe4o=;
        b=I9B7Yw77poR+TrZ7e9Hq6MpzJeGvtrOWGIIoDmwd86HlP27G6kdi9lkKy028c9FBFu
         bOVqewMBhXW9P9OTK/6DTQKSt0Ch2YWFsX9Sybx9+0kwKW2sWqKuw5xVHny2XdPnc7sW
         IUTJiqe64w+1OYiAI+6FPcehy80ap9HPYaa3p4AxJP1nAin4ExtVbDJQliNA5wdODanA
         1xnoUQGu0HDgLt8R46T7mIFj8KdaTvc6WBvgafx6v44BmHvgnQD0PFNgSUkxc+wD8e5Q
         ysmE8i24OEUu2xHXnefsXu8ljHr66YOC9+VoyPePVZhbgsIT5aYZepWIfep+MRVSp+E4
         uyEA==
X-Forwarded-Encrypted: i=1; AJvYcCXjorFdATL1t2ey18XlcZnX6tfizUWCpdIEZyUZlg7HtB4NNYBNk65MAzJcgL3rF/7MTscQX7zonpo304Ij+64=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfVwqmYmniQuhlC5Ry+nJ4s817xrNDOuivwnO903TeUKFi7vq1
	qYBkWWH2zLd8DPjjncgywnuwMuZno7vXtHT36PXVISzSHSmWj6XOZaKXgxmwmwo=
X-Gm-Gg: ASbGnctWKuGMl6rB5oJPtiPc/BalzDj4oQGgu60xO5WBpMcrrqhv2IaoLorZ30Jz5s+
	fMJiHaCisRjG1TOdLS3fBl9pWOBYC9Qqvaghv5JdVuja2RnzSK/JwASxS9k7/zGhgRO+zi3orYI
	rKOBDx+BQKV3ILNOYhU6v/qxkCbKWUhDQPUfv8m2D/kiWQIPhoh2Hxz1N3no1GKFIhz31jraJZP
	FCgDHbVlpepldTxDgDmTb1T+Yz/GHRhEqsXAD+0+Q2AqDGiZCjjTLZ7JtDxs3fqoZQ9prIJWKCV
	Yp7mj4asJ2kmoYIX5NfESyXG/xs98s2s0T/Q1AECqvEFXev53o0RYatoG0CbA8iw
X-Google-Smtp-Source: AGHT+IF4He6+/mC53LDltPVr7ux8SpfkYJcDIWJ7DoV51cEB8SAglYMSICJI8h1IZfryRzg8E5e1Yg==
X-Received: by 2002:a17:90b:37cd:b0:2ee:ad18:b309 with SMTP id 98e67ed59e1d1-3057caef387mr2511599a91.3.1743670755303;
        Thu, 03 Apr 2025 01:59:15 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-305827d710csm937620a91.10.2025.04.03.01.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 01:59:14 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
	Etienne Champetier <champetier.etienne@gmail.com>,
	Di Zhu <zhudi21@huawei.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Travis Brown <travisb@arista.com>,
	Suresh Krishnan <skrishnan@arista.com>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net 0/3] fix ipvlan/macvlan link event handing
Date: Thu,  3 Apr 2025 08:58:54 +0000
Message-ID: <20250403085857.17868-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When setting the lower-layer link up/down, the ipvlan/macvlan device
synchronizes its state via netif_stacked_transfer_operstate(), which
only checks the carrier state. However, setting the link down does not
necessarily change the carrier state for virtual interfaces like bonding.
This causes the ipvlan/macvlan state to become out of sync with the
lower-layer link state. Fix this by explicitly changing the IFF_UP flag,
similar to how VLAN handles it.

Before the patch:
  # ./rtnetlink.sh -t "kci_test_vlan kci_test_ipvlan kci_test_macvlan"
  PASS: vlan link state correct
  FAIL: ipvlan link state incorrect
  FAIL: macvlan link state incorrect

After the patch set:
  # ./rtnetlink.sh -t "kci_test_vlan kci_test_ipvlan kci_test_macvlan"
  PASS: vlan link state correct
  PASS: ipvlan link state correct
  PASS: macvlan link state correct

Hangbin Liu (3):
  ipvlan: fix NETDEV_UP/NETDEV_DOWN event handling
  macvlan: fix NETDEV_UP/NETDEV_DOWN event handling
  selftests/rtnetlink.sh: add vlan/ipvlan/macvlan link state test

 drivers/net/ipvlan/ipvlan_main.c         | 20 +++++++-
 drivers/net/macvlan.c                    | 20 ++++++++
 tools/testing/selftests/net/rtnetlink.sh | 64 ++++++++++++++++++++++++
 3 files changed, 103 insertions(+), 1 deletion(-)

-- 
2.46.0


