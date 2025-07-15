Return-Path: <linux-kselftest+bounces-37382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470B0B06843
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 23:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E983B4467
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 21:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB128275B13;
	Tue, 15 Jul 2025 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BShpFfa7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AB62727EC;
	Tue, 15 Jul 2025 21:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752613562; cv=none; b=rtCcyjJYnez/FnPS6dWu65OrW1vsL2mox3WUGM7gBoCg/JPiIPclDZQkh28TwbWBE7mtIqxBm4Vl8xg4cjX39o9YJdB4go19170Aj9O+K2uLJxIf8kvfdgDy1XpNl3/Jh5Kb4MZ8T1s+l9bcK3R+AOlvAIJ3KTeewPKTVZp/ImA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752613562; c=relaxed/simple;
	bh=FYGfjfOp0uffIaOqOxp3So3TBknLCN3hEFHcZKI2YSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JX0l055ltuT1T9VV45LU3U4bzeHxTSB5hJra8Y3XSkYIoBRDFvIvDQJ1o7ATCA/wsickfrrUULZ1x5ByVfPa1oWP5ZJecSMP3zPsGa4QJ2Gd7EeAcsSBkQbrEjnTxh58uPt86xdUAiriH4LLC4TH80x4SL9IjeSzvEtFP8Ea8lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BShpFfa7; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so4632169f8f.0;
        Tue, 15 Jul 2025 14:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752613559; x=1753218359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xrNWGpEv1BAuId4AbOTg2+zWZrUKdhz6s19aGKtODkM=;
        b=BShpFfa70DHufToOuPE5dFMRV1FacQ4E0lItlN+FPoptYpsAamHKAttspi8zJUhMli
         i24+hR8nHg732G3lHOgzG2KoRjXhkJKaaxuk96oaj3f8nUyVdvyyO8TSdMlX4GiR+3aX
         LGmuurV+Vj9Gp59RA/O4QOXRfzG1J9ngJAZWYbtznn6SKhKWd6F6+OllThokEc6Tadma
         cGE25hN7Krwrb7LL1C3czARqxKvpkzG3fUM8496YzA3jD8bh3goPIWddVV3Mw6mzcRSw
         7X3W4jp0irKxNNU/qDOcBsWHi3hUiRplaCqKFwG1yln3lFI1RbjPuTsXDO56MXrkB4Mh
         abLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752613559; x=1753218359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrNWGpEv1BAuId4AbOTg2+zWZrUKdhz6s19aGKtODkM=;
        b=lepb8YePKZphpbeQiSGR2YvwfUHT74ru8DqoppVpCsbrxxJ3gdq64xIXvDSePRDRgY
         qHV+cFDx6hTuLJ66funw553ZUou1fII+UbP0NrALinitSA2bHcFIeyPLc45vnJRwKlZy
         94KxnZOcHfF4cU7QfFEF45SY2GyXlk6noWhTFYAwvvTfabK0S37p31PUGAXVNn9kWQPz
         yI5O2lgUDB2pbI65BthVHdePIeW1NGbF2E6ZHN4uGItS/h323f50VKyVWM/tN19FTX9y
         DDHsA9DD8IR9PcgGnInhPrJO8qN19gVfavtTn7dRhqQPZDjeBS9OtoJgqd/cs4La43zO
         D/sw==
X-Forwarded-Encrypted: i=1; AJvYcCUn/2c5dVUI0xtKBgnpZ+LekfGwnKqWb8n0H5boB+fdmRKbXMkj/ohtq/i6h3ivWVkDTss=@vger.kernel.org, AJvYcCWgp1brMjfB975Q/zYM7qigThXzFot2ZzUKOT8vhHHIwVoDe2g86goNf8J8Y+Tce36LSv+CO5MmQq/asqrCunzm@vger.kernel.org
X-Gm-Message-State: AOJu0YyagKhFVW7qV8C6v/TOz9+GW1l9jPTanviggy3Hf60QLuc3X4Us
	D1hFfP46UwKxkfES0NVLfwYO3LYAHYwTPP0gPkRqc1IJ40mIfVGmYIZf5CVQxg==
