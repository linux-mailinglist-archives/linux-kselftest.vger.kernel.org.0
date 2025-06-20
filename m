Return-Path: <linux-kselftest+bounces-35450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7571AE1FE7
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 18:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E001C20381
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 16:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46ED02DFA35;
	Fri, 20 Jun 2025 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmAYI0bL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D64823ABA9;
	Fri, 20 Jun 2025 16:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750435910; cv=none; b=Woi3LhquAjVgs+3U8OIQgCwlmHf2Na6wUgWR7JI33Tq9vOcbxmgvJF0QSWXkgAp91pMZ/+U8iU2PAFxhCAaa11vAJ8WKx7QE4yb0/2ixTaQnO+6EsVZECuiLRQ6KKvLFIlrqeMolSJ0Z2mTf3WgiWPNfKz8QAjLKmCxCSunY7Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750435910; c=relaxed/simple;
	bh=3XtVq6vOTilHdAfXUvpwnwIyrFgk/J68ZyyO0zGzspI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oMAxAQxw+oClMbHXT3slJmapWvaLjKh7Gm+gg5UeZEwQYHznymW3DJsD46Eyldcw2iygBm3TekPpj+PawCC0uAt/sVecGZsmmxHxSM0DUT/o33cw2jcyWuRhYguROE4BVq7D61r0DazR/DXr0ydN7Ps4xELuly22DkK5YsxmUvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmAYI0bL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C962C4CEE3;
	Fri, 20 Jun 2025 16:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750435909;
	bh=3XtVq6vOTilHdAfXUvpwnwIyrFgk/J68ZyyO0zGzspI=;
	h=From:To:Cc:Subject:Date:From;
	b=OmAYI0bLll8ELtD48b/UvZiH1cHUT8L9xQ0jKNs+Zl1XlJQB+DYF4ociNpnPJQFXR
	 QUUcexb+OdNSnr9jf3g5cMoRjfj4u3ZNs+EjBF4dww7HYHNF6360HlmtXi3aTlA11a
	 PtHFy1V2iV2TyOxUM0orTXT++IlFjOM9b0xwe1VpJzozjhjlXGU/avIzrbGDFddRQ8
	 brAmbcHlEApt8r2AVk+A8qMIbHGtBxdmODcG7itEyYcamjD+TJ1nQiAuSMbLDUygd8
	 ZSTViXkMhmXo2WHRAZ5M7EeaBN4V68LeAXMuDZE1kf5MVCWIXB8oJcqVnySk2RVb3j
	 K89FHqsQDHUbw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/2] selftests: drv-net: stats: use skip instead of xfail
Date: Fri, 20 Jun 2025 09:11:07 -0700
Message-ID: <20250620161109.2146242-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alex posted support for configuring pause frames in fbnic. This flipped
the pause stats test from xfail to fail. Because CI considered xfail as
pass it now flags the test as failing. This shouldn't happen. Also we
currently report pause and FEC tests as passing on virtio which doesn't
make sense.

Jakub Kicinski (2):
  selftests: drv-net: stats: fix pylint issues
  selftests: drv-net: stats: use skip instead of xfail for unsupported
    features

 tools/testing/selftests/drivers/net/stats.py | 45 +++++++++++++-------
 1 file changed, 30 insertions(+), 15 deletions(-)

-- 
2.49.0


