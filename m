Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CCD2E861E
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Jan 2021 03:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbhABCbf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Jan 2021 21:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbhABCbe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Jan 2021 21:31:34 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CA5C06179E;
        Fri,  1 Jan 2021 18:30:54 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id c22so15231713pgg.13;
        Fri, 01 Jan 2021 18:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0uunf8NCDFYvIPUJR9RE23lPSlk2ARFIdjDyptH+ntU=;
        b=A+U6R5xXbDaY0aUJ2BXA7vdrsm9YxgrgzXISWgRGhEa3ePI8FIi41nZCKecp07iplC
         qKai7f1i6uygpJmEwduyYNoDOur7w3NuOtpBJorkfgTsWdMFlmnB7s+QnsruEPEUmXGC
         NU+VD9TIcd9a0VoT94c/IP6jcMFOvM1Rw6GouDqYvzbtyaOY0CiSQPHQMlRs26Uj3gBq
         kuY5LKpQdqmqQsD1tc1Bu66loS+PvnuwiXAuG69oLv14vi6R5+dUE2hYWqX2qOYzPPO8
         QJE5p1RWnGEv0KsdjuA6df3+IDOq5jxQ3tbLd0ckOeqvXdATG+K3CXbQPTAbKJO7pAZ4
         RB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0uunf8NCDFYvIPUJR9RE23lPSlk2ARFIdjDyptH+ntU=;
        b=YDNeR55yFnn+gNFb30rbzJ5xi8xhiaQeOcdeuY/iJHPQjMqphDfVbZwd1qNPCd7+g6
         WeiyDSuTOZxQlMyA244Gr+KTnQe7TZXHW3BVIHHNNYnoiLx68rE49APDK0ipS38M72jp
         UqEd22RRJYiFALhsiv6TYqwPFg5cVOanO9I0AG97PwTsSVauuNSGhv2qHREU1+vXAqKV
         EABvSCtuHpLc072K9a8yJny5lN1RQGYkTOGzkLomZaS2jskpsP4CESZ00ElfXw868BNu
         mG5cPLne7Q2wgvssyPjQgh6iF1s0mIXOfjojJUGGLiq4Uu0I8EbNQ8bF+POqfFTQ0CZ/
         Bb1g==
X-Gm-Message-State: AOAM531eZALSp+80Bcj8+czf+3vCQtgoRAvDOXR3nuHuBnnukhi+CTMO
        OyqFZ3L1zmSMelovXFMA0sSpS+mwAAn3YQ==
X-Google-Smtp-Source: ABdhPJz9hoTCtx82k3/2qjdbVJ/fzCknDUJwlZSgi27rlCQ1rdgSf9wRUp/YY6XmLGIz6wLLHG0Exg==
X-Received: by 2002:a63:130b:: with SMTP id i11mr19193274pgl.300.1609554653685;
        Fri, 01 Jan 2021 18:30:53 -0800 (PST)
Received: from sol.lan (106-69-181-20.dyn.iinet.net.au. [106.69.181.20])
        by smtp.gmail.com with ESMTPSA id cl23sm13995664pjb.23.2021.01.01.18.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 18:30:53 -0800 (PST)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, shuah@kernel.org, bamv2005@gmail.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 4/7] selftests: remove obsolete gpio references from kselftest_deps.sh
Date:   Sat,  2 Jan 2021 10:29:46 +0800
Message-Id: <20210102022949.92304-5-warthog618@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210102022949.92304-1-warthog618@gmail.com>
References: <20210102022949.92304-1-warthog618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

GPIO Makefile has been greatly simplified so remove references to lines
which no longer exist.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 tools/testing/selftests/kselftest_deps.sh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kselftest_deps.sh b/tools/testing/selftests/kselftest_deps.sh
index bbc04646346b..00e60d6eb16b 100755
--- a/tools/testing/selftests/kselftest_deps.sh
+++ b/tools/testing/selftests/kselftest_deps.sh
@@ -129,13 +129,11 @@ l2_tests=$(grep -r --include=Makefile ": LDLIBS" | \
 		grep -v "VAR_LDLIBS" | awk -F: '{print $1}')
 
 # Level 3
-# gpio,  memfd and others use pkg-config to find mount and fuse libs
+# memfd and others use pkg-config to find mount and fuse libs
 # respectively and save it in VAR_LDLIBS. If pkg-config doesn't find
 # any, VAR_LDLIBS set to default.
 # Use the default value and filter out pkg-config for dependency check.
 # e.g:
-# gpio/Makefile
-#	VAR_LDLIBS := $(shell pkg-config --libs mount) 2>/dev/null)
 # memfd/Makefile
 #	VAR_LDLIBS := $(shell pkg-config fuse --libs 2>/dev/null)
 
-- 
2.30.0

