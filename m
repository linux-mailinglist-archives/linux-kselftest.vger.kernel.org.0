Return-Path: <linux-kselftest+bounces-41447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1D0B56A3A
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Sep 2025 17:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88D13B67EE
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Sep 2025 15:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8742DAFCA;
	Sun, 14 Sep 2025 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="Zrd6Wehq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDC92586CE
	for <linux-kselftest@vger.kernel.org>; Sun, 14 Sep 2025 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757863749; cv=none; b=apaaNPd9J9VdbA7TbJQ7oejt7oOUJDA/AfebrMMfOo7Jg/W3yvhZFIHm1x/T+AUPAKwXEzuCTPy1doStmbu/yk6ze2BYjKIHBCLZ1OmA2tytr2b1+sgn5zFMTZkybhNNYB6rNd7qmmivVe1h8MaB8S1JhAkkfKG1c+1OEYvMrRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757863749; c=relaxed/simple;
	bh=LPkK3jmQR33RMe+1MmDw4dMC0OqA+N1omWuhB09kNq4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Rl1Uuck3jShfjQEtk9uRGIyZgN+WmKSiCREihs99kWmdY04RjJc2lGxq1nJBB8Je96jF6xdUCHwzSZJiozrVdFRSETnq4i8j4B8BKkEsTCDrQeJjQ9gAmf6pUhWVHplQdzL1v7LevE1tX/wFO6nY1yuShO2OTvNi7HnosdSvFhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=Zrd6Wehq; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 59A31104D01F
	for <linux-kselftest@vger.kernel.org>; Sun, 14 Sep 2025 20:58:52 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 59A31104D01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1757863732; bh=LPkK3jmQR33RMe+1MmDw4dMC0OqA+N1omWuhB09kNq4=;
	h=Date:From:To:Cc:Subject:From;
	b=Zrd6WehqccKCXVVYd3Kf/c/5vP4PTj6N/JoyZ75d1MVzeknjjQ0B9d/P9wTBf7Og9
	 CTYOhilWPjFutOXJnIChqjtv/YGKDnhoFCCiYXUHJPGLC9pFL4LOK7eaDGJdEnDJsI
	 NNCh+WF2WsMcnlMdzKiKKXA8nMYOXU+RZDAYgMm0=
Received: (qmail 23281 invoked by uid 510); 14 Sep 2025 20:58:52 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 5.04255 secs; 14 Sep 2025 20:58:52 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 14 Sep 2025 20:58:47 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id CBFCA3414EA;
	Sun, 14 Sep 2025 20:58:46 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 9DF5C1E8130D;
	Sun, 14 Sep 2025 20:58:45 +0530 (IST)
Date: Sun, 14 Sep 2025 20:58:41 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: shuah@kernel.org, lizhijian@fujitsu.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
Subject: [PATCH] selftests: watchdog: skip ping loop if WDIOF_KEEPALIVEPING
 not supported
Message-ID: <20250914152840.GA3047348@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Check if watchdog device supports WDIOF_KEEPALIVEPING option before
entering keep_alive() ping test loop. Fix watchdog-test silently looping
if ioctl based ping is not supported by the device. Exit from test in
such case instead of stucking in loop executing failing keep_alive()

Fixes: d89d08ffd2c5 ("selftests: watchdog: Fix ioctl SET* error paths to take oneshot exit path")
Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
---

Testing: 

# wdt_test_1 -f /dev/watchdog0 -i
watchdog_info:
 identity:              m41t93 rtc Watchdog
 firmware_version:      0
Support/Status: Set timeout (in seconds)
Support/Status: Watchdog triggers a management or other external alarm not a reboot

# wdt_test_1 -f /dev/watchdog0 -d -t 5 -p 2 -e
Watchdog card disabled.
Watchdog timeout set to 5 seconds.
Watchdog ping rate set to 2 seconds.
Watchdog card enabled.
WDIOC_KEEPALIVE not supported by this device

without this change 
# wdt_test_2 -f /dev/watchdog0 -d -t 5 -p 2 -e
Watchdog card disabled.
Watchdog timeout set to 5 seconds.
Watchdog ping rate set to 2 seconds.
Watchdog card enabled.
Watchdog Ticking Away!
^C
(Where test stuck here forver silently)
---
 tools/testing/selftests/watchdog/watchdog-test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index a1f506ba5578..4f09c5db0c7f 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -332,6 +332,12 @@ int main(int argc, char *argv[])
 	if (oneshot)
 		goto end;
 
+	/* Check if WDIOF_KEEPALIVEPING is supported */
+	if (!(info.options & WDIOF_KEEPALIVEPING)) {
+		printf("WDIOC_KEEPALIVE not supported by this device\n");
+		goto end;
+	}
+
 	printf("Watchdog Ticking Away!\n");
 
 	/*
-- 
2.34.1


