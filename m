Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2AB8BD360
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2019 22:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388910AbfIXUPB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Sep 2019 16:15:01 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41525 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfIXUPB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Sep 2019 16:15:01 -0400
Received: by mail-io1-f68.google.com with SMTP id r26so7618590ioh.8
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2019 13:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DI0egddMaTlmXPpI6j4ITK90qBcGxWnZ/Lc990IvF2Y=;
        b=JTMndQ+nYpdyNF5MJOGWUHZv+QevSaM0HzuyG4IdtM+xtvoSK1XA6X5CBcgkwcsFmA
         3GUTDUHSWAunyQPQX5jfxq+rvzj+h6POMg142essaWiGeLpd6xri8wEzS2VNPNctGHcg
         +xxXg9XTK7XRkzjGWbajAgkQlVoz2vQx7NuKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DI0egddMaTlmXPpI6j4ITK90qBcGxWnZ/Lc990IvF2Y=;
        b=Qx8mlxHS75WiI1QLIrb9BHrb5/0nnahR8JTJp1Bki0oMD9eGPMrWA9KmFoMcewlVdV
         DOBWmP35LFYPRlXB4vZ9Yz6WwmrVdrgvAhUqITnyh1cRBsK8+iQR+iOj7dEj7ouIuLTY
         7bLSVBJOhsBPMhWWlVoHv4w5xZ2f5Vcth2ISWueTiy9H/2zOdbBRT3MwMIzIfEvJag8d
         1NKglSpyXWc1s4V0VlUBLa4TAZmZOMygL18MClSboy9Cxs0WO1xUwRu9o1De69xDh0Yc
         Ta5mEkl+v9RiWXHWdt6V7nOjcy2rYjgP0CArN1hWdHQDu3rJBnUo4efJFKBpMIRbduKF
         4+mA==
X-Gm-Message-State: APjAAAXG6Tof7bpURHyNRQmWathXcXSqL1rJbr+G74wee2bAK/JQdExf
        9fkF0OPhCQWd952cpQ6WuTamhw==
X-Google-Smtp-Source: APXvYqxn6tRAr9RxU9eibq7Mfj2KW3OBHKsrpfR/gHKH+DusHXd6HU+er1lZb6yRz3aWg8YmGuURRw==
X-Received: by 2002:a02:cd8d:: with SMTP id l13mr744030jap.138.1569356100138;
        Tue, 24 Sep 2019 13:15:00 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b24sm2007733iob.2.2019.09.24.13.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 13:14:59 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     pbonzini@redhat.com, rkrcmar@redhat.com, shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: kvm: Fix libkvm build error
Date:   Tue, 24 Sep 2019 14:14:51 -0600
Message-Id: <20190924201451.31977-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix the following build error:

libkvm.a(assert.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a PIE object; recompile with -fPIC

Add -fPIC to CFLAGS to fix it.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/kvm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 62c591f87dab..b4a55d300e75 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -44,7 +44,7 @@ INSTALL_HDR_PATH = $(top_srcdir)/usr
 LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
 LINUX_TOOL_INCLUDE = $(top_srcdir)/tools/include
 CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
-	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
+	-fno-stack-protector -fPIC -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
 	-I$(LINUX_HDR_PATH) -Iinclude -I$(<D) -Iinclude/$(UNAME_M) -I..
 
 no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
-- 
2.20.1

