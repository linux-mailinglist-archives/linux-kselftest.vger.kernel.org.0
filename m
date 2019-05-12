Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3BF1AABD
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 May 2019 06:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbfELE5a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 May 2019 00:57:30 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41747 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfELE5a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 May 2019 00:57:30 -0400
Received: by mail-io1-f66.google.com with SMTP id a17so7566025iot.8;
        Sat, 11 May 2019 21:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Q4hqpIPM6r389oKY4xTVmiIkqrZbM6DRuzEQETW7JU=;
        b=VBEtp/i2ngujppylAgM7EwaA144Sis4lI+Qx+KW17ZaEOy96ZKAG+cZd1tfCzNYHXI
         2c1ZFDLK4IZ3TWnpXIpFlUiLg78NsCq2gIQ7oQzRk9BSdURV4V8YyARAgfVPoGNB3VR0
         FQ4Wj0gspcDEm+DoIFH67uHa4NpZYeLxjyACH6QtP1UHxoExGFB/J37gUsNdtZN54XGL
         NRZTJhEabUKBo6GLQ60KdeMf4hyyLclGzXhPXoNz5IBB6cArSF9GPvbtZDs03AA/eGcw
         hrlKgUqDJYNTOyM2lPKqELFuozYA7NzeoT3C5Ta18BUiXuoo9uDCTwyt4FvYAka+9m5B
         YXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Q4hqpIPM6r389oKY4xTVmiIkqrZbM6DRuzEQETW7JU=;
        b=bX+z/eP+sKprKvOcRAM+k3RUYJheyVvVblDeUQlBheC726YpjVSnDCSSYdg24YzRcr
         62c7ekTURkOGS85Nz74QKKeDC/t/zsXkhzVouZtsUTvkO4HuIxpF7CpIrGmxAkv/PHDU
         J25zuvAhUI8bghZvPD9yeCsfG0FbPomWMQ/8Y53g9slDGufPjUc/Z9cuWSc+76NGp4BD
         XCl1SwcMLGSTiGy9mIkv1FPFqVdRwjV98cGWTRAnvq3xchc5z91aYO0XFTbrZG+YNwLx
         eQpY18hmafLOKhJ3Vf3H5yYK942rm4r4/fxxgot1kKuFpIpzvGySY16jXxEstPS1hGyL
         iR5g==
X-Gm-Message-State: APjAAAXLtypLMdoKgecCgCRtz0Yr2hgfoEQjTOt+4lb7FD7Pa14g8xe8
        486qeBI4Pdud1v/RpDpqlL+kFsDQKlxx8Q==
X-Google-Smtp-Source: APXvYqxzMrP2D5ZzrLAYaBWkVH2L28m0YcGTC7+Z7kXk+2/5CVj1sqzL3v/Efii6pT1sIn+xsjxZRA==
X-Received: by 2002:a5d:914e:: with SMTP id y14mr7866978ioq.77.1557637049553;
        Sat, 11 May 2019 21:57:29 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id p132sm5826685ita.2.2019.05.11.21.57.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 21:57:28 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Cc:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Subject: [PATCH] selftests: pidfd: Create .gitignore to include pidfd_test
Date:   Sat, 11 May 2019 22:57:11 -0600
Message-Id: <20190512045711.4507-1-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Create /selftests/pidfd/.gitignore which holds the following file name
created after compiling:

	- pidfd_test

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 tools/testing/selftests/pidfd/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/pidfd/.gitignore

diff --git a/tools/testing/selftests/pidfd/.gitignore b/tools/testing/selftests/pidfd/.gitignore
new file mode 100644
index 000000000000..822a1e63d045
--- /dev/null
+++ b/tools/testing/selftests/pidfd/.gitignore
@@ -0,0 +1 @@
+pidfd_test
--
2.20.1

