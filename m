Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D24C4ABEE8
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 14:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243155AbiBGM2N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 07:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383137AbiBGLVk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 06:21:40 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92422C0401E4;
        Mon,  7 Feb 2022 03:21:26 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id d9-20020a17090a498900b001b8bb1d00e7so2452677pjh.3;
        Mon, 07 Feb 2022 03:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u1SeK1c7GsxTi1KJRtX41+e8KV9bbkC6jBlAR+v8yco=;
        b=qek10+XaY11auEJTZ6D2YUOXnJNC2jahYrh8WmWDjUshFRhDhJ9MUUpTlYEZ1NMIxk
         OJK15B11YbOuuQSFH2zv3+M1qNHESwuLSwwDRnd8qF2BlKd0yf0etXtUzqwqgLzIWmxu
         X5f/BuOsQtYFxvb+/AjXFs4g0VDQFUwHY2s5OvO570DzRPic/18rXaWBk4Eo/GteEX9M
         7wQGacG4s4RUi5vg/uaOxIdhZZPotD6Z5dG/iqk3bh4DJqU58gi221g9puGL1MROSccY
         3FMXdYR5NgOd/ii7X7VguVEijRWdC8skg5uriwOossgj6UvpMQA5KoRGeYMo/RchUYq7
         jWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u1SeK1c7GsxTi1KJRtX41+e8KV9bbkC6jBlAR+v8yco=;
        b=M47+xtL9mMQDHbnpNjL5mYrERhTYZ2+G3UgITKi9qmuLFaa56kIWV9vdpEtKUUCrK+
         XIQZt3WkcLvkSMuSXxjgjAhDVLAfR6+JqHdZIwQVqFQoX1T78DRdnRRu05VvilqBSrNw
         gZiy2QmSRrR3iSw24HcI70SJ3FyX441zZq+Na14vB8/tj67DJpwtQ7CIXYqogEP1smOg
         cOUE2PXH99HhlFgTCAq9yKFBvMSzDlcS3eqp3XxRm9/XYRiVttIunTBgFtVtA31MT58E
         a+RH+n/EDVn+z3MljPwhdzflTqZhR/6NiHvXPZUuIoczC29lvs2dxYdER4LQj/KmnHCh
         VLEg==
X-Gm-Message-State: AOAM530dhQQX7BzJh8Q4tx8P86v6KuI+yBFhONXA7YITqYJ0VP39sS0E
        KmJOYhOOYmCJKsjYaIynnOc=
X-Google-Smtp-Source: ABdhPJyyDGXxcAT+b6VN7v+g7nzcvVC6pBxqH3gvy90hhQbUrZ66KZpL9Y/MgLcgt8d+zNOrJd4/eQ==
X-Received: by 2002:a17:90b:3802:: with SMTP id mq2mr13748921pjb.236.1644232886066;
        Mon, 07 Feb 2022 03:21:26 -0800 (PST)
Received: from localhost.localdomain ([2400:2410:93a3:bc00:d659:4e05:9b13:b711])
        by smtp.gmail.com with ESMTPSA id w11sm11791400pfu.50.2022.02.07.03.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 03:21:25 -0800 (PST)
From:   Akira Kawata <akirakawata1@gmail.com>
To:     brendanhiggins@google.com
Cc:     akirakawata1@gmail.com, Jonathan Corbet <corbet@lwn.net>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] Documentation: KUnit: Fix usage bug
Date:   Mon,  7 Feb 2022 20:20:44 +0900
Message-Id: <20220207112043.397074-1-akirakawata1@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix a bug of kunit documentation.
Link: https://bugzilla.kernel.org/show_bug.cgi?id=205773

: Quoting Steve Pfetsch:
:
: kunit documentation is incorrect:
: https://kunit.dev/third_party/stable_kernel/docs/usage.html
: struct rectangle *self = container_of(this, struct shape, parent);
:
:
: Shouldn't it be:
: struct rectangle *self = container_of(this, struct rectangle, parent);
: ?

Signed-off-by: Akira Kawata <akirakawata1@gmail.com>
---
 Documentation/dev-tools/kunit/usage.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 76af931a332c..1c83e7d60a8a 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -242,7 +242,7 @@ example:
 
 	int rectangle_area(struct shape *this)
 	{
-		struct rectangle *self = container_of(this, struct shape, parent);
+		struct rectangle *self = container_of(this, struct rectangle, parent);
 
 		return self->length * self->width;
 	};
-- 
2.25.1

