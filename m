Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A1E65099F
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Dec 2022 10:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiLSJ4I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Dec 2022 04:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiLSJ4G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Dec 2022 04:56:06 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32636B1A;
        Mon, 19 Dec 2022 01:56:01 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so12456859pjp.1;
        Mon, 19 Dec 2022 01:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cTKkiNJMpOFSsx1JCeP3l8G+Rk8WYwK/ABRWtBWukFU=;
        b=fNK93FQsqBdLmtHBhN0aS5FflWsLrRbFl8eih1AzXBNOTYfhrP/t832X9iem3Xnem4
         M16jNxEAEPJzjbjtWAHZswURdsNSk410HQIjPX82/kT+GWdNnfIlY8SdXw9sozZmWuCI
         Ze3OAojpulo57cov9Xe/BOtQ/nZ9gSn2gFLjxSbVzqKwHzsift264ndAaq6nIszDERt3
         17NDtehjWkssb4EtNJg/TYuYyMRgRou/hHcC8lH/WNhBlaLgqEzSeTPPhAS863j7CfxQ
         lY6UxcEmbr4vC5yZUPvmVvO6k6IFli7J8FUKUrspcB1dUFBngph4Q+VBBEH7NufLUiCm
         trBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTKkiNJMpOFSsx1JCeP3l8G+Rk8WYwK/ABRWtBWukFU=;
        b=LRqDq2ETlPwhXjb0uGGxdIjNmjHMLG9m0EOTskuvXHE9Huf+DtGbeidjIEQ6jxTUIn
         JFupoq/VhDN0rok6lgRLCa/6f7UzCKEvrnmhe4JcYH5p+sGn7dl9qUZ1W7koXM1vJssu
         5GB1KIbwzCpjJ2Vj+ECE3W1qKfxVRAAXzNP+Ec+BaGWca4NI9fy6pxwWNVciXiLMtXDq
         4/uWM3zimPfBgp8e/4jgVlozMc3BycCkdF24WPLzs9fBrLtR+JLoPfdvvw67he1cbHCg
         6ziLvuBSKLLlwvSoD+l9sexPvdncrmLQJWJvSVTQKofh/vZGhwiFtSwmErRxwPZTSpPf
         ooqQ==
X-Gm-Message-State: ANoB5pmMKjIFjyubsj7M6iKKfc7Ra5PZUhnS/Hr3ebH0IklEkBVfwufN
        HhCMS8FsBKEWcWQR45RT0QE=
X-Google-Smtp-Source: AA0mqf4VVb2I5ay9QB6w6a5qmkiUGviVYoFeYMMdKw/Z9d73ve2jPNJSo5QwzW7lVzPiPqb3AnzEYA==
X-Received: by 2002:a17:903:2689:b0:189:5265:a647 with SMTP id jf9-20020a170903268900b001895265a647mr38637186plb.41.1671443760463;
        Mon, 19 Dec 2022 01:56:00 -0800 (PST)
Received: from localhost.localdomain ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id c8-20020a170902b68800b00188f3970d4asm6619540pls.163.2022.12.19.01.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 01:55:59 -0800 (PST)
From:   Like Xu <like.xu.linux@gmail.com>
X-Google-Original-From: Like Xu <likexu@tencent.com>
To:     seanjc@google.com
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: selftests: Install sanitised kernel headers before compilation
Date:   Mon, 19 Dec 2022 17:55:40 +0800
Message-Id: <20221219095540.52208-1-likexu@tencent.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
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

From: Like Xu <likexu@tencent.com>

On many automated test boxes, selftests in a completely clean src tree
will be compiled independently: "make -j -C tools/testing/selftests/kvm".
Sometimes the compilation will fail and produce a false positive just
due to missing kernel headers (or others hidden behind the complete
kernel compilation or installation).

Optimize this situation by explicitly adding the installation of sanitised
kernel headers before compilation to the Makefile.

Reported-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Like Xu <likexu@tencent.com>
---
 tools/testing/selftests/kvm/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 947676983da1..a33e2f72d745 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -202,6 +202,11 @@ TEST_GEN_PROGS_EXTENDED += $(TEST_GEN_PROGS_EXTENDED_$(UNAME_M))
 LIBKVM += $(LIBKVM_$(UNAME_M))
 
 INSTALL_HDR_PATH = $(top_srcdir)/usr
+
+ifeq ($(shell make -j -C ../../../.. headers_install),)
+	$(error "Please install sanitised kernel headers manually.")
+endif
+
 LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
 LINUX_TOOL_INCLUDE = $(top_srcdir)/tools/include
 ifeq ($(ARCH),x86_64)
-- 
2.39.0

