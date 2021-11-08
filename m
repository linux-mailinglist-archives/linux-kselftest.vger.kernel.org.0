Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26339447847
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Nov 2021 02:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbhKHBcT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Nov 2021 20:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235738AbhKHBcQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Nov 2021 20:32:16 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBC8C061746;
        Sun,  7 Nov 2021 17:29:30 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so3347835pjj.0;
        Sun, 07 Nov 2021 17:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0JNyHVD+1yzYEJ3JLaSRpORJwWMNkeDq20AnIcFvt5s=;
        b=k6BotfM2pSNgoWcsxY0UsqpuveBSB96Sr4cxHSa0Q0M7n5eeMdIeH3dYksvi5Z42mu
         8P7vZe6/QrjJUayqUjhL65M/pXmRNf4iI3DokaBQiNHFFZGOdYj0y7zeepPFFX4EKqyF
         BITF+0h1Ckcp9q3GiEmBJAZWAWZxN52l6bZR3OhQf/rwsNdXI9h+w0Vm8NA+W3MqjM8H
         fnar/6YqATXA+JW/0uEu+elWqZC1gXMwSjFx7mux1G6GfJISG0ccmuEnBS/drIJ9vq+N
         Bopf0tmv+z1LcBUYuxSiOPkngGbu/7vkRCCFoCRGXPoV4ak32ZdN1z34JIUPr70+oaS1
         S0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0JNyHVD+1yzYEJ3JLaSRpORJwWMNkeDq20AnIcFvt5s=;
        b=tHHu2a2jQUnGcq7viLG8mCHBeFVcGnqq13okSZZqh4Jqu+0fcpBAyjLPY5mtiXt6CE
         nuFQttBs+JlVPBIv4J3N/K8XBPdWHFAqEb7RbOxxc58Ti73ieUx1S6OfAgBBwm/519ps
         kadyeHs7llj9PRb9PHwbm6FEkpq+pHUa4zjfkmLBE3pH7zcmhZuhOD/qml9ZSvEHLmKb
         QTazS+p2VW8Y/1mTO35Ki/03m+OfCcOZa6Xuk6ej3PcuHPGa9+Ai6rjlBb6osxVP2NT2
         MjcbZrCVQnp92jBI8LCU8jXkS8yQx4O9IXrIkI7MASl+DqRw/7wn/2nE2Lc5XbDJyhw3
         s1Sw==
X-Gm-Message-State: AOAM533Hij/kwm4DK5kZPXZY5WYhTWgZznqO+eZw464p6m1met+q9Ax9
        TzoV5EH9JuISvf4fMQIQqPj7DO9f1gn7Gw==
X-Google-Smtp-Source: ABdhPJyVwgGxtocafh4Qw1aloohujgKREoDKJOaxND/DSBjIdQPX7sLx00BtGKgZGsk7MNy3kbhb6A==
X-Received: by 2002:a17:902:9a91:b0:138:efd5:7302 with SMTP id w17-20020a1709029a9100b00138efd57302mr66963409plp.35.1636334970050;
        Sun, 07 Nov 2021 17:29:30 -0800 (PST)
Received: from sol.lan (14-201-12-235.tpgi.com.au. [14.201.12.235])
        by smtp.gmail.com with ESMTPSA id t4sm13800861pfj.166.2021.11.07.17.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 17:29:29 -0800 (PST)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org, brgl@bgdev.pl,
        linus.walleij@linaro.org, shuah@kernel.org, bamv2005@gmail.com,
        lizhijian@cn.fujitsu.com
Cc:     kernel test robot <lkp@intel.com>,
        Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 1/3] selftests: gpio: fix gpio compiling error
Date:   Mon,  8 Nov 2021 09:28:49 +0800
Message-Id: <20211108012851.7772-2-warthog618@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211108012851.7772-1-warthog618@gmail.com>
References: <20211108012851.7772-1-warthog618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Li Zhijian <lizhijian@cn.fujitsu.com>

The gpio selftests build against the system includes rather than the
headers from the linux tree.  This results in the compile failing if
the system includes are outdated.

Prefer the headers from the linux tree, as per other selftests.

Fixes: 8bc395a6a2e2 ("selftests: gpio: rework and simplify test implementation")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
[Kent: reworded commit comment and added Fixes:]
Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 tools/testing/selftests/gpio/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index 39f2bbe8dd3d..42ea7d2aa844 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -3,5 +3,6 @@
 TEST_PROGS := gpio-mockup.sh
 TEST_FILES := gpio-mockup-sysfs.sh
 TEST_GEN_PROGS_EXTENDED := gpio-mockup-cdev
+CFLAGS += -I../../../../usr/include
 
 include ../lib.mk
-- 
2.33.1

