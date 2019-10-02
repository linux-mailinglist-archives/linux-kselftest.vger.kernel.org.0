Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A759EC9492
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2019 01:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfJBXDr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Oct 2019 19:03:47 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34142 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbfJBXDq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Oct 2019 19:03:46 -0400
Received: by mail-io1-f68.google.com with SMTP id q1so1258532ion.1
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2019 16:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oV/9b2AKj59V2uwPpS7RJHBFX/8QSHfj0AU6FMbpQCA=;
        b=dK+p1sIqIAJ8RGyefAphtb6lEwlpOLd/UkICw4usv/JjWR6t1kHw7a+p1pq3Qsqkj9
         URSJmGJkWDsHaeuLD2TGa7MWq+2juzA/OirywcxzN3IXLaSzy7LVKAXYH0Q+B54Ejfr4
         6PWic2A87QP2n0FYWCnFub7PPs/KIdmW0Lp+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oV/9b2AKj59V2uwPpS7RJHBFX/8QSHfj0AU6FMbpQCA=;
        b=BQBQSekOBCGdt8bJk7Gviifrhbhp7owjsYUpRnPUl5EWkDQOnlfYIkoOIjVJTkP9mx
         9Cyy7JVm9RSvyQbjWIa4Co1P4uH2yQApNJ35iu5OszjdUsn7lupcDUudZSBgwIfGfq1j
         pd3xrW4bqd6zvg1Cchgut/uG0318/sPJFS4fwuOzH3mLpWFyVgaBP5qZtI7WJST7fxD2
         7n5rna6x5slqyk2HVZJfFrDRnu0gT+6GFaaa4n3+HTof9kdQSqRtUvUixD7RMT96GtWg
         dw62a/x7QpusLp1oMgffcVKBEhyfEZOa1cfcLxtni90bTm8JpAiuwQYTuZl6GqON5kCi
         EQHw==
X-Gm-Message-State: APjAAAWEX4Kv3zfOTHsd4pXAaG1TV0fj8OpLtP89RDl0oWVNoGl/Y4/P
        xahXz62ufJUjG63/53YILXtvjQ==
X-Google-Smtp-Source: APXvYqygZWjkzv74/ZqaLQIipRxpUSbpqKXqXE5cRKwBIa0D4JgiRCE/Hg8dKE+sssxzkBGZVNthGA==
X-Received: by 2002:a92:b74f:: with SMTP id c15mr6837193ilm.43.1570057425858;
        Wed, 02 Oct 2019 16:03:45 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 128sm212298iox.35.2019.10.02.16.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 16:03:45 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     pbonzini@redhat.com, rkrcmar@redhat.com, shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests: kvm: Fix libkvm build error
Date:   Wed,  2 Oct 2019 17:03:43 -0600
Message-Id: <20191002230343.5243-1-skhan@linuxfoundation.org>
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
are defined. When build is invoked using:

"make -C tools/testing/selftests/kvm" KBUILD_CPPFLAGS and CC_OPTION_CFLAGS
aren't defined.

There is no need to pass in KBUILD_CPPFLAGS and CC_OPTION_CFLAGS for the
check to determine if --no-pie is necessary1s, which is the when these
two aren't defined when "make -C tools/testing/selftests/kvm" runs.

Fix it by simplifying the no-pie-option logic. With this change, bith
build variations work.

"make TARGETS=kvm kselftest"
"make -C tools/testing/selftests/kvm"

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/kvm/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 62c591f87dab..02d20aab9440 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -48,8 +48,9 @@ CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-I$(LINUX_HDR_PATH) -Iinclude -I$(<D) -Iinclude/$(UNAME_M) -I..
 
 no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
-        $(CC) -Werror $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -no-pie -x c - -o "$$TMP", -no-pie)
+        $(CC) -Werror -no-pie -x c - -o "$$TMP", -no-pie)
 
+#
 # On s390, build the testcases KVM-enabled
 pgste-option = $(call try-run, echo 'int main() { return 0; }' | \
 	$(CC) -Werror -Wl$(comma)--s390-pgste -x c - -o "$$TMP",-Wl$(comma)--s390-pgste)
-- 
2.20.1

