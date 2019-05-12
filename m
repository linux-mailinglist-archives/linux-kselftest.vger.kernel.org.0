Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 128E71AABF
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 May 2019 07:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfELFGX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 May 2019 01:06:23 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35701 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfELFGX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 May 2019 01:06:23 -0400
Received: by mail-io1-f68.google.com with SMTP id p2so7586787iol.2;
        Sat, 11 May 2019 22:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xeg85yFiTlLA38EPpfH3RQenJacu06uYlLAYbZoAoDE=;
        b=G99w1uJdOuUJxeFMKxfKbVUNMnTg2YjJQxd0sVMcO+2gHq8Hf+9AFSUCB87keT3RHS
         hSFvr54PII1LjN9UaPdEtQ0mdS6Wt+VK8SjbfZvwgKsyVGxZA8haDfY3rP0X4VvGSHK1
         xpeECpSm/NheJn53wSU6blqxux/8i6B9+pj092CxH0K+5jn8Eg7e2U16FhGz4wTBySW8
         1gfc+oiQywRjzVtxWRGnMwa9aZ2ST/rgCzeBXrh3OI24h2ATXqIFLi4uvmzAb7xokso7
         8Y8o6A0GM1TnS2I9HOk0RIWI4NTWXdSjgGDRFa1fbKQu/7wXLBZz2InPKYzjqBU4RCka
         9cVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xeg85yFiTlLA38EPpfH3RQenJacu06uYlLAYbZoAoDE=;
        b=oP7ct99BYiqRiq352porSstNJiHNl4Ds09kGnk8SwutTqnOSrYETkmTpbRz3Mxaw+h
         dC5cXTVRNJRbzmC9DjcdiOII4sRv2zT9nPmYp7vDnQI+W8u1wNaN78a1Zyt2Rp9pjD1/
         1A9CRH2D5n/9nJDt8DXFI/LJs489sQLmAF9T4oybfrHjK9QljGfVxLGvDrJVYdmGY+r9
         k0P7xBGco/ZiRmqaShz1IWTh2ETCZuQymEGlJtKERBLqECPpgHFDviQnErpRy4Y8lv6R
         hwRqb7Nec6omqBoG2FU505sn4H+O0VdbYeirJynuyTRnOIFVGuNFK/oW9xjjqdEKWFTA
         fPxA==
X-Gm-Message-State: APjAAAXKN3QCxQIoE0Xf8jWvb8dLtjjln/6LztAkgONy8NlMA1V2H7WM
        DrvRg72Q400Xa/mqU26lvzph7YDamkpTNA==
X-Google-Smtp-Source: APXvYqyevueinWgI93ZaC+5/E9etHikt4hymS4n07ALDnCDnhULW2dfj5MPLpp+EhkWRepE/f0IhSw==
X-Received: by 2002:a05:6602:2247:: with SMTP id o7mr3518478ioo.156.1557637582375;
        Sat, 11 May 2019 22:06:22 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id j84sm4276622ite.23.2019.05.11.22.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 22:06:21 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Cc:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Subject: [PATCH] selftests: drivers: Create .gitignore to include /dma-buf/udmabuf
Date:   Sat, 11 May 2019 23:04:52 -0600
Message-Id: <20190512050452.4720-1-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Create /selftests/drivers/.gitignore which holds the following file name
created after compiling:

	- /dma-buf/udmabuf

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 tools/testing/selftests/drivers/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/drivers/.gitignore

diff --git a/tools/testing/selftests/drivers/.gitignore b/tools/testing/selftests/drivers/.gitignore
new file mode 100644
index 000000000000..f6aebcc27b76
--- /dev/null
+++ b/tools/testing/selftests/drivers/.gitignore
@@ -0,0 +1 @@
+/dma-buf/udmabuf
--
2.20.1

