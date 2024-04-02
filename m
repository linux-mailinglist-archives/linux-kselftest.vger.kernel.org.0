Return-Path: <linux-kselftest+bounces-6963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4CB894890
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 03:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C944283870
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 01:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E543B8F7D;
	Tue,  2 Apr 2024 01:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyWCcDLQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5428C13;
	Tue,  2 Apr 2024 01:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712019940; cv=none; b=YM0aToOfhaW+VQyBuTFBeHL4xE9sit7aZO5M2jqLTSgxnm54vGGmUu9NrvqauH9XIwF7TpPaK5Yr4Y7pP54atMhhpLt0KBj9FamFyH1FIgCy6zpya/NVSxWs68bLZIAwOZ6pFujP5Yxcylv6IF0JAec7o2lKxiGI/8XTfeDDPVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712019940; c=relaxed/simple;
	bh=qMDSBPwJr3ShI0X/pT3ZBrb1Z8HIj3lJ315yAx7FL18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iokVnwkW/cXJy5HyBOxSBtaGEnJYi5ikI99k/WqJUXqqpxjsHkhFxv4hM6HsQXw3BjIWIS9me1OFLIIOJLMmpp30O42MrZFwqfR/k7+UMu8mH07FNiaF7Ek0hVUB4SapHcs9fMYUZapyQ82hkKcDKAcwzJQ2yw98zaaaV+4Polo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyWCcDLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF94C433C7;
	Tue,  2 Apr 2024 01:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712019940;
	bh=qMDSBPwJr3ShI0X/pT3ZBrb1Z8HIj3lJ315yAx7FL18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JyWCcDLQFj/mck9sF5z5umEQiqstOnWzrmQps5Cmtno1XkljIeqJhRXJ0I6HSWU1e
	 OFdgm3NRqkiGCMJuhFTivnTj9q+eM5RlK1iApB74Nlth8vSdACxjKm5KFkywvWzIQn
	 +DU/uzkSkAVAIeRg6tY2PibPGqY8s6ZMHSHMlc0ZVWawxJGtU9Ci6Pm8xL170/t3r3
	 cEBAB9ZEBZ4P6Ro26ZZn8OigocDFc/ImrChLSXyVtykKWkGcr/U2hZ4dElIv7SlMts
	 v2+8KuUqv8SNsjCv7MkFO3D7/B6mMycqN3cfnfMNUWMIgJkUeCEOsVLf7je2o76rNj
	 y7gy1F/qaNSUg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	sdf@google.com,
	donald.hunter@gmail.com,
	linux-kselftest@vger.kernel.org,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>,
	jiri@resnulli.us
Subject: [PATCH net-next 2/7] tools: ynl: copy netlink error to NlError
Date: Mon,  1 Apr 2024 18:05:14 -0700
Message-ID: <20240402010520.1209517-3-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402010520.1209517-1-kuba@kernel.org>
References: <20240402010520.1209517-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Typing e.nl_msg.error when processing exception is a bit tedious
and counter-intuitive. Set a local .error member to the positive
value of the netlink level error.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: jiri@resnulli.us
---
 tools/net/ynl/lib/ynl.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 82d3c98067aa..b30210f537f7 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -100,9 +100,10 @@ from .nlspec import SpecFamily
 class NlError(Exception):
   def __init__(self, nl_msg):
     self.nl_msg = nl_msg
+    self.error = -nl_msg.error
 
   def __str__(self):
-    return f"Netlink error: {os.strerror(-self.nl_msg.error)}\n{self.nl_msg}"
+    return f"Netlink error: {os.strerror(self.error)}\n{self.nl_msg}"
 
 
 class ConfigError(Exception):
-- 
2.44.0


