Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5291ABFEA
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Apr 2020 13:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505224AbgDPLoJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Apr 2020 07:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634021AbgDPLny (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Apr 2020 07:43:54 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FA2C061A0F
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Apr 2020 04:43:54 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id 72so1275976wmb.1
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Apr 2020 04:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/kCl4Qp/HWFb3bfjnVpgsPir2dBStE2GQr6w0WtQly4=;
        b=LoPHn4aWZllHhakXzK28hq0gYhdoPqjIUb5q8/9LUlHog4lr4YMsmhmr8PmtJTdMav
         xM6ygCdhcmyyvfd/mJ8DK3mdTAY9KsDJy6ksfNFP+kPKzedwwKjmPRVSb0f5b538c2G5
         WHSBeN5XustfBv4quIIiTSQDddY1iixE9KDr/fqmBHTmJPz+uP4AOB9efp28tE+mDE2P
         /fQ6mz3ZOi+SukgXRg232QEAxg43TB7bzsLQC7GHociU8BZGVw/bquOFTGonDwSou/m2
         Zkj3TJJbNndy9201si0eQbdT0J8AABk0pWCg+ZCj2/Nn0u/qS3iOlZuFfuGZbGyYAEFU
         RQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/kCl4Qp/HWFb3bfjnVpgsPir2dBStE2GQr6w0WtQly4=;
        b=tIjwS+RXa45/HZzPeKkqZKNdhnyP9z0NVIx2ND7hubl5DtjgPXfYcFMpbNwCg8pOC5
         422icZlfbtAdANWwFm4zAVgfkpKDALeDMgDApwzBpRjnLwGdGkc2GOXdiL3Y5ji8zInC
         +Vq6ZzAVkIWh5ysJdFmR+YrOrjMsXQbuHIZMPnKKaXTO7uWUv3Fn3m+fPJlkBv8bESO/
         qidVfPBQKG2YOyDgMXzTq3xA97w3WbpNNzBr5Y7texpYY+RhJonlGDune7x7WrXKxFRi
         19eMCTVobuTQMzJiCEHo2rIitHunTeBOIiiWKSv6n2MRfULw4UNMbNJUq/qWG9/kXSHW
         cgMA==
X-Gm-Message-State: AGi0PubWUvSm9kZS38/2LIt/ZyKWkfbrg9KqrvCkofw3QvtjafLen7TM
        1II9N/ViJ6hu5EALonjRvkdwhPjDaw==
X-Google-Smtp-Source: APiQypLbJHPjUQ2RlNkAM2mV95H3x40l/9Wm7yqr0AuKQvBVjKLGdfbybl/iUwu5f7bkVTRNSwWM4kQfuA==
X-Received: by 2002:a5d:404a:: with SMTP id w10mr7562452wrp.397.1587037432601;
 Thu, 16 Apr 2020 04:43:52 -0700 (PDT)
Date:   Thu, 16 Apr 2020 13:42:57 +0200
Message-Id: <20200416114256.226329-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH] kunit: Add missing newline in summary message
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        alan.maguire@oracle.com, frank.rowand@sony.com,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add missing newline, as otherwise flushing of the final summary message
to the console log can be delayed.

Fixes: e2219db280e3 ("kunit: add debugfs /sys/kernel/debug/kunit/<suite>/results display")
Signed-off-by: Marco Elver <elver@google.com>
---
 lib/kunit/test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 7a6430a7fca0..ccb2ffad8dcf 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -93,7 +93,7 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
 	 * representation.
 	 */
 	if (suite)
-		pr_info("%s %zd - %s",
+		pr_info("%s %zd - %s\n",
 			kunit_status_to_string(is_ok),
 			test_number, description);
 	else
-- 
2.26.1.301.g55bc3eb7cb9-goog

