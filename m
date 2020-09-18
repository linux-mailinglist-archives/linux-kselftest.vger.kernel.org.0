Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F77F270420
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Sep 2020 20:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgIRSc1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Sep 2020 14:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgIRScM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Sep 2020 14:32:12 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2530CC0613CE
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Sep 2020 11:32:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v106so6383673ybi.6
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Sep 2020 11:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=4ufz9l0cCzYsCoL4r8GDrSIfCJnmy8gI1393Dh+Rmy0=;
        b=gDr8SX0KFSof3ETP10gZupoFduQgqaPI99rHGbDjuBM8Gbb5fSKkoVPowjgLhGuGej
         18awEJF8MKVAhlVwtFJzbS+JlJBF7l/zj27KETQuv35X/QgqO5w3iKEI1QPd4DB1gsKx
         hq5Y5NheUrI4kS3JZSVcABnsdGvan9KtjLJd5EWWQ0JteT+TRiU6T2fRLXLm/YvjQFUg
         +wuXvUmLse8ZQ5k8XndeLKHAwApIIUWmJI0Xf50EnDl53mL/yleeS+C3+nEXIxym9kyj
         2LB80b+xFatQkgJfTORws0mQDHYCu1bg571LIN+GFiHWsMMB49vSNqI5Hr7EYNYPHNJH
         xCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4ufz9l0cCzYsCoL4r8GDrSIfCJnmy8gI1393Dh+Rmy0=;
        b=bIJzcwZzVbleNx44nZ4wz1ZFVNOBA8Mo+pB4fEwslYDjzUK0W5RV0b1x8snGq8O2Lp
         e8uTqJKvTdwdiL5eeCSTJGpJv1sfmlLStybTeAepgjSV4eEED5hEDR0oPK37qyU2TKjR
         ePeSt8m6+adYvpqXtPCBydaFI4R3HN4kAvVw+wyfYNRa8+OgirVcsJnONljL7iuylER2
         VeqIlXeMN4ixNnIT2iZZebnO3dPZkVEAKVtKQri3UginW3TkCJooTgrR9QcUjvPxzBJz
         zCohtXkO1EY/GPB+gRZzTTpxVxA7mOHZu6pjGGu2MYoogCw8uWDyvyGnGjFM90aAUDH1
         wh8w==
X-Gm-Message-State: AOAM5301U5I7krpng/9DhvmJQs+1YckiPR2pg2q6qOklbZPKQ3l5VhJz
        4G9vLJPyJV4Vg8x9HkI5hfCCR64T7rVzXg==
X-Google-Smtp-Source: ABdhPJyAluzyfa0U446HFUAVXW6a9HYsuxaYq7Q2k1km1l9MpCq1TNrLdsb174tXI9pMbjsb1BJvhZb6Y87KEg==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a25:5346:: with SMTP id
 h67mr14433285ybb.420.1600453931272; Fri, 18 Sep 2020 11:32:11 -0700 (PDT)
Date:   Fri, 18 Sep 2020 11:31:11 -0700
In-Reply-To: <20200918183114.2571146-1-dlatypov@google.com>
Message-Id: <20200918183114.2571146-10-dlatypov@google.com>
Mime-Version: 1.0
References: <20200918183114.2571146-1-dlatypov@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [RFC v1 09/12] kunit: mock: add macro machinery to pick correct
 format args
From:   Daniel Latypov <dlatypov@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

Note: It was unclear if there was existing code that could be reused.

This is used by DEFINE_MATCHER to generate matching funcs for primitive
types that don't trigger compiler warnings.

After preprocessing, we now generate matcher func code like
  kunit_stream_add(stream, "%p not > "%p", actual, matcher->expected)
as opposed to the hoping %d will work for all types.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 lib/kunit/common-mocks.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/lib/kunit/common-mocks.c b/lib/kunit/common-mocks.c
index b3a410fda63a..1f755f26cf5f 100644
--- a/lib/kunit/common-mocks.c
+++ b/lib/kunit/common-mocks.c
@@ -42,6 +42,27 @@ struct mock_param_matcher *kunit_any(struct kunit *test)
 					    matcher);			       \
 		}
 
+#define TYPE_FRMT(type_name) FORMAT_##type_name
+#define FORMAT_u8 "%hu"
+#define FORMAT_u16 "%hu"
+#define FORMAT_u32 "%u"
+#define FORMAT_u64 "%llu"
+#define FORMAT_char "%c"
+#define FORMAT_uchar "%c"
+#define FORMAT_schar "%c"
+#define FORMAT_short "%hd"
+#define FORMAT_ushort "%hu"
+#define FORMAT_int "%d"
+#define FORMAT_uint "%u"
+#define FORMAT_long "%ld"
+#define FORMAT_ulong "%lu"
+#define FORMAT_longlong "%lld"
+#define FORMAT_ulonglong "%llu"
+#define FORMAT_ptr "%p"
+
+#define CMP_FORMAT(type_name, msg, op)                                        \
+	       TYPE_FRMT(type_name) msg " " #op " " TYPE_FRMT(type_name)
+
 #define DEFINE_MATCH_FUNC(type_name, type, op_name, op)			       \
 		bool match_##type_name##_##op_name(			       \
 				struct mock_param_matcher *pmatcher,	       \
@@ -55,12 +76,12 @@ struct mock_param_matcher *kunit_any(struct kunit *test)
 									       \
 			if (matches)					       \
 				kunit_stream_add(stream,		       \
-						 "%d "#op" %d",		       \
+						 CMP_FORMAT(type_name, "", op),\
 						 actual,		       \
 						 matcher->expected);	       \
 			else						       \
 				kunit_stream_add(stream,		       \
-						 "%d not "#op" %d",	       \
+						 CMP_FORMAT(type_name, " not", op), \
 						 actual,		       \
 						 matcher->expected);	       \
 									       \
-- 
2.28.0.681.g6f77f65b4e-goog

