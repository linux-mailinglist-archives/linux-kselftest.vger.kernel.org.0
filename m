Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCA950D53D
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Apr 2022 23:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbiDXVSn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 24 Apr 2022 17:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbiDXVSl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 24 Apr 2022 17:18:41 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF8213CD2;
        Sun, 24 Apr 2022 14:15:38 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w4so18231441wrg.12;
        Sun, 24 Apr 2022 14:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QLCz1aEPZpTPZGtnpY3lHtJPFa6xwSRJK3O6rkL3K5c=;
        b=aCkTg93Kczt9m6C0yGFdto0l0p1yyEUzTPppKeDoSVWvQRERuAsM6KmuUbXV13pnrF
         Ftxp6eK8GcyYBiLbl79e3Aao75qo+6/wUyemedovZToO9dx4TnDZvHCJdAn4SsMdj+0w
         43Xy7RxetQ3kuPR0H6+b6N6I+BZy+6oAMaEyQaq8LYkSrZSnz/4A0uk40HrtJi1dBoBV
         uwjC5VmshX7W0tC9pnXXxII6dXgfSb449cYLqRo8yeZRsfnPheAA0fz4bODERkiWLdyt
         ZfVirEV/P7A+iSmK46RivLw7mjB2mRseKAOkACDdzq71CY2aM0TgbXnJFauYlZPYbYAZ
         ufxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QLCz1aEPZpTPZGtnpY3lHtJPFa6xwSRJK3O6rkL3K5c=;
        b=B41/ExnDz+bCJgtnJ286vQHoRTE97YWmsSXeA8REh/SdtOelTQnphyzZwmp0CuxNSK
         30GJYJ3K8Vw7fBZaUXrioXOe64NxBq6qvFAgfi5vU23OwmPmDHhlCk9skXkG9z9VJfhA
         5C9DOXOKLPnfzViNqSOLfVLdS6Qm3AUj9aYqZfczhSHGz/IiJGoH4VYcqC5PoEATi4NL
         vuvH79VLiRuzMIA3nk5gIMrUM6coSv07qtdbOuVaRGv4MDQ5icnX2KuUCb5MPuRtUuY1
         dBKOjVhCGTisGkCba65cKfSzg/UNAYFxvobgiTjaf4yMBFc8shNQFA73ChMdJADgVEs0
         N2lg==
X-Gm-Message-State: AOAM531orNzzFAJOMQva5OHLJNbivpZ8zSRHUCPBEUJmJiIqjOoyLyxj
        te1x3RoCE+F/hgjnMXJUFPY=
X-Google-Smtp-Source: ABdhPJz/FOFaeagHS5EO2XRc0+fKcdVmCWhnmahvPolqKQRCXrZWtIDoi0pRkc8kI5dw3Gh1Fp25tg==
X-Received: by 2002:a5d:6d0d:0:b0:20a:d741:6949 with SMTP id e13-20020a5d6d0d000000b0020ad7416949mr4522984wrq.312.1650834937597;
        Sun, 24 Apr 2022 14:15:37 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bi7-20020a05600c3d8700b0038eb78569aasm9571468wmb.20.2022.04.24.14.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 14:15:37 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>, Babu Moger <babu.moger@amd.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/resctrl: Fix null pointer dereference on open failed
Date:   Sun, 24 Apr 2022 22:15:36 +0100
Message-Id: <20220424211536.1373878-1-colin.i.king@gmail.com>
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

Fixes: a2561b12fe39 ("selftests/resctrl: Add built in benchmark")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
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

