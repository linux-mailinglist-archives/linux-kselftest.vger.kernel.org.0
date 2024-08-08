Return-Path: <linux-kselftest+bounces-15025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE4C94BD55
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 14:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9D21C2217F
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 12:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6006818C352;
	Thu,  8 Aug 2024 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnxJa4P9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C399963D;
	Thu,  8 Aug 2024 12:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723119910; cv=none; b=atFrUtuln7zGbEaLi17bTuGBGTEE1PSwLZZu9SzNEAZ0YC7PO3TVbNDEQiaUprv+DyXaTwg0U10TC42q3SU13aHe9rqcnKMevMOyhaeeEDXrGHnXG29rCGKWTqkrtw9r/VC7bfClEKaWQGQyqdDfNS4kn6PIKAzelAHDrPKE904=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723119910; c=relaxed/simple;
	bh=83O01skhPNEyX6b1nkJXchmdN8vo3orVhlU0WqlHJxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A7yzaQmgJ6pScHc/Q5npVxcCjQ6AkUUFlfiRj1AXF7QbMRME/3eF9pE88xNO9Lu6XIMt+u+VSjH4BAc5EIzvReT+lHP1dP8VpRulTSB4+ZRhUxdsq01ytdybMPRepIhxOXUSDu5Xf7kmkzhfUd2apd08ZCS7o3r3jYySos8kizM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnxJa4P9; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3dab336717fso633332b6e.0;
        Thu, 08 Aug 2024 05:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723119908; x=1723724708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V11qWEGhEyP7hThEnp51V2Dz5DUj4qW2UBjRZILqErI=;
        b=VnxJa4P9qdzPz48ss/P8H8G6I9+Mgmi5RUMTd/r63dCQhd1QRKb+4GjU5L7SNVWpno
         /zo4DUyfxfEiN79NBxAQjeoySSiBKuVsfukLbDylo03iA2GqVo225V9wbgq92kWmoq9a
         cg08xQ4Fkxq2/zhESlO/buHoI3PvutFbQf4GzBizdpv8/rFsZu/hY1rs3IBiG4PEHXJo
         TKAueMSGG8C7dp/Hm+hiJ1r7AXm3oRO3I7kxmqnq7v9/g8X35cS3fFsLWt5aRKYdZXWj
         2+Cch3VSgXRrxwAEb8cRlTAzWeIThRLnK36iK9AfwdkhqIaTXTXYdKGzV8W1WOeV3hJV
         VnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723119908; x=1723724708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V11qWEGhEyP7hThEnp51V2Dz5DUj4qW2UBjRZILqErI=;
        b=ddvgkQaifg8JTaNFkKh2mveR5tIfmHgz2mIuUL7pEDqwLPi2q03uTTkHfxo4wJHU2W
         9Bss7an6j7ASRvF1wM07memTuUHAMHWhIwLvoBzcXSZUuPaLJwxYvhV4t3AgU7zHgbym
         8Xqlq1VBHCUrj7wMl1tO0WHAKjJdCCsizy1IPdNMU/1Rqn6LQRcFLdRAqElm6O1XTIfc
         xSxhSlhx2gKSpeaB2+fRMQLi6ZmHZ3HWeCo2c6vsH4COyElHImG2mdSeBi6S7BwA5sa+
         Nsbry7Mb5o4Q1hK7v5qOF31qxcsZXMti71c5e4yII6EFixiDxC92YqcMgomxc6qnTyIW
         Inng==
X-Forwarded-Encrypted: i=1; AJvYcCWnwpTa5onKz/INM/6gDTE250e2JtiiDIIkHUQ62EP31SrgMzTg6TGXDzNyGDJc/vLNqXcbv5Z+V5fshPOUzWi6sX9y6uLqn8wutR0sbv3qjm/BpFv0LY8/s3EfQcLAQSPVa3vXzLfKUKVcV8PU32tbyo9K04kQh5eGtv0Odi5/s2k/CXe0
X-Gm-Message-State: AOJu0YzWuvs75iim6MFxZmQ/+VmHp5yfO0uAGa/eKHpge5CQ0xr9o+6i
	lJWaHz7qEtKXrCOABXMQ4CC41ZkdZLZLmGHgm+uIotl3r3tyhKTb