X-Gm-Gg: ASbGnct1v54RWxt5nCOImXBsdcLcT65WEQF4gz+vr5A5B2xrN5m5MJI9Jjr9GOtrMD2
	1jcwV4Y2YOilHcXIsfdE8hhPQ82V2iaRfmmJISat+NRqwal164LUZlp/7qf0PuWBXP9ON25Xj8e
	FmQEcYGqVj+zEirtLAH068jtNMVioI7gHcA5kCru+kP7+DY3iDtuw1xhCW8pp6Nu1gxzr/RZ6MI
	hILFKJ7TxeCK7aXU+hIPFbKQuYCbTToc2WPasKrvR/ua50tcSB18rPKpzqgeYQj7NC1Ugp6ld0+
	N7RgtzsbhEtgeJbd387Lq0mJSMhV1Ug1hQnmCE/PO1CK/3TPqzXHghbVI39MhFfTu1VBC25kp4E
	vk/v0787vS7ti0DdmQkg=
X-Google-Smtp-Source: AGHT+IGccMr+l6TuXlKeBOZcix9T3KSSEJKc+0G7hoGr2gWaAJ1sQCGF1RAGBN3M/xcDwUCYyKwhrA==
X-Received: by 2002:adf:b64b:0:b0:3a5:3062:793a with SMTP id ffacd0b85a97d-3b60dd72f31mr406572f8f.33.1752613558746;
        Tue, 15 Jul 2025 14:05:58 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:2::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e269a0sm15808133f8f.86.2025.07.15.14.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 14:05:58 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	horms@kernel.org,
	cratiu@nvidia.com,
	noren@nvidia.com,
	cjubran@nvidia.com,
	mbloch@nvidia.com,
	mohsin.bashr@gmail.com,
	jdamato@fastly.com,
	gal@nvidia.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH net-next V5 0/5] net: netdevsim: hook in XDP handling
Date: Tue, 15 Jul 2025 14:05:48 -0700
Message-ID: <20250715210553.1568963-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series add tests to validate XDP native support for PASS,
DROP, ABORT, and TX actions, as well as headroom and tailroom adjustment.
For adjustment tests, validate support for both the extension and
shrinking cases across various packet sizes and offset values.

The pass criteria for head/tail adjustment tests require that at-least
one adjustment value works for at-least one packet size. This ensure
that the variability in maximum supported head/tail adjustment offset
across different drivers is being incorporated.

The results reported in this series are based on fbnic. However, the
series is tested against multiple other drivers including netdevism.

Note: The XDP support for fbnic will be added later.
---
Change-log:
V5:
  - Fix warning caused by rcu_dereference() in p1
  - Fix checkpatch warnings with P3, P4, and P5
V4: https://lore.kernel.org/netdev/20250714210352.1115230-1-mohsin.bashr@gmail.com
V3: https://lore.kernel.org/netdev/20250712002648.2385849-1-mohsin.bashr@gmail.com
V2: https://lore.kernel.org/netdev/20250710184351.63797-1-mohsin.bashr@gmail.com
V1: https://lore.kernel.org/netdev/20250709173707.3177206-1-mohsin.bashr@gmail.com

Jakub Kicinski (1):
  net: netdevsim: hook in XDP handling

Mohsin Bashir (4):
  selftests: drv-net: Test XDP_PASS/DROP support
  selftests: drv-net: Test XDP_TX support
  selftests: drv-net: Test tail-adjustment support
  selftests: drv-net: Test head-adjustment support

 drivers/net/netdevsim/netdev.c                |  19 +-
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 tools/testing/selftests/drivers/net/xdp.py    | 656 ++++++++++++++++++
 .../selftests/net/lib/xdp_native.bpf.c        | 540 ++++++++++++++
 4 files changed, 1215 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/xdp.py
 create mode 100644 tools/testing/selftests/net/lib/xdp_native.bpf.c

-- 
2.47.1


