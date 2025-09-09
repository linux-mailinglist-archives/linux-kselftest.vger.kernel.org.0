Return-Path: <linux-kselftest+bounces-41023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88121B4A4F9
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 10:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4860116CF3B
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 08:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D7F23E35B;
	Tue,  9 Sep 2025 08:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1Ay7rIM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF967181CFA;
	Tue,  9 Sep 2025 08:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405947; cv=none; b=N2fFeMJqQVtmBGg3gjeH9dN1ztKnXZTXwHOI/+zfYbqCyN24cgo/DVULwOqVLMu0aglUrllktvYHq6bRmDWujbqUp2bq87cQOdmuSrHk9rR9PpM3AEv1l/raNfj7+0mUeWUNXZj8h1vWzuXuY5prilKQ2XdpsO2AjTTNK9y009o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405947; c=relaxed/simple;
	bh=UOs1D2zaTKzVNvaXvVUug3+A+pozaCT5dX8It7FgCbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i2ZXfbhQCfIeiRIC9fX7H6BhI2f92OLkm+N7imV+Vg4iEEC8yX7ujQJAHdkuurIArAgRks0KBH0Reudch9LmEiuZMhiNth0S4zWucIUMIuA0gmp+DenL2lc0p0hHcYVr4GB36PWSIwCTQZnsiUReXHKlQAs/rksPMX7Vi4gRlYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1Ay7rIM; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso3313147a12.3;
        Tue, 09 Sep 2025 01:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757405945; x=1758010745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UQCVIQ4ZNeoL3O3c1h4pVx8WIYjn5htIpwze/ZKsILQ=;
        b=C1Ay7rIMLIvw69cNSsR6wSGtENMRUuz9uJtyXfjUl3irRocRF7Aztk9970jSECrx7A
         3QgcZ59aTfcgJyPCvtjjt8uGG+Zl7QI3nX5ypxLnHuHsLfSUUsShZkk94tS29VnDgZoX
         e+k3zifv72h6qTHdnzUJ1HAjA9tSBqYJhOyEVBl+W01zhxyw9qERTFXjre9Jtxarcco1
         DK5Q13hlJBPdelYviSK2BuLNvFXNxQd/5VnEcffQwybCwSP5GC7GcfIrA1INNwA4XTLX
         U7Xh4dKG7ygbuj9qQcTpA7JQshw2szckE4uWuR8gXserbH/5EMlK04t6ALYxk4Kz21WI
         Jp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757405945; x=1758010745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQCVIQ4ZNeoL3O3c1h4pVx8WIYjn5htIpwze/ZKsILQ=;
        b=iGzRMgcr5pDAGCsWXYcbY7R2U7aFYwfwYSR+644FqVMr+QJqaLRb4AaOpm8q2etyx6
         FIQhc0oe3ThuLCu56djH+NkcyU0kfy0IH7eOC39dvUObpMHWUuymUVEhhxxbCWfiWRQ/
         f2U/XQxWod6sW9a3cVUDcDvwgC9dvj7QaGgweL6EFCGn7bpcfJkAW/3eusM9Fs8i4ZpO
         MchAI2+o7PXt0hqcvu1exrMa4bsbRTa1r/kiECyqWS9J498rHM7pdEvRhgsPavTkpfhz
         pDLXM+iToi2qSrTYfeoG/k3D9f7carACUrYWUbhvamyY/Auj4r8FgG0CuuV/MeLpdVs4
         vtgA==
X-Forwarded-Encrypted: i=1; AJvYcCVOUkFQhU4jjtobu7wKKQpaXtZiGvUBwyLdS+mt+Cf04cdjGQhtLxlf/2Atxi5u8ce79yS26L/2QuYu37/mdbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0rC/NttlDhJiSn45nqVPdhXR528LfGq5VZB3bktotMWJCb1jK
	9uCac12iMJJPNnGH734burQr7I2A5BgERFrXsL7t1r2qwavyqhMQs/yBZ69uwsdHBgQ=
X-Gm-Gg: ASbGncssYjcVzUe/vwbqSuYZBOKUL42lNXhf5iGb2lXHkFXEREU3x2G/ye/cU8oe6Nd
	FpvvH6yE8t9e6EbShDsGkR+CJHxxahlcHMeVDXhvWWR/+I3xsvwvF2TvAY/owdpUJGx8PNpSRKC
	6FRgH6IfqG0IW/a5R87LWKGbEMW4EqUSusK3zlgAB97DxUu+NdEbCUDZe8uvoCHgNKKEMs7GBTr
	PtqvWNKdybZcrOUw1jJ76IEiRXWlPefKNDvarAxZnxhz7y9jELZZKDDGostSmFJyHSXiN0GBinC
	gl/H6xfx+9Zn32v9rj+zF9G7UNGaAx95xMdvVl+pG2Qlz0lsJU4Qy7sfuakSw7nZbDmqOwNZF88
	p3AQFS5DYVgU/pBMVwYnd06v72+fs2VQBzwGajFu5sQq212Dv6vL6
X-Google-Smtp-Source: AGHT+IHOwAF6ey8JXaYopBWq9/Uhe7RT1srRJ5PBZryhDlCcrPMiCboRAz+KtxEzy/adPCaSbItKSw==
X-Received: by 2002:a17:903:b8b:b0:246:620:a0b9 with SMTP id d9443c01a7336-25176729c6fmr119760875ad.61.1757405944709;
        Tue, 09 Sep 2025 01:19:04 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c7ecd9cafsm174370575ad.83.2025.09.09.01.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 01:19:04 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 0/5] net: common feature compute for upper interface
Date: Tue,  9 Sep 2025 08:18:47 +0000
Message-ID: <20250909081853.398190-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some high-level virtual drivers need to compute features from their
lower devices, but each currently has its own implementation and may
miss some feature computations. This patch set introduces a common function
to compute features for such devices.

Currently, bonding, team, and bridge have been updated to use the new
helper.

v3:
a) fix hw_enc_features asign order (Sabrina Dubroca)
b) set virtual dev feature defination in netdev_features.h (Jakub Kicinski)
c) remove unneeded err in team_del_slave (Stanislav Fomichev)
d) remove NETIF_F_HW_ESP test as it needs to be test with GSO pkts (Sabrina Dubroca)

v2:
a) remove hard_header_len setting. I will set needed_headroom for bond/team
   in a separate patch as bridge has it's own ways. (Ido Schimmel)
b) Add test file to Makefile, set RET=0 to a proper location. (Ido Schimmel)

Hangbin Liu (5):
  net: add a common function to compute features from lowers devices
  bonding: use common function to compute the features
  team: use common function to compute the features
  net: bridge: use common function to compute the features
  selftests/net: add offload checking test for virtual interface

 drivers/net/bonding/bond_main.c             |  99 +-------------
 drivers/net/team/team_core.c                |  78 +----------
 include/linux/netdev_features.h             |  18 +++
 include/linux/netdevice.h                   |   1 +
 net/bridge/br_if.c                          |  22 +---
 net/core/dev.c                              |  76 +++++++++++
 tools/testing/selftests/net/Makefile        |   1 +
 tools/testing/selftests/net/config          |   1 +
 tools/testing/selftests/net/vdev_offload.sh | 137 ++++++++++++++++++++
 9 files changed, 246 insertions(+), 187 deletions(-)
 create mode 100755 tools/testing/selftests/net/vdev_offload.sh

-- 
2.50.1


