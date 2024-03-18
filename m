Return-Path: <linux-kselftest+bounces-6393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C96087EF8A
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 19:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35EB9B22A83
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 18:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D7955E5F;
	Mon, 18 Mar 2024 18:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ARZ9MwKY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C89656441
	for <linux-kselftest@vger.kernel.org>; Mon, 18 Mar 2024 18:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710785807; cv=none; b=fgHz035haAYxPZ3iOsBDX1V2P7ZW8SuR/cItx/h2sZ7qePKBfQOlg/TAyIz5M5WGD4ILnMD4F8VW5zAvvCgzuAUr2eJU6fLGfDrM+hy6GOTJ/R9Y6Tj8p2PO3Q2uQkLojvYYNUpXFrOyoXn2++EYc9jvhJi9n8R0fnfP6480puM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710785807; c=relaxed/simple;
	bh=aK42RSRjeC9IKLretkq6K3mOb1utL1EABlZm0R0jL/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JUQOz3MwXQWxd84W+cHSP7XOXv+5OqN9WVTg3IOVBfbjUppWAeZcVf6FMkd61TRo3h6L48OIDOjDD9yL+kEs4seDhIpVYwTpUVtSm444xPFNky2URf4U81Hmui4JhV97usuf0eayqI0Oc82FN1e9Eoz8oD+sJDsZfP+7fHUDI8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ARZ9MwKY; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5e4613f2b56so3530335a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Mar 2024 11:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710785805; x=1711390605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TutCVyAsBBig1tZFwFrMfle0rB3gxmbA8WbdKdW3GIk=;
        b=ARZ9MwKYKqfwMotgwXhfN0L71CEOcemJaTm1tgNV7bwsGUqRUZKFKyzRzFN2s8j9el
         RpGOhzxblG2mg0TPfT8g8dpHlWa4xzhMH0AXR0NL/WFrtQAUJPei63zFghw87PYRWIeE
         NEzRus7BQqQDYMIpGII5wYwud02uWh4iLNLiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710785805; x=1711390605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TutCVyAsBBig1tZFwFrMfle0rB3gxmbA8WbdKdW3GIk=;
        b=Y5DEsoL9PsTVEDLGtvA/vju8WjyjD7R/qTCxsLE4bNbfgre0NrMySTVx60xJ682yu7
         wfjyqg/21raDraquXl/sVZ99gYvaDjgaxSpdlRIVEs3APDANxvdm/M9+/sxr/vuJ6AGn
         Jc5lPP+gRktbkbxF/hfyeuebMa+QsT+XUCFT5QpD/MBeMsqJorVsnGGcwdObeBeG0aG6
         N99vDv1vN1NOV0eGPwymTBVwEWEcu/86ABvhjWvn5PH4Dc+X27Uw7q+BxRcG7rgu10wD
         aklZ113LTSVbcXtR7k1qzW8w6vkDkFOZ1gOeciL5OGDBXZdEODIZk2mAz8bHHW0qh2om
         eLSA==
X-Forwarded-Encrypted: i=1; AJvYcCUTF/3S/jGN3kb2IcoTa6RgtPz+UVEUqcQKBm327vH2RQXnKWO/flUjvSnii9VqNIYwRtzf7t7aBywTj6LVBG2HfdcFlN5PNPOCbXerv49X
X-Gm-Message-State: AOJu0YzXgSonDc+Ln3DQxUQRCeOg1DhH4S3Pe2X1taw8HCQrP44qvvRN
	e1HavsxwRzS4VlukhSt2qorvc9aVz2aWDu9vVjfyyinxpcm21iof3GkW0W7cSA==
X-Google-Smtp-Source: AGHT+IHL5dp9Je1qIRv0vv1+wAHaevvUv1aqzEk0ER5ggoxg/Bp/e00oDihoqfX4JSsOZSNsvbPZPQ==
X-Received: by 2002:a17:90b:3901:b0:29f:c286:d439 with SMTP id ob1-20020a17090b390100b0029fc286d439mr1818686pjb.35.1710785805001;
        Mon, 18 Mar 2024 11:16:45 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id sw11-20020a17090b2c8b00b0029bcaaf2baasm8092296pjb.3.2024.03.18.11.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 11:16:44 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Kees Cook <keescook@chromium.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	"kernelci.org bot" <bot@kernelci.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] selftests/exec: Convert remaining /bin/sh to /bin/bash
Date: Mon, 18 Mar 2024 11:16:42 -0700
Message-Id: <20240318181638.work.575-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469; i=keescook@chromium.org;
 h=from:subject:message-id; bh=aK42RSRjeC9IKLretkq6K3mOb1utL1EABlZm0R0jL/Q=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl+IUK90DszRxhMIIEkqPYLiLsWPFbVU218DUmi
 cRdTt7eIb2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZfiFCgAKCRCJcvTf3G3A
 JhL4D/98Q/UMkZ6mihjAYLaGdP9nozm50w8mti8CjE1+3V4lGLcP/fN787DQ0T4/Vlhr62YxZzW
 arKmNIeHxt4qqOgbztjGxKx2oaIXOoAslLTRTX3oD29Jf1BaWzfgB6gihYrhwaa1RroIcMdhpeh
 SmJgkZNubnQPgOzDRIbBB26JWcEKn2xNO2cBePzQWY2bCNDkV2pfBVui16V79jyYWFEl9oLvc0l
 PLUoqGnwRjaN7owt/aIbEGS4yPpNLkCK3/r4mPnFjE22gBt8hYIiu+Tp08fI/0WOMvYlUR/lHkJ
 JfYZ8WzbqZYj/RhnRs29Z0yixEJQO9aqR91ITJUJaFY5Z9ibebtCjUEgK/AWUq/Hq4ZrumVDwGl
 6N8yUiD4cE6vDog6YvggkDZcK0PuuasP9smEHFVmy+qjW51qw9xprEcbcncm1FdQyl4L36dDAWJ
 nIBreYuBDIHQgXtwldB0msRTmUGCMmTZZDb3xfpYdOs6F4VaH4YETb6f9JMZHWwicrGJB1SIS2B
 zVqcdb960hKGlfm80/5GYj2wuxscfgjET8yxFXRh5pfZfSmn1snv0U7j/zEBYaisVIL28oe2tVo
 PrGXRgvNWJYSe73k9eWBIJBEh/lKuHNlUFoH5tIRhdAbdv300T8IP7Jtiq4lbroM5e48UPzsZMK
 XJkcOSG Zpxt901A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

As was intended with commit 17107429947b ("selftests/exec: Perform script
checks with /bin/bash"), convert the other instance of /bin/sh to
/bin/bash. It appears that at least Debian Bookworm's /bin/sh (dash)
does not conform to POSIX's "return 127 when script not found"
requirement.

Fixes: 17107429947b ("selftests/exec: Perform script checks with /bin/bash")
Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Closes: https://lore.kernel.org/lkml/02c8bf8e-1934-44ab-a886-e065b37366a7@collabora.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: "kernelci.org bot" <bot@kernelci.org>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/exec/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index a0b8688b0836..fb4472ddffd8 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -19,8 +19,8 @@ include ../lib.mk
 
 $(OUTPUT)/subdir:
 	mkdir -p $@
-$(OUTPUT)/script:
-	echo '#!/bin/sh' > $@
+$(OUTPUT)/script: Makefile
+	echo '#!/bin/bash' > $@
 	echo 'exit $$*' >> $@
 	chmod +x $@
 $(OUTPUT)/execveat.symlink: $(OUTPUT)/execveat
-- 
2.34.1


