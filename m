Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91DE04FC80
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2019 17:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfFWPwc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 23 Jun 2019 11:52:32 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46170 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfFWPwc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 23 Jun 2019 11:52:32 -0400
Received: by mail-pl1-f193.google.com with SMTP id e5so5447049pls.13;
        Sun, 23 Jun 2019 08:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O30R5IepqsX9VW9UMy1gWcvt3pvWZfQRhZyo7WcC+Ws=;
        b=L/tTFSSpw07xcJb+VfO58wQcJubYvfTwZQ3kqJ4W+P4HQAIXJGK7mDohuVq9qGwC/l
         2oL5Z0AyOIQ3JEix0PYgyyMkh/GNxhtwHgzjqTJTg3Fxynj2eWtwgaXhM3tCP6/ToA+w
         FLai+Hj+TtG2NtY0CKlGmRR97JZxreyW7OfHCWGndwycR00LSwLG9j0EL6aTdYzN4aa6
         xGLHgQR3z/mZF6DTQ0jvjA/HRJkHeEULxth1mMC5lQitUpP1yjW4uC+xPASW6vHxoo08
         f/d4A66EjslRpIxnwRlN3zMFJUM2GFDjSzGMJALQOWkvjA4ZzUvudEUV8c9Q5rwVXkQn
         Eujg==
X-Gm-Message-State: APjAAAWOfqhhf+6bNaZWgv+AhZUOcb2o4SGpsdnUSUjyvr8jUyHrJEL/
        pHY/aabPhxyCAyxYEutkWF4=
X-Google-Smtp-Source: APXvYqzEheaakgyT/FA8+Ar1pHqTgDrpSpjY4hSyiy1ogM+X7fv6dTZShWXl3KwQf017ytTZjCQBvw==
X-Received: by 2002:a17:902:9a91:: with SMTP id w17mr46166834plp.126.1561305152092;
        Sun, 23 Jun 2019 08:52:32 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id c18sm9167081pfc.180.2019.06.23.08.52.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 08:52:31 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Simon Guo <wei.guo.simon@gmail.com>
Cc:     Denis Efremov <efremov@linux.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/powerpc: ppc_asm.h: typo in the header guard
Date:   Sun, 23 Jun 2019 18:52:00 +0300
Message-Id: <20190623155200.2147-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The guard macro __PPC_ASM_H in the header ppc_asm.h
doesn't match the #ifndef macro _PPC_ASM_H. The patch
makes them the same.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h b/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
index d2c0a911f55e..2b488b78c4f2 100644
--- a/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
+++ b/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _PPC_ASM_H
-#define __PPC_ASM_H
+#define _PPC_ASM_H
 #include <ppc-asm.h>
 
 #ifndef r1
-- 
2.21.0

