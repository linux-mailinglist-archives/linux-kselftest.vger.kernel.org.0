Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366F15649EA
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Jul 2022 23:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiGCVR5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 3 Jul 2022 17:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiGCVR4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 3 Jul 2022 17:17:56 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334EF5F95
        for <linux-kselftest@vger.kernel.org>; Sun,  3 Jul 2022 14:17:56 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ju17so2395274pjb.3
        for <linux-kselftest@vger.kernel.org>; Sun, 03 Jul 2022 14:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=UAU9Ti5/3pcjJfEf7SYUDB0Y//WoD831vyxbjmKFFus=;
        b=HbPxDC4FWqFQBiO068fh447G5XjBGhISKw7N/31xSUDh/EqbCXQrBjiAZDXyf7Dx0s
         MCHoa3mMyNbtEMadI29fcOq0q8hdgWqufEZecrs2EGwU2MwffxKmkKUCeg6HOIIJMgj/
         D+aDg7s1iT3viqwOi0p5+K2PAAc6iN8szFixa3dEsosBfonOJZt0PFnpahbrkA7hO6no
         cxZjSsv8VwNmxeWTtaDYVH9wY9KWTwhdnv9vtJrOskbhNDd/1CCC9cQjK1fhnUQy9rHb
         tlirKPZRy3htDJ3yLUMcpxVy0Gm+sjGEUp3xfhCwzv/sAOYNmdZmjFq+8XOamvDD1XYc
         5sTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=UAU9Ti5/3pcjJfEf7SYUDB0Y//WoD831vyxbjmKFFus=;
        b=r4wxtGh9HXgdiI1fmLFGWSQ8bigYUF4WNTDKIyaOoQ/DrNYS2vmabwA9H98sLKEZfr
         ulZI5PL9BaPbdB1HL5JCAqeRZU145ZbvDzIMIhSWb43Z2q9REXRWwO8Bt7ja8XRstZQh
         XNoCCwh7DXO0CnmFMQNI+E5GJKyQmrp5H0UaYIz5W+caHu5jdP03p36z6wzsxz1E15f5
         u5F5ZBJnnVuabCl3uMRrOnJX0Zs51pw3QzhoqkVGE8iQ6uGDKgmK6qkl/7ZTa8kyliLj
         WZ6K9clMIuQ2TcG+1GubrlcbrMCaHvG7k0WfXGgpc3PqlrMSVPwzBn3kY8K3hczT6a+y
         /ATw==
X-Gm-Message-State: AJIora8F7KMpt6mB/V+blMrNVchfCZLj1CRSOILAw5+Whb7XbPm+3Jl0
        RBzLgxijSKsABmMO8pEz0upnC7YzzMZddBS6
X-Google-Smtp-Source: AGRyM1t/ap8o9y6uhZIV1Je//vsr0CTH7z48aJFPN0zPNO8vbVoqHA7Ukkn8qGZdYQsapOqBh/Hnlg==
X-Received: by 2002:a17:90b:3a90:b0:1ed:27b7:5458 with SMTP id om16-20020a17090b3a9000b001ed27b75458mr31333060pjb.208.1656883075724;
        Sun, 03 Jul 2022 14:17:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709026f0800b00168c523032fsm19427341plk.269.2022.07.03.14.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 14:17:55 -0700 (PDT)
Message-ID: <62c20783.1c69fb81.f69f0.be54@mx.google.com>
Date:   Sun, 03 Jul 2022 14:17:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.19-rc4-7-gb7ecce6800eb
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 5 builds: 0 failed,
 5 passed (v5.19-rc4-7-gb7ecce6800eb)
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

kselftest/next build: 5 builds: 0 failed, 5 passed (v5.19-rc4-7-gb7ecce6800=
eb)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v5.19-rc4-7-gb7ecce6800eb/

Tree: kselftest
Branch: next
Git Describe: v5.19-rc4-7-gb7ecce6800eb
Git Commit: b7ecce6800eb1aa97c486c1aabf64659193d5a4c
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
defconfig+kselftest (arm64, clang-14) =E2=80=94 PASS, 0 errors, 0 warnings,=
 0 section mismatches

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

---
For more info write to <info@kernelci.org>
