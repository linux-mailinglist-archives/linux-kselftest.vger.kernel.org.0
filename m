Return-Path: <linux-kselftest+bounces-14703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A5C945AE6
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 11:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA6F283EA4
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 09:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978571DB43D;
	Fri,  2 Aug 2024 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3qtTt9D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EC51DB421;
	Fri,  2 Aug 2024 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722590619; cv=none; b=F+i+vBjzDNmfCLSAqOSF/I3Mj3F0tu/4drhlRpc7Klcg4C1RMTBjb5xebU75xz26qc1F0XBW2/5FlSCO/R3z4D/OtVzTfh/+Z3OxnC4SMYmYmxZHkPXqzW3iA3+YMSwpUDTg8UVfjkQg7Nb44/enqAfBPr+n+PEhA+zXO0e5SOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722590619; c=relaxed/simple;
	bh=SnvSs1etKWHU2+23pr2G5/54w/XtUgCs9O5keSBEStQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EbXsUAImco60sETycBhe6owbr3GgKk9b/iBLNb2LJZa/NVVDyJbYk5DXFnxcV9lVHacjeF3F7j1LtjC9dgIKIvSIGTs4AJk3+SzFY5O8dGpSI1QqyTZMDqVX2ab5OsKJHoR9wsXjmq+J002IS3fgmwQdHIQ7Gs1XmDu6/w5QDCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3qtTt9D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC61EC4AF12;
	Fri,  2 Aug 2024 09:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722590619;
	bh=SnvSs1etKWHU2+23pr2G5/54w/XtUgCs9O5keSBEStQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=f3qtTt9DG0wLlf4753GOk/7Cvck+7pfjNaxLh7So10seOeGeXqNY90cbGOEzZEU1J
	 lLMwVwspAVYeQbxbc8Pqe3hK0MUiP4UWdthVmJ+QnXhOK8YK8jCDwBAO/8gvOWRj6d
	 dGYklZkd4bd2y4v992Ek9Ktoje/PxLXrw7+49oJ8QjaMxFSLAIRNdv5zYYmTAgQn9N
	 8Kbbs0Hxk2sHY7BC75EZ1swcL6fxXfjmRc3BzI7M9j91NLNQHjglMrseSSR1zAoQav
	 weLaSImns3eRTy6vXXpHd+1sg0uwpegzAGemrNlZgtra1bAucwqzSvF2HmN5xejkxZ
	 mc7FuhbCMD3aw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E94C3DA7F;
	Fri,  2 Aug 2024 09:23:38 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Fri, 02 Aug 2024 10:23:28 +0100
Subject: [PATCH net-next v2 4/7] selftests/net: Don't forget to close nsfd
 after switch_save_ns()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-tcp-ao-selftests-upd-6-12-v2-4-370c99358161@gmail.com>
References: <20240802-tcp-ao-selftests-upd-6-12-v2-0-370c99358161@gmail.com>
In-Reply-To: <20240802-tcp-ao-selftests-upd-6-12-v2-0-370c99358161@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722590616; l=1650;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=BuZdUTS7934qcmF6bxHRsQ9gqgaVwYQtz+0zY8CtODc=;
 b=/UhVrA6u50O7HIcqANF4pFBPnfhjptVTN6UnS3NMOfKTyBQPoX/hEfXC351byVkGn2KGlZN1L
 5Ks6kc/0eYdD8Mmv7DUI0S+Az6kYbdNFbqicTcMdvs+K70uxHf0Omr7
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



