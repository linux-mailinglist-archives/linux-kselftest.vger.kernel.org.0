Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EF92F501A
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jan 2021 17:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbhAMQff (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Jan 2021 11:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbhAMQfe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Jan 2021 11:35:34 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742B6C06179F
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jan 2021 08:34:54 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id e18so3917712ejt.12
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jan 2021 08:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=imxNOIL2ER7DtcMLfQ/6C1z3KS46am+Q8zrFjZV4vkQ=;
        b=Kjwx42msNjsVsAuTlIgBlFA9ZiedF39fMDSTDx/uckfRWrku2SMld2JIZoV3curmq2
         0PRYHBZXnn5PZqOlPGjGiu4nqP8KHft0NfPoRx4MlAJG/mocoNSqN91WySExPaUgDoya
         4127NK+NdAeUYjwhLG7eroAVVu8XRMLzgidw5MGuxr2X+wzsvD/EnsqA0KPh99Az1iQQ
         4cCM+W9j4z76qPSynvGJqstRDe1g9I99miFxjGiL6aqCmi/Wej2wXufK+BplN/oksnfT
         vQ5kNWocVePxAhnq3mkpfPE9QpaHQYeI2tu7WcZTTdSiWbhTMkqHt+eutDKft2jA0TGn
         eymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=imxNOIL2ER7DtcMLfQ/6C1z3KS46am+Q8zrFjZV4vkQ=;
        b=qOPoITFs6htJpaELdpss9zw9+6UnkazOCvOUxGlYU70b7T61tSXOAefxQyqgHnSNxg
         cXM0e/UnJmFUxmfrYn4bsif3eoaNw6LGlDUz8zQ78khuZ8cRixmnG60lXW/N6KgRuKr8
         njd4ZIk7MKMGJpVM6aFhe5hG1XKjC+7pNSbRsJuEKZmnjzNYtEfaZCZK4UIBicligIOT
         Ovl1TaMUVq826cBgSD6GURcQp+Fwc6WXf+b7t8RhsZqdw7gUa3bvN2x0HFDLnxdulSdZ
         9N4O+vNmGBO+LE+RL4Svm5RAf9vy6xaF8yjREPqzVnKANpm0p14UrnBvptmR74wueqVd
         Q+DA==
X-Gm-Message-State: AOAM531+FsKTKG3AqUil8dljpDlLVqWKIdFGizkvzwvXIBYOUk3mwXjM
        9WfBOm+Wd4qyudobqHblkZtGxw==
X-Google-Smtp-Source: ABdhPJx6qJYn1edg3QxhlZRLiV2O0QxKtUTdy7pYA9R7v5ycVclRMYKcx7LSsNtukhOD0qf+wEiBmg==
X-Received: by 2002:a17:906:ece4:: with SMTP id qt4mr2038296ejb.311.1610555693177;
        Wed, 13 Jan 2021 08:34:53 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id g25sm923943ejf.15.2021.01.13.08.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 08:34:52 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     bpf@vger.kernel.org
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-kselftest@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next v2 2/5] selftests/bpf: Fix out-of-tree build
Date:   Wed, 13 Jan 2021 17:33:17 +0100
Message-Id: <20210113163319.1516382-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210113163319.1516382-1-jean-philippe@linaro.org>
References: <20210113163319.1516382-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When building out-of-tree, the .skel.h files are generated into the
$(OUTPUT) directory, rather than $(CURDIR). Add $(OUTPUT) to the include
paths.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 95ce81513648..92888eed89f3 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -25,7 +25,7 @@ BPF_GCC		?= $(shell command -v bpf-gcc;)
 SAN_CFLAGS	?=
 CFLAGS += -g -rdynamic -Wall -O2 $(GENFLAGS) $(SAN_CFLAGS)		\
 	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
-	  -I$(TOOLSINCDIR) -I$(APIDIR)					\
+	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)			\
 	  -Dbpf_prog_load=bpf_prog_test_load				\
 	  -Dbpf_load_program=bpf_test_load_program
 LDLIBS += -lcap -lelf -lz -lrt -lpthread
-- 
2.30.0

