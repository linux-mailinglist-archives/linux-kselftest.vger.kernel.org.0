Return-Path: <linux-kselftest+bounces-25070-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA54AA1AFB3
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 06:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7451C188EC14
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 05:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B02F1D6DC4;
	Fri, 24 Jan 2025 05:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqtBs1ho"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00CC380;
	Fri, 24 Jan 2025 05:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737695503; cv=none; b=suRHVT9QxP3TriA5eBxIz+MjW66+4AafCBRRP14N+SLA5TviT1SQuT70wiAPd3cRHn97RyrFY2dwxQbFYHfo+sRZFOwyi34/8VOGzQHll3h7z2wfdbbtYX8rr/iUbix9Txkp+pAXsJF1F9Gcw7onE4qwyN3j6Z9s/q5w/zcmvKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737695503; c=relaxed/simple;
	bh=GZfDhc8YobJPnzmcoeIXGiUTvE94cOwgS0opMG7s2JQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YZgJYr3HfOaMbybyhRFMLl2/JVOz3aIjn5QfMKp7JrgLdOc3PFMwshdG2YYIM6zp8HHYVsCFkuLc3goDc8tt2YbAZCB3JbwVvdBOjd2+PKHekOH6mkQ5Dd2aOC1vqF+rcQLBo2fsduLkIp7QTQObcn41dyfwUOP0FNmR0wElyH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqtBs1ho; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21669fd5c7cso29490165ad.3;
        Thu, 23 Jan 2025 21:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737695501; x=1738300301; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pm8oJeBuOFHd6ekxnejy3HEWqUKZZg6N9tys57iCgH8=;
        b=iqtBs1ho6qxCc14s1a/qD3q4QRRpGghtR61whZVuRhET9lpAPT16RJlZKMbfHYHHoo
         d/M4+RyvYG1ZcvPoNFwGs8V3h4Wo+0n8lCM4CdOPazGi37pDXcDZGQN52+cSf8gUdE6W
         ui1/rve5bj+ESAAT90S3iZv9lZ9ZomEdzUm4MNeLRxyj5oIbiLCxqkk00D3q4ViChaEv
         t2MTnWFdlbwUEwFJdHmq1DLDHsAcmo4ma4NM818ThlvmaKcT1xJ2E8gxYYS/aztKPyth
         TVzXk6ypwGtzpCbScWfZk9GniPuhxL/Gweq7Pyiy1C9AXQvJ2vV9p882K+V9VqWuFMCm
         cu0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737695501; x=1738300301;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pm8oJeBuOFHd6ekxnejy3HEWqUKZZg6N9tys57iCgH8=;
        b=w3K0IrQh/RNUEYpNEkqFlElraNGgNZSBw6RFGLW6JyyZT3N1iDxCbqhiyBqK+LJusk
         Zeafwq6qMDv3AKEL6AfKZmbaw1GUxbG0w4M7VF40egWmGw6woVdcUsMfdOcE8KxT3Ip2
         PrKiQ8uAz06jXHAEeKk/tEptJ/MmVXFGrqt1o6DTUsawmgc32uBn6ewPwTF3/yfIXQ53
         2skng5OL7tIhjutid/+4D240yPUm2Yt76nLhuqdKamy7+JDudROrhBe9vTGj50nv/1PW
         A5Q1CgqJ0e9coSCmj5OaIYvggaRIumLvSHLwKIFiGqLLChym8sjMNV57FdYyX7FfOI5n
         5Z7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU98fuD32ZsnmpHBI/N2FPKF63BTRSD9vdnamfQEq/S9qKxMbPBW0IFllT0/Fr0f1uEYb+r9cHl62Je@vger.kernel.org, AJvYcCVTI08l+GFbc3FlhxDoSEzS7pfPm9mKeJH77979F/xoRTElleVMbcoZzr01866fJMOgAz0Cn2oa6LvEOXY=@vger.kernel.org, AJvYcCW/9uv34CdNv2BqV2gnhVFgD4Kx2tj9oVcBAoHvh7nmwm75mo1jAAIm4vWU5hMlEbHJvD1R4m4nprgTlUXg2cKn@vger.kernel.org
