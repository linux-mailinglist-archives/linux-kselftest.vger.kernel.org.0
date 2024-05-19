Return-Path: <linux-kselftest+bounces-10406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3518C9667
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 22:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6905E1F211BC
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 20:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0986770FC;
	Sun, 19 May 2024 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="LysfzxI2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC616E5E8;
	Sun, 19 May 2024 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716150319; cv=none; b=Up5eA/IgueX2O9vAme39qUxTBNpVjsn5itIFwXx4WayqHotdHlEZJlsUt6qqRvKKK1AjDFvLkZoOwVPRfcFY0oWRZzVXjBIaPLYWMQXgL4g9pSTfRFNt1of6zEG99ph2x3dGBv+wLvsJPN40TD92YY+wIoMOIFT3ktLrjz1sbBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716150319; c=relaxed/simple;
	bh=NMSliNwL74ZlpY90nUOK1LqZL9y8XAKewfV1TUKPfDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJAVF37FPYRuOWFNgFnlX9wIpn3K67h9RilmXGxSQ9h8y+ACF89k0RBoV8FliLZVs4uD0QE5mGU+i56BnFSru/ydpMflC08ybp0psqtwpn2FC4imU0DSF38hlRQ+nULF7p0jtVcidJI47gsu8YorjehQ0OA+fJw1cz244d5I+vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=LysfzxI2; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=B5XkHAiQB3yfnTfasAfxLoB/R1xOMlGypN3yS7/YJUI=; b=LysfzxI2037oCBpeST743oLRKn
	/b2rMxT2vNS9Z5JinVpzCSsCQIpnOZa23QzRJmnte13Ka1TUnV6QL2KVoL7PLlKfWjR5QHrAQy36l
	8ccCu/fGh0FHel3GS44piDegWQvflMsc7MTKhioScuA/Z0lcfpS/l3S4MnJ1LQHHuKBFfAbayr+Ji
	a10AHB+Nl9VQ+NzcQuMFOL18d3tHqcdYknt1QCH+IvK/Cdmcvl8M9xNPNW7I0YDQt97PsX0r3wmnK
	MxgpxfH7c78arLMAkft011kIVH8qVRL6iaygKsn2s0GyngZcUQuqUJhmkSlmmJlygSJtEXDq/jxi0
	jLncO7+g==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1s8n5k-008wIn-0t;
	Sun, 19 May 2024 15:25:12 -0500
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
Subject: [PATCH v5 28/28] ntsync: No longer depend on BROKEN.
Date: Sun, 19 May 2024 15:24:54 -0500
Message-ID: <20240519202454.1192826-29-zfigura@codeweavers.com>
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

f5b335dc025cfee90957efa90dc72fada0d5abb4 ("misc: ntsync: mark driver as "broken"
to prevent from building") was committed to avoid the driver being used while
only part of its functionality was released. Since the rest of the functionality
has now been committed, revert this.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index faf983680040..2907b5c23368 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -507,7 +507,6 @@ config OPEN_DICE
 
 config NTSYNC
 	tristate "NT synchronization primitive emulation"
-	depends on BROKEN
 	help
 	  This module provides kernel support for emulation of Windows NT
 	  synchronization primitives. It is not a hardware driver.
-- 
2.43.0


