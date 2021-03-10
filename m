Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9662B333A5D
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Mar 2021 11:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbhCJKm0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Mar 2021 05:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbhCJKmF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Mar 2021 05:42:05 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1D9C06174A
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Mar 2021 02:42:05 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id v136so12406124qkb.9
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Mar 2021 02:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4oqgRNZGjKcuPrToE+ulENN9iboOssrjKjo3aJMrJ9Q=;
        b=s9prmAM12n13n3qUuRwt5GQbWCYJHSsKmZprdRrOZs1gcLo/jLhX5+3loZNnDFCA2q
         nD60ujTcDCXFKGqmUrEjCqph2454+hgHUx2kS6kXUOwivci8j6Mif9dpjGjG503isGp1
         kf+wK0k/Xsyf5nrxWzBgoZ/wGa3SXc38O7F02QcrR9nXHUpgV/7F1x2d75Dcs4dLgWtp
         9mTK7K/zOQyvHM3nkQuGlNOxP59cN1NaLkgu3ud8HYy5GeghbyxJQobe7h22TU5+l0IK
         7rEIMbjOaLk2jy0V3usd/JNl9vYV+Q12llM/d18bb95be6iuEyb/xXSScecLRUVmbDFM
         cRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4oqgRNZGjKcuPrToE+ulENN9iboOssrjKjo3aJMrJ9Q=;
        b=jshvjReehbNKxYUkm1nIQbN3NDIGc605nDKBFecMa5qkGXnMGrOq1zScwcTKQFVcxY
         WNMy9TQSFiuSMMpZJ27CbyiaOUbKx5uOqRCzcw52Hb/xv3H1AND5BalYRNKZb1VPl9ip
         OMNS2eeNVBhtbzhfkyS9QzsSPPlCRN7Q1PrVDI21XDpcBQy51WQJs4DxZkf/gRezjAWT
         tJyCnzhy7aID5bVpw3NI5aExu4TA/VKUXVv0+3EsFpQsRlkF08tE6MGU+LU7fty+jMvs
         YWK8fT8UXnYIp14Bt+NGoeoFFzRku5HCzcfY8EWzAqccLjviGsA3qv4JsiQpGoN1iROZ
         Wg5A==
X-Gm-Message-State: AOAM532k2PmGwxKnpErKeGOlFaS91miU8urXxZwyRTNOwn8TM6W9pKPc
        yOyS4SgPELNRiXVfiIxGWH88hm+Tsw==
X-Google-Smtp-Source: ABdhPJzZZYzpha85M4VLEh0UrtTjdzhQkJpiQu+lvwmZ/3NwfOWbQiR6FN6lp5YnDpdBObOChPowjwgZ4w==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e995:ac0b:b57c:49a4])
 (user=elver job=sendgmr) by 2002:a05:6214:c27:: with SMTP id
 a7mr2084546qvd.54.1615372924678; Wed, 10 Mar 2021 02:42:04 -0800 (PST)
Date:   Wed, 10 Mar 2021 11:41:37 +0100
In-Reply-To: <20210310104139.679618-1-elver@google.com>
Message-Id: <20210310104139.679618-7-elver@google.com>
Mime-Version: 1.0
References: <20210310104139.679618-1-elver@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH RFC v2 6/8] perf/core: Add breakpoint information to siginfo
 on SIGTRAP
From:   Marco Elver <elver@google.com>
To:     elver@google.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, acme@kernel.org,
        mingo@redhat.com, jolsa@redhat.com, mark.rutland@arm.com,
        namhyung@kernel.org, tglx@linutronix.de
Cc:     glider@google.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
        christian@brauner.io, dvyukov@google.com, jannh@google.com,
        axboe@kernel.dk, mascasa@google.com, pcc@google.com,
        irogers@google.com, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Encode information from breakpoint attributes into siginfo_t, which
helps disambiguate which breakpoint fired.

Note, providing the event fd may be unreliable, since the event may have
been modified (via PERF_EVENT_IOC_MODIFY_ATTRIBUTES) between the event
triggering and the signal being delivered to user space.

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Add comment about si_perf==0.
---
 kernel/events/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e70c411b0b16..aa47e111435e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6336,6 +6336,22 @@ static void perf_sigtrap(struct perf_event *event)
 	info.si_signo = SIGTRAP;
 	info.si_code = TRAP_PERF;
 	info.si_errno = event->attr.type;
+
+	switch (event->attr.type) {
+	case PERF_TYPE_BREAKPOINT:
+		info.si_addr = (void *)(unsigned long)event->attr.bp_addr;
+		info.si_perf = (event->attr.bp_len << 16) | (u64)event->attr.bp_type;
+		break;
+	default:
+		/*
+		 * No additional info set (si_perf == 0).
+		 *
+		 * Adding new cases for event types to set si_perf to a
+		 * non-constant value must ensure that si_perf != 0.
+		 */
+		break;
+	}
+
 	force_sig_info(&info);
 }
 
-- 
2.30.1.766.gb4fecdf3b7-goog