X-Gm-Message-State: AOJu0YyAJ8205EHPmZobzI6CpUnvB+YOjCpEN85Hm0mzQ1cAm/cLhyf+
	o90DjQcevi6exB6qL5u9nZv2TeXsZqcPgVFSv/YQ6R6s622wre9feUR9GRO8
X-Gm-Gg: ASbGnct1Kbmo/lCBi4Xhnnc5nXIqsMFV5atkJrHwbpAtx5DAMck3z0rXsu0zRnFXkoh
	CwYuvBHbrdMtZJbInb5JsCEGbpOd4UVuPr7EF9dOYDpM2XYN4Jf+Nepl53t6SbDSLnDC6eKiRPn
	/9mR0gU1XxSnBWrr6Ev43qzYwXu4mhm25Qd0O/JEvvA8A3aCrbuwek5DBFRbmfQ2zUUTEBoRY8e
	AGz1CI0FaNX6P89BUWt6yw9aZh1lMpd4yjoYYkJbdqfALmv1wIf9S61JAymIKFNw/kEO8qU27Kp
	42MXFh4TzmczJeYWxiMoFYmGzxnp0iLDEvTiyzo7CR/AAPctlcQ=
X-Google-Smtp-Source: AGHT+IEu34cEqyV0xw9hfuRNjxOhke8sLDPtu8jUlbl+4jeWRLNMy3Ms4sWiV94JmApPoJ9ZFKf+5g==
X-Received: by 2002:a17:903:2312:b0:216:36ff:ba33 with SMTP id d9443c01a7336-21c355589ddmr413044785ad.26.1737695500948;
        Thu, 23 Jan 2025 21:11:40 -0800 (PST)
