Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278C8798B59
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 19:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239126AbjIHRR3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 13:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjIHRR2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 13:17:28 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA5BCE6
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Sep 2023 10:17:24 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-564b6276941so1706633a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Sep 2023 10:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694193444; x=1694798244; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VqTO94yBsa78RGJDWM2gYxxXm6/ZvnXkcbd4F+ggfjI=;
        b=ByYVo0CtWU/h3rb1yV1Lt8hi829Ee9P8Ou7Aiwjx57owqkePkRDaxj4rcebhsyTIkR
         wcZF1F4NFcZg5xT1SmlL3z9rKNUbI8xH9pEXjvWFO0Vk8DNpZMpwCev6h1kE4zzlm+8h
         RM3SiNm6IGihkzj3rBz7zuAPTkO6jrjEnSbJDpGaq2a6Zb+v0y2hBTTAVK1DDXlPJ010
         v88C1SgL7xV15row9CyH43DCIDmZAnPqMqn+ajdzWMkbZFhyOqv33rashnJxyS2M8D55
         A3IDgiDrHQHaooNYpwYZYv57N37PQx3eVp3uwVS4Dt0driOWMJaVt/vMqFkqkqbVItQj
         yJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694193444; x=1694798244;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VqTO94yBsa78RGJDWM2gYxxXm6/ZvnXkcbd4F+ggfjI=;
        b=fj9EJpsfWbIoZ4Dg0KTRaDPEmjio7bwrRqJKZJClRUrPZHGMRPRA+b0qCoze+vTRSb
         y+RgRhR9tKLmqgtVhqNJck57n6iLoWBZBDYtsxlrMyP0Qmeugdo7Vuxwo3QQ5BZgDi92
         oVu1IQWh8u8gJhTeiLYuVLGel3qRBcMcQxNe2/jkukipLAxFsl4MjxrUeSvDFSVqKTBY
         q9+HNB0vPHByeVbFRO+h3BK4z4sojDCZT6uwLgtgtRb49L3I8pK3RlAUGlzhYhyejZDO
         jHiX9qtJeso+S6Xn0YL5J8KdD2iDcf39v72QCVJIEwEffa+oOFv4Hb/G9Otn2D7hRY66
         c1RA==
X-Gm-Message-State: AOJu0YzJD+HTWN6gc//QUVivigOKlr86DZGpU2R6eCvEFJvn59Rq/9Fj
        YCCM/nPniQS9zhvRFrQsjlHFpCH9j59B8DvLCcwgVA==
X-Google-Smtp-Source: AGHT+IHDv+Xh+MMnYwVKrLd9/7j5WZldMEtlgPBed9yk0cKXGKAJZ2cNnueUkspKIYPmEv1EqgqLOw==
X-Received: by 2002:a17:90a:fe86:b0:269:18f5:683e with SMTP id co6-20020a17090afe8600b0026918f5683emr3133798pjb.3.1694193444034;
        Fri, 08 Sep 2023 10:17:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id rj14-20020a17090b3e8e00b00268032f6a64sm3255025pjb.25.2023.09.08.10.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 10:17:23 -0700 (PDT)
Message-ID: <64fb5723.170a0220.2922b.8475@mx.google.com>
Date:   Fri, 08 Sep 2023 10:17:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: linux-kselftest-next-6.6-rc1-4-g3f3f384139ed
Subject: kselftest/next build: 6 builds: 0 failed, 6 passed,
 1 warning (linux-kselftest-next-6.6-rc1-4-g3f3f384139ed)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next build: 6 builds: 0 failed, 6 passed, 1 warning (linux-kselft=
est-next-6.6-rc1-4-g3f3f384139ed)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/linux-kselftest-next-6.6-rc1-4-g3f3f384139ed/

Tree: kselftest
Branch: next
Git Describe: linux-kselftest-next-6.6-rc1-4-g3f3f384139ed
Git Commit: 3f3f384139ed147c71e1d770accf610133d5309b
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Warnings Detected:

arm64:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-16): 1 warning


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to=
 !ENDBR: .text+0x13df86

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
defconfig+kselftest+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 erro=
rs, 0 warnings, 0 section mismatches

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
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to !END=
BR: .text+0x13df86

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>
