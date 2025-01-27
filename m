Return-Path: <linux-kselftest+bounces-25217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B3CA1D18B
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 08:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 939793A750D
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 07:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326E81FC108;
	Mon, 27 Jan 2025 07:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="M9ZiqL/R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C928918D;
	Mon, 27 Jan 2025 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737963157; cv=none; b=Uv/ZP1wOzQGPfBKhGal2ZGmK/JTDPjV1PpDewCfyuaq0C8vtbSgcaYC2J6a34adu9fh2/ViTNAiNdHpz23Z7SGjD6N1Y+q5khteLb5VyHSZC33A5HEMZUbNSmlieW5sWicHopKOc2kaNcoMKvo8ZriFoSQMa6wXDWRBCVjxIhdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737963157; c=relaxed/simple;
	bh=M1cz7Y5PlpaPiS3GVZ5e1VvQ0cfkEQKhqX+UMFLSc5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V6iirTd6HoX5ZKna9JWfU66nxuhCZfO62g40jVUPixv1wqoc7WwGSlU/aQ0ib2hwRd9Wbd6gvOgBGYHz7oAvu7iQkAE+oR00gq5Ya2FLWriVe+B+mgGz6RDZFjB8dTA0E25vNRrQXY95EmU01yetMfTw/ap+cvGPJ9OoR/45lms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=M9ZiqL/R; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1737963152;
	bh=M1cz7Y5PlpaPiS3GVZ5e1VvQ0cfkEQKhqX+UMFLSc5s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M9ZiqL/RLEj0JWkSk/0Nz+G8iHnq2hPL6WeF2ZZ7phJdtKUqclJ9Jm5X8V722qIB6
	 0vJIUh1ZGVxs6yv6jPp48sMEVrs4QCbcp7O2qpeeWsFoftqTp6m8UJo4LUWi2vbTBW
	 adu6Mf4p3SYYgqXXGC/ZLivbwIyeqGQ1XXN9fllxAe/iPd3sUOIKfI7fI54feYShan
	 kJi6RpNePbQAXvFSoIHZpILsXqUxmdmSIRWLDMy/f1cO6Bd2OljUEPhsJNUFasC/td
	 XSlJ8IQ+vSPOPREmyUntBUG22r/UcvbUdbxyRFBjD2tjX1KaIGd6E6HqLdoLmRiO5j
	 ZvtnxD6aellvw==
