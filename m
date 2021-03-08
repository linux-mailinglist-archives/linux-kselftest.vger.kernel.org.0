Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548A2331615
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Mar 2021 19:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCHS37 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Mar 2021 13:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhCHS3j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Mar 2021 13:29:39 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F88AC06174A
        for <linux-kselftest@vger.kernel.org>; Mon,  8 Mar 2021 10:29:39 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso4402349wmi.0
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Mar 2021 10:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bXejlMPueDZrsHR5nF/OLtofXE28kxk2lXgIivzYIs8=;
        b=PmCdJyvL61o4wnr1YkHvY762hwwHrF4cqUCPoROGMl6DrWItiUG9nXK3Zg8Y4OSPfr
         wBMWRVtZ/o6qdOOHYLsFq0blG6bCUUXtfoo/AGwOxx7pQP0XtZW1XkECFQrQkuLpPCaE
         j99Xx+fY8i0LEmTtWOli+1MV+Pu7fEQFeNhKFvfn3E4C+YBXhr6IwlxFgHY8UbvQ9Hdt
         T85QZcZUZl20ydCchBC/H5+0VFJF8fen62f/CaWvKYXH6J8zx9Dmu9rXS55yaGoCFTYz
         NNcDfDAdhuQUiExnfgke7cHV42buNteDd/bencskxdSU0q9/vXyxVfNjdj5ysRqhYyGw
         lS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bXejlMPueDZrsHR5nF/OLtofXE28kxk2lXgIivzYIs8=;
        b=bvBoGZVm8gWYIKYRjsZEZYiJBNYKG9J6kJxyj3Q8Oo8RvJCtwI/Hx5HIsQFaAZnn1G
         3NZBzMiCZDhCbYRTwoGcD7X9ugSwykRM9LYdk31B4x6tggY8twl7oJUPM+c+5avnN9Nn
         Zsrr9ma2nE3MU11RC9D9tWPiZF0Q4nSGOED5ajFvSG4iM7dBvLXTdPHIJ7sDLRwFj41b
         VhIaKNeCjWLCB48zmdEb3hSojtt7zniInWjTjYDxyEW5L+c33Ov6D5s50i/op8HO6/rS
         MsyOaCAWkelDB55OxIzfw69doyqLIwY+0Eim91A17862iL7YHyltmsuKzxiH9rRaLYAI
         jV/g==
X-Gm-Message-State: AOAM530hT/dJ/W98kOcJssHITX0be30x/YlJHRqR5KwJ1NRlWWdF53ia
        vIe3UWRaf3iC4YyV4908YKv+nA==
X-Google-Smtp-Source: ABdhPJyNEpuPwQXGDg+2N8ACypfhdlc4ZALGpV36n2znkSaSj31hJPID7PEnpwvyiIlabGQ7VaFnFw==
X-Received: by 2002:a7b:c308:: with SMTP id k8mr138354wmj.54.1615228178053;
        Mon, 08 Mar 2021 10:29:38 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id d204sm224425wmc.17.2021.03.08.10.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 10:29:37 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
Cc:     linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        joe@cilium.io, toke@redhat.com, quentin@isovalent.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next] selftests/bpf: Fix typo in Makefile
Date:   Mon,  8 Mar 2021 19:28:31 +0100
Message-Id: <20210308182830.155784-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The selftest build fails when trying to install the scripts:

rsync: [sender] link_stat "tools/testing/selftests/bpf/test_docs_build.sh" failed: No such file or directory (2)

Fix the filename.

Fixes: a01d935b2e09 ("tools/bpf: Remove bpf-helpers from bpftool docs")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b5827464c6b5..c3999587bc23 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -68,7 +68,7 @@ TEST_PROGS := test_kmod.sh \
 	test_bpftool_build.sh \
 	test_bpftool.sh \
 	test_bpftool_metadata.sh \
-	test_docs_build.sh \
+	test_doc_build.sh \
 	test_xsk.sh
 
 TEST_PROGS_EXTENDED := with_addr.sh \
-- 
2.30.1

