Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3B15ADA18
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Sep 2022 22:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbiIEUVZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Sep 2022 16:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiIEUVV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Sep 2022 16:21:21 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF28F32BBD
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Sep 2022 13:21:20 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id c131-20020a1c3589000000b003a84b160addso7635607wma.2
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Sep 2022 13:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=FWyWHD71T9hAwWWYq5d0qFKEdIZn5y5bu6+nFTnlJ18=;
        b=kh8dbngzih/sg97mPKrnkE9TTOdJ17BlH3Q6YNOGFMJE1IZkgSc5Zao5U8SgFF5d45
         5XIg4Hk6yzc+3r+vIT0/qqEerN7mhEYfGJOmbNdl6/wcnmAcy3GYRaDDrl6FaX/AAH4V
         jgO/8lICaYLgSDMT61jm8+KGdfY/3rsig7IkEWAfjQEaX2n9uQb2GFoHTrQZNYGQhpFd
         fbKPdZmOlIkglmJ0gqB1L0bi9m2ajcSoKv735mVw1fpt7ET/HbArwD2N68Qrvj2eYyEW
         hBTBPvyx5SjCR4SfDZYkrjSYs2JLV6X4HTZmZxpkd3NvSPqidHzE8kZbDuTCd2LyDvmn
         OAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FWyWHD71T9hAwWWYq5d0qFKEdIZn5y5bu6+nFTnlJ18=;
        b=ByDO19AGiPoPttMUDkCLJnIJxzHtdwxO749kTIY5kMJ//QgUort7cZCH3ctayD1Tv0
         YLZvUIBfGu8ftyrqdTxV6YZngfG93dOVJCGVy8rM6G7R1G5Gv5gkS8rxFNeAATfUZES8
         bqRXzn/CNUOjMZ/o0scn6ovmajCx6+UW5STBbbXgfAZ1ilcXd02ky8d1EafWNhQY1Ei8
         k4lVB1pOR+pnIbw4AznpDmhvapZVihep4KOR4N1q4MxAofslCquqSdRA2Y8h43dt9r00
         K+FBQqUOP1II36J23Jx/Xu37FCxM0fX3d1iE3UDrG1Xkn3X+55YLxoWwls0xKkd3z5Ey
         su5g==
X-Gm-Message-State: ACgBeo0OvvwgVYhA13uEi9g5GBfFt9on/4GVLOAln4SpwiVzec7jL235
        hv796IGnh7Mb07TvVA7GgHBYAF3HZGpyWHf6
X-Google-Smtp-Source: AA6agR7qg8y4hTacoHwII015jafdXxUTIcWbZcBE7JDALJ+lxDD1Q5kHn0exomLD5bt8JcBW2bwkDw==
X-Received: by 2002:a05:600c:4618:b0:3a5:f3f0:3a60 with SMTP id m24-20020a05600c461800b003a5f3f03a60mr11519602wmo.11.1662409279430;
        Mon, 05 Sep 2022 13:21:19 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c3b9300b003a846a014c1sm19841272wms.23.2022.09.05.13.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 13:21:18 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 3/3] selftests/.gitignore: Add io_uring_zerocopy_tx
Date:   Mon,  5 Sep 2022 21:21:08 +0100
Message-Id: <20220905202108.89338-4-dima@arista.com>
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

Fixes: d8b6171bd58a ("selftests/io_uring: test zerocopy send")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/net/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index de7d5cc15f85..e17b4f1ad770 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -3,6 +3,7 @@ cmsg_sender
 fin_ack_lat
 gro
 hwtstamp_config
+io_uring_zerocopy_tx
 ioam6_parser
 ip_defrag
 ipsec
-- 
2.37.2

