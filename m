Return-Path: <linux-kselftest+bounces-34429-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D4FAD0A01
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Jun 2025 00:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058AC179C0C
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 22:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22806238D2B;
	Fri,  6 Jun 2025 22:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSLoMz3s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4405A233156;
	Fri,  6 Jun 2025 22:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749249621; cv=none; b=agn/xQU1MMIrV8RqErpIAj2E32wIaQLdaA33x5qrwiREfdqR/JJdwz9wM3QdFuXwgBqZeQwY2lWK+VAPM9K1lwrFguj174M3y0+1WU/szYApyO8bUqtDp04FMU/LMLj+4eMhn7e5lVDsPJkYTzO6u1bdUjDv6NbOU/cAvUJ8Emc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749249621; c=relaxed/simple;
	bh=Umf6aZ0L2/WBdq94G/QOnFxf54hsMxax8i4F49KC5fU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GRHqZDPc358fwKtobDtg1ebeeypTiEYI7wh2VizCduzshgdwLIHT9X/0z4QxgBcjS1KvjJRNLQpIV/OcwF8v9+o9SmDGXAKIxz1EkA+SerLvK9RgqP0bt8N9daa/Bdcumeo9/2YSUj5bquDoim9BTJBcyPw47p7UMwo5bsgRTd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSLoMz3s; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a4f7865b22so435733f8f.0;
        Fri, 06 Jun 2025 15:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749249617; x=1749854417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXshBSIZNU4BeC4KDEJtIathlHJ2M2oUxcH/B0uC15o=;
        b=bSLoMz3sBsiEN8RN+5/iN+PKp+Cg1uBqrWC6vK7VXmwELWJ3BSZBOcMUaWzRuFbn9L
         P5UCQxDgLVqJ5RHtSnmR4mfWXPj8KBYaXoFvhr2yvFKKilDNLVBF+K5qW9uUnx/pWI5x
         NIvcT2UxM0Jy0FEygiEfqsGRT5rShekwY8I1omz5+eTQkRdHuzI6seTVdT0HIA/v/e2G
         zbuG0YkOVE3KPKtgP5csl3KnUbUxlITSjgHehxnhnek+FXVPD9reSPyhx2EzAOI1B0XF
         b+S85V9JYERy26crgZyymcTFHmFQb83aD379r+em84r0x24zHy/C9LPnGttWgIzK+Xe2
         wqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749249617; x=1749854417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXshBSIZNU4BeC4KDEJtIathlHJ2M2oUxcH/B0uC15o=;
        b=fkICQKXJcLh3tB0z7BafiV/Beh90DUfviR+EeDbt47Kag6k+N2He3T+F4tsGccWjnB
         +jQk+VBbtpktxDqNDrIfD/HnpaMe1eq+zuynPj9dd7gKsNnwQjrdCeUdLorIZxLRUX8A
         Byx7RCBox5tCH0jRWx4A4Q6PW4aUlRLOvStUIhi6RmOKNCuNU3LDfJp8XQdgbCzzchDV
         67bXRS2LN7WV+VsRRTtfRdOMxcSeEavxMk9seRBbPq15QNUinee30glSnt9E4agU3oMi
         j7XdtkF+WqWqu23dozRZjMEsj74EFBE77Z6Iwhka+EdX+FcR/9M+kvffsZG2172VH8LC
         M4cA==
X-Forwarded-Encrypted: i=1; AJvYcCUAX3bSRhyRzucYYCVWBGu2JLAio9xrRYW60vUqmwg7CeOkOplPtCDeHJZHSDa2tU+si6ZsGthIWZDzXNx33saa@vger.kernel.org, AJvYcCUNdBUvT85OHCbH/zSZ9umhhbHAg+BXXegjfXLAZI/vkrC49DVKxj8z3BD8wP1zsa4gnsuw105ZfCJ5B9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8o4dgbYV5wsosLcALGg/SlwccZRDYKYuBX/bTMKcGShcrg8Jk
	KY8MsIV8TIidmZ98ngF140cSchWnCDEHXeqymnDGIpvG93CQVXWCMT3L
