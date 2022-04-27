Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73010511621
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Apr 2022 13:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiD0LFj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Apr 2022 07:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbiD0LDU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Apr 2022 07:03:20 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDE72C7126
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 03:52:47 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id k29so1143626pgm.12
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 03:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=RgEFr0uLT67sHk1gOjDIqYdjt6R7MCkT+W0SXI48Bs8=;
        b=Z0VAh8aKgyeLalHF5C52B6iumRPhS4g7UWyx8hJDH7rEme+wXxt8FSwoGRXFlsbTY3
         YkB0MtCXbuYSAcW6ZvIoxMn7iLhnftelTJoK7QdjMlg+CJ83NNMI4x9t5qEW41CaKX44
         wLuBvps9fq2jpaQNHg6iue/Bbh73+thSRUqfEpXt6W6piqa6Fxcn9bA8asfETYy3PO2T
         teUqdTDVporKbocBnG3HcUQ9aMGxu/EHHD9eML49rlbQiS5PHyzSnmAZnjN7Zbl4gzno
         GWptP/ILB7Hzw68NbOzwqLCIPp7UbDWPyJhxcob5er/0plpPWOKpks3onQxB0x4/TqXB
         4mwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=RgEFr0uLT67sHk1gOjDIqYdjt6R7MCkT+W0SXI48Bs8=;
        b=v20m0AXH2t0lGNqX1H18b0zBSXs+PrefxqvFwYiwO/9KAYFyHiBf6q0waKx8RHF6hK
         NfIZ259+Hve1rOfSf7tPXzj5GFeTI7FESvk8Yoo1lImnq7lZ0DR9qSqbcMh4K4oe7N90
         EN6F2HYN1Z5IFLXarA8QehESpI5kXN7vIZQ6qV1TxYiac0OlGp5yWsUTnJ5fcumPU+2e
         s5Uif1w8Ly7F0ffygA2RBJK+0VuDwnpgcQ7hoojoVYRmqJv8im9gkl18zPGWrut4LdYo
         YBlPz6suFacnJphTjOuAJjKbk251pYruSoGivtB+eXCo9tD2t6lWpMkvi6c4wErQlHNf
         i6JQ==
X-Gm-Message-State: AOAM5337Bgm0vVwAg895ptiI863jjciRzJ4ARN4Q6Xg2FbL+2kr+IW4W
        NAP8MDPklR0+U1A8zw40ihuZLFmeAjc9pHdXRVs=
X-Google-Smtp-Source: ABdhPJwvl1g4gXQfXwH303FgV8+AYqxGjtPsG9FsIMEH+uUdgWtkB4Wvguul9kujNF/uQcsbY9X5YQ==
X-Received: by 2002:a63:120b:0:b0:3ab:5fff:9b14 with SMTP id h11-20020a63120b000000b003ab5fff9b14mr10281903pgl.71.1651056767348;
        Wed, 27 Apr 2022 03:52:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 64-20020a17090a0fc600b001cd4989fedesm6412836pjz.42.2022.04.27.03.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 03:52:46 -0700 (PDT)
Message-ID: <6269207e.1c69fb81.eff29.f00a@mx.google.com>
Date:   Wed, 27 Apr 2022 03:52:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.18-rc3-18-gc7b607fa9325
X-Kernelci-Report-Type: build
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
Subject: kselftest/next build: 8 builds: 0 failed,
 8 passed (v5.18-rc3-18-gc7b607fa9325)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next build: 8 builds: 0 failed, 8 passed (v5.18-rc3-18-gc7b607fa9=
325)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v5.18-rc3-18-gc7b607fa9325/

Tree: kselftest
Branch: next
Git Describe: v5.18-rc3-18-gc7b607fa9325
Git Commit: c7b607fa9325ccc94982774c505176677117689c
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

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
defconfig+kselftest (arm64, clang-14) =E2=80=94 PASS, 0 errors, 0 warnings,=
 0 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 erro=
rs, 0 warnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, clang-14) =E2=80=94 PASS, 0 er=
rors, 0 warnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig+kselftest (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warning=
s, 0 section mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig+kselftest (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warn=
ings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-14) =E2=80=94 PASS, 0 errors, 0 w=
arnings, 0 section mismatches

---
For more info write to <info@kernelci.org>
