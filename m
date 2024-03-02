Return-Path: <linux-kselftest+bounces-5791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDADB86F29B
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Mar 2024 22:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9466628312F
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Mar 2024 21:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0352241766;
	Sat,  2 Mar 2024 21:48:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB144120C;
	Sat,  2 Mar 2024 21:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709416091; cv=none; b=ZmwJlAO4g+1jDmXMrobsL03RiAUOYpxU94LONfjt4BGy0VJxJRAfsbRePquZVqkmZa/DbcL1lC75jbPLBgSj9FCfY3nzVmH8IqtFIPJMBAyMk+Z+7oczilzLDh10u9ukJEHE+YSgij6wqtaAV4C7Hmbi5MF+RbcqNUZ6ANq+wQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709416091; c=relaxed/simple;
	bh=Dd1rw4lv4Gh4mHQAg+mf2vjOKVRdZOlXlXZuy1zjhGM=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=Mum9DNQaMA18YL0j/uGAJg17CXIXUqQaqU+HgDDDTBHfzTUwIvi58QzSEtKB5S3RKXzaged9sQ/GQNJmLUSUMeW/57GZWdOYlNl3qoRx0GPWf3qXrLkzNar/CfksJAcOCm1QGBPZrm/2ADkppCBfCNNETw6+3F9/gRfrzvOVU9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 4D7B83781183;
	Sat,  2 Mar 2024 21:48:05 +0000 (UTC)
From: "Gustavo Padovan" <gustavo.padovan@collabora.com>
In-Reply-To: <3d7e66bc-967e-45ec-a9e9-12dafd3b3e68@gtucker.io>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <d99d026e-ed32-4432-bab3-db75296e67d8@gtucker.io>
 <a5726043-1906-44ba-a6ee-a725a2776269@gmail.com>
 <51fa8932e57010620e9a9e16a1979f4883e95a7d.camel@collabora.com> <3d7e66bc-967e-45ec-a9e9-12dafd3b3e68@gtucker.io>
Date: Sat, 02 Mar 2024 21:48:05 +0000
Cc: "Nicolas Dufresne" <nicolas.dufresne@collabora.com>, "Nikolai Kondrashov" <spbnick@gmail.com>, "Helen Koike" <helen.koike@collabora.com>, linuxtv-ci@linuxtv.org, dave.pigott@collabora.com, mripard@kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, pawiecz@collabora.com, tales.aparecida@gmail.com, workflows@vger.kernel.org, kernelci@lists.linux.dev, skhan@linuxfoundation.org, kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com, cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com, ricardo.canuelo@collabora.com, kernel@collabora.com, torvalds@linuxfoundation.org, gregkh@linuxfoundation.org
To: "Guillaume Tucker" <gtucker@gtucker.io>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1801a-65e39e80-6d-2f4e1180@80294519>
Subject: =?utf-8?q?Re=3A?= [PATCH 0/3] =?utf-8?q?kci-gitlab=3A?= Introducing 
 GitLab-CI Pipeline for Kernel Testing
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Friday, March 01, 2024 18:56 -03, Guillaume Tucker <gtucker@gtucker.=
io> wrote:

> On 29/02/2024 17:28, Nicolas Dufresne wrote:
> > Hi,
> >=20
> > Le jeudi 29 f=C3=A9vrier 2024 =C3=A0 16:16 +0200, Nikolai Kondrasho=
v a =C3=A9crit=C2=A0:
> >> On 2/29/24 2:20 PM, Guillaume Tucker wrote:
> >>> Hello,
> >>>
> >>> On 28/02/2024 23:55, Helen Koike wrote:
> >>>> Dear Kernel Community,
> >>>>
> >>>> This patch introduces a `.gitlab-ci` file along with a `ci/` fol=
der, defining a
> >>>> basic test pipeline triggered by code pushes to a GitLab-CI inst=
ance. This
> >>>> initial version includes static checks (checkpatch and smatch fo=
r now) and build
> >>>> tests across various architectures and configurations. It levera=
ges an
> >>>> integrated cache for efficient build times and introduces a flex=
ible 'scenarios'
> >>>> mechanism for subsystem-specific extensions.
> >>>
> >>> This sounds like a nice starting point to me as an additional way
> >>> to run tests upstream.  I have one particular question as I see a
> >>> pattern through the rest of the email, please see below.
> >>>
> >>> [...]
> >>>
> >>>> 4. **Collaborative Testing Environment:** The kernel community i=
s already
> >>>> engaged in numerous testing efforts, including various GitLab-CI=
 pipelines such
