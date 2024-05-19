Return-Path: <linux-kselftest+bounces-10403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D67F8C965F
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 22:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054641F211D1
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 20:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C84768EA;
	Sun, 19 May 2024 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="d+f9ku/Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D2B6D1B9;
	Sun, 19 May 2024 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716150319; cv=none; b=LFEjjvGoBCnr/3RgpMyb8z48TYtWgZItHQQ2/pJdR3jLlJ+AVmL1hH0or1YIOkiGxYJr5n/HX3ZkllCr4L0mqsDMj09746lPeOkLsL81O1X+/An3PAwfWl0MFfOMZp9GZaaxRuUIsKSIokOoZxUwmKaLFem/PAIhV63ZchOBApA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716150319; c=relaxed/simple;
	bh=Ab69AfMl5s2HGKThTzcfia+0ARaIy7ZHxeWA1a+xzg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m2aCEWr+6XS64+rwDg8vyXZuu/aOL/WVjULq7/kuJQNaRa+lXHuTnVq9K0YHThTqZ+S6pGzYKrTClWsUI9AloTjUHsYA63rbzB6dT3QL+mF6w8gXRrFzAXEnO58i9o6Ah5y5UHq+Q0S7q2s4cMZPrdMdnfliGT8qXiOcz0aKgpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=d+f9ku/Y; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=VdK2oeTVoe5yhUMrLM100xnYjqFCb6ObBf63KIgk/7I=; b=d+f9ku/Yu2E+VySvadD8hCvF6W
	MjXAr8xwMQeB/0y7/g/HQC+U3ui+x0bybvV27lgoJRdvS+yCkrgMtSkdmRTznIS/yHB9YTSWGKbGn
	dZgBwqm+mUXhTcuRCrnuULdEHwgmvGx0OkTNSxWszJNGe5kpujK2ewNz5qic7TZYPdzQnSBEKBzCs
	Gg/ZC3k6hF6Q9S0HeDdO2wwG2pEI5qVS9J2ZngMjPYRn4tMJxH5myLAqzEpWed0VaAJ07u1zMisEL
	LOq14ItTYtgHgCHpe2NQgdiNNp6cxuNvpD3uFJyWEWPx/iAT8ikgxk4Zpeqv/BDHDjzHcy/x4b3aN
	mOmp535Q==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1s8n5j-008wIn-0W;
	Sun, 19 May 2024 15:25:11 -0500
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
Subject: [PATCH v5 26/28] maintainers: Add an entry for ntsync.
Date: Sun, 19 May 2024 15:24:52 -0500
Message-ID: <20240519202454.1192826-27-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240519202454.1192826-1-zfigura@codeweavers.com>
References: <20240519202454.1192826-1-zfigura@codeweavers.com>
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
index c6dbde10bfc1..c9c9f1d98dd6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15748,6 +15748,15 @@ T:	git https://github.com/Paragon-Software-Group/linux-ntfs3.git
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


