Return-Path: <linux-kselftest+bounces-10475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDCE8CAAC7
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 11:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0903B1C21491
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 09:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11C557CB2;
	Tue, 21 May 2024 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omHaxv8U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82385478B;
	Tue, 21 May 2024 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716283709; cv=none; b=YTu23V+IXHYS2JTORSrlSL0D8IXoMwi2KNrwcg/jnZ+2oKrkxh76HtC42jFE/Yy/Yp3RNOMxAT9fYYP5Ucq+EffSxgj0JJlKwMHHdGq6yjFdYE68DMWGa6EvzBgqXbHuudPfznu7T3wmABbqhfY+OtbG6Ih2MGAUBf8nR67WVuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716283709; c=relaxed/simple;
	bh=vu4Fr4NnQHtFu5eBOffzT74hbPy+G9MfIqvA0bqoLfU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=b3pKvs+o/bm53gG89RtvzcplkyYW1v156/+GRXD7vNmAby1QRyZSnMRqV/jKWwx7lB5eZrQZHNXzRvzAsdPok5VA3oVIYpR6aLP1xocAfrCkx9fsKdF4lbGdjih+mjRvSNRLRUJ8pW9lNt5VD3g+L6jxt0tUps6k1GZfENCL3GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omHaxv8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6333FC4AF07;
	Tue, 21 May 2024 09:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716283709;
	bh=vu4Fr4NnQHtFu5eBOffzT74hbPy+G9MfIqvA0bqoLfU=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=omHaxv8UqD3LFxWqgzUNsyO6tACio0yOaRVMzFye9QZ/qJNp6cNQr0UvJVp/4Avid
	 6U1H6sZaemnnsr40Pg4Ht3rmux9P4Mzx5l1XI3uLUDAL2jcf8lvdCzgKyaE+vFIf80
	 qcF4N2wlwKiJzaxB3ZeuolKbTQS4kn3AUXZK7NB+yWRxojT0HV4N/nU0/hYEU7AiNM
	 ofhCMO74eWNQTnLzekiPXedVkuKXwVRJJboiD3zYbxaxpQAeqi3Hu8Pz6D/6PH4GeR
	 soTOpWI1wnyHRYvBisDBNRlfq23AHV0FGPmixl5LiKCmfqTHS8O/EMYwf7Q3nGfdPC
	 Tw7uecJM7mxEg==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 May 2024 12:28:22 +0300
Message-Id: <D1F7SODNAG8W.1OR5BWUWSM4EA@kernel.org>
Subject: Re: [PATCH 0/3] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Helen Koike" <helen.koike@collabora.com>, <linuxtv-ci@linuxtv.org>,
 <dave.pigott@collabora.com>, <mripard@kernel.org>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kselftest@vger.kernel.org>, <gustavo.padovan@collabora.com>,
 <pawiecz@collabora.com>, <spbnick@gmail.com>, <tales.aparecida@gmail.com>,
 <workflows@vger.kernel.org>, <kernelci@lists.linux.dev>,
 <skhan@linuxfoundation.org>, <kunit-dev@googlegroups.com>,
 <nfraprado@collabora.com>, <davidgow@google.com>, <cocci@inria.fr>,
 <Julia.Lawall@inria.fr>, <laura.nao@collabora.com>,
 <ricardo.canuelo@collabora.com>, <kernel@collabora.com>,
 <torvalds@linuxfoundation.org>, <gregkh@linuxfoundation.org>
X-Mailer: aerc 0.17.0
References: <20240228225527.1052240-1-helen.koike@collabora.com>
In-Reply-To: <20240228225527.1052240-1-helen.koike@collabora.com>

