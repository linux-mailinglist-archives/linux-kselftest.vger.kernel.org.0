Return-Path: <linux-kselftest+bounces-9439-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63D88BB7B9
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 00:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC0A1C2140B
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 22:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A466B5BAD7;
	Fri,  3 May 2024 22:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="FAOj2HEi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8F22C684
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 22:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714776472; cv=none; b=ARwSpxPoI/UUcdkUSA/J6rF/XBQu/LnBRZjH7dWLgHqvtGzh9mPpN9TQUjT8bg5xkqNrdBCWuHlLPEmN/VuNZeoRLhxE6RKu8QK3D3Uk5/9xDrA0e6AUeHMyTzu4H9c+GnN4i5Hy+Hj8NigJXVO/z7qtiPuuJ4j8JH00mu+Ks9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714776472; c=relaxed/simple;
	bh=LMXGwLmSyprUhqKTQEzJ1BN7b8M1HQiCia9JwbumDwg=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=gbhweelHyke4KZs0+L9+K2iHuqtEiVH/4vKvomT1AY2aeomupPcGQfAtwXNJtUGgMrX7wbVgThmF2/wzlKiqxzUAMud+ZtBSBBKmD+I3FRZsRaTqgeb43yUI7S9CxcNgFCD0MHTc6xafrNuuc5NcJomEtCJorUO1E+XmisMIw7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=FAOj2HEi; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6edb76d83d0so210366b3a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 03 May 2024 15:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1714776470; x=1715381270; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1KGz9r0Pj9cPD1l28LqKD15jIbxjZn6EQdjzBEbRPf8=;
        b=FAOj2HEiYVzZxndeckiPiJmArzpOsAopFDMYiadU0+zJNFz/QuSrZ3tKhCikaW9QIq
         cs2T8JvhM0J3ae+wfUXJzmmzWPDF43dyVZTEZfjSWJe922Wp12AYFt23HJiL9Tk9Z1fU
         EtZ8YUIhNrpjCHm9OSPK1Q909wrH2NFEqc+h8F7phZczip6li/2rrV8HSek/RfYiCXV6
         ITvtGbGaNqZa47kv/6fzgNnu302CR13yMti+yCaoPfXtVoZK02le/1ghNPiJg0rSrchO
         ZYoETtFNErFDMzP9OXzEvIhqAh2sxcTvO0tWp46kpfjxUb5doe4hj7AuswYMDg7ggTMV
         ZmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714776470; x=1715381270;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1KGz9r0Pj9cPD1l28LqKD15jIbxjZn6EQdjzBEbRPf8=;
        b=NDUb0Utl8wEA54nLKMteB+L5gyOyOK4R9Nl3hVqNSkh2D5Yx67geJ0GfvJmPofGX6Z
         W9FgLKbn1I2qvluF4FQ6VuSir/HvKytqUeTNdNPsSIij+nGHVRPh2lGDB4OrSlrYhQ+f
         E5qwBZexhPDgE3KWDg7VHhS7gCm7xtBp1hXL3PpIJGFLOrrK7dBijBTmZWJEClCSaoiB
         ucxAks0MZX1LGT4XbkKBqAxkNqFZoTwIoA+QHqiTtMOxnXZaVXF+ZPQJq1VYmFl2FUPq
         zGBTnygOIdA0mfDQcB0pvqhmMj+o5HofFk6FV5rWp05KiosvWhb1djvp6uMuJ4gWBsQ/
         Zddw==
X-Forwarded-Encrypted: i=1; AJvYcCUwiK8Q8uahsy5BE5Tjk4lO7avAkamoB8rs7AprazSQnA+gl+MFFRbqAc4B/E/GY0SJeXwxqFQFdmHqCWIv4YAG1QKmpbmpDjkTO3SKm/V7
X-Gm-Message-State: AOJu0YzK1bf91DbpHajDhgyqPd4BJy/yMLf9DwmMIPOqqtK8JIUpA2Hz
	9gzI3iBo4XZnIwd3+yXcTH7zhUg1OD7OZK6cGi/QhhvSc5FVFNU/1GvmBbVuPaInBii0M9cktbH
	hlbw=
X-Google-Smtp-Source: AGHT+IGUwpwrh7bYHnb3jVPl/rmq+Xh+uk/sTQEwLlofzZCynR3RAN01imbEFb9Ini8gH64EHJarcg==
X-Received: by 2002:a05:6a20:5530:b0:1ad:8606:6484 with SMTP id ko48-20020a056a20553000b001ad86066484mr4010759pzb.8.1714776470449;
        Fri, 03 May 2024 15:47:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y21-20020a056a00191500b006ecf56cb55fsm3681889pfi.96.2024.05.03.15.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 15:47:49 -0700 (PDT)
Message-ID: <66356995.050a0220.a21f5.f6ba@mx.google.com>
Date: Fri, 03 May 2024 15:47:49 -0700 (PDT)
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
X-Kernelci-Kernel: v6.9-rc4-36-g70bfefe4252d7
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 4 builds: 0 failed, 4 passed,
 1 warning (v6.9-rc4-36-g70bfefe4252d7)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 4 builds: 0 failed, 4 passed, 1 warning (v6.9-rc4-36-=
g70bfefe4252d7)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.9-rc4-36-g70bfefe4252d7/

Tree: kselftest
Branch: next
Git Describe: v6.9-rc4-36-g70bfefe4252d7
Git Commit: 70bfefe4252d7ab57fb49348ca5b66ad9298e46e
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 3 unique architectures

Warnings Detected:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-16): 1 warning


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to=
 !ENDBR: .text+0x14ea89

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

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
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !END=
BR: .text+0x14ea89

---
For more info write to <info@kernelci.org>

