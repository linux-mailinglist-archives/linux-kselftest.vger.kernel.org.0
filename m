Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E4C7A55EA
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 00:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjIRWti (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 18:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIRWth (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 18:49:37 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E820E91
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Sep 2023 15:49:31 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-690b7cb71aeso573524b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Sep 2023 15:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695077371; x=1695682171; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W5qR59e7Hn9TKxKNkWiOfGnOCRZWGEYJYDoBcE1tP68=;
        b=k5fbH1hoHzHVn8z5xZSMPvYL1fZgaQqzBHppdSHEQHnxq4ohjMW+H/dSQE/G0WJvGT
         OvsjSwJbBkGpJzoG5oM0E8pff0KhsRcOXUPrtTC2omuOSK30b+TGZ4snVEnERWEIGpMc
         P9k39vjG7HoXBiZlTQVzfb39Halxbhbdm1ACe8gsfdFBfn9BSMbFpWU6odEOtfSpIr+t
         5Yo1quK+bnjO9zm2ahfBClN+i8sJAPopfj06Gjbwa5r7KXBYIXb6kqVFldTPG97e2AsT
         +YyZWkz0enIlSIEFQBeQFuWo4UZ8BqY/LGooEMERZtrpBDUvvKH7RxzNq5Ny7JCJ3Pc+
         O6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695077371; x=1695682171;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W5qR59e7Hn9TKxKNkWiOfGnOCRZWGEYJYDoBcE1tP68=;
        b=oSsR0gaZCxAHhNPW0pBq1d5HvjDvScHSse4mwrzg4wsIoZzJGQiV5num7onwfMQydh
         OArTcsU82nHFSkyl+pH299xnGCat6uO/s74mzlnNRijiPgn9EMihnYS3PMlR2kA4iS/0
         9vs15Ux1I1YDd6iGeHGeBKa3v3lnNKqszB9OHez0M+qQX2kcNrCLqFlLeMBuRZx3aJmu
         1k+7n4NPvjK2oluiObheDyUT2mkvPEevCDZ3JFEl9IL2C8szFVVKD/xyanKU5uC8DKPi
         UAcz9aGCmJEbALP/1i6Qufo25PTh5sNlwXzTt32j4mf/9EkrJjzRusyqSVPZU80tqvTa
         DkAg==
X-Gm-Message-State: AOJu0Yxx9VRm6cW1vA1tpe+NXpCgfiWEw1gsPTX5ujGpH31B/Yc2PaBA
        4wfEmfpUIecZIVSGddwaWNQOmA==
X-Google-Smtp-Source: AGHT+IFm7mvIG4VOfmDPl+QWb1m3OE0YnVGZPUYUxQtraK/dry18KoS/fDP6T5IxeTDj1j6xNMURCQ==
X-Received: by 2002:a05:6a00:1823:b0:68f:d44c:22f8 with SMTP id y35-20020a056a00182300b0068fd44c22f8mr1147667pfa.1.1695077371315;
        Mon, 18 Sep 2023 15:49:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j26-20020aa783da000000b006883561b421sm7562281pfn.162.2023.09.18.15.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 15:49:30 -0700 (PDT)
Message-ID: <6508d3fa.a70a0220.87191.a653@mx.google.com>
Date:   Mon, 18 Sep 2023 15:49:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.6-rc2
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 6 builds: 0 failed, 6 passed,
 1 warning (v6.6-rc2)
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

kselftest/next build: 6 builds: 0 failed, 6 passed, 1 warning (v6.6-rc2)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.6-rc2/

Tree: kselftest
Branch: next
Git Describe: v6.6-rc2
Git Commit: ce9ecca0238b140b88f43859b211c9fdfd8e5b70
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

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to=
 !ENDBR: .text+0x13950b

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
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !END=
BR: .text+0x13950b

---
For more info write to <info@kernelci.org>
