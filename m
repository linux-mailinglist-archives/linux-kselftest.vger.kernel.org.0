Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC41214A8D
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Jul 2020 08:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgGEGMl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Jul 2020 02:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbgGEGMk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Jul 2020 02:12:40 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356EBC08C5DF
        for <linux-kselftest@vger.kernel.org>; Sat,  4 Jul 2020 23:12:40 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id o22so10579247pjw.2
        for <linux-kselftest@vger.kernel.org>; Sat, 04 Jul 2020 23:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fPweZ6DZU1ENxuozio/NA02HLt4qwCgCF26PVdwgmUw=;
        b=eHez7mRezl3LRANbjE9V3fYHuiKTipMbrZxyLSQ8DYa+CsUnkd7R93uYjLh8qhclBF
         astTE3wzBXb6w0ko4CNb3iCWSSyKMABzRVflBHuKZATMtETPiDqIYxCGlugWhQxJnQAe
         tcWFVOjHZeqkFFnKprhnoBDKbp1h+KP0S01jU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fPweZ6DZU1ENxuozio/NA02HLt4qwCgCF26PVdwgmUw=;
        b=uS+k4jHU3wBsOJaU4m+K/i0QzT1OpyWK+sTgOPn+HBrDaSBW3MtY1Rb7ioeYuUTZJj
         UudOA4czzdXoIINIs/Ayb0+9OB4hqntTv2zPMf9AIcPLUP2tM5GJ/e/57Mci1y1kttET
         vK64XOUzDq0zPb1R85piQzt2qP59kwoi+spEnoq7HC7kfjcxhasYSmHPYtUkpaPRj8eA
         W0MbgAHyQjpM7EBkHC/QVyjv5xztM2hXvymexxxbBPDoKdAoE0axI2PIVTGF8ZZAWqi8
         hE4+MhLD2Q+tp871J7v+QNfOOxzJ1Qb5uWEcFhI/qMRi2hb88wGxeN7OEAd3u8o/h+Si
         yoEA==
X-Gm-Message-State: AOAM5309a8zgaNCCHUfIlBdx6L4st67tlYUOJAJnxliXBPc/KJy0xfQg
        /S12TV6XJMdoovWnDzCbADqUCg==
X-Google-Smtp-Source: ABdhPJz3fz9uNnH3pm1N5xpLDXk919zAKiGqawBuegK156HeIrG5riLllTgK7fEcIVuXZxaN1UTCSw==
X-Received: by 2002:a17:90a:c5:: with SMTP id v5mr46527588pjd.192.1593929559801;
        Sat, 04 Jul 2020 23:12:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n62sm5275663pjb.28.2020.07.04.23.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 23:12:37 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Oleg Nesterov <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] selftests/seccomp: Check ENOSYS under tracing
Date:   Sat,  4 Jul 2020 23:12:32 -0700
Message-Id: <20200705061232.4151319-4-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200705061232.4151319-1-keescook@chromium.org>
References: <20200705061232.4151319-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There should be no difference between -1 and other negative syscalls
while tracing.

Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: Will Deacon <will@kernel.org>
Cc: Keno Fischer <keno@juliacomputing.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 966dec340ea8..bf6aa06c435c 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1973,6 +1973,32 @@ FIXTURE_TEARDOWN(TRACE_syscall)
 	teardown_trace_fixture(_metadata, self->tracer);
 }
 
+TEST(negative_ENOSYS)
+{
+	/* Untraced negative syscalls should return ENOSYS. */
+	errno = 0;
+	EXPECT_EQ(-1, syscall(-1));
+	EXPECT_EQ(errno, ENOSYS);
+	errno = 0;
+	EXPECT_EQ(-1, syscall(-101));
+	EXPECT_EQ(errno, ENOSYS);
+}
+
+TEST_F(TRACE_syscall, negative_ENOSYS)
+{
+	/*
+	 * There should be no difference between an "internal" skip
+	 * and userspace asking for syscall "-1".
+	 */
+	errno = 0;
+	EXPECT_EQ(-1, syscall(-1));
+	EXPECT_EQ(errno, ENOSYS);
+	/* And no difference for "still not valid but not -1". */
+	errno = 0;
+	EXPECT_EQ(-1, syscall(-101));
+	EXPECT_EQ(errno, ENOSYS);
+}
+
 TEST_F(TRACE_syscall, syscall_allowed)
 {
 	/* getppid works as expected (no changes). */
-- 
2.25.1

