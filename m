Return-Path: <linux-kselftest+bounces-7889-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E7D8A38E9
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 01:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674C9283CB3
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 23:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37BF152DE1;
	Fri, 12 Apr 2024 23:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfEDRIfx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBC615253A;
	Fri, 12 Apr 2024 23:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712965037; cv=none; b=hwlchyp0JtBJgn0adQQQsStanGmlx3n7SE/YL69C/ghzfcMyGONfHuZqweP4Y1/t0SwYPgvXcRpO3NccFiprh6/c4SNM5wDlev2/S/+ihOciQ1kGrKLlvfU2gbgg3jUZPkAiDssk0RqQeimTlDn4+EcafgiX4FbCpubsIlHNfeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712965037; c=relaxed/simple;
	bh=P1Yf3n7jFYyThb0whQqN7H3emmofC3ohUKqio9qXgnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+aSnF2AJzx85k275sOUIfoP6opArfDj8pyph+shE2fkHnsGLB2LkrOCeeWzD0YcTl7NoIv8vbFRVWHZ+3EgGXvFsA2NXPJ/lI1jT0TSMratkip9p2IjTPfKgAIM8KEvDfgaU1h52qPkkmSlAQSAwh6RHmLUYcJPweEhCMMZbYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfEDRIfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9ECBC2BD11;
	Fri, 12 Apr 2024 23:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712965037;
	bh=P1Yf3n7jFYyThb0whQqN7H3emmofC3ohUKqio9qXgnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cfEDRIfxjW83eQQpT01ovDpUTPxYY9QLZEgvziTolBeFsk8DiCynKJRONini+F+Lb
	 y5rMT/HpHKQh0yCDOw98aQkv7PKABq1UOmabz3ZERPy6pIyG1h/QMZoKNp7ISbb5+m
	 lO+F07ScWGyoUj+agNhwQsf+1Hup74yZva02ADROCcHzOOALMRMwmDL435+jnwUMZf
	 EdyQgFyzN/K0shJadk7PcwDf2eOLnqZv+7JrBhEWP7qR/tvNqAPogjbQdqBC+6B/9O
	 GD0brzJ8Sre6kRrhC9j7XGbbF8knidNrjJNwRwumM33QlgUT3CDcWUpKBhkbXVK0U/
	 ZbO7SUJ9ClCCQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	linux-kselftest@vger.kernel.org,
	willemb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/5] selftests: drv-net: add stdout to the command failed exception
Date: Fri, 12 Apr 2024 16:37:02 -0700
Message-ID: <20240412233705.1066444-3-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412233705.1066444-1-kuba@kernel.org>
References: <20240412233705.1066444-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ping prints all the info to stdout. To make debug easier capture
stdout in the Exception raised when command unexpectedly fails.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/py/utils.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index eff50ddd9a9d..d47d684d9e02 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -34,7 +34,8 @@ import subprocess
         if self.proc.returncode != 0 and fail:
             if len(stderr) > 0 and stderr[-1] == "\n":
                 stderr = stderr[:-1]
-            raise Exception("Command failed: %s\n%s" % (self.proc.args, stderr))
+            raise Exception("Command failed: %s\nSTDOUT: %s\nSTDERR: %s" %
+                            (self.proc.args, stdout, stderr))
 
 
 def ip(args, json=None, ns=None, host=None):
-- 
2.44.0


