Return-Path: <linux-kselftest+bounces-27419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D9FA439EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 10:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E89B63AF1A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 09:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24CC26138C;
	Tue, 25 Feb 2025 09:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYICDjSq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472F62139C8;
	Tue, 25 Feb 2025 09:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476460; cv=none; b=GbTzkc7AfntIM5m1xZfcwMsKMA5FLgjCoc9mmH4fhKiDLxfnBcdsXFvTdE67qXUlt8ygjKVZBajnP5oBJdrMxxZtopGImxvhijFVgSVtNCrPlkEbqez3SHOnGz4iUxR8vXU4lFI4JU57WuOR7Vz1OeSbvqc3elIjucOBytj3YsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476460; c=relaxed/simple;
	bh=HU7YrCSOKlhUhH+jPehuRHs6KX1rnYdknZ7MDxwzrmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mAvFQkY6ScxYp2EbmIbOQR41+eZe5LTmD9wD3Md5Ks4vx4NlB1GNoCnwRHncOet/wCh3pr0Y4RssvbGOEpk8SE4QwSVLMvzdTMYExzCr1yuAzdeSNbCgv10rXHATAHyoARTHILvATytynMniFyJWx1gYL91xD+fo4P8qKFKVJGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYICDjSq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-219f8263ae0so112452165ad.0;
        Tue, 25 Feb 2025 01:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740476458; x=1741081258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUnQ49xocVEo+4W639fekw7PlmecA3NGgOg9BDPiz0o=;
        b=PYICDjSqueR/i++yk5SscipSIpw8zc/S0eeNVnmG7G3tzrou18MdknMETKpcyhCS8y
         2NllbW24YgQwrInJXohGZzdgS5khSvOWhWZ3H0XobDTZo+yS4g1HS/22OBI9V8xB++F0
         d6UhDM+FXUJt3BlZvsmGwn/wWaeIZ0RlKaWNj0077jMfgisnTp2ov1I7P64HJZCHPlVr
         9iFNCJrFHf0QTv9d/tSUdcFEK6PNZh9g8SjL3wIZiy8AN3tHFtWTvB5nQ6cXtXBYIsT0
         G4U1JpMVQ5y2sCYy0xw/QW12kvIogJK6uAhe2/caUuO8Ekpokvflp68hXu6KdPyr3hHb
         c0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740476458; x=1741081258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZUnQ49xocVEo+4W639fekw7PlmecA3NGgOg9BDPiz0o=;
        b=sqRWGHxlSsSMY7YgwIULTVe2jTRFyugDRPv5rnKvt6/wf1TVU+ePTLmEtk6X6rc9rK
         XTcjT1PncCYb5g7AdFc+Cct4TCN+Vc4eA/h2YzDRAJ+hVBdWjuUqNjx6BA5kV/OtIm98
         M4+EnCWqKRjTwali5nslbT8RvstxgTCtXY8dGo6R5hNnXQPBw4Koa27BJwRFLGZBUrs8
         WXNmLtk9I6JnvKj6tRjTH2MINXeJaY6rkxbI8igSRQ/66j27S/cRgoI4KCRwVcCep1jO
         jb43CHEAcn9eQlqoihaGcwnN9lURYAHwXOb3PISwhfgFRaf5aGY7mQf1nU5JtJswG8XA
         PQ/g==
X-Forwarded-Encrypted: i=1; AJvYcCUyMbCgBdBw9rMHy1Xts4y3r/ONeJhzEX0BvFQFyHUJcR+2Lc/pXPhv/rrS7O09fFX2eAcAL9K2lauxkJps36Dg@vger.kernel.org, AJvYcCXKQI2u+BZmIXmM2uGoydXJpBp9xXoM9HBWw5ucdzrOcZRsr8kCdLKiTl75ZtxCthsuGFrIT8AfamF7Kuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaBZ8fckK91bJQg2vSO3opQPo6TTVKGPft96LOBXprwKlzm7r3
	bItbgRvJkLb9alynojFZFPF3vSj2cYsdXYxX6ISa9SWRzL83rNYlnW01h+vSsKBPEw==
X-Gm-Gg: ASbGncsLh4tF68DrKu/W546Vf+PBeBGRLW2utoFcSH3jFD4SVri5raSnk30MWGV4llg
	LVGSVDAx5yBwyqW854h4UeVBTGU6c318v0VRuur3p4ofRaqrPkQpFM03o9+TIlerQjaBBOR9Tap
	1Bg+2kotPPBjNNGV/5h2oB1GN5Ep8OixYg+dUzTF9hkjcXBnRjVLXcbYi6lGujbnKuBJqIXE6kW
	HV1TPelOL/VH5rSytkZCwoMdDWEsBww8hrMjgTI09H6+THn/F9xHlv7ytfsTzMtnxQo2NfqrPyF
	MUEgZgB1Uh13WxZsazYcLb+YmLDh+USkkwA8vU7MQ64Kpw==
X-Google-Smtp-Source: AGHT+IGsZlRQkzS+G8gVYWA2C9Yx+g1f3g9kKPPlULLYG2liKAVwngq0X1ZRp8n+Njl9DLAXQQHWIw==
X-Received: by 2002:a05:6a20:9e46:b0:1f0:fcda:ce63 with SMTP id adf61e73a8af0-1f0fcdace8dmr4447982637.20.1740476458062;
        Tue, 25 Feb 2025 01:40:58 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6f9e6dsm1065597b3a.64.2025.02.25.01.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:40:57 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Jarod Wilson <jarod@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net 0/3] bond: fix xfrm offload issues
Date: Tue, 25 Feb 2025 09:40:46 +0000
Message-ID: <20250225094049.20142-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch fixes the incorrect locks using in bond driver.
The second patch fixes the xfrm offload feature during setup active-backup
mode. The third patch add a ipsec offload testing.

v2: move the mutex lock to a work queue (Cosmin Ratiu)

Hangbin Liu (3):
  bonding: move mutex lock to a work queue for XFRM GC tasks
  bonding: fix xfrm offload feature setup on active-backup mode
  selftests: bonding: add ipsec offload test

 drivers/net/bonding/bond_main.c               |  43 +++--
 drivers/net/bonding/bond_netlink.c            |  16 +-
 include/net/bonding.h                         |   7 +
 .../selftests/drivers/net/bonding/Makefile    |   3 +-
 .../drivers/net/bonding/bond_ipsec_offload.sh | 155 ++++++++++++++++++
 .../selftests/drivers/net/bonding/config      |   4 +
 6 files changed, 209 insertions(+), 19 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_ipsec_offload.sh

-- 
2.46.0


