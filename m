Return-Path: <linux-kselftest+bounces-22602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121869DB95E
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 15:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B733164006
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 14:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA931ADFF5;
	Thu, 28 Nov 2024 14:13:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [195.130.132.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BE21AA1FE
	for <linux-kselftest@vger.kernel.org>; Thu, 28 Nov 2024 14:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732803228; cv=none; b=h7QbVHF41a2QJrtXS1eoNuw1Mw/v3StwSWT8zY9CoNhW7QwPFyUe0gyX1xJf9u/wywxgt3nbuMfpbdSWkr+EN3/bE15AgjZ3K2GZhNEp3UsSB96aHNGyq/DgN4b3hjGTlHCdgS7lV/tZl3DShUufewjQSr6Mv1PO/Hw0V4B+KcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732803228; c=relaxed/simple;
	bh=QW4ksDLjGIh3OgycdixnUdgjbLHk/UIqPtxkl+d9+00=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jtOSlRFFLfw2CMpKRa4djjLvYaIdlX69Kt5QrXM5aW82BndxC/eL0ZqHjbzXjI+Hl2myiuvhUhjZ/nEZEPU5MR9gw2JWRXcXzDILBIqMnDoXD8lmJzkwoIJQRrPdYITXhCKK4wPDbalt4fcq3bfXMausWQPAi0AqqiiD1GxMzaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
	by cantor.telenet-ops.be (Postfix) with ESMTPS id 4XzdNr55TGz4x3Pl
	for <linux-kselftest@vger.kernel.org>; Thu, 28 Nov 2024 15:05:00 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:c27a:bd9d:13ba:8a2e])
	by baptiste.telenet-ops.be with cmsmtp
	id iE4t2D00F04Zieg01E4tGe; Thu, 28 Nov 2024 15:04:53 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tGf8V-000bLz-3d;
	Thu, 28 Nov 2024 15:04:53 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tGf8X-00DNa4-4w;
	Thu, 28 Nov 2024 15:04:53 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] selftests: find_symbol: Actually use load_mod() parameter
Date: Thu, 28 Nov 2024 15:04:52 +0100
Message-Id: <a7f10d132c36f0e0c80a6bf377721e17732e120a.1732802636.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The parameter passed to load_mod() is stored in $MOD, but never used.
Obviously it was intended to be used instead of the hardcoded
"test_kallsyms_b" module name.

Fixes: 84b4a51fce4ccc66 ("selftests: add new kallsyms selftests")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 tools/testing/selftests/module/find_symbol.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/module/find_symbol.sh b/tools/testing/selftests/module/find_symbol.sh
index 140364d3c49fc912..2c56805c9b6e6ea0 100755
--- a/tools/testing/selftests/module/find_symbol.sh
+++ b/tools/testing/selftests/module/find_symbol.sh
@@ -44,10 +44,10 @@ load_mod()
 	local ARCH="$(uname -m)"
 	case "${ARCH}" in
 	x86_64)
-		perf stat $STATS $MODPROBE test_kallsyms_b
+		perf stat $STATS $MODPROBE $MOD
 		;;
 	*)
-		time $MODPROBE test_kallsyms_b
+		time $MODPROBE $MOD
 		exit 1
 		;;
 	esac
-- 
2.34.1


