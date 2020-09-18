Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848B1270410
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Sep 2020 20:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgIRScE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Sep 2020 14:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbgIRScB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Sep 2020 14:32:01 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A244BC0613CF
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Sep 2020 11:32:01 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 205so5338763qkd.2
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Sep 2020 11:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=8lrYz9+XqmT3DNwQQN81Dm2XDHT7obawXs7obsyAAUM=;
        b=YHk5UEF2zHq+CqvGtomS6PVaGEKk0ZCZLm2obeiC3EPYEa6RPibodtrWWu3OxGtL/i
         fs5c5BCjVAM/tVd7XYs6enAqJBe+rvI+FJVQdizUyiirpGdDZeYsDF+35cndDIM1f7ba
         XcHolyTJqRGRU4rdt2L7Spb72uJTwCKIhOXIZjmN/Jbh4rNBon4KuU8iu44Hx6zOH7u4
         tlYGUr4mGrG2zvfqhCtz9tY9ej2wpWSmseoRgTpBllAYFRqBU/HCIEAuwNewpPnIjdJi
         Xj0vlQZvAzCpCsXS4GyJZOSgPVodRCYwd6/hXRpR0A595+cPdKTGU8tXCpCz6nQ5/bke
         Me2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8lrYz9+XqmT3DNwQQN81Dm2XDHT7obawXs7obsyAAUM=;
        b=pQbd/osEucdtKOskvpYt8qpA9ygFRa1ZRi00lwuMvnXKcQlQsbdch9vgnNfdb7vtxS
         12b6VAb0ekdG52PeDF9hrJ3alqZK30rbUyIREoj4tN5EtCODajS6exYW9XQkMqfGc66X
         oH68YajOcUOJKJZRfwbdIB7NROr6COa8sP5thT+nkMJUABG13SgPxciSwNNB9vs5Qd3H
         1Jlke4kwQtQ8raLGXUidhPS6J2aO1vio5XNkwBGhvAl1lIVAUo9mzFUmsB8NzIBpqaV3
         NUfx0hCg70gzcBwpd4ASErhaDLt4eRtuR6DuPfRv1H6sC76pOAjIr453xvB/46QOf2ZG
         rM7Q==
X-Gm-Message-State: AOAM531JP6Cz25vK0VXahRl8OxIjSlrohTkPL8sFN+xEzXqxihMJZxrf
        L2YgcBTgR8wJ12LcPIyRF9TdaSa1gZj2bg==
X-Google-Smtp-Source: ABdhPJxBwq9XhV3QktoFeTn2knMlvdBKuSi9OTuEaTPjrBRksk85oB8YC0d/iGwkk7KhGwnuO67cGjdRIv3Zjw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a0c:b3dd:: with SMTP id
 b29mr18601200qvf.59.1600453920686; Fri, 18 Sep 2020 11:32:00 -0700 (PDT)
Date:   Fri, 18 Sep 2020 11:31:06 -0700
In-Reply-To: <20200918183114.2571146-1-dlatypov@google.com>
Message-Id: <20200918183114.2571146-5-dlatypov@google.com>
Mime-Version: 1.0
References: <20200918183114.2571146-1-dlatypov@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [RFC v1 04/12] checkpatch: add support for struct MOCK(foo) syntax
From:   Daniel Latypov <dlatypov@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Latypov <dlatypov@google.com>
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
2.28.0.681.g6f77f65b4e-goog

