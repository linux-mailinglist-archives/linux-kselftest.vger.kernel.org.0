Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C93B44CE85
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2019 15:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731743AbfFTNTz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jun 2019 09:19:55 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46504 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731953AbfFTNTz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jun 2019 09:19:55 -0400
Received: by mail-oi1-f193.google.com with SMTP id 65so2081325oid.13
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2019 06:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1IDImd+SyL7qusfZ7LEqZyeCM5Jqrmah1crodqgym2o=;
        b=Z77iLpOXmS+LuG22+Pytd77vIOhESlIw9v0v/o6wz3WFxUVyZVuXJyx4weKeiAaHLC
         ICyqNfMfDaMIR6ayB8jyTxh7WaXJguH7MAKdKF5UvpkAZpzjDSudYBycegmdv+cu3y15
         GJfnWza79menUVnjzVj/C188QZVNtvPmC6BkufiJg4QDBfrgLETYgTboXga0ksf6Bg0E
         mgqxLmAc+KD2Hbfv9VTXfG5MrxmYg+pZk4V6eZnGbPIEzp2SgIAXb6JEo3IdYTIKxYw/
         9heW8RVFfJ52e0uQ8KD/L8xbVktXc9+p8AmFlk7oON8FotA+3R0q1CsjGObin7blMxo6
         osdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1IDImd+SyL7qusfZ7LEqZyeCM5Jqrmah1crodqgym2o=;
        b=BrDhwwkx5PxwpBsMyOJa7WvDLOy5x4q6AVvTk7XHfjJa0LzUJSBKsctK8oqqmsHkhX
         WiSuPkZcvtJC5c29QVy6aiX16tMucLguzz/bwOVkyhow1TfX2mb0dhdTM3OwhT6Zx3uq
         sBptS02egGM/3tLeYA7WG8fedUNI5LX9sI9j5zcOiE0qKR2wu6Jj3waKU15v9TDPY+GS
         Mf9aekgUH3ZqVtD8gFHERMMeMF4Kb9SjuxxvgJ9/FKTrJYeDtkqdcEFCGgPcaLb+lZv7
         3mL28/w7+NOTLVUinAhJKk/XG0iUxzm1O4qxnK5Lie2pMSwT6zSIo1JflXMsngBfNKIJ
         rxMg==
X-Gm-Message-State: APjAAAW4A3vlJ09EJnDegCkK+qnKWvEOnDPILYC7fNF2Yl5zXBvc6wKq
        f4Ik8d3ynpjZIbtmc1YuBHVd9Q==
X-Google-Smtp-Source: APXvYqyRboXu4SbkOVXdL7maf5yqjeeaiBdvJH/64vyWK0jWSoHwuU7EkLw3RE1uOYLsi2ZI6ZrlCQ==
X-Received: by 2002:aca:4b42:: with SMTP id y63mr6256321oia.168.1561036794590;
        Thu, 20 Jun 2019 06:19:54 -0700 (PDT)
Received: from alago.cortijodelrio.net (CableLink-189-218-29-147.Hosts.InterCable.net. [189.218.29.147])
        by smtp.googlemail.com with ESMTPSA id t6sm7878945otk.36.2019.06.20.06.19.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 06:19:53 -0700 (PDT)
From:   =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org,
        =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Petr Vorel <petr.vorel@gmail.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] selftests/tpm2: Install run-time Python modules
Date:   Thu, 20 Jun 2019 08:18:19 -0500
Message-Id: <20190620131822.28944-1-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When ordinarily running the tests, upon `make install', the
following error is encountered:
  ImportError: No module named tpm2_tests
because the Python files are not installed at the moment.

Fix this by adding both Python modules as accompanying
TEST_FILES in the Makefile.

Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
---
 tools/testing/selftests/tpm2/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/tpm2/Makefile b/tools/testing/selftests/tpm2/Makefile
index 9dd848427a7b..bf401f725eef 100644
--- a/tools/testing/selftests/tpm2/Makefile
+++ b/tools/testing/selftests/tpm2/Makefile
@@ -2,3 +2,4 @@
 include ../lib.mk
 
 TEST_PROGS := test_smoke.sh test_space.sh
+TEST_FILES := tpm2.py tpm2_tests.py
-- 
2.20.1

