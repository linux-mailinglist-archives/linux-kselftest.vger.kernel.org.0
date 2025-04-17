Return-Path: <linux-kselftest+bounces-31026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9B6A9112D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 03:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEE333B2C0B
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 01:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955D31B393D;
	Thu, 17 Apr 2025 01:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Niit9KmY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BDE12C499
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 01:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744853588; cv=none; b=M5p2ssK+Oqw12ibyV6rb/7j7VxCzkZS0flRnm6ijDlYvAoadIbpdkoBx+CS0Jp4FqzdOlYdGWlEdenJdfsrnFkjr7nr+j57FSypJsrVdOIhrdLmw5A+pQaydcRp5lA6zyiYOBgfG4Q4CxNgy3XCQ969EU8pERLn0CNcb0iRrHcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744853588; c=relaxed/simple;
	bh=2xULYgcWmIJIehHFYM/bibVezPdaJmAJv90YTx9g74U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RZGVL8YcBj7U/ca7TGdW5/tZo+GKQym6YeMqrSdNnubERjaBpN4U1AJJ4YHx3DEAQnjbxctA81Og87/AhW0dX5TzlpWhVMhLH9NlyE0/RQBVsxGicwM+IM8+pFD7vZq3BWNAZpoM+ny8qYRq62Ll+Gvhpfyt6ImRP5OQ4F+hO3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Niit9KmY; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2255003f4c6so3180185ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Apr 2025 18:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744853585; x=1745458385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cl7lm0q1pdo1TJIdPWC7UtnUlQ76D/cDOJLKOcjE6io=;
        b=Niit9KmY+zeqZb+KOolZ0UPw8k+9oFE9HAUxH+EOggwLn0LbFnpTqB7MfJyHqc3jYz
         dskzprgL1yZRgw4itsd7cz188OasiYGAbtVbw2KnKTKziHlS2ZQy0dfkoMvQpkqANJss
         BP1B3dONTAbPh1auPbTt4EqMAVe9IuB6h1UEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744853585; x=1745458385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cl7lm0q1pdo1TJIdPWC7UtnUlQ76D/cDOJLKOcjE6io=;
        b=N/PjLWWS7APl/ej9H8cBkJ+kRQp1cnZ59oqW4X0itOZE91QJnQPsF4pFVSAhHcZ5A2
         RRzjBAKOVLB0BVQc1KkzfsqbXRoEqLr7/ZedeBZLw6mEcjwMZ9Ujp+wnPoz2QdXE0ocX
         wary+I2zDwOJPEbrHFEyROCzPp2bY00lCTal0d3jsCV5Dd6zxWteJ8yVobHAOAVW9McE
         ovzGha/4hHVK6+ovg6WVAjs/IIPMvgsO7jqlxSr2w4JqfIWJPdnAG5Z6+zCdkVKZGuvE
         rvv9wUMls21x53gTWRkqM+h8pSC9yyqhis54YvsDR/O0QoTYocIHqN9acgd4/WBFz3GA
         ImkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQSNt1Fmp/JnEAwVYI3z9QCk2UlVYkrZ0EHNJhYi1LlegsAIa89hz/KZaFZPpJ+jRV4ekF/owVXv6f02VD2tk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1im422YsBJGOzK3tOyzEw2RfzeuuU4EyvHvI/dlrpvkfoKE8w
	0liqjofvQ8EOAzryKstUpVV+aFxIMKnMEbZLBkQa3vcBonZgwLvMrql+Vo6t604=
X-Gm-Gg: ASbGncs8lsnr0SXtjLu3dvCi2h91LG+Ch2OjfygtctEac/Qbs5u1ZVkKG0YlQiIufiC
	uOyTEwtu8Zis7VmtcFmHQ0CGMEwuFP1PPv319U6wrrxqZs+Nxcc49VIloQkzWFQS07v8fUlc2U1
	C5lgivXjxU1leT8pOib3CHffeIMVIWUKI70hklyqw4fBckcz1Sx8s3EluA1QuovxqjBcbdfT0h6
	IG4exf7Hnc3ljekYun3+6KYb6+uJTP5nTyNLhNDaHSD15BbGjCefH89FIVk99/eqYPcH0M6hAfq
	3eMkr6XU7v4UgxhWSeKpjw3edu1MaPBzOhziIUuDXaRd4FiwQgD1YWEmNig=
X-Google-Smtp-Source: AGHT+IEfKQ+r/gnTBZHe1EymGe3tKAmJ5TO38k1pfoylMUgPGDSds01vW9UdN7R4QlZfSpduWCIKYg==
X-Received: by 2002:a17:902:ea07:b0:223:5c77:7ef1 with SMTP id d9443c01a7336-22c358dae13mr58260805ad.21.1744853585258;
        Wed, 16 Apr 2025 18:33:05 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33ef11c7sm21349505ad.37.2025.04.16.18.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 18:33:04 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
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
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Xiao Liang <shaw.leon@gmail.com>
Subject: [PATCH net-next v2 0/4] Fix netdevim to correctly mark NAPI IDs
Date: Thu, 17 Apr 2025 01:32:38 +0000
Message-ID: <20250417013301.39228-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v2.

This series fixes netdevsim to correctly set the NAPI ID on the skb.
This is helpful for writing tests around features that use
SO_INCOMING_NAPI_ID.

In addition to the netdevsim fix in patch 1, patches 2-4 do some self
test refactoring and add a test for NAPI IDs. The test itself (patch 4)
introduces a C helper because apparently python doesn't have
socket.SO_INCOMING_NAPI_ID.

Thanks,
Joe

v2:
  - No longer an RFC
  - Minor whitespace change in patch 1 (no functional change).
  - Patches 2-4 new in v2

rfcv1: https://lore.kernel.org/netdev/20250329000030.39543-1-jdamato@fastly.com/

Joe Damato (4):
  netdevsim: Mark NAPI ID on skb in nsim_rcv
  selftests: drv-net: Factor out ksft C helpers
  selftests: net: Allow custom net ns paths
  selftests: drv-net: Test that NAPI ID is non-zero

 drivers/net/netdevsim/netdev.c                |  2 +
 .../testing/selftests/drivers/net/.gitignore  |  1 +
 tools/testing/selftests/drivers/net/Makefile  |  6 +-
 tools/testing/selftests/drivers/net/ksft.h    | 56 +++++++++++++
 .../testing/selftests/drivers/net/napi_id.py  | 24 ++++++
 .../selftests/drivers/net/napi_id_helper.c    | 83 +++++++++++++++++++
 .../selftests/drivers/net/xdp_helper.c        | 49 +----------
 tools/testing/selftests/net/lib/py/netns.py   |  4 +-
 8 files changed, 175 insertions(+), 50 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/ksft.h
 create mode 100755 tools/testing/selftests/drivers/net/napi_id.py
 create mode 100644 tools/testing/selftests/drivers/net/napi_id_helper.c


base-commit: bbfc077d457272bcea4f14b3a28247ade99b196d
-- 
2.43.0


