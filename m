Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8236D0320
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Mar 2023 13:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjC3L2i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Mar 2023 07:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjC3L2g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Mar 2023 07:28:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3AF10A
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Mar 2023 04:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680175674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mP3bbqGIQpGVaDAwKG9q83wIQ8xRswQTNXCbZ2Tr0P4=;
        b=NGohBcH7pB14hVr263NkZNMDWUo08DP+AqtRhxN//1d9ADtRLY/567Aj1Vpm0YOKZluHVa
        qBwXoxkW1mK4oLVWNEzar70TlGHhsrlfPGtxEfN1Yaesjx1XuHoyHZObXQlWonLfgYbB/K
        rBka/51KnSWbqQfIvpCmHbL7sJh7yZ4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-e0B7RHtNOcqfNW9NzFihDw-1; Thu, 30 Mar 2023 07:27:53 -0400
X-MC-Unique: e0B7RHtNOcqfNW9NzFihDw-1
Received: by mail-wm1-f71.google.com with SMTP id fm14-20020a05600c0c0e00b003edd7388c79so1267973wmb.1
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Mar 2023 04:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680175672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mP3bbqGIQpGVaDAwKG9q83wIQ8xRswQTNXCbZ2Tr0P4=;
        b=th+Zz5Fem933U9UlGRVlR+kW8R/e/VMfyIhXygSXR34xSu5j1unbRdXVmVD4jg4+zz
         F21iDeYg6oc1hh1NhRZaDxDHy/TxRg2x7m18NRa0BopTYfP9XPnz9LRamtZ5rcYxbMrL
         2/sRt1InXIK6qC6MHd33zllZLktbECpRRDav7byRmzewis/GudaNArwgNqcJjWfYFYzr
         LEUz04peSYqPgTvzcNZ9E6LVaTo4rQEJecZCz/J3lKEM3sk6ir5COr69KLNoUTsKrj6s
         JfImoF6ncAWhL0QrmEpLLW6QgtgvP1zASKFUOZU0HEH3imLpnY2Zj61nEtP0uXe/brM5
         ACqg==
X-Gm-Message-State: AO0yUKWfy2Aos5uw/P5iKYdQiMkJSJcb3gtPAU6Imr5HtVgEVrad+319
        czQkP7w1fr9tqkwmKDgtC3qLtwTkRSeMlMBT1s7m5Jq17RUVn1CheXxT9t3TA+a1aS6OAQNRDPP
        vNNY7Gyb/oaJE+tZUZv+LP2ukUoKz
X-Received: by 2002:a1c:7714:0:b0:3ee:3f7:35aa with SMTP id t20-20020a1c7714000000b003ee03f735aamr19451861wmi.19.1680175672249;
        Thu, 30 Mar 2023 04:27:52 -0700 (PDT)
X-Google-Smtp-Source: AK7set+jEH09nINjs+jtTwMM7aUYIujL4lWIxtVBADGTYrhVrSQ7/64CBx3dKj/4yxcO08CjwA5IMA==
X-Received: by 2002:a1c:7714:0:b0:3ee:3f7:35aa with SMTP id t20-20020a1c7714000000b003ee03f735aamr19451843wmi.19.1680175671968;
        Thu, 30 Mar 2023 04:27:51 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f18-20020a1c6a12000000b003ed2276cd0dsm5510940wmc.38.2023.03.30.04.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 04:27:51 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
        linux-kselftest@vger.kernel.org, David Gow <davidgow@google.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Enric Balletbo i Serra <eballetbo@redhat.com>,
        kunit-dev@googlegroups.com, Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Gaynor <alex.gaynor@gmail.com>, Andrew Davis <afd@ti.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: [PATCH] .gitignore: Exclude KUnit config dot-files
Date:   Thu, 30 Mar 2023 13:27:42 +0200
Message-Id: <20230330112743.2331141-1-javierm@redhat.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There's a rule to ignore all the dot-files (.*) but we want to exclude the
config files used by KUnit (.kunitconfig) since those are usually added to
allow executing test suites without having to enable custom config symbols.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 70ec6037fa7a..7f86e0837909 100644
--- a/.gitignore
+++ b/.gitignore
@@ -103,6 +103,7 @@ modules.order
 !.get_maintainer.ignore
 !.gitattributes
 !.gitignore
+!.kunitconfig
 !.mailmap
 !.rustfmt.toml
 

base-commit: ffe78bbd512166e0ef1cc4858010b128c510ed7d
-- 
2.40.0

