Return-Path: <linux-kselftest+bounces-3069-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3F682EB42
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 10:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602C41F24227
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 09:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72292125BF;
	Tue, 16 Jan 2024 09:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MjVEw5nk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EB512B70;
	Tue, 16 Jan 2024 09:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705395929;
	bh=ugmXZTrJwY2DWctHzDYOn6LeXz0LXSbkdXjcp9JcxPY=;
	h=From:To:Cc:Subject:Date:From;
	b=MjVEw5nkSkP/JIGNqaz8zdXhJ+OBdsmCH/EnCjOyDWaEJf94kW40RkGtgkxlk7dHq
	 psvYgaoIkR3YK0x1sP+41I/XoAnYotI6lwTiq3X/uIpfjD4uUzh9+Sd4IYYZQt7WgW
	 yG7p8rr842sLq9QwHppi8v8x/8oirKTNiUb+6wIu2lzg/wlW4UtGdU9pb8upJjP3qC
	 k1/iA6Q3kEP7iKDSch3PsUmrvVL8+EVK2D1ceypwisR0XunEXPgySBJISukKY3Fe/g
	 cF7ZAzgupoHnFyrrZtZDpQ651GwKEc4zHh169MQNUV36jrzsYQtDbENiOt96VbwqJi
	 xRR0ZrrVcYSsA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 212D7378200E;
	Tue, 16 Jan 2024 09:05:26 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/mm: switch to bash from sh
Date: Tue, 16 Jan 2024 14:04:54 +0500
Message-ID: <20240116090455.3407378-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running charge_reserved_hugetlb.sh generates errors if sh is set to
dash:

./charge_reserved_hugetlb.sh: 9: [[: not found
./charge_reserved_hugetlb.sh: 19: [[: not found
./charge_reserved_hugetlb.sh: 27: [[: not found
./charge_reserved_hugetlb.sh: 37: [[: not found
./charge_reserved_hugetlb.sh: 45: Syntax error: "(" unexpected

Switch to using /bin/bash instead of /bin/sh. Make the switch for
write_hugetlb_memory.sh as well which is called from
charge_reserved_hugetlb.sh.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/charge_reserved_hugetlb.sh | 2 +-
 tools/testing/selftests/mm/write_hugetlb_memory.sh    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
index 0899019a7fcb..e14bdd4455f2 100755
--- a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
+++ b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
 # Kselftest framework requirement - SKIP code is 4.
diff --git a/tools/testing/selftests/mm/write_hugetlb_memory.sh b/tools/testing/selftests/mm/write_hugetlb_memory.sh
index 70a02301f4c2..3d2d2eb9d6ff 100755
--- a/tools/testing/selftests/mm/write_hugetlb_memory.sh
+++ b/tools/testing/selftests/mm/write_hugetlb_memory.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
-- 
2.42.0


