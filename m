Return-Path: <linux-kselftest+bounces-37178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B744B02843
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 02:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE9F3B8A72
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 00:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE5D1CAA4;
	Sat, 12 Jul 2025 00:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEMSwKAk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C95A6AA7;
	Sat, 12 Jul 2025 00:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752280022; cv=none; b=YRPerTbtEUz6PWA+HjKaiR9QusU18fk0bKP/BTmzVIUQ31cDgSQYjrKo+cSVc1Qo5znVzzG1/8syZ33AhP1e2xGjV/vQPJ4Px/SDhjIT14EewxMUcV7bSTubJ5HhXdV0ph8LdR1JWVif3e8m3YGfrCnit7N0/jP3p8PksqdrXSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752280022; c=relaxed/simple;
	bh=c+UdfulwcqBq40Di09xQxHMVNQVk1BeRih3Qe64f+hM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ai3jkdFgyxapc4vINuoBTZid+OFBe3Ur29sJXcUJ8XfZlpGF8Rm/KeNIMU9FIIAc47iDf4WoNR49qIjqgaoS2i41/Ui7DU1abquvlCpUii6nYeZwJ6W9Sby6RH6Xt6WQZckRveUWeBF8UDXSjW/dLCSmMvfVKS+8GCB3rYQDscQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEMSwKAk; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-453398e90e9so19854035e9.1;
        Fri, 11 Jul 2025 17:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752280018; x=1752884818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lWsL9ULyx92cLusCqLiEtLRqLtcJ2pY8MuhC9YyGufM=;
        b=dEMSwKAkCQ5LpJRERIZwcv5WCWww3xKLG/CMzXEWR2eP5SC740voDw+k6TMY/4sPt/
         vdkBtWtjPB7wWTS+Mw7ImNfHY49GunCQla+grWph92e+qQposMU3tjW40VuO7JM2XKHE
         42/ki2jQ0pnD1JrZespFJaPg1F35WmqPxeZGtEJZk0z7/QCqHkZzHSu7OiOCK622VcLr
         xCN+M4kQofqev+bJC7Vu2PLXlFt1kQE3cbtSrLZmdt50ZXk1xVJmv9VyFndXFurjE1XD
         OSBrMTBVMqpr057GgpMaMN5pDQmWXl329vNT/Us2Nbpx5aLdkUT4SoQDO2+JCUvusute
         36nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752280018; x=1752884818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lWsL9ULyx92cLusCqLiEtLRqLtcJ2pY8MuhC9YyGufM=;
        b=dHipbbGWVHMLixK78krPg9hzYG+OZbjIMebFX1o8ueMDYXyAXMO5744VOl89iGlXKu
         gAo6UGYnidOJxqZHpLkW8H7aoPFgBz9yOrJka6DaaQX/5cP4kallVoDIsiLmG5LTMIk4
         v+jp9RusT3oaVPX3FzzFrWWqybZ3uHVtSeKygfQhWc+Jv/OOXnScfDBv731yn9CF/QaM
         luPbznYRlVhpTjthOBVbnZbtBrYCEXwQRW2iUU7DI0ksQOtRMgxZd8jVMFOvIIUBLrxt
         7rbWFTGXfETCWyGmP3qgI9AVdylJarMyEbWgRb7zzIC5oxjW79vxz26ZsWRGHnP2pJLf
         wRFw==
X-Forwarded-Encrypted: i=1; AJvYcCU/MjHbGzBziJYEVfj9/MEjszMHoFbvAH2Ry8alU45borBnk0/z7cdKekmDThn9TnvcImE=@vger.kernel.org, AJvYcCWLgKuvlPBUKDEwkguRsPc6iVdnSjzK5h9yKmb+Dw3ybdfvMczFryvO730dIs0bRgCYCcMcC2arx6fUbmD3dbr6@vger.kernel.org
X-Gm-Message-State: AOJu0YwHGQ/zvZnshxsXutGTTJzom/tsXVTDNzs5T1m+puelfMJKGK9Y
	4fAmxuzIz8MDGcxFxssOgbKtodsazLRMDrRqBEKO/VmOPCGRrtsT7GNaSXWR/vWL
X-Gm-Gg: ASbGncupReNhbRddzsOZp/gXdo8I4ex+awZOSdjCaYFqG8NNT3Amm/h879v4Lp1TjBk
	xvUwLVjSyI/fau1yvPBKQ9v5Nu7kkicwc5qFLR3KadkLDJAVjwe9SmrMczhc9oVV2Rfubq50OLS
	2v/CPAjjEvczQGepLqYACc/uKmE4EGmUzT5BHBw5hCcaYarYrNEhUn7Zx32PnpC8NaEWt8IQJ0l
	wrguYIH9hEJwzWIuITV7CPcZ3Yrc7yBOVkfjeQkr3U5n/fjuFBtqBqx5jteeDAqC/nZIHuCcoks
	OQ3QzfClYspdM9C279cE8aX1I4Ok8fP7e7A+QSA4Onwnkg7LqczdyICv/FN89dFhmlb9USpjZQN
	MExa1fyfw1/MQ0/e5KnKGMyyHgfjb05o=
X-Google-Smtp-Source: AGHT+IEy6omEzmWN06l6ot8O9pk7YdXoHmKtmN4mRenqUP2baUdtv6jBY2xlAvGqriy2sk0h6CXLYQ==
X-Received: by 2002:a05:600c:5246:b0:44a:b9e4:4e6f with SMTP id 5b1f17b1804b1-454f42599b3mr51795425e9.16.1752280018130;
        Fri, 11 Jul 2025 17:26:58 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:73::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd43915dsm61428805e9.7.2025.07.11.17.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 17:26:57 -0700 (PDT)
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
Subject: [PATCH net-next V3 0/4] selftests: drv-net: Test XDP native support
Date: Fri, 11 Jul 2025 17:26:44 -0700
Message-ID: <20250712002648.2385849-1-mohsin.bashr@gmail.com>
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
V3:
  P1: Remove exception handling upon xdp attachment failure for better
      debuggability
  P4: Handle the bound issue with the use of bpf_xdp_load_bytes()

V2: https://lore.kernel.org/netdev/20250710184351.63797-1-mohsin.bashr@gmail.com
V1: https://lore.kernel.org/netdev/20250709173707.3177206-1-mohsin.bashr@gmail.com

Mohsin Bashir (4):
  selftests: drv-net: Test XDP_PASS/DROP support
  selftests: drv-net: Test XDP_TX support
  selftests: drv-net: Test tail-adjustment support
  selftests: drv-net: Test head-adjustment support

 tools/testing/selftests/drivers/net/Makefile  |   1 +
 tools/testing/selftests/drivers/net/xdp.py    | 656 ++++++++++++++++++
 .../selftests/net/lib/xdp_native.bpf.c        | 538 ++++++++++++++
 3 files changed, 1195 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/xdp.py
 create mode 100644 tools/testing/selftests/net/lib/xdp_native.bpf.c

-- 
2.47.1


