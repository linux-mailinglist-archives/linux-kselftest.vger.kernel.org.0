Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFDD4445F0
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Nov 2021 17:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbhKCQdZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Nov 2021 12:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbhKCQdV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Nov 2021 12:33:21 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA9EC06120A
        for <linux-kselftest@vger.kernel.org>; Wed,  3 Nov 2021 09:30:44 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id s24so2931549plp.0
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Nov 2021 09:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CFrgwsciqhLigy2EU/AaRm6zFzZu/RmdM4V9EloceVA=;
        b=kC4xV5MjH6bk8I4nye8+YYZO33K6/+6Z/bWF9Txp4X6wgkAFlE0J8Kga7Pf8GNfoi5
         alI3GfSrK1HVOWD0pQg9mNNETqPQG3ptR7FvS/hOk3qwBGJSyZj3hrxzWanQbiHqlRzp
         gqI0x/48tbduRDdBENe8sTqZprAUyuGhlAyzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CFrgwsciqhLigy2EU/AaRm6zFzZu/RmdM4V9EloceVA=;
        b=v2beDYoexyIzSq3rWchKy7oXXGnMYaSkn66I1F/02os+ikt0L8/b8/QITSIUzQugI4
         46QK1UpVcUpXVmeKQYcSnTMvLvinRKIa6GX1REmd8H9YTkIQVkNHlpl12qSAaHBIazNx
         cApYRUXSdQYoyp+Ok3hnndTExwhQd8+0cvAuAEcK3fRfhm64/EwYYJgKTUVs8oKN6lem
         3k62IGzyjL7rdbY+t2V/xtLTB4RF6ohg7Y+wWeeLmNEhTRxd0YtVoBs59HSVY2vrPjJ5
         fQeOOfUUvYe9ZeuK3zfwJ4c2JfLgtUMAhbBLwBlmz56Rqi6YCa8a5PM6GQyYd6PY7WMU
         4PnQ==
X-Gm-Message-State: AOAM530wkYABxWjANzp/SoLt8I0xVvmGNPzxpD4OOVYBzi85tLs10/Fn
        K3H6Np5tqTBOAX334rAaPUb4MeoyoPb+sA==
X-Google-Smtp-Source: ABdhPJwntl7sqqQ2NBbzrrk48f0sWS+yqWMG1/TpRv2Og9bPfhSZEMY+Gd4Y+dpMUoPl3H+9JRKy0g==
X-Received: by 2002:a17:903:2348:b0:141:d60b:ee90 with SMTP id c8-20020a170903234800b00141d60bee90mr24191927plh.15.1635957044320;
        Wed, 03 Nov 2021 09:30:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id pj3sm5868301pjb.18.2021.11.03.09.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 09:30:43 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 1/2] selftests/seccomp: Stop USER_NOTIF test if kcmp() fails
Date:   Wed,  3 Nov 2021 09:30:38 -0700
Message-Id: <20211103163039.2104830-2-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211103163039.2104830-1-keescook@chromium.org>
References: <20211103163039.2104830-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=970; h=from:subject; bh=5SGA6vKk/iwU4HRpuPNInhIqcJf9yybUaBe2IOL9GDc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhgrkuqYShFRe385bb2uQbzI3gBZtUefB10tmQnNTj WC2v2uyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYYK5LgAKCRCJcvTf3G3AJhiiD/ 4hgs0gemdqJuv8tsoUrd/l5QUSScsyFWkKOv1E73CDe+bkMxBVfQ03PAkh6EavU552ourVPL+H+NLq 0LZvSYqP53sGQ3Rq6924Pd5reqIGA0V9DjHr6Sr928rFBF6CyGiUbxrzsp6QXoIaRgJz+Q329EYskF AxKo4Z/upnLxG8wlQbYNqnOZHFQmljScM3PXqe088L/0Hci7l1TpCJfIVjYxLF6h6HFPX6qPfx1tmj /X4CXoz2ucEJy9ZwDHyiWTryA+Y37w21SI8h/tuSlLVnHKRi/zSQcthgSNIJqJvnTp55be27rr42cO Br8U/OY5W05/wr4Jrc3CujYuPAldQXChHw30HIxNYG5/hvPMwtO3/bbws+JfvWFMvj9Krql5mW/ssb f/YvQPXXXDJ39+SxVUNDA5yMh8/mgOb9KbMupFxghWCkCqW7x4TDl5C69mwjrPpNcfrARyy3G8xOhl YDhweHbvvR3KOLizlEKuy+4O9YTezjcznepCizMotBusB/DaCaxlqrPKC44OWer0LY4AV87dQIlWtP +dCfFHcRqEFVlHUJPORDaeHvqhOiH7ktKsO14Bi1KDA5q6h6TeL/HSQ2hPoIr+8ozP2IC4P8JI2lLx qi35wJYNSKkXDYoGtE3R5tfk0eZfEoyUlLJGJn4UEM7OgbXwl16GqYARbeqg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If kcmp() fails during the USER_NOTIF test, the test is likely to hang,
so switch from EXPECT to ASSERT.

Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 1d64891e6492..d999643d577c 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4087,7 +4087,7 @@ TEST(user_notification_addfd)
 	 * lowest available fd to be assigned here.
 	 */
 	EXPECT_EQ(fd, nextfd++);
-	EXPECT_EQ(filecmp(getpid(), pid, memfd, fd), 0);
+	ASSERT_EQ(filecmp(getpid(), pid, memfd, fd), 0);
 
 	/*
 	 * This sets the ID of the ADD FD to the last request plus 1. The
-- 
2.30.2

