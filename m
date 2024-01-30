Return-Path: <linux-kselftest+bounces-3768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 812CC842D71
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 20:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2104B1F25242
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 19:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2A171B2C;
	Tue, 30 Jan 2024 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="fx51pJ6i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21F16F08E
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 19:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706644721; cv=none; b=roHiDdYpC7lS/TI3e+T5w1oSoCjfWtxmEaySerEzbJbuB2NXysZ4pyfFa47cMnrWESrK+pZICgLmR3BIyJht+V3C+lX9MSYbkS9oqGC3OXD8vhvXMSD7SdFrQnF3hmh8N8/J4KaOa6yUwq764I2sMA4hnecKy7Zpetep0F+Pp1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706644721; c=relaxed/simple;
	bh=VCdM2kaEifBdHqBSzAyDafD49199Drmi8lwudxj7FHg=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=hNn1n5DVNCBFtB/5UHl1Pubb8oaidCE9hERXD+Y+5MJ1yrc5z27c/Q5/apNtwPyIuYnpB6lrILtooHvt38LfQfg7ghecLBaSns+dIJ1uXWsMe+VKjIEsFTzyZtuncHWg4UkHlLtH8oXsnJkHHJPNHeN42WLIUt9J+fKMZkN4H/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=fx51pJ6i; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso2460348a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 11:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706644719; x=1707249519; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ybKIVEqybrAdiKqE4GtyY7QL+vhlGVFS7ki6FG+D0Bo=;
        b=fx51pJ6iNbFzvwGIfi3/iP1k3+cJJ1RaabzyKSmlwDbPhYPvMcOX5JLOrZ0Jjnfj9v
         oTMI8ahJi9POf8uJfufMgHZmtT2JkcBr5gZOcCj2hZxLH6SoJ8ZfZBXkoR2vYjmNy+xA
         iMoAUtJhyP1JaI6WKB1RoGyBbb2XIsceD9fmUii8zHmjrTN8DxFtEumpSHvKcDKneAn3
         ti+Jsb3YHUJXVS/CmiYuBnTwlC31QoAe51WXolHeXttE83MIyWtKcEHj9Arqu8TN1eA6
         CjyxNJgA4P1tdf6ofSZW1Lby5QwNxqKb3qoobbtqgXPIKVFH7XpyOglNEUwRk7sx8Qc4
         5row==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706644719; x=1707249519;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ybKIVEqybrAdiKqE4GtyY7QL+vhlGVFS7ki6FG+D0Bo=;
        b=hYGDfA/Q46R5jF7z0nUq0hj2pS+zeYC/Nw0yT3aUIJKWQlO+q40cqNaQXOTIZNz+ES
         WMvqdD//zf221LnqZyF7v/qSN/l80j6lu2b3oSYEVI9xoWR64cy0K6KtIT5PoX/f7MrA
         4gzYo9QWK12GvBrvPUvTMohNZwv2t/mwntcXmX+AFe2adnED3Or8TwXP7yybkTOd4EuE
         hgJi9+ic/NacVQeS4VDObU6FPpgI+r1bHwcEjCvA6w0d32BAyPGXVpWqfLGw7312K6qw
         TwOpBPvrfeHROnksYt8c0NBBEZWLs+SoC7Tfajn9X78yb767b+MUTB8CAP+2Fk/65vKV
         Kqtw==
X-Gm-Message-State: AOJu0YzwtavT0ifISVhrO29btMk0oPQBeZKs+SvV5N2IkNrzyNsNTTCb
	qUx5SJ5B3Dkg2YJK6zcjglVX2AkuFugg6tn/oPfKd8cTwrzWXd8ZAbueQdBwfKcBrjUw6mDK9bl
	g
X-Google-Smtp-Source: AGHT+IHydJklX8Ph2GcoiIIqFR3pEBr3L+uOAfkR81XXpHWLMLrSkVCSPBBAATu0+WHPQ2jP5BvgXA==
X-Received: by 2002:a05:6a20:d391:b0:19c:9af3:d6a5 with SMTP id iq17-20020a056a20d39100b0019c9af3d6a5mr6516801pzb.26.1706644719192;
        Tue, 30 Jan 2024 11:58:39 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id lp17-20020a056a003d5100b006ddb0dde293sm8213126pfb.65.2024.01.30.11.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 11:58:37 -0800 (PST)
Message-ID: <65b954ed.050a0220.2a933.9923@mx.google.com>
Date: Tue, 30 Jan 2024 11:58:37 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: fixes
X-Kernelci-Kernel: v6.8-rc1-4-gb54761f6e9773
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-lkdtm: 2 runs,
 1 regressions (v6.8-rc1-4-gb54761f6e9773)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-lkdtm: 2 runs, 1 regressions (v6.8-rc1-4-gb54761f=
6e9773)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
8-rc1-4-gb54761f6e9773/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.8-rc1-4-gb54761f6e9773
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      b54761f6e9773350c0d1fb8e1e5aacaba7769d0f =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65b944ba4208d418ab00a03d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.8-rc1-4-gb5=
4761f6e9773/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.8-rc1-4-gb5=
4761f6e9773/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/65b944ba4208d4=
18ab00a03e
        failing since 469 days (last pass: v6.0-rc1, first fail: v6.1-rc1) =

 =20

