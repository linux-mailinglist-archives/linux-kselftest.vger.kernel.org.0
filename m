Return-Path: <linux-kselftest+bounces-957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9D6800A87
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 13:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7478E281ADF
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 12:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DEE24B29;
	Fri,  1 Dec 2023 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="TPyB9Hvp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4F1172E
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Dec 2023 04:11:29 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cfb30ce241so4020775ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Dec 2023 04:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701432689; x=1702037489; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0yI20JE0N918FW4Z1S/lc/k8ySJpnjscm01k968S/64=;
        b=TPyB9HvpFSWNeSz5a+YEYW+zsLFR27rxE1adP+4F0dqy5FA+Z8vReiHXq4NTLmQlvl
         zB7ygJszbeTjVRK4sS3hvnEk/Qe67jGzmO7obP0GuK0ZQGw7Y3tmcw8WvsjtL24oic73
         mJ9gyvdf1JOWwBeIxv0GDFXp7vIHNK02TJPAvL8XfLx59WWfb+d+trb7+/ZGsp8acRec
         NrzwVBrb/rnywfLLUrc2UFimMWyBs2s2ii4YW1rf/Edn4TAT/Hy+0VXmAhPdMK/ER96I
         UelGJcL2r4nG8Z4BZaW8WeFqQPAdsdXqxc35M9qHS9O/K17YsOqcudzWXJTkNHBMGws7
         /Vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701432689; x=1702037489;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0yI20JE0N918FW4Z1S/lc/k8ySJpnjscm01k968S/64=;
        b=pooq3Cxb2bDsqiC1RfLLNp7/9S5OBeA60R0A3LLZS6WHLC7S+06Hy7lqeyIvikjwyG
         jrwDDcxyf2JpqlzBesBzyIR6Ih7sMBAeCE67CrdBQYkqhg0pq/7i9Tiwj02JS5nPSare
         5fDOFE7ty3kCtIif0SwMjwLcyAjsujImFaMeDrcA6OQubagbeVrENl64YNwrrlzr97LZ
         2ZCY0j2FFSuSOn4/UVYG/ZFyi59dYx46XewvH/xVpWbdOTSGU6Hb/dmqw43zwTArkKZW
         Vph1WoQ2KmsHXIAS38pamVvuW5rI2tpaUdnx2DhdG4gBgtyPRVEB1MXPpR3CFAVKCq+M
         dMUg==
X-Gm-Message-State: AOJu0Yx1hKBM8ux8HIMaemWR7MNOQIWOZPiDbNGKE96+F7Nzg7ALUTCq
	vjDOPYvWT7agkW91SCJfW0GM4D6O/EY1ckBTpR5Zdg==
X-Google-Smtp-Source: AGHT+IFkhvUFkQtfy1LCa1QvODBOikVfSGUa8oIvI3VLnIpum+2J4/qKxLLUdNjHUbUjU5lMr6lRLQ==
X-Received: by 2002:a17:902:e546:b0:1cf:ff41:51e2 with SMTP id n6-20020a170902e54600b001cfff4151e2mr13399576plf.55.1701432688860;
        Fri, 01 Dec 2023 04:11:28 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v3-20020a170902e8c300b001cfd9ce2045sm2381410plg.80.2023.12.01.04.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 04:11:26 -0800 (PST)
Message-ID: <6569cd6e.170a0220.bcbd1.7c9a@mx.google.com>
Date: Fri, 01 Dec 2023 04:11:26 -0800 (PST)
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
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.7-rc1-9-g130a83879954a
Subject: kselftest/next kselftest-livepatch: 2 runs,
 1 regressions (v6.7-rc1-9-g130a83879954a)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-livepatch: 2 runs, 1 regressions (v6.7-rc1-9-g130a=
83879954a)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.7=
-rc1-9-g130a83879954a/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.7-rc1-9-g130a83879954a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      130a83879954a9fed35cf4474d223b4fcfd479fa =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6569713c192e7ddd9c7e4a96

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.7-rc1-9-g130=
a83879954a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.7-rc1-9-g130=
a83879954a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/6569713c19=
2e7ddd9c7e4a97
        failing since 409 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20

