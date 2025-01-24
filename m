Return-Path: <linux-kselftest+bounces-25074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A63A1B174
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 09:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15D1B7A5706
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 08:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F68F205AC2;
	Fri, 24 Jan 2025 08:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="d1VBjwyL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9357A205AAC;
	Fri, 24 Jan 2025 08:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737706384; cv=none; b=F5L7lQNidQYurzBzf4fiUsx6fw4VqkuhrJhEItpJt82rwHRt9ghmiufWIXjCB1Z1IR6iHVYODLJ9FqyzIARVyQyqBGuwLFa3XnG7enBIZmpq0lkYTtXaJYuRYC0k6H1h0w+K3LQ7DgKLPBg9tCd4h+OCTRW7WTd0A2Hv9MNZyiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737706384; c=relaxed/simple;
	bh=idLhQQ+Oo5UWIbjsyxcdZEeHw78VV8pc1CNx0UgjdPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlXgOTo26IcbGXcaBdOzcII0SvCX6La5I9GTHl/Vks6HEKntZ571Cvm33hSUo+yJoYLSdHFQZlzsNrkYi751OiN/KZJikBrJDblnNCWsxFL1bMDYgVN5NInVfUTKj3/WEr0MGk+iNYK7AN/kdPupIqDpKQNtOoMOnrtrBUftkck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=d1VBjwyL; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4A0ACD01;
	Fri, 24 Jan 2025 09:11:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1737706315;
	bh=idLhQQ+Oo5UWIbjsyxcdZEeHw78VV8pc1CNx0UgjdPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d1VBjwyLb5/825+b7cVXFO9bdDNfsHPuG4v+5w/PShcuhYZnEGzMi4sgSuBT/t+Vl
	 81MAQ4hSpeZbPfdN5IsMI6Ow92B6XjP6sN03JQCziXIeLU58DsLBP6BFGAvkJAmmYb
	 XS3nweXjhRkr7hgNRjCVLoF07N3/estJlBU9pt94=
Date: Fri, 24 Jan 2025 10:12:50 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
Cc: Vignesh Raman <vignesh.raman@collabora.com>, kernelci@lists.linux.dev,
	linuxtv-ci@linuxtv.org, dave.pigott@collabora.com,
	mripard@kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
	gustavo.padovan@collabora.com, pawiecz@collabora.com,
	spbnick@gmail.com, tales.aparecida@gmail.com,
	workflows@vger.kernel.org, skhan@linuxfoundation.org,
	kunit-dev@googlegroups.com, nfraprado@collabora.com,
	davidgow@google.com, cocci@inria.fr, Julia.Lawall@inria.fr,
	laura.nao@collabora.com, kernel@collabora.com,
	torvalds@linuxfoundation.org, gregkh@linuxfoundation.org,
	daniels@collabora.com, helen.koike@collabora.com,
	shreeya.patel@collabora.com, denys.f@collabora.com,
	nicolas.dufresne@collabora.com, louis.chauvet@bootlin.com,
	hamohammed.sa@gmail.com, melissa.srw@gmail.com, simona@ffwll.ch,
	airlied@gmail.com, Tim.Bird@sony.com, broonie@kernel.org,
	groeck@google.com, rdunlap@infradead.org, geert@linux-m68k.org,
	michel.daenzer@mailbox.org, sakari.ailus@iki.fi, jarkko@kernel.org
