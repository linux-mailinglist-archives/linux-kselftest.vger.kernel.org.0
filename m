Return-Path: <linux-kselftest+bounces-8765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBD68B07B8
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 12:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC691C22A3C
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 10:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B6B15AD85;
	Wed, 24 Apr 2024 10:53:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36865156C6F;
	Wed, 24 Apr 2024 10:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713955993; cv=none; b=nzlkQlurNrHRVTdFIsMM+XP9kpz29sAf13rUkpKJ/EvFY92q3IA7St1FdWvkDFQKTZ6s80KVQKbBY29st86izLwvnoqmgr5ppaKwwfekICdCIYTibqnTy4/OWTyLw0st3Np37Jvkdip/u5NPk4L3e3PG0GWCbJgka6jVRwcn2BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713955993; c=relaxed/simple;
	bh=js8C/26yYtRBsgN6k1rTXrGTe9JoFXS17KjL+cl13uA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CM0MmFGhQVsLFEzcb8aIF+n4NzsKueSO7IUpfLKG3OGy+8Gb1lkvYZMYZzJYN4K4I1qVIBgE7ggoMJYe8BjfBSL4haNmOmPJmsHDzvExjAuyvXbrXCFAmgh3wN43A+aNkCN18t13FY7K4QEus1q2+jZYcECsp4yPz66JsqwtMpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D58A0339;
	Wed, 24 Apr 2024 03:53:37 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23FCE3F73F;
	Wed, 24 Apr 2024 03:53:09 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v1] selftests/mm: soft-dirty should fail if a testcase fails
Date: Wed, 24 Apr 2024 11:53:01 +0100
Message-Id: <20240424105301.3157695-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously soft-dirty was unconditionally exiting with success, even if
one of it's testcases failed. Let's fix that so that failure can be
reported to automated systems properly.

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

Applies on top of v6.9-rc3.

I previously sent this out as part of a larger series [1]. Feedback was to
repost standalone.

[1] https://lore.kernel.org/all/20240419074344.2643212-1-ryan.roberts@arm.com/

Thanks,
Ryan


 tools/testing/selftests/mm/soft-dirty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
index 7dbfa53d93a0..bdfa5d085f00 100644
--- a/tools/testing/selftests/mm/soft-dirty.c
+++ b/tools/testing/selftests/mm/soft-dirty.c
@@ -209,5 +209,5 @@ int main(int argc, char **argv)

 	close(pagemap_fd);

-	return ksft_exit_pass();
+	ksft_finished();
 }
--
2.25.1


