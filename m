Return-Path: <linux-kselftest+bounces-8068-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE118A5FEF
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 03:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF6F028487B
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 01:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511503BBC0;
	Tue, 16 Apr 2024 01:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="MLMYd6K5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D34200DB;
	Tue, 16 Apr 2024 01:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713229834; cv=none; b=h5gEhXp10rFtTMaO1bdBsb5agtRisamPJvfmeXqD30s/zzCSI8XjcoY+fQH0Ly0bluGhUs2Az0ue4hU87WbMmIxv5fibeBlV0ewssvhSPITqK5y+hQM+xEkqHYFTR01Qnzo03UiYUEakET2jkIuQXpqG5nUAp9W+AWgf/1e/M2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713229834; c=relaxed/simple;
	bh=7g70MEkYsbvyv5B3tP07rIgV0HE0wsXAskPkOYz8lu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOPexFAvJbxqlGpi7gIdKu9v47D+ao/53NRVmD7dJSDbthkA+UTb9QlgNlBXWhs+geq3hxK9Wj8EF8n9yZe2WbxD3FV9SqwV7HN4PL4toNdDurZ6ZjenGHUe30bSY7zCI+fkVRLK822bytRLzQ7PDb0U8qZI2SYqELk5whZY2v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=MLMYd6K5; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=96ODQpwakoPzfWh2F7/9agUhbVTfz5BIqgRK/StEgUg=; b=MLMYd6K5QaEhBn06hEjaG4NMNl
	PSABkqphKgXc/eSI2XNdnh2Dug9LyuiG9i4u9fI0qn7wwXTkuxKMgu7Vcfi6+vVaqOt6v6UsThzYo
	yumew+lpe7jpPZ7yvPnwKRTO4qEe7YC6VulRcpz/GdRiTk3Z7V2f1j7Mtz3x4yll8+WiM0lXvDqky
	6iJoD17r8IdAQpJUzOzebnPNQsC2RYCS+ZiyU8JYAVI843+mCup5t9ySo16e/ngKsdh0T+MWCZfbe
	LbH6PEJHSBc2r7xXfGPTDeuD9XPMy/36favJgPuW8Bc1Y5MvDbh1qOKDrPUuycrcLkYtRHATi7BFi
	h0GixevQ==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rwXL6-00FbQv-37;
	Mon, 15 Apr 2024 20:10:25 -0500
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
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [PATCH v4 26/27] maintainers: Add an entry for ntsync.
Date: Mon, 15 Apr 2024 20:08:36 -0500
Message-ID: <20240416010837.333694-27-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240416010837.333694-1-zfigura@codeweavers.com>
References: <20240416010837.333694-1-zfigura@codeweavers.com>
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
index 41a013dfebbc..09ae011a8d91 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15728,6 +15728,15 @@ T:	git https://github.com/Paragon-Software-Group/linux-ntfs3.git
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


