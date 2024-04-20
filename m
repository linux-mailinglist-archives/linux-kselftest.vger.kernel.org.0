Return-Path: <linux-kselftest+bounces-8518-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B39D8AB8C5
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 04:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09E31F21507
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 02:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197A3625;
	Sat, 20 Apr 2024 02:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsfnTaPW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1527621;
	Sat, 20 Apr 2024 02:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713580557; cv=none; b=hOTWR5Fd1pNA7G9qi4m4KfeEOyE9jYJbl0UKVrZJ/bJ+wpsgw5wIsExMjgpgUja+f8WvN5a4bfMN1dfCVbPBfaj976nnRhEG0tqoIo/q+Yw82AB2swUf8X2ThMW5f+JZR9bQJo2iEMRsHQ94Zb8pols+ya8cOeNi3CFJE/yR3Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713580557; c=relaxed/simple;
	bh=Px6n4T6fDurah1/0rouDyoErqxr14aPcjeGz0qssdQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eLP4/eUClArcTL32Moz9wzmln7lnXqbjU5apDwfGQ/TcwdT8BAHYJSitU8NksX2jAO+l7D6pNzxWpUA4UgrEsphSBsTE0eWzz+AVjtOG+bkIGedaq2se/PKbPq4EPe0Cp0FDWazRNwHz23K8ArKYIeVjDUeIYwKQbZBfA5uIuWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsfnTaPW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC9FC072AA;
	Sat, 20 Apr 2024 02:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713580556;
	bh=Px6n4T6fDurah1/0rouDyoErqxr14aPcjeGz0qssdQ0=;
	h=From:To:Cc:Subject:Date:From;
	b=BsfnTaPWkJppLhiS82+ZBUxxl50+EtboZQsXIq74K9cBFKqd8m7X9awsoGGm9In/2
	 0bd23j0qA4EXaZzSuojBmczd7t16XopXUbHr3wNm3ZqFphLPJLARdwBdwFTntTktix
	 MuhrhHmaBbZUmhuzhn0xeHSmZ8IrBxhJIVk/BWkGhDbXqQaO7rdnTN5pSl5K8NMVra
	 AH1ia844V6/mTiM89tkY7t/Jsn8Vv5alWjlc0QQBguK8egb3whrufO1wxdjVtLE4qw
	 Wu1Pnz/Z4tXCLpKMwvdVLf3tey4aYAPF0EIM19lU9zlzqEDRU294zRIUHp4C0cp8kz
	 8E4fUrFd+Sg5w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	sdf@google.com,
	amritha.nambiar@intel.com,
	linux-kselftest@vger.kernel.org,
	dsahern@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/4] netdev: support dumping a single netdev in qstats
Date: Fri, 19 Apr 2024 19:35:38 -0700
Message-ID: <20240420023543.3300306-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I was writing a test for page pool which depended on qstats,
and got tired of having to filter dumps in user space.
Add support for dumping stats for a single netdev.

To get there we first need to add full support for extack
in dumps (and fix a dump error handling bug in YNL, sent
separately to the net tree).

Jakub Kicinski (4):
  netdev: support dumping a single netdev in qstats
  netlink: move extack writing helpers
  netlink: support all extack types in dumps
  selftests: drv-net: test dumping qstats per device

 Documentation/netlink/specs/netdev.yaml      |   1 +
 net/core/netdev-genl-gen.c                   |   1 +
 net/core/netdev-genl.c                       |  52 +++++--
 net/netlink/af_netlink.c                     | 135 ++++++++++---------
 tools/testing/selftests/drivers/net/stats.py |  62 ++++++++-
 tools/testing/selftests/net/lib/py/ksft.py   |  18 +++
 6 files changed, 188 insertions(+), 81 deletions(-)

-- 
2.44.0


