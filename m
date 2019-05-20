Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 383EF23BDA
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2019 17:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388831AbfETPTA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 May 2019 11:19:00 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:39813 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387864AbfETPTA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 May 2019 11:19:00 -0400
Received: by mail-it1-f194.google.com with SMTP id 9so23707610itf.4
        for <linux-kselftest@vger.kernel.org>; Mon, 20 May 2019 08:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8bDPOW4T9PERtlCKjJ2lAbrC2Btl/gUnBtJeF4+SdEo=;
        b=M2FGtec4qwOQA9nWt3yNJamKQbZ6wWHEdQ7BldBsOi2SLF2pp3o3HgjfWthzjXcrkt
         1Hs+/DfFdQxqw0ItBC68YwvtUHfxSDPNMNLezriKfz417YqyxPA0xE315PCzAR3zfJwq
         sD4QG6ggCau9zHe06mjOfQ/XeYTExSpjEdqb9EfyT8q9xhCfiXdOI7D/5lD6jYqoWhyC
         KCI0lBwpSXxLHBGlYkTxZ182lmZPVwPKZjKhBCHRAF5RLHL/2mIcGf0eGvTbEPMZTbFy
         lRnLGTe/ufItgUvJSnsswcjufkJZChaO2cCIaWAhfiTpiBkCBx5/xWGe0JLXpAVpwW/L
         XZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8bDPOW4T9PERtlCKjJ2lAbrC2Btl/gUnBtJeF4+SdEo=;
        b=LSJiDtsLnL5ybzDgwkP0t/TKCqQvB4IAK67m49yvoFYD4Vi8ahfXUCDyMUvt6AJKPL
         8eQ3EPKOSjuY/xeElvs3yB72e4DmpNy1mzQqAsUlFeByXjVCIB1HBpfwePKlnHJMKcnN
         DA/wcUgnhgNv7ZybmwndIAuE1lBlO8de0hRz8msT1NK7owMNxmUqGNNxmHyAeJcXFtcI
         Cy3uOL9VuG110EEu7hYaPWpcbTRFlnCm2L3qZqug+fVqQkSGXKcoEk/FFeYESyZCZiNh
         dIaKG1zn7LL30tZWKyHHVoW+AmN0HpEdlwICn4UUN6Uyyy6VOqR+1rp6X/23A0zyt5V3
         HPaA==
X-Gm-Message-State: APjAAAXsJtYTHDSDFGrzSut4OyZf3d9lXzfhK1wYODhf8v/AYmIVdV9R
        0bra0STZ6+EbVgtTw/Y2EfuaP/24QXU=
X-Google-Smtp-Source: APXvYqxPeWPsR3qi08xbeYLoNXEOxhRXLPb6AbDnMWGKPpAWkaPEec6V+TrN28W/Fq0LTraaojid4w==
X-Received: by 2002:a05:660c:107:: with SMTP id w7mr11276557itj.59.1558365539219;
        Mon, 20 May 2019 08:18:59 -0700 (PDT)
Received: from localhost (c-75-72-120-115.hsd1.mn.comcast.net. [75.72.120.115])
        by smtp.gmail.com with ESMTPSA id s8sm5513436iot.55.2019.05.20.08.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 08:18:58 -0700 (PDT)
From:   Dan Rue <dan.rue@linaro.org>
To:     dan.rue@linaro.org
Cc:     linux-kselftest@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: teach kselftest-merge to find nested config files
Date:   Mon, 20 May 2019 10:16:14 -0500
Message-Id: <20190520151614.19188-1-dan.rue@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Current implementation of kselftest-merge only finds config files that
are one level deep using `$(srctree)/tools/testing/selftests/*/config`.

Often, config files are added in nested directories, and do not get
picked up by kselftest-merge.

Use `find` to catch all config files under
`$(srctree)/tools/testing/selftests` instead.

Signed-off-by: Dan Rue <dan.rue@linaro.org>
---
 Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index a45f84a7e811..e99e7f9484af 100644
--- a/Makefile
+++ b/Makefile
@@ -1228,9 +1228,8 @@ kselftest-clean:
 PHONY += kselftest-merge
 kselftest-merge:
 	$(if $(wildcard $(objtree)/.config),, $(error No .config exists, config your kernel first!))
-	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh \
-		-m $(objtree)/.config \
-		$(srctree)/tools/testing/selftests/*/config
+	$(Q)find $(srctree)/tools/testing/selftests -name config | \
+		xargs $(srctree)/scripts/kconfig/merge_config.sh -m $(objtree)/.config
 	+$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
 
 # ---------------------------------------------------------------------------
-- 
2.21.0

