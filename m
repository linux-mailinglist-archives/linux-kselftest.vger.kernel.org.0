Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F957B8143
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 15:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbjJDNrv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 09:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbjJDNru (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 09:47:50 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0259B;
        Wed,  4 Oct 2023 06:47:46 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9a645e54806so391646566b.0;
        Wed, 04 Oct 2023 06:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696427265; x=1697032065; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=egYHGEuBl8zKyk92amOjilTnvvJywQYkpCyOuM9tLHY=;
        b=KBEUNWx2P4To1zKYcEtQW2nnl6I+bFiYRTDMTGTBqZK7ySyhbdwpIA4PZrK0hkg4to
         f9nirExV+pLGUi1mpIsmRknWKDQ2MThvop3ydz2Pk20K2dX1HxPW8rs14h4H/KCvHqU3
         gJR6XrrajYkvmVZdJAgCm9KAcWS+rk3G6P/+rktF2BrOiCYlK5S7n0mvW2MDIyhY8WVV
         52Y62zqWScOrxIgmxPFrASdAul7cD2zKS/JD+SUHUyZMh7oBZdtNsuSs2Osxx6mDFk1r
         hbaSH3qa7K2TBfSQz1zQBZ2thoLXOdrI2259vjAqBnahWowD+7MNSkvcHpvQza+eygxy
         S/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696427265; x=1697032065;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=egYHGEuBl8zKyk92amOjilTnvvJywQYkpCyOuM9tLHY=;
        b=kz73KRpW3Uf2jFRNuOrloP6TLwrQZhe2nUcoJFB9bHPXdhWsGIGblhzTc8BdB/vd0i
         Ll4wlrnY0saMbYnRumZg2BYiypvcG3RyBMOECKCGE3hcqUAptivMsbE2rQTiYvdZXTda
         4hyQFeFqF66f4cHqAok+6fdX2KKZW3TG8ANV+Ne84FpKSHDalrHVOX0/RW7B8hwb7vr+
         QtS3cDDAWTb3wIGKgh9T+8fx5awP0mpei25EFK9UK7QDHzCR6QwM7lsxPw3eCZ/agJdd
         QCoaBVzA+BzIMzXk+mEoIxAjb9aNWAwpOg9lLQkHYvjn2ZzqpakdRDxDugHnAuj+Hmz5
         kJBg==
X-Gm-Message-State: AOJu0YyGOH6et95ey0tnMmTayATdM14DGC427ZW2j62ZxVBXoWbWsxEo
        SxFKCRl1MG5W6/h1rJjpB+NAoA4MiADNCA==
X-Google-Smtp-Source: AGHT+IFWtJm+2TsFh7qSvpmY+DpsY9a8CA5z2wDlH2swnDl0IPK1nYdCBableT2ajMPRWuXbuQnsqw==
X-Received: by 2002:a17:907:7711:b0:9b2:a96c:9290 with SMTP id kw17-20020a170907771100b009b2a96c9290mr2067154ejc.33.1696427264915;
        Wed, 04 Oct 2023 06:47:44 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id kf1-20020a17090776c100b00992f2befcbcsm2805593ejc.180.2023.10.04.06.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 06:47:44 -0700 (PDT)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/3] selftests: add gitignore files to user_events, tdx and
 dmabuf-heaps
Date:   Wed, 04 Oct 2023 15:47:40 +0200
Message-Id: <20231004-topic-selftest_gitignore-v1-0-40689bcd23e2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPxsHWUC/x2NSwrDMAxErxK0rsG/RelVSimOKzuC1g6SCIWQu
 9fp8jHzZnYQZEKB27QD40ZCvQ1wlwnyklpFQ6/B4K0PztpotK+UjeC7KIo+KynV1hlNwKsvMcT
 RcjD0OQmamVPLyznwSaLIZ7AyFvr+P++P4/gBxV9BX4MAAAA=
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696427264; l=764;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=hNbMKfIZ1/m8KY1PFlvjO0yUr1I8QIssp/js5MXQ574=;
 b=g/ReUmVPGJgmxo9JKp6VBvkYMKYssACExpLenQAI2FcwzZNA9AABwJQNlnXmlQeJaOGR1GGOi
 iDlm8NwZfm2D8W35N5xXPoc0IkuUp5hH+wet4eSAwNb4drVYGy60nyg
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

user_events, tdx and dmabuf-heaps build a series of binaries that can be
safely ignored by git as it is done by other selftests.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (3):
      selftests/user_events: add gitignore file
      selftests/tdx: add gitignore file
      selftests/dmabuf-heaps: add gitignore file

 tools/testing/selftests/dmabuf-heaps/.gitignore | 1 +
 tools/testing/selftests/tdx/.gitignore          | 1 +
 tools/testing/selftests/user_events/.gitignore  | 4 ++++
 3 files changed, 6 insertions(+)
---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231004-topic-selftest_gitignore-3e82f4341001

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

