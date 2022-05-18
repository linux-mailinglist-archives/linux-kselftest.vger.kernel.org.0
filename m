Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C78752C0D0
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 May 2022 19:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240690AbiERRBp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 May 2022 13:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240686AbiERRBk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 May 2022 13:01:40 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168CB56C2A
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 10:01:39 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f8398e99dcso24332497b3.9
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 10:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=21gji5A7fyf+LOH7W7vX2Ngr8AGXxxWBQWpGLTWRGhA=;
        b=GTzkF8O5vkR1Lt+Fnw7LR/ngt2HqSyPnypaoqbXSyP+l0zND+UX2I0KppXnl1YZi6I
         03baXp65KNEbOp+bqVWwVIBpZpkzPzYSrsYgzkjBGT3tSZ1qmttFgx3AwVGDCbEdJ8Nk
         TRVb/htkvdsqFa/k2tSEAefow55INRy1eJMxSjlVtQrpBLjC1y3k6B15D8J+y15khDS0
         3sZ/3NciSAL4YcN5zUE2nW3wbrdeS0l7Y3vSQwU/XD6RNkKP3vR2rqYFzdno8wUK2PBK
         9BCc2PRT+x06Z+qc/Tx+Db/tL9sxXLOz5VyT8X+kLlGTQ3l0efVDXJKBgpDhevgDT24b
         ocEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=21gji5A7fyf+LOH7W7vX2Ngr8AGXxxWBQWpGLTWRGhA=;
        b=kTFd33DvDq4esA1fya9SK3jngRlbcddo3FX5cqu5RmVjFJWNbqycU6VlULgy7SLHLQ
         kAv6nW2KjngBIOnzhVcrmTTpkUK9glbhydrkUVaIV7BuBR/aK/5AKaZyVVc1BQkYOOsH
         ZK6RrQjjsdGsSM+SRp39v5PZb1izJLhAId388ar4kaqHXi2SJ/DmtpQO0xZ+fwK+r4h/
         KXouXpxNaZZyYklBfTmlHgVIu1WEO7uk6cy2beJpSNcADrBfN+3s9Rc4GeMo8kw9qO5G
         sfQ+OkiP3Bl590aSKuIAubF5P5wF9yxpDsqTkpI9BWqv4mCZjmR9WyXzx/csDYDrkt8s
         CiJA==
X-Gm-Message-State: AOAM533QhBK/q9A2PzYqq33rk55XhgBhwCa7Qjp5biWjch2okJYKeTa4
        vrfsuYiRRd7d9NmKeROhDXNswPmn3n6n1g==
X-Google-Smtp-Source: ABdhPJy5L9IdIUF+kc9lONmkwtmBOtrGteA3jV3FIp+O1wzAgxcgJV3U+0y/By+Qa0bPGIbZ2l3+jMPy66fGaw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a94f:2cb3:f298:ec1b])
 (user=dlatypov job=sendgmr) by 2002:a81:2f8c:0:b0:2fe:ed42:21ca with SMTP id
 v134-20020a812f8c000000b002feed4221camr399767ywv.120.1652893298194; Wed, 18
 May 2022 10:01:38 -0700 (PDT)
Date:   Wed, 18 May 2022 10:01:22 -0700
In-Reply-To: <20220518170124.2849497-1-dlatypov@google.com>
Message-Id: <20220518170124.2849497-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20220518170124.2849497-1-dlatypov@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH 1/3] Documentation: kunit: fix example run_kunit func to allow
 spaces in args
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     elver@google.com, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Without the quoting, the example will mess up invocations like
$ run_kunit "Something with spaces"

Note: this example isn't valid, but if ever a usecase arises where a
flag argument might have spaces in it, it'll break.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 Documentation/dev-tools/kunit/running_tips.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
index c36f6760087d..da8677c32aee 100644
--- a/Documentation/dev-tools/kunit/running_tips.rst
+++ b/Documentation/dev-tools/kunit/running_tips.rst
@@ -15,7 +15,7 @@ It can be handy to create a bash function like:
 .. code-block:: bash
 
 	function run_kunit() {
-	  ( cd "$(git rev-parse --show-toplevel)" && ./tools/testing/kunit/kunit.py run $@ )
+	  ( cd "$(git rev-parse --show-toplevel)" && ./tools/testing/kunit/kunit.py run "$@" )
 	}
 
 .. note::
-- 
2.36.1.124.g0e6072fb45-goog

