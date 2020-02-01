Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63C8914F54C
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2020 01:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgBAABN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Jan 2020 19:01:13 -0500
Received: from mail-ua1-f73.google.com ([209.85.222.73]:51630 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgBAABN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Jan 2020 19:01:13 -0500
Received: by mail-ua1-f73.google.com with SMTP id k24so2188884uag.18
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Jan 2020 16:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xCsmu4aj8EN/ECCHKtP+kWyAhx9ybdR5E/pP0+fGVsg=;
        b=TgtQby4eRqpgOeGBlTU4dTD9h1ULNYnndcMLety++EJ4HQjpz37LvWy5bzeabDJald
         un27UOLZ+XU1TkH8XBnm61cmDpNZ0vd7CIuKCla88JAqJUDjBYc768VJ9Ej3fM09iwIo
         2eIu8RVWOLsNMFvgBfBJn403Fb0kpJhMdD/MymRVosVO0fYldLhc9+kpv2Et0I5J4XNF
         QQLDhJRoZI08J6f7Ejp32X6v0T40f92d3OCkfw+OzB2vtpocZbBZdC52jfBH7gYU4CSj
         RCdQzPXpp/cL2UbtO1M77KJglkXTizVM32CBPRw14l09uchxQqiE2ibVw59vA+ltW+b2
         iB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xCsmu4aj8EN/ECCHKtP+kWyAhx9ybdR5E/pP0+fGVsg=;
        b=NY1BKNUDVK3IZ8riGD2JlAn30vKsJ4k9fgtcVQKDqXpmOOKEMYKg13MizHRYwAg5dT
         hYK0Ity9jAL6tl+IoHT9ObRNoavBzRgqMcgiy/bmu50Kdux9WA3DwHtwwqC1e34jWIX/
         slJSL/yd3U4bH1WxWtpPrhlHYjg1XsRSjQXRsCQMbErjDkC/8Rzj3GG8GSl6FjbipF2L
         5Ga8x/aCXeVxcv9WMUnoAi7WkVU/DQQOwVaiZJdoBo3oc4pXHzSh3rGTuYDSKvqaOIR0
         rS9HkJ9tzXJIwPrZN3sa3QyaY7vfqrnTvrY4kR3e9Qlp3tqB7XmBgtWgJF2vcmmowDz0
         UUpg==
X-Gm-Message-State: APjAAAXlvsPYiywhvE1Vj7SwItwO1GOEnlTQO2oBqXbaeDDR34/FfYV4
        /Zg3FyZVvqG9jlU5N7EV7zByXCQyACHL+PKk7lWWJg==
X-Google-Smtp-Source: APXvYqxlrR68AJPQzIEvwHccod9/5UKO3hKIkgEkI9aMx1JBOe57PrDtQ41vCE3bZBQcm1E2nsuDWstTBUfbyFdGvDNwUw==
X-Received: by 2002:a1f:d5c5:: with SMTP id m188mr8311853vkg.7.1580515271831;
 Fri, 31 Jan 2020 16:01:11 -0800 (PST)
Date:   Fri, 31 Jan 2020 16:01:02 -0800
Message-Id: <20200201000102.69272-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v1] Documentation: kunit: fixed sphinx error in code block
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org
Cc:     kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, davidgow@google.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix a missing newline in a code block that was causing a warning:

Documentation/dev-tools/kunit/usage.rst:553: WARNING: Error in "code-block" directive:
maximum 1 argument(s) allowed, 3 supplied.

.. code-block:: bash
        modprobe example-test

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 Documentation/dev-tools/kunit/usage.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 7cd56a1993b14..607758a66a99c 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -551,6 +551,7 @@ options to your ``.config``:
 Once the kernel is built and installed, a simple
 
 .. code-block:: bash
+
 	modprobe example-test
 
 ...will run the tests.
-- 
2.25.0.341.g760bfbb309-goog

