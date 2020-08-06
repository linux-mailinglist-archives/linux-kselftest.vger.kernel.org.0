Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474AC23DF3F
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Aug 2020 19:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgHFRny (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Aug 2020 13:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729956AbgHFRnp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Aug 2020 13:43:45 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E03AC061575;
        Thu,  6 Aug 2020 10:43:35 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id g14so12986483iom.0;
        Thu, 06 Aug 2020 10:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z/ASPTS2Ee55jSURHALLk5ixEglfeB12zyqYUwDPixY=;
        b=vZMte5qYscBHsZYUsCMEgz2Dn5MTnYOYyFbw+RlgdpAO59S3kD4naXFl+mcCw42QNt
         bvkFgOd6Vg2GSimvm4HfT9wBwWAtyNx1Qbb3SSQKvWrDJpQ9+OHCG2xjlwxdDUNF7wV1
         44D0HXxDqOc2KX+QxTpZCL7TJYaJ8lJPEtt+9yL4Lo3dYeyh+P+mD0SFVLv8r/+49Udh
         Vi3oocj6BufFT13MZ54fPA1M3LR+31aIh0fPBE1zsO7rde8EaadlD0GMfRGsXOYJQGQz
         bGFHvIYfNeji+5d+dGxJfgkLBbuqa7bdct7MA6ZEndOp2ZqhhALT/c0uti8y0IXJAg7S
         N7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z/ASPTS2Ee55jSURHALLk5ixEglfeB12zyqYUwDPixY=;
        b=JSd4q1aikBI8bqmGazU6HdLgfRSDaWpOX9X0WMQNi/0ys+ylyHG6MT8wrt7ZZ3eJsG
         CdH1SQ1+YjGjOX4OoNwTFhynO13WC5M4/LoZeaVQ2sql/SZ4Jon3WIH4ZSX4wMuumyT9
         p7P0SDtP5W4auEg1tItl+07/R4T11EoX6+c/VXWuY7mK4xYX/WeeC66Uza9hPvWINQYq
         EmoMEVuNWfPBoI4U2Hf7k2zIcOLUHGtUxSSlGDVbXiiGSdYCu6VceW8MPf2Rpqggicf6
         lM/0iTce9CwBCV7uyghtnoRDQ/2YYVykdEhvOvfDF/pdkPFKlVRFoYGxweHgqnQOFvw5
         bF9Q==
X-Gm-Message-State: AOAM5300bh9PT2J3DRIoPsQltt07PNKT57Myx5RuCxqyXP4nUhespG/f
        BO5PYsz7HfywmsWTMZ5/pe7+3ahlQlk=
X-Google-Smtp-Source: ABdhPJy/jzaHUWIEV12zEeADOXLHmSLfbdTrUGAtz8PFO6lqoR7KkgjXCncmEAwHoLFKmvvD13++bw==
X-Received: by 2002:a05:6638:12d4:: with SMTP id v20mr12338614jas.108.1596735813690;
        Thu, 06 Aug 2020 10:43:33 -0700 (PDT)
Received: from urieldev.c.googlers.com.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id s74sm4750141ilb.44.2020.08.06.10.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 10:43:32 -0700 (PDT)
From:   Uriel Guajardo <urielguajardojr@gmail.com>
To:     brendanhiggins@google.com
Cc:     urielguajardo@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Uriel Guajardo <urielguajardojr@gmail.com>
Subject: [PATCH 2/2] kunit: ubsan integration
Date:   Thu,  6 Aug 2020 17:43:26 +0000
Message-Id: <20200806174326.3577537-2-urielguajardojr@gmail.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200806174326.3577537-1-urielguajardojr@gmail.com>
References: <20200806174326.3577537-1-urielguajardojr@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Integrates UBSAN into the KUnit testing framework. It fails KUnit tests
whenever it reports undefined behavior.

Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
---
 lib/ubsan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/ubsan.c b/lib/ubsan.c
index cb9af3f6b77e..1460e2c828c8 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/uaccess.h>
+#include <kunit/test.h>
 
 #include "ubsan.h"
 
@@ -137,6 +138,7 @@ static void ubsan_prologue(struct source_location *loc, const char *reason)
 {
 	current->in_ubsan++;
 
+	kunit_fail_current_test();
 	pr_err("========================================"
 		"========================================\n");
 	pr_err("UBSAN: %s in %s:%d:%d\n", reason, loc->file_name,
-- 
2.28.0.163.g6104cc2f0b6-goog

