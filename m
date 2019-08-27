Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D52A09DA56
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2019 02:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfH0AH5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Aug 2019 20:07:57 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43596 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbfH0AH4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Aug 2019 20:07:56 -0400
Received: by mail-io1-f68.google.com with SMTP id 18so41853015ioe.10
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2019 17:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a5z2pwdyiPujj+zyGVyLnpKnSEToBkmyR8roMplmnXw=;
        b=F7BmUN+QmTsdUsQeCw8YeegWM0cNlrWFyAIOl5L9NAle+JqTUOdkwRelba5mvU1WTJ
         nlHOEuEZQQQ3GNuW4Ig+plu6no6vRqFHLyN4NyYdqmT9nAY9yreQXj2f1JmdsxgvQoyI
         6pUYSXPdJZ99uKo0LKgiHVktu3trX2JhLmZak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a5z2pwdyiPujj+zyGVyLnpKnSEToBkmyR8roMplmnXw=;
        b=RqaDb1mn6hwzRBZHYN4vU6Y5cx7y+H58mbPB+ngBOolv31KXKZH0mk1OcZvm+QRzDa
         s39ZPGO0BSxWFU55ra/DR0rmUR6iAMIHJH+6mEIgqNCNfXm8xLGBDYxYMNz7SOKMhTeH
         YZIBopDNFJzhmo5Bwy/F1UkmLyl7pvtXKGHIxSRcgsFp5/mR9Td7nUYJKwhjrc49Qc9H
         wtokkBWrgHOc9wd1sNFNnaairpzkb1+Y5mFFBBMFRYT0avD+IkyEgTpn6eFqdDouTDLd
         oKpMLpMKs0oBXtcU/otUR9Ut4p964jyuPuBOvXE85uXDg1oDmtymaTycWyrdWnT3fndR
         WsXQ==
X-Gm-Message-State: APjAAAXafHKx5jTgzKefZ2tHhWac2FizcEFTzg99jcG/LBMsWR+ioG/h
        WSHgBJsnqJQQfkyU0WCHbNHX9g==
X-Google-Smtp-Source: APXvYqwZXQTYcLqLmGjeo3QU1lIjgbyL1qWx8uhRds422nNNmVUSG9ZPkZS7URWw5OLsPs8YCbVZpQ==
X-Received: by 2002:a6b:5d0d:: with SMTP id r13mr825424iob.89.1566864476030;
        Mon, 26 Aug 2019 17:07:56 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k9sm12164773ioa.10.2019.08.26.17.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 17:07:55 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, corbet@lwn.net
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.rue@linaro.org,
        anders.roxell@linaro.org
Subject: [PATCH] doc: kselftest: update for clarity on running kselftests in CI rings
Date:   Mon, 26 Aug 2019 18:07:53 -0600
Message-Id: <20190827000753.25081-1-skhan@linuxfoundation.org>
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
 Documentation/dev-tools/kselftest.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index 25604904fa6e..e55d9229fa8c 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -12,6 +12,31 @@ write new tests using the framework on Kselftest wiki:
 
 https://kselftest.wiki.kernel.org/
 
+Recommendations on running kselftests in Continuous Integration test rings
+=========================================================================
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

