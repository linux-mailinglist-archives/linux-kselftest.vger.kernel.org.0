Return-Path: <linux-kselftest+bounces-4708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6280A8557FD
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 01:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AE9A1F21FDB
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 00:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8889514F9E9;
	Wed, 14 Feb 2024 23:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="YmtLhx3z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E07A14E2FD;
	Wed, 14 Feb 2024 23:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707954833; cv=none; b=ls3DwkJRZcZwXzB+dC8Yh9CNjQCadlrmolXuQg+jbKE6byS9QmM5gX6TwDZQPBelQS0zYL32y0QLl+x6JM2+SFy9Y/TfluNa1EllmqZ85ogZ2JxN8eNw8ufO+uWWZoxDClKQDg7a1wJpC9QKVD1ZKuT17QLpf+t5iFB5UChydAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707954833; c=relaxed/simple;
	bh=SJHckSnO59KNn4GgMh+3HCnN8XA5Fp4zU2xtYlg35+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QacwrXzdrgCDgm2L4Kc7/9rndQiwqZZ9EzJhz+jXtRtdi6BWkwaNavkCaPbsb+abgtWgd01fH92wNi7Xv+sv4f7avkobPO48I0xbt8saly9p6BnxJ0FEA/qJy/u8+Zu3hdr9labkgDc/k26+9h1bBpStaM16wVGXY35+CWDFI1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=YmtLhx3z; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=KNfTFrOlykYG/fleH9ulVSplLfHApmFBo701D/t2NDY=; b=YmtLhx3zkmHA/dpXVcH93FP23h
	hB+IaXS7Vuatgkf5hHyT35+L/TOabJkc11O/CoP88JZUhZmk0SzVZrgA6pe/KPwpXNj1MSGgvHcQb
	EWytT+lFqAdH/SmKEJH0lzKmdmOYJQiFsDCk9Px1a1nGyv8rPKMLNTHLcnNUnsC3NiKb3nW8/QbrL
	PFea1lWKDTjQnGjPSVFrm4jGYqubwWESj3l2YMwVAR8f7CWrzJLSAPj9+NCBH9dcaby7P6ctQ+FnG
	c+xG+DRO5OGvi8d52LJKn6586dmRsHKqAWfV/fFB7HXS3+VyL6zPrZ4Rm5GFWtt4Ba0uC1Vhxxeh3
	CVZCby7Q==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1raP4X-00GcSK-0Z;
	Wed, 14 Feb 2024 17:53:49 -0600
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
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [PATCH 30/31] maintainers: Add an entry for ntsync.
Date: Wed, 14 Feb 2024 17:53:05 -0600
Message-ID: <20240214235307.10494-21-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214235307.10494-1-zfigura@codeweavers.com>
References: <20240214233645.9273-1-zfigura@codeweavers.com>
 <20240214235307.10494-1-zfigura@codeweavers.com>
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
index 960512bec428..e80ed255951b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15591,6 +15591,15 @@ T:	git https://github.com/Paragon-Software-Group/linux-ntfs3.git
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


