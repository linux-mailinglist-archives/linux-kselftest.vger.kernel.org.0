Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B170445AC7
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Nov 2021 20:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhKDUA2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Nov 2021 16:00:28 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:34958
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230438AbhKDUA1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Nov 2021 16:00:27 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 689393F1D0
        for <linux-kselftest@vger.kernel.org>; Thu,  4 Nov 2021 19:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636055867;
        bh=0pnSsWOy8eqTzq7zuU561UzcloXsqaxFF9Ie3eNk/ec=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=YkTF8fHB1M9SCbTOEdwsp7T0ANeFuotRA0su04X8G4cLHlB9hpHfOGGxivujs8hdf
         oG8fim1K+75OTL9NQx/3yEOfZV9EvVIRd0bmuht7ZogZRG/Gqd6GxdYDlCI0PzEQr1
         ubKbU8/YSEN5uWNW0t8QiW4d5TQBZYG4vnN+UD9tLB8Hl/yNSx5+SO09lPh3rtYXoR
         +XUfAwXf4FIfHoD7Wz/H/tS4/gRuFMWaFmgDxr+tB1u27MpaAiuOrubfcNTLa2TI1a
         1Ai0LiYk8PTxxKAhSzGDUgj/WbV1TVYaCB88YLE4cnDiRkfYjyoMDkJ7hxWNNiGG9J
         vAsuQhzD8hisQ==
Received: by mail-pl1-f197.google.com with SMTP id y13-20020a1709029b8d00b0013dc7c668e2so3903820plp.16
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Nov 2021 12:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0pnSsWOy8eqTzq7zuU561UzcloXsqaxFF9Ie3eNk/ec=;
        b=EuIcChweRbxionJulJ/DHquIjrknsS3ZFx/RB/UIdHZkxz55fgSHnXtWK4tRKhAMPP
         ZshUiAVODOUC47YhseeBQUWn2ZNMtpl+zBAL7SfzO+EQh3r8HGBKlzCDUy9HnZEURMd2
         mMlDamMTSzf/m6RJOxnUSXHIH1Yr5oLbxwywRS9z09d3JFmuja3PIY+Top+D75r9Yo7p
         fBjTxWLfga61YimiqTgqU8DeZpPLG8RpbR5QfovXe6UoxqAImoHWXsths0gqV8GjKphE
         aJvu1/r4Rh1FFhZcycvikQXJ/8fqm8VQDVykDL5KZs6vwHtLCW28iG4y4ImJMjHURToY
         jXbg==
X-Gm-Message-State: AOAM532Iyax0P6kjTlwOnHp29mALK27WxLEkR73Y4A0deX9JPqqDNsIt
        3sZaGH9IiRBbUQ4HP05Sfa5ZqZRFlPXImNvk4Fsm6mFoVQkCi5EX4E6WOJndVYxClvSn2WRbgHg
        QIk1tGgYcmdGe6p9SW7Ab1zoSsOo/2aqSVx2fCl9USeubDA==
X-Received: by 2002:a17:90a:49:: with SMTP id 9mr24753812pjb.80.1636055865843;
        Thu, 04 Nov 2021 12:57:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7wB2r2Re/P/FePo0Awpnri6iPWwgGRRfBJT3nRIg5DxZhTBI+76ib7euJSTdTGOeNeMie6Q==
X-Received: by 2002:a17:90a:49:: with SMTP id 9mr24753792pjb.80.1636055865666;
        Thu, 04 Nov 2021 12:57:45 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-66-27-118-101.san.res.rr.com. [66.27.118.101])
        by smtp.gmail.com with ESMTPSA id p3sm5458700pfb.205.2021.11.04.12.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 12:57:45 -0700 (PDT)
From:   Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To:     shuah@kernel.org
Cc:     keescook@chromium.org, luto@amacapital.net, wad@chromium.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/seccomp: Unconditionally define seccomp_metadata
Date:   Thu,  4 Nov 2021 12:57:00 -0700
Message-Id: <20211104195700.20724-1-luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There are conflicts between glibc system headers sys/ptrace.h and
linux/ptrace.h that can likely cause seccomp_metadata not be
defined depending on what version versions are installed, leading
to compile errors.

A solution to make this test more resitant to these system header
differences is to rely on defintions inside of the file by
unconditionally defining seccomp_metadata and removing the
linux/ptrace.h include where a defintion of seccomp_metadata
exists for certain headers.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index d425688cf59c..67e2c3c001a0 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -26,7 +26,6 @@
 #include <sys/ptrace.h>
 #include <sys/user.h>
 #include <linux/prctl.h>
-#include <linux/ptrace.h>
 #include <linux/seccomp.h>
 #include <pthread.h>
 #include <semaphore.h>
@@ -171,12 +170,12 @@ struct seccomp_data {
 
 #ifndef PTRACE_SECCOMP_GET_METADATA
 #define PTRACE_SECCOMP_GET_METADATA	0x420d
+#endif
 
 struct seccomp_metadata {
 	__u64 filter_off;       /* Input: which filter */
 	__u64 flags;             /* Output: filter's flags */
 };
-#endif
 
 #ifndef SECCOMP_FILTER_FLAG_NEW_LISTENER
 #define SECCOMP_FILTER_FLAG_NEW_LISTENER	(1UL << 3)
-- 
2.32.0

