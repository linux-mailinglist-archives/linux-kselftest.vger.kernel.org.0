Return-Path: <linux-kselftest+bounces-15636-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56ECB956A8B
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 14:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13D1B281AD2
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 12:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9868168486;
	Mon, 19 Aug 2024 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRyvU9yZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4970914EC5D;
	Mon, 19 Aug 2024 12:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069579; cv=none; b=qtew3uohjvlD3ULAGF0o3oxKRRvKKU+k0JIX7DO3kQRyJAKUqyzx88Yn1lRT8jVV/mC7v/iVC+UGPkbh3KNDX2bM+6koXumC6bSvWImsHM5WX6+oUCXi20DOZswBeqvQMKtI+/vkVBmU6dinFnDPM6kdWBXZlvEJici6YFmzjuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069579; c=relaxed/simple;
	bh=cApv/0vB46wt/bl/zg4yD4yW7qejN5Hnwhk1ZDwSG5A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ceEY9NuIfw+83Ir3aoaAzOp9QA9LLK5Yq0Z6DjMpUgeIP/5ZgdmK6NgF+CslWATqkcdybNTsdWUlXegGtbBdiYg4ckE7G4X9kES+Kvex1c+oUfJq9AUaBTFARw2cHg/kL02vcxBuF+TFH4okV/C79ayQCMn95O0zaZ0/bApyuyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRyvU9yZ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70d25b5b6b0so3019314b3a.2;
        Mon, 19 Aug 2024 05:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724069577; x=1724674377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yDLH4aOA6ypJuymjozWklFnJ07QX/Vl6rLcVwo8MiNA=;
        b=FRyvU9yZG6czdPYDjU4wTjNjTRiTr2d/Hbr8x3qbhAWmd4gJqHQIL4+nqr4KNYKPFw
         kOAHfSJqCrt2BOl1esG4LAQ2Ri2kHKwqMeTNYdjifXgBY9RBzuN237r+pXz4nQ5gIZD+
         WTne3EJ17RYW9txb3oyoUNg+PlI/JWXl6DwFJBK/DeJ80ogp1mXyIDYDb+/KMjugmbM4
         0hYwGts1q+jPS6C+U+eRrqDjMCDJuzkuDew+Ev71RNsUhuJaZLdYVtx76QxwhGrtk6K3
         ZVEcos6RSsMbMfFiD4XI5h0sYDkpePzmTSJ7H1fKOoVMoHxA0fFSWhhHlJyGAWAOBtcJ
         Gxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724069577; x=1724674377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yDLH4aOA6ypJuymjozWklFnJ07QX/Vl6rLcVwo8MiNA=;
        b=NlaASozIwsi6f3UrOKjfJX/OKNMIh4znM66sklMLoN5bV1QU+jCHw3mIgCrgHrPZ5S
         qHDmQw4jF12rBxu8ccqe8OQb5F+wjQ8XEMYzA/TioXGiTNAzAW/ji+B9J6tAVKexMyMQ
         zztnkE7Pexh8AQavWM/yJRD5JgPx/8XfyI29ABW6sGjqhFiyr/NgPiBBG1ziH0EvY7A9
         rnsnTUvwLccjkg0lXak9D84PBb8Z1Y46bMZ43Au4anVHuSLzkDhnqlMyg6aZEc3oDi6p
         SrSW3B36TQDyYaboncixw5R3bs0Zs/KNSO/nPP/lFiRBGdfop2wG5xkSNek9LGTl4DUs
         5KsA==
X-Forwarded-Encrypted: i=1; AJvYcCW5uYA16C/ZoKovMrY/iMkWnL8gbAwSuWvvpNVk1+GL6xikhw3P8SRbdvEvSCUFkKduMiywxFG9/zr4M4/QsIbIvMH0e0OczKHZLdXxM//nw6t6JIxhXj5hd0NgUtnp0r8nf0lMDLn58DP/0ji9HNqSygTbxnD3vcqQfCzlQac6/lbXVdk5
X-Gm-Message-State: AOJu0Yzu0dg5kyf5fnXIOWUU/SWre9Q8CwJZXeUa94T+o7THoyPV9qMl
	x2vyxZvy+UHQfY1xzXhMLEnR0DBrria4f5360lCzzJAdyB/udVE7/M3RwA==
