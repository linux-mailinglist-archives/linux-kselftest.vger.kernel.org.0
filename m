Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBFA5179B8F
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Mar 2020 23:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388511AbgCDWOX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Mar 2020 17:14:23 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35415 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388509AbgCDWOX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Mar 2020 17:14:23 -0500
Received: by mail-io1-f68.google.com with SMTP id h8so4242346iob.2
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Mar 2020 14:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=slmOLpdIbjI5QyAjKPc7cej/Tzyq5DfvzSm4Ztafae8=;
        b=ecN/elXI6djHnjKOjuizUlbuZJhSwPC5OCKNCufxl/wtlZb8szUY5hv3RZbtDfuyut
         M4EOscKs55/2R2aMEu38z9NkZUDXkprSPuyVva6hc/Fqv2sJKhmgxPzHwYyLCNAQ4Aut
         H5ULfGaZT2Xdfudf09SNt7vsZBWjk9AK8Zk38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=slmOLpdIbjI5QyAjKPc7cej/Tzyq5DfvzSm4Ztafae8=;
        b=Lw82sOu1xNb4Fa9bv5jAxQoUVOSEXJuCeuKFIWvU9np3+4iprbNlsH/A7g90qKPU6s
         tPppjOv/s16eKiK49T+amh/6WVRdrHt08/4pEj6V47mrSrui2ol6SyzIHu19BLa2BRCw
         sagwfOu6m4nXECgXhzRM6e5z96f/SbTJBb+C/4vPUFNIEb5ZG9SV+7TzvktjHJHajw3J
         tqbbtaWKNDlP90QOmAVz1oXKgjX5+mv3j2EMnQ+TFWL6qQvetK6F4UcJ31OqeK6MlQ50
         txi/NJOtLssi1HtDGyUcMXVAIOmB17Xo7Ng7rJvRthTPCei68mDXFkLdujwukw49gCRd
         2XTA==
X-Gm-Message-State: ANhLgQ1ei7D/WeqzikSegjB0AE4XUNsaRN8uruulmqWbdmcfDOiyjhqF
        IKks1yl3NLt64ss9qA0sHwWu3g==
X-Google-Smtp-Source: ADFU+vvtttXCtOoapb1Bl0NcpOGalK4Y39X0zQcS/sDoJw9QE2E2iSZda+0cyiHM4ZSp4ozHIzE72w==
X-Received: by 2002:a6b:9245:: with SMTP id u66mr3907500iod.110.1583360062502;
        Wed, 04 Mar 2020 14:14:22 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g12sm6850409iom.5.2020.03.04.14.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 14:14:22 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, gregkh@linuxfoundation.org, tglx@linutronix.de
Cc:     Shuah Khan <skhan@linuxfoundation.org>, khilman@baylibre.com,
        mpe@ellerman.id.au, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] selftests: android: ion: Fix ionmap_test compile error
Date:   Wed,  4 Mar 2020 15:13:34 -0700
Message-Id: <bc4a7fd417e1f76c3dfba387962d5ed74464e9d8.1583358715.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1583358715.git.skhan@linuxfoundation.org>
References: <cover.1583358715.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

ionmap_test compile rule is missing ipcsocket.c dependency. Add it to
fix the following compile errors:

..android/ion/ionutils.c:221: undefined reference to `sendtosocket'
..android/ion/ionutils.c:243: undefined reference to `receivefromsocket'

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/android/ion/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/android/ion/Makefile b/tools/testing/selftests/android/ion/Makefile
index 0eb7ab626e1c..42b71f005332 100644
--- a/tools/testing/selftests/android/ion/Makefile
+++ b/tools/testing/selftests/android/ion/Makefile
@@ -17,4 +17,4 @@ include ../../lib.mk
 
 $(OUTPUT)/ionapp_export: ionapp_export.c ipcsocket.c ionutils.c
 $(OUTPUT)/ionapp_import: ionapp_import.c ipcsocket.c ionutils.c
-$(OUTPUT)/ionmap_test: ionmap_test.c ionutils.c
+$(OUTPUT)/ionmap_test: ionmap_test.c ionutils.c ipcsocket.c
-- 
2.20.1

