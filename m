Return-Path: <linux-kselftest+bounces-8615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A753E8ACDFF
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 15:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B77281F8F
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 13:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938D414F128;
	Mon, 22 Apr 2024 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NN2NYGgW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49E714A4E5;
	Mon, 22 Apr 2024 13:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713791826; cv=none; b=f1J0ZtfmIwfURHx6V0YCMDp7Lsi00qlyFDqT7kSIAMnU2q9g/OOAcHvxmCnkkrcIUfSoiS3XGV0RFYdxXwaeJGgmag9fTTQk7PKqts83ldLvnyOeKy+W/0qGhf+o3etKBMgM+4MCqgk3Zi9d3V22pY/1PgVteaPqnOzasr4cvXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713791826; c=relaxed/simple;
	bh=bIu3jv7wbFitFgCSSAIH5zSJzALudmrLAp7H2HUq9VE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kh9DAJ9SDHYg03S2DO7rUHugJcF19HDSxnMjkT4KE4rZw7PSnutThAm5GZZL278a/9JY+iKvwXDDDWImrM93rrvZAdLBbbqoaeylJKGfs+hCS5j32il4+/UbWgK3mSCCUCOz6BoGscv3znDU++lB3PXU+yD51f+nNleKZ94acmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NN2NYGgW; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2db17e8767cso58122391fa.3;
        Mon, 22 Apr 2024 06:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713791822; x=1714396622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rC5Q3TsmbK89CYxlmTZK9bHoQvR58XmOMQv8g8W4/aI=;
        b=NN2NYGgWCHO6Xsi5Z65W6qo19ybkXMWKpRpbeM8X72xK+RD4lfuHoz5T0C6EKROoDK
         Y5C3UbE5+c5y9tvkKR5+NlkgNlfzXVRI+Wd3oncLAgm4VHQ2+0Q0SUhQ0eorvDMIQLcn
         SfBKNj9qO25bXP5TPVXliyE8HXB0QMZ4ytcH9jxnjFE0QWZ2aDTClmeheIV4LZ3SYOmW
         bTZUNlsr93kxxG3kC4u1nKjmWdKlIjRsVl7PJ4fww1qGYGBhMLEOtT/M53voPXy+4ZXr
         XOxMU2JDOvH7gRYH9xta0BYje2qC75duhIweJotfxIivjQXFGNCx54jM8OrJGSqLvhCt
         mSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713791822; x=1714396622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rC5Q3TsmbK89CYxlmTZK9bHoQvR58XmOMQv8g8W4/aI=;
        b=v9TvxqvkbU5u6xIJCHXI23n1Y9IAp/jSiHix42pYjinnLiuy4Fmu14wdhPOiFLrzkh
         MKneazBaAErg95moq6jhI72SjOuW6/xdtKEZz/JsxKxQZCLnV1jMEpARyZURFHMGAPVL
         H3tNJhDz8+p4w2N9U4U6m1gfT4vdotcdUn37niVLWGoeysNt6kvdBxm3VjdcZFnrJhFK
         mL11V4YOtfIdzJ1fg1695Xv3KfFDkJphPMMt3hB/GNbjVISCQ1jnZirCInID4us/MBpu
         uGwBqRAukGI81sBck+cLx7/x19NaVRV9zEOmHNbP/tCDt1Zl4Fv+CDizOxObJ2XAlH+D
         Sj1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpmwSoQN41iu8Zx3l0KgWLdc1rs1XV4WnpOb0s2RZ/9ftKks8eVNtNK7glhtsU2p6HIC5YumcVq3UFZmsX35r9wuYauBp3lcgKfj0ZmBTj+OGoIGYJ1MKOMGoL4XmqiShQPiSFxhQD0U+p2RFr
X-Gm-Message-State: AOJu0YxXm1pgv1StFMhNJA5/0FwxgLpmVnG57k+dziuGQc2VAl0rOPK7
	uLpgf1wIonnhzavmsJULdPFwmyDrg+sIsYx450NNpZZqu9Rieb8s
X-Google-Smtp-Source: AGHT+IEZYgvUslSm4eH9mo9Iqq9wum0lqnNiW2nb2vsWtTcF6qcwIIy2TK+M2PClLWiKTUoJLwZIQw==
X-Received: by 2002:a2e:9384:0:b0:2db:348f:5c33 with SMTP id g4-20020a2e9384000000b002db348f5c33mr5485742ljh.16.1713791821576;
        Mon, 22 Apr 2024 06:17:01 -0700 (PDT)
Received: from localhost ([185.204.1.218])
        by smtp.gmail.com with ESMTPSA id w2-20020a05651c102200b002dcb67e5716sm1273768ljm.22.2024.04.22.06.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 06:17:01 -0700 (PDT)
From: Amer Al Shanawany <amer.shanawany@gmail.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v2] selftests: filesystems: add missing stddef header
Date: Mon, 22 Apr 2024 15:16:59 +0200
Message-Id: <20240422131659.30222-1-amer.shanawany@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <df1df586-188e-4290-9986-7b7cd31710e3@collabora.com>
References: <df1df586-188e-4290-9986-7b7cd31710e3@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

fix compiler warning and errors when compiling statmount test.

gcc 12.3 (Ubuntu 12.3.0-1ubuntu1~22.04)

statmount_test.c:572:24: warning: implicit declaration of function
‘offsetof’ [-Wimplicit-function-declaration]
  572 | #define str_off(memb) (offsetof(struct statmount, memb) /
sizeof(uint32_t))
      |                        ^~~~~~~~
statmount_test.c:598:51: note: in expansion of macro ‘str_off’
  598 |         test_statmount_string(STATMOUNT_MNT_ROOT,
str_off(mnt_root), "mount root");
      |
^~~~~~~
statmount_test.c:18:1: note: ‘offsetof’ is defined in header
‘<stddef.h>’; did you forget to ‘#include <stddef.h>’?
   17 | #include "../../kselftest.h"
  +++ |+#include <stddef.h>

Signed-off-by: Amer Al Shanawany <amer.shanawany@gmail.com>
---
V1 -> V2 added compiler warning in the patch message

 tools/testing/selftests/filesystems/statmount/statmount_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test.c b/tools/testing/selftests/filesystems/statmount/statmount_test.c
index 3eafd7da58e2..e6d7c4f1c85b 100644
--- a/tools/testing/selftests/filesystems/statmount/statmount_test.c
+++ b/tools/testing/selftests/filesystems/statmount/statmount_test.c
@@ -3,6 +3,7 @@
 #define _GNU_SOURCE
 
 #include <assert.h>
+#include <stddef.h>
 #include <stdint.h>
 #include <sched.h>
 #include <fcntl.h>
-- 
2.34.1