Subject: Re: [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
Message-ID: <20250124081250.GA24731@pendragon.ideasonboard.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
 <f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>

On Fri, Jan 24, 2025 at 02:11:26AM -0300, Leonardo Brás wrote:
> On Thu, 2025-01-23 at 19:23 +0530, Vignesh Raman wrote:
> > This patch series introduces "kci-gitlab," a GitLab CI pipeline
> > specifically designed for kernel testing. It provides kernel
> > developers with an integrated, efficient, and flexible testing
> > framework using GitLab's CI/CD capabilities. This patch includes
> > a .gitlab-ci file in the tools/ci/gitlab-ci/ folder, along with
> > additional YAML and script files, to define a basic test pipeline
> > triggered by code pushes to a GitLab-CI instance.
> > The initial version implements:
> >     
> > - Static checks: Includes checkpatch and smatch for code validation.
> > - Build tests: Covers various architectures and configurations.
> > - Boot tests: Utilizes virtme for basic boot testing.
> > 
> > Additionally, it introduces a flexible "scenarios" mechanism to
> > support subsystem-specific extensions.
> > 
> > This series also introduces a drm scenario that adds a job to run IGT
> > tests for vkms. This scenario includes helper scripts to build deqp-runner
> > and IGT, leveraging approaches from the drm-ci/mesa-ci project.
> > 
> > We are working towards creating a generic, upstream GitLab-CI pipeline
> > (kci-gitlab) that will replace DRM-CI [1]. The proposed GitLab-CI pipeline
> > is designed with a distributed infrastructure model, making it possible
> > to run on any gitLab instance. We plan to leverage KernelCI [2] as the
> > backend, utilizing its hardware, rootfs, test plans, and KCIDB [3]
> > integration.
> > 
> > For an example of a fully executed pipeline with drm scenario set,
> > including documentation generation,
> > see: https://gitlab.freedesktop.org/vigneshraman/kernel/-/pipelines/1350262
> > 
> > Please refer to the documentation included in the patch, or check the
> > rendered version, here: 
> > https://vigneshraman.pages.freedesktop.org/-/kernel/-/jobs/69787927/artifacts/artifacts/Documentation-output/ci/gitlab-ci/gitlab-ci.html
> > 
> > Differences from v1 to v2:
> > - moved to tools/ci as suggested by Linus on the previous version
> > - add arm64 containers for native compilation
> > - added boot tests using virtme: this is the base structure for boot tests,
> >   next steps would be adding other tests such as kselftests/kunit tests
> > - added DRM scenario testing on vkms: this should replace current vkms test
> >   in drm-ci. This work shows how a test scenario can be used by different
> >   subsystems to add their tests.
> > - update documentation
> > 
> > For more details on the motivation behind this work, please refer to the
> > cover letter of v1: https://patchwork.kernel.org/project/linux-kselftest/cover/20240228225527.1052240-1-helen.koike@collabora.com/
> > 
> > [1] https://www.collabora.com/news-and-blog/blog/2024/02/08/drm-ci-a-gitlab-ci-pipeline-for-linux-kernel-testing/
> > [2] https://kernelci.org/
> > [3] https://docs.kernelci.org/kcidb/
> > 
> > Helen Koike (3):
> >   kci-gitlab: Introducing GitLab-CI Pipeline for Kernel Testing
> >   kci-gitlab: Add documentation
> >   kci-gitlab: docs: Add images
> > 
> > Vignesh Raman (2):
> >   MAINTAINERS: Add an entry for ci automated testing
> >   kci-gitlab: Add drm scenario
> 
> Hi Vignesh Raman,
> I am very happy to see this project going forward :)
> 
> It's been a few years since I first thought on finding a good way of helping
> kernel developers testing their patches, while making use of the free runner
> minutes Gitlab offers. It can greatly simplify the testing for people who are
> new to kernel development, or students trying to understand it better.
> 
> And this patchset allows that to happen :)
> 
> Actually, I spoke to Helen last year, and to enable it to run on the free
> Gitlab-CI runners, there is a small extra patch which is needed:
> 
> https://lore.kernel.org/all/20240327013055.139494-2-leobras@redhat.com/

Gitlab as an open-source software project (the community edition) is one
thing, but can we please avoid advertising specific proprietary services
in the kernel documentation ?

> Could you please apply it on top of your tree?
> Some stuff changed places, but I can send a v2 with that fix if you want.
> 
> 
> While I have yet to review this v2 patchset, I applied it on my repo for
> testing, and cherry-picked the patch on above link, triggering a Pipeline:
> 
> https://gitlab.com/linux-kernel/linux/-/pipelines/1638955600
> 
> It seems to be working fine, please check it, as you may be more used to the
> results.
> 
> Thanks!
> Leo

-- 
Regards,

Laurent Pinchart

