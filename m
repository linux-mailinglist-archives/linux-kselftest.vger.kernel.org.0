Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D92C4779A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Dec 2021 17:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbhLPQuv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Dec 2021 11:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239688AbhLPQuu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Dec 2021 11:50:50 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A2CC061746
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Dec 2021 08:50:49 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id c4so45299870wrd.9
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Dec 2021 08:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pJRqVurWv/xPXVPfg9RJJPd9MELUol7kDVQDIoB29M4=;
        b=j11Nk8Sqnke5x2cKuVDNGRjjHdUv65mw61hzMSDPnxhKxKjz9QpmvRbTOAP7PT0Qj4
         lRXxMRjip+9dtbSJwULLTlpd8uQFObXQRsWQK8/SkwknGd8VnKGckm/sWIgoysHaC/Z8
         HdC4fr9IHtl+IEBfF+F9+H/3xJPYuVVbF95I7BezfRE6DXptsOftO9AhzQ6zL24dejmq
         jSJY9DN376cNEDYkyJoBYBC9NY7VYUdMQyBdZH/81RjvIU84Yl1ebNqL7SVO3KFoofjN
         8moq9RwIwng4+LkWkIyMunWctj6e/4mQi717khuAB1ziYwlG6OJGS4YONFdZQtSx0VUB
         j5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pJRqVurWv/xPXVPfg9RJJPd9MELUol7kDVQDIoB29M4=;
        b=r1TwzHqN7XAjtSZfXlHx3pJBBNaSW7LzDmKIqqmUudVGJujy4cKQ4O9i5G604bK/Py
         Ay/5hCD5yWIlSYFoadiFICAzErY85qqZ/3yikbEu7Uy5bf8XiovPsiI6sHRA0geK0CWs
         MFaOug2CuuC1907Y+DsHFYo+5ckwAR1tHWi6L1rMgD09pmroOTqX4i2oXyjhaXqa0bMU
         jX9ha7iR3stjilOYouQEkB/t9VfJdC6z4HrhjaS4CpO0BTgYC+AZgfVyBA0rzR1Wp/r+
         0VTFSUV4Ug2PHim4MPLDBMY04DbL96rCuj+oMXKEKWb444VPXJDJycR27DKTn/B7oQ0w
         bKMQ==
X-Gm-Message-State: AOAM531pcay7r9HVODa9J65QyBK3n0ciRXDoTygAqlWwFG5Lz0e3CCo+
        47714I3RLG7tSCWid6epGCsB7w==
X-Google-Smtp-Source: ABdhPJxzwdAAnWi1SsHBCOcf33UW6I563gS8lB7I43K9co91J+vPwBcD4O7ZqVJpBGGrEwajiLNvbw==
X-Received: by 2002:adf:f708:: with SMTP id r8mr10213612wrp.198.1639673448266;
        Thu, 16 Dec 2021 08:50:48 -0800 (PST)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id y15sm7438906wry.72.2021.12.16.08.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 08:50:47 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        shuah@kernel.org, nathan@kernel.org, ndesaulniers@google.com
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        quentin@isovalent.com, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next v2 2/6] tools/resolve_btfids: Support cross-building the kernel with clang
Date:   Thu, 16 Dec 2021 16:38:39 +0000
Message-Id: <20211216163842.829836-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216163842.829836-1-jean-philippe@linaro.org>
References: <20211216163842.829836-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The CROSS_COMPILE variable may be present during resolve_btfids build if
the kernel is being cross-built. Since resolve_btfids is always executed
on the host, we set CC to HOSTCC in order to use the host toolchain when
cross-building with GCC. But instead of a toolchain prefix, cross-build
with clang uses a "-target" parameter, which Makefile.include deduces
from the CROSS_COMPILE variable. In order to avoid cross-building
libbpf, clear CROSS_COMPILE before building resolve_btfids.

Acked-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/bpf/resolve_btfids/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index 751643f860b2..9ddeca947635 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -19,6 +19,7 @@ CC       = $(HOSTCC)
 LD       = $(HOSTLD)
 ARCH     = $(HOSTARCH)
 RM      ?= rm
+CROSS_COMPILE =
 
 OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
 
-- 
2.34.1

