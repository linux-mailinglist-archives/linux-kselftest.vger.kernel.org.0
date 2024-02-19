Return-Path: <linux-kselftest+bounces-4978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BA785AEFD
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 23:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1EE51C236DA
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 22:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384695BAD1;
	Mon, 19 Feb 2024 22:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="Ljfk4RsK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD7A58ABE;
	Mon, 19 Feb 2024 22:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708382383; cv=none; b=NxenBm/+JNQPB11Xaeht5z7rvtlLx+9dmHcwdl3S3QFHNfMJ/n/OP/59/uAqR8UlxHaAyaQxMMJtjBpWQQrSRUc3YVro5aGMmJ3sjP9yY9y/5IumT64bMPOARpHEzc8yNQc1RyVVsQLSCNcQCBp6v0t3ynT8YB3hXUxM5+PxRBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708382383; c=relaxed/simple;
	bh=p01L6av4Fibfqe9Ft5JEuuMdbFwMYOdJziRoJnmGKNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAu9dYeF1wmvbIlg87bQqMV/KMMGk5ONeYREcEkRYK8C8TEOWljAsVEIuP3GBPIlF09D0Ce1qlD5rLrkuULopm4JQJ4ShkWM0Z+wP915BVgruOoFq0wV4w8O3qbDSpnDfMWJRHEPZgWHrO0agt6pl9P3hvpgaD+8lfm//ZUMZQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=Ljfk4RsK; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=dAFFuBNya4nffZscrJ3QkaFdEWP403BeenFfOcb76Jk=; b=Ljfk4RsK9vN7/LcpQw4oOzg+3r
	W0iWiXbEI+wXNLu9KbBeFOH6YWbrHUXME41BLLP0cVKrUGWOGn+X2UlgpnNBkUr9Mfp570aDpwgMl
	FB/Nl11wi9E7qlQtcQgjXvE96+U8oMHG1jlpbgyL6W5qDP1MzaW4ak4RPnanv4XILAvhUK9QaQC3X
	OgvFpYEPsCzryh2II0vvzmXotrSOkP8cx2gKBtB7VAjTmUjT1ya2w/r34ACvQTRzo1KC3MJO/skPu
	hMZvMqxOEpwRBtnW3KDMhpZI2gWBydWFSNDU8RD2ic1AYkSyCsw9ygJobr5h7PJ4L5F3X4rTeWJ+p
	J+PV4p6A==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rcCIU-0037Oz-31;
	Mon, 19 Feb 2024 16:39:39 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	wine-devel@winehq.org,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [PATCH v2 30/31] maintainers: Add an entry for ntsync.
Date: Mon, 19 Feb 2024 16:38:32 -0600
Message-ID: <20240219223833.95710-31-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240219223833.95710-1-zfigura@codeweavers.com>
References: <20240219223833.95710-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as maintainer, supported by CodeWeavers.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ed4d3868539..d83dd35d9f73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15595,6 +15595,15 @@ T:	git https://github.com/Paragon-Software-Group/linux-ntfs3.git
 F:	Documentation/filesystems/ntfs3.rst
 F:	fs/ntfs3/
 
+NTSYNC SYNCHRONIZATION PRIMITIVE DRIVER
+M:	Elizabeth Figura <zfigura@codeweavers.com>
+L:	wine-devel@winehq.org
+S:	Supported
+F:	Documentation/userspace-api/ntsync.rst
+F:	drivers/misc/ntsync.c
+F:	include/uapi/linux/ntsync.h
+F:	tools/testing/selftests/drivers/ntsync/
+
 NUBUS SUBSYSTEM
 M:	Finn Thain <fthain@linux-m68k.org>
 L:	linux-m68k@lists.linux-m68k.org
-- 
2.43.0


