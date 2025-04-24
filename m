Return-Path: <linux-kselftest+bounces-31475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34943A99CF3
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 02:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20513ACC83
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 00:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CFC1BC4E;
	Thu, 24 Apr 2025 00:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Irk3iess"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF361A28D
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 00:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745454495; cv=none; b=WPPI7mHHvs95FpQGStoIQbdFM3xWQ+yqB3vVD1FE//xQSLmBHY939x0cqy26nd9X3vBOjX2Q5C1KhSbMGToFxUHIzD11gejMhXh1lWAnjpWNDIKXLPPOayjjpQPqNGCGqBYz6F5r8ACw4FS/3VgwBl6KldIr3IMgNNhgxdT3t70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745454495; c=relaxed/simple;
	bh=h8wAY7qtIy5UrHIDhwmDC5fKfwUd64U5Lep9H+J6vLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eIDwFVJi3mu4+/7/wZA2GOiJQ98+/9PY/wvsvUhC28ZrX8a99n1K0XTL8j+4fXbx5lcCoSIXAdaDVyPR33VeOe8S7Ph9rOcioh0HyziEe9X8y9/jhHSWyTuHFPI/Mata4OZvczQkWq5gYBeW39lKUeGz+A/VjvTk7+ixbqbCvgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Irk3iess; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-301a4d5156aso508596a91.1
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 17:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745454493; x=1746059293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KIHmcKmXhg69DmaElnA5LLW3gaVd1eMpD/hTU28A/HE=;
        b=Irk3iess1ZWp76vpIqY5KPFENe546uefn8gu0FUv4zFwws9WeEWpYwLJhVFzmtGIJ/
         9NymRvz3kZ2/UGxkxTyOq7NsHOel9Bexar/PuFA6mjIMCKul9TJzb8r7CaSm5jS0HWOl
         sa8u4cOsXO8vdoSuPh/cq2Izhdy+ZBT2rXb+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745454493; x=1746059293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KIHmcKmXhg69DmaElnA5LLW3gaVd1eMpD/hTU28A/HE=;
        b=apsTQbirwbOh3IMlaAIs2TEXkFzdx0L63CA9he4EkA9K7K1btnrH48XouXgFes567g
         68OFtOerxbx0fL0SZBquYSbweVc37GQbTSIlo7583cPyc+bMovCBbQB6QABd7iAF9z5n
         VDyf/zk/5jWkH6hBEj3fg8n814FryXwjNurekAnxZbIIpdDUBH1ocIAVEZEcFQNqkDNj
         GesmGOOLvfTWe6Uc7ehndERuTa6uLJFhRKTotTSJ+oG0vLM5Li2ABRloGA4tUIk+WA9J
         lFmTiT5LKiwFzfhjGyomctHJFuJ+Bqm/oMXLhZG+NYZL9CYQK5PaWEzfHfGvT344Es2K
         bimQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/pyGGxuzq0S6z8Tb5DZepmCdNSDuq00HCy64ucVZii92I+w88aEocfwFLmpjT1lovR2GK2mybFiVkoBWFK+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpzs5nCklIyOdi8zGv7XWtD+6z7GqqkB8I4I8dA+Ws8BOQWIyj
	Hre9D4OICbxQDZ6cW+5XTRib9O9KGVO6LYFj66o4Ct3Dw7doLSYl8x5G46lC8n8=
X-Gm-Gg: ASbGncts0rmOqFNQliTrvlY6WFEZLLZVMwq6uT3bjcIcWLDaPJwaUTz9ot3PGr6Nqoj
	I3tFLnwJOL3PijQSbxX+EWGHe6GtIX7Q5yK8cFyug5tglSDFyuNK5GdDVz8WXnKdBpioLClLNtV
	FuvewVNQdER5nXSoRtRga9Y/CDWl4b8eWKbqUm5hNdXpQra8y18utSRVgxU+kt3N3WZn3gVayXF
	OO0BmWGUR1tx3hT4HpQiBBeFYeLyzdNJ/V1Z/RBhtEGLeFVvFM5F/wa+pLDdB0CGFq7DXSlcN+h
	Z6Q2qKiNG88IfdZGOjo59jYvkyF9C69BNyURCvhK1dYKLotS
X-Google-Smtp-Source: AGHT+IETblWxuoSuSV8+WUwaLohHsvmGk7SHFO08yaKEGr+w9ecMqwtPnCysdbaJTuia4bAV484exQ==
X-Received: by 2002:a17:90b:584c:b0:2ff:53ad:a0ec with SMTP id 98e67ed59e1d1-309ed2821damr1082565a91.21.1745454492678;
        Wed, 23 Apr 2025 17:28:12 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ee7c4054sm83013a91.23.2025.04.23.17.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 17:28:12 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	shaw.leon@gmail.com,
	pabeni@redhat.com,
	Joe Damato <jdamato@fastly.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_)),
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net-next v4 0/3] Fix netdevim to correctly mark NAPI IDs
Date: Thu, 24 Apr 2025 00:27:30 +0000
Message-ID: <20250424002746.16891-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v4.

This series fixes netdevsim to correctly set the NAPI ID on the skb.
This is helpful for writing tests around features that use
SO_INCOMING_NAPI_ID.

In addition to the netdevsim fix in patch 1, patches 2 & 3 do some self
test refactoring and add a test for NAPI IDs. The test itself (patch 3)
introduces a C helper because apparently python doesn't have
socket.SO_INCOMING_NAPI_ID.

Thanks,
Joe

v4:
  - Updated the macro guard in patch 2
  - Removed the remote deploy from patch 3

v3: https://lore.kernel.org/netdev/20250418013719.12094-1-jdamato@fastly.com/
  - Dropped patch 3 from v2 as it is no longer necessary.
  - Patch 3 from this series (which was patch 4 in the v2)
    - Sorted .gitignore alphabetically
    - added cfg.remote_deploy so the test supports real remote machines
    - Dropped the NetNSEnter as it is unnecessary
    - Fixed a string interpolation issue that Paolo hit with his Python
      version

v2: https://lore.kernel.org/netdev/20250417013301.39228-1-jdamato@fastly.com/
  - No longer an RFC
  - Minor whitespace change in patch 1 (no functional change).
  - Patches 2-4 new in v2

rfcv1: https://lore.kernel.org/netdev/20250329000030.39543-1-jdamato@fastly.com/


Joe Damato (3):
  netdevsim: Mark NAPI ID on skb in nsim_rcv
  selftests: drv-net: Factor out ksft C helpers
  selftests: drv-net: Test that NAPI ID is non-zero

 drivers/net/netdevsim/netdev.c                |  2 +
 .../testing/selftests/drivers/net/.gitignore  |  1 +
 tools/testing/selftests/drivers/net/Makefile  |  6 +-
 tools/testing/selftests/drivers/net/ksft.h    | 56 +++++++++++++
 .../testing/selftests/drivers/net/napi_id.py  | 23 +++++
 .../selftests/drivers/net/napi_id_helper.c    | 83 +++++++++++++++++++
 .../selftests/drivers/net/xdp_helper.c        | 49 +----------
 7 files changed, 172 insertions(+), 48 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/ksft.h
 create mode 100755 tools/testing/selftests/drivers/net/napi_id.py
 create mode 100644 tools/testing/selftests/drivers/net/napi_id_helper.c


base-commit: cd7276ecac9c64c80433fbcff2e35aceaea6f477
-- 
2.43.0