> >>>> as DRM-CI, which I maintain, along with other solutions like Ker=
nelCI and
> >>>> BPF-CI. This proposal is designed to further stimulate contribut=
ions to the
> >>>> evolving testing landscape. Our goal is to establish a comprehen=
sive suite of
> >>>> common tools and files.
> >>>
> >>> [...]
> >>>
> >>>> **Leveraging External Test Labs:**
> >>>> We can extend our testing to external labs, similar to what DRM-=
CI currently
> >>>> does. This includes:
> >>>> - Lava labs
> >>>> - Bare metal labs
> >>>> - Using KernelCI-provided labs
> >>>>
> >>>> **Other integrations**
> >>>> - Submit results to KCIDB
> >>>
> >>> [...]
> >>>
> >>>> **Join Our Slack Channel:**
> >>>> We have a Slack channel, #gitlab-ci, on the KernelCI Slack insta=
nce https://kernelci.slack.com/ .
> >>>> Feel free to join and contribute to the conversation. The Kernel=
CI team has
> >>>> weekly calls where we also discuss the GitLab-CI pipeline.
> >>>>
> >>>> **Acknowledgments:**
> >>>> A special thanks to Nikolai Kondrashov, Tales da Aparecida - bot=
h from Red Hat -
> >>>> and KernelCI community for their valuable feedback and support i=
n this proposal.
> >>>
> >>> Where does this fit on the KernelCI roadmap?
> >>>
> >>> I see it mentioned a few times but it's not entirely clear
> >>> whether this initiative is an independent one or in some way
> >>> linked to KernelCI.  Say, are you planning to use the kci tool,
> >>> new API, compiler toolchains, user-space and Docker images etc?
> >>> Or, are KernelCI plans evolving to follow this move?
> >>
> >> I would say this is an important part of KernelCI the project, con=
sidering its=20
> >> aim to improve testing and CI in the kernel. It's not a part of Ke=
rnelCI the=20
> >> service as it is right now, although I would say it would be good =
to have=20
> >> ability to submit KernelCI jobs from GitLab CI and pull results in=
 the same=20
> >> pipeline, as we discussed earlier.
>=20
> Right, I think this needs a bit of disambiguation.  The legacy
> KernelCI system from the Linaro days several years ago is really
> a service on its own like the many other CIs out there.  However,
> the new KernelCI API and related tooling (kci command line, new
> web dashboard, modular runtime design etc.) is not that.  It's
> about addressing all the community requirements and that includes
> being able to run a same test manually in a shell, or in a VM, or
> automatically from GitLab CI or using a main generic pipeline
> hosted by KernelCI itself.  With this approach, there's no
> distinction between "the project" and "the service", and as we
> discussed before there shouldn't even be a distinction with
> KCIDB.  Just KernelCI.
>=20
> However I don't really see this happening, unless I'm missing a
> part of the story or some upcoming announcement with an updated
> roadmap.  For some reason the old and established paradigm seems
> unshakeable.  The new KernelCI implementation is starting to look
> just like a refresh of the old one with newer components - which
> is a huge missed opportunity to really change things IMHO.

Calling that a missed opportunity is a subjective perspective about
the latest developments in KernelCI. The system implementation is
one level less important than the actual kernel community engagement
the project can generate. If one asks people around, the lack of
community engagement with KernelCI is evident.

However, after the recent leadership change in the project there is a
growing effort to bring the kernel community closer to the KernelCI
project with a renewed focus on high quality test results, clean regres=
sion
reporting, among other things. Then, with an increased number of commun=
ity
members involved, we will have the necessary feedback (and funding!) to
evolve the KernelCI infrastructure and technology to new levels.

Otherwise, envisioning something that can solve *all* community testing
needs would never be anything more than a fantasy in people's heads.

- Gus

--=20
Gustavo Padovan
Kernel Lead
Collabora Ltd.


