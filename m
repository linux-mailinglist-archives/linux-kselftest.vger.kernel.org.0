Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944F16F8142
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 May 2023 13:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjEELJA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 May 2023 07:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjEELI7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 May 2023 07:08:59 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B8218DFA;
        Fri,  5 May 2023 04:08:58 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-2fa0ce30ac2so1522387f8f.3;
        Fri, 05 May 2023 04:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683284937; x=1685876937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Egg8JLOnnpq+lsDJAxwILwTlZTsXYBB4sQaBEoTtEhA=;
        b=K+9tlciuQ0YsQdelmaHJvbYoj6zxrRfGHGXm3U7n5dVc4Q5lEchsQbhc1DM51GZoCk
         R7Sj36dxB26xue851hVw7HN01OOnypGXU96PW94M2aN4FjpmBIkNGnkSa9xUPDce/NxA
         cBzj7I6vjGZKsXYsXTdPAHpF8hxKXc4wqL2HKf3c/GRA9UoJjgnC6ljaQ0H9Fs+NbqCO
         unR+iO7qDdWhS8HtVFydJUH0cyiCyGio3mFFF3BIUbiAGl10Bck5foe3yv4cTiVOP5VN
         X+AeBy4kb1uaCV3OEhLsbQyy8MTL0FHAhO9z1JXAW0gANQDCxmnEN1Bi5KOts+XAYy19
         plCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683284937; x=1685876937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Egg8JLOnnpq+lsDJAxwILwTlZTsXYBB4sQaBEoTtEhA=;
        b=P6A82Kg1zFrlKEYgq+XfmHliezLqgTA6mbcUox7nENWJHhHCIVaQ47Tc8ZdpC13Gzw
         Ua7aEEIDvUJ0/MxtQVGAl0iAj1HIfLqyBu9qaVP8Mj+tzjbqTwGpggCpSVbflMjzPdws
         vwinBEAVpcTTqw/w7oRHLshduz6dDJlxu8No0SaT4qsz6rCEBd6KYhS7swfaj1mbHeH5
         q/AJbjuXZirbuuVBYtoNA+58Y+NjmSXS6060ZJmh/y9l2/c+dlcEch2pftVHGSyy/kyI
         9w/DvLII7CkkxqftbDr0dxhKwHURi8r9tPUN2lzcHE3Cfh/gsiBmRh5juteA6mrxyUUN
         JrgQ==
X-Gm-Message-State: AC+VfDzKQ0DJmA14w9Hg5SDLIfAAUl5t/YPxshbHckVnDA0dGgbEGcKm
        QcCBPRSvrVY02KplIgwIvQnOZPX8iXw=
X-Google-Smtp-Source: ACHHUZ4pBXYp+e7KXBdE2OE1qLBdbPVLsr7cqOsE/3NymtwG27Sz4Wj2SD+mYkflle4zi7W599TqjQ==
X-Received: by 2002:adf:ce91:0:b0:2f8:ba03:6dec with SMTP id r17-20020adfce91000000b002f8ba036decmr1112374wrn.20.1683284936900;
        Fri, 05 May 2023 04:08:56 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o5-20020adfeac5000000b003065f2a8a63sm2067130wrn.27.2023.05.05.04.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 04:08:56 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Nhat Pham <nphamcs@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests: Fix spelling mistake "trucate" -> "truncate"
Date:   Fri,  5 May 2023 12:08:55 +0100
Message-Id: <20230505110855.2493457-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is a spelling mistake in a message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/cachestat/test_cachestat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
index c3823b809c25..9be2262e5c17 100644
--- a/tools/testing/selftests/cachestat/test_cachestat.c
+++ b/tools/testing/selftests/cachestat/test_cachestat.c
@@ -191,7 +191,7 @@ bool test_cachestat_shmem(void)
 	}
 
 	if (ftruncate(fd, filesize)) {
-		ksft_print_msg("Unable to trucate shmem file.\n");
+		ksft_print_msg("Unable to truncate shmem file.\n");
 		ret = false;
 		goto close_fd;
 	}
-- 
2.30.2

