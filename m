Return-Path: <linux-kselftest+bounces-7207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C57C6898BE6
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 18:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646081F24F3D
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 16:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74BD12D214;
	Thu,  4 Apr 2024 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fRx2C0Ai"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C45612D758;
	Thu,  4 Apr 2024 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712247261; cv=none; b=kd/7xQdiGxwVQyenHlLgjFyeSym38yYJOUwKQ/6/Y3ZLHrmOiNksLejU3poDcrRnT172LXLm6d8BlAv2TXfY7AZnvdafM4unCf85sCa1T7BfRIbJMKg0SZaXikqNH/+i3URjCCfHwFQiu0mHHvO9QGGukGB88O09PjPduY/8ya0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712247261; c=relaxed/simple;
	bh=ldtvjkAh4uiGxCheNFBwI4fa4kaJRENVGkoL+ZPIS0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jFnh6xCQ/8HCz+Zn/wVwhpmLGvlWfwIUiq4nxUnBO1+KBDZftPJN+I9Q8l0xlE9PR4h13YNCwlTwekYzXOk3uT55MdHQhIt0RglseV2ISOBFd9O2/paHExTOpMIMz9lTOystlVdSF/gRTxmke9HeqJko/zYVm8l9Q9P+snnRneE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fRx2C0Ai; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712247258;
	bh=ldtvjkAh4uiGxCheNFBwI4fa4kaJRENVGkoL+ZPIS0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fRx2C0AiLQ4G1u6VFtu1nRt8ktODQ2HPoOEC4eASfbnsv3kNtEnb3RqER3Y2wbRY9
	 d/pJoQRl2pj7+q7DT0patY2f1zEPrCtrwOUGfyEg+1Y9GoFWQMUusXNax/Kl1k9DY1
	 73JunOQKqEIxh0+00nwpZp9kupfykapjNm13AahJ2r9U2cuRX5xsRw9syYMPjG5lR1
	 JnvrI/7rMjOBLXXhKhsNJ9b2Be3kKxApdA/+kWDhXAzANyGnmiGUzjGpQ0M/2GT64W
	 SpEU9pSg90tT9ET8Bb0UgJvlZbj/k0v0OPetMnblBZWVFmWXQfOqKLD2YM0CZcB08/
	 VqJE/TPfcDIEA==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B8A7B378212B;
	Thu,  4 Apr 2024 16:14:14 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel@collabora.com
Subject: [PATCH 2/2] selftests: exec: Use new ksft_exit_fail_perror() helper
Date: Thu,  4 Apr 2024 21:14:33 +0500
Message-Id: <20240404161433.114497-3-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240404161433.114497-1-usama.anjum@collabora.com>
References: <20240404161433.114497-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use ksft_exit_fail_perror() to print the value of errno and its string
form. This is the first user of the ksft_exit_fail_perror() and proves
the usefulness of this API.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/exec/recursion-depth.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/exec/recursion-depth.c b/tools/testing/selftests/exec/recursion-depth.c
index b2f37d86a5f62..438c8ff2fd260 100644
--- a/tools/testing/selftests/exec/recursion-depth.c
+++ b/tools/testing/selftests/exec/recursion-depth.c
@@ -37,25 +37,25 @@ int main(void)
 			ksft_test_result_skip("error: unshare, errno %d\n", errno);
 			ksft_finished();
 		}
-		ksft_exit_fail_msg("error: unshare, errno %d\n", errno);
+		ksft_exit_fail_perror("error: unshare");
 	}
 
 	if (mount(NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL) == -1)
-		ksft_exit_fail_msg("error: mount '/', errno %d\n", errno);
+		ksft_exit_fail_perror("error: mount '/'");
 
 	/* Require "exec" filesystem. */
 	if (mount(NULL, "/tmp", "ramfs", 0, NULL) == -1)
-		ksft_exit_fail_msg("error: mount ramfs, errno %d\n", errno);
+		ksft_exit_fail_perror("error: mount ramfs");
 
 #define FILENAME "/tmp/1"
 
 	fd = creat(FILENAME, 0700);
 	if (fd == -1)
-		ksft_exit_fail_msg("error: creat, errno %d\n", errno);
+		ksft_exit_fail_perror("error: creat");
 
 #define S "#!" FILENAME "\n"
 	if (write(fd, S, strlen(S)) != strlen(S))
-		ksft_exit_fail_msg("error: write, errno %d\n", errno);
+		ksft_exit_fail_perror("error: write");
 
 	close(fd);
 
-- 
2.39.2


