Return-Path: <linux-kselftest+bounces-33062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58876AB80A1
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 10:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8672B1886A70
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 08:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB09289828;
	Thu, 15 May 2025 08:25:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DA82882CB;
	Thu, 15 May 2025 08:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747297549; cv=none; b=fM6XOfCl4GiJOe/lJRSklpGitUljPVPQ9mTzMnw8NQH8ZsLjMYHj9wICKvFTyia9x3hs7toPKQeUisEQ8Xc/BC5j8CLGzBpKpjffJNPl2NBFqzI3wuq7d1t5CQQeaulk8V1KUkP+2JFjiLSF/MkcMT1K7w2U00EjPH78VezCcWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747297549; c=relaxed/simple;
	bh=JxIs9ti23+lhasBtOh4fpkazhknzy+eYTXszTYWShXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gUFtDJPf/lA5vd277WBLMT17lp1yM+nP0kyzK3XQznbJdjc8EHiu3uvwMt/0TA6sBZMU6B6qqdaHImq02s2SHRrlY4ePB4iuf73MdtLKNByoXLk5QCjYdRI1cLSBhzzJRM4FMzC+mqll8J/Xrz5VS+EUdrEmC6Jq5BvVIVEXj2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c5e2fe5f17so64912385a.3;
        Thu, 15 May 2025 01:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747297546; x=1747902346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6mkHlRM8iLp0NsM5Jk7d5tEtIOoI6iyctbL8lUwGW6Y=;
        b=I+8bn3trgknTUrx8HNhee2GtTVhCz2pOHoRxeuiLTrzAy4sGvgsIS/dqqolEQR5+K5
         6gAq6axK1zBzFn8C0+vE5CdX1hmIY2NjYtP4RZppBgu6ST9HynhxzqKW/eNSk2lQNntH
         cGLc3p1xl0m1qmFFTQRkbPu2ab+QQzhzGw6kwifvK5gi3jpy/auwVYY4XZfc0cLMh6Xh
         Thx/vJRz5tqacH0Lx/1PRfBmZ82o4BQrCJrN/YZL5sTlJUTGtEsPDpfFc/xObKGoxkJe
         SUDkbNL6VPfxHu1sTRcQ0gWttu+xHRx2Of/MC5lsp5uqVx2KCwquwTqbSXviSiPb6WOe
         a+2A==
X-Forwarded-Encrypted: i=1; AJvYcCUrU+bmIa1qWxGXAqvy2rivisAMnUBk+l9JuSpf6z/ztcOWcsg9GsElce0KBsiyeezDR+H2Tae8r82uh9E=@vger.kernel.org, AJvYcCWVG+pH9K3gaaJL3dLyaRaqOL9haM94aVqikdkE+eGZ7WHcVzFtkNPHSAQLkFAxf+U2Nzoq3Cnkg+FQXwOEst42@vger.kernel.org
X-Gm-Message-State: AOJu0YyHuL85ZGtWEF1rJYMrTDDVUC+lFCByJzeXyaQrnr5+0gawKjSs
	qOqGw/JRxsxCHbygTKQy6wvNoDtV737DjH2Hw05yJmc04t6BbibTCIUCupSzuBI=
X-Gm-Gg: ASbGnctM1LQ34qqr4UHTz/rHlrBhRI1cekn/nGrZj/RuCd5Llu44D6Tgfxfvu9EZM+W
	4AIElpOxytgt6K6yB7YWz6devbox9mYxVrFintnfFyYMMggXfOnsnRBhWy120dDfX2C6VrXsaIY
	RtAoukiZWIPBLz0K8fTdppkvKrxosE1LjsS2mriauh8UYMH0OI7zDYnSM6fpNbNJvWNgG/8O3GM
	uWKg391v3CuFV8h6EIuJbqpLGXoxVBnhgAvuAEuUHrOcQud1JD7na4nGmxkdqs1aMeibLnWDQte
	ba5kKzJsDhGLuQd6iIC8qp8OrZNUQntIdoByhnxbvhAKjECAMHXGFLIaM2j6Jxa++BYFIRc+9iD
	NUE2Ge6E77Js=
X-Google-Smtp-Source: AGHT+IHiPQ8uW95AatqAwso13h1WKaP0+B7bIj7pRJzr+/EQRvdcdBIlwrYkcv0hfB89DdKMD1DJ6A==
X-Received: by 2002:a05:620a:2404:b0:7ca:f349:4265 with SMTP id af79cd13be357-7cd287df076mr823220185a.4.1747297546343;
        Thu, 15 May 2025 01:25:46 -0700 (PDT)
Received: from localhost.localdomain (ip171.ip-51-81-44.us. [51.81.44.171])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd00f4d52dsm955472185a.17.2025.05.15.01.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 01:25:45 -0700 (PDT)
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Shuah Khan <shuah@kernel.org>,
	Chen Linxuan <chenlinxuan@uniontech.com>
Cc: zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	wentao@uniontech.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/memfd: clean Makefile
Date: Thu, 15 May 2025 16:25:21 +0800
Message-ID: <20250515082525.358433-1-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When writing a test for fusectl, I referred to this Makefile as a
reference for creating a FUSE daemon in the selftests.
While doing so, I noticed that there is a minor issue in the Makefile.

The fuse_mnt.c file is not actually compiled into fuse_mnt.o,
and the code setting CFLAGS for it never takes effect.
The reason fuse_mnt compiles successfully is because CFLAGS is set
at the very beginning of the file.

Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
 tools/testing/selftests/memfd/Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/memfd/Makefile b/tools/testing/selftests/memfd/Makefile
index 163b6f68631c4..e9b886c65153d 100644
--- a/tools/testing/selftests/memfd/Makefile
+++ b/tools/testing/selftests/memfd/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS += -D_FILE_OFFSET_BITS=64
 CFLAGS += $(KHDR_INCLUDES)
 
 TEST_GEN_PROGS := memfd_test
@@ -16,10 +15,9 @@ ifeq ($(VAR_LDLIBS),)
 VAR_LDLIBS := -lfuse -pthread
 endif
 
-fuse_mnt.o: CFLAGS += $(VAR_CFLAGS)
-
 include ../lib.mk
 
+$(OUTPUT)/fuse_mnt: CFLAGS += $(VAR_CFLAGS)
 $(OUTPUT)/fuse_mnt: LDLIBS += $(VAR_LDLIBS)
 
 $(OUTPUT)/memfd_test: memfd_test.c common.c
-- 
2.43.0


