Return-Path: <linux-kselftest+bounces-2547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4338C82134A
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jan 2024 09:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9570E282D3F
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jan 2024 08:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D064017C6;
	Mon,  1 Jan 2024 08:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mJ5H00/h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53269210B;
	Mon,  1 Jan 2024 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704098183;
	bh=giHGWwDeltvyjzRJyE60kEU8wo+8AOWtU2n4rpsZokA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mJ5H00/hzYa7ecJ8yDwgc+W5yoNyAGqahFf2l+LnINskO8F7x2swpkhkcqzQeuomo
	 wy5BCXS+iB16I2qtXXD0d5R36w5bYjTWwtXhjZse9YYzyOedJ/mJrIRiyAejGk4hPX
	 QQVNXSuyTOGs9fvp8JPi5WWbT8hOO0c9YiuGy3Un1Eff82GApXYA6XuNPHO/VxYgUk
	 HMBxwUdf32sqyIt/1lhe407G2ciTAmHBgWtTseS4kornAhmbqSRGBkGrVGWN+0xkfD
	 ePybNEAuihCMN8hf9k4dw04GkfAl71aelQ5iEUnuh9phQQNB0v3Nqe8tifym2B3QAE
	 zcT/Uq4MH85Nw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6592B3780894;
	Mon,  1 Jan 2024 08:36:20 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests/mm: skip test if application doesn't has root privileges
Date: Mon,  1 Jan 2024 13:36:13 +0500
Message-ID: <20240101083614.1076768-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240101083614.1076768-1-usama.anjum@collabora.com>
References: <20240101083614.1076768-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test depends on writing to nr_hugepages which isn't possible without
root privileges. So skip the test in this case.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/compaction_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
index 707b0809b717..656afba02dbc 100644
--- a/tools/testing/selftests/mm/compaction_test.c
+++ b/tools/testing/selftests/mm/compaction_test.c
@@ -173,7 +173,7 @@ int main(int argc, char **argv)
 
 	ksft_print_header();
 
-	if (prereq() != 0)
+	if (prereq() || geteuid())
 		return ksft_exit_pass();
 
 	ksft_set_plan(1);
-- 
2.42.0


