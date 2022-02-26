Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0034C547A
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Feb 2022 08:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiBZHqr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 26 Feb 2022 02:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiBZHqm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 26 Feb 2022 02:46:42 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B511DEA98
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 23:46:08 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id w37so6727778pga.7
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 23:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=kYY/jI3fv0NlYasJ6etpKNCE4dsLQ7C5YOs86X+P5LQ=;
        b=OlDq8RJIGCIFdLl7fRG2JXKIMZeqRiy3NsBBXFJTaABqPJhVH69wXy5SNcet2xBsyf
         FTZ6+NWQ5fGn3PQFG4dl2Q/F7ZW2wvnUEYIjC+l2CgS4fsWYb6nAObdREe83qzd2L9+s
         0SV/XLjv2gaSZNKpJSWYNBYzcNZZQ72QkxewIfLCcH469h4mqcyiRU9lzZjs/DcHZOab
         rAp26CmOtTzuwf20pXvz5lL6tBTFV8ID1ssi9bJSudNYK2vd1mCkgN3i0JYhFbBZlvhH
         XpDZflr/WeZarf9KkSi3madCKuZ9u6fvDx6WaO2MbudlJjFO2ctMjCVVDTwK7jpU1LTt
         S/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=kYY/jI3fv0NlYasJ6etpKNCE4dsLQ7C5YOs86X+P5LQ=;
        b=lE9PAttlLT71sgLELHZOYT+zG8ieWQE5Pa2TCSH4N4nl1oECysQ4V9Zr4QvLbu1+tv
         APZopcX7d38ByPFsdgwE7KckuSA5R0750dNSqwQyfBBXDLOYeBQuMaLuHFDTOtvOeM3k
         UXKNcXs0k+al367gurwuOlb9q9/AW3fp3xUuSfyUxvUpwZ9Ypxtop/bxcC4p8U+odqlt
         xuFLloVHyxUqf7bND4PecBSM6toJ9sXX9PxFYXhZmJPU613t5GAC/fQojvsICjs6ZN1v
         99we4ZcwMx6i8YJGd/bm5FuyWLdoa6f9loCOdoiplimd6QTIGCyB9Mj/WZTnLzgC6e5x
         7enA==
X-Gm-Message-State: AOAM532UKFwHm8+vqQxN15WpB1FAcVUsFI/peUcjjfwXVY17Oo7yA6q1
        lMnhYYqfEgrKKBHcQzEgdRkQnA==
X-Google-Smtp-Source: ABdhPJxcaLKzdtA+m6f1T7Ty2ImXZEtH0x0kXVhZy/SD7/Kbbe3IEDzFQ/l/alPdjRVczBhuQQPwjg==
X-Received: by 2002:a62:7990:0:b0:4e0:5ae8:6c11 with SMTP id u138-20020a627990000000b004e05ae86c11mr11724089pfc.34.1645861567675;
        Fri, 25 Feb 2022 23:46:07 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u16-20020a056a00125000b004e1e36d4428sm5475167pfi.104.2022.02.25.23.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 23:46:07 -0800 (PST)
Message-ID: <6219dabf.1c69fb81.da382.ed94@mx.google.com>
Date:   Fri, 25 Feb 2022 23:46:07 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v5.17-rc5-17-g2aaa36e95ea5
Subject: kselftest/next build: 6 builds: 0 failed, 6 passed,
 1 warning (v5.17-rc5-17-g2aaa36e95ea5)
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

kselftest/next build: 6 builds: 0 failed, 6 passed, 1 warning (v5.17-rc5-17=
-g2aaa36e95ea5)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v5.17-rc5-17-g2aaa36e95ea5/

Tree: kselftest
Branch: next
Git Describe: v5.17-rc5-17-g2aaa36e95ea5
Git Commit: 2aaa36e95ea586ad23edfcc1d474e8b735a4d1c3
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 3 unique architectures

Warnings Detected:

arm64:

arm:

x86_64:
    x86_64_defconfig+kselftest (clang-14): 1 warning


Warnings summary:

    1    net/core/skbuff.o: warning: objtool: skb_copy()+0x132: unreachable=
 instruction

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

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
multi_v7_defconfig+kselftest (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warn=
ings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-14) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    net/core/skbuff.o: warning: objtool: skb_copy()+0x132: unreachable inst=
ruction

---
For more info write to <info@kernelci.org>
