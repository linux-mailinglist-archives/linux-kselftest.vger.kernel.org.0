Return-Path: <linux-kselftest+bounces-7801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F05E38A3037
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 16:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC203285C96
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 14:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4934F8624E;
	Fri, 12 Apr 2024 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgMHTEgi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA75219FF;
	Fri, 12 Apr 2024 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931281; cv=none; b=qOgIXy2olkFzdoNPJ9I7ozWyBc3y5j1I95Wxm6uQ08KsGKwPPKT3oN16O5WKIphj3gUTuIm2I1jxb7Xs6I3rWpkq7LmEIKrMvrCS6u3gnxKS33tgfIpwouaDz/QcGAEelhs/yuHx0/80rhP/TcWreJ5W6kEI6Ae2jEXojw50xvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931281; c=relaxed/simple;
	bh=+dYVQCDb5Pw1mBa/FLgAHMax9yxda0T6YnDCaiYR0lU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IRZEalcgMbbeeLzNqJwrSehQuXcW9SayDgsL3GdzaEKvhJDFgJbgK5ADxRJm4py0ayrbOUjtoP5BvACUngZx6VckC2kCycMDBEnNC1fhOhoXbVBlD0mAPUYKLsjjIpNQoX8WptXloN87Kg7TUPT2qtyjQ+CUkyYcUB020XJivWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgMHTEgi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C394C113CC;
	Fri, 12 Apr 2024 14:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712931280;
	bh=+dYVQCDb5Pw1mBa/FLgAHMax9yxda0T6YnDCaiYR0lU=;
	h=From:To:Cc:Subject:Date:From;
	b=qgMHTEgiXBzBtayIluoeD+vgK1BMdgubILYvAyewqdRwUbSEmROaHlqJa8FEigCU9
	 n7TejwNCO7mReMHYYufjb28Fr2I7pnIpA38vT9lXyt7wfnQoDe+EIu4tqg5O0vdUZ1
	 Uo31rsjG7IOJ18HVUjU++brmvMWZejRjm2Y/kVOG5ThriiXxZblEuqxTb8EeSZWJHO
	 o6VG6tV32YrqhGqYYwk67J27K3CdPbW9pkQlld4xkD8OSvDEIfk2g+FrN3OWFMBX0U
	 v87Nr5T3bKUXrt+jhl9CnNhsCLbFmXbnajOLk3CDjd8NHc5ITiWQEut/+cHmyjalRd
	 hnrN7AMI5Vm7A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/6] selftests: net: exercise page pool reporting via netlink
Date: Fri, 12 Apr 2024 07:14:30 -0700
Message-ID: <20240412141436.828666-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a basic test for page pool netlink reporting.

v2:
 - pass args as *args (patch 3)
 - improve the test and add busy wait helper (patch 6)
v1: https://lore.kernel.org/all/20240411012815.174400-1-kuba@kernel.org/

Jakub Kicinski (6):
  net: netdevsim: add some fake page pool use
  tools: ynl: don't return None for dumps
  selftests: net: print report check location in python tests
  selftests: net: print full exception on failure
  selftests: net: support use of NetdevSimDev under "with" in python
  selftests: net: exercise page pool reporting via netlink

 drivers/net/netdevsim/netdev.c             | 93 ++++++++++++++++++++++
 drivers/net/netdevsim/netdevsim.h          |  4 +
 tools/net/ynl/lib/ynl.py                   |  4 +-
 tools/testing/selftests/net/lib/py/ksft.py | 41 +++++++---
 tools/testing/selftests/net/lib/py/nsim.py | 16 +++-
 tools/testing/selftests/net/nl_netdev.py   | 76 +++++++++++++++++-
 6 files changed, 218 insertions(+), 16 deletions(-)

-- 
2.44.0


