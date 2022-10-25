Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537E360C179
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 03:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiJYB75 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Oct 2022 21:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiJYB74 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Oct 2022 21:59:56 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585542339E
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Oct 2022 18:59:56 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id f23so9996595plr.6
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Oct 2022 18:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vCTfchUZqB6jq/TQwhEC0qTFQwNSnjako4vxTuNBHps=;
        b=mq5wg6Oi6vToYD+lUfiVoRg8mhQA1WOxf9EiC7ZzquGBqlKhQWe1inmBr8xFb0iOl+
         Mmur1SU8lx9nXLx0ZGdzzXuiGmCJ/y5xUERrN289nGwfjmPL8LYOPlDEEp+UVs+eEe7f
         /94inQMu5LvZfD5doofvBITGKvMoR0wmGP0BSPLedtYk0qmenuJSbd56HeGYa0+883Au
         Phz4WUiott+cehYXsmXocfA0M62eRi9V4AlKaFlwbaCqT52Bfm2O8HaHYc6eO04P97np
         r6DKMVPda495gja3vo1ySV7L9dYAOZZRVZOYtV1XuKtBDik3F+MeItP2dPK1Hu5TS449
         O1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vCTfchUZqB6jq/TQwhEC0qTFQwNSnjako4vxTuNBHps=;
        b=06jQTij0JHD+YGc52IXUMQ2B0NVEF0m5uedxJDsDYGSuPTfRAGfYCaC8KwJI5J3vuN
         TuRuY5xNN6E9b6NMi9T1PV+OzzQts0scXYvBzKPuKxi8qeEC7OaNNXK2SYhkgas9+zj9
         CezEKtZVoieqXnfHWWA/Qo/lauu1MBoP/NT3Lwuc9mua/pDfMLrwcwR7ZUkDhRi+LBh/
         vT7Y0Syh0yElGEj/pJg/elWPjc++EPeDOSVbATleKTOmNE9Srs1pNfwrPa/i2k7hw78v
         73U1V2Q/lxdupzl2xMLLJtz7HmWRe+peu89XJW9GXxXiE2/utrEoSPRNGxr3YekOivQo
         W2ig==
X-Gm-Message-State: ACrzQf1ilWzc2ItQH06fwdVKcxNKwD1N3jOAIGSnuXWhYW2kvc833rBW
        7zfhgSpjZMn2ezq4ddH8s1s=
X-Google-Smtp-Source: AMsMyM6HCFpKXCtyWx8bFu0hQV/hAUWeOtqNgXLKdqlhDOmP332WYfV9Eue/fIkJ8Rjf08SLGh7rmg==
X-Received: by 2002:a17:902:7897:b0:178:9292:57b9 with SMTP id q23-20020a170902789700b00178929257b9mr37064692pll.102.1666663195800;
        Mon, 24 Oct 2022 18:59:55 -0700 (PDT)
Received: from ubuntu.localdomain ([1.221.137.163])
        by smtp.gmail.com with ESMTPSA id q4-20020a17090311c400b00186b549cdc2sm328830plh.157.2022.10.24.18.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 18:59:54 -0700 (PDT)
From:   "YoungJun.park" <her0gyugyu@gmail.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>
Cc:     David Gow <davidgow@google.com>, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, "YoungJun.park" <her0gyugyu@gmail.com>
Subject: [PATCH] kunit: remove unused structure definition
Date:   Mon, 24 Oct 2022 18:59:46 -0700
Message-Id: <20221025015946.3186777-1-her0gyugyu@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

remove unused string_stream_alloc_context structure definition.

Signed-off-by: YoungJun.park <her0gyugyu@gmail.com>
---
 lib/kunit/string-stream.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
index f5ae79c37400..72659a9773e3 100644
--- a/lib/kunit/string-stream.c
+++ b/lib/kunit/string-stream.c
@@ -131,11 +131,6 @@ bool string_stream_is_empty(struct string_stream *stream)
 	return list_empty(&stream->fragments);
 }
 
-struct string_stream_alloc_context {
-	struct kunit *test;
-	gfp_t gfp;
-};
-
 struct string_stream *alloc_string_stream(struct kunit *test, gfp_t gfp)
 {
 	struct string_stream *stream;
-- 
2.25.1

