Return-Path: <linux-kselftest+bounces-34408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D10ACF93E
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 23:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9AC173F60
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 21:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DE627F73A;
	Thu,  5 Jun 2025 21:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlKPATe/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F119E20330;
	Thu,  5 Jun 2025 21:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749159613; cv=none; b=U5tWDjEt26/3fT4IVUGeI/8MqSaazwBLjBpX/Y4YZTj08mgSqBbee0HpHH4xM5S+8y2IJS50FTcto1xU/LBrqs2Bq6wcowLXz/6r77zWuy+52xOhlIQzbuvEwyANZV0QaAFY2tz/AxT1paSYk+0IofRjwiccA6ws4fwHzqZKhfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749159613; c=relaxed/simple;
	bh=jF4uQG4JzF72d7snTV6xQmqLe92fvsopln0oHorfTsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YfQZ0oXh0vFFgiY/jVByGQlBrJaHAWlkHNVAb7S8DQG/nDOoipIzJwTkaBCBjNOrVGhgSWNIxM1h+lc6puZOkvRPnIN+V/8mBNJvOor+Gf0vpgkVfki4S7szC3YdB1FsRMOogwfITGEu/2+PttoUCCPhVPjeySjdGWphUVrw/1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlKPATe/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B46CC4CEEB;
	Thu,  5 Jun 2025 21:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749159612;
	bh=jF4uQG4JzF72d7snTV6xQmqLe92fvsopln0oHorfTsM=;
	h=From:Date:Subject:To:Cc:From;
	b=GlKPATe/Avsm6ZuNOpe704ziDRKivTFQ7MOe6uZNlB9t5qMm4cqmXH6Rq4RRm0K0x
	 r8Iflr3yiR1/Oi0EntShR5LLAD4hoyLjugTn2+0RFwR/GfE3zdFbYI0NUZF8QRnPVN
	 GpaRipwiY/8HVIFMgMZHpE3MlPJyUSarM/Rp1fDwhAWgqqRwYXkE7I7yYpsKl4gcJW
	 5BvSqaIHmGWbw13oHaIn/153L5/p+17TEcfRzXaxckIwH+efuSKbpkkGRBbaMXFs65
	 xtGI/0sMcLRMhykdLzBRfXGj0XWB6ElV+5pYkGN/xXDBw1IVhz+PUbCd3frBU0tez/
	 VXDSGwzHHS7UQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 05 Jun 2025 22:34:31 +0100
Subject: [PATCH] selftests/mm: Skip failed memfd setups in gup_longterm
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-selftest-mm-gup-longterm-tweaks-v1-1-2fae34b05958@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGYNQmgC/x3NQQ6CMBBG4auQWTtJwRTQqxgWjf7UCbSQTkETw
 t1tXH6b9w5SJIHSvTooYReVJRbUl4qebxc9WF7F1JjGmtZcWTGPGZo5BPbbyvMSfUYKnD9wkzL
 a3rre4dbZmkplTRjl+z88hvP8AZBYcXJxAAAA
X-Change-ID: 20250603-selftest-mm-gup-longterm-tweaks-e685a8ae9751
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1375; i=broonie@kernel.org;
 h=from:subject:message-id; bh=jF4uQG4JzF72d7snTV6xQmqLe92fvsopln0oHorfTsM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoQg66dsI93JV7jaEUVWpgeecRKK89umoSWS2U+wte
 WjYo/yuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaEIOugAKCRAk1otyXVSH0PtTB/
 9/UeYw9A7wm3FKaXvq2MEwdVcJo4LgFSyAItBCoqVAe00bppjaqaxjMIGfBh0rzwY5pSqr/7gk7D7w
 /T78BTJ8ChN1LUXm++WUw72gXvhxCAxtTY2LyaQvAjAN0wOSWf61ziQmAy6zDdSNqVGEzO3IBtnmlc
 pnH/CoibYybieEhalHrnxOJtti7shLtoYtNRKoW8gQQZPHCaSk+phYC2PkVzj8aifFvj3J+l5V6wxA
 EDkDZ6HYWlXTZ4Twqw2knAXmTPo/n79shLjahyarK6LchvzMRGGSKLH/BCETV0NX09Zre275yqLEL4
 vALD93orwfK0aSVdE37UE0zhGGMufx
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Unlike the other cases gup_longterm's memfd tests previously skipped the
test when failing to set up the file descriptor to test, restore this
behaviour.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/mm/gup_longterm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
index 8a97ac5176a4..29047d2e0c49 100644
--- a/tools/testing/selftests/mm/gup_longterm.c
+++ b/tools/testing/selftests/mm/gup_longterm.c
@@ -298,8 +298,11 @@ static void run_with_memfd(test_fn fn, const char *desc)
 	log_test_start("%s ... with memfd", desc);
 
 	fd = memfd_create("test", 0);
-	if (fd < 0)
+	if (fd < 0) {
 		ksft_print_msg("memfd_create() failed (%s)\n", strerror(errno));
+		log_test_result(KSFT_SKIP);
+		return;
+	}
 
 	fn(fd, pagesize);
 	close(fd);
@@ -366,6 +369,8 @@ static void run_with_memfd_hugetlb(test_fn fn, const char *desc,
 	fd = memfd_create("test", flags);
 	if (fd < 0) {
 		ksft_print_msg("memfd_create() failed (%s)\n", strerror(errno));
+		log_test_result(KSFT_SKIP);
+		return;
 	}
 
 	fn(fd, hugetlbsize);

---
base-commit: ec7714e4947909190ffb3041a03311a975350fe0
change-id: 20250603-selftest-mm-gup-longterm-tweaks-e685a8ae9751

Best regards,
-- 
Mark Brown <broonie@kernel.org>


