Return-Path: <linux-kselftest+bounces-3896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4DE844AB1
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 23:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B53E1C21481
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 22:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2032439AF6;
	Wed, 31 Jan 2024 22:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kxIWU+wB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640F239FCF;
	Wed, 31 Jan 2024 22:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706738688; cv=none; b=hd3anqNHky3Rx8HLBFNsjRAJMPzIvtO+ht2zxfkB86vGwsLsKfZKkO4PMwRvMby9yYUbRZHl6EB4hkGT9UrQE13VKHyDWlO+X1F5bYUZ/5RxYltcj552uGgHmtJkdEQ/VVV+l7YRxfawVG03D1scbAIIHqKZdz4ArAyBpDnCrzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706738688; c=relaxed/simple;
	bh=rL6UwTddxATQMnHl3lvOrzS0ZwUZS/8XdLqdZsz3tYE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hnWYWnX6EsghOORTIziZEjUxDOVOzq04TNpeaI0pf3Vl3TdowdqRes7waNBOAdhLU7IMxDI3/N3recdPNb8iW/F1bO9fpYPk0jG5eENQWihrKZkgSJDm2DW32gCwacIQG6SINqdnSP6Ak/DAWBj/xbI0l+ZeTLXb+jH99exx9h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kxIWU+wB; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706738684;
	bh=rL6UwTddxATQMnHl3lvOrzS0ZwUZS/8XdLqdZsz3tYE=;
	h=From:Subject:Date:To:Cc:From;
	b=kxIWU+wBshFK7I+RUIsTcbhEwf/iedWGcTjpZZQ9pBsm/WgVfrDG2ElwGudROcsj6
	 zQx0qUOFZZCQ9rUDCRLsTJnpb1CGjLghSEXHed0O5Om5Tb1d+Hn+ARLQJGNazir57V
	 QjxHnsZqu1Dm/MpT0OXW5JpdPiFSX6MHu6IivQKtPIM7a075gO0239WzK4efY9GOL6
	 c5wWT48FBN0xqvP6Gm7foEV48XWvksY7gTYJJ5YLcXRrozzFi9hp2vg115vqUwED2k
	 vA1ZbWe9/G//EI2j2qmdavtXvATR540ij+CCG1l5JOJind2BLS85Ek1/Ps910FS4Fg
	 cZYQ/0q/av7uw==
Received: from [192.168.1.211] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DEF1F378042B;
	Wed, 31 Jan 2024 22:04:42 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH 0/4] selftests: ktap_helpers: Add some missing helpers
Date: Wed, 31 Jan 2024 17:02:39 -0500
Message-Id: <20240131-ktap-sh-helpers-extend-v1-0-98ffb468712c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH/DumUC/x3MQQqDMBBG4avIrB1ItJLSqxQXMf41Q0saMiKCe
 HeDy2/x3kGKIlB6NQcVbKLyTxW2bShEnxawzNXUme5hbG/5u/rMGjnil1GUsa9IMz/NMDkXvHN
 9oBrngo/s9/g9nucFWsbcDWgAAAA=
To: Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Laura Nao <laura.nao@collabora.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.12.4

This series adds a few missing functions to the shell KTAP helpers
script which are present in the C counterpart, kselftest.h.

This series depends on
"selftests: Move KTAP bash helpers to selftests common folder"
https://lore.kernel.org/all/20240102141528.169947-1-laura.nao@collabora.com/

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Nícolas F. R. A. Prado (4):
      selftests: ktap_helpers: Add helper to print diagnostic messages
      selftests: ktap_helpers: Add helper to pass/fail test based on exit code
      selftests: ktap_helpers: Add a helper to abort the test
      selftests: ktap_helpers: Add a helper to finish the test

 tools/testing/selftests/kselftest/ktap_helpers.sh | 39 +++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)
---
base-commit: f1ca07220ad16a9efae7f68e4bade0db89b63a3c
change-id: 20240131-ktap-sh-helpers-extend-805b77ca773c

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


