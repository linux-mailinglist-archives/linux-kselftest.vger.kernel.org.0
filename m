Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB9E59899
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2019 12:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfF1Kly (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jun 2019 06:41:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35835 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfF1Kly (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jun 2019 06:41:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id f15so5784351wrp.2
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jun 2019 03:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fn4SHUReevfi7LGNbp5/ZkuKJ+VkXuPKGZp9iPHBRQM=;
        b=FcVGYRR7L2QIhyB2lwKvcYoAwdEZDdkz2dYGOGl9QJJ0ctqjC9CJ1NECXQauijgNJC
         gsIx6qLOunnFDj1aF3VW/2AeIRIEgwooWkCrf7oBEP8OZ677GZqJlEFx5PgSMj/WqHiv
         4yJf0fA26OgX3xlz45arEnpuf+Mg+5TDXv09y3Fcp5OKRoF4EKpxF7pc+/PHxdftHAYZ
         zpYhdtBcHpZI04t9Y6nPUAatQYA+8YtDnG6Bu8LEefRtuMIsp4d8hjuDTTNF8lylo3YK
         TxVuPxoml6kyZo5T4JSTcDUhztUt8ciXSYZ0ZHPaP8zX0d3u5HA4rJCo95yekxcjPWJ3
         HqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fn4SHUReevfi7LGNbp5/ZkuKJ+VkXuPKGZp9iPHBRQM=;
        b=e/ShHNgrnsncJVtxEdZYjCRNLc8EY+xJxPWTAm/pCazH+VrNUYiGBqJVaxTXuG1FSy
         1Rg3AwsrX4G155PeVWKLcOeOy+JUmyNySDRcDK8500TVzAYohufcio8no7L1LBJfc8Hr
         U8RNUPAfSURStomOwnfSonBygWlekbRyZNPeeWNjgxBawDz5CxqgOdyd6bRQwY7vWpev
         mQdz5KUBl/VAsiOeAno+RVO/bMpeu2frwGQbb4Ja+ESR4gRUv+R3ux6lEwwz2BunAl+O
         6osCISc5lO70NqCZx0i1yaqGKNUX8g3FHZ/iNd65zR2U0MSsk+teJGmkkSvo+ZV8vhbV
         rT2w==
X-Gm-Message-State: APjAAAVAXca5+LsSILMNNnKxC0NH/axSwRlPsKblBdZmUblY59NSCMU3
        soJehlA9pfiZeKjHlIN0iBJajQ==
X-Google-Smtp-Source: APXvYqxU+O7Rz4jovQdk7zfCc7KuhQRK+1MN9MQ4NsrOWxTF9ULwMVt/VH0FS/xYrs2HcD4jWM4JvA==
X-Received: by 2002:adf:ec49:: with SMTP id w9mr6913488wrn.303.1561718512837;
        Fri, 28 Jun 2019 03:41:52 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id y184sm1610627wmg.14.2019.06.28.03.41.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 03:41:51 -0700 (PDT)
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
To:     skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     murphyt7@tcd.ie, kraxel@redhat.com, daniel.vetter@ffwll.ch,
        laurent.pinchart@ideasonboard.com, tomeu.vizoso@collabora.com,
        airlied@linux.ie, shuah@kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH] selftests: dma-buf: Adding kernel config fragment CONFIG_UDMABUF=y
Date:   Fri, 28 Jun 2019 11:41:48 +0100
Message-Id: <20190628104148.5314-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The test case drivers/dma-buf/udmabuf need this kernel config enabled

CONFIG_UDMABUF=y

Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 tools/testing/selftests/drivers/dma-buf/config | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/drivers/dma-buf/config

diff --git a/tools/testing/selftests/drivers/dma-buf/config b/tools/testing/selftests/drivers/dma-buf/config
new file mode 100644
index 000000000000..d708515cff1b
--- /dev/null
+++ b/tools/testing/selftests/drivers/dma-buf/config
@@ -0,0 +1 @@
+CONFIG_UDMABUF=y
-- 
2.17.1

