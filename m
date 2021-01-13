Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F222F501D
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jan 2021 17:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbhAMQgN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Jan 2021 11:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbhAMQgN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Jan 2021 11:36:13 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF00C0617A5
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jan 2021 08:34:56 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id w1so3927600ejf.11
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jan 2021 08:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jXQ6vMa7f3RRXc70uOmWKXVZ59ITEzz6ydYPgh3UHMU=;
        b=Fs6aFm7FeMEyhEFtBLTnCCPm+UPC7JZRY20GjPnEBNQ0PXAkirddbeguIhxj3rgg1g
         dHfbOhgYsvDN2q4fdgmr4g46+DiDnR+8T2Ef9V4YtSOU9U1ondfDaTGpDxU/B07rdQ5/
         DJtbGcPX304Nyq1IsxCg1YdYLChvlzmdo2zq0M8n5111u4cXTeG1Mxx0jY0yKVeIXzd6
         r3QZMaVuFkZ8v0ChFHBf5CslxlZ2KhrbcP/an0PPA2BTFrba7l/tz22a40QgYfqbHw8d
         zIn8DhVGxXk00DZ5mNb24Y2MxlZukJ7YaMz2nrn6rRsN/Cvk+N2EIen7HctUv7R+hKrc
         HJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jXQ6vMa7f3RRXc70uOmWKXVZ59ITEzz6ydYPgh3UHMU=;
        b=NQnC9C1kjAtP62Le46yatN7Zac5EmMm7s4G8qoiQvb8iGSlz6l0yN4lGl/bqbBdM7B
         OLW+qsMnBDuUiBnxq3S2ZChWjVBGA2bejnntrEVC85KLVnmoDDdpJIZjApgMXjDxahQY
         HSgokRjHZDnA6JbUkhs9jFEH9gc6DI9X1XVmQ+bTWxP0raq5wgJOR5CbaoxjQaOgl7hd
         1r6BWqtRdr6evMj4QTuSjJL0Gh8JWXNmev4rISgrVkFwqX/e4K2fVDR3E3zroF/TAvoX
         AGgrv/WncB5nIRSST/RXIJZJRsC28uhp1rE/yX8OTt/TbgR0kzFak42V1eXFP7lNZPg3
         phSg==
X-Gm-Message-State: AOAM530245/uhXZCZdaV3vz1A037vrtKIZDd0XfPTgfaWGGhIZUlPXX7
        1TC5jjVEoIE8f6lihH0vlu5xOhSbAfjBLg==
X-Google-Smtp-Source: ABdhPJzNuHI7XdRTYgxqmmWaFsNDoP1WAofc8B682yrTxmEVHj14bMrSFLKbrV7oq+fH4/GitlPR2A==
X-Received: by 2002:a17:906:39d5:: with SMTP id i21mr2066874eje.339.1610555695624;
        Wed, 13 Jan 2021 08:34:55 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id g25sm923943ejf.15.2021.01.13.08.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 08:34:54 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     bpf@vger.kernel.org
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-kselftest@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next v2 4/5] selftests/bpf: Fix installation of urandom_read
Date:   Wed, 13 Jan 2021 17:33:19 +0100
Message-Id: <20210113163319.1516382-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210113163319.1516382-1-jean-philippe@linaro.org>
References: <20210113163319.1516382-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For out-of-tree builds, $(TEST_CUSTOM_PROGS) require the $(OUTPUT)
prefix, otherwise the kselftest lib doesn't know how to install them:

rsync: [sender] link_stat "tools/testing/selftests/bpf/urandom_read" failed: No such file or directory (2)

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 67cdf858f01f..0fafdc022ac3 100644
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

