Return-Path: <linux-kselftest+bounces-38955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DCDB26323
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 12:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699515E25EA
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 10:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20482F83BB;
	Thu, 14 Aug 2025 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFZEZUNT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740992F39D5;
	Thu, 14 Aug 2025 10:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755168198; cv=none; b=LjuuDj5Y4hb9rY2JDgZFbfbi4ddb1gyOp18Iugfsfmq/A0bU5hwAf2RS1JXt2ISEveLtX3xsIReVmGxUrozFNzqfi8lX5Ir8/oPBUSvUvpP7M0Md3Tnj5nlyzQMqxDRylQNIdIHRijyUDU+ncsHTTSrhlfF5B8c+kvPe8jP27yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755168198; c=relaxed/simple;
	bh=ByaxPKIOOsSpAmqsDB0Mq3lT1GdJT7b79vpjsbOysw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O53WghFBUODwcFiZDALvWxZx+WeohGPI40E3miNfF8Vwjwo0NHMTmnnGgs0mctb0EEgjDwCMKpM2Z98XmRgFSevXQKL2FU7q9hZDBCaIT8FkP28VmO0BZYW9QW4d3GTBwVJhUT4o9u18fQKkubwbJHV1MeNbjH0BsJqjRsDL4mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFZEZUNT; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b47173a7e50so589241a12.1;
        Thu, 14 Aug 2025 03:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755168195; x=1755772995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NQQrI7equ/7Apuzl/jQOdd++HWjACeEFbFrTaZ0NeVc=;
        b=YFZEZUNTIrOnbb2x1lGE1MIb4iu9/eriu8nXIugf8mT3CP8vPVW99vkQBpnCxY0c2z
         9CllxRBviPb0kSv4TMzBXycltb4Aqj5Scr0a563VOHpNqAGbaEBJ9bWFs+v3Iljpn0T0
         ZX/NATbHBIeheerB99gnNzxcGxp5xPVRDk+QynRXW3ff+hUXUxTFpF7Wx6Jd1qKu7t5+
         nCWZ0rCeCfJih1geRl1sc9gPCJaazgCcoYkIC84x+9y47uzVcL9Avc1SV+GvsX4xJH0L
         5rzdMAnumaKNRFa5XfveTvhzkz+k5deNwT/rCQAg3t39yLAwc3sIJssoIcMGDYRq0evq
         /7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755168195; x=1755772995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQQrI7equ/7Apuzl/jQOdd++HWjACeEFbFrTaZ0NeVc=;
        b=M7IleBZvuh2tqORiVxq9oE9pOB8MfdGQkn2dHGgNIN422phJI6SnL9Jlp99aLn5KA7
         7YN/YB1RNULGvMXG2MKdA/XN1fGhnDp0q0g60ox0odd2IAdVNy4pkM10aZJJk3c6/vFQ
         7oupG8ERf110KW04UYnjmJfZTl78risqxtZAtk+ppQ2GUadXcwfrBOaU6m6UkZryOXVY
         yuqMixYtPGHUZQgi1dXD8aHXWModShxE2mnT3JiW3qAWPM7aeO3kUjSEAg9pgponMNMF
         /BJoiVy2kMvga5fiL28/LJXQECkJGQNvOQEAj8fgEGLIMRWPf+38xi0GrOnaswIMhWi7
         malA==
X-Forwarded-Encrypted: i=1; AJvYcCUMbcIt53UbOU/PSZscYb7a2LMSxhOf8fGWHHAjbnIuZ/QssAauF2vRBWzvypOk5JEgeRCuKnHlzSvv6QMH7nyK@vger.kernel.org, AJvYcCWh2bp8tYko/WUyYDK/SBfVvxZhThL+u3GJQ0xvPeUI+ewzRZO4PsXRQIR+VqQDEnXi/UUzjWRGRvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuMH3SYSHuHa5QM3Y7TY93sqS/mnLoJt4YpTdTpbU48bCwg49I
	HpwkyT2haP7BaH3f+a1lJ/vGDxa4AJuyOqtiVHxlmJWCRpqGPJeZz+iBmbdvLVma
X-Gm-Gg: ASbGnct3cwS6EmIojqaZ6014Jz4etgxWRo6eDg9XOIcs4D2bnwaXl87TcCjE2mXwFX7
	1oHBKY+A6vGyyv4XLAgZhPN3rtRFZ65vryiHNNK9uayqWtLZH0qHrQDma5NPkmkgmSfDNuYA4Fo
	LNWZh3qoEF5MGXimVhjdG4jQWET6CgbQLhPDWjjkvMa5KAEsxd7yVRlumjmXM5A7O6XT75jBTWn
	AzdnOnzZE33LpPyz+d4NqFR+jRQsfRSBVz4jnkW7uHPpPrUU3x+H33HUuq+bZbF2KnxxslLpsrT
	O/a36bYhQ9DOHaYiaPdJ+2V6pymVEv+yLnslSoOzykm0AJ6csf2XUJ7I6dIgzV5u67iyG3g5mbV
	JIgPVOmB84g4nobRHWXjHpBDrDjjPo9clN8GcBwIWrw==
X-Google-Smtp-Source: AGHT+IFrxnbMnFTrneqJzK3CsUad1WU6U11pJTdSkCfwczVAOD+xvDSRYuVuFDDf9/y+3vylk9r3EQ==
X-Received: by 2002:a17:902:ce12:b0:243:e3:a505 with SMTP id d9443c01a7336-244586f2595mr32018195ad.57.1755168195448;
        Thu, 14 Aug 2025 03:43:15 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976a1csm351796225ad.78.2025.08.14.03.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 03:43:14 -0700 (PDT)
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
	Jonathan Corbet <corbet@lwn.net>,
	Petr Machata <petrm@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 0/3] bonding: support aggregator selection based on port priority
Date: Thu, 14 Aug 2025 10:42:53 +0000
Message-ID: <20250814104256.18372-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset introduces a new per-port bonding option: `ad_actor_port_prio`.

It allows users to configure the actor's port priority, which can then be used
by the bonding driver for aggregator selection based on port priority.

This provides finer control over LACP aggregator choice, especially in setups
with multiple eligible aggregators over 2 switches.

v2:
a) set default bond option value for port priority (Nikolay Aleksandrov)
b) fix __agg_ports_priority coding style (Nikolay Aleksandrov)
c) fix shellcheck warns

Hangbin Liu (3):
  bonding: add support for per-port LACP actor priority
  bonding: support aggregator selection based on port priority
  selftests: bonding: add test for LACP actor port priority

 Documentation/networking/bonding.rst          | 18 +++-
 drivers/net/bonding/bond_3ad.c                | 29 ++++++
 drivers/net/bonding/bond_netlink.c            | 16 ++++
 drivers/net/bonding/bond_options.c            | 37 ++++++++
 include/net/bond_3ad.h                        |  2 +
 include/net/bond_options.h                    |  1 +
 include/uapi/linux/if_link.h                  |  1 +
 .../selftests/drivers/net/bonding/Makefile    |  3 +-
 .../drivers/net/bonding/bond_lacp_prio.sh     | 93 +++++++++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh | 24 -----
 tools/testing/selftests/net/lib.sh            | 24 +++++
 11 files changed, 222 insertions(+), 26 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh

-- 
2.50.1


