Return-Path: <linux-kselftest+bounces-18550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8DF9897FB
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 23:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E99282949
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 21:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B0A17BB11;
	Sun, 29 Sep 2024 21:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="nVvfdLLN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6476BFCA;
	Sun, 29 Sep 2024 21:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727646471; cv=none; b=YrGjclFTFIYsN0x4DENRmmwjBzpivC/9d7EPQf5I2M8F6mqP4DAIshVsJ92D7DP7Pg8hBCNTrFlZ3G7DVH+UrZeXrcvK0DaP0HlBkvc4sgoxGSkqeVpAEVh5Sjm7Aqc2WQZmhvG5zzn7ZeCPPQRDwo1HD2QT1GAdXWUVBbbQn2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727646471; c=relaxed/simple;
	bh=MulA0rURMeNske1UgIGnFH1FtKaa7d9GjQrQlxdDJhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MNeJ8t680lYdDiQQw2U1vU/1xqYmHBQkqk8DISdlEAfANv62qMlI6nXryRmcG9qblCW1kjtQkjigYMgwUNYgHEtD/0uV79H5MaudzYc0wfptHQyQ4QsRIK2AsYXHerGHoq63WNOkFxuTD2X9+T8bDMqvd3C0bBveYNnv3sS5TkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=nVvfdLLN; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1727646464;
	bh=MulA0rURMeNske1UgIGnFH1FtKaa7d9GjQrQlxdDJhs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nVvfdLLNVCiGMum1ua/MxM+fGg4WAtcee1qXj6TG4IJ739Fk4KH0vKVVk5QVVDEeX
	 7K5HhOWH9rJ/poSiMaI+fzozxqdyfVt0bYsjMLHd4nBKYjXnFLsm04Px0XbKUc3h6U
	 3fhHqDOO0GHLVr8VUY2bJG69Bcj+54Zyy6PbRVTQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 29 Sep 2024 23:47:37 +0200
Subject: [PATCH 2/5] tools/nolibc: provide a fallback for lseek through
 llseek
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240929-nolibc-csky-v1-2-bb28031a73b0@weissschuh.net>
References: <20240929-nolibc-csky-v1-0-bb28031a73b0@weissschuh.net>
In-Reply-To: <20240929-nolibc-csky-v1-0-bb28031a73b0@weissschuh.net>
To: Guo Ren <guoren@kernel.org>, Willy Tarreau <w@1wt.eu>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727646464; l=986;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=MulA0rURMeNske1UgIGnFH1FtKaa7d9GjQrQlxdDJhs=;
 b=z9fHPM3rogDBEyaoKCauQ5Uk8UU4+nLbufcN7bota5eZy+6hygwd2HcukhexF0i+ltK3gLXbY
 oS07svIimY/DB0nACOBV416CUixFArCTsr3916tCo1qc6m7agaItuWW
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Not all architectures implement the lseek syscall, for example csky for
which support will be added.
Provide a fallback implementation to the llseek syscall.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/sys.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 7b82bc3cf107439a3f09f98b99d4d540ffb9ba2a..b3b78343647177c9e5ecb7261997b4f5e03fb8f5 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -595,6 +595,14 @@ off_t sys_lseek(int fd, off_t offset, int whence)
 {
 #ifdef __NR_lseek
 	return my_syscall3(__NR_lseek, fd, offset, whence);
+#elif defined(__NR_llseek)
+	off_t result;
+	int ret;
+
+	ret = my_syscall5(__NR_llseek, fd,
+			  sizeof(offset) > 4 ? offset >> 32 : 0,
+			  offset, &result, whence);
+	return ret ? ret : result;
 #else
 	return __nolibc_enosys(__func__, fd, offset, whence);
 #endif

-- 
2.46.2


