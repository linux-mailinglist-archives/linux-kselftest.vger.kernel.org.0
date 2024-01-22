Return-Path: <linux-kselftest+bounces-3292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC7383594D
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 03:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1CD71F214E6
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 02:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2608A38;
	Mon, 22 Jan 2024 02:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="sUrdawp+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE91A5F
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jan 2024 02:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705889799; cv=none; b=KvxygvXYzi0i7sZTohIH2vv0OHJQANDE5O9Z3YpjqMxCj+8da0750LLQFXfdmLdsyx/OWN2rQSpUC28YRLAeFkm0eOAiY1Mg2UV0klq+O8ZzcmHhwt+E4czvpouFmPSO9cVzwVASpxt91KL+a1sDM+DDyZ3rRw6g9Q6QGfnwm1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705889799; c=relaxed/simple;
	bh=VV2rqPXX6qwnWXCSfKZMhcPP3hxJDzxk1I8ByvxTK0s=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=sD8Oy+yPxN4xfhrZSk+lrKOmxPLbf1ZUHAAJ+TVeaCwTyUA8vfoOlnzAOVTF/bzfqKaTC+Xxnw9FiKP2xuhPMZFPJ9PLQH1izyb3Byx75SFI18zUcyeKpkxndTHFUZHYsRmXSR7W/tmlUOln2cD5qoCcLrnbo/9lgEDvk9OCtBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=sUrdawp+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6dbc9dab55dso1342538b3a.0
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Jan 2024 18:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705889797; x=1706494597; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ChiSprBRkDTzin70GlGN2iqbr3plvvlM2q+G3XJ5ZZc=;
        b=sUrdawp+tOv7Xl8nblEDYlnDSATETpMvwzYcf24CPOCxjNocukOCfToHhDz7m8ToBK
         oZLxqhhDc+Il31LEG5siy0zeVKRiXScGmj0tmRvlI4U0hz7UQfIWm6q0evXCHHt6FH3L
         205aQ6bLK51y8cY3DTz2cmKTekTJ0EPI+i0IbaKi3Pwpj9TyAtgzhitgzW2KOdwXvErx
         Qdm/U/ArF+3GRT3HzTTo3prV8mEH4E9yf8yPamNmnD+Pc/zgrrTxhoEITLnkukXdWZz8
         gTaMxzt6EBC42JZT3/KqsLU/Uz4fCyUAlB9PMAy5J1ZCoGPhQlSWAbXykLzJY5jUhhcE
         +mSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705889797; x=1706494597;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ChiSprBRkDTzin70GlGN2iqbr3plvvlM2q+G3XJ5ZZc=;
        b=YiUobEgpMoUBcvMEya0WxPHg1HHd7BV3zmMotNvoM+lE2aVgPHQTBrSOViB6Q5ujaS
         2qmR1hM11+GnGT/Ykg1+Gc3Kt6e87hNEtGSuwIy9i4QSe62Axx+H4Plg5MmIjtCsU7tv
         /i/zbE0Hs2mQDvY10nv33qkRUUuj66sjsYstrJMUs+NjcUBRpHt7SnM1P6pBgUfhdCa/
         AkxjwtyDPISg0SLTtrcQd8nTb1tuqJE+Ie0l996xg/wwvCHEKLEVSJ+hJlXrwcE5yMKR
         hJIlB0mHx7euCcEkkmSd+F/LsLL+hxyS1le+rBMmgFYZKwORkhXX+EE7VD82J5XrhPLC
         L/EA==
X-Gm-Message-State: AOJu0YwYF97yoyKq4mU/sp1QhLDPu0Yx9sGv15x+PBOLgQFG3Oim13e1
	AGsNUVWHn9P8PrCQpJcYWLDYEWVxIJYQ8BiLN7VTM+xKc+mI13NEnJ0kVHRBsEA=
X-Google-Smtp-Source: AGHT+IHRAoM5dy+u3m1iJlSxDLKYLc3CUsMqRJDdalA8GL5S2GUIkxe3qyZJ5IgogEBAsFI63/3dRA==
X-Received: by 2002:a05:6a00:460e:b0:6da:ca4b:8632 with SMTP id ko14-20020a056a00460e00b006daca4b8632mr4997856pfb.5.1705889797056;
        Sun, 21 Jan 2024 18:16:37 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b25-20020aa78719000000b006d998c11eddsm8648181pfo.62.2024.01.21.18.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 18:16:36 -0800 (PST)
Message-ID: <65add004.a70a0220.9702f.f02e@mx.google.com>
Date: Sun, 21 Jan 2024 18:16:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.8-rc1
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-seccomp: 4 runs, 2 regressions (v6.8-rc1)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-seccomp: 4 runs, 2 regressions (v6.8-rc1)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
8-rc1/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.8-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      6613476e225e090cc9aad49be7fa504e290dd33d =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65adc34c0fad8dd25952a408

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.8-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-seccom=
p-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.8-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-seccom=
p-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/65adc34c0fad=
8dd25952a409
        failing since 459 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65adc345d1751930f952a401

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.8-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-seccom=
p-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.8-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-seccom=
p-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/65adc345d175=
1930f952a402
        failing since 459 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20

