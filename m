Return-Path: <linux-kselftest+bounces-11078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8384A8D6D51
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jun 2024 03:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59231C215C5
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jun 2024 01:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103CBE545;
	Sat,  1 Jun 2024 01:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ZkbKLk0Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59A6AD32
	for <linux-kselftest@vger.kernel.org>; Sat,  1 Jun 2024 01:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717206170; cv=none; b=ui6JGtqVlKMiEoCOBB9XhDG1Zr+FhSG98APMks/lV86MK2RFQrjvOh73C2L6SaWVuFNz3IIWUgcOUUPbhcaN/OZIOQ/XN6d4bXYx/j+CuzkB7Jc46f2dzomS+I5yeWglj0Oiz/6/4bJoKmI/Z2brkaiMK2Y4x0asVvp3nNRkFzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717206170; c=relaxed/simple;
	bh=9q24OK+54KK88ado61PuNosVaFVX47B1htwWtAs+klI=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=sJUtzxo/ERoIeHLskF4EENZqAkNQMDhSkdeq7g/mpXZzwiCc1pyezwsPRZv9Q6gHi7GCT3jZdT4UcaBLP6dRj1B12HvYygo6viAwQ9PWspMv6wNLYWZg6dN/vOURo9URQEg8kVlBKnuBKDMuIkYxs7/4FLM72vsJ+GxK1h3zgCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=ZkbKLk0Z; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f612d7b0f5so16742495ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 18:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1717206168; x=1717810968; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JgwVkC+1e/A1lIpOAlYn5oeYv7Nb64OdVKrEq74KydY=;
        b=ZkbKLk0ZcrNxYsqS/V3/TjBZD+0iDDfez3eQ5qpmI8PUL2pGL89AxobCW34yUbZ9PB
         qWiOLEnPedEIk0Sz4ahW4OFVBGeomm5s36J3pQKsrbMQ4VdvRttoOxj+7r5qlBSu11Yw
         VZvUkbG7ITDTGZdvFWoYbg6r75slgrJnS/jyFCCEPyYypgDojg8YymmWETH3mMJHAn2z
         ghG13IoDXlxDeWPwQBCB4Wi+4+3PQ3A0sfCUElzWZFNd3TG/eo3uRdeGrld/jls+DHNB
         TOgZPm2z+r04Fv8M4xReoGIGjfOLgoFq1NiL/bjTOngbHDd0EMSOPSK0cyOaUBpR4ter
         fzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717206168; x=1717810968;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JgwVkC+1e/A1lIpOAlYn5oeYv7Nb64OdVKrEq74KydY=;
        b=qptfo78Nukr809JPsfXUh+wnmBK0iMmNQmTMPXYVQ3MLWVVhSU5PPpWzwJbx2OdExM
         lA+mAkdpCWMUM0FUqsBQsWK90dLXrtcjCS8bDHxiVaDFI3cVxoYmHvXazbCCbo4RPFne
         lEDl+oDGzZc7nch2RVfItClDbeMi5KNGcRVLAvkG0dQlthLs0bTzpL7mwsRUb1f7q1HT
         e/mg2ZbVgRtuMc9t3N2LI5TemiujBNJydnfJH53HcgwpbcEd8CMq5dpjKlekLhqYfyrd
         QyvemrBBVrpWTdJ547cdstSRcetjUVdPxBBNJpqYMOpyv0IOqGr9O9+UEsqHmPqkudTR
         tp+A==
X-Forwarded-Encrypted: i=1; AJvYcCUFDV1HOZJv10WH/RjXolDojMzncncbMFj3QXyyHmJWk9834gkZYt/RCnkV9WcjLTtzmf84h9L9o/ggEModIyxJs4BkaXPlJLBB32bSsmkZ
X-Gm-Message-State: AOJu0YyNK08rZIq7PrFD03EiaLJUrLONF7ZtGmKcLJgC+US130F4pBBc
	evk+RMdwi1WNiOI7hHIacy0ZLaZip8yfy7W2l7HTOrRuB5tIZVZSHDIBo8JV40MC6fxi1KqjFUa
	v
X-Google-Smtp-Source: AGHT+IFFY+xfatOPUpZrARK92RgFC6q+EC9IHtqxmByb3KZOulEn2V9xcOONmG7+s6U+i9wmcIAJvQ==
X-Received: by 2002:a17:902:b941:b0:1f2:f8b7:60cf with SMTP id d9443c01a7336-1f61bfa5c34mr71089335ad.27.1717206167857;
        Fri, 31 May 2024 18:42:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63240c947sm22868885ad.269.2024.05.31.18.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 18:42:47 -0700 (PDT)
Message-ID: <665a7c97.170a0220.dae7a.6f1e@mx.google.com>
Date: Fri, 31 May 2024 18:42:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1-11-g4bf15b1c657d2
X-Kernelci-Report-Type: test
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-lkdtm: 6 runs,
 1 regressions (v6.10-rc1-11-g4bf15b1c657d2)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-lkdtm: 6 runs, 1 regressions (v6.10-rc1-11-g4bf15=
b1c657d2)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
10-rc1-11-g4bf15b1c657d2/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.10-rc1-11-g4bf15b1c657d2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      4bf15b1c657d22d1d70173e43264e4606dfe75ff =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/665a6e1c29beed0e797e706d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.10-rc1-11-g=
4bf15b1c657d2/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabo=
ra/kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.10-rc1-11-g=
4bf15b1c657d2/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabo=
ra/kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/665a6e1c29beed=
0e797e706e
        new failure (last pass: v6.10-rc1-9-g0f42bdf59b4e4) =

 =20

