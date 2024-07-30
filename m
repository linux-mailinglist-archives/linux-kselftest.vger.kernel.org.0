Return-Path: <linux-kselftest+bounces-14419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C1A94043A
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 04:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D431F21F6F
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 02:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4B57641E;
	Tue, 30 Jul 2024 02:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsP25G4n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF2A29CE7;
	Tue, 30 Jul 2024 02:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722305610; cv=none; b=HexpQc/aLGCBzfAHqg0/kcwkkPNnuEGX5y647Sry2Y0avSIt6i14xN098H7JcYqo/MjwtJ8zgLRYvAZGW+sp3/Zqy2T3K0sYynu4qOttNF0Ec1Om6dtFPIN7zwbxdl94g0dk2DXEt/OEjNFzcsi9gM9JV+PIsFSy/ZM5m6bO368=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722305610; c=relaxed/simple;
	bh=SnvSs1etKWHU2+23pr2G5/54w/XtUgCs9O5keSBEStQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HQABqgR3ZBhuO7vKzrpYxaWtgqCcvS1bxx3o7BVI6MT3cTUWXYSdY4n+6IqNI/W4a/f+eGLABnyS6p8++lSjuzg1m0DPK6UoK0mc0XsVpYzHQct1Pho7CtaTh9C4kMX9K2prxMKmLqRaCRZ+8vMvYKRq/gRb6p3RDQegoy5mKtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsP25G4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6851C4AF13;
	Tue, 30 Jul 2024 02:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722305609;
	bh=SnvSs1etKWHU2+23pr2G5/54w/XtUgCs9O5keSBEStQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XsP25G4n9BBJlaafuerRxe8CthEZAb5DWL1QCrPfTUKxFP362yGz/oDdK6PwqNvZa
	 h9g3FjEeDxIUALr0Hkt+6w2bPLqsF17jXO+xdQZLADVfgSMBTXvlL58wmK/apyXQe7
	 YpCZNK1p52wNjg6+PZOV0OZzTjvB7h7LskinJO6gyMQ28rhbCoXBie9Lyvcn/cueyX
	 jVpqAnSjBOcjK0pMo7dzCLNEkX0Dhv/T35rw3RpcUIPdFL+7LvmuVrP64onbgelImH
	 M6pMCM8sgcl9NY9foQba+AE6f5Wpj4IbxXgt005Ty+OOPXUel0x5sXgvVaa7Jkn7qd
	 B6WnJXDse8iFA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDBEC3DA7E;
	Tue, 30 Jul 2024 02:13:29 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Tue, 30 Jul 2024 03:12:18 +0100
Subject: [PATCH net-next 4/7] selftests/net: Don't forget to close nsfd
 after switch_save_ns()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-tcp-ao-selftests-upd-6-12-v1-4-ffd4bf15d638@gmail.com>
References: <20240730-tcp-ao-selftests-upd-6-12-v1-0-ffd4bf15d638@gmail.com>
In-Reply-To: <20240730-tcp-ao-selftests-upd-6-12-v1-0-ffd4bf15d638@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722305607; l=1650;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=BuZdUTS7934qcmF6bxHRsQ9gqgaVwYQtz+0zY8CtODc=;
 b=CDkZKzvPI2EBsk787oywLx/nF0RKGExokF6JLZ0roP33C5/QydoXyCH2yUaOCAjZ7YJZQtE6V
 A3dTUzbx2T/AXFQs3mcrKprwnaWuXCYrpC0+mY0TsE808+NGpZYcBVt
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

The switch_save_ns() helper suppose to help switching to another
namespace for some action and to return back to original namespace.

The fd should be closed.

Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 tools/testing/selftests/net/tcp_ao/lib/setup.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/lib/setup.c b/tools/testing/selftests/net/tcp_ao/lib/setup.c
index e408b9243b2c..4e6820e7cb86 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/setup.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/setup.c
@@ -142,6 +142,13 @@ int switch_save_ns(int new_ns)
 	return ret;
 }
 
+void switch_close_ns(int fd)
+{
+	if (setns(fd, CLONE_NEWNET))
+		test_error("setns()");
+	close(fd);
+}
+
 static int nsfd_outside	= -1;
 static int nsfd_parent	= -1;
 static int nsfd_child	= -1;
@@ -296,7 +303,7 @@ static bool is_optmem_namespaced(void)
 		int old_ns = switch_save_ns(nsfd_child);
 
 		optmem_ns = !access(optmem_file, F_OK);
-		switch_ns(old_ns);
+		switch_close_ns(old_ns);
 	}
 	return !!optmem_ns;
 }
@@ -317,7 +324,7 @@ size_t test_get_optmem(void)
 		test_error("can't read from %s", optmem_file);
 	fclose(foptmem);
 	if (!is_optmem_namespaced())
-		switch_ns(old_ns);
+		switch_close_ns(old_ns);
 	return ret;
 }
 
@@ -339,7 +346,7 @@ static void __test_set_optmem(size_t new, size_t *old)
 		test_error("can't write %zu to %s", new, optmem_file);
 	fclose(foptmem);
 	if (!is_optmem_namespaced())
-		switch_ns(old_ns);
+		switch_close_ns(old_ns);
 }
 
 static void test_revert_optmem(void)

-- 
2.42.2



