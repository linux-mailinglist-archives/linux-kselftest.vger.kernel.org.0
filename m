Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2135369C93C
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Feb 2023 12:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjBTLEU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Feb 2023 06:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjBTLER (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Feb 2023 06:04:17 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3C11422A
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Feb 2023 03:04:06 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F3A8C3F582
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Feb 2023 11:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676891044;
        bh=PQ/e3yix0m9X8IeKW6PjCOf86G2Z7hFs9Ie/f4F1ppE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=jARpOUNcIkLbXx9McVsaMufnktMVBZesAkUzUBOVEN0IMN41a5c58sfuIqthfoMOq
         ZfU1aGNrM3D1vFWejdxmBKq9srfxMt8vLTQrwiBX2MawLUDlGnDC9XP7IfmabQMflC
         hlCieqzZsdETvHLbRhLpsfCWcjXKz/Pwxaeb7ihBHfrrUmNfNR2oOE7uyb95a4qaVE
         TVt0fuJHohthe3S2HkCqYI8R2qq/+OU6uhThyratA6YtIlRNkTtl3WwnNm+K1Wp5gc
         dsDtNujVGPnoKGxc6Cc3FafYz+BkCabw6yFkN7wdOKNdx4ERKxhYdn6tADaur5c/2x
         KU3rlRefGTtyQ==
Received: by mail-ed1-f72.google.com with SMTP id eg35-20020a05640228a300b004ad6e399b73so470918edb.10
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Feb 2023 03:04:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQ/e3yix0m9X8IeKW6PjCOf86G2Z7hFs9Ie/f4F1ppE=;
        b=fKYR3iCT2Mm5vzQhYzRJvP2AHUmASRt2NnZwgCMLEiC77SM0bzlujZvEi13T6ITVUq
         A7JwIzMmUYofr3l6wW+zzXXmxeXOQRAu76oqIRDDHxNzlktrAK1lfC4ue47RGeOMToBF
         nzMYGwt+q4nu2iIvV2y//zhxJg7hTi2PPx9Ulnd2zCwjY2RYV5gQPpripYiDXO03RTMa
         lxxOGdy7YDbvqdwNG09r67qcc23zQ7c34gnszfkJcZR8mCiS755TA2KSvYtE4igGiWK0
         mywYsVSev28xkfmKHfNs49XCJA6adWk7yI895DgbSaG9KskfivdF56SdrivBKTz6WP9v
         //Sw==
X-Gm-Message-State: AO0yUKW65nn+s6ksKOC66q0j7pkO3gl+Am/VOxARKAHpdjr1D14VF09G
        khQyjldcS28uIfj61gC7k5+KR/FQ/fuwmZLYhE4q36DwWofWPL0KzNc5UwrVhXr5Bi5z7EzNUuO
        hSK7yLs781QyP5bEqBr6BIyBKMxV48N5qPK1/3+sp0pjJIw==
X-Received: by 2002:a17:907:6e87:b0:871:dd2:4af0 with SMTP id sh7-20020a1709076e8700b008710dd24af0mr11742887ejc.26.1676891043832;
        Mon, 20 Feb 2023 03:04:03 -0800 (PST)
X-Google-Smtp-Source: AK7set9K9DWYKm6njTRouQU2LGApclEmMni7DIBij60SxRmB3n34Dr/nplqD3hOHz76k2PwAFJ+yyQ==
X-Received: by 2002:a17:907:6e87:b0:871:dd2:4af0 with SMTP id sh7-20020a1709076e8700b008710dd24af0mr11742867ejc.26.1676891043606;
        Mon, 20 Feb 2023 03:04:03 -0800 (PST)
Received: from work.lan (77-169-125-32.fixed.kpn.net. [77.169.125.32])
        by smtp.gmail.com with ESMTPSA id b11-20020a1709062b4b00b008b147ad0ad1sm5582552ejg.200.2023.02.20.03.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 03:04:03 -0800 (PST)
From:   Roxana Nicolescu <roxana.nicolescu@canonical.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] selftest: fib_tests: Always cleanup before exit
Date:   Mon, 20 Feb 2023 12:04:00 +0100
Message-Id: <20230220110400.26737-2-roxana.nicolescu@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220110400.26737-1-roxana.nicolescu@canonical.com>
References: <20230220110400.26737-1-roxana.nicolescu@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Usage of `set -e` before executing a command causes immediate exit
on failure, without cleanup up the resources allocated at setup.
This can affect the next tests that use the same resources,
leading to a chain of failures.

A simple fix is to always call cleanup function when the script exists.
This approach is already used by other existing tests.

Fixes: 1056691b2680 ("selftests: fib_tests: Make test results more verbose")
Signed-off-by: Roxana Nicolescu <roxana.nicolescu@canonical.com>
---
 tools/testing/selftests/net/fib_tests.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 5637b5dadabd..70ea8798b1f6 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -2065,6 +2065,8 @@ EOF
 ################################################################################
 # main
 
+trap cleanup EXIT
+
 while getopts :t:pPhv o
 do
 	case $o in
-- 
2.34.1

