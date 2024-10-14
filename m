Return-Path: <linux-kselftest+bounces-19648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8416799CAB4
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 14:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B12280CB7
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 12:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58FA1A726B;
	Mon, 14 Oct 2024 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="j/lAOMPE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F03F16FF25
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2024 12:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910329; cv=none; b=oHrzsF+Lhcca7zodc5jw3u6ryTUvG/bWh4aN0r8a3d7aizzULAHePO63Qeu7rUb63QmN/lJ+OeqvCQv6GO8DH/dMAxeX7JcovjI3jIoU7XuOr6/ixBTmNf4zERRDk3BXaV78luT+7q4M8MYFbX+VGJwr+FK9FR1mFRckcd6u5kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910329; c=relaxed/simple;
	bh=OsTxUs4/SWvCzWLjDIUovBS9RHmoyLWLQ0t3vDJ7fr4=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=ujSOWU0fyA6mlWNIlpVeqBmpPtprADA6yg7zXcG7otLvrEcTb9rIgNGDKtwJfPojnkUZbOGsb14ziiLEyeos9rnQx1FWUVkO0bGG/qZz8DdC2tAX0F5hHWGm5d4lMQ3JgGQ9GENcwoi7T/Ou5ZgFNx7V2oEJAGLWHLabbMwJCh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=j/lAOMPE; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso3101018a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2024 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1728910328; x=1729515128; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MT7n5/aFwYw6jU6PJjvnVNtOAgtadLbwwQsdZooyIHw=;
        b=j/lAOMPEXpfH0gE+1BqxUXs13j1S/LLDkvP+gARd9JE1kJj/23h9SD+ERAzk3eOn70
         7KOWMoB6ALB7Wg4mojih6Lwa9XU1zk4YDgL1IOwacOpzZvTK944vMTPdngwkOGWP2e7s
         khX3dQQNISvFQCqK0BgGCwhbVgB3Bwmg5lKjBVTFScHi9SCNNHfdbBUHBFx7CIpwvqGL
         Ak0xdFp2leJF33/4km4+wLAngtj39T4ZyHEjTp0h00amqv6N3xnDdgvJTzpPQuJnzS7t
         qfsDUNHNHnNr72TaXg8+Jj25Nzi87ZEkjayo5TQwal0f7Cgut0dwj21wpyeEfCSXyIuZ
         vJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728910328; x=1729515128;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MT7n5/aFwYw6jU6PJjvnVNtOAgtadLbwwQsdZooyIHw=;
        b=wPqE5v/1w1KrnuTsqx1vfOFOsbO8cGIgkLemsPH6juTeChU0xiNA5tGPJ22/2JHIWi
         R0jb+efT4gUrKIl/nuLrurv3WYx33dEV9b3Qa6aea0xWMlh9sq4VrPtu7gSjrNN6WHKL
         rqr6n/Bye8FbHJ4EPnT4h+kUM7vo/WhtUpp8Up2KN6qxUeFG7HC8YFbYKDn1EIJCEako
         AUL9kf/llS/SjfgInsp7x683SL65Re2dIS3ZCUjAhIKKK0pJtwXRwiOlTGgv5YX87qLb
         7H6Xh8+dxZxJ141wjYhxUCbY6BH/QxGS+fClxsrGb00n4OH/xpsitTFg4IxuJcWCqhzX
         cFNw==
X-Forwarded-Encrypted: i=1; AJvYcCXhNGgBRqjapBIiQnid8XXnKBAYJZczF9PUYgHzXOb4Zd8OB6j7mlD4ngfLyGy+3o0wgNTEDH9JGJvnF64XSfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuHkjxkQBUYVbiBfgm6hk/afEwtiEW5fSs2lkqQkNQ4WdozQen
	CbJPFV9FFHAD6+O/8VVSeaz1lQl+YQFVN8nD8FCvvoQEaQPEyznNB77kRUa9sKM=
X-Google-Smtp-Source: AGHT+IHPoOW0Wer/i02Ti8ua4IwrmUB+cPVmXbZQj8X3uQ4d24YzZwJfYH0VALJ0qQvt6gyy2NV+yA==
X-Received: by 2002:a17:90a:db8a:b0:2e2:d61d:60e6 with SMTP id 98e67ed59e1d1-2e2f0aa3dccmr14140763a91.17.1728910327851;
        Mon, 14 Oct 2024 05:52:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e323c8714fsm4892959a91.32.2024.10.14.05.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 05:52:07 -0700 (PDT)
Message-ID: <670d13f7.170a0220.35123a.957a@mx.google.com>
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
Subject: kselftest/fixes kselftest-lib: 2 runs,
 1 regressions (linux_kselftest-fixes-6.12-rc3)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-lib: 2 runs, 1 regressions (linux_kselftest-fixes=
-6.12-rc3)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-12   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux_kselftest-fixes-6.12-rc3/plan/kselftest-lib/

  Test:     kselftest-lib
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


  Details:     https://kernelci.org/test/plan/id/670d06ca62e90ff6e7c86855

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-12 (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.12-rc3/arm64/defconfig+kselftest/gcc-12/lab-broonie/kselftest-lib=
-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.12-rc3/arm64/defconfig+kselftest/gcc-12/lab-broonie/kselftest-lib=
-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/670d06ca62e90ff6=
e7c86856
        failing since 5 days (last pass: v6.12-rc1-5-g45a8897db67d4, first =
fail: linux_kselftest-fixes-6.12-rc2-4-g34d5b600172b) =

 =20

