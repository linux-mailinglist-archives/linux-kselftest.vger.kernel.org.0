Return-Path: <linux-kselftest+bounces-5564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D359086BBEF
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 00:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607F81F24A74
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 23:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1FC13D2FC;
	Wed, 28 Feb 2024 23:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LQXhw439"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A698613D2F5;
	Wed, 28 Feb 2024 23:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709161649; cv=none; b=jPGlIXmNnqoVgJIqI420FtQu2HtqkUyFS5UkeyMI82+LEBfGW0NoDOf1ZK5sjA/WknVt3E36xNBrkvJm7NJz5Z6O6JUQ8WzhGwGQnfU24arkl5VL0MnPpugSN3PeEJ+tiBTV2/gmhffTAKqttNJgjMfPmVFg5HHnLRwRDQVONDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709161649; c=relaxed/simple;
	bh=fY1yIvW62KvszeLy+gCVYUvKP3VyBD0EuDMlnUClxWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QArHB2s8MWrgjC4nb/fmxf6iB0exsBeQ6LIIjhWntXvTF98gFLIqUtKZsJagoyzY4E6Nh8g6FPAo2aKfH+Nuy/p+9a9QNm3J6BckZVOazDFyKDKEso1b4b27YRaOeLog/S3kqnw2fiA18PMqQ5uhmcXsaoAbXt0q8R78CssuUYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=LQXhw439; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4F4C72E7;
	Thu, 29 Feb 2024 00:07:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709161631;
	bh=fY1yIvW62KvszeLy+gCVYUvKP3VyBD0EuDMlnUClxWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LQXhw439jgKAmY0pi7oEur6XckRkL0wWADYtH4pWxsa9s7Rb8KeZy1FokwXiAVUUF
	 7BjyQ+qJlQ/U6OwIw6ha1jg0DR+PhZ4SbEdMOPtQ1PqMqsZVNdgMb94SW6VI+4k0Y5
	 5ZM/L/GT/UFR4Y/8n8nY/hf8soMJpFQ8owgcHKYw=
Date: Thu, 29 Feb 2024 01:07:25 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Helen Koike <helen.koike@collabora.com>
Cc: linuxtv-ci@linuxtv.org, dave.pigott@collabora.com, mripard@kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com,
	pawiecz@collabora.com, spbnick@gmail.com, tales.aparecida@gmail.com,
	workflows@vger.kernel.org, kernelci@lists.linux.dev,
	skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
	nfraprado@collabora.com, davidgow@google.com, cocci@inria.fr,
	Julia.Lawall@inria.fr, laura.nao@collabora.com,
	ricardo.canuelo@collabora.com, kernel@collabora.com,
	torvalds@linuxfoundation.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH 0/3] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
Message-ID: <20240228230725.GF1659@pendragon.ideasonboard.com>
References: <20240228225527.1052240-1-helen.koike@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240228225527.1052240-1-helen.koike@collabora.com>

Hi Helen,

I appreciate the amount of work you've put into this, to improve testing
of the kernel as a whole. I'll need more time to answer, but please see
below for a quick comment already.

