Return-Path: <linux-kselftest+bounces-7231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F22A9899199
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 00:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F04A1C21957
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 22:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F3C6FE1A;
	Thu,  4 Apr 2024 22:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="j0IVmt6O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66C86F510
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Apr 2024 22:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712271156; cv=none; b=TpQUlAIQG+M1yJh6nsSKqNlBZUjRKiuaVsbysFYHpHFJp4whbV1IN05i5LAHvNe13rG4dKQZFeDknjGK8Deut1z2zW+lnTDGKuFsfEV1Uuuot65oTjMmn93zK16O7eB9sBroReHvkKIY2+hPFV9V6lLTbPwQZK6PIK3woLKcVOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712271156; c=relaxed/simple;
	bh=dTlwvKpReqBfv6hShxbtbOtbnhUQVAgU9snsexzimyM=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=BsurZlE1hx0IlyK9iMEIMXbEW8XHLE7m/r5wvAy/pCVYSgWcvkok904noh/ri1g6C5HR3Mcr0oP6g4tbyKuZgd89R1udx6lAqoGYjef9zUCP2dlw42bchI2wmOWRaTzTk7K+NwnTbEeDfi280jE3vzUAgHfMTQbufj2J8WBpI5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=j0IVmt6O; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ece8991654so1223932b3a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Apr 2024 15:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1712271154; x=1712875954; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dTlwvKpReqBfv6hShxbtbOtbnhUQVAgU9snsexzimyM=;
        b=j0IVmt6O81LsWYw7R5HgDLtW1LgdY0Qvje/7VSbFgpH0jmDLV614dR+Gx5HWkegGsJ
         2Ry3LFryTV3c3bjKcAiiFur/pODoaszTVlQEmomjzfo9h6lSfHsGBNfQa0Zc0J6h1jvl
         t8Hgh/rb0xO/WYOzWq7poRI/OkufSsVsKOwbn5rsdNcBdixUvCmNkkMZgvz7JACD1het
         EVSb7468POdPGj8SooWCs7yLN9rPMweGrfecFsHc2f98SAvk+5f2K+AbTRLPMj3osiQn
         GqwcgefHS5QnyE0vCSMu4W8VVXrP6KTSQ0MwWKCkj9elsZhr6l1lahVYrhlDG358IRzI
         FpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712271154; x=1712875954;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dTlwvKpReqBfv6hShxbtbOtbnhUQVAgU9snsexzimyM=;
        b=E5TnQvHG6C68IdAVuCnASd8x7/UnIo5NQI2DECZjeK4ehah0NeFpZCi7sqxS8+yTEk
         Vb5yf6M0yIjZi5utzDZmmWlv2/0v9VA0JgVSeWAxKcZzRSlpj2fxsSxIXAxVuwEr7MQ6
         qfn4B8aKuBzTzClOA0f6O6fN8a3VsPOHCPUPz2yKsXMjFv3ggmGl9qC4RCWIbx5TnOVE
         +6sGx3vaLWDbvy7WC5XULekPWFggeaUrYq/qDFNA8nilrpfw/QNGzMkl+NngvLAaBY6b
         qXFaENjaB4mX8XVx3HTcNDgdHysPtg4FLnUj4EvWMWSsTldFCsld8C0qXV/jnuhl4eBj
         XbsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/NQhch4NtL/N/+KBCYotSnWZ57jfNDAJK0UzQwQEfJj6beLsHMxOS04yqnKay/3HfI1wxp0D0G+6q1yRrx9sXKRH4u0Mt9QqKvmYWsLhW
X-Gm-Message-State: AOJu0Yyv+vhwnjDoqwNmIblp8HWRrhimVkOhS0VbTJaWJrZu9p/e5p/w
	NfYDZSSfQslg2WlP/SgxaJqup+qU9tL9M4bBAMCwM0Y1ELUdU5VYskpSa4qVBuk=
X-Google-Smtp-Source: AGHT+IGJerHh5Jn2LP+40NsKCR8c3B9ADlA4W6N2TuBCP+L5bmj6CeNwXc70DStTJK1nZgkHgVGK2Q==
X-Received: by 2002:a05:6a00:93a3:b0:6ea:f351:1df9 with SMTP id ka35-20020a056a0093a300b006eaf3511df9mr1113081pfb.23.1712271154129;
        Thu, 04 Apr 2024 15:52:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p23-20020aa78617000000b006eab7ca005esm187284pfn.18.2024.04.04.15.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 15:52:33 -0700 (PDT)
Message-ID: <660f2f31.a70a0220.f680e.100c@mx.google.com>
Date: Thu, 04 Apr 2024 15:52:33 -0700 (PDT)
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
X-Kernelci-Kernel: linux_kselftest-fixes-6.9-rc2-2-g72d7cb5c190b
X-Kernelci-Report-Type: build
Subject: kselftest/fixes build: 2 builds: 0 failed,
 2 passed (linux_kselftest-fixes-6.9-rc2-2-g72d7cb5c190b)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes build: 2 builds: 0 failed, 2 passed (linux_kselftest-fixes-=
6.9-rc2-2-g72d7cb5c190b)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/linux_kselftest-fixes-6.9-rc2-2-g72d7cb5c190b/

Tree: kselftest
Branch: fixes
Git Describe: linux_kselftest-fixes-6.9-rc2-2-g72d7cb5c190b
Git Commit: 72d7cb5c190befbb095bae7737e71560ec0fcaa6
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 2 unique architectures

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

---
For more info write to <info@kernelci.org>

