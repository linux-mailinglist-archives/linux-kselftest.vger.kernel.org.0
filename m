Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DEF50FCD9
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Apr 2022 14:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348809AbiDZM2o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Apr 2022 08:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245146AbiDZM2m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Apr 2022 08:28:42 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3596666AC9;
        Tue, 26 Apr 2022 05:25:34 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id y21so11099303wmi.2;
        Tue, 26 Apr 2022 05:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AEGDxEoZo4Owm1HQ+h+bYb/0LtcFO1Dwja4aXVPVeOE=;
        b=iwLyqGtidwR4gF1oF0MSpetu/hE/KigWy9ZiBW3FhLFPnVcCGv7nc3W58WS+tCNgr8
         2lnYmmkS0dBw4gjOBu67C02VFF5/Bv1ERcP5J+fMpSyJiT254cdKVNRluh2k4kluLVFz
         RhYC6xO/O88/sb+H+8O38JTlfidJ3CmYuoTDhjv22cTaqK54t0iS7O15R6ixYzcHO3Lt
         J9lttcMeLhP3iqgIAdvSJO3PrH7tBQ99lWsh7fCGFOpZhtPOaU1BsoxfwSekS36iyS7T
         L+tvhg9ExbA88vmpERVYPoOWC2IM0AK/OzcP+1cThYZpNxCmhPuJu890lXZqqumjJH28
         r1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AEGDxEoZo4Owm1HQ+h+bYb/0LtcFO1Dwja4aXVPVeOE=;
        b=EQ/jXWxeLN/+vx4Hkl6CiIbLTYK6/Q3YI5otIaavJDFnPQXIDbQ8h+0IQ0UuTKunPX
         raELdtHj6PhGWSK71AaDeoJISmOfBci9C09BtOQfw+FUyGwYElsA/qq5JDR6G81auIEr
         ECkg/u4NCrvaDHsVnP/FVV+mOnvYThGlxVzK+3opABh8h9DcH6BPjq9Hn6lSMTh5OClb
         0we3OxASmgoFlI37qNFqiIoCgh7C0P4iQBUBd92YZ4P/MvGuZfXtzVx68oSUxDK4ZWja
         qgngczgnUXxAwKBhy/fEUCE/Z49QY3uaB89P3hv9Ne3168VAYnhUaZzhcxbwnt9NMMXo
         FHKA==
X-Gm-Message-State: AOAM532sFb2bsGTipjSS8dlrAlRLTLmJKvwDb6mnLn4Rf1xzdYIGmqiK
        vI1PiBUKOVqqCK8bTd2hZ/s=
X-Google-Smtp-Source: ABdhPJwWzZt/8S2psE8et87L+MMPxiSEMyaRtYt7FZ21rmoYGjJxFMtbPsGM8oc2Rp1taF5F0mWt5w==
X-Received: by 2002:a05:600c:3c86:b0:392:990b:ae29 with SMTP id bg6-20020a05600c3c8600b00392990bae29mr30016938wmb.105.1650975932670;
        Tue, 26 Apr 2022 05:25:32 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id c13-20020adfa30d000000b0020adc82de11sm4848195wrb.26.2022.04.26.05.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 05:25:32 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] selftests/resctrl: Fix null pointer dereference on open failed
Date:   Tue, 26 Apr 2022 13:25:31 +0100
Message-Id: <20220426122531.1506634-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Currently if opening /dev/null fails to open then file pointer fp
is null and further access to fp via fprintf will cause a null
pointer dereference. Fix this by returning a negative error value
when a null fp is detected.

Detected using cppcheck static analysis:
tools/testing/selftests/resctrl/fill_buf.c:124:6: note: Assuming
that condition '!fp' is not redundant
 if (!fp)
     ^
tools/testing/selftests/resctrl/fill_buf.c:126:10: note: Null
pointer dereference
 fprintf(fp, "Sum: %d ", ret);

Fixes: a2561b12fe39 ("selftests/resctrl: Add built in benchmark")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---

V2: Add cppcheck analysis information

---
 tools/testing/selftests/resctrl/fill_buf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 51e5cf22632f..56ccbeae0638 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -121,8 +121,10 @@ static int fill_cache_read(unsigned char *start_ptr, unsigned char *end_ptr,
 
 	/* Consume read result so that reading memory is not optimized out. */
 	fp = fopen("/dev/null", "w");
-	if (!fp)
+	if (!fp) {
 		perror("Unable to write to /dev/null");
+		return -1;
+	}
 	fprintf(fp, "Sum: %d ", ret);
 	fclose(fp);
 
-- 
2.35.1

