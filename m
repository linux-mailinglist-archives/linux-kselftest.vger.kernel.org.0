Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1405ADA16
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Sep 2022 22:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiIEUVX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Sep 2022 16:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbiIEUVU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Sep 2022 16:21:20 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A3212AD1
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Sep 2022 13:21:19 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c131-20020a1c3589000000b003a84b160addso7635580wma.2
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Sep 2022 13:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=qK8g1so1NHgtdfDBp+1lgIp6oz/unpeLonHutdiTva0=;
        b=FGdNc3yo2x2cVa9jFFXEuDe2LubjXj7cm+oe7YZe1o7KViBm5F+RpPm0dwu8aQ+Kei
         jRtpEe58P1bZjRriEVfs1Kcr4Nx1Aw3LPDakdtywK6mWdQQed2QlO3Q6Lvme9tcEX+Bp
         PsqujT/fnB5eIPcZ0IXdtT0+ebF6TMaJ9mSWQqRwwLfDh4CdqQoECNRP4W0Ol0sKc3AL
         o4j6ZHHupFdDd1PgtUXLQ6ZjuMJvTYv7o5kBMyffRLHW+oHP762yqTHJgaq4Tnukw1uW
         LPCcShtxpwIRTrWXawr7cD6Q0MMZkxiz9JOMdiFYX7I62VCBaZxCQseJFvU400LxlFzx
         OCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qK8g1so1NHgtdfDBp+1lgIp6oz/unpeLonHutdiTva0=;
        b=ArGOJTXsuqGF/pNpNc0NMky9RmYjmL7b+AQnwDmUs/KDL02wYW/MGjH2787bo23OMO
         7odjjObC02A7RMOu6QrNW1kKyBrWP7r+ntI3K/a8+iFEXh51bf96Zw1CCRAAsekEJvea
         jJyDnDBLvAr313xpjGWiVYQnl4J2RCbpZDMfd1MZRVwmkSPuUXNMG69Gg9Gj6MqSPkAM
         fIML7HCf6GALjkJQYXIFBhjM6a5dtrL0nQpF16znxHwCBXp3RsNsHjLtdgfwKMmPZtCx
         J2iYL2dk0fQhn49qkXms1jZ3Hf7a4wPa+Z4u3MLwHMdHIXxontdLG+qr7tL0jcqfM/9G
         L4DA==
X-Gm-Message-State: ACgBeo3LiueZ6QFjV91Vuue1U1D+fvCSeCN7jebkxKf8pGIoDp0ILs5s
        Se7YcVePZ9tubGV39/x5pmdqEg==
X-Google-Smtp-Source: AA6agR6diDgtK5K1JSKNLHo44677Ccqyyg3ou9EZwE5V1mI1+MF9uM/sIgm08uDI6rFmXv4Ag4ucVg==
X-Received: by 2002:a05:600c:4ca3:b0:3a6:1616:e591 with SMTP id g35-20020a05600c4ca300b003a61616e591mr11548208wmp.99.1662409278200;
        Mon, 05 Sep 2022 13:21:18 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c3b9300b003a846a014c1sm19841272wms.23.2022.09.05.13.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 13:21:17 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: [PATCH 2/3] selftests/.gitignore: Add vfork_exec
Date:   Mon,  5 Sep 2022 21:21:07 +0100
Message-Id: <20220905202108.89338-3-dima@arista.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220905202108.89338-1-dima@arista.com>
References: <20220905202108.89338-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Cc: Andrei Vagin <avagin@gmail.com>
Fixes: 6342140db660 ("selftests/timens: add a test for vfork+exit")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/timens/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
index fe1eb8271b35..cae8dca0fbff 100644
--- a/tools/testing/selftests/timens/.gitignore
+++ b/tools/testing/selftests/timens/.gitignore
@@ -8,3 +8,4 @@ procfs
 timens
 timer
 timerfd
+vfork_exec
-- 
2.37.2

