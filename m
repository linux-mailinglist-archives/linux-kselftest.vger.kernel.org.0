Return-Path: <linux-kselftest+bounces-14369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 677A293F0CB
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 11:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 046D4B209AB
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 09:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB95113CFB8;
	Mon, 29 Jul 2024 09:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgiGG/n6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3643F12DD88;
	Mon, 29 Jul 2024 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722244659; cv=none; b=jSti2pJMR/rHeC3kabPX1UGNmagBsqxw3BNlsBse4i0IFASdMTC1PnFaipWi5pQn0rz4Nr6tU9hvP0KDy9H8nDNflHTWrnFTJE1xtu6gBZDQsds+d45WTScPwdVxrELDt/BO7t5PWgurjnlxep3vwUFQESbzCh/0SCNZxrikqMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722244659; c=relaxed/simple;
	bh=m4SWXhvAtez5my1PKqqejWoJipF/iRLRbaiuefksVe8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BU8yzg13tr5I9bst9+TIwRPFmITrW9jCvPMcZHgnnJOCpxvKUCXm4U8HUOcIusZAPDmeoz2TDzPYQxTvVTTC9giEaFXuZBjFwgSB6Rgw8tVwkjRxQiuHTAHSr3SE4SJ2XHbzL/YGBiyYIysX2pH3bcW30w1MAkC7UJlv+AUGZ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgiGG/n6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-428163f7635so12983725e9.2;
        Mon, 29 Jul 2024 02:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722244656; x=1722849456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4J4SYhEOa1gabPOMO05hjVOcl3yukqW8OZI/5xw8IwY=;
        b=GgiGG/n6Ec6h7YgJ1EsqqMjaSVYyePus99N8To1ZqWpfkb9k8vuL2pZ3K5HPLs5e/k
         Z+H0lrYv0MTYJfwUcIZ+w6dAFh/WpnsFNyR88+uDFGguNsm9pEKyDsjwaL1kibTQHF/k
         iDrpBYwVyTwspXmHKi0z9W0JPuzdCECpmqrLtf/3oy4jMvMjRm0k7Xhft7+kiD+qk/BU
         ZZAZMG4iTXHEQZ/jwGIUaopZFaPKRBn6xUO0tZeHTKvwQsJmeOlJCCSG7xsHV29rWnDY
         AsaRJEv909ECCEnVxMF/rllAe3Ete6cBreZsevD7b3UcjmMY66irhdnTeYIDZ01N+aBe
         PNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722244656; x=1722849456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4J4SYhEOa1gabPOMO05hjVOcl3yukqW8OZI/5xw8IwY=;
        b=UrM7Bp9s6zwcU2OQ73ddbJ1zYd1gwbi5x/Rq9R0LiQeGD/J7fiQrLsfUSzU9GCMOfR
         Olq8w1/xzFlOMy2iTYxDtWoR/aFJsOPp3Fr4kwDg+U7Ppxc0goiuwsXvUKRqkuuUnVfL
         EqW90Logu2A+qRT8C3dyFtdP6CU6wcYPu+RaoK1aMbXNy73G1jrADRE8Ddd29vi9VE2k
         Iqwgkm5YneSBWZ7qbgYRYiy88Ii5hoez0X8GNAxBKE7WnFoVt/rUJe4MDkI8Yh5eVC9o
         QDALuX7SIImufO6OQLwzVe+8+cJC1KOrEtW6/QGdC85NTWzmxe/faefeWDRxGP79n8Mv
         xbmg==
X-Forwarded-Encrypted: i=1; AJvYcCW3XthuYTyu8IIMkMs6+aWPICUbhO1olB24sywoK/1kdo1i+ZUI1XCjqZ6ZWUvFgguT+44piNcnOvWPDCM+oPttXS46LiqQ947j2hcFFlEmjUnq3FC4lG9KN8yVXsU/xQpRDJnXzUMzw0zn23Ip
X-Gm-Message-State: AOJu0Yx5qwL028HtK2bu6aIeLWSR+ui+L4ZBOom9sj8CA9+yOL0hSXZt
	hHwUFgZuB8NzSpkm8h6lGsIHme9Ix9hNqONb1iOMVZ+u+p/L/JFjNRxbjA==
X-Google-Smtp-Source: AGHT+IF4VHDW9ojKBR3q4Jivc1+iyrtgdpimZ8JmgOjlc/xzRxT+ve0gc0P2I/uxp+rWVbQ0JWSdXQ==
X-Received: by 2002:a05:600c:4ed4:b0:428:1ce0:4dfd with SMTP id 5b1f17b1804b1-4281ce04fafmr18629985e9.34.1722244656245;
        Mon, 29 Jul 2024 02:17:36 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42805730e5dsm171836905e9.2.2024.07.29.02.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 02:17:35 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] tools: selftests: riscv: Fix spelling mistake "regesters" -> "registers"
Date: Mon, 29 Jul 2024 10:17:34 +0100
Message-Id: <20240729091734.42259-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are a couple of spelling mistakes in ksft_test_result_fail messages.
Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/riscv/vector/v_initval_nolibc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/riscv/vector/v_initval_nolibc.c b/tools/testing/selftests/riscv/vector/v_initval_nolibc.c
index 1dd94197da30..6838c561e4c9 100644
--- a/tools/testing/selftests/riscv/vector/v_initval_nolibc.c
+++ b/tools/testing/selftests/riscv/vector/v_initval_nolibc.c
@@ -49,14 +49,14 @@ int main(void)
 	ksft_print_msg("vl = %lu\n", vl);
 
 	if (datap[0] != 0x00 && datap[0] != 0xff) {
-		ksft_test_result_fail("v-regesters are not properly initialized\n");
+		ksft_test_result_fail("v-registers are not properly initialized\n");
 		dump(datap, vl * 4);
 		exit(-1);
 	}
 
 	for (i = 1; i < vl * 4; i++) {
 		if (datap[i] != datap[0]) {
-			ksft_test_result_fail("detect stale values on v-regesters\n");
+			ksft_test_result_fail("detect stale values on v-registers\n");
 			dump(datap, vl * 4);
 			exit(-2);
 		}
-- 
2.39.2


