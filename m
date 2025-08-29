Return-Path: <linux-kselftest+bounces-40256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1257FB3B7C7
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 11:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C961887F89
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 09:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377AD305064;
	Fri, 29 Aug 2025 09:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5/AoNF5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24DA270EBC;
	Fri, 29 Aug 2025 09:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756461285; cv=none; b=GKH9PCjbGaotML7l3ITrn+kAfqito2BvpGpuKyQ3ZQKorgLSpv7oK8CsqfJFXV71vs7lr+KeiLTiWM9JUB1QmWoVA0RvYMIWL2THB6BxgYxySQFpollAJQ539R5oSEBCCHQrchgRTpdjn2PzbJdV7HGV738a5CkVlIHtdw0n/fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756461285; c=relaxed/simple;
	bh=bgh1fzFvQFuUXkGTaWOtXdt8WEKPCTaLk/N19SRXgA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zx+xhlKtCny4JZ8pTma08ppq+qJ9JKKZM/dEhwaUMjGNj/amOAwQM9lyhPTj9M32VZa80F/y5qDWe6NFHM4BBS47nrXv+KXEhQYGFk9VyuIMfzS6Ob3AZQsbIri3/kEa+bYlaFRsJDuh4wPK18wVCuwQhu8NCEHsLjPjCelxpf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5/AoNF5; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-323267b98a4so1580397a91.1;
        Fri, 29 Aug 2025 02:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756461283; x=1757066083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v80YyVMFDbV3jWpWkWNkuwYjTqzPpq5yZ0PoHTDS4og=;
        b=L5/AoNF5y1TAfBZ2XlELWRqXT/WW8yE3gKJ5JNEA3Bc/nND/xGjIBHk7yZOiE/Dmqa
         b6jmcBVZYCOUR/gcaf/XcZXY2RUbbPRZAb6iomqkQ5h0p1DVXBGAP1w+wZ16DRTqO6bR
         t3tPTyTKm2SfJPIKgrDVwbmSg6ggoLkt8F/Bql3GyHEcIQTQNaOJ69+72CY9ug9WGsxl
         LBoKT6V0M76r+RNDWeA6JUR9GqFZnAHHKeCOwzbIWHgzZNe1vYXD1yYbrzzZXneO7kxt
         K4odJsO1LuR6kLhBxLTsvbmXUbwD2j2aLF9hcMpwTKr+hbJuk1LWP+3PFUf3Rj+xEESV
         Z7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756461283; x=1757066083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v80YyVMFDbV3jWpWkWNkuwYjTqzPpq5yZ0PoHTDS4og=;
        b=NeDl1yVKuXIFouWECjaALDtauKMgLHN0uXviMgTD06UidJkPedyDh7xfEg2ED1ZDFu
         PhwDECDnybCnGKNHfVgO1D/jAsEt2J+mI9hSEPDiTFD3E+1GOFCZRnLOZeGT8uxENvrd
         0IepijoYSCTZZHJutlsgw2spvL0z+njF2iucOXAhcCon3+AZyZeGEXtWJPu6VLY2ryW6
         /YHY7vQc08AHkzd2blH2h9jrkHCMF35BJebTX9E+HCIYuSkFuBVmE7Xgy7J+7ae7rKDp
         yj/d9ZWZTNJVYlATs5colgrO5GQ6J9oIbk6DXxByHDI9smiGkfOlD6fwsomIFxvGclOk
         p0ng==
X-Forwarded-Encrypted: i=1; AJvYcCWCw2rBJV9kbi4xRqHtQ0w/QBJKhKQTFuwHvolKMJC6UzTArXWnTJwT/p2VHTqcH2EcHjui9S2cD67Jqa1/ZNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDO5bBfh2+WWXkkf0asrwuspIKsnqlaRNzgb9M0oyOhsVRfw6O
	XoiJo/XTsD16kD6cNeESAhmfjBkZgzNThgYmPt9zJUqVUaTLkalByLQ+jrgy7x/vm8Y=
X-Gm-Gg: ASbGncuthCh/nBuytqjfwQhzJU7anPR/jJalGsqvO6U/BEMdQf+XvOZgoP6DG+1wdPJ
	O/MJ+Vj0K+xPZMLrl3yRxkRkymNNYk44ZfhuwYpPFUsy5p6TDHysYrxUlS52sjgwrY9kbY8ctCy
	/455zGDzj8b5cYRtMdCf/ejhXjNWjKrnbvHO0uGlwhZ4+tnFVd3qVA5VCbZURxYyenQzIEB76aM
	QQ3IEFRBqj3CtFDBN9KGMlYvoRmFxmw1LkxPAnHx9VkNqrzHIjOOM4FoPmRAUaFeNh7O7KBV1q3
	PtAGyyKy9al0hT7ZG9njlWUTYafGf0BLXJFQjj87EA9fdK3UMxnzcVBIorJvixzgv7PIgmSBkvZ
	BDGTHCw1S8fjSRwPvJY5hKmEaEvH0TrBsKanvDTy40tlyCLVvO3ei
X-Google-Smtp-Source: AGHT+IG76pnCoDXhKAMPqyxKq/qZ6RUOF7vchrK3Wz4WO1MA0dj3LEo47BFWemGqy9Y/5U94MnUqmg==
X-Received: by 2002:a17:90b:4ccd:b0:327:f21b:7734 with SMTP id 98e67ed59e1d1-327f21b794fmr1329447a91.21.1756461282723;
        Fri, 29 Aug 2025 02:54:42 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd347db1fsm1751528a12.47.2025.08.29.02.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 02:54:42 -0700 (PDT)
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
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 0/5] net: common feature compute for upper interface
Date: Fri, 29 Aug 2025 09:54:25 +0000
Message-ID: <20250829095430.443891-1-liuhangbin@gmail.com>
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

Hangbin Liu (5):
  net: add a common function to compute features from lowers devices
  bonding: use common function to compute the features
  team: use common function to compute the features
  net: bridge: use common function to compute the features
  selftests/net: add offload checking test for virtual interface

 drivers/net/bonding/bond_main.c             |  99 +----------
 drivers/net/team/team_core.c                |  73 +-------
 include/linux/netdevice.h                   |  19 +++
 net/bridge/br_if.c                          |  22 +--
 net/core/dev.c                              |  79 +++++++++
 tools/testing/selftests/net/config          |   2 +
 tools/testing/selftests/net/vdev_offload.sh | 174 ++++++++++++++++++++
 7 files changed, 285 insertions(+), 183 deletions(-)
 create mode 100755 tools/testing/selftests/net/vdev_offload.sh

-- 
2.50.1


