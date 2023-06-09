Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB0E72A50D
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 22:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjFIU7R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 16:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFIU7P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 16:59:15 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A9230FD
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 13:59:14 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-650c8cb68aeso1959148b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jun 2023 13:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686344354; x=1688936354;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o/nbv8QU8+Uhsj0CuVGum8Z7f7SUSUOBiGBXSuD/tRY=;
        b=0b9X7+DPTpXJ/SwM/3VfdswB62bNufjsEnT6SRY6sP/HRiynZii5NzGDDMOXit8xM/
         NAUyT9vtaGB1JJZlNueb4W0FvH7mNAJ55k9wQVC8SeMOV6VtdpJ6S2vCepdWxwdfW+i2
         yQOVE0mBlMR8bx3atZxcVUWcHN6eo4+ZQY0lpiTBxQEYmVoiNrNZmLlYbfZLGIjpg4TJ
         7XH6iIDd9hO+Nfb38+xYlUdM4jEecSoLlF8aT2rlM+h87MC40QRBUaSp9vuzoqtIcbbC
         FTJXWQWvPlGil9gyM1o8cz7IXacKVawfHtuYoiJ0tXhw6M+0xL4J6sLPdj0SnmsyBITe
         wWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686344354; x=1688936354;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o/nbv8QU8+Uhsj0CuVGum8Z7f7SUSUOBiGBXSuD/tRY=;
        b=IrXioK8/jLw+/T2igA7q/qQVnY1mqBRq8uZC6OnBQ0k1bModW585VnuTi20yfYwi4y
         8u3j5puftCF93huh28UtNB5eMU/O0CSJ/9Kk05xMIoXz2lC6796kr3VDW4cAROPVKXb7
         NzCDM9adXtaCj7RkPzvXgR7EDdjjw4IHd0g2n4C/wL3TR06HtmEbze//z0iDhlky+egh
         h0gbbhTZuzpg2JIOvtXHPzb49mwCEV4ExdLVYWXElzXXE1Zwad0LBr7p9SgFSJFtdkCP
         3GRcwvj7Q3WU7tp91G+VuYtTTMqOzzfB7iPttYmD9A1KLw5f6/2LIhB1GK9S1HAysqpO
         NZsg==
X-Gm-Message-State: AC+VfDwpW84yYsponsJGrl6yoQ6rmkly796xRYRGvyxE5P3/3y8uwbBD
        dcKXGKJTLJh0Sg0xhxAfBTk4qwEd1NZDbJ/JuNuDKQ==
X-Google-Smtp-Source: ACHHUZ70GGJlv2KtLnpvx3W+mxfonumSLjtptyelSRdlaxaxBfv8kODfQ5e0JI5cHguWcaDv2oYOIg==
X-Received: by 2002:a05:6a00:39a8:b0:650:6e3e:a8e3 with SMTP id fi40-20020a056a0039a800b006506e3ea8e3mr2110717pfb.26.1686344353854;
        Fri, 09 Jun 2023 13:59:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q24-20020a62e118000000b0063b85893633sm3014772pfh.197.2023.06.09.13.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:59:13 -0700 (PDT)
Message-ID: <648392a1.620a0220.62524.6743@mx.google.com>
Date:   Fri, 09 Jun 2023 13:59:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.4-rc1-9-gd51a218328e0
Subject: kselftest/next build: 3 builds: 0 failed,
 3 passed (v6.4-rc1-9-gd51a218328e0)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next build: 3 builds: 0 failed, 3 passed (v6.4-rc1-9-gd51a218328e=
0)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.4-rc1-9-gd51a218328e0/

Tree: kselftest
Branch: next
Git Describe: v6.4-rc1-9-gd51a218328e0
Git Commit: d51a218328e0be533ca0b10bc29060aaec70432d
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 2 unique architectures

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
defconfig+kselftest (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest (arm64, clang-16) =E2=80=94 PASS, 0 errors, 0 warnings,=
 0 section mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig+kselftest (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warn=
ings, 0 section mismatches

---
For more info write to <info@kernelci.org>
