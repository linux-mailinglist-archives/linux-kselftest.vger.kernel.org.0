Return-Path: <linux-kselftest+bounces-37032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CD4B00B91
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 20:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2FDB168D75
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 18:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB002FCFCC;
	Thu, 10 Jul 2025 18:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OS+1iK8N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0F72FCE13;
	Thu, 10 Jul 2025 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752173111; cv=none; b=B3wCmhS+NDNXH4dv33WYde9pyi8ON/fgtzW4v04kczjsc4U5hP31+4jtyZwULMz1DMBov2wEfj2eAa/c9fHjp7GWxy08iJI5xh27d4s6kY+Nv06OwpmLjngyDH+ECiyo+uouqT1eUzNRDFP9/wcB/x31ZJzSxG/fl8kARmk1zkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752173111; c=relaxed/simple;
	bh=FjuyeMKtCIS0jd6XrsqzjUVLDsLRgSk/4GQsuk9iPHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ay2Ji8GEIeCaZFFqQzeJviDFXfN1hYE2QNN8+UtoCeS2EqPMrIuwIe6yG4lFtRNKOoOBipb2CN9vBho1X2Nx+Mgt+LQU73XhrZt68Ywz1QNVPXVkh3QVZV/0+P8uBn8uAQ2cGcoSsLqCLhplyLI+7tBjxx9ogDsuGmJlp1taE0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OS+1iK8N; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a6e8b1fa37so1186132f8f.2;
        Thu, 10 Jul 2025 11:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752173108; x=1752777908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+tmXGTqg6eeBpnnZy9odoGENAwHa6i1JIVa+JuaL8yY=;
        b=OS+1iK8Nxwfy6Qwzf4qNCLF7YkrSrZAY7pVBemo67MXhLyxN8lEXkeSuKI1IuV5i0G
         NTqs4Ak7FHg6ZX7kMTpyhLnqNvkrFViDD1ooexFvSGCmvqCEr4X/7rTX/f0m5klu8AX0
         RGcinFc6k2GQ5ZtAKBHsJEs4CcjJ3ml+l8/YDb90n45Av1zKuBjitzVbHZIsBKSIj9dR
         LY5nQr7fdrH5OH8Vzhv/174LYuBZM+GveOeOQ/K5DLS/Zrx+OoeyuLTWFh8KtLHrBqWw
         5JPn9YmS8XbVRqXa8zc+oGxvHhLuN2ylNuml3PXHICqVPfzuUCpjAgSYalGV14tn2jE9
         6FIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752173108; x=1752777908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tmXGTqg6eeBpnnZy9odoGENAwHa6i1JIVa+JuaL8yY=;
        b=jsGunJjh6jVCFHg3k2SMrcGqSch+o1FnjlehVQHOZ/EcISmoi0MOtX8OkF8oEESrcB
         nNRdEcaMDTfWGRDC0KHI+l2PxCLEAiiuNNK0CZLIF11Ki8i/pzyUDFA81l9HbhvYB385
         dk5t+oP7by1Vx8q6Hy40KqzOhvxsh3UYCSZQf8mxwD3MV+uZgg2cmc7D4SA3FiDn4V1V
         eiegRYlYRp2zqlGpzEGN92o2vmdvBwRUpkbVGbDSbCBtXj+Xw4Iyp+QFn8C3i9tNa3Xi
         eYOwWai3uuTR0IbFvAb5OcTfTF7ppeVnIwYJ51NNxKNdll2hZ7598b85auvpWMFWaexq
         K9CA==
X-Forwarded-Encrypted: i=1; AJvYcCU5V3NcF7eqvgiF0wVXtvPjefVrLDrZyXqQ4BCtB/E4AJtYL9A/5PpBIqfIwGBugReCITE=@vger.kernel.org, AJvYcCWHdmaH18Q94OerLgS2GF0PAFdjTAimqPFW4LzBj9jkqIAzmK1lAUGv0u9nPChOEsIyQ4xtfWoKhvv8/8C/a6N6@vger.kernel.org
X-Gm-Message-State: AOJu0YxTPhqHpGvMBUH0eq8Q6A3x44pJ0vSam67+6MwuT2nxVcFpmea5
	jo3L3Rup7i+IE5TlXLmlweYa12LzdbgXDkBoFpFDbyqAiQdkGrkQC0/KUHLHSY9l
X-Gm-Gg: ASbGncvqtvd3e4cBUXNlpya/wJqvaTxSiUsRgbHp5sE3SKRuMj57kcSgDWtoCUyEOaZ
	qDZ6xBG/AEPZbx7BufY8HzE0xvcDpYUPxGFqCOiuU9AcKcTdGLn+svEY1MQUtqloQNDIIKCZvMe
	phee184hMSJeEFvuWkrDePv1Q3ctAOg/uf4HZJgNWPywg6ZNCRER+cAz/CwIsuyJCOrPB7CHWRH
	77M/qjUtpetfGEqsQKx50S5gz1ki/Bi7KWH9TfDr3bgg+xY+Q7MtesHh4b0IaW1XfN/BtSXJj0K
	+J7NkXk65RDYItaQoLsmtp7LroYx46hQBXzlkmxKTcP84dNSwhPkb8RsmhPM
X-Google-Smtp-Source: AGHT+IFOVLXj9+/yGcFNrr1hM2oagcUsAWzlWAvHp3xxFZifqOwLcAH41XMAbdYu7JzvHp+OFoC+Ig==
X-Received: by 2002:a05:6000:2c04:b0:3b5:e6bf:8379 with SMTP id ffacd0b85a97d-3b5f18d987cmr639004f8f.28.1752173107911;
        Thu, 10 Jul 2025 11:45:07 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:4e::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26c97sm2559318f8f.90.2025.07.10.11.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 11:45:07 -0700 (PDT)
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
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next V2 0/5] selftests: drv-net: Test XDP native support
Date: Thu, 10 Jul 2025 11:43:46 -0700
Message-ID: <20250710184351.63797-1-mohsin.bashr@gmail.com>
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
V2:
  - Remove unused and libxdp-devel headers
  - Fix reverse xmas tree in xdp_native.bpf.c
  - Reorder headers in xdp_native.bpf.c
V1: https://lore.kernel.org/netdev/20250709173707.3177206-1-mohsin.bashr@gmail.com

Mohsin Bashir (5):
  selftests: drv-net: Add bpftool util
  selftests: drv-net: Test XDP_PASS/DROP support
  selftests: drv-net: Test XDP_TX support
  selftests: drv-net: Test tail-adjustment support
  selftests: drv-net: Test head-adjustment support

 tools/testing/selftests/drivers/net/Makefile  |   1 +
 .../selftests/drivers/net/lib/py/__init__.py  |   2 +-
 tools/testing/selftests/drivers/net/xdp.py    | 663 ++++++++++++++++++
 tools/testing/selftests/net/lib/py/utils.py   |   4 +
 .../selftests/net/lib/xdp_native.bpf.c        | 524 ++++++++++++++
 5 files changed, 1193 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/xdp.py
 create mode 100644 tools/testing/selftests/net/lib/xdp_native.bpf.c

-- 
2.47.1


