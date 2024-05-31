Return-Path: <linux-kselftest+bounces-11023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11ECB8D6598
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 17:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0BC728DB30
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 15:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCEC73502;
	Fri, 31 May 2024 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="eyXVpzRP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DF429A0;
	Fri, 31 May 2024 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717168691; cv=none; b=sTnzHtxBULHKbYBm8yGHPNqnZJ8ijhy/kUYXtobWumySRb4hcxzruP0kTnSkDa+GLTNDqbLlm/LmOhLt5Krf63kQVw6mestiudYSHu6tAy1bdy3LrIFCAQLOeSBUx9TTXBQ8WUffC2dlp81ptcBxwT1otJ4+SxPc1LABamenH0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717168691; c=relaxed/simple;
	bh=S+OItTF7bkKx7msDIMufZGJM0il9tZ7Etrq9yxouKwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rkexWLXQKGvN4EQ1d106ucLyLEs/sXyg51o/W3HQ7HDkbaDol9BCUhz3i385/wsTcnli3gbE3o8ZGluMdw/KyU3kmmqMobII2LkXReCqG6FFd4fbZ60JaOAUec0253M5ehAWerRLdJf/V0279Ts92494cKLPFpsvLVztefFqjE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=eyXVpzRP; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=nKhgMb1X5YJvQK8owPBySV+XIkHcz2ecLwi5G+M6A3A=; b=eyXVpzRPBjX41I0t
	Lt84BGj3hQSRGBA+QVHG5TDxC2szJGGwRmccatNbYi1KW6bzOomx9H+Snvsna71O4tet3s/HqxQa3
	lUHVF+oDiTW0O9VWgFG1WE8D/NrqBoAEcNOlCNG0Ju4ijrAwDkTwHb4FZ1qA3wukZ0lynkl1vRkHB
	5HH4Af+wlotM+d95Sr5Q2sg/C4gAZWRXn64H9odkO4Ggrz53LKmxLV9mPbXXyekPPF3WN8ZUy49Yq
	UbKAivZd1aWpy45LuqybGVD9DwbbQ3r+3ljns/3MqKzOd0mMaLRaBlPqgkbl227/KzV0Tu9K6fCOM
	TqV4SCU248U9X2rHtQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sD414-003bWQ-0t;
	Fri, 31 May 2024 15:18:02 +0000
From: linux@treblig.org
To: davidgow@google.com
Cc: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] list: test: remove unused struct 'klist_test_struct'
Date: Fri, 31 May 2024 16:18:01 +0100
Message-ID: <20240531151801.128792-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'klist_test_struct' has been unused since the original
commit 57b4f760f94d ("list: test: Test the klist structure").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 lib/list-test.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/lib/list-test.c b/lib/list-test.c
index 0cc27de9cec8..383ee0ad582e 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -1201,12 +1201,6 @@ static struct kunit_suite hlist_test_module = {
 };
 
 
-struct klist_test_struct {
-	int data;
-	struct klist klist;
-	struct klist_node klist_node;
-};
-
 static int node_count;
 static struct klist_node *last_node;
 
-- 
2.45.1


