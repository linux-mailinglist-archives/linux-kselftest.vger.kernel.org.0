Return-Path: <linux-kselftest+bounces-6594-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F2288B254
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 22:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0345B1F3C2C1
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 21:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C56060267;
	Mon, 25 Mar 2024 21:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="yrXO9t84"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E27333995
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Mar 2024 21:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400950; cv=none; b=euSy313PEekO75yA6qynXYNy66Gcm1C9lqDRmvOrD7SrFZl5tcjrkvsSvLi6yzmdZ2oTKYIn+KmehDanw0kdCO50n5GYmt06i9JzhOCvhR3koZBX36BQFzRN9s37phZjiHRnFEE+ZbbOBky1tmxZvyfWCxiSXXvns+Lhdvpnadk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400950; c=relaxed/simple;
	bh=5na+tVNpv4WZwpTmleKqPgST/KJ4jEf94JrxvU7tDvw=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=Gjgflw2Zxz9ckLcfzFPdsrKaqeGl2iO0lMgJ233IBMM85sytRBp5K/QaLq68BZ/e0QPfKfI06T5QGiKxdJR6uxG+ikUYoaaYdRO2P/W+/M2cI0/n4BFu64rbKm+xAzSY8iXC3tpWICdV+daAEJyvuUU0792LbvX0aGgceBiel2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=yrXO9t84; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ea8a0d1a05so1842565b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Mar 2024 14:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1711400948; x=1712005748; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5na+tVNpv4WZwpTmleKqPgST/KJ4jEf94JrxvU7tDvw=;
        b=yrXO9t84auGEUCXO7xJB6l2Xg5W1832i26MtfyL6uf4Vl1DDNSyl9W2gRD5hWZT3/g
         rRTDqzKvZweTZGOnpIRg79uHPCLpMlGj7ycmjxVOU5+bjlxxkpQJ7E8irJpAPZhg0F8z
         5hB90i7AqwYbYCpjazOROht1fYuYR7jH6h+lH27sH8Dh9e9nAnsjdjd38rE7JanE6FyZ
         ByFD8fgiS77iLrrAW1g3I65+U2NptHXtrBSlY8FBHlp0To37lvJrbjTRzs66YjzJB0yl
         LKy/gdLYzcs0EpPHOlMHt3EcXsgBdShe7G+VBzEXdcA433h0mIo7BxU0LV27Cwf4G32n
         Jd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711400948; x=1712005748;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5na+tVNpv4WZwpTmleKqPgST/KJ4jEf94JrxvU7tDvw=;
        b=ONiBIE4TI5C97zo6lltuI9lM/O5QIAsK7C+VH6/86vDWbdhjjdEgnKC68OrEeiI2m1
         v9FyGpfxX7Gxy/ybrGh8vAqZAszGdXB1ijnLywIhr2X9Com5sjTotaU7iTL80Fl0Msr5
         BEJVq7BtrZZAZhqc8iPubrY6h83djj3PU/bd1jwILrpPDsMaZVodlOokss/EN6+F9r5G
         vw6K+2VmAyyEgHYuPGl1/tFYc7xi15sF1CBA0KE83PxPLXWi9XhAuQNvaG4OXzz3Iv3n
         jSm4y3UaE4849hdgeb/1NpUFvrxdMy0wintW0DsuqS7LovlANYOva6EEmEPfd92xdncW
         9hEg==
X-Forwarded-Encrypted: i=1; AJvYcCXUg3uYxRE7ozG3mcKhYLSzVOq4R9JUkryv/sBNFJPiM0bSEX/vFKlpbtWKrTbShtOtyhnXe0YoBAw5jNg8qi09ujJkywOC8rkC70Cv6U1h
X-Gm-Message-State: AOJu0YzqK7Rwfj+uWjs2zKrNvuiSFUHaZOMrK8l8KyKEBju2Hy2TJITv
	IIodU0kYRtIlxRdkgQlBJFl4i55nLG7y6UfThaoXErbO/pHqIuxh6j4lMTgTA3s5vGEGxrLQIZR
	aWOY=
X-Google-Smtp-Source: AGHT+IHBACASm7KhyeGnPFc6OEVs012EKUhlvY39Oy0/AWLvOUZ0AYicEJPMWai12RNtyV1xDpIUJg==
X-Received: by 2002:a17:902:ea0e:b0:1e0:b60f:5de3 with SMTP id s14-20020a170902ea0e00b001e0b60f5de3mr6898981plg.7.1711400947513;
        Mon, 25 Mar 2024 14:09:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902a38b00b001dc05535632sm5302205pla.170.2024.03.25.14.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 14:09:07 -0700 (PDT)
Message-ID: <6601e7f3.170a0220.75819.e0c0@mx.google.com>
Date: Mon, 25 Mar 2024 14:09:07 -0700 (PDT)
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
X-Kernelci-Kernel: v6.9-rc1
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 2 builds: 0 failed, 2 passed (v6.9-rc1)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 2 builds: 0 failed, 2 passed (v6.9-rc1)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.9-rc1/

Tree: kselftest
Branch: next
Git Describe: v6.9-rc1
Git Commit: 4cece764965020c22cff7665b18a012006359095
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
defconfig+kselftest (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig+kselftest (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warn=
ings, 0 section mismatches

---
For more info write to <info@kernelci.org>

