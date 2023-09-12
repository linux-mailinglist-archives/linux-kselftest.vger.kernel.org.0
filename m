Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E8E79CE2A
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 12:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjILKYB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 06:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjILKX5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 06:23:57 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE49B9
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Sep 2023 03:23:53 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c3887039d4so26881995ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Sep 2023 03:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694514233; x=1695119033; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M9LIb5haVVHTJnBYry+OCoJloq0Q0VbbRaGISgkSZ5M=;
        b=tryLHP29ZbXlPBFjTBr263izMLZmsewcCZvRVp0cRmWLtTsuW36plvaco8xMVaTw9f
         xof/EiVgtpnXBOmt/1+mU+uLrXsi0lTwFPapYp4V73rJyX4lrgVQ7zHn1amY6WtGUQQf
         PFjHtcENePCGYFczxn+E22Y3I8LbBPEbyyo/BUiguRxFyk4iFa0es6JOyBQWpn7vHxo8
         rbaqls1UJXvP29j8i7Qk+VYl+j9wVJEM9q/jVIcmITP3Sy9QoD1ZEDYB1fIf5HxwqPXF
         PKr9gq1qVGaw3fhjeKZd3u6/CZo+lO/KEPzZK4ulK9GWD3u+zIRTsCkPidfOjju+WOHU
         rRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694514233; x=1695119033;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9LIb5haVVHTJnBYry+OCoJloq0Q0VbbRaGISgkSZ5M=;
        b=OD8OSTJXv4Adz/Mys1dkVAEP1xh8xxhhrBGkk8SEBWxNs5rgnQrMNbjy4kKNC8Pn4D
         3TTzsaI4sSZ6P77gUhWVU4aGlGXxgbbTYpMGfihhIZn4E6f2UgWWYaNVPH4LVLd+ijHx
         TpnO6D9mW/gqShct3LA3E6NtfWm9JChMHL7WbNmGb1Kq5nRuEaOYxdtZ+HuuM9cgE7eM
         8mfZ6pKO9/+PsPCT4gKGB8qTXzQPTkt9b+65IL0DhyVbH+uokfQLkC9n5Yf0i1tc6HMb
         d2D6kR1Xot2+NScJbRAqbbcLMKcLTaSk6uylZCzZVcXJ3stzT3+MHJB300wj/QdU2No8
         +YlQ==
X-Gm-Message-State: AOJu0YzxaMlU2ikygN/yWSRkz2fvlBmxNyzFAgm0Wn+R57/YQX896noa
        Dm5uN7VvNT5nx+r7Y8zGQgKwqg==
X-Google-Smtp-Source: AGHT+IEmgdDEUJ9JrQjm0gbzQ86T5t9CvRObKuPE3dADfCJu9EHt7NCkdJcWeSSlEO+b9rD4JiFnaQ==
X-Received: by 2002:a17:903:2282:b0:1c0:bcbc:d78 with SMTP id b2-20020a170903228200b001c0bcbc0d78mr12208361plh.14.1694514233421;
        Tue, 12 Sep 2023 03:23:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bc7-20020a170902930700b001beef2c9bffsm1576553plb.85.2023.09.12.03.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 03:23:52 -0700 (PDT)
Message-ID: <65003c38.170a0220.c6d7b.5009@mx.google.com>
Date:   Tue, 12 Sep 2023 03:23:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.6-rc1-3-g7ab6fe6625c9
X-Kernelci-Report-Type: build
Subject: kselftest/fixes build: 6 builds: 0 failed, 6 passed,
 1 warning (v6.6-rc1-3-g7ab6fe6625c9)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/fixes build: 6 builds: 0 failed, 6 passed, 1 warning (v6.6-rc1-3-=
g7ab6fe6625c9)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/v6.6-rc1-3-g7ab6fe6625c9/

Tree: kselftest
Branch: fixes
Git Describe: v6.6-rc1-3-g7ab6fe6625c9
Git Commit: 7ab6fe6625c9bdcb8fa5f61c8f8e30e13f689284
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
 !ENDBR: .text+0x1393eb

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
BR: .text+0x1393eb

---
For more info write to <info@kernelci.org>
