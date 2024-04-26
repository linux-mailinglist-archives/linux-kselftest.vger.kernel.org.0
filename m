Return-Path: <linux-kselftest+bounces-8968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DDF8B42B7
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 01:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55F831C21EDB
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 23:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038B23FB2F;
	Fri, 26 Apr 2024 23:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBCgt1oH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E593F9D4;
	Fri, 26 Apr 2024 23:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714173846; cv=none; b=u1/B5QDkntd0cJ5w5bPqeg4ksnUp6r08QcTrX1Aha3czMCnw/twYFyx4KxaxREPYYBojLPybjzyIWvB6kIbqIKlsGpUx73i0vpQSB+LkvXvkZ+JrajQnafe0WgVu4fG20/PuoyK4F5Tu5M0qMXgda0AI52HihM+C8A/orFypRWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714173846; c=relaxed/simple;
	bh=5jqwXOyQToPv0k8xyfI1wlEGdOtc42g28NCgzOvVDRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CfRIp26Ot4bGFsUGpNUTBNF4MFkUEbVfckGTmZZRaFv8/iDMuv4Ye5di3rHdtK40UIrFB/7uzb3l9OHuzuWuvEY6MHmcWHhX/0xpcKaRV7a5f/iseu0vlHSzHVy3b8FVfbevFTk9NiFEYkJaRhkSyleHQ/7x07hWtC4Hsi0b7fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBCgt1oH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81A6C2BD11;
	Fri, 26 Apr 2024 23:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714173846;
	bh=5jqwXOyQToPv0k8xyfI1wlEGdOtc42g28NCgzOvVDRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sBCgt1oHJ76eZVzfkjVox2yCO359uqbNxXAD3hChiMGH3MVj4l/ueFj8q0nY3Z0yP
	 AW63pEvYBzFfA7LXMeN9mNAKjRYaKMJWBuKrpIxhBzHHet+t1Lt4YQtMKSs51MXAo2
	 V3muw2pL2x6ScezLv0cU29725cF/jbfg4U7TtXX3hGsR1cFJTWuQvP/cvRRpjWdTmn
	 hwRbTKjvrWWFfVfHmsgWNPxbIUq3SdUUQIiUb61qGF1BMSgTysDltXNJvUa9mnUT/N
	 /uHDlRVXKV0SpZMyhZIkG6Lh46fhoCG0b6+3D88Y/m2qZcgL1gHnQ6Uu/BFNgg5quO
	 jM7UNJmfbAg0Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/6] selftests: net: py: avoid all ports < 10k
Date: Fri, 26 Apr 2024 16:23:57 -0700
Message-ID: <20240426232400.624864-5-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426232400.624864-1-kuba@kernel.org>
References: <20240426232400.624864-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When picking TCP ports to use, avoid all below 10k.
This should lower the chance of collision or running
afoul whatever random policies may be on the host.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/py/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 11b588a2bb9d..074b792ec943 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -77,7 +77,7 @@ import time
     """
     Get unprivileged port, for now just random, one day we may decide to check if used.
     """
-    return random.randint(1024, 65535)
+    return random.randint(10000, 65535)
 
 
 def wait_port_listen(port, proto="tcp", ns=None, host=None, sleep=0.005, deadline=5):
-- 
2.44.0


