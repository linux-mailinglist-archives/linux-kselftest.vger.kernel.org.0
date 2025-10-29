Return-Path: <linux-kselftest+bounces-44270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E134DC191DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 09:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20D365850DF
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 08:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A3A31A57B;
	Wed, 29 Oct 2025 08:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7YsI0GK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3887131A552
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Oct 2025 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726178; cv=none; b=W37tqMVs9Pfyf/Hn7BtMt4j+QZP5lTjjmvslS0sPpwBsqbWk76sEqzwfFXgFH2t2GawmoLcGGeugg2Dn8C0KpM/Y9Ty3GEi9+XwOSoTvwvfXN1n2oM7twWYwTve2qBjRqhS74T7ERTNIfai1k3fg1dUfaAGld3D+yDVRvpIxQSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726178; c=relaxed/simple;
	bh=II2ZeAq5d1PqZyNvFep+lfOCaOaR9aIDJK3qwqZxtvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C9iFaNah/Y4JAHlr0EVhS++yHdCNK82E+KZrSuc2sNVNd0SQuduZmv9o9QXw+Aj6bmDb8lOr02/F79Bc1rAlFgEZB23hK7AG+e9ACYyP7vYAtvaxsL1nzamM7w04Yk8GE/sBVkIXd4xJcG8+R0ORnb8+Zo85Q8OPoKBwnoI7FfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7YsI0GK; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2907948c1d2so73664875ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Oct 2025 01:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761726176; x=1762330976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pjESO5fQEKLuX6fwGQrrMr1sS1AZEXE62NjhuH0WeLY=;
        b=Y7YsI0GKGozgk7tmV4wM/+RTg0rdqLe5ZwTyElLj9fuq6sgLRjNPFcw8pFEBntVbuh
         vKJ4L1Uonwx2pZNkmrtldJNEzGXxPdonFJv+ETTvehVct+XxpIOp6hT34kEZc0twjYNF
         q+ImXDbunIud/CKTivfI/JbdKaXLabWLVKJ5azemMdMIidWdrDxP7dEkOh5Gd5tPXk43
         +BAjgg9TP5ogfFcgQ3fKMf1+QsqvPL8s+Ko1xf/8YR/YHdV3r6T+YV4Rq/BzoC3oJ0iy
         E8Gp9J/hU8tlnpQZXvpQLEOfLkuAU5MmH7Zb0hVUxuHxbrA7hCQg1pbnEADOI8J+wNeL
         ydMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761726176; x=1762330976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjESO5fQEKLuX6fwGQrrMr1sS1AZEXE62NjhuH0WeLY=;
        b=X/nJy2AEhJMidk6wXRqD3LAkWmBjflKoMPekv1+a/ksGcm6u7bGapx9kdxQKxMckIP
         vc8xAdNTJycJT6S5KjF8smxmRxvuNY3gL/FNFcJgXWvv2ySCpOH0nv5M5Po1nF/lo5pF
         bsx1KetSnOpQfdqFDDsfNf/5ROqUAzKuTwt5oNUqz5iFRCmBHyvQBq+Qo/oNss/0B49/
         gDCrVI+AwbOVc/Lfm0Xan3/crzg4OhEyhqkgDMUxdoD/bmdeDiQ7u4a+iMOcDlaboRbC
         xwNyViUR81UKm/cbe10RnNOsJFHpjAx2GeEsGWpfgf4s6l+OTXUMaa0pP1VUmA52B1ea
         XT2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqexsKgxig18YwiqREG8Kn/uLwpBFi/kuOxLTQEqf/9qvc04VvCEBDQIK0l/ZZ/PA+6bKfRQo69iHOzmEHmIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUEStc3iCAkCKf3Za8HUj7/3esyNDv9f0TuP/ty8jgqy/0ajHB
	2k7bebWpvIl3jPNZAHlhz58vQmeT+D0/+P6ctkDNWZXpWIxZLnr2LSwm
X-Gm-Gg: ASbGncs2QwRQ/4fkX/SvSi6TaYznIzoTLlHk5vd1pUzSSBMkXCvlbzwGig1sPE4CzJm
	Stcgib/oaC0ha0NWa/jJxKTUoWaAPKaHLkqENzZj1Ef+/ch4GraXrmqCQPDo6IJSRIEBzRI+mBB
	/fr/PjDLKhr7xWqiAcnaD2RqDNe4q6ZO725K5coF9NayzyuHUWZ0o0Q5Jau6m7XPe1ym3wtz0fC
	5ov/5Gj0DxWiqFrVDjRfIZZ5SwxW6f+4I/gu4+tUDWx2e03yHE6QXglg1CxoTrvJ/BUoSuK9cke
	LwZeiTCooKcueDW3d5OWshaHwgvzUSUMQ3GeAJH1odUTZy3/Xku3c37TvMbohlCUPctpeXO/KBd
	wM1349l2k3ClukJT7eB2LHBX41ZwNwG/ppxC6BpzC6eNEHulraA6aenYeOWcfD5clpB2R06VPtG
	9tXkMmsN5hYnHw74TTkL09utHOlQ==
X-Google-Smtp-Source: AGHT+IFtlmUFHwbjWAVa70at2N/ziNZo4fE2Wvt/G/+dSsYuVmuZ+70lod3hZaRVGg519qEMJmCkWg==
X-Received: by 2002:a17:903:187:b0:262:2ae8:2517 with SMTP id d9443c01a7336-294dedfc7dbmr23710645ad.5.1761726176352;
        Wed, 29 Oct 2025 01:22:56 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d09958sm141906005ad.24.2025.10.29.01.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:22:55 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jan Stancek <jstancek@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Shuah Khan <shuah@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 0/3] Add YNL test framework and library improvements
Date: Wed, 29 Oct 2025 08:22:42 +0000
Message-ID: <20251029082245.128675-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series enhances YNL tools with some functionalities and adds
YNL selftest framework.

Changes include:
- Add MAC address parsing support in YNL library
- Fix rt-rule spec consistency with other rt-* families
- Add selftests covering CLI and ethtool functionality

The tests provide usage examples and regression testing for YNL tools.

Hangbin Liu (3):
  tools: ynl: Add MAC address parsing support
  netlink: specs: update rt-rule src/dst attribute types to support IPv4
    addresses
  selftests: net: add YNL test framework

 Documentation/netlink/specs/rt-rule.yaml   |   6 +-
 tools/net/ynl/pyynl/lib/ynl.py             |   9 +
 tools/testing/selftests/Makefile           |   1 +
 tools/testing/selftests/net/ynl/Makefile   |  18 ++
 tools/testing/selftests/net/ynl/cli.sh     | 234 +++++++++++++++++++++
 tools/testing/selftests/net/ynl/config     |   6 +
 tools/testing/selftests/net/ynl/ethtool.sh | 188 +++++++++++++++++
 tools/testing/selftests/net/ynl/settings   |   1 +
 8 files changed, 461 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/net/ynl/Makefile
 create mode 100755 tools/testing/selftests/net/ynl/cli.sh
 create mode 100644 tools/testing/selftests/net/ynl/config
 create mode 100755 tools/testing/selftests/net/ynl/ethtool.sh
 create mode 100644 tools/testing/selftests/net/ynl/settings

-- 
2.50.1


