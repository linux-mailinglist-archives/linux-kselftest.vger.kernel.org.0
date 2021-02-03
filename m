Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC1230E236
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Feb 2021 19:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbhBCSOm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Feb 2021 13:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbhBCSNg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Feb 2021 13:13:36 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0304BC0613ED
        for <linux-kselftest@vger.kernel.org>; Wed,  3 Feb 2021 10:12:21 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id f8so301198ion.4
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Feb 2021 10:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q/XjWOBQrwKZ3SFGSB0fATQ2ysDx1Jq6OdD33TEzEu4=;
        b=Ca53H6enHZi+n+88m0jGJsgev/5lnuLUGNk2voy5K3CkZmT9+uJF4YH8ETx+tL+2IO
         CsNamMChin+rVfByuLl3nBKMwXT+UjebNkNLPSpCDhm3jyBEi/GrkfSWDK+OBSvIqbuv
         KrhYy0sJv/lDXYjv+3sK05wxFYcwI/qdrikZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q/XjWOBQrwKZ3SFGSB0fATQ2ysDx1Jq6OdD33TEzEu4=;
        b=oKI84nwWFKAlfXOrUaGwn88WrjL/PfsvIePQdTVWc7HvFXbHeD85MQqkl5V9vYN+0r
         uqWIf30a4JcTgq2p7Jpl9yXYC0dx0H166IzUhRWSx9fMHcEboL0PH7E5VN5g8xq8ITFC
         MZTjkixhH4RkxqsA4+WWjk3ltyhECzrWHME+fIyun5jkqYmXesooYQMKaCzRPKeXDSLH
         UgxNpoCFqgoyGOLXb2jCJRCIs8ebXIwdSGtk0fhgZ+DVDqeO70JGmosO4cFV0o6bprVh
         OF2BbTJxk3Q2BVMxHcXj1g/sdepd22CycyramHGiVFt9/aD9h28k/SXHDaO213HlH2xE
         /13A==
X-Gm-Message-State: AOAM5306FiYSgfv1EZwV0eMoaXsOYq2s68YiPSkoJs+J1qdzQVe9x52F
        2JmGgMuWrEJhBlOS5CUvIDZq/A==
X-Google-Smtp-Source: ABdhPJw8iD9beaycWlURDEZl4vpUK/XlUZjR45GfkvhmxT8ZKEaI7qDG0lvzt7C8BSA2pY18tqX2mg==
X-Received: by 2002:a5d:968e:: with SMTP id m14mr3468449ion.26.1612375940544;
        Wed, 03 Feb 2021 10:12:20 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h21sm399684iob.30.2021.02.03.10.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 10:12:19 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     corbet@lwn.net, gregkh@linuxfoundation.org, peterz@infradead.org,
        keescook@chromium.org, rafael@kernel.org, lenb@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, bp@alien8.de
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH v3 4/7] drivers/acpi/apei: convert seqno to seqnum_ops
Date:   Wed,  3 Feb 2021 11:12:00 -0700
Message-Id: <d0f4ecaf408f2ea1d8cbb719b4fcabf969749c04.1612314468.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1612314468.git.skhan@linuxfoundation.org>
References: <cover.1612314468.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Sequence Number api provides interfaces for unsigned atomic up counters
leveraging atomic_t and atomic64_t ops underneath.

Convert seqno atomic counter to use seqnum_ops.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/acpi/apei/ghes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index fce7ade2aba9..103f67edee1a 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -41,6 +41,7 @@
 #include <linux/uuid.h>
 #include <linux/ras.h>
 #include <linux/task_work.h>
+#include <linux/seqnum_ops.h>
 
 #include <acpi/actbl1.h>
 #include <acpi/ghes.h>
@@ -625,8 +626,7 @@ static void __ghes_print_estatus(const char *pfx,
 				 const struct acpi_hest_generic *generic,
 				 const struct acpi_hest_generic_status *estatus)
 {
-	static atomic_t seqno;
-	unsigned int curr_seqno;
+	static struct seqnum32 seqno;
 	char pfx_seq[64];
 
 	if (pfx == NULL) {
@@ -636,8 +636,8 @@ static void __ghes_print_estatus(const char *pfx,
 		else
 			pfx = KERN_ERR;
 	}
-	curr_seqno = atomic_inc_return(&seqno);
-	snprintf(pfx_seq, sizeof(pfx_seq), "%s{%u}" HW_ERR, pfx, curr_seqno);
+	snprintf(pfx_seq, sizeof(pfx_seq), "%s{%u}" HW_ERR, pfx,
+		 seqnum32_inc(&seqno));
 	printk("%s""Hardware error from APEI Generic Hardware Error Source: %d\n",
 	       pfx_seq, generic->header.source_id);
 	cper_estatus_print(pfx_seq, estatus);
-- 
2.27.0

