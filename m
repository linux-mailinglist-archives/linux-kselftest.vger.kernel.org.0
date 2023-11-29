Return-Path: <linux-kselftest+bounces-826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 778257FDB38
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 16:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6421C21077
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 15:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26F2381A1;
	Wed, 29 Nov 2023 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaCfdq/T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8405237D3E;
	Wed, 29 Nov 2023 15:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15A0C43391;
	Wed, 29 Nov 2023 15:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701271509;
	bh=Nb8tm7B+NGdmZAEx/i4rqoigQ/eiqRZPYosDwPWo2AY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aaCfdq/T8P3k/Qh4KXZku0Z8B6cIu0RbB0RNZZzkHHLmxHjrN4it8JR0XeEBV0Cf0
	 QPI/cHNqaekn6Itmep5rX9+ohdRNG2iK/P8bCByOn1VCUhnv5b/AfQdK/h25N2lBts
	 9vQ42H8RWu9a4l4+sm8ziQbwuAMcGNcNOPcQpfXtoO+gSSejcGFW24/wWczAJDe4Dm
	 XIHVKaoLbzdJNsVKlXAUuP9NAbbQf1zAmj4MHPyP5+4qTPLboI1s4ItCxh3OgEgqXb
	 gfcE+JdDssCVAumDxPrgIORL3hA/oEFYeq+VdxUh3sz0jtp/twfIcrKPsd/laqirnA
	 jetXg8F0898gw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 29 Nov 2023 16:24:29 +0100
Subject: [PATCH 04/12] selftests/hid: tablets: remove unused class
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-wip-selftests-v1-4-ba15a1fe1b0d@kernel.org>
References: <20231129-wip-selftests-v1-0-ba15a1fe1b0d@kernel.org>
In-Reply-To: <20231129-wip-selftests-v1-0-ba15a1fe1b0d@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701271499; l=659;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=Nb8tm7B+NGdmZAEx/i4rqoigQ/eiqRZPYosDwPWo2AY=;
 b=PzPLUKbSzIb01Kpd2ou7OVM+vn83H+oaUcMIdpFBv7EfvQ2pYb8b3prdb4B/UOxafTCBqIaQR
 LmL0bOn3IM7ASYsWao6gT0wYsQYOl5E8zJrc5S695rHCF3mWCmjuqMc
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Looks like this is a leftover

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/tests/test_tablet.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
index 303ffff9ee8d..cd9c1269afa6 100644
--- a/tools/testing/selftests/hid/tests/test_tablet.py
+++ b/tools/testing/selftests/hid/tests/test_tablet.py
@@ -133,10 +133,6 @@ class PenState(Enum):
         return tuple()
 
 
-class Data(object):
-    pass
-
-
 class Pen(object):
     def __init__(self, x, y):
         self.x = x

-- 
2.41.0


