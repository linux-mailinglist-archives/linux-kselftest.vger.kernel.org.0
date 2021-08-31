Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF983FC642
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Aug 2021 13:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241033AbhHaKsL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Aug 2021 06:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237852AbhHaKsL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Aug 2021 06:48:11 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2F1C061575;
        Tue, 31 Aug 2021 03:47:16 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so1663637pjr.1;
        Tue, 31 Aug 2021 03:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a5gyd43f5zC4BpSnVHpfbLGSISBJk03DFe0K9GmEp+s=;
        b=dkpsii4jDYLZWoAFDWWH1iacNBfspn+R84S8krXcfYJj1mAMG9OkrCuvL/6ymyLmRk
         a8g7CG50q0EikxFK8EEHJBgP1xiDyGNxEWAIJ70ZqAQz8lGXjcLcfyDQvoYAVu91kfdO
         5y9PElt7vz7HHcmVsHfuf2MEozOPZdLTXjHaIyx7brDEchZwH5lveG0oZ0z3OOjFovem
         Qt1WzzvmWnp1u87O5L/hl8y9XHYZDAKxhrZ8GCCMHZ10vJVXc8D077ErSuEfd7vcI2zf
         t2cSMCB6zz8jpkz7Q4r0kmRT++TGUgaR8ipjkOYTmf+U/QvnBwALZA17t607TYmH73/3
         Mnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a5gyd43f5zC4BpSnVHpfbLGSISBJk03DFe0K9GmEp+s=;
        b=Vw9s1JH44kZ7HPnozDPFVhCwdTm1QBn+6HoVtokyZ9drf7pRvUWma2mA73cA70uJmU
         3iM38KbRIhvzWGE1VOnbfFgi2jw3zt+COuvILcXehUwQRidXI8rKF059+LAGiIMgejA9
         M4TwG77Ten2yNXwx9vLLIFSS5sJGvgrSmbTwGnOlwKBfZKiS1mPIrowM2vhk+fxPQE6N
         uEViknLN7Ks19xNjgUm9GeVAf0c7knfGjZORdDQ3NhbcP+ETUqHvoGmjoAP9FuLMiYYL
         7DEEboVapC/HjdIIC4NRLxBF1a9yxSA2yCn88esaKdoY3hiHkkI/hLV5UXPFh16+nYe3
         XnnQ==
X-Gm-Message-State: AOAM532rJNsgR/iAbkAwx+XrlbAWNDtxGxMNDmecd6nPKsF6S0pQDBm3
        zhbHGgtsQgAXvPBA1m+GPkM=
X-Google-Smtp-Source: ABdhPJzQcWtSfoph9uR44Q9vqBfL3YpVWD7U1Q4HHpncwCs6AMpDbWZVH+SBD+p+OdfYFM5ETUQe1A==
X-Received: by 2002:a17:90b:1c8c:: with SMTP id oo12mr4674452pjb.170.1630406835935;
        Tue, 31 Aug 2021 03:47:15 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u62sm17542795pfc.68.2021.08.31.03.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 03:47:15 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     bamv2005@gmail.com
Cc:     shuah@kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chi Minghao <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] selftest: gpio: undeclared variable
Date:   Tue, 31 Aug 2021 03:47:07 -0700
Message-Id: <20210831104707.16667-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Chi Minghao <chi.minghao@zte.com.cn>

Add undeclared variable

Fixes: shortid ("undeclared variable")
Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Chi Minghao <chi.minghao@zte.com.cn>
---
 .../testing/selftests/gpio/gpio-mockup-cdev.c | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/testing/selftests/gpio/gpio-mockup-cdev.c b/tools/testing/selftests/gpio/gpio-mockup-cdev.c
index e83eac71621a..83a32b8835d3 100644
--- a/tools/testing/selftests/gpio/gpio-mockup-cdev.c
+++ b/tools/testing/selftests/gpio/gpio-mockup-cdev.c
@@ -15,9 +15,66 @@
 #include <unistd.h>
 #include <sys/ioctl.h>
 #include <linux/gpio.h>
+#include <linux/const.h>
+#include <linux/ioctl.h>
+#include <linux/types.h>
 
 #define CONSUMER	"gpio-mockup-cdev"
 
+#define GPIO_V2_LINE_NUM_ATTRS_MAX 10
+#define GPIO_V2_LINES_MAX 64
+#define GPIO_MAX_NAME_SIZE 32
+
+#define GPIOHANDLE_REQUEST_BIAS_PULL_UP	(1UL << 5)
+#define GPIOHANDLE_REQUEST_BIAS_DISABLE	(1UL << 7)
+#define GPIOHANDLE_REQUEST_BIAS_PULL_DOWN	(1UL << 6)
+#define GPIO_V2_LINE_GET_VALUES_IOCTL _IOWR(0xB4, 0x0E, struct gpio_v2_line_values)
+#define GPIO_V2_GET_LINE_IOCTL _IOWR(0xB4, 0x07, struct gpio_v2_line_request)
+
+enum gpio_v2_line_flag {
+	GPIO_V2_LINE_FLAG_ACTIVE_LOW = _BITULL(1),
+	GPIO_V2_LINE_FLAG_INPUT	= _BITULL(2),
+	GPIO_V2_LINE_FLAG_OUTPUT = _BITULL(3),
+	GPIO_V2_LINE_FLAG_BIAS_PULL_UP = _BITULL(8),
+	GPIO_V2_LINE_FLAG_BIAS_PULL_DOWN = _BITULL(9),
+	GPIO_V2_LINE_FLAG_BIAS_DISABLED	= _BITULL(10),
+};
+enum gpio_v2_line_attr_id {
+	GPIO_V2_LINE_ATTR_ID_OUTPUT_VALUES = 2,
+};
+struct gpio_v2_line_values {
+	__aligned_u64 bits;
+	__aligned_u64 mask;
+};
+struct gpio_v2_line_attribute {
+	__u32 id;
+	__u32 padding;
+	union {
+		__aligned_u64 flags;
+		__aligned_u64 values;
+		__u32 debounce_period_us;
+	};
+};
+struct gpio_v2_line_config_attribute {
+	struct gpio_v2_line_attribute attr;
+	__aligned_u64 mask;
+};
+struct gpio_v2_line_config {
+	__aligned_u64 flags;
+	__u32 num_attrs;
+	__u32 padding[5];
+	struct gpio_v2_line_config_attribute attrs[GPIO_V2_LINE_NUM_ATTRS_MAX];
+};
+struct gpio_v2_line_request {
+	__u32 offsets[GPIO_V2_LINES_MAX];
+	char consumer[GPIO_MAX_NAME_SIZE];
+	struct gpio_v2_line_config config;
+	__u32 num_lines;
+	__u32 event_buffer_size;
+	__u32 padding[5];
+	__s32 fd;
+};
+
 static int request_line_v2(int cfd, unsigned int offset,
 			   uint64_t flags, unsigned int val)
 {
-- 
2.25.1

