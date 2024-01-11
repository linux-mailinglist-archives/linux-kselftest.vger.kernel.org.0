Return-Path: <linux-kselftest+bounces-2840-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 128FD82A8FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 09:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231F61C2237E
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 08:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9F0FBE5;
	Thu, 11 Jan 2024 08:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4QZg8gxL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC2714F65;
	Thu, 11 Jan 2024 08:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704961236;
	bh=+QT1qADhN3aElSdApBfVVCCL+syggMVKAodbmRy0hY4=;
	h=From:To:Cc:Subject:Date:From;
	b=4QZg8gxL+JFstU+vyMO5eplxQfKU549dclXgTi1cHfIgtDefRmcl+7qw5uF41OviO
	 wpkC9o/TF0PWgQLoZqz1BR7kSzR8ZzPCCgRTRajhJeEfH3MY14oytlJBYPNIijQ4N3
	 23gfkESjaQTj1DG1LQrBxEbtZwqtWpxZpGGif1NqOHqPF3HCQOcVx1LiT44VS8eLGQ
	 2hoJlT5hSFc7UBpNquoRJshxnO135R3HdpqGocGh0K7tuHJi0/3lnN29fgtxEIa3wg
	 /hkHvQtVAlMpao5tXZQGaBXIP+edzE1LpZO6VLbOHKOP64gFa3FzJ4OkRJ0T9cPPiy
	 L9DB6WwuXL0xA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0D5363781492;
	Thu, 11 Jan 2024 08:20:33 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/mm: mremap_test: fix build warning
Date: Thu, 11 Jan 2024 13:20:38 +0500
Message-ID: <20240111082039.3398848-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix following build warning:
warning: format ‘%d’ expects argument of type ‘int’, but argument 2 has type ‘long long unsigned int’

Fixes: a4cb3b243343 ("selftests: mm: add a test for remapping to area immediately after existing mapping")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/mremap_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index 1d4c1589c305..dd1cbb068982 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -457,7 +457,7 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 			char c = (char) rand();
 
 			if (((char *) dest_preamble_addr)[i] != c) {
-				ksft_print_msg("Preamble data after remap doesn't match at offset %d\n",
+				ksft_print_msg("Preamble data after remap doesn't match at offset %llu\n",
 					       i);
 				ksft_print_msg("Expected: %#x\t Got: %#x\n", c & 0xff,
 					       ((char *) dest_preamble_addr)[i] & 0xff);
-- 
2.42.0


