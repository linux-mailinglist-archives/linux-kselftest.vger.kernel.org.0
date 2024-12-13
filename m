Return-Path: <linux-kselftest+bounces-23364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F35B9F1685
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 20:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08871890B85
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 19:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAB11F8F08;
	Fri, 13 Dec 2024 19:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="cFcvnPfy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A221F8EEC;
	Fri, 13 Dec 2024 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118575; cv=none; b=X89rGtEvLVninRVqGX4KbIAvlQ4EDdFeawZfrO0BfL17hxkATxvbx+gVQU8q0HgbEGCQn5NGYKCCaegm47/FCe9TqI5VQvm9Z93cCM2ARjCJkVhYx01cj1TCcZwlWlM2+hmyUSwPy/DqBhNL/PFGR5d5BqHl439Jzevce4Fd6hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118575; c=relaxed/simple;
	bh=OJvM6op5wYx37WguuHJVy5B8DCwQrTuTTPhePbmCAcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNoIKQ7sNo7kWoboopUvjMujUBLRFUzPmQQ67oJSskmeTgoePHjg3ZW6NwoAm2UFevhCMT6uVlUJ7F4TOUSFb9tajceV9mYlkamKBF4ycMVRblVdx8w8e8LopMuZ3v6YOl9D1oqDBmS1L2IWpoj5lwYyJja4Y0hJg1C7J+aHU7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=cFcvnPfy; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0P2C43dx5tRTctB9mu2F7UXtDC2Bs0A7lV36tqxIGe4=; b=cFcvnPfyyEDyAF88DnZSGAQQe1
	72wqsgfuSEMqPyjVaYBNoADVQlKfxA7tc+f8dc2HEpsmrgT+vJFuBQYcZpzBMnrFrepLlnLMNgXiK
	UlwnW89bdDZs77XK8LvhaMxx+HNR9zRYulZwKIs1OThHSwSHVN5VxHojuhvvOzgi/U/bFe6k1zaj1
	Yby/jDUEOLeLGKjbhpUqYE3hK7a3wbBHuUS/UO17As0pNKpg00Hs7HyXNHjzXDedF9GUr4OzzR4ms
	0cwsUR38jHCmwsyNApfq5wMGfnPxNLTF3tSm53pmFjSfdPmRdTgMFNdkYy+XpQ/JkHUO7bRlS243h
	AlweDgSA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tMBSJ-00ASsZ-0f;
	Fri, 13 Dec 2024 13:36:08 -0600
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
Subject: [PATCH v7 28/30] maintainers: Add an entry for ntsync.
Date: Fri, 13 Dec 2024 13:35:09 -0600
Message-ID: <20241213193511.457338-29-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213193511.457338-1-zfigura@codeweavers.com>
References: <20241213193511.457338-1-zfigura@codeweavers.com>
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
index 1e930c7a58b1..8c3dd9077fc2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16708,6 +16708,15 @@ T:	git https://github.com/Paragon-Software-Group/linux-ntfs3.git
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
2.45.2