Received: from ?IPv6:2804:1b3:a801:16c4:23da:a93c:e00a:1229? ([2804:1b3:a801:16c4:23da:a93c:e00a:1229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414e151sm7636555ad.186.2025.01.23.21.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 21:11:40 -0800 (PST)
Message-ID: <f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
Subject: Re: [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
From: Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To: Vignesh Raman <vignesh.raman@collabora.com>, kernelci@lists.linux.dev
Cc: linuxtv-ci@linuxtv.org, dave.pigott@collabora.com, mripard@kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com, 
	pawiecz@collabora.com, spbnick@gmail.com, tales.aparecida@gmail.com, 
	workflows@vger.kernel.org, skhan@linuxfoundation.org,
 kunit-dev@googlegroups.com, 	nfraprado@collabora.com, davidgow@google.com,
 cocci@inria.fr, 	Julia.Lawall@inria.fr, laura.nao@collabora.com,
 kernel@collabora.com, 	torvalds@linuxfoundation.org,
 gregkh@linuxfoundation.org, daniels@collabora.com, 
	helen.koike@collabora.com, shreeya.patel@collabora.com,
 denys.f@collabora.com, 	nicolas.dufresne@collabora.com,
 louis.chauvet@bootlin.com, 	hamohammed.sa@gmail.com, melissa.srw@gmail.com,
 simona@ffwll.ch, airlied@gmail.com, 	Tim.Bird@sony.com,
 laurent.pinchart@ideasonboard.com, broonie@kernel.org, 	groeck@google.com,
 rdunlap@infradead.org, geert@linux-m68k.org, 	michel.daenzer@mailbox.org,
 sakari.ailus@iki.fi, jarkko@kernel.org
Date: Fri, 24 Jan 2025 02:11:26 -0300
In-Reply-To: <20250123135342.1468787-1-vignesh.raman@collabora.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-01-23 at 19:23 +0530, Vignesh Raman wrote:
> This patch series introduces "kci-gitlab," a GitLab CI pipeline
> specifically designed for kernel testing. It provides kernel
> developers with an integrated, efficient, and flexible testing
> framework using GitLab's CI/CD capabilities. This patch includes
> a .gitlab-ci file in the tools/ci/gitlab-ci/ folder, along with
> additional YAML and script files, to define a basic test pipeline
> triggered by code pushes to a GitLab-CI instance.
> The initial version implements:
>    =20
> - Static checks: Includes checkpatch and smatch for code validation.
> - Build tests: Covers various architectures and configurations.
> - Boot tests: Utilizes virtme for basic boot testing.
>=20
> Additionally, it introduces a flexible "scenarios" mechanism to
> support subsystem-specific extensions.
>=20
> This series also introduces a drm scenario that adds a job to run IGT
> tests for vkms. This scenario includes helper scripts to build deqp-runne=
r
> and IGT, leveraging approaches from the drm-ci/mesa-ci project.
>=20
> We are working towards creating a generic, upstream GitLab-CI pipeline
> (kci-gitlab) that will replace DRM-CI [1]. The proposed GitLab-CI pipelin=
e
> is designed with a distributed infrastructure model, making it possible
> to run on any gitLab instance. We plan to leverage KernelCI [2] as the
> backend, utilizing its hardware, rootfs, test plans, and KCIDB [3]
> integration.
>=20
> For an example of a fully executed pipeline with drm scenario set,
> including documentation generation,
> see: https://gitlab.freedesktop.org/vigneshraman/kernel/-/pipelines/13502=
62
>=20
> Please refer to the documentation included in the patch, or check the
> rendered version, here:=20
> https://vigneshraman.pages.freedesktop.org/-/kernel/-/jobs/69787927/artif=
acts/artifacts/Documentation-output/ci/gitlab-ci/gitlab-ci.html
>=20
> Differences from v1 to v2:
> - moved to tools/ci as suggested by Linus on the previous version
> - add arm64 containers for native compilation
> - added boot tests using virtme: this is the base structure for boot test=
s,
>   next steps would be adding other tests such as kselftests/kunit tests
> - added DRM scenario testing on vkms: this should replace current vkms te=
st
>   in drm-ci. This work shows how a test scenario can be used by different
>   subsystems to add their tests.
> - update documentation
>=20
> For more details on the motivation behind this work, please refer to the
> cover letter of v1: https://patchwork.kernel.org/project/linux-kselftest/=
cover/20240228225527.1052240-1-helen.koike@collabora.com/
>=20
> [1] https://www.collabora.com/news-and-blog/blog/2024/02/08/drm-ci-a-gitl=
ab-ci-pipeline-for-linux-kernel-testing/
> [2] https://kernelci.org/
> [3] https://docs.kernelci.org/kcidb/
>=20
> Helen Koike (3):
>   kci-gitlab: Introducing GitLab-CI Pipeline for Kernel Testing
>   kci-gitlab: Add documentation
>   kci-gitlab: docs: Add images
>=20
> Vignesh Raman (2):
>   MAINTAINERS: Add an entry for ci automated testing
>   kci-gitlab: Add drm scenario

Hi Vignesh Raman,
I am very happy to see this project going forward :)

It's been a few years since I first thought on finding a good way of helpin=
g
kernel developers testing their patches, while making use of the free runne=
r
minutes Gitlab offers. It can greatly simplify the testing for people who a=
re
new to kernel development, or students trying to understand it better.

And this patchset allows that to happen :)

Actually, I spoke to Helen last year, and to enable it to run on the free
Gitlab-CI runners, there is a small extra patch which is needed:

https://lore.kernel.org/all/20240327013055.139494-2-leobras@redhat.com/

Could you please apply it on top of your tree?
Some stuff changed places, but I can send a v2 with that fix if you want.


While I have yet to review this v2 patchset, I applied it on my repo for
testing,=C2=A0and cherry-picked the patch on above link, triggering a Pipel=
ine:

https://gitlab.com/linux-kernel/linux/-/pipelines/1638955600

It seems to be working fine, please check it, as you may be more used to th=
e
results.

Thanks!
Leo