X-Google-Smtp-Source: AGHT+IFNF4/TI/RiZzBmCojYf0q0UhYhR9ISOwG+XMI5KF4KMxeYzVN7hNhuuscPM8M7bTDbGfqRKg==
X-Received: by 2002:a05:6808:1a05:b0:3d9:30a2:f8f9 with SMTP id 5614622812f47-3dc3b1bf4camr2122895b6e.0.1723119907581;
        Thu, 08 Aug 2024 05:25:07 -0700 (PDT)
Received: from dev0.. ([49.43.168.245])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7bb819e782csm5530478a12.48.2024.08.08.05.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 05:25:07 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	Abhinav Jain <jain.abhinav177@gmail.com>
Subject: [PATCH v5 0/2] Enhance network interface feature testing
Date: Thu,  8 Aug 2024 12:24:50 +0000
Message-Id: <20240808122452.25683-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series includes fixes for creation of veth pairs for
networkless kernels & adds tests for turning the different network
interface features on and off in selftests/net/netdevice.sh script.

Changes in v5:
Rectify the syntax for ip add link.
Fix the veth_created condition check.

Changes in v4:
https://lore.kernel.org/all/20240807175717.7775-1-jain.abhinav177@gmail.com/

Move veth creation/removal to the main shell script.
Tested using vng on a networkless kernel and the script works, sample
output below the changes.

Changes in v3:
https://lore.kernel.org/all/20240614113240.41550-1-jain.abhinav177@gmail.com/

Add a check for netdev, create veth pair for testing.
Restore feature to its initial state.

Changes in v2:
https://lore.kernel.org/all/20240609132124.51683-1-jain.abhinav177@gmail.com/

Remove tail usage; use read to parse the features from temp file.

v1:
https://lore.kernel.org/all/20240606212714.27472-1-jain.abhinav177@gmail.com/

```
# selftests: net: netdevice.sh
# No valid network device found, creating veth pair
# PASS: veth0: set interface up
# PASS: veth0: set MAC address
# SKIP: veth0: set IP address
# PASS: veth0: ethtool list features
# PASS: veth0: Turned off feature: rx-checksumming
# PASS: veth0: Turned on feature: rx-checksumming
# PASS: veth0: Restore feature rx-checksumming to initial state on
# Actual changes:
# tx-checksum-ip-generic: off
# tx-tcp-segmentation: off [not requested]
....
....
....
# PASS: veth1: Restore feature tx-nocache-copy to initial state off
# PASS: veth1: Turned off feature: tx-vlan-stag-hw-insert
# PASS: veth1: Turned on feature: tx-vlan-stag-hw-insert
# PASS: veth1: Restore feature tx-vlan-stag-hw-insert to initial state on
# PASS: veth1: Turned off feature: rx-vlan-stag-hw-parse
# PASS: veth1: Turned on feature: rx-vlan-stag-hw-parse
# PASS: veth1: Restore feature rx-vlan-stag-hw-parse to initial state on
# PASS: veth1: Turned off feature: rx-gro-list
# PASS: veth1: Turned on feature: rx-gro-list
# PASS: veth1: Restore feature rx-gro-list to initial state off
# PASS: veth1: Turned off feature: rx-udp-gro-forwarding
# PASS: veth1: Turned on feature: rx-udp-gro-forwarding
# PASS: veth1: Restore feature rx-udp-gro-forwarding to initial state off
# Cannot get register dump: Operation not supported
# SKIP: veth1: ethtool dump not supported
# PASS: veth1: ethtool stats
# PASS: veth1: stop interface
# Removed veth pair
ok 12 selftests: net: netdevice.sh
```

Abhinav Jain (2):
  selftests: net: Create veth pair for testing in networkless kernel
  selftests: net: Add on/off checks for non-fixed features of interface

 tools/testing/selftests/net/netdevice.sh | 53 +++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

--
2.34.1