On Thu Feb 29, 2024 at 12:55 AM EET, Helen Koike wrote:
> Dear Kernel Community,
>
> This patch introduces a `.gitlab-ci` file along with a `ci/` folder, defi=
ning a
> basic test pipeline triggered by code pushes to a GitLab-CI instance. Thi=
s
> initial version includes static checks (checkpatch and smatch for now) an=
d build
> tests across various architectures and configurations. It leverages an
> integrated cache for efficient build times and introduces a flexible 'sce=
narios'
> mechanism for subsystem-specific extensions.
>
> tl;dr: check this video to see a quick demo: https://youtu.be/TWiTjhjOuzg=
,
> but don't forget to check the "Motivation for this work" below. Your feed=
back,
> whether a simple thumbs up or down, is crucial to determine if it is wort=
hwhile
> to pursue this initiative.
>
> GitLab is an Open Source platform that includes integrated CI/CD. The pip=
eline
> provided in this patch is designed to work out-of-the-box with any GitLab
> instance, including the gitlab.com Free Tier. If you reach the limits of =
the
> Free Tier, consider using community instances like https://gitlab.freedes=
ktop.org/.
> Alternatively, you can set up a local runner for more flexibility. The
> bootstrap-gitlab-runner.sh script included with this patch simplifies thi=
s
> process, enabling you to run tests on your preferred infrastructure, incl=
uding
> your own machine.
>
> For detailed information, please refer to the documentation included in t=
he
> patch, or check the rendered version here: https://koike.pages.collabora.=
com/-/linux/-/jobs/298498/artifacts/artifacts/Documentation-output/ci/gitla=
b-ci/gitlab-ci.html .
>
>
> Motivation for this Work
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> We all know tests are a major topic in the community, so let's mention th=
e
> specificities of this approach:
>
> 1. **Built-in User Interface:** GitLab CI/CD is growing in popularity and=
 has an
> user-friendly interface. Our experience with the upstream DRM-CI in the k=
ernel
> tree (see this blog post [https://www.collabora.com/news-and-blog/blog/20=
24/02/08/drm-ci-a-gitlab-ci-pipeline-for-linux-kernel-testing/] )
> has provided insights into how such a system can benefit the wider commun=
ity.
>
> 2. **Distributed Infrastructure:**
> The proposed GitLab-CI pipeline is designed with a distributed infrastruc=
ture
> model, being possible to run in any gitlab instance.=20
>
> 3. **Reduce regressions:** Fostering a culture where people habitually ru=
n
> validated tests and post their results can prevent many issues in post-me=
rge
> tests.
>
> 4. **Collaborative Testing Environment:** The kernel community is already
> engaged in numerous testing efforts, including various GitLab-CI pipeline=
s such
> as DRM-CI, which I maintain, along with other solutions like KernelCI and
> BPF-CI. This proposal is designed to further stimulate contributions to t=
he
> evolving testing landscape. Our goal is to establish a comprehensive suit=
e of
> common tools and files.
>
> 5. **Ownership of QA:**=20
> Discrepancies between kernel code and outdated tests often lead to misatt=
ributed
> failures, complicating regression tracking. This issue, often arising fro=
m
> neglected or deprioritized test updates, creates uncertainty about the so=
urce of
> failures. Adopting an "always green pipeline" approach, as detailed in th=
is
> patch's documentation, encourages timely maintenance and validation of te=
sts.
> This ensures that testing accurately reflects the current state of the ke=
rnel,
> thereby improving the effectiveness of our QA processes.
>
> Additionally, if we discover that this method isn't working for us, we ca=
n
> easily remove it from the codebase, as it is primarily contained within t=
he ci/
> folder.

Not to criticize but I can do  tests I ever want with either Github
or Gitlab simply by bootstrapping BuildRoot on top of whatever the CI
runner has. So I essentially need just enough deps to make a BR build,
and that's it. And e.g. could run x86 tests on ARM ISA runner with zero
issues. And can even have emulated TPM chip in the QEMU VM by building
swtpm.

I had this for some time running actually Gitlab runner. It does not
currently build QEMU but then it also did that:

https://gitlab.com/jarkkojs/linux-tpmdd-test

Essentially just executing this sequence:

git clone https://gitlab.com/jarkkojs/linux-tpmdd-test.git
cd linux-tpmdd-test
cmake -Bbuild && make -Cbuild buildroot-prepare
make -Cbuild/buildroot/build
build/buildroot/build/images/run-tests.sh

I use TCL's "expect" to make conclusions from the output :-)

I'm assuming that this has a bigger point that I can understand right
now but makes me a bit puzzled given that it is quite trivial problem
to my understanding (if you want to pursue to it). Like one work=20
week maybe but not more than that...

Especially it feels weird that it needs kernel to be patched at all and
when I did read the motivation but it has sort of whitepaperish stuff
that does not really explain me the edge of this compared to e.g. to my
ad-hoc but still very usable solution (which is agnostic to runner's CPU
architecture, can emulated hardware and works in any possible hosting
with CI).

So maybe my review comment it this: do not assume that this would be
entirely new thing. It is not, and I'm sure some other people have
done this too in the past rather than just me. Instead this should
explain why this is so great that even kernel tree needs to be patched?

BR, Jarkko

