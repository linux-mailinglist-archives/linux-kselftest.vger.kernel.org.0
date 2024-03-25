Return-Path: <linux-kselftest+bounces-6593-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0370B88B1B4
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 21:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D711FA14CA
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 20:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4666150246;
	Mon, 25 Mar 2024 20:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="U9fCcmGE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865C75339E
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Mar 2024 20:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399126; cv=none; b=RpJZ5vgJAodbf2sF1haQEjqdVC2L7aXnG96l2vyM2zkHLSQpqiZR7l0D50m2mrkUHamZqIzdhUjYtAmFKuLB+uue4uau3tQ1JgKG6U3lucXgTNW4Fqu77EXN8oNtVz7gA9Ln+fCFCPvVdbYav7MEjVCgVA0AbjQGEZHOlTOpst8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399126; c=relaxed/simple;
	bh=vuXcdJaKNDQOAfPpA5Q3xnW4b6U/WAKsl6SjC3PVFjk=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=cGsVM7Wi45lngbzJV36j/J2Gz2B9VHWsAjHFgzh1QO4M717rflHQwcNn7bgh6y8YoFZ+f2PiD+qLFSp/9xYBSnfpJ5G7KvGEaZEbydWXnBx5XRwm2h3vHuZze35cIbyyUWfwJ7VuLFl0z8TWNfDzNUQWHtBHtuk+8n0widiaAgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=U9fCcmGE; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e782e955adso4109653b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Mar 2024 13:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1711399124; x=1712003924; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4zeVuE2E93azj7M1TG0J2TafJUlcj/QdINhMAfkT66k=;
        b=U9fCcmGEEuEGULHLMnuEAVGdfnoQ1l32prmhSi1dFe/ffn84QcFb6p9K7Wlh71mOKz
         /WcOIcOUOQEbKGUmvPhpq1GZERrnQMFCTl35uWP/D9xhUPoZO0f5LaczhnOm4X4RMl4K
         /uwe3xSxjkKX1W1odzF8RLfr5p4IkgB2FZCS4+0tQs1E1ow86rfhXuHkWmWYPU1VrOUR
         aSBYZfUgsj7xHIpy2MsnAYxHbZBkZWigPLkc3cQmn7keFs9OfZf5UzWsxx3lB80si1Kf
         dsjzOICev8E1j9pcsTNQu3mD/VJ2Wk8YEH6YAZDG4AJAHwvQWJ9sEBVxIEFOw0S2WcNh
         TtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711399124; x=1712003924;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4zeVuE2E93azj7M1TG0J2TafJUlcj/QdINhMAfkT66k=;
        b=txEFbD2XMr8qvZuzZLbR8/PKM1Huk5HnpVEV2GEGvIW2ZMcj9R64QdFPPtW35eD6p/
         OPVLAx5eqHxOXQoBaXCU0somP0n8qDVHULgk00+50AKdvLdbjFfXWtQpHSIcS7TeoTGL
         FRW4YTe9YEEgOM77rJO3BSJvw82gnEbpWA14mawwuQX+0ieW5tIXdisEr6ZOWIGS0Ppa
         QxRG6KmnhG8LjtDPa0oXRB637X0HtrGyz2D72TXcpZHpWymn0UjY7A4gJeMBXLDtm1xz
         ejbV8AMruuQR0MayXuKo4H76lKpCZo1M9taFssQ8FlK7Er/pcvIJ6m6ktsBJemrYLs3o
         MI9g==
X-Forwarded-Encrypted: i=1; AJvYcCWb6xbXAN9S3dbyAe+ajS7ps/PxoI8l0CbdlpJWUCFv31M46zEnicWLXJ3hz1LC9Zt20WeXKcO6HOLqPEu9HdJFh+guG3sWkdv6pTVXATTz
X-Gm-Message-State: AOJu0YyOm6DxGQtwwBstGQMqNzX2sBpy/3FAfVYV8EqhGbdtnGrp8DM+
	1YxrlpI2CF9I8tQBWZ+ONZ9ZdkuhQVJH/YZlY03NzQQkNMYuNjVgNLmJZAkC9ZM=
X-Google-Smtp-Source: AGHT+IFFx895q1/SBeEGNgmvVadHo1b5vIO13zF8sWLaNFzBjYkx+m/lstrPisxKZIzYhLk4mkphTA==
X-Received: by 2002:a05:6a00:986:b0:6ea:9117:bc65 with SMTP id u6-20020a056a00098600b006ea9117bc65mr12453407pfg.6.1711399123353;
        Mon, 25 Mar 2024 13:38:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 26-20020a630a1a000000b005c6e8fa9f24sm6245137pgk.49.2024.03.25.13.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 13:38:42 -0700 (PDT)
Message-ID: <6601e0d2.630a0220.24c2a.1597@mx.google.com>
Date: Mon, 25 Mar 2024 13:38:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.9-rc1
X-Kernelci-Report-Type: build
Subject: kselftest/fixes build: 2 builds: 0 failed, 2 passed,
 1 warning (v6.9-rc1)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes build: 2 builds: 0 failed, 2 passed, 1 warning (v6.9-rc1)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/v6.9-rc1/

Tree: kselftest
Branch: fixes
Git Describe: v6.9-rc1
Git Commit: 4cece764965020c22cff7665b18a012006359095
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 2 unique architectures

Warnings Detected:

arm:

x86_64:
    x86_64_defconfig+kselftest (clang-16): 1 warning


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to=
 !ENDBR: .text+0x149bf9

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
multi_v7_defconfig+kselftest (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warn=
ings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !END=
BR: .text+0x149bf9

---
For more info write to <info@kernelci.org>

