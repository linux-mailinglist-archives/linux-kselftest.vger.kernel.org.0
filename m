Return-Path: <linux-kselftest+bounces-5559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3C086BB17
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 23:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88A91F26C53
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 22:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EA172902;
	Wed, 28 Feb 2024 22:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="A87kTiHE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2FD7004E;
	Wed, 28 Feb 2024 22:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709160941; cv=none; b=QIKdH5ez7Po7ol8rtWKdTmTFQH5Hqxg+fwADHvYEpxXUw20zvlJsovEItt4qrNXzwJmFgMt1r2Db8Q/pEBAFls7biLwdgh8Km5MoTEQmQmisvgijSWuqoeWfnr2AHoUYj9+CTc2Dtcb7H8uUf8nk15T6pmVNW8MdxiuxXv3LFfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709160941; c=relaxed/simple;
	bh=6VtgkIxV7BP05QpH+CSqlVMLA5ngVi7oylPuoBSEGcU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=mx1RUrmHi1rxB2MInkHQnjH4sPA19mak9D/xwVm6S+RwoeUf5R+xlW+KGIUyfjn+NS7kzhx5sECqts2ks6cMCIchEp5smJFJWv9KEUzMQHWETtmbIr3lIl84WX9Pq3FZH/U2A/u51FLOQ/8eJcw8icBeK/SrGW+6ykcrWNwTnf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=A87kTiHE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709160938;
	bh=6VtgkIxV7BP05QpH+CSqlVMLA5ngVi7oylPuoBSEGcU=;
	h=From:To:Subject:Date:From;
	b=A87kTiHEClW+SUso7bjkel8UYsTiCXSBcH8Kj4bY4dGebjnrGHM46oTUceu7kYsMJ
	 dUKnjoqQzR4S6wUIhAypXIkDwynXGnR/khIjTFPzyNu8cWr+UG1/8Fj0LqBkW16gB1
	 92f9csTs5SBxNH2Dh3XKEmVlkYJaz6aSnNmb+YqHfvoKZM9r9AyKKsaZtvrYtfjCEq
	 PCXF4hneWm6yfjFSHE+gilccufYz6HYkCyIWnpF5dK3dvqL+37/YkHDPrAHZxH3+CK
	 e7kN3st5G5Nfuio6dxRodRU/VBZeu58ERPkEogNoptEMDEay3nYrgUcTC57iFdbfuX
	 rYhYCzfDWw77w==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: koike)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 93F7437820CB;
	Wed, 28 Feb 2024 22:55:31 +0000 (UTC)
From: Helen Koike <helen.koike@collabora.com>
To: linuxtv-ci@linuxtv.org,
	dave.pigott@collabora.com,
	mripard@kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kselftest@vger.kernel.org,
	gustavo.padovan@collabora.com,
	pawiecz@collabora.com,
	spbnick@gmail.com,
	tales.aparecida@gmail.com,
	workflows@vger.kernel.org,
	kernelci@lists.linux.dev,
	skhan@linuxfoundation.org,
	kunit-dev@googlegroups.com,
	nfraprado@collabora.com,
	davidgow@google.com,
	cocci@inria.fr,
	Julia.Lawall@inria.fr,
	laura.nao@collabora.com,
	ricardo.canuelo@collabora.com,
	kernel@collabora.com,
	torvalds@linuxfoundation.org,
	gregkh@linuxfoundation.org
Subject: [PATCH 0/3] kci-gitlab: Introducing GitLab-CI Pipeline for Kernel Testing
Date: Wed, 28 Feb 2024 19:55:24 -0300
Message-Id: <20240228225527.1052240-1-helen.koike@collabora.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear Kernel Community,

This patch introduces a `.gitlab-ci` file along with a `ci/` folder, defining a
basic test pipeline triggered by code pushes to a GitLab-CI instance. This
initial version includes static checks (checkpatch and smatch for now) and build
tests across various architectures and configurations. It leverages an
integrated cache for efficient build times and introduces a flexible 'scenarios'
mechanism for subsystem-specific extensions.

tl;dr: check this video to see a quick demo: https://youtu.be/TWiTjhjOuzg,
but don't forget to check the "Motivation for this work" below. Your feedback,
whether a simple thumbs up or down, is crucial to determine if it is worthwhile
to pursue this initiative.

