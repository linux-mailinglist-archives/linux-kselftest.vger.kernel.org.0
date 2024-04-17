Return-Path: <linux-kselftest+bounces-8245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE2A8A7CCD
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 09:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 197FA281AED
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 07:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07A56A323;
	Wed, 17 Apr 2024 07:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="0po4qvAt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5985A69E07
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Apr 2024 07:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713337625; cv=none; b=jJX0U8PV65sioxLRaGO5kf+v5aOX8tbdJo0nWcbXgHI0tldBVGb4dPNRZZOwpKjDT7X0SI30VW8VgjuJ43ZNx3xPDYK58x6Hd6urzI1GMULetN9/BjBZw8TE6YFO4Pa7ls7Q3tgvDPr4vqABLQSeWGRijxoi5rMfJgB/7VRPN5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713337625; c=relaxed/simple;
	bh=cJWKIE2simLkVegK6HdKQbPZlDTWgJ+Xfb5dfqoXg9I=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=uoCEaUmvNRdB5JlTj/BedXo1qnPWWqdzyTXNkI7/cCvX3OtXBNJyIadddi6ERsL0BGDspZg6WYhwjDXMxDOVL9OVOpXOWFTwA6MfCO1Nf/ZpZfYI2QZyRbxa3piHGysWV6NmxoL+kp/FlwiEwwaZLOLTb1OQ6jSOpE92CY8YKxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=0po4qvAt; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e3ca546d40so38757495ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Apr 2024 00:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1713337624; x=1713942424; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CUrt1v+6y2mxE5rtxrPZSOd7ohFhgt06IQb8V3MnNuY=;
        b=0po4qvAtWfH+NLJsPP3TFOnFZUyJj0yGIr2yPDCmrd8vD56Nm1pQFtSx+ez2ZZj6/9
         4PUmK8DhLGsjD+bhyPUHuztsR3roedXdnjXdkN1gQY3MpeOqNKdfcqvXI+u589y4R5Fo
         Sd1hppsz7GLWsMuGoOOwbvaNPSEH20wESQh21q2uv6AypAJ1Tff7wbiJ2QKzd94dfEVH
         LlTxfK/3VJV5F6eSCvMpwEgi7rD+W60tBAxCbbPn4YP+jZAWgyK3t8QUgU0aVxfJ2D9u
         Kr0cZs+XmlYoBTTIDBrKW5hVtLXOJdJ0U8LKzpzz+6ezEbew/a6zSpLxdm1zI57EYJ9z
         F5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713337624; x=1713942424;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CUrt1v+6y2mxE5rtxrPZSOd7ohFhgt06IQb8V3MnNuY=;
        b=KsMGqNX2JQnk9oC8XLo4LQ+BoX2Ikbux1KMXxrpvaXIizRDSp01LOfMw1+xFSwK+Dr
         WX0nB0gDvh/o2di99LU091tksQdomyxoAbhGAiF0RZ77/vzY36f0KXnFBYreSKSixCMb
         nOncejce7Sy21OoGsHZ/8jT+T6cjklOw24EFN6Qd7EM3Ul/oYKbdTWS1cTUasLCgBFSt
         rZRcufMLa8PK2M7pVkaK6NBS1Ysr59LXZlUpxUHBvu70JkSgU57UNQzWIGNwtBX8Uc2w
         qFv9e6AmSrvyjYR3sRgO6ht8caftmZkztKXTduk42Oug6m+i3jBaCExflZnhrDNyRzfs
         fIVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR2trYbCM5rzWWzqnBs6nyK/7Zz006wKYQuACR+ot8/ZESPQIDCBUPIRYi4PlsWddeaaUeE9JwWAgpWjf88T2CFZSQ4eLiJOT7yAbOl7k5
X-Gm-Message-State: AOJu0YwTvy7caTtEPlUIFpeIXstNmigoQPF/NkXq8kg8RhxaexQDzPxs
	iD968eLmbO4eQcqeJY668IIqVrYoCQhYqYKOar20IL2LAV+svzhWO7jNZNygAF4=
X-Google-Smtp-Source: AGHT+IG6RUOfxJBmmct9kDznDCkGwFUQssi6Mb3xMjyis3g6Y0Vgnoxzwpag2Vru3EjMiZLy7vNpdQ==
X-Received: by 2002:a17:90b:1e46:b0:2a6:1625:368c with SMTP id pi6-20020a17090b1e4600b002a61625368cmr13011591pjb.6.1713337623613;
        Wed, 17 Apr 2024 00:07:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bg22-20020a17090b0d9600b002a2f3cfc92asm693078pjb.16.2024.04.17.00.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 00:07:03 -0700 (PDT)
Message-ID: <661f7517.170a0220.f60f1.2273@mx.google.com>
Date: Wed, 17 Apr 2024 00:07:03 -0700 (PDT)
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
X-Kernelci-Kernel: v6.9-rc4-19-g00ab560eb0e3
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-livepatch: 1 runs,
 1 regressions (v6.9-rc4-19-g00ab560eb0e3)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-livepatch: 1 runs, 1 regressions (v6.9-rc4-19-g00a=
b560eb0e3)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.9=
-rc4-19-g00ab560eb0e3/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.9-rc4-19-g00ab560eb0e3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      00ab560eb0e3f9725521c9fec2e8992e9e7e6c29 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/661f669f409ca066214c42dd

  Results:     1 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.9-rc4-19-g00=
ab560eb0e3/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.9-rc4-19-g00=
ab560eb0e3/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.shardfile-livepatch: https://kernelci.org/test/case=
/id/661f669f409ca066214c42df
        failing since 62 days (last pass: v6.8-rc1, first fail: v6.8-rc1-32=
-g345e8abe4c355)

    2024-04-17T06:05:02.322922  / # =


    2024-04-17T06:05:02.332553  =


    2024-04-17T06:05:07.476034  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/13400391/extract-nfsrootfs-aa8qs62p'

    2024-04-17T06:05:07.489336  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/13400391/extract-nfsrootfs-aa8qs62p'

    2024-04-17T06:05:09.716032  / # export NFS_SERVER_IP=3D'192.168.201.1'

    2024-04-17T06:05:09.726942  export NFS_SERVER_IP=3D'192.168.201.1'

    2024-04-17T06:05:09.843762  / # #

    2024-04-17T06:05:09.851964  #

    2024-04-17T06:05:09.969653  / # export SHELL=3D/bin/bash

    2024-04-17T06:05:09.979867  export SHELL=3D/bin/bash
 =

    ... (152 line(s) more)  =

 =20

