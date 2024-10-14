Return-Path: <linux-kselftest+bounces-19650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C989A99CAB6
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 14:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7238C1F216D7
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 12:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510CA16FF25;
	Mon, 14 Oct 2024 12:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="EAcRGVAo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EAE1E4A6
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2024 12:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910330; cv=none; b=m/71MKjCuN+4va5zL0XGmU3gtqsU6MilHrH59TtOwyQtaES2hWGncYRuiGs9ThXxE44yjoOKuEpB2gSXRQVUTYJJo8tyYutVG6KrJq5irKTm2Najcx6W/3Hg8IlASYUHZ1pRrVzARX4wjrnwsS3CN6aEVsEx80tl2/1Ho8ficEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910330; c=relaxed/simple;
	bh=YS0SJOQ03fKvHEsx98Jo3CZsxs+ZYg5wHIXpROw/VMY=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=AmXSS1LBhB9yioY3eh9nyFnALHKT3Qlddu4SgW5A7YNpPtn8QD4hVwhWPkVKnH9YRyZXuxACz3GskE156wXiVpbkUXVyEndZSmL6YFipcZ6Y81cokbm87GMuCSzEIBIZrhVvJuLt+6b8Ptn+o+HVYuxShwGqlCMs0/yf/vPIRJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=EAcRGVAo; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20caccadbeeso27849975ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2024 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1728910328; x=1729515128; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KWb8s0hL1XXigb7WkTMzqyjunaLsziZrnuG8cLLyu/s=;
        b=EAcRGVAonlyhPXHU7kLu4E0DqbRksp+/dMdI3ZSYnpqE27DyAnCuPcvbh+nrtN7gpj
         FpUZfHZbC8bLJYyU/2gDsGrxPDXldrgTGPQHMiSu1I9aS1AZsPHJ6E7DzH9Ytqjqd28A
         JtY0MeGmbSVSBASsb4t4sTUgU9MRjp7zyD0zhqBLWvLIrdxTqeIDQGxajdNn2ZP/Alz6
         vwiDEyJi4fxzNkoUganNQ7Dyk0Ch/T69f5Sj31nOPE5oG6o5L6854I83yDxgrT/CA/Ml
         ut+GJhJuy74HLldwPmveDI7dRo9tVBNXL6oL2VQGOAxkg+qElxxq8NOB+curiroiG52d
         vWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728910328; x=1729515128;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KWb8s0hL1XXigb7WkTMzqyjunaLsziZrnuG8cLLyu/s=;
        b=xD9dzh224vJJILQsdUudebumVxhddIT3l8ZA76G7++O8TDtWcXXOzIAwsEaZNAh2UL
         eiHWJxAKxqFzo7BGlUoLkHE9qrsNbBd2QfVGFqbrUvLHErEeYIo2TMJnS9e7+bftIg2H
         06Wwp27bNDcsMgTEu+8I/7ogcB/0c384+Gm+LdZDXXJS1V8DF6cSn8KSBsTPb3suo4O5
         E2y+jDTJGqaTgVbqkqvYK5SL/3iCYw+1sTttY/CLZ+XYJAz2rtuKgDRMHZKpkxdf3Zl5
         EAXI6kjcz6fm5VsqujE26DTU3CXwtaXyTM90TV0+2jEpzIOK0y6E1R1wbj5hBZUAWDra
         9PHA==
X-Forwarded-Encrypted: i=1; AJvYcCWAWLal8GC384sCuCKje/Lix+KEm5hqTc/9OBku0IcsxmNIOKePvLxIZPLwE6LVHEhkMCcFTLE2Zu1nrV/jWT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZaVYI49XHwxMevNibCNPIQn987sU+luYsXOJ/vT5JXWAFyK2b
	TH/2AIceMnAlidbNwQhoy8iDOI/jpGXaKwLY1XmCagnp20UsIUksFQutiAHI0lhzeRN+j0xBfLt
	9
X-Google-Smtp-Source: AGHT+IHl4oCs7FS5LsS/0eDUGeag1bfNuJoZxCsCxycIq6CSVPBQcaUuLTAHY5/PZBxryb9F1NWFJA==
X-Received: by 2002:a17:902:db12:b0:20c:5ba1:e8e5 with SMTP id d9443c01a7336-20ca145d515mr169324115ad.19.1728910328226;
        Mon, 14 Oct 2024 05:52:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c36a754sm65051245ad.302.2024.10.14.05.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 05:52:07 -0700 (PDT)
Message-ID: <670d13f7.170a0220.f1557.2e1d@mx.google.com>
Date: Mon, 14 Oct 2024 05:52:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux_kselftest-fixes-6.12-rc3
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-seccomp: 2 runs,
 1 regressions (linux_kselftest-fixes-6.12-rc3)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-seccomp: 2 runs, 1 regressions (linux_kselftest-f=
ixes-6.12-rc3)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-12   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux_kselftest-fixes-6.12-rc3/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   fixes
  Describe: linux_kselftest-fixes-6.12-rc3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      4ee5ca9a29384fcf3f18232fdf8474166dea8dca =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-12   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/670d07f5cd937325b5c86857

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-12 (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.12-rc3/arm64/defconfig+kselftest/gcc-12/lab-broonie/kselftest-sec=
comp-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.12-rc3/arm64/defconfig+kselftest/gcc-12/lab-broonie/kselftest-sec=
comp-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/670d07f5cd93=
7325b5c86858
        failing since 5 days (last pass: v6.12-rc1-5-g45a8897db67d4, first =
fail: linux_kselftest-fixes-6.12-rc2-4-g34d5b600172b) =

 =20

