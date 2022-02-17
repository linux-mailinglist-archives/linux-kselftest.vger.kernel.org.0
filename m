Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D794BAB5A
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Feb 2022 21:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243698AbiBQU5W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Feb 2022 15:57:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243654AbiBQU5V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Feb 2022 15:57:21 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C3B26570;
        Thu, 17 Feb 2022 12:57:06 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 919661F46309
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645131425;
        bh=o3K6tBzoDd9/wUzrBeJx9N/1UIvuvmQGWXMam7COp4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kcl7N0jJOd6xombjhHEZtPPOy7HfPXscpWoPieyMDbxjizt6W/7vKMMsZIWciKKbc
         ujcVO6Ldu2dnrJUdd/RRnzDT6qRaUvnNSUvlUnfZ3DCJVR0EXZVM888asx0ZhMcLs7
         vHA0oLYhgaBpXyuH1RnGxjot+M7CbFpyJQhmk0/+faOgy7yM7E55aLfYaTa7ucyY7N
         9xbiyYA9tSQ9ER4o752nSVTkxZDW1WngjorJ9dCRNhNMq5jsq349BV2wYKp3xmNr0/
         W1N+MCPMb8lyRxKtWxh7nyfGwxiiiFvVS1eRRDQwk3h7z8i+e+28yd2JlwniVSZcLN
         qM85pAYXXo1ZQ==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kernelci@groups.io,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests/lkdtm: add config
Date:   Fri, 18 Feb 2022 01:56:20 +0500
Message-Id: <20220217205620.2512094-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220217205620.2512094-1-usama.anjum@collabora.com>
References: <20220217205620.2512094-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add config option which is needed for SLAB_LINEAR_OVERFLOW test. It
needs KASAN enabled.

Cc: Kees Cook <keescook@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Fixes: 9c4f6ebc3665 ("lkdtm/heap: Add vmalloc linear overflow test")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/lkdtm/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/lkdtm/config b/tools/testing/selftests/lkdtm/config
index adc9fa60057c5..4e8af0f712f74 100644
--- a/tools/testing/selftests/lkdtm/config
+++ b/tools/testing/selftests/lkdtm/config
@@ -7,6 +7,7 @@ CONFIG_HARDENED_USERCOPY=y
 CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
 CONFIG_INIT_ON_FREE_DEFAULT_ON=y
 CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
+CONFIG_KASAN=y
 CONFIG_UBSAN=y
 CONFIG_UBSAN_BOUNDS=y
 CONFIG_UBSAN_TRAP=y
-- 
2.30.2

