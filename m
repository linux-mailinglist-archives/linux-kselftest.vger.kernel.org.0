Return-Path: <linux-kselftest+bounces-38725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ED5B218FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 01:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23093460EDB
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 23:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0309239096;
	Mon, 11 Aug 2025 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSsrOxXo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70202581;
	Mon, 11 Aug 2025 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754954026; cv=none; b=hHxj9/unqcjpgjh9m0wQzP+iY8FJB4QwZozx29tZAd1L7sgbttNOrZlv2CV+lrWywlNBJ5FEoPI7l03Ga31Rlz0LYIo9g21R85ZLfelLQXvK5B9z9Wvbsz8gx+9BxnyTQVEQIuIWrduotx5LIAUxsVuGeH4FQZt+06b5gcKJpzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754954026; c=relaxed/simple;
	bh=BWP/jkVEfLzui+QgbWLmN8KUvSIh3LPI/JHFwM1T3l8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ps811ajy33I9MOF1PjW2u3BSXmyadbii/Z1evQlPy11MUkm+mcNWwJig25l3GQce1Y/LwNtDb66l0h0t5yeGvokXmu/ojORbPRnbgwzNmwrn3CmiX25s4KDuQDNrIpPKYHHrwUoNHZpCGJ+axfqMq2wVyoUPCFiHKdXsj//uf2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSsrOxXo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03FAC4CEED;
	Mon, 11 Aug 2025 23:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754954026;
	bh=BWP/jkVEfLzui+QgbWLmN8KUvSIh3LPI/JHFwM1T3l8=;
	h=From:To:Cc:Subject:Date:From;
	b=kSsrOxXoBQnLB71AW2w/j3Kvaj8i9dJ4oegX387aJEA2APGLUlojcaElxPryk5cS3
	 UsVD9CO+trjUtbi+lrPGlOYsB3UK64hnVyRCnqIfW61dUU1PMTUGs+8ZKZ58wguK7O
	 tdfRD6Oiw4WEYlW/gf4ZGKBYNvmrjYk+OUDrprpT1+jpfGgqM5F9k5bweTmnq0FEzL
	 vIxt3MpQqgt+Digm/kuqBI7593IE/8oZddN0Xy8XnpmXkUwEW/VbESvebEVW/vqs+e
	 fmIJhxOE0SA4NXHhswF0IVmXi4wc+S5lK/3F3DMuzZcHwoV/dbSeaaV/A6orHrh22N
	 kEqxfn1uKZVqQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	sdf@fomichev.me,
	almasrymina@google.com,
	noren@nvidia.com,
	linux-kselftest@vger.kernel.org,
	ap420073@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/5] selftests: drv-net: improve zerocopy tests
Date: Mon, 11 Aug 2025 16:13:29 -0700
Message-ID: <20250811231334.561137-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few tweaks to the devmem test to make it more "NIPA-compatible".
We still need a fix to make sure that the test sets hds threshold
to 0. Taehee is presumably already/still working on that:
https://lore.kernel.org/20250702104249.1665034-1-ap420073@gmail.com
so I'm not including my version.

  # ./tools/testing/selftests/drivers/net/hw/devmem.py
  TAP version 13
  1..3
  ok 1 devmem.check_rx
  ok 2 devmem.check_tx
  ok 3 devmem.check_tx_chunks
  # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0

Jakub Kicinski (5):
  selftests: drv-net: add configs for zerocopy Rx
  selftests: drv-net: devmem: remove sudo from system() calls
  selftests: drv-net: devmem: add / correct the IPv6 support
  selftests: net: terminate bkg() commands on exception
  selftests: drv-net: devmem: flip the direction of Tx tests

 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 14 +++++++-------
 tools/testing/selftests/drivers/net/hw/config     |  2 ++
 tools/testing/selftests/drivers/net/hw/devmem.py  | 14 +++++++-------
 tools/testing/selftests/net/lib/py/utils.py       |  5 ++++-
 4 files changed, 20 insertions(+), 15 deletions(-)

-- 
2.50.1


