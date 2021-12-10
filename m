Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C00C470746
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 18:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244473AbhLJRhP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 12:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241455AbhLJRhH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 12:37:07 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C53C0617A1
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 09:33:32 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso10280497otf.12
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 09:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WMqa61IMKQAN9nayBNaET9ogW/1IQBHwCkgxPK83A3s=;
        b=ZiinzdUTAUE4pW3+MikJK5J7ul2KgoWPeStbJcIb4f+ObGuAEAF6SL+SMRMxnX95h2
         iK95itksi/1uauaJqsD/x6K8C5VGuaLthvLoxR2o9n0klTF4wkcseELo0XrgDCp4GWPa
         /qWqBFehtViF2vhi7zRNmscMQ1Z5b/aeYT60o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WMqa61IMKQAN9nayBNaET9ogW/1IQBHwCkgxPK83A3s=;
        b=txPlajCBFG1Jg6qeBXeJANiEafueMGUl/r0OY+0ARtdxP7CIJQJvIL9Ifqlx+3vwPg
         HOl3ICEvQAaOu1hYX4zOcEXWL3aHAsUX/LFA0gAGZYP3RxuKSEEzWe/YZ1qRNV3aWyLr
         nG3hHMMYZAiaac49+2Fgajp5Z78haBLTqKg/Vc5Hal6oAwwkUo2QFzgl7cLP1iDfed9c
         dt3Hxq0+PBH8x9I+5mx/M0sE/z7I0VMd7kswqD8yr76IqPpaFNQiN1zSo7V5a/GD1pXe
         gn6OWMBLll/DL4smMOOK5t86RtaEOq3FS8S0obekdg/RhQMbcARaoh6uNC49IsmSl813
         0bPw==
X-Gm-Message-State: AOAM530PiBXzmBICJW5x/gNFmlNqu5ZCxJf96wlx6x1h4D/U1OTATvnJ
        3jx67n+IwVeUzm6+bARUR5lUSQ==
X-Google-Smtp-Source: ABdhPJxs5UyjzAwtor6CH4V3zYGHQWLFyg/yw499Ss2tuG45t4WeD25Up32eMNTOXvKpzS2SfYHVjw==
X-Received: by 2002:a05:6830:1392:: with SMTP id d18mr11833207otq.374.1639157611625;
        Fri, 10 Dec 2021 09:33:31 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x4sm892224oiv.35.2021.12.10.09.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 09:33:31 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
        keescook@chromium.org, mic@digikod.net, davem@davemloft.net,
        kuba@kernel.org, peterz@infradead.org, paulmck@kernel.org,
        boqun.feng@gmail.com, akpm@linux-foundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 06/12] selftests/landlock: remove ARRAY_SIZE define from common.h
Date:   Fri, 10 Dec 2021 10:33:16 -0700
Message-Id: <e86b9f3a050a919b90a41e42f369e8945210c2fb.1639156389.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1639156389.git.skhan@linuxfoundation.org>
References: <cover.1639156389.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

ARRAY_SIZE is defined in several selftests. Remove definitions from
individual test files and include header file for the define instead.
ARRAY_SIZE define is added in a separate patch to prepare for this
change.

Remove ARRAY_SIZE from common.h and pickup the one defined in
kselftest.h.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/landlock/common.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index 20e2a9286d71..183b7e8e1b95 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -17,10 +17,6 @@
 
 #include "../kselftest_harness.h"
 
-#ifndef ARRAY_SIZE
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
-#endif
-
 /*
  * TEST_F_FORK() is useful when a test drop privileges but the corresponding
  * FIXTURE_TEARDOWN() requires them (e.g. to remove files from a directory
-- 
2.32.0