X-Gm-Gg: ASbGncuLSKmQoXsb7upFKTZi40u9KnO466jOFjRP6xtGpUfKQvFfG7/FA9CB1ul9Bio
	tqW4uFmxGWYE5uVV1bLjnGUWg0HODd6raZTOETP+Etk9irx855Jzc47gr6srR18aR54M+aU/DFL
	Tj9yfbOfAuwx/NubfFdTn2eS7HDXXijjQFEfvwEYq2PllYSn7LUpKpjKOtlJa+rm02jsEWwA2DW
	p2f9s+WrPdALnYNuaWG2jk4JvwuhCMn35SVdUcxX0NoA11hy/N4UQ6xgXSq2NWOrTjB9G5OKQ5J
	EDu8YH3d5wSLvHVyMaguVckTewqzRYerzEY/YrJQbp/rqMWpYN48RCm7jAf/pbIsEmhDYxLp2V+
	2g96TWrRmvso=
X-Google-Smtp-Source: AGHT+IG2IOCjOeOs8sYspOVGNo6JXAP4dCv2MZ+rJKi1VOqe3yrtvfxYWbt/lxPo4/W3/HuTbHFpPw==
X-Received: by 2002:a05:6000:2281:b0:3a4:f7ae:77cd with SMTP id ffacd0b85a97d-3a53313110emr1363448f8f.1.1749249617020;
        Fri, 06 Jun 2025 15:40:17 -0700 (PDT)
Received: from localhost.localdomain ([41.34.150.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5323bee86sm2968132f8f.43.2025.06.06.15.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 15:40:16 -0700 (PDT)
From: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
To: skhan@linuxfoundation.org,
	shuah@kernel.org
Cc: linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Subject: [PATCH v2] selftests: ir_decoder: Convert header comment to proper multi-line block
Date: Sat,  7 Jun 2025 01:39:14 +0300
Message-Id: <20250606223914.117449-1-abdelrahmanfekry375@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <65743e71-fc2c-4a04-b7f1-b977031a4fb8@linuxfoundation.org>
References: <65743e71-fc2c-4a04-b7f1-b977031a4fb8@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So, this is an updated version following
the right way of writing change logs while
making sure the signed-off-by mismatch is fixed.

The test file for the IR decoder used single-line comments
at the top to document its purpose and licensing,
which is inconsistent with the style used throughout the
Linux kernel.

In this patch i converted the file header to
a proper multi-line comment block
(/*) that aligns with standard kernel practices.
This improves readability, consistency across selftests,
and ensures the license and documentation are
clearly visible in a familiar format.

No functional changes have been made.

Signed-off-by: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
---
Changes in v2:
- Fixed multiple trailing whitespace errors
- Fixed Signed-off-by mismatch
- Appropriate change log
 tools/testing/selftests/ir/ir_loopback.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/ir/ir_loopback.c b/tools/testing/selftests/ir/ir_loopback.c
index f4a15cbdd5ea..c94faa975630 100644
--- a/tools/testing/selftests/ir/ir_loopback.c
+++ b/tools/testing/selftests/ir/ir_loopback.c
@@ -1,14 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0
-// test ir decoder
-//
-// Copyright (C) 2018 Sean Young <sean@mess.org>
-
-// When sending LIRC_MODE_SCANCODE, the IR will be encoded. rc-loopback
-// will send this IR to the receiver side, where we try to read the decoded
-// IR. Decoding happens in a separate kernel thread, so we will need to
-// wait until that is scheduled, hence we use poll to check for read
-// readiness.
-
+/* Copyright (C) 2018 Sean Young <sean@mess.org>
+ *
+ * Selftest for IR decoder
+ *
+ *
+ * When sending LIRC_MODE_SCANCODE, the IR will be encoded.
+ * rc-loopback will send this IR to the receiver side,
+ * where we try to read the decoded IR.
+ * Decoding happens in a separate kernel thread,
+ * so we will need to wait until that is scheduled,
+ * hence we use poll to check for read
+ * readiness.
+ */
 #include <linux/lirc.h>
 #include <errno.h>
 #include <stdio.h>
-- 
2.25.1


