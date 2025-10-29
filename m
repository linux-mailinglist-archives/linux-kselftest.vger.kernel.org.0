Return-Path: <linux-kselftest+bounces-44309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5148C1BF57
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 17:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 078C919C3C5F
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 16:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2DA34B1A7;
	Wed, 29 Oct 2025 16:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="VJ+bfWtS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408F23375C3;
	Wed, 29 Oct 2025 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753892; cv=none; b=S9ROQXvhfAtADK2jm/cBLUaqLDZMFawMYfDdvxRUExsrAeFtE9nA8CLoRanLp6RPuOfq84FJwCGVxmA407UvDuGGt3HLgQ0QTisuglrqtEHKbo1HG0lyDksTqtqZqy5/NY9H/AiDq+UT1jdQDBKoNcMzKyzxqsF5KalHaTxsBQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753892; c=relaxed/simple;
	bh=p8j6KI5U2HWyMls37DISJDXR7gsqGwKcS5o2esypx3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UI0YRNCMh74spdwoI+gGZB54iOIsPdSZ7SeKduFHPoHVk3d/oXjIAO3S8NjIqdszn0imnBupCJ5VOc+gU3AAubqjMdHCUOYclhRJpVY3QN7oA1R4qjzaoEOrLOUkD+iy4Qvq4Ufn2hctXJddse0n+v8z0ut5abUJbbCQ18sbzYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=VJ+bfWtS; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761753882;
	bh=p8j6KI5U2HWyMls37DISJDXR7gsqGwKcS5o2esypx3E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VJ+bfWtSmDxg7L5VLT5kMYe+vSl3kItv6MhK+AO4DIQudR/8DIYd/ZTB9HwYK9K3b
	 NiEyzKk7YX5Sg9qC/ycRpayl0SjMXfHrWMvS1wPJCc4vRgXnzjT+oInDE7JH8ZF1OP
	 9BFL6A0NDKXjmykxwHs4Z13hjILq3yisdscZH+Ok=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 29 Oct 2025 17:02:54 +0100
Subject: [PATCH 04/12] tools/nolibc: use 64-bit off_t
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251029-nolibc-uapi-types-v1-4-e79de3b215d8@weissschuh.net>
References: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
In-Reply-To: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761753881; l=1030;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=p8j6KI5U2HWyMls37DISJDXR7gsqGwKcS5o2esypx3E=;
 b=b/w0aY84tvGY5qVbZlu9Qgoas141xbvuYg3ANiAFrcUxLKME3YjnNu2IKOhzv0WiALXXFlhm2
 R3BCpM5UkZzAxnHCVbO2c1qM1tHIW9VMMUaXTlb7MUp6rqQQXovGq00
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The kernel uses 64-bit values for file offsets.
Currently these might be truncated to 32-bit when assigned to
nolibc's off_t values.

Switch to 64-bit off_t consistently.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/lkml/cec27d94-c99d-4c57-9a12-275ea663dda8@app.fastmail.com/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/std.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/std.h b/tools/include/nolibc/std.h
index eae457d60858..392f4dd94158 100644
--- a/tools/include/nolibc/std.h
+++ b/tools/include/nolibc/std.h
@@ -26,7 +26,7 @@ typedef   signed int          pid_t;
 typedef unsigned int          uid_t;
 typedef unsigned int          gid_t;
 typedef unsigned long       nlink_t;
-typedef   signed long         off_t;
+typedef  int64_t              off_t;
 typedef   signed long     blksize_t;
 typedef   signed long      blkcnt_t;
 typedef __kernel_time_t      time_t;

-- 
2.51.1.dirty


