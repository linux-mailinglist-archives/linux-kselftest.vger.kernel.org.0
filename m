Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882C7375F9F
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 May 2021 07:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbhEGFKT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 May 2021 01:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbhEGFKT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 May 2021 01:10:19 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0ACC061574
        for <linux-kselftest@vger.kernel.org>; Thu,  6 May 2021 22:09:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u7-20020a259b470000b02904dca50820c2so8736422ybo.11
        for <linux-kselftest@vger.kernel.org>; Thu, 06 May 2021 22:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jSTI64CJ1fjEq5OTPDv3eN3+6glJnRm4XHS+PKPJDqQ=;
        b=JVIXRhcjz7NCzpFAcvQ+vpKLDHmL3+gV0tpn3h+3lYDO6SgFnmFaCx5Aa8B8YGhYQL
         XYbXHEpkJ2BastYVJE5UxO5ocwv+ghKnd6Y5sO6OcjMzAwRGdkvZ19A7NCWJyHTnzsR5
         7Muwz5cO+4J0doAO4LKM/W6Pkd31Emd19Kj/TIINVihz7ASMCUo55GwyPWFxEG1TL9Ce
         DXUxq49XNginaHoHcdFrIMxf8LpSO5TbrSuE9Lnjg28YgClK98Q5V/RYkK0W5jl4tWMX
         Gp+iw9aBR6SZ35PZLiB7tQlwhPLPR5NSVZfed9scnvw81usR4vm1G8RZGcBoGeubfzOj
         WRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jSTI64CJ1fjEq5OTPDv3eN3+6glJnRm4XHS+PKPJDqQ=;
        b=UW4wk2DOhjMy83FFRzdnNiWiqexCgDZS52WHPtVpuLEoI4MUEg0qxst5PR6fsjKKu1
         PgdjVAFbXCnOiEbGN8mPVDbsQhkNzm9zDfla1syTohrgZIhV4TMms+KB8UCEGukNQrwD
         afHu6gMpsrafV2GYEd/z4lgDU0JznqYiNm/BpIcHex9+8pGrgvh6F0wGePtoKVe9dtkY
         BFla1iKcm0CkRmWE8hFWrfBHeyddIbkaSNxNe9nGWbcfNQGatHXAwgRshnxVrGgxA24r
         WKcoEIbCfqkKwWz1IEad0Ud8KSxFodhd9kW1RZm0giubU/6SiRhHit3cESw4U+bIcfLj
         FJ/Q==
X-Gm-Message-State: AOAM531G10RFqn1MeEZLhdTtFbNfZyKJ8VDpMUiLC36ehcKIvwOZHqmn
        3J7+ivDCX25NQ0FXoz48vo4Z6rWnhrH/lA==
X-Google-Smtp-Source: ABdhPJy9tq8jPJY+ebhUXAl3EcvJ1PKeKQVZ9aWvrBWOFDSB3qbryOjP9jS6yOfytiqDVbXjWXm6HbciSaRB5A==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:7a7f:ce22:a6af:49e5])
 (user=davidgow job=sendgmr) by 2002:a25:cacd:: with SMTP id
 a196mr11407255ybg.296.1620364159507; Thu, 06 May 2021 22:09:19 -0700 (PDT)
Date:   Thu,  6 May 2021 22:09:07 -0700
Message-Id: <20210507050908.1008686-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH 1/2] kunit: Do not typecheck binary assertions
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The use of typecheck() in KUNIT_EXPECT_EQ() and friends is causing more
problems than I think it's worth. Things like enums need to have their
values explicitly cast, and literals all need to be very precisely typed
for the code to compile.

While typechecking does have its uses, the additional overhead of having
lots of needless casts -- combined with the awkward error messages which
don't mention which types are involved -- makes tests less readable and
more difficult to write.

By removing the typecheck() call, the two arguments still need to be of
compatible types, but don't need to be of exactly the same time, which
seems a less confusing and more useful compromise.

Signed-off-by: David Gow <davidgow@google.com>
---

I appreciate that this is probably a bit controversial (and, indeed, I
was a bit hesitant about sending it out myself), but after sitting on it
for a few days, I still think this is probably an improvement overall.

The second patch does fix what I think is an actual bug, though, so even
if this isn't determined to be a good idea, it (or some equivalent)
should probably go through.

Cheers,
-- David

 include/kunit/test.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 49601c4b98b8..4c56ffcb7403 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -775,7 +775,6 @@ void kunit_do_assertion(struct kunit *test,
 do {									       \
 	typeof(left) __left = (left);					       \
 	typeof(right) __right = (right);				       \
-	((void)__typecheck(__left, __right));				       \
 									       \
 	KUNIT_ASSERTION(test,						       \
 			__left op __right,				       \
-- 
2.31.1.607.g51e8a6a459-goog

