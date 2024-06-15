Return-Path: <linux-kselftest+bounces-12001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0776990961D
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 07:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 087611C21452
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 05:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8009C10940;
	Sat, 15 Jun 2024 05:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="naJrcck8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D430BF9D6
	for <linux-kselftest@vger.kernel.org>; Sat, 15 Jun 2024 05:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718429030; cv=none; b=QC7BnM0Ixpu4T62Hm+8pOV/99iiVc64OPTFvxMyydh7JgVOzIur808VfgsjeI3/JhmMQT0mk7i9PypfRiMywLOiWP+LiBF4dmHuddC/CShb3Xorsq5WwYUmqSbCe2imDRgUQf8y+xcBC/YeH5TUZti7FS/xNxAUwk4MRdBBVSuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718429030; c=relaxed/simple;
	bh=+NpsIj5pcxq8ie4bKlFekVcRZYT+t5KIMqHODZak37c=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=E9lFLhA5WsTXU3VLr7EFvMowLiHSi3ypQ9pLGqes5BVU3KIHRXg89Wz0BdPY9ffQzFdV1utebXFw1cP9wnt44vaUIRCY6QMF7tSdeBp190/1gXn17VFvRetEf/Hd21TSemOIPSxIxeJejxW/EIUhelRwHQKI5RN6OWPdFfgtiRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=naJrcck8; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5bdbdf0d7b0so259135eaf.3
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jun 2024 22:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1718429027; x=1719033827; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8FbabIhp9UsFpEe3JJe8o84z/10usEAzSiwx3DVqSLo=;
        b=naJrcck8t+HOLPSA9Bo9P/uZeRjAJbI2e6X7g4RqVoP3jSYKhQhaKfQmd+uiLlyNSL
         tUIy/PO6iixavftjmhxHcfzC/CvH/Z1cW4DRMFuLrN5eEEXIJXPO9zm1Tt/giJWbX6UI
         eIPhmWxNBuZhs4vsbG06wsOzF4A5db4hk3CftzqTOV4l/6s8K3KpAwKcwICYcRH4zuQp
         kc4NFUv3RqPqM5FBJw7lj0pp6zYwyTul2QfNF2wAnPaeeWGH62ORnCOp0dK1eV/DinUs
         ooT3LokbimLTZf/+pE8HtN2QMgKW3t28zuMGGg6xXtZxyZ8VqEBkLN/nYSILdZT5vOvs
         KiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718429027; x=1719033827;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8FbabIhp9UsFpEe3JJe8o84z/10usEAzSiwx3DVqSLo=;
        b=Uv2mPbPINtlVcZgvafo24OlQ8uLwvqk06OQa6Lti1e5PmAwtw/ETcRCDxCSI4qOONr
         ZD9UnCTxky4VT81bZdmPPXaZgrCc3ZLrPmPSEgXn3xmSEfDIHXbruvu7Hccqbn0gP9gx
         1LTO4V5dkPWYYRRG2DuOqm7+C6I5bdpuIgSJw71D5lqQVPSg/fCYwBmdLuyDPC1i7YKC
         jt/KrzJa5PG108xXpHda5KF5sH+Nxvuuslc39uhIMktg5Hm+MjlCbZQRfOuT32xebV/b
         xbZVTjDvg4i7QEfjH2JPtbwFZf4OYaj79K3NdwVcoJLPk5sPsah9LxiElRhhd9fo1p9D
         EeGw==
X-Forwarded-Encrypted: i=1; AJvYcCWIb4X0WifiPb5Gq77A4KvRf/aWqsLy2WyL76RhAwda+AZabh3r2h6Whvnr1hOoPVVlHscqFAZoOk+kywe+7kwILSzNeXMrEZpKkysd+V70
X-Gm-Message-State: AOJu0YypImEkQZrmQKgtBnmqPQe5YmT04cJ/fEgVVfVELGKWrM+BvFXw
	nlZA7s3W2FRm5aV/YX5utXxruWx7H/gmGZZbcugFlzMn+kffiDJMCbmbDocMNMM=
X-Google-Smtp-Source: AGHT+IFXq55CvE0aU224u1NS21f4SLKxGt7UQuaikGDp7Qor/6PilE8KHig2JuQ//+22OUJEDSZGjg==
X-Received: by 2002:a05:6358:54a2:b0:19f:436b:f6b6 with SMTP id e5c5f4694b2df-19fb516a936mr519343455d.28.1718429026710;
        Fri, 14 Jun 2024 22:23:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fedcf36a95sm3524998a12.7.2024.06.14.22.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 22:23:45 -0700 (PDT)
Message-ID: <666d2561.630a0220.22159.b26b@mx.google.com>
Date: Fri, 14 Jun 2024 22:23:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1-2-g64f5bc57b24e
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-cpufreq: 5 runs,
 2 regressions (v6.10-rc1-2-g64f5bc57b24e)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-cpufreq: 5 runs, 2 regressions (v6.10-rc1-2-g64f5b=
c57b24e)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =

mt8192-asurada-spherion-r0   | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
0-rc1-2-g64f5bc57b24e/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.10-rc1-2-g64f5bc57b24e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      64f5bc57b24e8c7935d51732571d405acfcf4b99 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/666d18fc704802e8047e708a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.10-rc1-2-g64=
f5bc57b24e/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-cpufreq=
-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.10-rc1-2-g64=
f5bc57b24e/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-cpufreq=
-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/666d18fc7048=
02e8047e708b
        new failure (last pass: v6.10-rc1-1-ga567885b1ecc9) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8192-asurada-spherion-r0   | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/66690987f94e1c493c7e707e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.10-rc1-2-g64=
f5bc57b24e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8192-asurada-spherion-r0.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.10-rc1-2-g64=
f5bc57b24e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8192-asurada-spherion-r0.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/66690987f94e=
1c493c7e707f
        failing since 14 days (last pass: v6.9-8287-g31a59b76b978, first fa=
il: v6.10-rc1) =

 =20

