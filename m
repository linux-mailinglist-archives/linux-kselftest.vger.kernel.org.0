Return-Path: <linux-kselftest+bounces-14579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8422E9437BF
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 23:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F7C92839EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 21:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D698208D1;
	Wed, 31 Jul 2024 21:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="q9Q3/auq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1873C099
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722460983; cv=none; b=dnZzqx32iET7K6cPhk5mosS00Vb96yFKYlFlk8QvqibC1GHnu2498nAZ9sjoRFlHdloitnBI3cv6SZsI/oUgZ1L2t6IxknfM8ybbttNJg1+IHRupNWScnwoKTJcLkZQbJsPHO1JW0yYK1FoCODs/czk6Z+L4tadcWcB/bGa5Msk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722460983; c=relaxed/simple;
	bh=GfO55b+2JVxSvDqBxCzypiim8opRWyBpZbr5KXHzR/4=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=XFay6Eeux/BEKukv+8ggu4kWji1qT6xnOzRYirsNZ77o9627yZieCqflbc/qHQiPth7boDgEcOlXo2IcmM02R20PRr6Ts52F/TNPLnYBpujv43hnSyuxR7OLZ9kN9dyeO5w3nx7cAyqvnTvjJJxbR2H9bTbPKgLrgiUUav7ApGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=q9Q3/auq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc6a017abdso40836485ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 14:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1722460981; x=1723065781; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nK3gaH2rnWK7tnNJ+cHm6BKybIiZQMLLOHfx8Ur48uo=;
        b=q9Q3/auqaUaQA1qB+xn4KxSmc+/z/icKHOFeEmbhr92RMjJHgT4PG+P1lSgNkouW7A
         S7WAfJpQ5X5xMoMDPWQjGwoihlcwhRcSjjAUtZVTbmbfJKIaj6UDGtOL2LscMvLBaSgD
         vDTyi8EYE+sr69nsScpQhqkNBHb9+/Qh/SEPUwvu+r7GOKFW/nRBlr+YF+D1/W7i3W3m
         tSorfdWDQgQqCyUAnKatQzL62Mq5TF9q8w1btm6hmR+hdgnL17scYqFW2GF7v5ViEraI
         E4V7byjT7K0w/wgEy6HNwGPhUHdoVmV6KILh+TkWQlhEheT9/Vje0li8l++tIg6W5+ng
         d7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722460981; x=1723065781;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nK3gaH2rnWK7tnNJ+cHm6BKybIiZQMLLOHfx8Ur48uo=;
        b=kWgW7v/eyeLFhuVvrp8KLcXv8AMLeinZ+RE9QLnznzkvsiRX2yI3gvHEww2AehGZlp
         T/oIaUUDXx9Kada+lHLuWIj/dZaoY9122FqQcZsuwOUHB1EYt2fgKYjo3tm6pAIIf/iX
         s01EbScP+OcxSs5E/2ZKLIw7CGM4kzByAlWYXpVybVwMmmAjAxcyq2z6SfU1+inV3Q3/
         TNcgSxMutefXsNtB+eGDJKo2VLHqksL6ngINBxKADaL2K7y0KT2vQYZolWEQEpYqffF6
         Vl+GX5Zr2Xub/Ku1b/b3dtBvJDUSFM0saz2/4IdrEqzjvqVFu7EgRPjBQ+9rrzdhmg5S
         pgvA==
X-Forwarded-Encrypted: i=1; AJvYcCUY4K+Zd4LOZnOS4Sd9M5EXFEBV6/fzM3EnKZhIXkwfyquVY0c4cQ/0fqRtyV5tNtDuqblMGHMCMQYHLQGX4asQyZG8vcEtyhLeB6jBe7Df
X-Gm-Message-State: AOJu0Yz/gd+/yw9oVqTyQyjXgnSL7wKowI2qY7OsUFSZeHS8ePrF9gfT
	8474BkL/4aYIgo86I/If+5nswxlFSeSi6P9EzNRozTeiindscpbSn9yGVF5sYkY=
X-Google-Smtp-Source: AGHT+IH4jJBy1T5is5CptcEoN0grAiPp3GiQV62HKJuFSoHKyrZAuM857shOt0wJ9nPfcwacXNg29Q==
X-Received: by 2002:a17:903:234f:b0:1fb:72b4:8775 with SMTP id d9443c01a7336-1ff4d2135c7mr6436145ad.40.1722460981413;
        Wed, 31 Jul 2024 14:23:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ffb53csm124630585ad.304.2024.07.31.14.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 14:23:01 -0700 (PDT)
Message-ID: <66aaab35.170a0220.28631.0f23@mx.google.com>
Date: Wed, 31 Jul 2024 14:23:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.11-rc1-6-g38cde27f74d8
X-Kernelci-Report-Type: build
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 6 builds: 2 failed, 4 passed,
 1 warning (v6.11-rc1-6-g38cde27f74d8)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 6 builds: 2 failed, 4 passed, 1 warning (v6.11-rc1-6-=
g38cde27f74d8)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.11-rc1-6-g38cde27f74d8/

Tree: kselftest
Branch: next
Git Describe: v6.11-rc1-6-g38cde27f74d8
Git Commit: 38cde27f74d8bbe2f705fb1f80384acab9762e9e
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Build Failures Detected:

arm64:
    defconfig+kselftest+arm64-chromebook: (clang-16) FAIL
    defconfig+kselftest+arm64-chromebook: (gcc-12) FAIL

Warnings Detected:

arm64:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-16): 1 warning


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to=
 !ENDBR: .text+0x14ef94

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, clang-16) =E2=80=94 FAIL, 0 er=
rors, 0 warnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, gcc-12) =E2=80=94 FAIL, 0 erro=
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
BR: .text+0x14ef94

---
For more info write to <info@kernelci.org>

