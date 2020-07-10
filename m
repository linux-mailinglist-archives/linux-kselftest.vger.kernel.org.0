Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCE221C043
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jul 2020 01:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgGJXBM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Jul 2020 19:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgGJXBM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Jul 2020 19:01:12 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF58C08E6DC
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jul 2020 16:01:11 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id o1so2854043plk.1
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jul 2020 16:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=plPGzTPn8qeDi7iOgwL0mp+ouaTZyfAGNQFOzP+7U8Y=;
        b=AVULz8YcPhjFqumFxyE6EiQFOzyKP8WlXfdL8dzQANxCxMos6i3W1g9dfcVE2XpITO
         EmnvAfNht4K5U63zDffx2pmWCMA8kTSCUTCxYzKVJhlKI6JOMmmk5sXZsTLA1TPAtdfz
         pF+uQrs0ajxDHBOA39ovBlWQX/K2UsWE52Q5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=plPGzTPn8qeDi7iOgwL0mp+ouaTZyfAGNQFOzP+7U8Y=;
        b=TojkaAUCTJTREo2XcOl2YAzgusy8l2gG7n8Arf5AkKPSD4e9k3YF76UeYzITYUKDfu
         XefzO/I9bSj7TTxcgUkxFuxQyRbslPmlHSVE+lT6Me+QbUDcqyANPANocAqw1+Fa/ZIN
         Brv5IoFtGpGC9SN4qqCQdjT+mG/rMhanghIs4Mjm5R4zuBOkrjr2VLQ3lzIIRGATTaqz
         l2gw+jvhAx066gwiX564bmtRhDgJk3Q+Hzash7GsUUmw3p0wM69Lix2L2X7esySOjjhy
         N+1sA09cTUZjMYraJ426Cszp2+skdSFdjzZTPT+5UKvXnullVyR4UhagFjQ7t+DIc7DD
         LruQ==
X-Gm-Message-State: AOAM533/4h8LWEggeH5eRj+zvnwtQsjUMPOcau/BGU1K2EKHzgW8Ri6z
        Dr18Y5urTFbRuiOvE7Uh0vN7goTfpJY=
X-Google-Smtp-Source: ABdhPJxJ3IvgLCB287FazX3iXVmDYo+c5ory2weCQWET53H5hMwkWX4TueUomo9YQx2XmgcY8Z6egg==
X-Received: by 2002:a17:90b:34d:: with SMTP id fh13mr7286518pjb.99.1594422071364;
        Fri, 10 Jul 2020 16:01:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b21sm6946553pfp.172.2020.07.10.16.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 16:01:09 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Shuah Khan <shuah@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH for-next/seccomp v2 2/2] selftests/seccomp: Set NNP for TSYNC ESRCH flag test
Date:   Fri, 10 Jul 2020 16:01:07 -0700
Message-Id: <20200710230107.2528890-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710230107.2528890-1-keescook@chromium.org>
References: <20200710230107.2528890-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The TSYNC ESRCH flag test will fail for regular users because NNP was
not set yet. Add NNP setting.

Fixes: 51891498f2da ("seccomp: allow TSYNC and USER_NOTIF together")
Cc: stable@vger.kernel.org
Reviewed-by: Tycho Andersen <tycho@tycho.ws>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 14b038361549..0d29114123fa 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3257,6 +3257,11 @@ TEST(user_notification_with_tsync)
 	int ret;
 	unsigned int flags;
 
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
 	/* these were exclusive */
 	flags = SECCOMP_FILTER_FLAG_NEW_LISTENER |
 		SECCOMP_FILTER_FLAG_TSYNC;
-- 
2.25.1

