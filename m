Return-Path: <linux-kselftest+bounces-2011-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAEC8146CF
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 12:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04CECB232E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 11:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD2924A14;
	Fri, 15 Dec 2023 11:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H75SE11a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A194625578;
	Fri, 15 Dec 2023 11:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3333131e08dso487947f8f.2;
        Fri, 15 Dec 2023 03:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702639498; x=1703244298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=78QwY/yXp7SyEhpI3hXVRE/tZyrcCs2zsxYlhvSEhSw=;
        b=H75SE11aOHp4MsZGHC1WeFjfX9x7PLQRMwdoTs2Y//jqKBg3fMvr39MlqgfCsFqYpD
         4r4GfAGDh3jDKOWN2W/uKrfF1r0A2P5uxYtPCzkBkoH4SxO/ZnVsXCAH55xqqbeF4PO8
         RcXLSQSEn+f9c2PWno5WH0YkQUbNurkQSD91b32fzNNhYufyYUjw4zpN4VBTDZIMfn52
         m3LtwShSD1J7k5kHCi5zdbrtOtu2pJg39e6gYSIfChyRZ+1F/m8wrCRFYqAacaLf4v59
         s/chXjNMHdSD9K9w+C8P0f5M/zhFN8ZNd56DHpVf2dxMBepkJ3gLe92OrPSr8eCexttH
         VJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702639498; x=1703244298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=78QwY/yXp7SyEhpI3hXVRE/tZyrcCs2zsxYlhvSEhSw=;
        b=eJ6HzvnaK1L4MExagZwUZo0CdagyvJpigdXwZkT91AvtZbxu/+ityGPGFr9tZ8puQl
         SNFzxLsC2PBJ46qUYV1WahQ7oGDHDA9zffKrBTu2mgjE7t+X28WdtiMReyCGWx8ZtPPC
         2t4M7Fegz4OA6D2olmG7WK56LZ/cMMj/3iX87XaG953ijeVaRDdukWYzQzymFAXjL5R1
         2qUTipMyLAPI65QmvWiiY//5aXLaTACtR0p4JAsf+8xAVdLuiEDhZ0ATTknTK/mPgKEQ
         rdnDfFTZ+Fij91DXDLKkDQUajnSQA//HD/K7Q8sGLt2EmiLIAevAMgKnfxRyUOSCrUeZ
         KSgw==
X-Gm-Message-State: AOJu0YzqsYkzBH+9ztHBo+qHoKZjIY/YZtqPQvMT/sUm3XtHAFl7r0Zq
	fUDxt5dlH2GhfGtZkTmgsNk=
X-Google-Smtp-Source: AGHT+IHbvlF50uwy5uxAGyjsXMY3E1oRBF1pOxK0P3BvjONqgzkK+7agL/9FjbSYjrZbPUgvJTYAew==
X-Received: by 2002:adf:ed49:0:b0:336:4350:e2fb with SMTP id u9-20020adfed49000000b003364350e2fbmr2275153wro.76.1702639498352;
        Fri, 15 Dec 2023 03:24:58 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id df5-20020a5d5b85000000b003364a0e6983sm3668181wrb.62.2023.12.15.03.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 03:24:57 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	Shuah Khan <shuah@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] powerpc/selftests: Fix spelling mistake "EACCESS" -> "EACCES"
Date: Fri, 15 Dec 2023 11:24:56 +0000
Message-Id: <20231215112456.13554-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake of the EACCES error name, fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/powerpc/papr_sysparm/papr_sysparm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/papr_sysparm/papr_sysparm.c b/tools/testing/selftests/powerpc/papr_sysparm/papr_sysparm.c
index d5436de5b8ed..f56c15a11e2f 100644
--- a/tools/testing/selftests/powerpc/papr_sysparm/papr_sysparm.c
+++ b/tools/testing/selftests/powerpc/papr_sysparm/papr_sysparm.c
@@ -177,7 +177,7 @@ static const struct sysparm_test sysparm_tests[] = {
 	},
 	{
 		.function = set_with_ro_fd,
-		.description = "PAPR_IOC_SYSPARM_SET returns EACCESS on read-only fd",
+		.description = "PAPR_IOC_SYSPARM_SET returns EACCES on read-only fd",
 	},
 };
 
-- 
2.39.2


