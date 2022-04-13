Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30834FF844
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Apr 2022 15:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiDMOCA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Apr 2022 10:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbiDMOB7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Apr 2022 10:01:59 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C81F7665
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Apr 2022 06:59:38 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id bo5so2092136pfb.4
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Apr 2022 06:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ym7vqfO9MZuMNkNfLOHKE5xtdlWB082BQEv1JKJABS0=;
        b=yhquTRsnlFBChP8peY9sqBqBsElwJATgYnVld6VujrK6asuQPhgzXUSweWmk+4lDp2
         Bs1EKuSUNaZy68FpZXkkesCMon49sf+pjZ2fsGB+rCQfFh2yTTdKrXryYkaQBJIOTm1V
         WKHTDeg4uqOFeqtCRrVwP8FMHjQcwcvakaNNUj2r8AePTxiPiMMUlAhr/91L3+bqr4p8
         vbCqnTpf0c/zB+p62jX3fIXW0jSY7Io09IjuHK90xL1RoSTe98nMGiOibAOtl5qACQx0
         X/AtiW81wilefulDDeAllznulMsxhZisR+tyhVtPe+t01jM7rrDY6B3rmaHTjPC64Z7r
         tU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ym7vqfO9MZuMNkNfLOHKE5xtdlWB082BQEv1JKJABS0=;
        b=KTAosdOZESgMp/2IdGS5BNUA2GAeFs+2is+fdjQc87lso0g2vNY5480qyCaOOmX1aN
         /u4bzAvNL+jjblMJOBbosTBsWaQWzptLYdaxaPJpl00PtNCwvgzbvkrI6zNpArgkWDHp
         rl9IvcnPqBGYH4ceVJKchR8uyddbjDKrcJm/TFl+SDNQ6RjhTAldv4FYVl2hnEAPPCcF
         TykN/L7wcRuO2NSrkeqg+9vZVIk5AG1RcjC63LwGhidTogp/trkOyDEqwin90JtuOfah
         NS8nDlbB4gAfkjH4VZvV+SUnvLSAByt2K6psNAm1bN2dSbm90zweFHi7xUx2ShVRVdWa
         OiSQ==
X-Gm-Message-State: AOAM532TKDjhxtI1biIMapYuXyf04UqWscEABX43Z3fQAoIEpM75a8tt
        MIMt+dwjzlFhVWuvcPUURaj0Aw==
X-Google-Smtp-Source: ABdhPJwDoEyEtFoEhzOFzPmcMyo+bRVx1jmJs8EmJVG+4Fq8su0HQIruIECKVXAg4YIHZptbLSkfcg==
X-Received: by 2002:a05:6a00:23d1:b0:505:bf44:84ee with SMTP id g17-20020a056a0023d100b00505bf4484eemr16140454pfc.75.1649858377573;
        Wed, 13 Apr 2022 06:59:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 13-20020a17090a0ccd00b001cb8984dc28sm3220967pjt.22.2022.04.13.06.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 06:59:37 -0700 (PDT)
Message-ID: <6256d749.1c69fb81.36829.7c04@mx.google.com>
Date:   Wed, 13 Apr 2022 06:59:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: fixes
X-Kernelci-Kernel: linux-kselftest-fixes-5.18-rc2-1-gce64763c6385
X-Kernelci-Report-Type: build
Subject: kselftest/fixes build: 8 builds: 0 failed,
 8 passed (linux-kselftest-fixes-5.18-rc2-1-gce64763c6385)
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

kselftest/fixes build: 8 builds: 0 failed, 8 passed (linux-kselftest-fixes-=
5.18-rc2-1-gce64763c6385)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/linux-kselftest-fixes-5.18-rc2-1-gce64763c6385/

Tree: kselftest
Branch: fixes
Git Describe: linux-kselftest-fixes-5.18-rc2-1-gce64763c6385
Git Commit: ce64763c63854b4079f2e036638aa881a1fb3fbc
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
