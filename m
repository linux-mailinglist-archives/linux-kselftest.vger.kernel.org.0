Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6772F3BF443
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jul 2021 05:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhGHDVM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jul 2021 23:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhGHDVM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jul 2021 23:21:12 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBC3C061574
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Jul 2021 20:18:31 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id h3so5179184ilc.9
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jul 2021 20:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9T+utMZuunfx662ohPO94qoZtpTEcl7gy4ZtO3dCnRk=;
        b=RSFOn9Fyok6NqB6pVJQsWOINqg0fmGywAVRJbO8VT6wIV8nJTWJv0VjXUDq1d7xFCm
         oONM6pJJiLpqrTerV+tgbfuzZ2t6qXZittqvUUEOKcz/vYJ4E4MJxpdl0kBcwXXuhbI8
         UbRIJvm+kscN6mkL/+AtibUwKbMfCyWqE9M84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9T+utMZuunfx662ohPO94qoZtpTEcl7gy4ZtO3dCnRk=;
        b=mS+2gBGx3WIzU9akhNfRny3H+FFVXrF+xVIBTc2bNO51r6rtUWmi7ptX9kLayltk0N
         qS6YjK9IuLR9iu9Y267KXaJHiP70NFEAgQiwX+EILgoFI+9CZYanjt29mQ5+IrrXcNW1
         RMRAWVF2x+cYrSnOcczK0Zb/Ail9PhnI81hMjvBSpUv5fFayC/27ny/ctSDRlBMlYFrM
         DtfXG3BKzyBIFXNvP7xgeUNhB97aNKLuL1qEL5sukWJzOi2CAWTbgVRx/jGDbjXuH1Hi
         Y3sh8uDkAyjrcOxMtczJUtvX80TTOGjNFat2euntomWOcHa/6xMaBRDSI4nfm+jmS9Te
         L7TA==
X-Gm-Message-State: AOAM53148kqzLOhqE+BDXDRljKUZnu1LLSl26D/x5XXg3AUmLIw4WK1/
        DXQLwP3VrrI39imHES0Vk/b+KA==
X-Google-Smtp-Source: ABdhPJyejhApA3rWl1rQFA3BRKanF3qwZu4S5QEagZ+XdsLOO5j3FEbgQLk3H5iWq00V0EGztof2yg==
X-Received: by 2002:a05:6e02:78c:: with SMTP id q12mr7884200ils.243.1625714310809;
        Wed, 07 Jul 2021 20:18:30 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g12sm450538ioc.25.2021.07.07.20.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 20:18:30 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, gregkh@linuxfoundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: firmware: Fix ingonred return val of asprintf() warn
Date:   Wed,  7 Jul 2021 21:18:27 -0600
Message-Id: <20210708031827.51293-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix the following ingonred return val of asprintf() warn during
build:

cc -Wall -O2    fw_namespace.c  -o ../tools/testing/selftests/firmware/fw_namespace
fw_namespace.c: In function ‘main’:
fw_namespace.c:132:2: warning: ignoring return value of ‘asprintf’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
  132 |  asprintf(&fw_path, "/lib/firmware/%s", fw_name);
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/firmware/fw_namespace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/firmware/fw_namespace.c b/tools/testing/selftests/firmware/fw_namespace.c
index 0e393cb5f42d..4c6f0cd83c5b 100644
--- a/tools/testing/selftests/firmware/fw_namespace.c
+++ b/tools/testing/selftests/firmware/fw_namespace.c
@@ -129,7 +129,8 @@ int main(int argc, char **argv)
 		die("mounting tmpfs to /lib/firmware failed\n");
 
 	sys_path = argv[1];
-	asprintf(&fw_path, "/lib/firmware/%s", fw_name);
+	if (asprintf(&fw_path, "/lib/firmware/%s", fw_name) < 0)
+		die("error: failed to build full fw_path\n");
 
 	setup_fw(fw_path);
 
-- 
2.30.2

