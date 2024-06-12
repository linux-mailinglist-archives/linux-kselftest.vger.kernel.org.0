Return-Path: <linux-kselftest+bounces-11726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CED19048C1
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 04:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B01A1F23768
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 02:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993304696;
	Wed, 12 Jun 2024 02:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="wBW4yYtP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A195664
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 02:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718158298; cv=none; b=g2nsCC0hnOvR2fLeQIz+l5Tx975zVDrdhvSmGj4bKrH37xue1LHYZ7vh0ZKSGbiKpTeWhjGM71eWggPUyA+5xYOIelkYcLR1fsYymgSeTBdZ3a/ixMgzxBwnImduwHm/46c0WilKXQ5pgPBxlnO5iYwLA/4z2QxoGiqY5KxxrEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718158298; c=relaxed/simple;
	bh=4Eiz0wP4UnE1R7S3ag+tCN//C4vGsaCH1uGfc2rZXaY=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=WD+eJwJ+R24bZm/soZ9zboUTe8m7cZugHCcjgF3eVJVb9/ww/Wu3qWUtAUKMcIjq2Tt1ncu+7MKg3TH4aQTIFWUPjSdSdmp68Zv6idU1hvZphbR/30msGjBCsYuuzeV4CDIw527yAL5N5SvDoTwSIZulj80e1cQBQ/RsMX+wscc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=wBW4yYtP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f7274a453bso17038645ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 19:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1718158296; x=1718763096; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Uz2MkN53avJ8QPGmdHu+I2yHEKPqF9KR06SF6VOOLEM=;
        b=wBW4yYtPBkuQakxOLbLHTSzbxTGmpXDeYrlREIm6hQcD/Pnby4RhoVFqh6vfivWVmx
         jUPUobdV+SdOhXVgXSq47fzd0hKzoA+JnMFjGqkIx+f+W6QZ5jUdbkyvQQ+Xxk7KuU0g
         R99eXSUa7f38DBfsPLfe7szf6Dr/C5eVSX/9MA0Xvry8rQRuCdoLdvTDtln6gs+ucJyq
         5EieF039bb4aWJlZh5PSBSrI8OV/4lDazY02PF45uYJhG3jcmYUoNJPwdd0BkGCNnq2H
         Wetmq1mooNje9wtnmjP7fwrCU5O1KPQmJiItxb4tdiwCwujxWwXv+WxYKuimieNWwq9x
         4IXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718158296; x=1718763096;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uz2MkN53avJ8QPGmdHu+I2yHEKPqF9KR06SF6VOOLEM=;
        b=jKw0LPTrKUCbVX7YFJnS+P9T0ZFP6OUJrLcS9AxmQX7lK4HJ39kL3HoQXiO8It9iJf
         t3tAYUnoAD6G9XIj4xv4hbFsQQ9AeU6esR3vTjU+lQM4q+ecUOvsO1PlI9TEh8U6YRM4
         Ontc7B8smdC5Ge+kU5NQ5iyzMuWKHQ/y4HfCLEOLgszgnwCpco7sLQcODyCM0XMHm5Hg
         +EDxh2Gnap9gbEr9ICHC2X7URW0cOYBPXZpp0kH3CLv3SQxk2RI+oj04vH6QHSvcDqq2
         RjTtFm4evrPrU9HlDXfOoi6C9coGhKbt8s6aNHc27f2k7HA18Lyt2W/rKuoRHAoNP6tG
         uRLw==
X-Forwarded-Encrypted: i=1; AJvYcCU9L4xf3m35OiBEgYg+L2btJl3sAHZdaDSEdHx3QEJ9ZG+84VyUUc9kkFNyVc+TkJTYXVY/+jcZZctJc1hv8ehMGzIqt02JCJAkPfBJwJAQ
X-Gm-Message-State: AOJu0Yxi8Cy6l5ACzfE1sJHfFLyNJu9+oFz4gE8NGLzFgeDLY5asUQ3K
	YKT7U8ZUvxsg09fLnsiwC+9kX3JuC3Ubt0RovdZtaXv+uMsQds1SD50Ibcn2qsQ=
X-Google-Smtp-Source: AGHT+IFpOD6y8amq2sXsuPDDgCTEZEo55Bp1BSowcH/O5aVp7WEQwmpk0XALVlb8hjfKrdawnB6eqQ==
X-Received: by 2002:a17:902:e80c:b0:1f7:c33:aa7b with SMTP id d9443c01a7336-1f83b51bf76mr6727785ad.12.1718158295587;
        Tue, 11 Jun 2024 19:11:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd80de1esm108454595ad.294.2024.06.11.19.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 19:11:35 -0700 (PDT)
Message-ID: <666903d7.170a0220.1160b2.fb21@mx.google.com>
Date: Tue, 11 Jun 2024 19:11:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1-2-g64f5bc57b24e
X-Kernelci-Report-Type: build
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 5 builds: 0 failed, 5 passed,
 1 warning (v6.10-rc1-2-g64f5bc57b24e)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 5 builds: 0 failed, 5 passed, 1 warning (v6.10-rc1-2-=
g64f5bc57b24e)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.10-rc1-2-g64f5bc57b24e/

Tree: kselftest
Branch: next
Git Describe: v6.10-rc1-2-g64f5bc57b24e
Git Commit: 64f5bc57b24e8c7935d51732571d405acfcf4b99
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
defconfig+kselftest+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 erro=
rs, 0 warnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig+kselftest (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warning=
s, 0 section mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig+kselftest (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warn=
ings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
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

