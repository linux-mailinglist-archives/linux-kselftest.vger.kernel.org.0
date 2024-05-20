Return-Path: <linux-kselftest+bounces-10447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B754C8CA223
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 20:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB34B1C2100F
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 18:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4B01386DF;
	Mon, 20 May 2024 18:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Y1juGW73"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7201386CF
	for <linux-kselftest@vger.kernel.org>; Mon, 20 May 2024 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716230595; cv=none; b=moSzJmuBhyysl+RbABRN8/4mpJVhs2TOLNYcsd69+OmGcMXwhliRJJnlsL+bqjx7Ujlv0+SiNLQAVLYZI32sJZqgNt3XTwNGaL9ypAohvCYogkjFZceNDOYEN81kU94zTFQmbZagcsteV8/OsRFXHuuLPheSKdgMWSqOK8+ROmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716230595; c=relaxed/simple;
	bh=/5WIVCjFVBtsVJ9tek5gUkUgEeygxC10jrWOXOC+mtE=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=A4vtDh5Dk25DY1vCQpU4RDPickTrO94B6vb6IGKLp2q61PKoH7Ucc5bBFP8SEP5HPXNAAtZRfkfGnaJtloYqjonbCgZnOjVw+0/mxfCTBXJ2RZTndLfv6KV+tb+z5FEbL24RcCl9chF5CdljmzmI7sgH20yTdHa7pdLoo4nscL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=Y1juGW73; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e651a9f3ffso80478625ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 20 May 2024 11:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1716230593; x=1716835393; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ea5YQwfvHKeADvG1MvsKbzXHmq/u75tT0JR6NFTw05o=;
        b=Y1juGW731tL8z4yTTSlJIm+ALAbsVVjzxEo8+hUqTwz92iMfWozicC598KxEfrPxlj
         qyt38NaOxd4+t6eTSk6g3orxpXWsRLfAgt5akv0sH5ntSXJjGzmNKQIispUWwE40UuFq
         8Jq/dygEHHu43tT/d3yT3RF1wNMsPCfaSRAA1ObmMsQMDHhImAjFfeN1hYHgX9dqLe+v
         wuVybMTKLa5lPW923mnA7HtC9HCveveVqKxKyCEQoWlqWk5yMHyFRVKHtQyS4npVeh59
         orl7CMITXYNClmilJ6VGVKTV73MhtpeFgriJOiJVpuxnFD3wi4SLabbGPfYnUmCLYgt9
         QmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716230593; x=1716835393;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ea5YQwfvHKeADvG1MvsKbzXHmq/u75tT0JR6NFTw05o=;
        b=H1UpCfF4nKUYeA0qd0o4Bpd0o5qvs4nnsr111n2Lk6w1SKtA8WAygcWLm5CnIawlgp
         ybohWGjwQi0cGLwEyLUJL+e1JmWTEFSz17mQiRULCujWeB4/5fPeHBCkv094BW/liLlr
         ZQvbN7/frMdyLrhUIHe9NI0nLDBda/MLC0AA2AQbKcho8IfFtPus7WJ6IDEu7JQVk+g1
         DzZUEnpxywX0bt4Ho2HTVP26aMj6UKQa5eSsJN/SFui9YNnEIA3SKhdGog5i1UGKjXWL
         2A5wOwBZtfZQzRz1AK3j5xO05UvIBijiJPZvjYKKfiM/NFfShTPlZFhD3yyGO0AdxpSt
         GA1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4mkV6SmPRUjmpHl+f4AGs575Xlg73vT+D95yUOcJv24kxEHN2QFDpoyLC88tlCK7rIWYIpcX4lK+XCywtlVz6f0ph8Hbwx6oLXGD+f32N
X-Gm-Message-State: AOJu0YwXwDoUCpdW1qKn0UOlDVlOWG25TOfH5vQKan34w2zdP+qSydz3
	8JNvlIRIAWUWHJ/xlmBv/EER1r9ePQaUesW2I0qzIh2z62sWa9A0M4dxhUmEoqQ=
X-Google-Smtp-Source: AGHT+IHrkP+qB2K9+1E4Kr/U0ndCgo1byisYJyIEXCrNCxCevFuXohBpPbiDwtMqj6OVm61BCRcU6g==
X-Received: by 2002:a17:902:c3c4:b0:1ee:42d9:c974 with SMTP id d9443c01a7336-1ef44061779mr258334795ad.66.1716230592934;
        Mon, 20 May 2024 11:43:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad6176sm207647495ad.76.2024.05.20.11.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 11:43:12 -0700 (PDT)
Message-ID: <664b99c0.170a0220.21b5f.4804@mx.google.com>
Date: Mon, 20 May 2024 11:43:12 -0700 (PDT)
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
X-Kernelci-Kernel: linux_kselftest-next-6.10-rc1-fixes
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lkdtm: 2 runs,
 1 regressions (linux_kselftest-next-6.10-rc1-fixes)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lkdtm: 2 runs, 1 regressions (linux_kselftest-next=
-6.10-rc1-fixes)

This legacy KernelCI providing this report will shutdown sometime
soon in favor of our new KernelCI infra. Not all tests are being
migrated.
If you are still using this report and want us to prioritize your
usecase in the new system, please let us know at
kernelci@lists.linux.dev

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/linu=
x_kselftest-next-6.10-rc1-fixes/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: linux_kselftest-next-6.10-rc1-fixes
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      a97853f25b06f71c23b2d7a59fbd40f3f42d55ac =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/664b8c24318095877b4c42e9

  Results:     62 PASS, 4 FAIL, 21 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/linux_kselftest=
-next-6.10-rc1-fixes/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/=
kselftest-lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/linux_kselftest=
-next-6.10-rc1-fixes/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/=
kselftest-lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_FORTIFY_MEM_MEMBER_sh: https://kernelci.org/test/=
case/id/664b8c24318095877b4c42ed
        failing since 3 days (last pass: v6.9-rc7-44-g2c3b8f8f37c6, first f=
ail: v6.9-8287-g31a59b76b978) =

 =20

