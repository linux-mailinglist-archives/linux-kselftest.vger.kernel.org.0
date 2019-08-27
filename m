Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 603529DABA
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2019 02:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfH0AhM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Aug 2019 20:37:12 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37827 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfH0AhM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Aug 2019 20:37:12 -0400
Received: by mail-io1-f66.google.com with SMTP id q22so42075957iog.4
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2019 17:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BzeVAWovI9wNatL9dmXA8c77UhbonukUh6rmg5r+32k=;
        b=RFd2pTJzpbhIHF6iGKKLVB6oA47DzUgxrLAPE7IxEi6UB3IZzHyhvbYooAtYVjcJWW
         4DjCKMeysWFIR+5+ixOtvr0LuvkmTvkQfQRH2mCLNjECnJxVKcUAXiVoZ+ZTljt9wt+Q
         sDuBx6JUPqc8uKtyJhA0TdgvqrzmEPubyW8eA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BzeVAWovI9wNatL9dmXA8c77UhbonukUh6rmg5r+32k=;
        b=ew0GMFjZgwvApJCkiUnoIa/re0dQQrv7opcG3x8LJK+W8jKgLMzFn8oQjyQZv8SQYB
         23U+x/onCrgnzIfYhiOfONu9GnSM35mzhq7YasF2Q93CPbAnUcPgyQZGAmR7ngiVyB+K
         ClzNci+dnce0eBHfSpAul7PrMhj4Jn79ez3VeTH7pBpQD8e5oTmmerEX/zQsxjolXBUf
         rN1hBWKmDxnW3GKsDccg7AME9f5NGe6Crs3hAJTNwAIY5eeuDD/z1vvLr3jLJuFK5Y6U
         nlwTJZ+nCkJxIsSv81TF7Zhqqv3DDlPZ1Z4fjrnQEzSkyMH7QMd6r8tJuIV4jyPquni3
         Vaaw==
X-Gm-Message-State: APjAAAWOdyrcKrObCxXj2mpq5+Pv+yoiSH9goS6WKVbgQNL0lvkK32BS
        TGSXdX7Iot2AdgUd0Xa6MCrg4A==
X-Google-Smtp-Source: APXvYqxc72IrPdBOQjJ7DSRNsqCKEkfC2oIBkrJ4CwrkYFZ/PDg3oRQ89onY+gSPvXLkKnSmphNiWw==
X-Received: by 2002:a5d:9c12:: with SMTP id 18mr6327310ioe.48.1566866231264;
        Mon, 26 Aug 2019 17:37:11 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v23sm9995828ioh.58.2019.08.26.17.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 17:37:10 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, corbet@lwn.net
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.rue@linaro.org,
        anders.roxell@linaro.org
Subject: [PATCH v2] doc: kselftest: update for clarity on running kselftests in CI rings
Date:   Mon, 26 Aug 2019 18:37:09 -0600
Message-Id: <20190827003709.26950-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Update to add clarity and recommendations on running newer kselftests
on older kernels vs. matching the kernel and kselftest revisions.

The recommendation is "Match kernel revision and kselftest."

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
Changes since v1: Fixed "WARNING: Title underline too short."

 Documentation/dev-tools/kselftest.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index 25604904fa6e..308506c5e8fa 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -12,6 +12,31 @@ write new tests using the framework on Kselftest wiki:
 
 https://kselftest.wiki.kernel.org/
 
+Recommendations on running kselftests in Continuous Integration test rings
+==========================================================================
+
+It is recommended that users run Kselftest from the same release. Running
+newer Kselftest on older kernels isn't recommended for the following
+reasons:
+
+- Kselftest from mainline and linux-next might not be stable enough to run
+  on stable kernels.
+- Kselftests detect feature dependencies at run-time and skip tests if a
+  feature and/or configuration they test aren't enabled. Running newer
+  tests on older kernels could result in a few too many skipped/failed
+  conditions. It becomes difficult to evaluate the results.
+- Newer tests provide better coverage. However, users should make a judgement
+  call on coverage vs. run to run consistency and being able to compare
+  run to run results on older kernels.
+
+Recommendations:
+
+Match kernel revision and kselftest. Especially important for LTS and
+Stable kernel Continuous Integration test rings.
+
+Hot-plug tests
+==============
+
 On some systems, hot-plug tests could hang forever waiting for cpu and
 memory to be ready to be offlined. A special hot-plug target is created
 to run the full range of hot-plug tests. In default mode, hot-plug tests run
-- 
2.20.1

