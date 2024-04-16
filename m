Return-Path: <linux-kselftest+bounces-8037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B258A5F65
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 02:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED90282ED7
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 00:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C36B1879;
	Tue, 16 Apr 2024 00:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UON5JF6e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EEC17FF;
	Tue, 16 Apr 2024 00:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713228363; cv=none; b=PqOAJMC9601kjDDQjUVjfLcmpFizxXtDy1q9Skv+wZWFgn+mYbju1LRrj6jZrtfHnjXbJMVnEFLzD0V04w/I4dra+u3l3JgQtM0VGF3/mc8TvnM84Wxa0ajLvBtNey9lIWI2SjX/XDke2f3KQs+abQRSVe71xmh16x9QOuTGs7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713228363; c=relaxed/simple;
	bh=iNZKXPBcjfgMkeh6eFR/vPN9uOlTrnue8ygafyAn8PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KR7cPIJrCPi8k9CnorxUzZi3lk8Rp74DDREKmz+PGLTwSJk2lRRrXcqAPmUnwlY4jJkURM9+GyedA+54aFWMJ8c9HrfQZt2VysqkvSmRVRuAb3i1H/oJFIVUA/8xDYATS+4/KNUFaZUoYabKKsHgSh9ictqhAwPgaw8tWWEvlbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UON5JF6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668F8C32786;
	Tue, 16 Apr 2024 00:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713228362;
	bh=iNZKXPBcjfgMkeh6eFR/vPN9uOlTrnue8ygafyAn8PI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UON5JF6e37Z0no2i8XS43agDIo8fpjnUsy2hNBeJDSLdInQvT/ESdYfrnOVy2kzz8
	 7PRPTnLMgOCgOCNlEI8s5OWK+wRHsfF/EZMAt4A6BI5Gc1r4i7YRfVWqd3nVpP5+Jy
	 KslKjJt97GaTWTkA59eZ4I5BjyCyPCPIc33Nl1hhzWVXpkeYLQg18MOz/yDHl89oh8
	 KsSnoxSezfJfoUmhYKFacoilSCIWbYgU5LYJYA+DH5iObZ0GlU+2Aq3JkI32RGHVdS
	 WBgsY/RLWmSl7BgRpsa4Vg97rqSNapdF0c2B15gTlFkmI2qjNOJHJQrIP+f2nYUaGB
	 19L09Odq9QaQQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 1/6] selftests: drv-net: add stdout to the command failed exception
Date: Mon, 15 Apr 2024 17:45:51 -0700
Message-ID: <20240416004556.1618804-2-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416004556.1618804-1-kuba@kernel.org>
References: <20240416004556.1618804-1-kuba@kernel.org>
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
index f0d425731fd4..19612348c30d 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -33,7 +33,8 @@ import subprocess
         if self.proc.returncode != 0 and fail:
             if len(stderr) > 0 and stderr[-1] == "\n":
                 stderr = stderr[:-1]
-            raise Exception("Command failed: %s\n%s" % (self.proc.args, stderr))
+            raise Exception("Command failed: %s\nSTDOUT: %s\nSTDERR: %s" %
+                            (self.proc.args, stdout, stderr))
 
 
 def ip(args, json=None, ns=None):
-- 
2.44.0


