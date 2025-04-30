Return-Path: <linux-kselftest+bounces-32031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C202AA4F2D
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 16:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5033B3713
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 14:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667A819EEBF;
	Wed, 30 Apr 2025 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CmIoUxUh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B19B199FA2;
	Wed, 30 Apr 2025 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746024964; cv=none; b=ttMBORF0crkP3bv5qQkIcppBYirO6w75dCQIJqsXMKDrj924S2sJisedaYNCEf+73zk2J+kfVyrs65SVOqSx5d4IPkcymszM4/4uMy3gj2r3cJBPxg3o39aEpC143cszE4KrNCg8v+oVTyoeqgULZkyh8zlYV8LR5H6flBQixdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746024964; c=relaxed/simple;
	bh=g91vEHY2gNNgWu359DyV0tUsX5BBjcdqbFaJa90Gwjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=e4LeTsl0OtJ/OSofBh+e7DGueWdeEaVSJd89+qE3sU8QgKMezjkzuCcWQAFzZnQwTEV+YV451h39sGok7aur/vCcwWt2sYp4cflFdUxLYCWcw6y2NWccrtQT5HDPEElWC5up2+5oWbRsD+E285Cl7QoCTDkGaJdMUFdhwsJe6qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CmIoUxUh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1746024960;
	bh=g91vEHY2gNNgWu359DyV0tUsX5BBjcdqbFaJa90Gwjk=;
	h=From:Date:Subject:To:Cc:From;
	b=CmIoUxUhp4tVJW9jnF9TZjbsFFycTTKz/5C+1QuYSPpxRE5yGrNR7an8GU8ZoTmh6
	 D+BMqYGkPnESKAUbYB+NZCgSkK3T5UsUHaZRmryR7StOZHJPdQpyxeSjG3dD9DtluE
	 cTBV8ZrBsieHd3AP6bt1hFARuwrJU3CbHwEo+r3cZTe2B7Max9jntPjkt4+2ItHcG3
	 SDDffJ6NXyLWacGDuHAPhKxW6Csuonxmh8P2yM9WzOWi0lyAVkeomm0gP9vnZtTyod
	 IH6zqQhDX5dCuqC1X8y4aVQbLve0wxOjHKrPVmDTfX9S8SNPcmhoL+37m+d1I/mF8L
	 OGSw609bLIPUA==
Received: from [192.168.1.63] (unknown [70.107.117.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8137A17E02BE;
	Wed, 30 Apr 2025 16:55:58 +0200 (CEST)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Wed, 30 Apr 2025 10:55:49 -0400
Subject: [PATCH] kselftest: cpufreq: Get rid of double suspend in rtcwake
 case
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250430-ksft-cpufreq-suspend-rtc-double-fix-v1-1-dc17a729c5a7@collabora.com>
X-B4-Tracking: v=1; b=H4sIAPQ5EmgC/x2NQQ6CMBAAv0L27CalWIx+xXDAdgsbTam7lJgQ/
 m7DceYws4OSMCk8mh2ENlZeUoX20oCfxzQRcqgM1lhnrvaOb40r+lyi0Be1aKYUUFaPYSmvD2H
 kH96cd72hduxMhFrKQlWfl+dwHH+inCwudQAAAA==
X-Change-ID: 20250429-ksft-cpufreq-suspend-rtc-double-fix-75c560e1a30f
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Shuah Khan <shuah@kernel.org>, 
 Shreeya Patel <shreeya.patel@collabora.com>
Cc: kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>, 
 linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

Commit 0b631ed3ce92 ("kselftest: cpufreq: Add RTC wakeup alarm") added
support for automatic wakeup in the suspend routine of the cpufreq
kselftest by using rtcwake, however it left the manual power state
change in the common path. The end result is that when running the
cpufreq kselftest with '-t suspend_rtc' or '-t hibernate_rtc', the
system will go to sleep and be woken up by the RTC, but then immediately
go to sleep again with no wakeup programmed, so it will sleep forever in
an automated testing setup.

Fix this by moving the manual power state change so that it only happens
when not using rtcwake.

Fixes: 0b631ed3ce92 ("kselftest: cpufreq: Add RTC wakeup alarm")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 tools/testing/selftests/cpufreq/cpufreq.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cpufreq/cpufreq.sh b/tools/testing/selftests/cpufreq/cpufreq.sh
index e350c521b4675080943d2c74dc31533979410316..3aad9db921b5339585da5711a08775ebd965aaf3 100755
--- a/tools/testing/selftests/cpufreq/cpufreq.sh
+++ b/tools/testing/selftests/cpufreq/cpufreq.sh
@@ -244,9 +244,10 @@ do_suspend()
 					printf "Failed to suspend using RTC wake alarm\n"
 					return 1
 				fi
+			else
+				echo $filename > $SYSFS/power/state
 			fi
 
-			echo $filename > $SYSFS/power/state
 			printf "Came out of $1\n"
 
 			printf "Do basic tests after finishing $1 to verify cpufreq state\n\n"

---
base-commit: 8a2d53ce3c5f82683ad3df9a9a55822816fe64e7
change-id: 20250429-ksft-cpufreq-suspend-rtc-double-fix-75c560e1a30f

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


