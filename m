Return-Path: <linux-kselftest+bounces-40514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F358B3F69D
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 09:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009A43B9FF0
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 07:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9B12E6CB3;
	Tue,  2 Sep 2025 07:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnBrrApV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7702469D;
	Tue,  2 Sep 2025 07:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756797987; cv=none; b=Qhxnd5t6+afcXu2mVuTo4JF6NRwHS86zbJ3Ay7X6ZLd0O7Z6LOUCdzTymq+dVN5uc9viRJqtVJMqyZFAxCRZlznh8pT6/NSg2TsPXo3wpUL9LE6G7k9FnEhn1QRonZzASBVG8DWpDuOomZDVyutrkKCmatqA8ubCzvzo2T37ee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756797987; c=relaxed/simple;
	bh=2G4EzO9fxCGzAIacSHn8bEFZC6l+QFGRKXVPv/xSaZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O/pa005sToW8jPSKY3F8uXLMmug6KBEebBmUgWKjqC4yDdoi3ZYxXjxYYyZSU8AD+QJGxx/jJbpo2B3CUiNthzskZUEWlCq101v/L5lPMFTxcSl7BVdL21mrAfyRSZ72EnhbTKrZbtVLcJAL6nXr89AVAn5vA3wqs6ME2pD/syk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnBrrApV; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3277c603b83so3090575a91.2;
        Tue, 02 Sep 2025 00:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756797985; x=1757402785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fdkwcPLZcouh+xTI91hgt1W1VAbAdyW6Tw3FCKoqM1Q=;
        b=OnBrrApVrqjH3xz5lZI2Q3x6rPsCjZmY1YzCNqOxGConysyd8Gni1n4hme/qTUgass
         E+lUUvekTrt6z5KUO6Z854ajcJIRypZUh0JlgZlTY+dOCpzH1FtE5nrooGBG5W8cAQwb
         XipQuXR3YzzCim7JQpjwSzW5zeVwkMMsySAzw83I+kMljnr4j+2Xz22kBl9XeH9noxI+
         HxyhC/vqxEqABFQkbsLbu8sVIKCZAjaDF+p7Gkx+vfHeiWUML5MMAn+UaB4YFpNtJQOS
         8USj0uGdCxb/7YgDHysSik8VpL8ydekavvvseR1rUdPwsmTUXC8MK/bLMhfhbg4wN6Ed
         P01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756797985; x=1757402785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fdkwcPLZcouh+xTI91hgt1W1VAbAdyW6Tw3FCKoqM1Q=;
        b=vN5MR0kXAu4Z6aVrLnkrjzvZtgF+Rbq3Lw8/jBuboQrZ3NYKAGSAJDMEKNxETc0Hlp
         HvbBO4d+TPe9wIhk1Xk7uFrlF/w/KMJo5F+3lGC8jdK5se213gPkrm79+EYzBhx+YeSQ
         /TvP4ZH2YXzBBOX7FVtWRYj1h6AbNRx7wkFIkOIVrH3q5432+2kOhjw6HYdueD/Cx2PY
         Q0w7dspeJJioKht2GOTBuyvASVy65ugs1MX7rwf2/lzdDSTmS2ijefgavcaywtoMgSV6
         DwknNp+nbP2q9+uA6/da3KRxWJOIECGlCoJCQ00CcAqGq23AAoAMj2445z8+v0/NQCat
         DwwA==
X-Forwarded-Encrypted: i=1; AJvYcCWe9pf18aQgfcP1USISSX6FvSOdZ7f18AqVYMJeT4l4xpI35Awb4oWl12Lio5BisftHxQ8qu8J19cZKrGXrflk=@vger.kernel.org
X-Gm-Message-State: AOJu0YztysuzzwEC+21KAcP4ZFwqNFX2j8YARwApJBB4MWmRz/qWm6/s
	7Ip+fF6BTlZnGzeZgk9amIkTqmF+or+Mf21+gqopOG8HzakZdNZ6/O0ZB7ELO4utrRU=
X-Gm-Gg: ASbGncsf8NWBw/gcFHK7UEVxYLFkv3pwIFGZdIbVsFEBY8GbusTK1cNtrh1NOXMYIZt
	RcTDbGgfpbmv4j0caT/XTFM84deDz+W87ItjgIeJ6rMcAQ8J3+DJBegIkfxbEm3LICdeU16N4NM
	DAxnj1WqA9d3Icz1E5L+7dZpRnD2EO4qBP+79pveq5lylZqQolP4pQSGPn5DsHjWpf28euGSnaV
	OBsLhGICf9jCJ9L6jwRrdzjxBWE5KgIcSwg3morhJV+tPUkdZn4MmalMjcsHN+y2DHXccXkC+zs
	1nQD/OBsK8UKjyY3cx21fMgaOyW7o7t68XTu9z6X7OA90LZOUPe1gQv7QahaZPRbk/4v0u+3Zme
	c8lzc9OMokDYZNlgFGbHZwffl+LkOftT3xWoYaBqmn8Rr2SKCQ8br
X-Google-Smtp-Source: AGHT+IE1KISoARlLW0+j+MAOmFpdoWDFESZ1JRv6Xjut65WaWwicfsrhz+hd0ssorH+TrEY56RunSg==
X-Received: by 2002:a17:90b:3c8d:b0:328:d94:179 with SMTP id 98e67ed59e1d1-328156dfa69mr14438586a91.26.1756797984934;
        Tue, 02 Sep 2025 00:26:24 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327d9347189sm13416648a91.9.2025.09.02.00.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 00:26:24 -0700 (PDT)
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
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 0/5] net: common feature compute for upper interface
Date: Tue,  2 Sep 2025 07:25:57 +0000
Message-ID: <20250902072602.361122-1-liuhangbin@gmail.com>
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

 drivers/net/bonding/bond_main.c             |  99 +----------
 drivers/net/team/team_core.c                |  73 +-------
 include/linux/netdevice.h                   |  19 +++
 net/bridge/br_if.c                          |  22 +--
 net/core/dev.c                              |  76 +++++++++
 tools/testing/selftests/net/Makefile        |   1 +
 tools/testing/selftests/net/config          |   2 +
 tools/testing/selftests/net/vdev_offload.sh | 176 ++++++++++++++++++++
 8 files changed, 285 insertions(+), 183 deletions(-)
 create mode 100755 tools/testing/selftests/net/vdev_offload.sh

-- 
2.50.1


