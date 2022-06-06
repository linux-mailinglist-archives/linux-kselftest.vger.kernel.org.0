Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8F953F16F
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jun 2022 23:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiFFVKo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Jun 2022 17:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiFFVKm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Jun 2022 17:10:42 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78AD38B
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Jun 2022 14:10:41 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id t2so13120432pld.4
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Jun 2022 14:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=1SatIsjeB++xJj5idTtmP3zHgV9bKBPl7Padg+PLhJE=;
        b=SHEKUYaYWxx1r/18y+NH7K0fHaySP3v79ffME4Djp/IDjhqxdaa4DkDwiq9vxdIxqq
         qfMgYhxmg/ibU8NvIzISi2Pn4pdDIW7vwJ8yucWHezk2NcAxUn0DXALDJ/rrijIDuQja
         sRv3ak3+1uBnqVQsP2NIfy77EHnxqZGN64JwR/p8PazlE3e6UIi+Nz/p0hYjOYC00C8h
         3lWtARnflAD297SLIGVhMSQaTGi4O7MXqv6vpaXeSFguh1BJ0fmMIGF/ej10wwbD18V3
         Xh63vg71S/toXY6fPKXKNVOdGTGBNcCa63sB7RBWF94Y+6iobr1iKI5xx+KbN0ydMKl8
         b5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=1SatIsjeB++xJj5idTtmP3zHgV9bKBPl7Padg+PLhJE=;
        b=25VGJHbjA3jlZAE5gS9GWoReV+AoYk6ZlwrYY91DLFQxVv0URMZ17Fvm8irRY8IoGP
         kg2WQmU24d287PgQ6UNy0wal3OxjhjYr3PVfPMgKa+IWJ9QtJeQaqEpfFkVqDgI4YHh0
         v5bketeTJqRg/lh1fYSuvzSX1nAQBMFq3yxVv3zSmTOg5i5/jYjpljjVR1kE1TpZ+uMs
         4jUMXG7/zRq2UVDPfzVUM195b2pTCdwS8gv8BbDtC2wbDZcKh1Ul2IRtNUiCGP/ce4Hp
         bSC4U+Ht+yTXs/bXTDXGdiF3FdiowY2ReAXw2w9baqEibM6tZcK6wKoXtG0HnCTrikEF
         IYKQ==
X-Gm-Message-State: AOAM5329H8uhdE+bM6rJIWtjZ+F0Z+wQI7bbX+l0XEZ5ZokIzyaDGbrb
        fg977l6XGUyun1JoHG/D0IrZWqh5nuAFO721
X-Google-Smtp-Source: ABdhPJy5Tp6FLFXSNCtuNfRKtB+vZ6/W8+P1zLoj2nnyC0owc4Nn5HlHV7xh7+5fL+JsV0P3dnDQtA==
X-Received: by 2002:a17:902:dacd:b0:164:17ef:54c6 with SMTP id q13-20020a170902dacd00b0016417ef54c6mr26527289plx.11.1654549841307;
        Mon, 06 Jun 2022 14:10:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ij1-20020a17090af80100b001dff2fb7e39sm13179031pjb.24.2022.06.06.14.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 14:10:39 -0700 (PDT)
Message-ID: <629e6d4f.1c69fb81.be1b9.f364@mx.google.com>
Date:   Mon, 06 Jun 2022 14:10:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.19-rc1
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes build: 8 builds: 0 failed, 8 passed (v5.19-rc1)
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

kselftest/fixes build: 8 builds: 0 failed, 8 passed (v5.19-rc1)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/v5.19-rc1/

Tree: kselftest
Branch: fixes
Git Describe: v5.19-rc1
Git Commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
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
defconfig+kselftest+arm64-chromebook (arm64, clang-14) =E2=80=94 PASS, 0 er=
rors, 0 warnings, 0 section mismatches

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
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-14) =E2=80=94 PASS, 0 errors, 0 w=
arnings, 0 section mismatches

---
For more info write to <info@kernelci.org>