GitLab is an Open Source platform that includes integrated CI/CD. The pipeline
provided in this patch is designed to work out-of-the-box with any GitLab
instance, including the gitlab.com Free Tier. If you reach the limits of the
Free Tier, consider using community instances like https://gitlab.freedesktop.org/.
Alternatively, you can set up a local runner for more flexibility. The
bootstrap-gitlab-runner.sh script included with this patch simplifies this
process, enabling you to run tests on your preferred infrastructure, including
your own machine.

For detailed information, please refer to the documentation included in the
patch, or check the rendered version here: https://koike.pages.collabora.com/-/linux/-/jobs/298498/artifacts/artifacts/Documentation-output/ci/gitlab-ci/gitlab-ci.html .


Motivation for this Work
========================

We all know tests are a major topic in the community, so let's mention the
specificities of this approach:

1. **Built-in User Interface:** GitLab CI/CD is growing in popularity and has an
user-friendly interface. Our experience with the upstream DRM-CI in the kernel
tree (see this blog post [https://www.collabora.com/news-and-blog/blog/2024/02/08/drm-ci-a-gitlab-ci-pipeline-for-linux-kernel-testing/] )
has provided insights into how such a system can benefit the wider community.

2. **Distributed Infrastructure:**
The proposed GitLab-CI pipeline is designed with a distributed infrastructure
model, being possible to run in any gitlab instance. 

3. **Reduce regressions:** Fostering a culture where people habitually run
validated tests and post their results can prevent many issues in post-merge
tests.

4. **Collaborative Testing Environment:** The kernel community is already
engaged in numerous testing efforts, including various GitLab-CI pipelines such
as DRM-CI, which I maintain, along with other solutions like KernelCI and
BPF-CI. This proposal is designed to further stimulate contributions to the
evolving testing landscape. Our goal is to establish a comprehensive suite of
common tools and files.

5. **Ownership of QA:** 
Discrepancies between kernel code and outdated tests often lead to misattributed
failures, complicating regression tracking. This issue, often arising from
neglected or deprioritized test updates, creates uncertainty about the source of
failures. Adopting an "always green pipeline" approach, as detailed in this
patch's documentation, encourages timely maintenance and validation of tests.
This ensures that testing accurately reflects the current state of the kernel,
thereby improving the effectiveness of our QA processes.

Additionally, if we discover that this method isn't working for us, we can
easily remove it from the codebase, as it is primarily contained within the ci/
folder.


Future Work
===========

**Expanding Static Checks:**
We have the opportunity to integrate a variety of static analysis tools,
including:
- dtbs_checks
- sparse
- yamllint
- dt-doc-validate
- coccicheck

**Adding Userspace Tests on VMs:**
To further our testing, we can implement userspace tests that run on virtual
machines (VMs), such as:
- kselftests
- kunit tests
- Subsystem-specific tests, customizable in the scenarios.

**Leveraging External Test Labs:**
We can extend our testing to external labs, similar to what DRM-CI currently
does. This includes:
- Lava labs
- Bare metal labs
- Using KernelCI-provided labs

**Other integrations**
- Submit results to KCIDB

**Lightweight Implementation for All Developers:**
We aim to design these tests to be lightweight, ensuring developers with limited
computing resources can still run essential tests. Resource-intensive tests can
be set to trigger manually, rather than automatically, to accommodate diverse
development environments.


Chat Discussions
================

For those interested in further discussions:

**Join Our Slack Channel:**
We have a Slack channel, #gitlab-ci, on the KernelCI Slack instance https://kernelci.slack.com/ .
Feel free to join and contribute to the conversation. The KernelCI team has
weekly calls where we also discuss the GitLab-CI pipeline.

**Acknowledgments:**
A special thanks to Nikolai Kondrashov, Tales da Aparecida - both from Red Hat -
and KernelCI community for their valuable feedback and support in this proposal.


I eagerly await your thoughts and suggestions on this initiative.

Also, if you want to see this initiave move faster, we are happy to discuss
funding options.

Best regards,
Helen Koike

Helen Koike (3):
  kci-gitlab: Introducing GitLab-CI Pipeline for Kernel Testing
  kci-gitlab: Add documentation
  kci-gitlab: docs: Add images

 .gitlab-ci.yml                                |   2 +
 Documentation/ci/gitlab-ci/gitlab-ci.rst      | 404 ++++++++++++++++++
 .../ci/gitlab-ci/images/job-matrix.png        | Bin 0 -> 159752 bytes
 .../gitlab-ci/images/new-project-runner.png   | Bin 0 -> 607737 bytes
 .../ci/gitlab-ci/images/pipelines-on-push.png | Bin 0 -> 532143 bytes
 .../ci/gitlab-ci/images/the-pipeline.png      | Bin 0 -> 91675 bytes
 .../ci/gitlab-ci/images/variables.png         | Bin 0 -> 277518 bytes
 Documentation/index.rst                       |   7 +
 MAINTAINERS                                   |   9 +
 ci/gitlab-ci/bootstrap-gitlab-runner.sh       |  55 +++
 ci/gitlab-ci/ci-scripts/build-docs.sh         |  35 ++
 ci/gitlab-ci/ci-scripts/build-kernel.sh       |  35 ++
 ci/gitlab-ci/ci-scripts/ici-functions.sh      | 104 +++++
 ci/gitlab-ci/ci-scripts/install-smatch.sh     |  13 +
 .../ci-scripts/parse_commit_message.sh        |  27 ++
 ci/gitlab-ci/ci-scripts/run-checkpatch.sh     |  19 +
 ci/gitlab-ci/ci-scripts/run-smatch.sh         |  45 ++
 ci/gitlab-ci/docker-compose.yaml              |  18 +
 ci/gitlab-ci/linux.code-workspace             |  11 +
 ci/gitlab-ci/yml/build.yml                    |  43 ++
 ci/gitlab-ci/yml/cache.yml                    |  26 ++
 ci/gitlab-ci/yml/container.yml                |  36 ++
 ci/gitlab-ci/yml/gitlab-ci.yml                |  71 +++
 ci/gitlab-ci/yml/kernel-combinations.yml      |  18 +
 ci/gitlab-ci/yml/scenarios.yml                |  12 +
 ci/gitlab-ci/yml/scenarios/file-systems.yml   |  21 +
 ci/gitlab-ci/yml/scenarios/media.yml          |  21 +
 ci/gitlab-ci/yml/scenarios/network.yml        |  21 +
 ci/gitlab-ci/yml/static-checks.yml            |  21 +
 29 files changed, 1074 insertions(+)
 create mode 100644 .gitlab-ci.yml
 create mode 100644 Documentation/ci/gitlab-ci/gitlab-ci.rst
 create mode 100644 Documentation/ci/gitlab-ci/images/job-matrix.png
 create mode 100644 Documentation/ci/gitlab-ci/images/new-project-runner.png
 create mode 100644 Documentation/ci/gitlab-ci/images/pipelines-on-push.png
 create mode 100644 Documentation/ci/gitlab-ci/images/the-pipeline.png
 create mode 100644 Documentation/ci/gitlab-ci/images/variables.png
 create mode 100755 ci/gitlab-ci/bootstrap-gitlab-runner.sh
 create mode 100755 ci/gitlab-ci/ci-scripts/build-docs.sh
 create mode 100755 ci/gitlab-ci/ci-scripts/build-kernel.sh
 create mode 100644 ci/gitlab-ci/ci-scripts/ici-functions.sh
 create mode 100755 ci/gitlab-ci/ci-scripts/install-smatch.sh
 create mode 100755 ci/gitlab-ci/ci-scripts/parse_commit_message.sh
 create mode 100755 ci/gitlab-ci/ci-scripts/run-checkpatch.sh
 create mode 100755 ci/gitlab-ci/ci-scripts/run-smatch.sh
 create mode 100644 ci/gitlab-ci/docker-compose.yaml
 create mode 100644 ci/gitlab-ci/linux.code-workspace
 create mode 100644 ci/gitlab-ci/yml/build.yml
 create mode 100644 ci/gitlab-ci/yml/cache.yml
 create mode 100644 ci/gitlab-ci/yml/container.yml
 create mode 100644 ci/gitlab-ci/yml/gitlab-ci.yml
 create mode 100644 ci/gitlab-ci/yml/kernel-combinations.yml
 create mode 100644 ci/gitlab-ci/yml/scenarios.yml
 create mode 100644 ci/gitlab-ci/yml/scenarios/file-systems.yml
 create mode 100644 ci/gitlab-ci/yml/scenarios/media.yml
 create mode 100644 ci/gitlab-ci/yml/scenarios/network.yml
 create mode 100644 ci/gitlab-ci/yml/static-checks.yml

-- 
2.40.1


