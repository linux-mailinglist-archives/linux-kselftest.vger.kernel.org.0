Return-Path: <linux-kselftest+bounces-3287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A03835948
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 03:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BBC02823A2
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 02:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E63F36F;
	Mon, 22 Jan 2024 02:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="mueCPwq5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DDF17F8
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jan 2024 02:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705889773; cv=none; b=UR2x+yrzSlC1HgybE+w4t5Rrsmz1ZqZrWt5B+4EHt6t4WGetkEzhx6Zhkunuko2Dec21LZ1oqQ5PhaK8irl7jaI1TZ4qYAQE1AUGib2sYH5Rvl0Ug60Aj7ZSf/z4jCZ+UKB/TnPifCZJM+ayN6q6Ep9Ohxha08LNQ4KmotMs7qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705889773; c=relaxed/simple;
	bh=6ydBXy0V4j0g3sm4w7Wn4N5SapmrUvpD9fIaL5lvOsg=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=Oj4MTPa8md0PY2DXr52JxIE31mzriZ4sBcJGfUDVsRc8l0rpucG1SDbao0bfBtzY5bVWJ1oR45O8X5dkXtSllJt9qYhe5cbiQvlC8zCQ0gKfXdyf0HVC7awpXhTYwjkOviU5/QDWl+uxGBZ2Y/zymHwNwuoaOjWFFudOiZdUXLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=mueCPwq5; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5993047a708so1332821eaf.3
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Jan 2024 18:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705889770; x=1706494570; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=piWnP5fqoqWrLekrSVhBbB3JYdHCPd0cun8qUXwzjCM=;
        b=mueCPwq5nHSbZxrwKVgdFGe9MnRMHd3bEWgZ9bQtzGvnM/g6L0WL+jFsBhIFcdciUX
         ZIrY83Ru+cl/X4GKWTCS3mZ3REtz502cWeR/XK03edGFgP+4bUx26AHi1ue+zMyC0BVV
         UIEjna/j3XWHAQMiIL9bsz6RbLPOaBJ+94PSJLe0bFHzA4RootPZOOwyZxY7TnwLRP3U
         Ab3QS5o8sH3BOq4NttSMilEuxjSEsxvotSRLHL3ji0FNu06/wPyGwRMvWpC4wwla/lZS
         UvK0uEAPwmr+pcFmI3cOB+9kY1LZAHAfJbCNtMDDxADJSWmz6glAFZu6bSTdcUvX4NMA
         IovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705889770; x=1706494570;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=piWnP5fqoqWrLekrSVhBbB3JYdHCPd0cun8qUXwzjCM=;
        b=F71JUbvqr6X8+1mCTQA3KZcSRAoUmbeMFJ3K0Xd/foQZdejl4Za+Jgxi2ElAwxhy8b
         UKwKdgYIy5OokXtBmEqB8J+iqNKVMT2L7zk0L6QVFqOQqEMFCCd4M7mgD+FS2T6Lvp+t
         YTjnP+N0qgGmQb6DtGqzyPILy4R10yXYGFQX7VhkEGql/K8seNpqTNwFhuUcKkVRlQOV
         LpqApEjwlXhMcVactc3skN6sY8G+FU3hCmJ+0SbY5zR2P7bxN9on0YFXIwSlTtEj+GwC
         zMH0aNZEi9sQryi3MD6Mvr35Zx3qm5IdmC7R5m1VBF2xWcAjoNjLpxTon8SVOsKgRkyq
         z9qA==
X-Gm-Message-State: AOJu0Yx/C5pnqrnhmaEg55tkff7jBoumONXAUuRoHugphohOkZbpv131
	3010YXIKDTbMuXYhCZKWLybn9U8AJPmt/iM4M5TD25Zh0DSWyvQzWXt7Zm9g2y4=
X-Google-Smtp-Source: AGHT+IHIx8dvuYlYYj2pXg2mQFjM4INeNMLwVnjRw8wpYZ0WApwSqMUn0/5ox381sgt3rMNy+q3xpw==
X-Received: by 2002:a05:6358:c83:b0:176:5c75:b348 with SMTP id o3-20020a0563580c8300b001765c75b348mr278348rwj.4.1705889769968;
        Sun, 21 Jan 2024 18:16:09 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v2-20020a632f02000000b005cebb10e28fsm7252874pgv.69.2024.01.21.18.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 18:16:09 -0800 (PST)
Message-ID: <65adcfe9.630a0220.cf659.8ad8@mx.google.com>
Date: Sun, 21 Jan 2024 18:16:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.8-rc1
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lkdtm: 1 runs, 1 regressions (v6.8-rc1)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lkdtm: 1 runs, 1 regressions (v6.8-rc1)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.8=
-rc1/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.8-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      6613476e225e090cc9aad49be7fa504e290dd33d =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65adc25caf68668b1c52a432

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1/arm/mu=
lti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-imx6q-sabre=
lite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1/arm/mu=
lti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-imx6q-sabre=
lite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/65adc25caf6866=
8b1c52a433
        failing since 417 days (last pass: v6.1-rc1-23-g00dd59519141, first=
 fail: v6.1-rc1-23-g8008d88e6d16) =

 =20

