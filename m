Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593B97B0949
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 17:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjI0PuK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 11:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbjI0PuA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 11:50:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9D327D5F
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Sep 2023 08:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695829727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7eHWlFiucdq0IfNiQ7WXj2KUdARtYTii9zK/Td8/6q0=;
        b=TnJIK7WgFt/xz1YrvWVy9Op0lekte718dk95zL2Q/V/6n/3KqukoFl0cdkakp4eo8jFdTz
        tcVax6FXwhcHbaCJ7awfA/TqQM0uf5DFFvf4YUMSyD3HlxOjpuCQIHHGXPGzxiaTVCLs80
        ubO5KqMVSkRf+LsNX0lZttleeeT2y+8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-qjQa3XnWMEW2HIkn1i91LQ-1; Wed, 27 Sep 2023 11:48:43 -0400
X-MC-Unique: qjQa3XnWMEW2HIkn1i91LQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-65b23c40cefso72493226d6.1
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Sep 2023 08:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695829722; x=1696434522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7eHWlFiucdq0IfNiQ7WXj2KUdARtYTii9zK/Td8/6q0=;
        b=R+4NwV3DQmC44W9M26mQ+G+jX3Sr1EGRutTbpl7nRAT3FK/KMyWYIhvkIjcPLjE44l
         O8X0aT3yusF2toZp5Y8jhg7fUBYtUjnquqbYoc2MUtbQ5q+CyNdybk39hoftrfrCY83P
         b6HGTN0JzBq2BF6HN8KRRpYKhpj9whAz91mRC9NFtB8e2f1tPJksyJweRf4rgC2JgcF5
         08UP7XqWpIsYB/5OlhS0xdBy62oUYk7fST7/Czz3ts4zrK4u9Cncyz44CYRpQpki9zBX
         cPduFvTyqoZ4ZN//RUQi1xPfXi2AvLgG/kEdekRo+8YGpMEB/OvOpbVbcpIHue3PXIkJ
         WQ+w==
X-Gm-Message-State: AOJu0YxYc87PVWInKHnI+OMpzjRoxNdRhwu1CLhwcfytvLm+HM+9lpGJ
        Ev+07U/NkyZkEV54rDDxt5DXuUcElB4P2E6/w4EZndxzNeu5EDIEsL15ZN2OW03w+HyP9fCl69Z
        Ege7u6hl7HiB9YEQjtP83VusaQtTb8ZRy+Is=
X-Received: by 2002:a0c:e3c4:0:b0:65b:239f:6779 with SMTP id e4-20020a0ce3c4000000b0065b239f6779mr2411217qvl.38.1695829722171;
        Wed, 27 Sep 2023 08:48:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvXN24Gq7lJ4N2Pd195k1EQvGDijxPrzCysfC8L9ky0JbCss85UWdaXbwHnXlPbMaYyaElaQ==
X-Received: by 2002:a0c:e3c4:0:b0:65b:239f:6779 with SMTP id e4-20020a0ce3c4000000b0065b239f6779mr2411199qvl.38.1695829721936;
        Wed, 27 Sep 2023 08:48:41 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-30-58.cust.vodafonedsl.it. [2.34.30.58])
        by smtp.gmail.com with ESMTPSA id j12-20020a0cf30c000000b0065b0a3ae7c7sm2964022qvl.113.2023.09.27.08.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 08:48:41 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Rae Moar <rmoar@google.com>
Cc:     Marco Pagani <marpagan@redhat.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] kunit: run test suites only after module initialization completes
Date:   Wed, 27 Sep 2023 17:48:27 +0200
Message-ID: <20230927154828.122280-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit 2810c1e99867 ("kunit: Fix wild-memory-access bug in
kunit_free_suite_set()") causes test suites to run while the test
module is still in MODULE_STATE_COMING. In that state, the module
is not fully initialized, lacking sysfs, module_memory, args, init
function. This behavior can cause all sorts of problems while using
fake devices.

This RFC patch restores the normal execution flow, waiting for module
initialization to complete before running the tests, and uses the
refcount to avoid calling kunit_free_suite_set() if load_module()
fails.

Fixes: 2810c1e99867 ("kunit: Fix wild-memory-access bug in kunit_free_suite_set()")
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 lib/kunit/test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 421f13981412..242f26ad387a 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -784,13 +784,13 @@ static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
 
 	switch (val) {
 	case MODULE_STATE_LIVE:
+		kunit_module_init(mod);
 		break;
 	case MODULE_STATE_GOING:
-		kunit_module_exit(mod);
+		if (module_refcount(mod) == -1)
+			kunit_module_exit(mod);
 		break;
 	case MODULE_STATE_COMING:
-		kunit_module_init(mod);
-		break;
 	case MODULE_STATE_UNFORMED:
 		break;
 	}
-- 
2.41.0

