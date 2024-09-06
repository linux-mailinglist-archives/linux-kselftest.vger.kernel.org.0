Return-Path: <linux-kselftest+bounces-17416-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3EC96FC29
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 21:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74200B20C54
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 19:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B59513B2BB;
	Fri,  6 Sep 2024 19:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="qvX8wfcO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E293F1B85EA
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Sep 2024 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725651054; cv=none; b=My2jQd9Gnv0AEMJh70gRjYByRx88x3E2F5fYOiWNV7edU6Md+p59ShQeUSlOBExDACVMLBXEvY39yfDCYJrWoAdOxvkv5F2X9vcEeUxh8vJzfDIhjmjH4Z+Wzlmz9FjLXom22fva5caXft6xL7O1xIvgAACMNukXlghF2ujMVWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725651054; c=relaxed/simple;
	bh=p7igByil926D5c+iPHFN6VJi/RvmTCyCyDts/K1lFBk=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=KW/MVuSjGUU01YVk1ZBWz/z/jYeX83Ldjvg+v7vFye+gRNIxHoIxhx13w16w/EqRJhwIdNYPkqRhNlylfyanNIJw5gpq4JjHHR+/gmMop1kDetY04XT/2EHBq96SXobc6TjRKQoA+YoCvO4n214mEU6RhmTSZl7AyZWGdY9kAb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=qvX8wfcO; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-717934728adso1755409b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Sep 2024 12:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1725651052; x=1726255852; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=onFnTghilyTPI0sKbO7B8Zeu0fwK9cLqDJb637zInbc=;
        b=qvX8wfcORtw+YqO9PFe+CSBUZ3sIOyYSc3Sr+7dHhp1ucC4KAOEqz19nLvRsw38JLl
         CpT7LdX9GtTAiB407tyjt/VVJ4tihY+xcxJOy0bwB+qCzDbX1ggRSYmVhBwq94YeP7W+
         TCQT/F6WdWeJ9bJSQQJk/iHaf3Gc7m9vj9ymQs4Qd8CrLLKWcRNkEPuzSmlYw0JrTKWQ
         eSzuEsG10i86LigtyGAyJu8UAi52iNxQAZvwkkglkEe2KX0VDR6ITaaXL0WzDoFPZqxA
         1BH5HRwvaM+GO9fc6I7lQKLOho1DC2My0ROhTpJAFgRcGilO31J1Y/PlHhZ18DdEBFv4
         fZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725651052; x=1726255852;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=onFnTghilyTPI0sKbO7B8Zeu0fwK9cLqDJb637zInbc=;
        b=RGkrqJ0heQ4hThnC0e6ETEPuUD7/oUszguA+1L6+X7LNkSDdotBpSe+Wb3V5qsY5cI
         rA0eMZr1k7oV7IVF7DG+qi2fstFAVsiielkyA8N/kk4fOSXVWADr9LEyUY8p/K1ZjGTr
         ExECiQ79+nSctoAGt7o3fRjS12azuRk4MmXsrYhJf+ZfzY+vquX6JVK9AUe/lVExZUXD
         QQm7u0GGZMtmqX56I4kd2ijgQnDRe9/xFTGwg2PsIzw39LsxmQvtqXnbF/tSZvWgxHwF
         8g+JiAvCTRo3Eo0/z/3Cjr7HM81hjDT6N/DMusc8AngWKB5Nl/dSnDnHVXn6Y6+1RKZA
         nKbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfDpWyYDY/4PB+3HfZ386c8N8Dsb4nqpCq73F7dmfcB+HkHHm8d8W/1y/Gdd88iIFVQ5WHoXHOUwv4Z1YZ21k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgGN/EzcmCM5J1hBol657daqxcO/nFvRMnChI6kYhvWeyF/Nwk
	0er9BAmUsXFdHzAo6jX0C98WLjEE030QpC9tvw7AdvZHZ/ajU4QCZzyWdumZw/lnN9ZNL7AjzHe
	z
X-Google-Smtp-Source: AGHT+IHy55a3tyVnwINgDc9QJWbA3y41d7Mn5Q3K/mYL89zb26hcNWyuLbLsfP4nyOONrPvmw3KT1Q==
X-Received: by 2002:a05:6a21:350d:b0:1ca:da64:4f4b with SMTP id adf61e73a8af0-1cf2ac710a1mr202086637.2.1725651052167;
        Fri, 06 Sep 2024 12:30:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71794628cc9sm2619281b3a.11.2024.09.06.12.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 12:30:51 -0700 (PDT)
Message-ID: <66db586b.050a0220.f40fb.d5cc@mx.google.com>
Date: Fri, 06 Sep 2024 12:30:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.11-rc1-19-g7beaf1da074f7
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-seccomp: 2 runs,
 1 regressions (v6.11-rc1-19-g7beaf1da074f7)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-seccomp: 2 runs, 1 regressions (v6.11-rc1-19-g7bea=
f1da074f7)

Regressions Summary
-------------------

platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
1-rc1-19-g7beaf1da074f7/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.11-rc1-19-g7beaf1da074f7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      7beaf1da074f7ea25454d6c11da142c3892d3c4e =



Test Regressions
---------------- =



platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/66db52a8b348d6369bc86855

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-12 (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.11-rc1-19-g7=
beaf1da074f7/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-=
seccomp-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.11-rc1-19-g7=
beaf1da074f7/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-=
seccomp-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/66db52a8b348=
d6369bc86856
        failing since 38 days (last pass: v6.10-rc7-29-gdf09b0bb09ea, first=
 fail: v6.11-rc1) =

 =20

