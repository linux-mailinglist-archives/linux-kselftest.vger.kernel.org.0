Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113B954EEF4
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jun 2022 03:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbiFQBrB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jun 2022 21:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237138AbiFQBrA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jun 2022 21:47:00 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0077A63BEA
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jun 2022 18:46:59 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id w21so2988143pfc.0
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jun 2022 18:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=pwHaV2y2Bxu1k9V48sfmgmcfSPlc3DuZU6Ieth+3iJk=;
        b=enayjOKyisnqanZBUUvJT2Kj/wEqSNI17S7JnjYSgXzUo8FyTAIMLqv2yVSFvpegwE
         3OEVaP3ZR/z1KhbAh/jI3/VRsTcboyuUPp4i3kIfqidOYdj79omlVF27cI8hJOPBRFjd
         WP10sp/geo833+VAFjdeHd8Zpr+rfyfRQMhTwBpgnZCXRs3xFvkejrAJm6itA7wzqpVJ
         SJEnQYJ1JbFIn8d7qvETdh3IIYckiu8IOVPeg0IRZp+/va1KbTgCb3Vdeo2V8w/3x1ZU
         nyWjwI1T+P217TulML8CbZy+gNiTDGqKRxkUwTGQitjX1e+n+QppSOj48Vl3AvrXhbsU
         l0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=pwHaV2y2Bxu1k9V48sfmgmcfSPlc3DuZU6Ieth+3iJk=;
        b=EkE2iyzpIcv+EVMUN5KOHma6S8K7qSpeVWGDhiUceU+L73Ub+u5Bfy6C2i+RaUO/CT
         i+TWuUB+u5U0pq8mI6/Vy3MzkzHhzOPjq5QdtUYiYfJzfAy6QNqDsliqXjo5ds3lx70g
         J9L748Q9cFNI2dh/WFq7HXvdp6ltltZphaiB5UVDfJqA6lCLvu499noVV/Nhmq/1u+AL
         r5eyO7Yw672Cgsa3frjstcci6WFlrH7a9CllrqO9DVEcXWQbmCYOmmWGctEI66fcxop6
         RL7v6C29uuN548he2pXzFjjNNlDrmJpoffyBiAevSUz9+oao6wH9Zlki3fzFDha5NrBd
         LYoQ==
X-Gm-Message-State: AJIora8BnzqQ1CXkKzZG0KvQiA9gigcQ8M9la2ge0ZRHCIx8K6OOCxrT
        ygWOsdq2vsyzI6L+G85EzYs+2A==
X-Google-Smtp-Source: AGRyM1uUzZHOeIYcSeG9bMKgFd68+pIUWcO9f3rVjGNNnvl8G/weWivbw1M63dWzI/DquGjLQTge3A==
X-Received: by 2002:a05:6a00:1ace:b0:51c:242d:b62e with SMTP id f14-20020a056a001ace00b0051c242db62emr7525604pfv.25.1655430419481;
        Thu, 16 Jun 2022 18:46:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ja1-20020a170902efc100b0016632179ecfsm2223989plb.264.2022.06.16.18.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 18:46:59 -0700 (PDT)
Message-ID: <62abdd13.1c69fb81.e3d21.3415@mx.google.com>
Date:   Thu, 16 Jun 2022 18:46:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.19-rc1-4-g9b4d5c01eb234
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes build: 5 builds: 0 failed,
 5 passed (v5.19-rc1-4-g9b4d5c01eb234)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/fixes build: 5 builds: 0 failed, 5 passed (v5.19-rc1-4-g9b4d5c01e=
b234)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/v5.19-rc1-4-g9b4d5c01eb234/

Tree: kselftest
Branch: fixes
Git Describe: v5.19-rc1-4-g9b4d5c01eb234
Git Commit: 9b4d5c01eb234f66a15a746b1c73e10209edb199
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 3 unique architectures

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
defconfig+kselftest+arm64-chromebook (arm64, clang-14) =E2=80=94 PASS, 0 er=
rors, 0 warnings, 0 section mismatches

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
