Return-Path: <linux-kselftest+bounces-11437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC15900CC4
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 22:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0889B2180B
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 20:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C457A19D89B;
	Fri,  7 Jun 2024 20:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="DWaBgFP0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF3C224F2
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Jun 2024 20:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717791324; cv=none; b=OWbgjAG8JWz+4M+A6/iGJJT/Ot/tbQSnqpvpfV8qIUcTxAMkh5+sGhWeoX2ROiW2/Kh++GSYgx5CSTOs73Ucikrnpfh4w2hDLt29ddKVChx5XjluXmaP9nON/r8bCiybdATOIF+nIC10WZAg13wx3WPbeKDnWmrPS8DDi8fzX+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717791324; c=relaxed/simple;
	bh=sZ4JM/EcbT7Pg+kVtsQndSxOgpBnN/25e6MGvoU7Na0=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=aIPKS469hjWydET38SFVnir1XsdPl8L1NGDNyDnq02Az5bgmIGzaRAckg9vd5qB8n/wUCRvxxVlYDm4nuYKQ1GgO8dz0Mdk28HTUBYAm2R5uekjDHKDLlL3aLonQ+kNFd0R7wTB7wutxMwB2hrYWdJS94xogCCN9Lr0/8N4rE1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=DWaBgFP0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f4c7b022f8so23395285ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jun 2024 13:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1717791322; x=1718396122; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L8aWQgESKcDzrNX+DI6LYbR/ZdIxEaQ3UHsQEKD6PHs=;
        b=DWaBgFP0ry+df9RmyS5737ewv5A/Ie7bhIqr5z+hkSb89AMmy9qYxGEJAbjCM/MZJp
         wxjZtCV8zGvk5T17/0DL7G9lW8oVjW6T7/WQTdby5nZx/SSwAoK0u3leckLqbzbxpzpF
         i4SEzhEsfJHYJA17TdfhLb61SI2fdP5IrZ/vBX4LU3D8gURYFv2GcuWPMs7EoEWRCPIH
         zI560GeOzwC2BqelZsn/b1sJfS4NnZaiiTwePG2QZ21CW378z95RtCeHGAl54eNDzf6i
         pqT2UQC8WSIhmQDfxqtm5Bz8eoFmdmYAuIZM0+9zQ7inoLxuzaUjdORcaRTw7r11SYIz
         1EVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717791322; x=1718396122;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L8aWQgESKcDzrNX+DI6LYbR/ZdIxEaQ3UHsQEKD6PHs=;
        b=hj0UEolEUwXT/9AT8dW+k9VOb1a/U2BW9VpxCFIOpdL4VRtNmYFiyUZkWxg0SNwll9
         mYst2b/C5g4ayg5xwA0wS+TqetIRqjZlSGbEE8pEihgrow2v7pTYFz6+BbjuxZw879hD
         FHJn7ZQm8EUy02INDUroqeEC9rgx52yBaMjUFJtUA9suwysNa491E1n33gu8RE+uFJhk
         kK/8Vxxsss9LYlCrUe8EJU92/IAyhHb1acU3IL3sNV0dZiP2/IQ3WNibJM9xIRCeTewH
         E8bmWkeD6q9p+RJ1h3MpO6Db/LZrwDJKU5V15t9ej43H6J9gbleumUcp7z9TCEjChK1a
         13Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWHAteIIg0VIo186bG8HZWRM5xbPOuBeUsnCq/oUFdZ85Ml8JLCeMAgAsdfHksEOQxzEwqDCi6njg+ZmepO8Xy24prS5P0GNYnJlv7V/pNV
X-Gm-Message-State: AOJu0YzB7soKgcHYAK7yyxF34veOe7LIVPykFqzHnJjH/h0tJfXH5tWU
	m2sXwvt2Hwvot8syaFua+b0Ba7cdigAF0XVvqGGl5lKx4ddp6mqLyRp2CTPp0LW0DX8oBRoMWwB
	Q
X-Google-Smtp-Source: AGHT+IGs11mvqKkwpmIqnl06YoF21e8nxRYrH8AzU0RxrnIsIfm0/mZwMteuyEdRNAixTjX7bbejuw==
X-Received: by 2002:a17:902:f688:b0:1f6:5013:7842 with SMTP id d9443c01a7336-1f6d02ddca4mr41100715ad.27.1717791322409;
        Fri, 07 Jun 2024 13:15:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7ed609sm38461175ad.239.2024.06.07.13.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 13:15:22 -0700 (PDT)
Message-ID: <66636a5a.170a0220.1fd726.b15a@mx.google.com>
Date: Fri, 07 Jun 2024 13:15:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1-1-ga567885b1ecc9
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lkdtm: 3 runs,
 1 regressions (v6.10-rc1-1-ga567885b1ecc9)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lkdtm: 3 runs, 1 regressions (v6.10-rc1-1-ga567885=
b1ecc9)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
0-rc1-1-ga567885b1ecc9/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.10-rc1-1-ga567885b1ecc9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      a567885b1ecc9ce739d128c9f2e5ef6369dfa59f =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/66635a06f3b94671bb7e706d

  Results:     62 PASS, 4 FAIL, 21 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.10-rc1-1-ga5=
67885b1ecc9/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.10-rc1-1-ga5=
67885b1ecc9/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_FORTIFY_STR_OBJECT_sh: https://kernelci.org/test/=
case/id/66635a06f3b94671bb7e7074
        new failure (last pass: v6.10-rc1) =

 =20

