Return-Path: <linux-kselftest+bounces-30102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B48FA7BC99
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 14:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562A93B54D0
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 12:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1241E1DE2;
	Fri,  4 Apr 2025 12:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0reCk9Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E08B14EC5B;
	Fri,  4 Apr 2025 12:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743769320; cv=none; b=LuTYfuaDzPUaNwVpWON+z24yn0qmqgrm5E/mAAgWu7nJSKVBs0U+u8mp5CR0n0G7eJDDbjvdp8/hDqZyleMNglOuDNqEyai1kGtz6oqAoKWDWhqo8MEEUGUdNSuDnHGbBt/UfvZihpQN3yvBq7UxdoGcV91r0LLNgc+flKQ2PBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743769320; c=relaxed/simple;
	bh=mnpTgFlWk/InoznKhcKLcuT1vadvFGMDp53yHVGD+NQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gpdYVb2yJwASpBC2M+1JlW9jdxWxGXwRozel0DnJo+LXBhJcRytpW7MXUQIijXjU3JOL20MuT6B0IbjyzINvTR8Qw8lJmfQ+f55pmgzBYhAfb40T68UFWcm3y6H4J2AIk4m3DR782jkBO4GEslinBKSOS0R1zBwwF2TxIguQ7AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0reCk9Y; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-225477548e1so19395995ad.0;
        Fri, 04 Apr 2025 05:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743769318; x=1744374118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lS7qSD4e7hPh6460jSHrjNj8p/hA13los5OwWtR9Nng=;
        b=R0reCk9YXusRB/T/JEWKMDBAKw6+v+7OAhajp/Jls0kXwDr9CRfk5Ybt7+E8RA/WB4
         gsc8Tw9reqmDr4F/WCn4fjddHvmOoP1REh5NelqG4sV8sz1mGC5lirfBqfJ/2pnspVB5
         1sC5fX3ybA5JwfVYdJb8ZJ5VKb7hPzYwgZK5ntIvh3jalM4X6aP3ZC3CnTGEWrobv3xX
         tbnr8M9TrrIAlD1FreYH2BbT3War+KCDzDrWfWLyBDRqapZCjucsSVcPcGKYotp4qXzk
         KdJGFwN5bZFqsNjnBavIU09S8ugPHzyLJALpgo5GNFRtfUdS78Oh35nBkk7m5ys73Pvs
         e6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743769318; x=1744374118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lS7qSD4e7hPh6460jSHrjNj8p/hA13los5OwWtR9Nng=;
        b=A1fXQi1sGyFYSv9TdE3ZUM894e9TvzKgSJD0qhUCeiega3JDa3hFAlaC7JRmgSAW96
         4NKsq2rL1pqxdqeVla5RWUDHoB0BH6Q6BhxddpWssn14G4hIrrgDhKY0FEEJw+eq43nh
         txr41FRC+t64fyIlHYhALf2401zfrSrJaOuudl1Ev9/YzZXZ42MpneWGOsVzzHPdGNTx
         KGAgqmGaS7BsLtcMOQo92My6lv4QKUD4cu9gTB6HI1q7n8KXcdcg1LY7NjrFFOpdwekc
         1JzU15W/Z5Duj7DwK3DGwhssAO0lLmRVIVHx3BKOI2BuJkRsaiH1IxJs5/7NSLwjLDQa
         vUhA==
X-Forwarded-Encrypted: i=1; AJvYcCUM8MBajbbHZ6HhP6n9RRc/ajKEgRBlD8fbY4WDtoi+uNdHmF7stW/Qvbes+TWlDH5mFFL78jt+@vger.kernel.org, AJvYcCVm+9MJts9nbgWIdju62EuX/DzP+n+eZ2OPx3x2rCCVwOekKcYBFMxtCO+5mXUI6OaHFgPHQRXRTWziZC0EqGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUUwtc3efkbfHTrluZZUjZjoi4/lI0hD9/CiNt5o4YOukSsuZW
	Z4a1MuZ7zDqshJ3ACMNi+S0Kp2da5qkaZfZ5nbLJQc9lTfzXC10K
X-Gm-Gg: ASbGnctyTKkOyjuxufG5wx0wCybAh3/bML9r1IZ+vWDgQecuXfGyhLK5v5Y6YvF2f3M
	WbHS5mD1cXrSmsOmVx0vkJJTURG26w1f8SPuLhXxvjVT9URDjNvZvIQ1m8QwKKZgkHSdorcWeVG
	KMszdoKA9U6pZxjnLmJ9RiD7zEGvZQb8+jpAGDOTJDooKoZvcARtq8HplTFzE7mc2rtzz95Zwoz
	snHDRzPDD2lQ7jPoIgmTew892f9ed8RuzfAWd6xlRX3wY5bCVO2DkZbaRntlG6MD07Z6qzmTdPn
	kvNH0ypqrYW6LxvgJuk8XB/iMCeomejywA==
X-Google-Smtp-Source: AGHT+IH1z9ZBucYcFMHE87tQuYbEgXHWKdxHEUQmakpwMZIz7ATr49xhNUKYURUv0boYRBgte66VTg==
X-Received: by 2002:a17:903:1b25:b0:223:2aab:462c with SMTP id d9443c01a7336-22a8a86580fmr40912545ad.15.1743769317598;
        Fri, 04 Apr 2025 05:21:57 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229787727e1sm30755005ad.218.2025.04.04.05.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 05:21:56 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: kory.maincent@bootlin.com,
	willemb@google.com,
	aleksander.lobakin@intel.com,
	ecree.xilinx@gmail.com,
	almasrymina@google.com,
	daniel.zahka@gmail.com,
	jianbol@nvidia.com,
	gal@nvidia.com,
	michael.chan@broadcom.com,
	ap420073@gmail.com
Subject: [PATCH v2 net 0/2] fix wrong hds-thresh value setting
Date: Fri,  4 Apr 2025 12:21:24 +0000
Message-Id: <20250404122126.1555648-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A hds-thresh value is not set correctly if input value is 0.
The cause is that ethtool_ringparam_get_cfg(), which is a internal
function that returns ringparameters from both ->get_ringparam() and
dev->cfg can't return a correct hds-thresh value.

The first patch fixes ethtool_ringparam_get_cfg() to set hds-thresh
value correcltly.

The second patch adds random test for hds-thresh value.
So that we can test 0 value for a hds-thresh properly.

v2:
 - Skips set_hds_thresh_random test when hds-thresh-max value is too
   small. (2/2)
 - Change random range from 1-MAX to 1-(MAX-1). (2/2)

Taehee Yoo (2):
  net: ethtool: fix ethtool_ringparam_get_cfg() returns a hds_thresh
    value always as 0.
  selftests: drv-net: test random value for hds-thresh

 net/ethtool/common.c                       |  1 +
 tools/testing/selftests/drivers/net/hds.py | 33 +++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

-- 
2.34.1


