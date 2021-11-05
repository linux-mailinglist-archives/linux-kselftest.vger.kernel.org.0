Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5764466F3
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Nov 2021 17:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbhKEQ2c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Nov 2021 12:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbhKEQ2b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Nov 2021 12:28:31 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6D0C061205
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Nov 2021 09:25:51 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id g29so5664537lfv.4
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Nov 2021 09:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QUTfLy1iCpJaN03F0qB7HmLPMvYCUl4mt7QEsJfTLts=;
        b=kkEJtaY1K2n82x/UBfegIqqgxmEgtDimvV3nuidIgABKW6b/bWTBhKWCqRTYZJ6zXJ
         cjn1R6E286iVDSbguU8u6YX1fG9GY0efrxqXQdEFis4uxZWnS15oJ6srFgw2x4Ur0CYe
         T0LjNOrKMx0JX1ecJygQwJzqvpTK3QFosK0E1oo/1IL2KCaLwZ8XswtAGt3zbzHb5Qe0
         eMZioRrukDQNT++0Lf9TI/g5tpO1ZnhKMa/1NNoxH0p+YkheoJ71aQd6+DTfwdfckguN
         sf4aQePetkg2GUbAcJwtQrFsJCUpAcpPczLPGcyHM3C06ZbU8YiqY4kkkW/4bX2uHod1
         8KLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QUTfLy1iCpJaN03F0qB7HmLPMvYCUl4mt7QEsJfTLts=;
        b=Tm+NBt433yVOUzBoUYbE4iTA9D8XMc0wVn3HcPr9Zo+8g/mgLA5eCg6GzzqdQaqiAD
         JD3mha3dClctZm4WEAMlJ8Shdr7BASGH4YVtpESV3bbjg1DHol4cASVm0ElNd3MrSFn1
         01t5FiDD5LCX1Q+U+FhR46A8KQMXPSzY4/wM/37TNw/hSb9SU8fK1krcNS76aC6QY1Mh
         5Bt1eP44+c6b3Gpz/e7YxwmDuE+0Wv3hgwaBbfKFvqFOQj8pBj9SmJjHlgBMRI0RY8hf
         lALQmuS4deuObxTmZct5DFqjSdb2Ill+bmCOu+SFac5lHtzVPVerIgKoQHv1J0ctX/cv
         5gDQ==
X-Gm-Message-State: AOAM532RQ+d+08CUUrshYlOV80Ui2wRvpwfajqIWs5s8pHjE2gIjcnXa
        XvhfCWltDKB/h8v1vBgJEo2aLg==
X-Google-Smtp-Source: ABdhPJy8KooI80fVpt9eaxrWsH+brvLejZ46wccflYYtY1bDxHtC/FMcxFJmC2hqfHTBccTJ8cSStw==
X-Received: by 2002:a05:6512:1113:: with SMTP id l19mr28399988lfg.201.1636129549793;
        Fri, 05 Nov 2021 09:25:49 -0700 (PDT)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id t3sm870833lfc.216.2021.11.05.09.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 09:25:49 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     shuah@kernel.org, christian@brauner.io
Cc:     nathan@kernel.org, ndesaulniers@google.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 2/2] selftests: cgroup: use function 'labs()' over 'abs()'
Date:   Fri,  5 Nov 2021 17:25:30 +0100
Message-Id: <20211105162530.3307666-2-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211105162530.3307666-1-anders.roxell@linaro.org>
References: <20211105162530.3307666-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When building selftests/cgroup with clang, the compiler warn about the
function abs() see below:

In file included from test_memcontrol.c:21:
./cgroup_util.h:16:9: warning: absolute value function 'abs' given an argument of type 'long' but has parameter of type 'int' which may cause truncation of value [-Wabsolute-value]
        return abs(a - b) <= (a + b) / 100 * err;
               ^
./cgroup_util.h:16:9: note: use function 'labs' instead
        return abs(a - b) <= (a + b) / 100 * err;
               ^~~
               labs

The note indicates what to do, Rework to use the function 'labs()'.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/cgroup/cgroup_util.h | 2 +-
 tools/testing/selftests/cgroup/test_kmem.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
index 82e59cdf16e7..76b35d9dffb5 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/cgroup_util.h
@@ -13,7 +13,7 @@
  */
 static inline int values_close(long a, long b, int err)
 {
-	return abs(a - b) <= (a + b) / 100 * err;
+	return labs(a - b) <= (a + b) / 100 * err;
 }
 
 extern int cg_find_unified_root(char *root, size_t len);
diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
index 22b31ebb3513..d65bb8fe876a 100644
--- a/tools/testing/selftests/cgroup/test_kmem.c
+++ b/tools/testing/selftests/cgroup/test_kmem.c
@@ -192,7 +192,7 @@ static int test_kmem_memcg_deletion(const char *root)
 		goto cleanup;
 
 	sum = slab + anon + file + kernel_stack + pagetables + percpu + sock;
-	if (abs(sum - current) < MAX_VMSTAT_ERROR) {
+	if (labs(sum - current) < MAX_VMSTAT_ERROR) {
 		ret = KSFT_PASS;
 	} else {
 		printf("memory.current = %ld\n", current);
@@ -383,7 +383,7 @@ static int test_percpu_basic(const char *root)
 	current = cg_read_long(parent, "memory.current");
 	percpu = cg_read_key_long(parent, "memory.stat", "percpu ");
 
-	if (current > 0 && percpu > 0 && abs(current - percpu) <
+	if (current > 0 && percpu > 0 && labs(current - percpu) <
 	    MAX_VMSTAT_ERROR)
 		ret = KSFT_PASS;
 	else
-- 
2.33.0

