Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE2F28C4B4
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Oct 2020 00:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389191AbgJLWVx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Oct 2020 18:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389210AbgJLWVg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Oct 2020 18:21:36 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6880C0613D2
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Oct 2020 15:21:34 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id 139so13643475qkl.11
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Oct 2020 15:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=3U+Fcas1apO9zkp2uie6RVp/REzkW4tgtQ1I3cCtcMs=;
        b=dJmMJXFcJsI2IPPVbFmC+XU26TnOljliXdvklavMAECzjqMdwvjfC4zWbJr1MauBff
         sJjeCU5CqPiySsV54uwvkNtdC53TfYsnFVqS6uOEFS3Eg/90jmnkMifYsWYLAxqa2jzv
         o9UAL2cBqCX0i7jorUoTNrRJ+UiZJtXUAShkakjeouNLqo+1KT1SR18MBwV1nQCf3q7w
         NOOiXw2bD3kRzbTNoiGgxl95mVbb74dnq1mmMSoBUmyuByoqv/8ZnoO8zTM8bzR55eVd
         qFAjR4UG5NH/MQvxg+pWtyujFTjG0YxBrupJ/Ki91H3tlTwoS2xIviwjYH7SaQ+ptReg
         Pbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3U+Fcas1apO9zkp2uie6RVp/REzkW4tgtQ1I3cCtcMs=;
        b=miOzDdmT+qVbQZPMhL0yeq7b4B6PLhXyozMDgoO/97cMSm57uu8CGYcrbAEfee2Vbv
         Q1QBerkGC3+N5BAoZ4YyApLEsACNbvrAIP/SJfn/cilvsB9wMIXYvkF/iSxWk/cJN0EY
         0TSp1X66qEnTUav4hRLJ/sAV1ylp+vuHvZVaSM6LfQitWzV5pfJhH4txKnCdR+Atx5hh
         2vnqihUQqrKQukKDRsA9SnhoGck2+bJfnXt6ynKaTTuELjyOc9zvfIaZ/5+W50xbS9bt
         U8r6zBZib9h7T5AvxOAr1ucdgk0jQY+IlUFFkmJw3nIdSkUkJwPJ3EjCKf/l5w9ikeBV
         XMdA==
X-Gm-Message-State: AOAM533sD+d7aawuWk7rya1+PkoWabQMLjJUOxh0e1/zOqBdJQd8h9Xe
        CS5k2TtoKQu4WvuSIFJ7yuzciodgAiRY8Q==
X-Google-Smtp-Source: ABdhPJwM6iK7jt1J3LI/TsIHXw1h9NcHoyJVKzFqrwix5e3p1NooRLAYVvucmAHzQ7HziKz/+InvjUJgTY2+5Q==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:ad4:40c6:: with SMTP id
 x6mr27592944qvp.20.1602541293871; Mon, 12 Oct 2020 15:21:33 -0700 (PDT)
Date:   Mon, 12 Oct 2020 15:20:47 -0700
In-Reply-To: <20201012222050.999431-1-dlatypov@google.com>
Message-Id: <20201012222050.999431-10-dlatypov@google.com>
Mime-Version: 1.0
References: <20201012222050.999431-1-dlatypov@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [RFC v2 09/12] kunit: mock: add macro machinery to pick correct
 format args
From:   Daniel Latypov <dlatypov@google.com>
To:     dlatypov@google.com
Cc:     alan.maguire@oracle.com, brendanhiggins@google.com,
        davidgow@google.com, keescook@chromium.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, mcgrof@kernel.org,
        sboyd@kernel.org, skhan@linuxfoundation.org,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>
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
index 4d8a3c9d5f0f..ce8929157ded 100644
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
 		static bool match_##type_name##_##op_name(		       \
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
2.28.0.1011.ga647a8990f-goog

