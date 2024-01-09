Return-Path: <linux-kselftest+bounces-2770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA6A828F53
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 22:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A8A31F2633A
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 21:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6108C3DB9B;
	Tue,  9 Jan 2024 21:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="A0iySkjP";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="uk3qDy3M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC973DB84;
	Tue,  9 Jan 2024 21:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 6403060177;
	Tue,  9 Jan 2024 22:55:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704837314; bh=le8QSZjVL3Ipmww56+RTzFLJ8CHP/G7VfB4Ysq97AvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A0iySkjPKFxAkx51V/9kvsh7jjUudnQ7yu8dADsNKKsUz/7Srh2v5yV0RNRVCl+Ut
	 KNXHlXrH/2uXfLc0VObiBCO6BqwWrmhDns+lGYft9fVKup4xnYodEfeKeZC80uMNwr
	 bJ1/rAIhb4RdIRl7QsBMVTERfXTaY9vWqSv3sCNukoT4baUFtjVhI9eHK06EMSa3Q9
	 hN7H61UjgfjMwYRVCVTBBvEXsZpKsoRgrupXD3x+xa67D/qBbvIHGk02OyxlhdeUTQ
	 53hW2zDPaBt1ijlv41JVvrOBN4PhQI5QNZQ5XqZ9u3nuRzVmo/u/qSHui/7k0nz/T3
	 StzhcrqpwTcnQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0o-DVXMEr7rM; Tue,  9 Jan 2024 22:55:12 +0100 (CET)
Received: from defiant.. (unknown [95.168.105.29])
	by domac.alu.hr (Postfix) with ESMTPSA id 83B9960171;
	Tue,  9 Jan 2024 22:55:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704837312; bh=le8QSZjVL3Ipmww56+RTzFLJ8CHP/G7VfB4Ysq97AvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uk3qDy3Mul/GE+9ot0q9Qlxi6ZVfZvULptzxHsqIuGJx5DOCsTPa7QhMg9rwsZaT9
	 soHQpsSEUaNMdy471V4wvMkvEBcCCsnAfqb9e8fUcdZPN5JHi61PhsthjHi9/r1+oc
	 1sHm3ydujrxulKgpW+3QN2aOqhKVY+Dhup4zddI06ssARQD+hZQ7oGDlQ8lJmRAVEl
	 sodzvsdTNOvT27ac0mFw0KCr7K5Mgi3ucOH+r4m56NvCMcAEKRVp3p/gIlp5Xu83gW
	 MSu7ZA5eoGEgJeOgNN3Q9J/IOtbFHKhxY8w2R+soU0L0WLZFkilz4OAVHDwzhmnAa4
	 3AOJHaTW/aDrQ==
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	Paul Elder <paul.elder@pitt.edu>,
	Alice Ferrazzi <alice.ferrazzi@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 2/2] selftest: breakpoints: clear the format string warning and secure the output
Date: Tue,  9 Jan 2024 22:54:08 +0100
Message-Id: <20240109215406.18218-3-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240109215406.18218-1-mirsad.todorovac@alu.unizg.hr>
References: <20240109215406.18218-1-mirsad.todorovac@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

GCC 13.2.0 compiler reported the following warning:

breakpoint_test.c: In function ‘check_success’:
breakpoint_test.c:287:17: warning: format not a string literal and no format arguments [-Wformat-security]
  287 |                 ksft_test_result_pass(msg);
      |                 ^~~~~~~~~~~~~~~~~~~~~
breakpoint_test.c:289:17: warning: format not a string literal and no format arguments [-Wformat-security]
  289 |                 ksft_test_result_fail(msg);
      |                 ^~~~~~~~~~~~~~~~~~~~~

ksft_*() functions are unprotected against potential spurious format specifiers
in msg.

Protecting the conversion with "%s\n" format string fixes the warning.

Fixes: 748e84b79af01 ("kselftest: breakpoints: convert breakpoint_test to TAP13 output")
Cc: Paul Elder <paul.elder@pitt.edu>
Cc: Alice Ferrazzi <alice.ferrazzi@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 tools/testing/selftests/breakpoints/breakpoint_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/breakpoints/breakpoint_test.c b/tools/testing/selftests/breakpoints/breakpoint_test.c
index 3266cc9293fe..07249251859b 100644
--- a/tools/testing/selftests/breakpoints/breakpoint_test.c
+++ b/tools/testing/selftests/breakpoints/breakpoint_test.c
@@ -284,9 +284,9 @@ static void check_success(const char *msg)
 	nr_tests++;
 
 	if (ret)
-		ksft_test_result_pass(msg);
+		ksft_test_result_pass("%s\n", msg);
 	else
-		ksft_test_result_fail(msg);
+		ksft_test_result_fail("%s\n", msg);
 }
 
 static void launch_instruction_breakpoints(char *buf, int local, int global)
-- 
2.40.1


