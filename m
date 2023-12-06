Return-Path: <linux-kselftest+bounces-1268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5452806C77
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 11:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF6D1F21271
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 10:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3DA2D021;
	Wed,  6 Dec 2023 10:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4ETiG5L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED16613AEA;
	Wed,  6 Dec 2023 10:46:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6328C43397;
	Wed,  6 Dec 2023 10:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701859575;
	bh=9Tw/V5BfsP8eOfjYMQJzQj/K+Mj6xP6MJHv7Smo4iQs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L4ETiG5LfvSl+3wBwj0ztHDODdoDVkt3URSTG20y9a80+aNFViolXNTPMo8xiW4l+
	 bwT+XtE/uSHBsxIsibmd1tNGXjd3dthrXJGk8U44CO2fkkUcggEWwRB3t4ppuKdBM5
	 e00Ozzpc4p1sOkis+unr0rrYB4n6z/OobQoE6xNPzy5xM/5EwipgbOT7fA0I6Lwuud
	 6E2Ih+1A0GmYU5D1O3cYVfLxrlot9ZTI2uVqjHSDhRpLu1HQ/L4VQgYXUkGYNJYvTv
	 Lnysz/R/s1BiiQnjBI2prayV5EGfaGnFneYqRkHTQ1houWSm2wYhULjxBZut4Xe3Bv
	 ytoJv32qz7zSA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 06 Dec 2023 11:45:55 +0100
Subject: [PATCH v2 04/15] selftests/hid: tablets: remove unused class
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-wip-selftests-v2-4-c0350c2f5986@kernel.org>
References: <20231206-wip-selftests-v2-0-c0350c2f5986@kernel.org>
In-Reply-To: <20231206-wip-selftests-v2-0-c0350c2f5986@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701859565; l=742;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=9Tw/V5BfsP8eOfjYMQJzQj/K+Mj6xP6MJHv7Smo4iQs=;
 b=EK73Kr733r3Gdl1YZvIa3AtxB9ftadyv5o2jtBzWLNR3Y1jK6VnfXbhFsqW5sVbkuHl1zYZBR
 rFTKD7oO/0XBqV8cvIqA4EwTCuM8wJRT3CWZdTz+3AeLYGK8vug/eY2
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Looks like this is a leftover

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
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