On Wed, Feb 28, 2024 at 07:55:24PM -0300, Helen Koike wrote:
> Dear Kernel Community,
> 
> This patch introduces a `.gitlab-ci` file along with a `ci/` folder, defining a
> basic test pipeline triggered by code pushes to a GitLab-CI instance. This
> initial version includes static checks (checkpatch and smatch for now) and build
> tests across various architectures and configurations. It leverages an
> integrated cache for efficient build times and introduces a flexible 'scenarios'
> mechanism for subsystem-specific extensions.
> 
> tl;dr: check this video to see a quick demo: https://youtu.be/TWiTjhjOuzg,
> but don't forget to check the "Motivation for this work" below. Your feedback,
> whether a simple thumbs up or down, is crucial to determine if it is worthwhile
> to pursue this initiative.
> 
> GitLab is an Open Source platform that includes integrated CI/CD. The pipeline
> provided in this patch is designed to work out-of-the-box with any GitLab
> instance, including the gitlab.com Free Tier. If you reach the limits of the
> Free Tier, consider using community instances like https://gitlab.freedesktop.org/.
> Alternatively, you can set up a local runner for more flexibility. The
> bootstrap-gitlab-runner.sh script included with this patch simplifies this
> process, enabling you to run tests on your preferred infrastructure, including
> your own machine.
> 
> For detailed information, please refer to the documentation included in the
> patch, or check the rendered version here: https://koike.pages.collabora.com/-/linux/-/jobs/298498/artifacts/artifacts/Documentation-output/ci/gitlab-ci/gitlab-ci.html .
> 
> 
> Motivation for this Work
> ========================
> 
> We all know tests are a major topic in the community, so let's mention the
> specificities of this approach:
> 
> 1. **Built-in User Interface:** GitLab CI/CD is growing in popularity and has an
> user-friendly interface. Our experience with the upstream DRM-CI in the kernel
> tree (see this blog post [https://www.collabora.com/news-and-blog/blog/2024/02/08/drm-ci-a-gitlab-ci-pipeline-for-linux-kernel-testing/] )
> has provided insights into how such a system can benefit the wider community.
> 
> 2. **Distributed Infrastructure:**
> The proposed GitLab-CI pipeline is designed with a distributed infrastructure
> model, being possible to run in any gitlab instance. 
> 
> 3. **Reduce regressions:** Fostering a culture where people habitually run
> validated tests and post their results can prevent many issues in post-merge
> tests.
> 
> 4. **Collaborative Testing Environment:** The kernel community is already
> engaged in numerous testing efforts, including various GitLab-CI pipelines such
> as DRM-CI, which I maintain, along with other solutions like KernelCI and
> BPF-CI. This proposal is designed to further stimulate contributions to the
> evolving testing landscape. Our goal is to establish a comprehensive suite of
> common tools and files.
> 
> 5. **Ownership of QA:** 
> Discrepancies between kernel code and outdated tests often lead to misattributed
> failures, complicating regression tracking. This issue, often arising from
> neglected or deprioritized test updates, creates uncertainty about the source of
> failures. Adopting an "always green pipeline" approach, as detailed in this
> patch's documentation, encourages timely maintenance and validation of tests.
> This ensures that testing accurately reflects the current state of the kernel,
> thereby improving the effectiveness of our QA processes.
> 
> Additionally, if we discover that this method isn't working for us, we can
> easily remove it from the codebase, as it is primarily contained within the ci/
> folder.
> 
> 
> Future Work
> ===========
> 
> **Expanding Static Checks:**
> We have the opportunity to integrate a variety of static analysis tools,
> including:
> - dtbs_checks
> - sparse
> - yamllint
> - dt-doc-validate
> - coccicheck
> 
> **Adding Userspace Tests on VMs:**
> To further our testing, we can implement userspace tests that run on virtual
> machines (VMs), such as:
> - kselftests
> - kunit tests
> - Subsystem-specific tests, customizable in the scenarios.
> 
> **Leveraging External Test Labs:**
> We can extend our testing to external labs, similar to what DRM-CI currently
> does. This includes:
> - Lava labs
> - Bare metal labs
> - Using KernelCI-provided labs
> 
> **Other integrations**
> - Submit results to KCIDB
> 
> **Lightweight Implementation for All Developers:**
> We aim to design these tests to be lightweight, ensuring developers with limited
> computing resources can still run essential tests. Resource-intensive tests can
> be set to trigger manually, rather than automatically, to accommodate diverse
> development environments.
> 
> 
> Chat Discussions
> ================
> 
> For those interested in further discussions:
> 
> **Join Our Slack Channel:**
> We have a Slack channel, #gitlab-ci, on the KernelCI Slack instance https://kernelci.slack.com/ .
> Feel free to join and contribute to the conversation. The KernelCI team has
> weekly calls where we also discuss the GitLab-CI pipeline.

Could we communicate using free software please ? Furthermore, it's not
possible to create an account on that slack instance unless you have an
e-mail address affiliated with a small number of companies
(https://kernelci.slack.com/signup#/domain-signup). That's a big no-go
for me.

> **Acknowledgments:**
> A special thanks to Nikolai Kondrashov, Tales da Aparecida - both from Red Hat -
> and KernelCI community for their valuable feedback and support in this proposal.
> 
> 
> I eagerly await your thoughts and suggestions on this initiative.
> 
> Also, if you want to see this initiave move faster, we are happy to discuss
> funding options.
> 
> Best regards,
> Helen Koike
> 
> Helen Koike (3):
>   kci-gitlab: Introducing GitLab-CI Pipeline for Kernel Testing
>   kci-gitlab: Add documentation
>   kci-gitlab: docs: Add images
> 
>  .gitlab-ci.yml                                |   2 +
>  Documentation/ci/gitlab-ci/gitlab-ci.rst      | 404 ++++++++++++++++++
>  .../ci/gitlab-ci/images/job-matrix.png        | Bin 0 -> 159752 bytes
>  .../gitlab-ci/images/new-project-runner.png   | Bin 0 -> 607737 bytes
>  .../ci/gitlab-ci/images/pipelines-on-push.png | Bin 0 -> 532143 bytes
>  .../ci/gitlab-ci/images/the-pipeline.png      | Bin 0 -> 91675 bytes
>  .../ci/gitlab-ci/images/variables.png         | Bin 0 -> 277518 bytes
>  Documentation/index.rst                       |   7 +
>  MAINTAINERS                                   |   9 +
>  ci/gitlab-ci/bootstrap-gitlab-runner.sh       |  55 +++
>  ci/gitlab-ci/ci-scripts/build-docs.sh         |  35 ++
>  ci/gitlab-ci/ci-scripts/build-kernel.sh       |  35 ++
>  ci/gitlab-ci/ci-scripts/ici-functions.sh      | 104 +++++
>  ci/gitlab-ci/ci-scripts/install-smatch.sh     |  13 +
>  .../ci-scripts/parse_commit_message.sh        |  27 ++
>  ci/gitlab-ci/ci-scripts/run-checkpatch.sh     |  19 +
>  ci/gitlab-ci/ci-scripts/run-smatch.sh         |  45 ++
>  ci/gitlab-ci/docker-compose.yaml              |  18 +
>  ci/gitlab-ci/linux.code-workspace             |  11 +
>  ci/gitlab-ci/yml/build.yml                    |  43 ++
>  ci/gitlab-ci/yml/cache.yml                    |  26 ++
>  ci/gitlab-ci/yml/container.yml                |  36 ++
>  ci/gitlab-ci/yml/gitlab-ci.yml                |  71 +++
>  ci/gitlab-ci/yml/kernel-combinations.yml      |  18 +
>  ci/gitlab-ci/yml/scenarios.yml                |  12 +
>  ci/gitlab-ci/yml/scenarios/file-systems.yml   |  21 +
>  ci/gitlab-ci/yml/scenarios/media.yml          |  21 +
>  ci/gitlab-ci/yml/scenarios/network.yml        |  21 +
>  ci/gitlab-ci/yml/static-checks.yml            |  21 +
>  29 files changed, 1074 insertions(+)
>  create mode 100644 .gitlab-ci.yml
>  create mode 100644 Documentation/ci/gitlab-ci/gitlab-ci.rst
>  create mode 100644 Documentation/ci/gitlab-ci/images/job-matrix.png
>  create mode 100644 Documentation/ci/gitlab-ci/images/new-project-runner.png
>  create mode 100644 Documentation/ci/gitlab-ci/images/pipelines-on-push.png
>  create mode 100644 Documentation/ci/gitlab-ci/images/the-pipeline.png
>  create mode 100644 Documentation/ci/gitlab-ci/images/variables.png
>  create mode 100755 ci/gitlab-ci/bootstrap-gitlab-runner.sh
>  create mode 100755 ci/gitlab-ci/ci-scripts/build-docs.sh
>  create mode 100755 ci/gitlab-ci/ci-scripts/build-kernel.sh
>  create mode 100644 ci/gitlab-ci/ci-scripts/ici-functions.sh
>  create mode 100755 ci/gitlab-ci/ci-scripts/install-smatch.sh
>  create mode 100755 ci/gitlab-ci/ci-scripts/parse_commit_message.sh
>  create mode 100755 ci/gitlab-ci/ci-scripts/run-checkpatch.sh
>  create mode 100755 ci/gitlab-ci/ci-scripts/run-smatch.sh
>  create mode 100644 ci/gitlab-ci/docker-compose.yaml
>  create mode 100644 ci/gitlab-ci/linux.code-workspace
>  create mode 100644 ci/gitlab-ci/yml/build.yml
>  create mode 100644 ci/gitlab-ci/yml/cache.yml
>  create mode 100644 ci/gitlab-ci/yml/container.yml
>  create mode 100644 ci/gitlab-ci/yml/gitlab-ci.yml
>  create mode 100644 ci/gitlab-ci/yml/kernel-combinations.yml
>  create mode 100644 ci/gitlab-ci/yml/scenarios.yml
>  create mode 100644 ci/gitlab-ci/yml/scenarios/file-systems.yml
>  create mode 100644 ci/gitlab-ci/yml/scenarios/media.yml
>  create mode 100644 ci/gitlab-ci/yml/scenarios/network.yml
>  create mode 100644 ci/gitlab-ci/yml/static-checks.yml

-- 
Regards,

Laurent Pinchart

