Return-Path: <linux-kselftest+bounces-48640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0106D0CA84
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 01:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B072301AD00
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 00:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6E91C7012;
	Sat, 10 Jan 2026 00:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KA7nNCpl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F4C19D071;
	Sat, 10 Jan 2026 00:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768006298; cv=none; b=QgKSayNKFp27l8D6UmYHwY+NOfzNjZCigcn3lJ0ZTT3SMRgRZIOJGdlVgJqXziDBcqSEST5+oY8HAkVBJApANEy0WuKT0UZpOVLnk3byfSa6utezS4Q+YoP4jvybcuLoJenl3qHZGcO3TKPXclBwrnwq13Y0RYdA0wsmVVfcQe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768006298; c=relaxed/simple;
	bh=PsTelvQ935mw3RKF9+LbA3+EyDPYVTsBDUQP1m+cajE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fq6c+6p7/2g6PdgAh4erO6f4LLb0Ey7/M2PSinu262MlwkxJXLY5swzs78+HsLOfjOCYsQRQdLVvrWLEyijoyKHzgUZ5xRRGke4ZI4cVwqG+12OykNBE0kx0TrQ+9xIryaCoY4Xuv/Ba8qVzWMUGMGnfuDryU3y7ulQ/vD0zdOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KA7nNCpl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE5BC4CEF1;
	Sat, 10 Jan 2026 00:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768006298;
	bh=PsTelvQ935mw3RKF9+LbA3+EyDPYVTsBDUQP1m+cajE=;
	h=From:To:Cc:Subject:Date:From;
	b=KA7nNCplam2mnZTg5KFuibF7bf+y57YXdm3sOA73Zq1zd26kJnyjm74gd2xrSy+Aj
	 5nRZYl/sNHq3L4HJXKxkUjxwA4snKfGBzWk6rtSiUvMfa6ob42CWMgpJMnhDZbNJi+
	 7X6KK3RyOxZYLRF3ZGoTcjEs8jXzT5bswueXFM0SQ9+gjoCtiZ/5N7KjBKWDffZfpp
	 7ov1k5w+jfdc5Bnr8bscvD5ES8xI7mHhwAsCg8NXISFDY722TsGGaiq8QN4AEtRthk
	 EHL+6XxH7R/n0Yv2fEuhCTZhIoeC7z7U2I9TIU2ma0RObxMOy2OJt9KW9J7ZXL1vkl
	 AQPniaG4FQz7A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	sdf@fomichev.me,
	willemb@google.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/6] selftests: drv-net: gro: enable HW GRO and LRO testing
Date: Fri,  9 Jan 2026 16:51:15 -0800
Message-ID: <20260110005121.3561437-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for running our existing GRO test against HW GRO
and LRO implementation. The first 3 patches are just ksft lib
nice-to-haves, and patch 4 cleans up the existing gro Python.

Patches 5 and 6 are of most practical interest. The support
reconfiguring the NIC to disable SW GRO and enable HW GRO and LRO.
Additionally last patch breaks up the existing GRO cases to
track HW compliance at finer granularity.

v2:
 - fix restoring all features
 - apply the generic XDP hack selectively (print a msg when it happens)
 - a lot of small tweaks and 4 extra patches
v1: https://lore.kernel.org/20251128005242.2604732-1-kuba@kernel.org

Jakub Kicinski (6):
  selftests: net: py: teach ksft_pr() multi-line safety
  selftests: net: py: teach cmd() how to print itself
  selftests: drv-net: gro: use cmd print
  selftests: drv-net: gro: improve feature config
  selftests: drv-net: gro: run the test against HW GRO and LRO
  selftests: drv-net: gro: break out all individual test cases

 tools/testing/selftests/drivers/net/gro.c   | 399 +++++++++++---------
 tools/testing/selftests/drivers/net/gro.py  | 158 ++++++--
 tools/testing/selftests/net/lib/py/ksft.py  |  29 +-
 tools/testing/selftests/net/lib/py/utils.py |  23 ++
 4 files changed, 406 insertions(+), 203 deletions(-)

-- 
2.52.0


