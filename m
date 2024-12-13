Return-Path: <linux-kselftest+bounces-23366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFB49F168C
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 20:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B0A286ADC
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 19:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966F51F9425;
	Fri, 13 Dec 2024 19:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="KQfc0hwH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3329D1F941B;
	Fri, 13 Dec 2024 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118581; cv=none; b=sccyDyZOXhhEHE3XR9hy7OCSAXMxbpktzGyXcAK2gGdo5Ero2r3Y/Kl/pZCRX/x7pj5lj6TR9jpHBlqnQb8gDXBvNI/n1B2yNGI3Ogl70WqgHvOI9Plf9kfsSi441LyXHgdTUEBMhgjCts3v/mY4Ec8mIwXMAsmOmAuWlIFxBw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118581; c=relaxed/simple;
	bh=U2jvLVxDBW1wqTl+8HqpuZ+B2aEhALkVpMFRfXjOGKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdmH+qVOIq5GV+Erie3Y4dmNsZSj1kWVATtAgu9MOzxtvs23V+wAZ3fbbprSKAHHYt/fKYng1s7ao9RlOL00oFZOt1K0ppSxZSmanxgKi+pVX2NlGxgP4Nhg0iruqWrOXBEI8gK+cHbfG6U7DVCr+ELhg0qCXAtFDrCWwJNk2xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=KQfc0hwH; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=H78XD7mVtyigbR9tP1mufDrwr59LEZXCMX3E9nnMZnc=; b=KQfc0hwHr12D7BqQNvjPQ9PAHz
	OpCN/ST3o2WE5w1fzloAiS2FW/sOHv0p23pFztOpzrTr5K0dwCNsacDNCnge5Jb8306pIWq4snMSf
	iCGBkRk6K3fSxB1o2GWRqVqSYhHoqyppoLbOEuo+tRzGnhQoG/cZPLeg22aKXRu21Zv8P6BuehhUk
	wRii0IC6KTXiDZMQBZtJHtI3mh+Oa7TAxcvLmNY/285fJw0DGmxYUHvrT2ubcG+j0jlWmWkNVSRgN
	mZ+M8C6zBm81RJuOFM6csqMKXso35yuEO+kMs62SjdY3Rte9rqcpNX8kFiHMT7D+igCn++VpRISIR
	sJE2UzjA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tMBSO-00ASsZ-1T;
	Fri, 13 Dec 2024 13:36:12 -0600
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
Subject: [PATCH v7 30/30] ntsync: No longer depend on BROKEN.
Date: Fri, 13 Dec 2024 13:35:11 -0600
Message-ID: <20241213193511.457338-31-zfigura@codeweavers.com>
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

f5b335dc025cfee90957efa90dc72fada0d5abb4 ("misc: ntsync: mark driver as "broken"
to prevent from building") was committed to avoid the driver being used while
only part of its functionality was released. Since the rest of the functionality
has now been committed, revert this.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 09cbe3f0ab1e..fb772bfe27c3 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -517,7 +517,6 @@ config OPEN_DICE
 
 config NTSYNC
 	tristate "NT synchronization primitive emulation"
-	depends on BROKEN
 	help
 	  This module provides kernel support for emulation of Windows NT
 	  synchronization primitives. It is not a hardware driver.
-- 
2.45.2


