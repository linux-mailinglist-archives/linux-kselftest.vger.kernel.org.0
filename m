Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC5128C4A2
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Oct 2020 00:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388932AbgJLWV1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Oct 2020 18:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388899AbgJLWV0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Oct 2020 18:21:26 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E150C0613D7
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Oct 2020 15:21:25 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id c4so7844172qtx.20
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Oct 2020 15:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=m+wXYoLHV4fcV086/vT+cUUJr23s1Z5LPv/l64PtKCI=;
        b=d7htklom5TFv6EMI3PZltokIliW9RMyvHFmExRX41mok5bQ/YPtG0DS43P6FqJRjkf
         PKmdYO1HDNseK2x6SodFYw6dpaEdCiuI5m1Xowu7+ylmblXVkhQB14RHtXZ8Lxeh15TV
         wdlHucQPL0jHwyX8zhj6zaWmPasMJq6NbvknN5OI88ky7Da/3k2/DwBw0pSK6JOyY31D
         9Z3rW64klIEZM4EixkH9efW6wuSE7Od9vaeWffaA+u+9aPkiJCBLWk/Czxqu41zCswrA
         LN98UYdnOwoD2DChAfebVc5dO8jcYNHCyNlTaYB1x54GyTyHXaAUdQW3wfnL86Eo8TmW
         TiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=m+wXYoLHV4fcV086/vT+cUUJr23s1Z5LPv/l64PtKCI=;
        b=UN3UeZVyMmBj9JnuEZ8VE6WoYzAwL87fy5ooxMUGzsDS9rapvnJirT/8A3YzGWvqP2
         faXyYCS2QlJYxEyzaTeB5Xg6WyBCt1Ab5k9iyu+e9zr+emc1IF8V9LzxzJP4gVGA/H/s
         M8mwJT5k9lhnA2avA179ePGmLq/Lt7+Jo7SvpqzSJwoIRQYmonJ1NfkJJMOrgislcwXv
         6DY+0KbcRMeaOG0tirm7HlBZgeg3/iAA99GHeNtD0p/QrHMRmHUuuUaijmZ4H1mqp08o
         BIpi9AhTDwzUYMm6zNqjzR+/jp7zV3reowrT2ujlPGTPg7sKc3yBgQAR4TLFlu63LY1Q
         8SWw==
X-Gm-Message-State: AOAM532ZXu3WU8+7YqBfZcYOlOFv7TUNGXl4VLAyJO2lJmOTsmvA7FyV
        iLILfTDf4lfmpLZxZx/7HY3DGtUb1spJ4Q==
X-Google-Smtp-Source: ABdhPJz0hdbpme4RcxU2sxTA1uUQP9aATQVz6BRY34uV4A3z60lr9fQwkjBGu5uuB30/E3kCnI0wi7Pwf5Vi6w==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a0c:a085:: with SMTP id
 c5mr28431576qva.30.1602541284288; Mon, 12 Oct 2020 15:21:24 -0700 (PDT)
Date:   Mon, 12 Oct 2020 15:20:42 -0700
In-Reply-To: <20201012222050.999431-1-dlatypov@google.com>
Message-Id: <20201012222050.999431-5-dlatypov@google.com>
Mime-Version: 1.0
References: <20201012222050.999431-1-dlatypov@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [RFC v2 04/12] checkpatch: add support for struct MOCK(foo) syntax
From:   Daniel Latypov <dlatypov@google.com>
To:     dlatypov@google.com
Cc:     alan.maguire@oracle.com, brendanhiggins@google.com,
        davidgow@google.com, keescook@chromium.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, mcgrof@kernel.org,
        sboyd@kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Brendan Higgins <brendanhiggins@google.com>

KUnit will soon add macros for generating mocks from types, the
generated mock types are named like `struct MOCK(foo)` (where the base
type is struct foo).

Add `struct MOCK(foo)` as a NonptrType so that it is recognized
correctly in declarations.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 scripts/checkpatch.pl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 504d2e431c60..b40a68e7bc25 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -796,6 +796,10 @@ sub build_types {
 			(?:
 				(?:typeof|__typeof__)\s*\([^\)]*\)|
 				(?:$typeTypedefs\b)|
+				# Matching a \b breaks struct MOCK(foo) syntax,
+				# so we need to have it not lumped in with the
+				# types in @typeList.
+				(?:struct\s+MOCK\($Ident\))|
 				(?:${all}\b)
 			)
 			(?:\s+$Modifier|\s+const)*
-- 
2.28.0.1011.ga647a8990f-goog

