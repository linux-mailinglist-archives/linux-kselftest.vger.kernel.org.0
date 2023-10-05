Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A2D7B9FD3
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Oct 2023 16:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbjJEOaP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Oct 2023 10:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjJEO2n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Oct 2023 10:28:43 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E187226A6E
        for <linux-kselftest@vger.kernel.org>; Thu,  5 Oct 2023 05:56:40 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32329d935d4so878891f8f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Oct 2023 05:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696510599; x=1697115399; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HH/Udjjj3CtptJmCoUEp/CvYHR6TzyFaMzpT2cZzJKc=;
        b=fJVA7IV9cEKiADBa+dOdv8ZGgYkAqUyOISKkCitQ9QJZdjjCoBo5mQrtyDPyox4Kts
         GQSB1MPd2BzPpSLYe5m6BSkGBSODn5Q6j+YooNwLlFWRtI+aNHAVXbMpgvBgln48Apc1
         PAwdGN6dS5Icvdr5eapL/cKbB87dEtR716EqkLBB8PcklP0cZ6OLIDT832+7LSHuByhD
         ZbE0QZ9IAh4uuKTVeBJg+S7427YKN9cXCdO/HEIXbCWkjW4K6WPmZ0/CDdnd7ylCXNui
         CgGtRS6KnAuCukUvf3d1Sfs3r2oNA+Y3I9FCpY0Uz1/q5vI38/7eBAH1kzEFm/9UhvZ6
         xjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696510599; x=1697115399;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HH/Udjjj3CtptJmCoUEp/CvYHR6TzyFaMzpT2cZzJKc=;
        b=hejVMkTQFJwlIVbW3nyRbHrlA5ug8icPBH0/XS4jUeFqTUinpu/tE67Ez31ZbZR8AQ
         8hzn0EGhHVpEK4AmlvkhkEb//ENmXOnV11HTPm2pWmTsB4BTDHrL/beU+KZKbkCfclkL
         YEYxvrA9RYMzoF4NCwkY43Zzt7vM8gP55FPY8+jRbpvKCbCI2jPAOusa3xWwP26QgpU8
         8bNE2QZrs4qzi9UF5hx1TaxCxdkbDJCd71S40yKhxiiAcWj9ojWRet7fH6aq9ENiNs9o
         Sj0t80Id+4/ld6DdF3WMQcuZTOam4Po8/kGN1xlVLpj4DAGRVD6R0F5G7nu09vDTu3gr
         xyXQ==
X-Gm-Message-State: AOJu0YxlCcpMsFazSIEv21wOwCpvYu9NAq2T1A9k3TiXTIRDWQUm9wS4
        K2Ad++iwMsij5jM16M/sHmwD9ThRcSu7Qovy56E=
X-Google-Smtp-Source: AGHT+IEsb5dGZ2g6wqoU+6uB/clNw7zodjaFFHmB25QFHtw9YYrZ8zHoHNanFetas/GnW3OPzWBJtw==
X-Received: by 2002:adf:dd83:0:b0:314:15b7:20a5 with SMTP id x3-20020adfdd83000000b0031415b720a5mr4602845wrl.54.1696510599313;
        Thu, 05 Oct 2023 05:56:39 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e13-20020a5d500d000000b003259b068ba6sm1756363wrt.7.2023.10.05.05.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 05:56:38 -0700 (PDT)
Date:   Thu, 5 Oct 2023 15:56:35 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     ruanjinjie@huawei.com
Cc:     linux-kselftest@vger.kernel.org
Subject: [bug report] kunit: test: Fix the possible memory leak in
 executor_test
Message-ID: <61a208ab-8052-4b05-b18f-5edd2b7af2ce@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Jinjie Ruan,

The patch 8040345fdae4: "kunit: test: Fix the possible memory leak in
executor_test" from Sep 27, 2023 (linux-next), leads to the following
Smatch static checker warning:

	lib/kunit/executor_test.c:276 free_suite_set_at_end()
	error: potential null dereference 'free'.  (kzalloc returns null)

lib/kunit/executor_test.c
    268 static void free_suite_set_at_end(struct kunit *test, const void *to_free)
    269 {
    270         struct kunit_suite_set *free;
    271 
    272         if (!((struct kunit_suite_set *)to_free)->start)
    273                 return;
    274 
    275         free = kzalloc(sizeof(struct kunit_suite_set), GFP_KERNEL);
--> 276         *free = *(struct kunit_suite_set *)to_free;
                ^^^^^
Static checkers always try to encourage people to check allocations.

    277 
    278         kunit_add_action(test, free_suite_set, (void *)free);
    279 }

regards,
dan carpenter
