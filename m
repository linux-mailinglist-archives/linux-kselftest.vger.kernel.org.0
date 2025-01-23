Return-Path: <linux-kselftest+bounces-25039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79A6A1AAF2
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 21:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885843AD2F4
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 20:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9897A1C5D7D;
	Thu, 23 Jan 2025 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="lV1PeQYg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFE91ADC85;
	Thu, 23 Jan 2025 20:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663093; cv=none; b=gjzqqpqhX2c05YzzlFJYee8xOQ5mRhYgWqGf0VJVw0WGWOu00PvujEkKF71gv422vCQmvR4WY+DC+SGV20lqCgsPXRZrNbc+mI0YNCrA1a0ehgyaObIBegI6tv+M3/UhTlYExQpjDH0J1EOF+l5HO44vonoVGUKmRRPT0mO8mTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663093; c=relaxed/simple;
	bh=spnsUo7shJpfgJZ7NTyaOqYn6sFVn0aKxfiAKaNimHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uXS7dIWKf+uJLfS8I2iLupFElbvAfyWXCHv1l87cKclVg3OuEwcKK1oaN6zStCsG41dfQ6ShcaoLE9hkPc+KOFW2X0GmkPuT1KjjQNr1bGr+BhR5c+Af539fW3ooVl/qIYbuEkAJ1RlRtFbyTJOnBtvEu3qW3tmb0XNh7uf8+EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=lV1PeQYg; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737663088;
	bh=spnsUo7shJpfgJZ7NTyaOqYn6sFVn0aKxfiAKaNimHY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lV1PeQYgnjec8omHBBQZFquKXLY616XCV20/JLlTwa+9BoF79JLDQSFwKIuhbIZJn
	 +5NO7jNhTJrVJ9u1MDkuJv8wdDJ8dqDZVVGorrOXZC2oWsvpIq+rGRvq5O9grD1uTE
	 p2oxU7bfhqH+2//MoC4mE8myDhIMljXUu9B42FNs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 23 Jan 2025 21:10:43 +0100
Subject: [PATCH 2/3] selftests/nolibc: ignore -Wmissing-prototypes
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250123-nolibc-prototype-v1-2-e1afc5c1999a@weissschuh.net>
References: <20250123-nolibc-prototype-v1-0-e1afc5c1999a@weissschuh.net>
In-Reply-To: <20250123-nolibc-prototype-v1-0-e1afc5c1999a@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737663088; l=1256;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=spnsUo7shJpfgJZ7NTyaOqYn6sFVn0aKxfiAKaNimHY=;
 b=m7EmfQMJA0dxL338zOoCpCg0MlGmKLF98alMNzqsXp542ikV4HdW9mekHmEL4xESIkMNne3kQ
 kee4QPVKwRYCCgRNzXWBEdKv5SdZzt2j2PAgz5xlPEgvfTwWLZC0/s2
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

To make sure nolibc itself is compatible with -Wmissing-prototypes the
compiler flag should be enabled when building nolibc-test.
However some of its functions are non-static to ease debugging [0],
triggering the compiler warning.

Disable the warning inside nolibc-test while still enabling it for
nolibc itself.

[0] https://lore.kernel.org/lkml/ZMjM0UPRAqoC+goY@1wt.eu/

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

---
It's a bit iffy, but I only see three possibilities:
1) Make the functions static
2) Use #pragma
3) Add dummy prototypes

1) was NACK-ed before, so I used 2)
---
 tools/testing/selftests/nolibc/nolibc-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 0e0e3b48a8c3a6802c6989954b6f3a7c7258db43..f162793b162f9b1ec687098b9094a6d247a53e99 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -43,6 +43,8 @@
 #endif
 #endif
 
+#pragma GCC diagnostic ignored "-Wmissing-prototypes"
+
 #include "nolibc-test-linkage.h"
 
 /* for the type of int_fast16_t and int_fast32_t, musl differs from glibc and nolibc */

-- 
2.48.1


