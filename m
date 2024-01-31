Return-Path: <linux-kselftest+bounces-3812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6466843393
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 03:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62AC428A7EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 02:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D478383A4;
	Wed, 31 Jan 2024 02:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="mDg24hho"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABB718AFA;
	Wed, 31 Jan 2024 02:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667370; cv=none; b=nwkflUmP3OBiT66gr+2BopuIOP1P/uvNg+XBAnrXSDxzbJlu4wHtvC8z9bJsbVfOwdtbohUVH2xYkBG2NM32+Wqjo7Y0zZ2Xg7k37LBSPFK48jWHlfWIB98k82MMPHJfFcXVix/LEl/nfWOFMlOrCrj5Usde1PGULGKq2jI99kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667370; c=relaxed/simple;
	bh=7B5CV9F4s4vjyjGFgVZxdU1S+iuE0jPD0kJ+jDAFB9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOjKXHLQApQBvFFp2Qg/Z7Cks0N+Z6EPnGTdgD63a5EW+YEqCQ+YTcHHJKpR75j6ILhSn9cvqSNkb7icZ2jHoF5l5EV8EMYDJeK4kAVq1eBANpNyLIgu+eQrr8rI9Jkrs8aGqj4YvERjIcEnRy2Ag94vAfFTnFeOi7qIx7SugIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=mDg24hho; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=kEY81ThKNufG032Um78kKWhIVAmyunZr7IiiHuV5wWQ=; b=mDg24hhoYo2z2gy9XUIyagUrTr
	vPPfaNvERLV7wmD+M29Y57TvqOTOyWR38WIpGW3YXk+aFQ9hEuoBK7+bzVnz0arEtripOxA/6Jjzh
	BsAd5iP2gMUlDgAYJB/GCCdRQ64Jss7E4Pg+3JGHxXNMCHxynPJnxtS2i7jAkoELWIA/yx0XEqj1n
	hOMBgjXlivXFw9L99q1dVsR1jlL8QcZYe/zka43g5Qpu+eXMKvbSclWbNGhyo0C/G3LANBjM9T//T
	pW3f2Z1GKSvsaiIYKTMd9BB6/UzethYwJ/puySGKKScxv6Vmt8WVNETK7Xyq8OlmXRuHdx52h7CjJ
	+wfC6WtQ==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rV08s-0038Kv-2C;
	Tue, 30 Jan 2024 20:15:58 -0600
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
Subject: [RFC PATCH v2 28/29] maintainers: Add an entry for ntsync.
Date: Tue, 30 Jan 2024 20:13:55 -0600
Message-ID: <20240131021356.10322-29-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131021356.10322-1-zfigura@codeweavers.com>
References: <20240131021356.10322-1-zfigura@codeweavers.com>
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
index 8d1052fa6a69..7924127d351b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15585,6 +15585,15 @@ T:	git https://github.com/Paragon-Software-Group/linux-ntfs3.git
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


