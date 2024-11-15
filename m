Return-Path: <linux-kselftest+bounces-22119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E79BC9CF57F
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 21:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93EC11F29FDC
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 20:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC241E1049;
	Fri, 15 Nov 2024 20:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nf/iozw7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD5317E010;
	Fri, 15 Nov 2024 20:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701355; cv=none; b=J6lNBoazJLofRyHum1aRYtGYtJ0t5VvFnj+WgRX+1reTib1/BLf1Pxbg9+lyjDHSR2yR3meN+AvhkyqFKmMdunk+JZyLcG/HNS5nVgaC6CBYbmD+gwpHia25DYYdZvpmut9rRm2InCt4HlMXeDm/6HfPO1RxmLCuwvZNs9cijY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701355; c=relaxed/simple;
	bh=pK5WVxfgrltfpybPUrLPkaOXRpy/Q/5O2c4tVehDSP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WOLWmxw3/n/VKANpaapAjRJgcJyYbyKWAC3BWvul9HFEsz/KunKOhRZh8+/1ePQp5QCLPcrJILS856zPJ+YOyk6ca+NSfx8fiAmQNPiE52MD1SNpm448bhoQUJ6/XBksJWM75xzKSLDgPpAM9bimKHv6tsLA4UXw5P72/mjt4Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nf/iozw7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180E3C4CECF;
	Fri, 15 Nov 2024 20:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731701355;
	bh=pK5WVxfgrltfpybPUrLPkaOXRpy/Q/5O2c4tVehDSP4=;
	h=From:To:Cc:Subject:Date:From;
	b=Nf/iozw7ey7EFZNXtRRmoxCPSb/b1RWbDFpPDWncu1nFE8AncrwqUNs6w5V6KCt+/
	 g+oh6qbVX6Ms1JyXGsRs+yuIiZ3OryQOEC/qENIR91ow1CHH0zC4p74YD1vPNpPprk
	 eZJP5tZUgjGvb7zo2bU4hHZLyxA91CjfjUDrBfXA/ZHSVraIBNEk+/BujjSrxby/5V
	 8WPUB4QIq+v9ZbnKZeid1Ygvr1PSA0B2UfyXPMRlmNY+5/hdhY3N5xahXVjgOh/fsk
	 k2LivqzPzZOZTT5NbeC+av7CILwdFRVDJRVysLUJAit1jLHJN6o0fddP2EJQ5nasrD
	 +DvELTEGvlkOA==
From: Jakub Kicinski <kuba@kernel.org>
To: shuah@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Tim.Bird@sony.com,
	linux-kselftest@vger.kernel.org,
	workflows@vger.kernel.org
Subject: [RFC v2] MAINTAINERS: split kselftest entry into 'framework' and 'all'
Date: Fri, 15 Nov 2024 12:09:12 -0800
Message-ID: <20241115200912.1009680-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The testing effort is increasing throughout the community.
The tests are generally merged into the subsystem trees,
and are of relatively narrow interest. The patch volume on
linux-kselftest@vger.kernel.org makes it hard to follow
the changes to the framework, and discuss proposals.

Create a new ML focused on the framework of kselftests,
which will hopefully be similarly low volume to the workflows@
mailing list.

From the responses to v1 I gather that the preference is to
keep the existing list for all (or create an alias to it);
the framework-only section should be the one to have a new
list created.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Sorry for the delay, the responses to v1 weren't super positive
but I keep thinking this would be very useful :) Or at the very
least I find workflows@ very useful and informative as a maintainer.

Posting as an RFC because we need to create the new ML.

v1: https://lore.kernel.org/20241003142328.622730-1-kuba@kernel.org

CC: shuah@kernel.org
CC: Tim.Bird@sony.com
CC: linux-kselftest@vger.kernel.org
CC: workflows@vger.kernel.org
---
 MAINTAINERS | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f245573722ef..345a0657ba1d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12395,7 +12395,7 @@ S:	Supported
 F:	Documentation/admin-guide/reporting-regressions.rst
 F:	Documentation/process/handling-regressions.rst
 
-KERNEL SELFTEST FRAMEWORK
+KERNEL SELFTEST
 M:	Shuah Khan <shuah@kernel.org>
 M:	Shuah Khan <skhan@linuxfoundation.org>
 L:	linux-kselftest@vger.kernel.org
@@ -12405,6 +12405,19 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
 F:	Documentation/dev-tools/kselftest*
 F:	tools/testing/selftests/
 
+KERNEL SELFTEST FRAMEWORK
+M:	Shuah Khan <shuah@kernel.org>
+M:	Shuah Khan <skhan@linuxfoundation.org>
+L:	linux-kselftest-core@vger.kernel.org
+S:	Maintained
+F:	Documentation/dev-tools/kselftest*
+F:	tools/testing/selftests/kselftest/
+F:	tools/testing/selftests/lib/
+F:	tools/testing/selftests/lib.mk
+F:	tools/testing/selftests/Makefile
+F:	tools/testing/selftests/*.sh
+F:	tools/testing/selftests/*.h
+
 KERNEL SMB3 SERVER (KSMBD)
 M:	Namjae Jeon <linkinjeon@kernel.org>
 M:	Steve French <sfrench@samba.org>
-- 
2.47.0