X-Google-Smtp-Source: AGHT+IFeFDQZCHvvoULRrRufpyLEcH6B+hTXY6nzthD3VG5bAuB7hTq/DV503Vly/FoAltGc7dWR7A==
X-Received: by 2002:a05:6a00:1996:b0:70b:1dcc:e5d0 with SMTP id d2e1a72fcca58-713c525113fmr7095558b3a.30.1724069577335;
        Mon, 19 Aug 2024 05:12:57 -0700 (PDT)
Received: from dev0.. ([2405:201:6803:30b3:1f59:cb71:c749:d10f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef4136sm6501798b3a.100.2024.08.19.05.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 05:12:56 -0700 (PDT)
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
Subject: [PATCH v8 net-next 0/3] Enhance network interface feature testing
Date: Mon, 19 Aug 2024 17:42:32 +0530
Message-Id: <20240819121235.39514-1-jain.abhinav177@gmail.com>
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
Tested using vng and compiles for network as well as networkless kernel.

Changes in v8:
Remove redundant variable initial_state as per feedback in v7.

Changes in v7:
https://lore.kernel.org/all/20240815105924.1389290-1-jain.abhinav177@gmail.com

Create a third patch in the series to do SKIP -> XFAIL replacement.
Add logic to incorporate XFAIL on setting IP address for veth pair.

Changes in v6:
https://lore.kernel.org/all/20240814191517.50466-1-jain.abhinav177@gmail.com

Use XFAIL for ethtool operations that are unsupported instead of SKIP.

Changes in v5:
https://lore.kernel.org/all/20240808122452.25683-1-jain.abhinav177@gmail.com

Rectify the syntax for ip add link.
Fix the veth_created condition check.

Changes in v4:
https://lore.kernel.org/all/20240807175717.7775-1-jain.abhinav177@gmail.com

Move veth creation/removal to the main shell script.
Tested using vng on a networkless kernel and the script works, sample
output below the changes.

Changes in v3:
https://lore.kernel.org/all/20240614113240.41550-1-jain.abhinav177@gmail.com

Add a check for netdev, create veth pair for testing.
Restore feature to its initial state.

Changes in v2:
https://lore.kernel.org/all/20240609132124.51683-1-jain.abhinav177@gmail.com

Remove tail usage; use read to parse the features from temp file.

v1:
https://lore.kernel.org/all/20240606212714.27472-1-jain.abhinav177@gmail.com

```
# selftests: net: netdevice.sh
# No valid network device found, creating veth pair
# PASS: veth0: set interface up
# PASS: veth0: set MAC address
# XFAIL: veth0: set IP address unsupported for veth*
# PASS: veth0: ethtool list features
# PASS: veth0: Turned off feature: rx-checksumming
# PASS: veth0: Turned on feature: rx-checksumming
# PASS: veth0: Restore feature rx-checksumming to initial state on
# Actual changes:
# tx-checksum-ip-generic: off

...

# PASS: veth0: Turned on feature: rx-udp-gro-forwarding
# PASS: veth0: Restore feature rx-udp-gro-forwarding to initial state off
# Cannot get register dump: Operation not supported
# XFAIL: veth0: ethtool dump not supported
# PASS: veth0: ethtool stats
# PASS: veth0: stop interface
```

Abhinav Jain (3):
  selftests: net: Create veth pair for testing in networkless kernel
  selftests: net: Add on/off checks for non-fixed features of interface
  selftests: net: Use XFAIL for operations not supported by the driver

 tools/testing/selftests/net/netdevice.sh | 61 ++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 4 deletions(-)

--
2.34.1


