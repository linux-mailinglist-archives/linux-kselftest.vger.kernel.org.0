Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6087B4369D7
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 19:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhJUR6W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 13:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbhJUR6V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 13:58:21 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19CAC061570
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Oct 2021 10:56:05 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id s3so1657679ild.0
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Oct 2021 10:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NIb28jF9myhlHii521Fi0CnKe3S439N9mgqsB6OzrQ8=;
        b=Vqv0+pNvyRpRjKj7UdIrKSR2qBY9wFtJnM6i6fUi4B7RfS3eTjyorUo2UfqVZnL2Er
         Gwnmmd1+P/dhgpVRTerixbgXYbj1l+VRRa9TtOVGzIS3MHbHhlQj7xBTzzP4Fc6IPDIM
         5ev/tvmqsfwz7IHLFeWUlRzDg+gKDpJ3wIMTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NIb28jF9myhlHii521Fi0CnKe3S439N9mgqsB6OzrQ8=;
        b=6AD1iMAZccofzrhN81+mjHAD9zmEo5SGxqtUpzgNKMGFJLgGV8vkC9eIltaSeL+Xln
         I9YDokHYR0yjAquLbn783RV90FTpFJPZXYfeJJHw4liJd1s8vauqfSI/dp0RN5YeN7RS
         /B4IXeRZSp/IfbNg78luptwbN14Uw/1iPUC0Bc1lkGslIMl8+xrg6zEpPri0WwfXGqY9
         6GDDamsneTsXXnSs5ZXtZgTOgJPRks4gDSL03lMgX363FtupX+Ea36BrIomkSzctk7/r
         cbtZxJeEjkL/dAcxD8bTXteEddwvsaS+G3dvMITlxMqJBPFpzBVtYEaV00ZWr9xZpsRG
         KRXQ==
X-Gm-Message-State: AOAM5313v0/2wUifFcI0mmQALUZ8vbBa8lX7UC7Sqa8gK1EilMI0Gf9M
        ZkwnHEbd4Bs7GhWFylEWHqS99Q==
X-Google-Smtp-Source: ABdhPJyzIUMx6SkKLw5EjpXmNVNI136gxC++lNpOVzgsGneg+Co6eDrOuIdS5bAy2jGysdSmYswXnw==
X-Received: by 2002:a05:6e02:14d1:: with SMTP id o17mr4620494ilk.57.1634838965135;
        Thu, 21 Oct 2021 10:56:05 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n3sm3201743ili.37.2021.10.21.10.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 10:56:04 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     pbonzini@redhat.com, shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests: kvm: fix mismatched fclose() after popen()
Date:   Thu, 21 Oct 2021 11:56:03 -0600
Message-Id: <20211021175603.22391-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

get_warnings_count() does fclose() using File * returned from popen().
Fix it to call pclose() as it should.

tools/testing/selftests/kvm/x86_64/mmio_warning_test
x86_64/mmio_warning_test.c: In function ‘get_warnings_count’:
x86_64/mmio_warning_test.c:87:9: warning: ‘fclose’ called on pointer returned from a mismatched allocation function [-Wmismatched-dealloc]
   87 |         fclose(f);
      |         ^~~~~~~~~
x86_64/mmio_warning_test.c:84:13: note: returned from ‘popen’
   84 |         f = popen("dmesg | grep \"WARNING:\" | wc -l", "r");
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/kvm/x86_64/mmio_warning_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
index 8039e1eff938..9f55ccd169a1 100644
--- a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
+++ b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
@@ -84,7 +84,7 @@ int get_warnings_count(void)
 	f = popen("dmesg | grep \"WARNING:\" | wc -l", "r");
 	if (fscanf(f, "%d", &warnings) < 1)
 		warnings = 0;
-	fclose(f);
+	pclose(f);
 
 	return warnings;
 }
-- 
2.32.0

