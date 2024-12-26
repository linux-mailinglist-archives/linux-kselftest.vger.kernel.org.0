Return-Path: <linux-kselftest+bounces-23754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD059FCC8F
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2024 19:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0805A16184F
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2024 18:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F4613DBB6;
	Thu, 26 Dec 2024 18:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b="sy0h9CTj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729E9136351
	for <linux-kselftest@vger.kernel.org>; Thu, 26 Dec 2024 18:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.55.113.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735236739; cv=none; b=oxT1CU+efxHkI6TEaOo7oyK9hVEbOfv9QpTiN3rdGALqdMZlrI9U57d5basel8lcf5F5+zTj2VMSUY9/tIa6JMyJYTojDrI+LgyPhcUa4Edew6j7m3MG7LbZmnnJs+Y13ecNrP08E5ZR/3MwRyo+lGlbBqZ2VCk7i0/unQpKW/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735236739; c=relaxed/simple;
	bh=uhMfqDUhtkR+GQP452MsKCCd8W8gks/GmHEk4DiWRYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ky4VhhLNFgsbh2673WxwlDNluO7YSl4zXXw7RN5+ceYorGnjPiEBli0M9shOnvx1z5aiIZl7rUmQGjilKl1Vt9IUjp3tfp4RAvWr0aBLvQo2j3KoekENJswxo3iwUe6vIY2GtMUtt/AjMJ4OoiEFwaDkG2oUy6FJOJT+BNCWaPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=eurecom.fr; dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b=sy0h9CTj; arc=none smtp.client-ip=193.55.113.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eurecom.fr
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
  t=1735236735; x=1766772735;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uhMfqDUhtkR+GQP452MsKCCd8W8gks/GmHEk4DiWRYY=;
  b=sy0h9CTjfod+dpU8F/bTNaV5TvkSkRRkFenREM4rAGJw2ctj004OcW8r
   6c4kV6Z0sS8P+kWp17s3Vu9FIPHVQyewzG7X0gQ9TGC0rr0deN2ryO4/k
   uMS0vFUFxV7zhxfKaER2YgVjWj8yLphQMlCJvASuf9G26rT/RAxuU5jgh
   0=;
X-CSE-ConnectionGUID: JD5S3PjXTfOTUTDfJTyZvw==
X-CSE-MsgGUID: Yy361EnIQw2HBvR8nINvUw==
X-IronPort-AV: E=Sophos;i="6.12,267,1728943200"; 
   d="scan'208";a="28325974"
Received: from waha.eurecom.fr (HELO smtps.eurecom.fr) ([10.3.2.236])
  by drago1i.eurecom.fr with ESMTP; 26 Dec 2024 19:12:07 +0100
Received: from ntu.. (88-183-119-157.subs.proxad.net [88.183.119.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtps.eurecom.fr (Postfix) with ESMTPSA id 1B8D62DB2;
	Thu, 26 Dec 2024 19:12:07 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
To: linux-kselftest@vger.kernel.org
Cc: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/1] selftests: Clear -Wimplicit-function-declaration warnings
Date: Thu, 26 Dec 2024 19:09:32 +0100
Message-ID: <20241226181203.527121-1-ariel.otilibili-anieli@eurecom.fr>
X-Mailer: git-send-email 2.43.0
Cs: Shuah Khan <shuah@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

This patch clears out warnings seen while compiling the tests; at the time, it closes a test report.

Thank you,

Link: https://lore.kernel.org/oe-kbuild-all/202412222015.lMBH62zB-lkp@intel.com/

Ariel Otilibili (1):
  selftests: Clear -Wimplicit-function-declaration warnings

 tools/testing/selftests/pid_namespace/pid_max.c   | 1 +
 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c | 1 +
 2 files changed, 2 insertions(+)

-- 
2.43.0


