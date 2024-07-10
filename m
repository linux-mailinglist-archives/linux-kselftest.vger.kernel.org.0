Return-Path: <linux-kselftest+bounces-13489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C16F692D752
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 19:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CA451F21DDA
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 17:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F56D194A7C;
	Wed, 10 Jul 2024 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="QAO1UYN8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979CD194128
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Jul 2024 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720631840; cv=none; b=Nx9cBfE9mRI4PbL3zCXQc9bvQkCh5+lmo0W9JmhDnAy3G7cqYkH+2JSz8lKLgiHHDuMvP5hILyh2PeZoieYB7qdFc/ckM90IKRv2CmQTX5esrekKthfWKi4iFrioQKzv7oE9Y9CkfHDGWOdfC1k4sUQHe7SXb8Rz13PjBuVe5wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720631840; c=relaxed/simple;
	bh=xDSkAKf0ke0MBhGMque2vJpaE0tJ5kza1+Cmcqzs8h0=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=cNKZ1Hld7NflbV8V9Y/TGWFlZdOamByv8JboWWjTFQY2Mjd5e3puGmvNvxuBTnuA1ddiX0xOwEaRploauk9NFULQ8FbmJzWN3ovs+FP09eRl448INZWUU3fDAifdVX/QZBW7aMXKUttKvQGSjXsfw6oIDM4RyYPz62PiTLcEi5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=QAO1UYN8; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-24c0dbd2866so29745fac.0
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Jul 2024 10:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1720631837; x=1721236637; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L/n1WNi1ZnmVyi1SARi9HsjxC7/soaknDFE8laGrTBQ=;
        b=QAO1UYN8vQ7UicY9j5G0P48ue8958JJ8l6PzKLM/1ucSukNhqNK55Gh+qnXBM+UEze
         Dt8O210Al5eYEMydhvQ/I2ryQM2liiq9iS63mGl9iZxCqcXywNM2nKqddiSQ/VLCdnKW
         AfTYwGyiC/sPiQSGsBYv5JqAZgpxFgfJ+BN2JhhkFvvnd0udTZabcqwKJ3dU1OOFo+u4
         hOqm19ZE0Ck+bG4zVp6VmF/g/k/+H1A3Qb9zdqupHe6uYWvPOpSO3Zy62uTdBS1kdCNV
         BDzdpu77SgTs3TwALkDUOzk5kz5f7/YjaLT9f2tl9gu0YSb5FtWjvTuvOYjsrfCz3YHt
         eYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720631837; x=1721236637;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L/n1WNi1ZnmVyi1SARi9HsjxC7/soaknDFE8laGrTBQ=;
        b=aDAr1jXz87Mav6GMgS/VPcPUp0l14+/Cb0GuaE+IH91cdPktyTw6EBletSulvT1gZF
         Ys/RD2rkv+fwQ4/DsFQ1f86jfYRrrw72mJ/SszgkKGjuPRBt2JWfAr5Gham5Yreuhtpc
         tfBHCQb0okMFqcPIRzEPylahCJt5zIWQtSlgpg4niMisTuEi9IEunHlklUgvMry+b8tN
         CY+03c51DhqlukU/b5+SJRNxdE7YDa6U6qbna3qU5yht+weV09CoHIIjCPyQ7U6eDiHh
         soUrrwO9aqDKdgnUAvQXw/3coV7Kvl1omcTwHFe5ndXHUlSqKUR14peoeiVgV1Cm/L02
         /PZw==
X-Forwarded-Encrypted: i=1; AJvYcCWFOsVl5MpEu7QZoWQON9AClEtPy/b/rxSuXwSD8e4iRwtYNDRvPgoMiSajnZRg35J+4c/S735OOpDdHtYxg0g4ZuI6uCRHqBkopSOhsGIL
X-Gm-Message-State: AOJu0YzSqU9TBruWbPa7hej5+S2b2CbnoCtGFTk4iOc46xof64mduozX
	wEMuzN25e1TDFwZTuVdGDv1sutT2P5OzxT8D4H8LBAuCK1y1l5nGf5GCqge+1aMwjryiGopKxF0
	3
X-Google-Smtp-Source: AGHT+IHbUYhdSmq2xvEUZFUYa9IjAssQSqqaNsge7PGgn+qU7MAPYzx8ErW8W5lA4hh8AU6IgLiVpg==
X-Received: by 2002:a05:6871:70c:b0:25e:fb:af8c with SMTP id 586e51a60fabf-25eae7f52e9mr4886747fac.18.1720631837490;
        Wed, 10 Jul 2024 10:17:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438c0a1csm4062075b3a.63.2024.07.10.10.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 10:17:17 -0700 (PDT)
Message-ID: <668ec21d.050a0220.83332.2a48@mx.google.com>
Date: Wed, 10 Jul 2024 10:17:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1-29-g2b2ea9f19da1
X-Kernelci-Report-Type: build
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 5 builds: 0 failed, 5 passed,
 1 warning (v6.10-rc1-29-g2b2ea9f19da1)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 5 builds: 0 failed, 5 passed, 1 warning (v6.10-rc1-29=
-g2b2ea9f19da1)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.10-rc1-29-g2b2ea9f19da1/

Tree: kselftest
Branch: next
Git Describe: v6.10-rc1-29-g2b2ea9f19da1
Git Commit: 2b2ea9f19da15dc96b7fbdf583de71f5f41331fc
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Warnings Detected:

arm64:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-16): 1 warning


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to=
 !ENDBR: .text+0x14cf94

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, gcc-12) =E2=80=94 PASS, 0 erro=
rs, 0 warnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig+kselftest (i386, gcc-12) =E2=80=94 PASS, 0 errors, 0 warning=
s, 0 section mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig+kselftest (arm, gcc-12) =E2=80=94 PASS, 0 errors, 0 warn=
ings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-12) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to !END=
BR: .text+0x14cf94

---
For more info write to <info@kernelci.org>

