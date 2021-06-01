Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAB739783F
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jun 2021 18:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbhFAQpB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Jun 2021 12:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbhFAQpA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Jun 2021 12:45:00 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA58C061756
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Jun 2021 09:43:18 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id p22-20020a17090a9316b029016a0aced749so548788pjo.9
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Jun 2021 09:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=aTLuLVDR3lxcou2oBOuWuwpILE9+p4rbUTDh4A1ndUg=;
        b=cgjkARurXBSRrO3zA1rIuwqKH1hSgO+xKdOaemlYS/J7t4GR8aKmW37vIRssyT84e+
         D0QBFjgw7JZ7W2aE16mcr9xjkmCVufU++TxZpytMBMJEcPlwcJQ3Mv0/1r/C3/RAOlsO
         +QKvzP5we6zfaCnj0QM25edS3B6Rsgfxb/CM84uVVgfyOtkBnIp2fJ71NX0eu6rtund5
         BchPtn9k068U3QJaUBdHHT3t5pqZa8tfFtHP814l7KRV7HgUKSomKUj2u3DA9CeMZ6Rs
         EWE3/S81qRxQWUb65DICAssi9TKj6lm4fUSKrzRHfyGCS2DGwn874dgSe5PDMgVhu4Gr
         Kbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=aTLuLVDR3lxcou2oBOuWuwpILE9+p4rbUTDh4A1ndUg=;
        b=Z0nUS9aTs6YPmJeDuvrUGeWpyK/+t3cYU0biwKondbrkWHOwNhKztNeFs9QmZLJ9hq
         3V8ToHozqM8tiEQdjCNdKpZIiNms6QX26TW2UzFFdmFMEf18IKZl9IYy5VOQiI8ns7Be
         fhGIM8/rVVo/lHUYeykFWc+QSaDq4A0QE4Pk7L67LYvIClJdo+stgtgbvdNWYC+41hFo
         vYt0HFQhoI5pSpR4TYIKO/fWiAl5dBUJpiXCp04kq+tkrsDfeoBF3JajLzfGenb/T+XZ
         pprsjZh7M7Kf+b/F34v99VNl0rOPIOZ0Dw4zxRpnM1T3SH687WdCcYRK1UJ73YeD0R6v
         ZrZA==
X-Gm-Message-State: AOAM533SEVMR7JxiJd4qX8X2rLN0cs1nlfmhu9sHt8sa/x5S/vXqweFc
        02B94x1TvUD4RU4s4EUK3aje7BTaBR+5JDyQEVFws4WXpHhqCIFgdK5UifZSe8jnWF42514FySx
        ZZS+e+3RzbSuQ05HZoZRErdNnAuKduMbksVn2Ou08kBfEj1OLjNQl2mUxWUyJqdvpN1OPiOfKTy
        VGRSw=
X-Google-Smtp-Source: ABdhPJwFeayMKFWCMU7/Jn60aBx4kngs6iBv6Aw8W/fGakCaE62W9z44EIv+sa0caIvWoz3jsRv0smxvW9OVvw==
X-Received: from dmatlack-heavy.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:19cd])
 (user=dmatlack job=sendgmr) by 2002:a17:902:6902:b029:106:50e3:b2db with SMTP
 id j2-20020a1709026902b029010650e3b2dbmr7955257plk.35.1622565798266; Tue, 01
 Jun 2021 09:43:18 -0700 (PDT)
Date:   Tue,  1 Jun 2021 16:43:05 +0000
Message-Id: <20210601164305.11776-1-dmatlack@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH] proc: Add .gitignore for proc-subset-pid selftest
From:   David Matlack <dmatlack@google.com>
To:     linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        akpm@linux-foundation.org,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This new selftest needs an entry in the .gitignore file otherwise git
will try to track the binary.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/proc/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/proc/.gitignore b/tools/testing/selftests/proc/.gitignore
index bed4b5318a86..8f3e72e626fa 100644
--- a/tools/testing/selftests/proc/.gitignore
+++ b/tools/testing/selftests/proc/.gitignore
@@ -10,6 +10,7 @@
 /proc-self-map-files-002
 /proc-self-syscall
 /proc-self-wchan
+/proc-subset-pid
 /proc-uptime-001
 /proc-uptime-002
 /read
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

