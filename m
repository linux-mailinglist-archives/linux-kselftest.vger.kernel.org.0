Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A369DC94A5
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2019 01:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfJBXOe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Oct 2019 19:14:34 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46659 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbfJBXOd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Oct 2019 19:14:33 -0400
Received: by mail-io1-f65.google.com with SMTP id c6so1136843ioo.13
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2019 16:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xvZas5u4F0ANJvTgj3n1e3Kg28XWglgthvIgi7KiUDM=;
        b=OAmzgMLRqJrsm01/oVo0z52yps2KIsjjA0iSxmFhaj0J88TZvinG5qtiC7/sCqrJct
         XrgfqrnXnUfbVHpnU/DQZtmNicYVO9mW/frxnGp5y9Aqp4/NAigNRU873DNLZ4Zvu29D
         LUI0gg2+7ZwzBWUdbPnc7BM6q8a4zpw/xTOws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xvZas5u4F0ANJvTgj3n1e3Kg28XWglgthvIgi7KiUDM=;
        b=R7O5KDHJJCkNznIP5i6JRVVALfJtQ8wHGDlWDmLwwuIZIDp+aP3sWenoY2CvvTxroM
         G9IUaVADbVne3OE5xLKI/SrO0Hris+MUXAxmTrB2Xup7LmGsq8Ox8r5W1XTY4jEI+4MU
         ojK1SdaSe2+HBfgBikNrpkj9E2skkP8F6btH+rkB8A+e2LOo9ifLSL12L7/re4xJ4TMY
         VIj06d0O9D3k/rQPE4/e+Bl4ErtIa+cCLW126LHgcYdS34WRu4Jhqw0hyV4hG8VgqtAA
         RNk1i60XV4IahVuvw4SaWV7B1xUI779FM4ycvZ0d2RaEeNCnmxQdRTLkYAOQMHN9J0Vb
         9Vpg==
X-Gm-Message-State: APjAAAWhjqx3ljLhK0r8tm5GUiPoWS5glYlnaNPmCnHvopM+5wggg5AM
        q9aDvWBB5zHgSpOkt6gAEbI9Ow==
X-Google-Smtp-Source: APXvYqzuqtspnkYcsNldhwxDFk74uox7GnxjgX02w15feBtduAjf6+BWwfmMwuq7uIhWVVekiK+5hw==
X-Received: by 2002:a92:b752:: with SMTP id c18mr7008975ilm.42.1570058072984;
        Wed, 02 Oct 2019 16:14:32 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m5sm259542ioh.69.2019.10.02.16.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 16:14:32 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     pbonzini@redhat.com, rkrcmar@redhat.com, shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] selftests: kvm: Fix libkvm build error
Date:   Wed,  2 Oct 2019 17:14:30 -0600
Message-Id: <20191002231430.5839-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix the following build error from "make TARGETS=kvm kselftest":

libkvm.a(assert.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a PIE object; recompile with -fPIC

This error is seen when build is done from the main Makefile using
kselftest target. In this case KBUILD_CPPFLAGS and CC_OPTION_CFLAGS
are defined.

When build is invoked using:

"make -C tools/testing/selftests/kvm" KBUILD_CPPFLAGS and CC_OPTION_CFLAGS
aren't defined.

There is no need to pass in KBUILD_CPPFLAGS and CC_OPTION_CFLAGS for the
check to determine if --no-pie is necessary, which is the case when these
two aren't defined when "make -C tools/testing/selftests/kvm" runs.

Fix it by simplifying the no-pie-option logic. With this change, both
build variations work.

"make TARGETS=kvm kselftest"
"make -C tools/testing/selftests/kvm"

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
Changes since v2:
-- Removed extra blank line added by accident.
-- Fixed commit log.

 tools/testing/selftests/kvm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 62c591f87dab..7ee097658ef0 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -48,7 +48,7 @@ CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-I$(LINUX_HDR_PATH) -Iinclude -I$(<D) -Iinclude/$(UNAME_M) -I..
 
 no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
-        $(CC) -Werror $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -no-pie -x c - -o "$$TMP", -no-pie)
+        $(CC) -Werror -no-pie -x c - -o "$$TMP", -no-pie)
 
 # On s390, build the testcases KVM-enabled
 pgste-option = $(call try-run, echo 'int main() { return 0; }' | \
-- 
2.20.1

