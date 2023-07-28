Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B6476735A
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 19:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjG1R3h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 13:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbjG1R3f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 13:29:35 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB343A81
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 10:29:33 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7748ca56133so23306839f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 10:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690565372; x=1691170172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dT09jtLuy7a5zKnUmbIcfbqwcSckF6Rn16/QMnBw9d4=;
        b=ik1kl2QQs6gPAyqKxmdly76qC7JHXn+5QGW4RI0PwbnJ0R/L395Y9sycGvRLYDQcZy
         nOWDXXXddSS5rl784gp45eNnu+DdKmIEWVUWQ4TW9vyspok+cwRiIAg60ADmJe70X1CY
         7kz/kUN29oVvwFQAhtrdsqOTTt+2KHcw/wuMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690565372; x=1691170172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dT09jtLuy7a5zKnUmbIcfbqwcSckF6Rn16/QMnBw9d4=;
        b=HpanWRhyj5A0Je0LPLFmBJt4OI+NFAl7nIy6w9vT2YijL2hMr0jEiXH1HEO2IasQJD
         tLJ1N7L3C7izIpxnrxof7XoJQCPBbMwqxaK+czUEgi5Okn0j2X4c34a2RMTmMddjVTpE
         wU21jFfwySYvrhtxle4Rk3C2ejzY6ZCYgwpkVhSr2G4Jmnv090RVbtz0elWMi64XyOSr
         qv8v7hElqseUoHBcT9wv2oImlI/apmYsPotjTAkXuJ9gd0yL4PmpwLEZxocXpSWh1qMc
         yU5AWAWORVadq9n5TcwGiPz7+IH8wJ/DGVEt0tVMeEzkyrQY/W9yTdcLs2/KRarSrpH2
         polA==
X-Gm-Message-State: ABy/qLbUPic5yT8m0h6luLvXRPQqy479wTTLd5uzdlptUDHbu9afXsvl
        Vpnh73vAPWWO44cJCUuDZRs4TQ==
X-Google-Smtp-Source: APBJJlE1OMp2GGXg6HYJsYLE/2Pq79PXrP4ciLYxaRJN/m5Tq3XeasWWvCny30uP2LXSkucWtGutdw==
X-Received: by 2002:a6b:c9d3:0:b0:788:2d78:813c with SMTP id z202-20020a6bc9d3000000b007882d78813cmr248574iof.0.1690565372321;
        Fri, 28 Jul 2023 10:29:32 -0700 (PDT)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id b2-20020a029a02000000b0042b37dda71asm1181050jal.136.2023.07.28.10.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 10:29:31 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, Liam.Howlett@oracle.com,
        anjali.k.kulkarni@oracle.com, kuba@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH next 2/3] selftests:connector: Add .gitignore and poupulate it with test
Date:   Fri, 28 Jul 2023 11:29:27 -0600
Message-Id: <e3d04cc34e9af07909dc882b50fb1b6f1ce7705b.1690564372.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1690564372.git.skhan@linuxfoundation.org>
References: <cover.1690564372.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add gitignore and poupulate it with test name - proc_filter

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/connector/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/connector/.gitignore

diff --git a/tools/testing/selftests/connector/.gitignore b/tools/testing/selftests/connector/.gitignore
new file mode 100644
index 000000000000..c90098199a44
--- /dev/null
+++ b/tools/testing/selftests/connector/.gitignore
@@ -0,0 +1 @@
+proc_filter
-- 
2.39.2

