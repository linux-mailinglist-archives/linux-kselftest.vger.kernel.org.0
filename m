Return-Path: <linux-kselftest+bounces-7661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1408A0582
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 03:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C341D1F21659
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 01:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01487679FE;
	Thu, 11 Apr 2024 01:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdlbkEb1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2D369950;
	Thu, 11 Apr 2024 01:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712798920; cv=none; b=fzWk0f0aqJ3rZ9ycSiP7l591nIOlVKWCYRJ9E9GKVQum3tjyEh8zHq9848oXaSNPjnf6LvSOmKaMkAkFmCgXhl1aM/p0GcBLLboiZApPnh5Q7p1wN3Pql3EhbwuceU7i+exn0YmTdkyjh39OlgwCRUllZsvlIAAGt+j7x5sLQJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712798920; c=relaxed/simple;
	bh=YcYZX2ebMw4YLzD98CZfGkw/K5GmlBY8ZPZW0UaeBvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hmdw9nBn4ydw2GgoS6ez9yXA4eY+71o/6R/7vB/w6LpoqTufT22+hwtI3ZYpJEOxoWhe6xm8wcrtG+aGeMXSIsxyVTZASCLD93h8434eb/86UBbBe8/oFIItjBEv8xBodlkTHewRsayYp4rY3x3dQSleaYaJWra+1FyXaXFS0aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdlbkEb1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011BAC433C7;
	Thu, 11 Apr 2024 01:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712798920;
	bh=YcYZX2ebMw4YLzD98CZfGkw/K5GmlBY8ZPZW0UaeBvg=;
	h=From:To:Cc:Subject:Date:From;
	b=OdlbkEb1B/DcMnAeTF5tNC6webryZ7sREOifEUQ+HQhEBlw0Y8FRa3feClE1Ml3CQ
	 YiljRyGcvN8RKx/gswb+935mx70IJpz5qyq+Cs5AJAeeX5ekMmRhw3N5RM0y2QPbXX
	 eeJdXjxujkBYfWekFFr+LV5NU3Ssk77IF+8AgUb+xy6hJuGp13u3U/ixvlHB4HAKog
	 Z8Ins18Ocj6XfQtg7DIknnfZ011DxlVHmhcAHW6m7gLdwHupfmOUJWROryEdN67gmu
	 cpad0q18zE/kJanDL7YOiVXH6qoSnNXrYMYfysXvJTj8jueY/l/nURu093/alw995w
	 8DdTCBEtCpu3w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/6] selftests: net: exercise page pool reporting via netlink
Date: Wed, 10 Apr 2024 18:28:09 -0700
Message-ID: <20240411012815.174400-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a basic test for page pool netlink reporting.

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
 tools/testing/selftests/net/lib/py/ksft.py | 29 ++++---
 tools/testing/selftests/net/lib/py/nsim.py | 22 ++++-
 tools/testing/selftests/net/nl_netdev.py   | 79 +++++++++++++++++-
 6 files changed, 215 insertions(+), 16 deletions(-)

-- 
2.44.0