Received: from [192.168.50.250] (unknown [171.76.81.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 693ED17E0E8D;
	Mon, 27 Jan 2025 08:32:24 +0100 (CET)
Message-ID: <6ebd1551-017f-4b31-b235-829b2735d78f@collabora.com>
Date: Mon, 27 Jan 2025 13:02:14 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 =?UTF-8?Q?Leonardo_Br=C3=A1s?= <leobras.c@gmail.com>
Cc: kernelci@lists.linux.dev, linuxtv-ci@linuxtv.org,
 dave.pigott@collabora.com, mripard@kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
 gustavo.padovan@collabora.com, pawiecz@collabora.com, spbnick@gmail.com,
 tales.aparecida@gmail.com, workflows@vger.kernel.org,
 skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
 nfraprado@collabora.com, davidgow@google.com, cocci@inria.fr,
 Julia.Lawall@inria.fr, laura.nao@collabora.com, kernel@collabora.com,
 torvalds@linuxfoundation.org, gregkh@linuxfoundation.org,
 daniels@collabora.com, helen.koike@collabora.com,
 shreeya.patel@collabora.com, denys.f@collabora.com,
 nicolas.dufresne@collabora.com, louis.chauvet@bootlin.com,
 hamohammed.sa@gmail.com, melissa.srw@gmail.com, simona@ffwll.ch,
 airlied@gmail.com, Tim.Bird@sony.com, broonie@kernel.org, groeck@google.com,
 rdunlap@infradead.org, geert@linux-m68k.org, michel.daenzer@mailbox.org,
 sakari.ailus@iki.fi, jarkko@kernel.org
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
 <f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
 <20250124081250.GA24731@pendragon.ideasonboard.com>
Content-Language: en-US
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <20250124081250.GA24731@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Leo,

On 24/01/25 13:42, Laurent Pinchart wrote:
> On Fri, Jan 24, 2025 at 02:11:26AM -0300, Leonardo Brás wrote:
>> On Thu, 2025-01-23 at 19:23 +0530, Vignesh Raman wrote:
>>> This patch series introduces "kci-gitlab," a GitLab CI pipeline
>>> specifically designed for kernel testing. It provides kernel
>>> developers with an integrated, efficient, and flexible testing
>>> framework using GitLab's CI/CD capabilities. This patch includes
>>> a .gitlab-ci file in the tools/ci/gitlab-ci/ folder, along with
>>> additional YAML and script files, to define a basic test pipeline
>>> triggered by code pushes to a GitLab-CI instance.
>>> The initial version implements:
>>>      
>>> - Static checks: Includes checkpatch and smatch for code validation.
>>> - Build tests: Covers various architectures and configurations.
>>> - Boot tests: Utilizes virtme for basic boot testing.
>>>
>>> Additionally, it introduces a flexible "scenarios" mechanism to
>>> support subsystem-specific extensions.
>>>
>>> This series also introduces a drm scenario that adds a job to run IGT
>>> tests for vkms. This scenario includes helper scripts to build deqp-runner
>>> and IGT, leveraging approaches from the drm-ci/mesa-ci project.
>>>
>>> We are working towards creating a generic, upstream GitLab-CI pipeline
>>> (kci-gitlab) that will replace DRM-CI [1]. The proposed GitLab-CI pipeline
>>> is designed with a distributed infrastructure model, making it possible
>>> to run on any gitLab instance. We plan to leverage KernelCI [2] as the
>>> backend, utilizing its hardware, rootfs, test plans, and KCIDB [3]
>>> integration.
>>>
>>> For an example of a fully executed pipeline with drm scenario set,
>>> including documentation generation,
>>> see: https://gitlab.freedesktop.org/vigneshraman/kernel/-/pipelines/1350262
>>>
>>> Please refer to the documentation included in the patch, or check the
>>> rendered version, here:
>>> https://vigneshraman.pages.freedesktop.org/-/kernel/-/jobs/69787927/artifacts/artifacts/Documentation-output/ci/gitlab-ci/gitlab-ci.html
>>>
>>> Differences from v1 to v2:
>>> - moved to tools/ci as suggested by Linus on the previous version
>>> - add arm64 containers for native compilation
>>> - added boot tests using virtme: this is the base structure for boot tests,
>>>    next steps would be adding other tests such as kselftests/kunit tests
>>> - added DRM scenario testing on vkms: this should replace current vkms test
>>>    in drm-ci. This work shows how a test scenario can be used by different
>>>    subsystems to add their tests.
>>> - update documentation
>>>
>>> For more details on the motivation behind this work, please refer to the
>>> cover letter of v1: https://patchwork.kernel.org/project/linux-kselftest/cover/20240228225527.1052240-1-helen.koike@collabora.com/
>>>
>>> [1] https://www.collabora.com/news-and-blog/blog/2024/02/08/drm-ci-a-gitlab-ci-pipeline-for-linux-kernel-testing/
>>> [2] https://kernelci.org/
>>> [3] https://docs.kernelci.org/kcidb/
>>>
>>> Helen Koike (3):
>>>    kci-gitlab: Introducing GitLab-CI Pipeline for Kernel Testing
>>>    kci-gitlab: Add documentation
>>>    kci-gitlab: docs: Add images
>>>
>>> Vignesh Raman (2):
>>>    MAINTAINERS: Add an entry for ci automated testing
>>>    kci-gitlab: Add drm scenario
>>
>> Hi Vignesh Raman,
>> I am very happy to see this project going forward :)
>>
>> It's been a few years since I first thought on finding a good way of helping
>> kernel developers testing their patches, while making use of the free runner
>> minutes Gitlab offers. It can greatly simplify the testing for people who are
>> new to kernel development, or students trying to understand it better.
>>
>> And this patchset allows that to happen :)

Thanks for testing the patch and providing feedback.

>>
>> Actually, I spoke to Helen last year, and to enable it to run on the free
>> Gitlab-CI runners, there is a small extra patch which is needed:
>>
>> https://lore.kernel.org/all/20240327013055.139494-2-leobras@redhat.com/

Thanks for the patch.

We can keep the variable name as KCI_CI_TAGS (like other variables) and 
add it in variables with default empty string.

> 
> Gitlab as an open-source software project (the community edition) is one
> thing, but can we please avoid advertising specific proprietary services
> in the kernel documentation ?

Agree. We could remove the lines which mentions gitlab.com SaaS in
commit message and documentation.

> 
>> Could you please apply it on top of your tree?
>> Some stuff changed places, but I can send a v2 with that fix if you want.

I will test your patch and we can add this for v3.

Regards,
Vignesh

>>
>>
>> While I have yet to review this v2 patchset, I applied it on my repo for
>> testing, and cherry-picked the patch on above link, triggering a Pipeline:
>>
>> https://gitlab.com/linux-kernel/linux/-/pipelines/1638955600
>>
>> It seems to be working fine, please check it, as you may be more used to the
>> results.
>>
>> Thanks!
>> Leo
> 

