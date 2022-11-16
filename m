Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9500862B075
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 02:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiKPBSU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 20:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiKPBSU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 20:18:20 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC0929835
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 17:18:19 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id k15so16053863pfg.2
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 17:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4v7isZvGgHqlGq3SMrhmzOXYF9Yn2vjjvAnfnUNB0zU=;
        b=f9fCSlovDGMhiDlLZob51cKUNHpmLBkH38EqtVzqKKEa6qQ2eFkNojtCazsGKvPbSQ
         1Xg11/yZrD9ufnrSX7veotwS4x+Yi+Kxkn6ne9LjEV1jCYxcgbBVFq5lPB9c1GXQToae
         TbYBSY9TBP1cOGQQiOSk/JdQjtwHFRzlz+h6EMKe33QKA0cNBqgCdIl3Oma6uoArRH5k
         fxVqn5lKon+JejuYjEAAKcl3igHsM+KIe/c5kjeKMKZSkpVxeMM5Arj0ZGm9ht7y/wE+
         64TKpORb9ps41lNyQclTaKCc1NP4cCRQoDFzmWDkkOyFqIGjpEJV1+uY7UREtWUFS7VW
         AXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4v7isZvGgHqlGq3SMrhmzOXYF9Yn2vjjvAnfnUNB0zU=;
        b=QwyQWf1rGR1DZvGVSULzFEiB+Hl97wzGPREnDXcogU5GgLsPv4piy0ErDW0V1xt88J
         cFQLqtgeF6/4Rj8wvKBuvyNsSUVJNj7P16/v3wQ/XoKRPEAWboxjplsbJ86I2BZXt2c2
         VD3ly1NEMi5aoRH5YDdloYGQ24lBXmUbl8NdwZi/JU2a49SceHpjS8sWWF3mNHVfBM+e
         0qhmDB5Zw7ZZyaQa3TvzrPBLB+twb8UPEXd8dshVFUvewzm92OlUrBuJEXzOadQ1CImR
         a1ffDbyZO5fodDRPY51xYzh0FvAPuUt75gvQD1TT5lMh2gY3qlafsfwOkGvNCJ2RNzVQ
         ZwIw==
X-Gm-Message-State: ANoB5plvTuNvjIW0qQWB4SlEoHkcMvcpComcqR9aL4f1lMWStxJ/qt3l
        l0llD7JTaqXnS2saTeGCnwCoaQ==
X-Google-Smtp-Source: AA0mqf41kc/UJVw1O7t1vAqRpqJ5us8CH27lPaPG7OYhipmPdZHVUn4Qr5lYlhGEVVtJRWs+v+IuIA==
X-Received: by 2002:a63:db4e:0:b0:46f:8982:cc8a with SMTP id x14-20020a63db4e000000b0046f8982cc8amr18855831pgi.110.1668561498709;
        Tue, 15 Nov 2022 17:18:18 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902680500b001785a72d285sm10510807plk.48.2022.11.15.17.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 17:18:18 -0800 (PST)
Message-ID: <63743a5a.170a0220.4316d.02cd@mx.google.com>
Date:   Tue, 15 Nov 2022 17:18:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.1-rc1-16-g35eee9a363be
X-Kernelci-Report-Type: build
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 8 builds: 0 failed, 8 passed,
 3 errors (v6.1-rc1-16-g35eee9a363be)
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

kselftest/next build: 8 builds: 0 failed, 8 passed, 3 errors (v6.1-rc1-16-g=
35eee9a363be)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.1-rc1-16-g35eee9a363be/

Tree: kselftest
Branch: next
Git Describe: v6.1-rc1-16-g35eee9a363be
Git Commit: 35eee9a363becb854109e35d568299bafc97c9d1
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Errors Detected:

arm64:
    defconfig+kselftest (clang-15): 1 error
    defconfig+kselftest+arm64-chromebook (clang-15): 1 error

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-15): 1 error

Errors summary:

    3    error: write on a pipe with no reader


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
defconfig+kselftest (arm64, clang-15) =E2=80=94 PASS, 1 error, 0 warnings, =
0 section mismatches

Errors:
    error: write on a pipe with no reader

---------------------------------------------------------------------------=
-----
defconfig+kselftest (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, clang-15) =E2=80=94 PASS, 1 er=
ror, 0 warnings, 0 section mismatches

Errors:
    error: write on a pipe with no reader

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
x86_64_defconfig+kselftest (x86_64, clang-15) =E2=80=94 PASS, 1 error, 0 wa=
rnings, 0 section mismatches

Errors:
    error: write on a pipe with no reader

---
For more info write to <info@kernelci.org>
