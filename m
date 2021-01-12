Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14162F3285
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Jan 2021 15:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbhALOCy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Jan 2021 09:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbhALOCx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Jan 2021 09:02:53 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B4CC0617A5
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Jan 2021 06:01:31 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id h16so2409337edt.7
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Jan 2021 06:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x0YUj1+zjl+/xGU2slFlAP8CkLypp1CdWTvlwp1GroY=;
        b=I/9wyV1A3JsKrGZjPBsUfMhP4rl+e+p0AXnUvthIkVW5rIGUCd3nER7MS38cM9xtEa
         oJ7N098+ITPAOTtOn/9A6l05RZVXGMmFdt3QLjvfCDxiOXLIvZaa/0gPBtP1tV84W3Bz
         sce1BPEb2sYrwMR83wNMRX4wZLZ9GdB8ztujvwg6PL83v9t8sV/XNHlC5F84IssFds7o
         XNL7uFWPVjnGo8fJhTy/yk+qscito/aEXYyJGTMUo3q+WScfg35YJ0ZiBmKhd9+J81mp
         emob1lSxntMDSRHQ7c8Ec96ZIMv0H9GCV1AeULAdTaBG/rao6r6bpEEhCVub3+Z2sgGM
         076Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x0YUj1+zjl+/xGU2slFlAP8CkLypp1CdWTvlwp1GroY=;
        b=JppKyHhJlZRW/Eg7d7Z/PL6U9AYmTeiA4GXmvur46rSLlGYQy/XuohrVjTfgW8Za2c
         2OrO6Jx6pR59EtSG0QCyfA87UJfuLtjk/v39leNo0xjVw1U8GArdjPKRzx+ILm9HYzkd
         mGC5qrluk7Pnn+DKezypsL0Ys3NJ1Ff+rAR85qYy65r3oa0g23v53+36l/6sZEiYFcqH
         J4HBYLJQwdGnL44KtQUXtczdecACXJRc+6GE6JtxwItnGbP6Oe8hOi9dzuN8ntq3PsE/
         N1B2BfPyrwQcY+3AZmZazoXnZV/3IsivqgwMPr3OZGl6aUarEEmape/4bjYWqbtZZQYt
         WyEA==
X-Gm-Message-State: AOAM530NmM23I44R6fQ6XaYrT5EKl259ywM9kclV0YE0hg/RsCeQnhSs
        j9z6Sham3NoWOIKoUqPuuk/vhg==
X-Google-Smtp-Source: ABdhPJyXw0Kj8q+RBw0xlDBiAfkrYa6nduRBvyDUPnzluIebbL9pnbrvbwlHWfGZmGNnlUN42X1p4w==
X-Received: by 2002:aa7:c253:: with SMTP id y19mr3471449edo.179.1610460090237;
        Tue, 12 Jan 2021 06:01:30 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id t19sm1227846ejc.62.2021.01.12.06.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 06:01:29 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     bpf@vger.kernel.org
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-kselftest@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next 4/5] selftests/bpf: Fix installation of urandom_read
Date:   Tue, 12 Jan 2021 14:59:59 +0100
Message-Id: <20210112135959.649075-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210112135959.649075-1-jean-philippe@linaro.org>
References: <20210112135959.649075-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For out-of-tree builds, $(TEST_CUSTOM_PROGS) require the $(OUTPUT)
prefix, otherwise the kselftest lib doesn't know how to install them:

rsync: [sender] link_stat "tools/testing/selftests/bpf/urandom_read" failed: No such file or directory (2)

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 046848c508d1..bffb4ad59a3d 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -82,7 +82,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
 	test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
 	xdpxceiver
 
-TEST_CUSTOM_PROGS = urandom_read
+TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read
 
 # Emit succinct information message describing current building step
 # $1 - generic step name (e.g., CC, LINK, etc);
-- 
2.30.0

