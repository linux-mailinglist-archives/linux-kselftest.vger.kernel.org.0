Return-Path: <linux-kselftest+bounces-19310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4726995CA3
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 03:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6271F285D55
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 01:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58E779EA;
	Wed,  9 Oct 2024 01:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="kzVSnrdL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B8C17555
	for <linux-kselftest@vger.kernel.org>; Wed,  9 Oct 2024 01:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728435988; cv=none; b=MNfVfVbJi4MYZB3/CUpAH6JNPNSpRerC0bX6aYeaGtlhZRMT/gfUXqCVhn4+Hx1bFAh9MRhojosvvG1aX4StzcWoROWZ9nMb06djOu8QKHiPfrTnkmTRFdy/l+bo5rOU8CnXPPuhQXSXaGvdaGkMsUCL/GDP9HjZMyibYci1zKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728435988; c=relaxed/simple;
	bh=CTVy5rNhcPUrb/6upi14ktf1KENOhbNazhWKbVBHfew=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=oXT3ZRY2Em5bwVknttjOoboXg7tEzt1VAVcF0ZOnYvw4nuWeJUOroX0ihLWcyqzzFQ0/w137BnYtyaQzOuPUjLlXegXvrRPzdu+MmazQmt/G4wea0TwNWhqKJpE32LIb0hB+Nrcr9JeN9t+I66/A8aoPYe7GeDRPDYMCu++zeKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=kzVSnrdL; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71df2de4ed4so261872b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Oct 2024 18:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1728435987; x=1729040787; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=REvxRWVcCO+QPKUjYt+r6iSU06Q8MqSc+12b9ZT8wLo=;
        b=kzVSnrdLbHnGetXYzEIzjIiThZ7tj6kh7Ny1g7haHBG1wio+IiOS+sng4JAd7j2uSm
         Oem5bmGQR1kNi+RdAzFcshseqwZq6fAD/spdTzFgG3Ume6u8vdTZbhucl+M+jE+OACnF
         B099j8YOYrNaTfIdMtsce4nZqU/DQpXC+5GhWXJPxflhCoy3TCynCoMbeF2qV88Tw+eu
         VE9FyobzIk6cJ7IH8L2o2P5p1nm6/aXoTHocaG+A2yQzc2uvSjonLp5B0rmG/mdqMHuh
         Y+rHc+6UOzfSmYw1AUs3TGdqnwO9cgxS5nj9l0iZi2oVq1cjVV1i908RmNl9Y2SpsGMk
         k/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728435987; x=1729040787;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=REvxRWVcCO+QPKUjYt+r6iSU06Q8MqSc+12b9ZT8wLo=;
        b=chSjiYSYILnOyjRq58jw5FI20BlEFJcBC+j+8YupJu5ka0/rxQwuiq9KE8a1hwENKS
         6EHup+Gp6/OyfyLtGoZK8bA22ds8yR7MmCNK/P5phyol+JGEzCfpcap4fDBTKRaMD46E
         QFH1APadt9L0WtMWNIDRrJ8cEhKB6+svEYbjaO36akJ7oZFTw45zBv7pn6w2vbgoHOpM
         YabY7vZhAU+BtlujYUj5jvHda4Bj5ErBEUixFGNQSwu3KEoouLt4iJ+Eb6Y6WwQy+try
         KKyuPo2Y7rq0brDx3onLT/Ek2+Tv8itltY0AQKEwzfWTLHbV7hflHCTmq+EYO9u0/jl7
         Jq8A==
X-Forwarded-Encrypted: i=1; AJvYcCVEHkQTbg6cBhJTp2x8GOn2Ta9b2q0PDbPzAk/5hJmhVgVXExi5ucV1DdoBdQApjaUcs+M84OaM3xarZFbppBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJwOo+JMenSztWc/IREKhy5RVCrf8LaoRV8bdUjv5rCmsJPxL8
	EVvfXWAbbF3Mn1YzMABCxGYbGUXz1V3dGkfpFPyUXgHxAKJ8TQpC37202JrC/hiaX9XmRBOrBm0
	2
X-Google-Smtp-Source: AGHT+IH54apNPY1M3CFeQpDL9pY4T3JPYGB6kHlX4eomeU5rbhHf+xR4UR9rL45MOlDogCB0jtxjnA==
X-Received: by 2002:a05:6a00:61ca:b0:71d:f9c2:b9a with SMTP id d2e1a72fcca58-71e104d856dmr6246467b3a.7.1728435986702;
        Tue, 08 Oct 2024 18:06:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d7d3aasm6707384b3a.194.2024.10.08.18.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 18:06:26 -0700 (PDT)
Message-ID: <6705d712.620a0220.29e177.8d0d@mx.google.com>
Date: Tue, 08 Oct 2024 18:06:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux_kselftest-fixes-6.12-rc2-4-g34d5b600172b
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-seccomp: 2 runs,
 1 regressions (linux_kselftest-fixes-6.12-rc2-4-g34d5b600172b)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-seccomp: 2 runs, 1 regressions (linux_kselftest-f=
ixes-6.12-rc2-4-g34d5b600172b)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-12   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux_kselftest-fixes-6.12-rc2-4-g34d5b600172b/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   fixes
  Describe: linux_kselftest-fixes-6.12-rc2-4-g34d5b600172b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      34d5b600172b846161e507bdce132c98d9cc9701 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-12   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6705c93503f7c09e74c86855

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-12 (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.12-rc2-4-g34d5b600172b/arm64/defconfig+kselftest/gcc-12/lab-broon=
ie/kselftest-seccomp-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.12-rc2-4-g34d5b600172b/arm64/defconfig+kselftest/gcc-12/lab-broon=
ie/kselftest-seccomp-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6705c93503f7=
c09e74c86856
        new failure (last pass: v6.12-rc1-5-g45a8897db67d4) =

 =20

