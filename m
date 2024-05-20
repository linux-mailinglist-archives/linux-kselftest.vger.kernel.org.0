Return-Path: <linux-kselftest+bounces-10448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A098CA2F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 21:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B32131C20BB4
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 19:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546D254735;
	Mon, 20 May 2024 19:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VhUZLS06"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDC912E6A;
	Mon, 20 May 2024 19:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716234837; cv=none; b=kK0/RM7J8BuFrnRtKzqOK8Exa1+XdkyI5Tjw+nWA6HAcmYpzSlIQQ9JkHJ7/meF9sCz0MMQU6Wz7vdOPQSu5XESgOlMQN4JsqYVuHKnmXnb7bS9mqWDVnW/JosIkFb3EnuN9j58DUMvnWzYMn0t6ZQX7MMtzPpOf97ncNCYK974=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716234837; c=relaxed/simple;
	bh=QxwadSFkxmRXFr0xxxHIn2pF5xPts2dxqh+DBylu7mQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rbHgP0hKbo1XOQCIrVUoYgKEq02bUpwsaD5aSi4EPVUiTsu9pm+MJ2xDcui8eTyjJIRewOE2hhs6l6bracFgzs9NaexTUP6Wd3rTrhZwkdkW7Rmcxumd23NHMSXpCpvpH56nTc/WS9+ZFepZ1pnQyPBVDGGDRUhVX7ZtF3sZwsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VhUZLS06; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716234833;
	bh=QxwadSFkxmRXFr0xxxHIn2pF5xPts2dxqh+DBylu7mQ=;
	h=From:To:Cc:Subject:Date:From;
	b=VhUZLS06j1YdBnQbzv56wlvUR5HQvP/1AvkKKjbuDbLyWBUR182YzrNpA53jj0242
	 /XfRVzmz2NPwJEqJ4wd3q1geEWlr3zMB3hKvXqSCwwLwldwYxWeCJt72l0fQ3kneEc
	 vlqrJdesHy/9tfTO5izTPOAmQKFQymdSt2ocrpWD2o1Al0Tds8TQgKcOziaLorI9au
	 CZ5KW2RBAZAHfCsmQjPa2KhipqUUce1J40a4H6aU1WN+tiM6K7JL5qB7Ly8DW+u324
	 disEcT1fkvvegQKdSYQvjt9vIAhmHagZsTdVqE5TtD8nBypirSCIvwOI1ug//FF0tI
	 aZUYxFQM7Ln4Q==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 317083780BFE;
	Mon, 20 May 2024 19:53:52 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: mm: check return values
Date: Mon, 20 May 2024 11:52:48 -0700
Message-Id: <20240520185248.1801945-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check return value and return error/skip the tests.

Fixes: 46fd75d4a3c9 ("selftests: mm: add pagemap ioctl tests")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/pagemap_ioctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index 2d785aca72a5c..bcc73b4e805c6 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -1567,8 +1567,10 @@ int main(int argc, char *argv[])
 	/* 7. File Hugetlb testing */
 	mem_size = 2*1024*1024;
 	fd = memfd_create("uffd-test", MFD_HUGETLB | MFD_NOEXEC_SEAL);
+	if (fd < 0)
+		ksft_exit_fail_msg("uffd-test creation failed %d %s\n", errno, strerror(errno));
 	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
-	if (mem) {
+	if (mem != MAP_FAILED) {
 		wp_init(mem, mem_size);
 		wp_addr_range(mem, mem_size);
 
-- 
2.39.2


