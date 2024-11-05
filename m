Return-Path: <linux-kselftest+bounces-21433-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB399BC30A
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 03:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2B91C21867
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 02:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2B12C859;
	Tue,  5 Nov 2024 02:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="utchch9P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573331D6AA
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Nov 2024 02:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730773003; cv=none; b=ka2Ktuamkdd/eDziV6qrOYUmJSFYZ4N/ygqN/FC/oQ8by0QAD4xXY+ECNdmSr2rLDDzAYhor0UuiFIIVXlkWMeiGVY127Ofw3GgqYNz5KAmZTeiGXLpDv0KBst8I9X6Go02LUEw2h6XBOlZIA2qrXdEYmD54Pt/K9OOtIDohf60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730773003; c=relaxed/simple;
	bh=/Lazv/4Zex591O/UgLJoNuq+ALqyBBub0IgGOjRflCE=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=WjgWpQPOFEqJWqpar7mgORd6lZmDnZv2BjVkf3LHi6ZL1dkOcj6aUYB/ta2UW+/c2XsqN16fD708trfVdN6ZcxvV5rRzsmtNgGTy3UNcDBbztQtAoGp0CgxD5WEV0875B8azONWGkTGcRCPVC0q/B07kXU4Q1vrn2hRN3W0/Deg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=utchch9P; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e5130832aso3960848b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Nov 2024 18:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1730773001; x=1731377801; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IxoOr9q6IdV2Q0p+c1X5DWXzBUZ8iSsW8Vi1xCiIsGs=;
        b=utchch9PebEhKbQ7PG77kaQlWTBLBd2musLiLzzz3ZV4vbn4YXxDcbybMm+WBPGbdi
         mYT7EyK3ptTvMe7Ox0y7hKh0LB6kTCWyITLmxjk2tm3v3GJnUpp1yXClaKTc7TsyT8pf
         fauSXPDjDel3buQ8AYrAOJx5+V5yCtaJm60HZpb+ukYk2UFFGbCIbhEJJxoRFRIJib+Q
         MUaUQc57a7XhdI3qvPmdI51c+dWyPBlgycP6gMT93K9Heb5ThPL9nHh8cC6K5juSSMrC
         5j6j1HHoiYzBUFksvIvH9pNvY75kUFD4hJ1n15tWTqO1a163a6UMqjMRxISedUktk5Gu
         zyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730773001; x=1731377801;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IxoOr9q6IdV2Q0p+c1X5DWXzBUZ8iSsW8Vi1xCiIsGs=;
        b=OghsCuVMc47q1U8/th3ER6fbvsTH3Z0/TfWY+x/G2MxJmh16GuOSxiDnXBOhPJ+nLT
         jp40qqgQXgL7Y8FCjavBLaYQ/ynTvcyKAYIz7Qh6j5K2H0muA47Rhcg2QnEx1+mMTd1m
         FcoCE6ewKb5TwpuzDAYzLKWvXED3YHElGxyRHA8xK1ieQ0UFxOHq75gX8hEGWozna/d7
         5LVwvyFnGbX3ZRnCn39+9spkzcl1XHtsWazWcdPCWdwdKdRH3/782QV4OqM6hUUl/eHs
         w96T3ejuknrBhSwZapVNLe6gcPsuSnZWErF8zx+QHylqTJOYSEjPpqvvq1ndSE22M4W8
         YBqA==
X-Forwarded-Encrypted: i=1; AJvYcCVyj8cCfo0JbLVZDvRleoHBmfm5qpcnB/3MFJY42TPCSZ2pP3OE6BFXLWwTwdM55tcET8Z/t4/jFhnWy/4Nua0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB7DqjFzglaP7rubTeLho2mOnwT7eOuYLZMd3pViGfy5PDdEc/
	yndK7jSIZ+pugsAwRtrQyodjRxmwTKAdoS/SmvlTXRcdggQV9X11cUeuIyQnfPE=
X-Google-Smtp-Source: AGHT+IHClqccUKwMyYhO1kXwBTT9RHGOmUPXgiS4glyQrCqPnorbHGcfRjsb0H8pa9qTnUlagxfaDw==
X-Received: by 2002:a05:6a00:3d41:b0:71e:a3:935b with SMTP id d2e1a72fcca58-720c99b97a9mr20121115b3a.25.1730773001337;
        Mon, 04 Nov 2024 18:16:41 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c3902sm8206302b3a.136.2024.11.04.18.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 18:16:40 -0800 (PST)
Message-ID: <67298008.050a0220.28512f.3b99@mx.google.com>
Date: Mon, 04 Nov 2024 18:16:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.12-rc3-23-ga44c26d7fa74
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lib: 1 runs,
 1 regressions (v6.12-rc3-23-ga44c26d7fa74)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lib: 1 runs, 1 regressions (v6.12-rc3-23-ga44c26d7=
fa74)

Regressions Summary
-------------------

platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
2-rc3-23-ga44c26d7fa74/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.12-rc3-23-ga44c26d7fa74
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      a44c26d7fa74a5f4d2795a5c55a2d6ec1ebf1e38 =



Test Regressions
---------------- =



platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/672978b37de8409f75c8685a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-12 (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.12-rc3-23-ga=
44c26d7fa74/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-l=
ib-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.12-rc3-23-ga=
44c26d7fa74/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-l=
ib-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/672978b37de8409f=
75c8685b
        failing since 97 days (last pass: v6.10-rc7-29-gdf09b0bb09ea, first=
 fail: v6.11-rc1) =

 =20

