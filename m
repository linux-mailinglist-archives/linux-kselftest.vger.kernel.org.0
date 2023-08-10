Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FA0778227
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 22:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbjHJU1C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 16:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235841AbjHJU1A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 16:27:00 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655A22723
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Aug 2023 13:26:59 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bc5acc627dso10196625ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Aug 2023 13:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691699219; x=1692304019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7VqWk9TlJRT8ykwWsdvSnZzCfxI5F9cpgpLcByRA+sY=;
        b=K6Xr+JpfP3xNnjYDhY0dK5WU16CS3QdsDehTrDhfKyWhlQr9Ju/mj540r6Y+bgal7r
         Iu8tF0uh1VerGPWpO5/wmQxvZkh8iK1gyky0YbGqEnpkyPiNkPHdIw5lKML5Pok1+I7a
         XPeKJAL5CSpLJAKuJCFlHYDzyBBWqVnVMzUfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691699219; x=1692304019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7VqWk9TlJRT8ykwWsdvSnZzCfxI5F9cpgpLcByRA+sY=;
        b=dLpazX/brCaoLW1Da6xev+RVQ43Icxw73/cuLKW8yRVRWvfkjhmLuTWXGSkb1/JPjj
         tR5gYgOiaIvy6Bmz0FHW00W+5T2Qf/Vy+sL/005GyUnGujJusgzXzCRwUspndW1Oc7d9
         6cGnqP7L/7HVlXQsN5y+k3/Xy7CwfJ3QkvqpbJv1tlPiXlxlITzL2zbQjpsG+JQyXaNr
         sGC6KyDrCaH50burQcsA0wjM4ZS4MgrjMQb+NyLYGSDY6FJPwPF88wMmj8KNnfNRa4PH
         mRufA/F72JRtRCvdTHa+qh2bPnlMKttqXOue5+hHHxK5cym4+E9VTQRCL27GYJ5HDv4o
         K8ZA==
X-Gm-Message-State: AOJu0Yyd2rsyFb3gBbaVYw6k7HwsmLvF4u/JobhhMSZXh9RJ3CuNNBC5
        N103uuYrSm+s/Dw8886GWCrOBA==
X-Google-Smtp-Source: AGHT+IFgOcyEjd2Q4OTHrM/7gs8YLxs3o0idMAJRHLTXxcQ2zXZGYP1++8Hj+FJQ5dwHLcBJL9Zu0w==
X-Received: by 2002:a17:902:d3cd:b0:1bb:5b88:73da with SMTP id w13-20020a170902d3cd00b001bb5b8873damr2990326plb.61.1691699218904;
        Thu, 10 Aug 2023 13:26:58 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k3-20020a170902694300b001a98f844e60sm2183276plt.263.2023.08.10.13.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 13:26:58 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org
Subject: [PATCH] selftests/seccomp: Handle arm32 corner cases better
Date:   Thu, 10 Aug 2023 13:26:56 -0700
Message-Id: <20230810202653.never.932-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2014; i=keescook@chromium.org;
 h=from:subject:message-id; bh=CLpz6EOfRrbHfxs+DW+QOBPRQnZKfWBS9qhYDrihYZA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk1UgQGhY779bsGNZZQsbavTn3fuJhNl9tmHaJi
 pe/oTK88q2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZNVIEAAKCRCJcvTf3G3A
 JuJ/EACTcQ+/SL8NKJMeMFthsYqig1wZP1bL6BwiogHpMrhrE4JVzTccWGM8XLHbP63E9NyJdTG
 CbifBfVw4Q2qw1VXKAvuSpkN6uSsMv4s3/BosmYE5yEu4i608R2SQMqm1ifN1U1ovAAYvXxVXY4
 mEy+5TG5jPr/3XZrHHgf7ygankQSzS38Na8mfcmebpJfZweX8kDy8Zew6h2tSG09wMBoAlirQEt
 K2TKbjN/dhB2e906M3h7tHIXjIH8gThBwY+4s6o+DI5vhpDjT/6ETxNgaAK9wmXNCyP2v+o3GBL
 hscos8jzbMZ4QJ/+1PCtSgY7j2PzQmbNzr/wDgkA/LSuAVhL58isbFkaIrHmgXPHd6IDjiaEXR5
 Vr7pR97vDB1V6HJ5lHg9kZShcr1TABvwit/h/O5anJXH2Aer12Ng1kHn9m+2buZI5tYjvB8gicC
 JJg/zttnHUhUwzKUKUk3wlToFm9Czbj+vraJF+kexBjCW+DPUS0l6Oa6JPjElLKe5BrrUhTlyBN
 3LLd16WA4HhAwVyVlq6vm2gbEUUeXthpn3hm6b/JxOULzY/vOxkMGjjbKalbsRof+RKDJPz6vM5
 cYVUoyL+rap+LF2B7gOhxuHz9zwF4EvwPoQ4wd4snZlGZ/T6NlRz3bHc8/4DkmejD6OCLSsBxS6
 UCCv7P2 xUDMYFGA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It turns out arm32 doesn't handle syscall -1 gracefully, so skip testing
for that. Additionally skip tests that depend on clone3 when it is not
available (for example when building the seccomp selftests on an old arm
image without clone3 headers). And improve error reporting for when
nanosleep fails, as seen on arm32 since v5.15.

Cc: Lecopzer Chen <lecopzer.chen@mediatek.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index f6a04d88e02f..38f651469968 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -2184,6 +2184,9 @@ FIXTURE_TEARDOWN(TRACE_syscall)
 
 TEST(negative_ENOSYS)
 {
+#if defined(__arm__)
+	SKIP(return, "arm32 does not support calling syscall -1");
+#endif
 	/*
 	 * There should be no difference between an "internal" skip
 	 * and userspace asking for syscall "-1".
@@ -3072,7 +3075,8 @@ TEST(syscall_restart)
 		timeout.tv_sec = 1;
 		errno = 0;
 		EXPECT_EQ(0, nanosleep(&timeout, NULL)) {
-			TH_LOG("Call to nanosleep() failed (errno %d)", errno);
+			TH_LOG("Call to nanosleep() failed (errno %d: %s)",
+				errno, strerror(errno));
 		}
 
 		/* Read final sync from parent. */
@@ -3908,6 +3912,9 @@ TEST(user_notification_filter_empty)
 		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
 	}
 
+	if (__NR_clone3 < 0)
+		SKIP(return, "Test not built with clone3 support");
+
 	pid = sys_clone3(&args, sizeof(args));
 	ASSERT_GE(pid, 0);
 
@@ -3962,6 +3969,9 @@ TEST(user_notification_filter_empty_threaded)
 		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
 	}
 
+	if (__NR_clone3 < 0)
+		SKIP(return, "Test not built with clone3 support");
+
 	pid = sys_clone3(&args, sizeof(args));
 	ASSERT_GE(pid, 0);
 
-- 
2.34.1

