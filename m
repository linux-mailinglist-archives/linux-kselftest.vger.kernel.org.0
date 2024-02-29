Return-Path: <linux-kselftest+bounces-5657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0987F86CF33
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 17:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3241C235D9
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 16:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771486CC13;
	Thu, 29 Feb 2024 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Q14FqFwO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E3F6CBE0;
	Thu, 29 Feb 2024 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709224138; cv=none; b=RlgEzoPp+HymUrW2RLArSw1cIFH9NrXWkKrWacZIn1157k0RpUUoscb3roUjsfIEN8CnbgVlwhSKDilbscOsNIBnqcIjis05xNcNj8EZ0asgcJMGFu9DZRiM5JedBb+dhnu852HNY76khrC74HfJvun/7Bj4g0ohGnMlqPGQRxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709224138; c=relaxed/simple;
	bh=z4pcMkbx7CwYtTLR1xVSD2jGRP8EoN4FBh8txazgN9A=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yk8q9AvQFOuB1esStVtnxxiAbNRAJO0Lil2m8r8FT9CAlg2fRrQ9+bKc1dG78FWod6jA/kKEmM1XWRNFEVvAAoBpuN1c4pE1xPbR54pFkpMR8/156j57BTE2ApuKfjKdf/J/LB4tFx3BJDN5W/hxEU0A/Q+Os1ZE7XUJ9fUKEPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Q14FqFwO; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709224134;
	bh=z4pcMkbx7CwYtTLR1xVSD2jGRP8EoN4FBh8txazgN9A=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Q14FqFwOkU3VixMurYxnw1yk1ZbMV9inkY4T1bEtUk4/XS5dyG+R94vFtllvI/t1b
	 BLOtyXu7swxRNfucTD11pVsSgdE0emaKDk+nNA+iRUqy11TXgGKLTE0dbr4QtYhiAW
	 3R3NW0akW34+qswicx0By/kpbDHalnrt0hcUHs1fQf08vDKcmYxD0p4odjklxshMID
	 bek9QpSuvYFpYd2ms1DWsCyijWVcDNkR+DROy3guaDoYd21B1zBqeAE/1j+qZu0tTL
	 nVulcl3OdM19BKtZutlAs+shYJGgpfIoXjlhEB9AgDh2FFQa2kdoq7wtco/LS2xlHT
	 dlzl/nirPPcnA==
Received: from nicolas-tpx395.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 92CC13782066;
	Thu, 29 Feb 2024 16:28:51 +0000 (UTC)
Message-ID: <51fa8932e57010620e9a9e16a1979f4883e95a7d.camel@collabora.com>
Subject: Re: [PATCH 0/3] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Nikolai Kondrashov <spbnick@gmail.com>, Guillaume Tucker
 <gtucker@gtucker.io>, Helen Koike <helen.koike@collabora.com>, 
 linuxtv-ci@linuxtv.org, dave.pigott@collabora.com, mripard@kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com, 
 pawiecz@collabora.com, tales.aparecida@gmail.com,
 workflows@vger.kernel.org,  kernelci@lists.linux.dev,
 skhan@linuxfoundation.org, kunit-dev@googlegroups.com, 
 nfraprado@collabora.com, davidgow@google.com, cocci@inria.fr, 
 Julia.Lawall@inria.fr, laura.nao@collabora.com,
 ricardo.canuelo@collabora.com,  kernel@collabora.com,
 torvalds@linuxfoundation.org, gregkh@linuxfoundation.org
Date: Thu, 29 Feb 2024 11:28:48 -0500
In-Reply-To: <a5726043-1906-44ba-a6ee-a725a2776269@gmail.com>
References: <20240228225527.1052240-1-helen.koike@collabora.com>
	 <d99d026e-ed32-4432-bab3-db75296e67d8@gtucker.io>
	 <a5726043-1906-44ba-a6ee-a725a2776269@gmail.com>
Autocrypt: addr=nicolas.dufresne@collabora.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Le jeudi 29 f=C3=A9vrier 2024 =C3=A0 16:16 +0200, Nikolai Kondrashov a =C3=
=A9crit=C2=A0:
> On 2/29/24 2:20 PM, Guillaume Tucker wrote:
> > Hello,
> >=20
> > On 28/02/2024 23:55, Helen Koike wrote:
> > > Dear Kernel Community,
> > >=20
> > > This patch introduces a `.gitlab-ci` file along with a `ci/` folder, =
defining a
> > > basic test pipeline triggered by code pushes to a GitLab-CI instance.=
 This
> > > initial version includes static checks (checkpatch and smatch for now=
) and build
> > > tests across various architectures and configurations. It leverages a=
n
> > > integrated cache for efficient build times and introduces a flexible =
'scenarios'
> > > mechanism for subsystem-specific extensions.
> >=20
> > This sounds like a nice starting point to me as an additional way
> > to run tests upstream.  I have one particular question as I see a
> > pattern through the rest of the email, please see below.
> >=20
> > [...]
> >=20
> > > 4. **Collaborative Testing Environment:** The kernel community is alr=
eady
> > > engaged in numerous testing efforts, including various GitLab-CI pipe=
lines such
> > > as DRM-CI, which I maintain, along with other solutions like KernelCI=
 and
> > > BPF-CI. This proposal is designed to further stimulate contributions =
to the
> > > evolving testing landscape. Our goal is to establish a comprehensive =
suite of
> > > common tools and files.
> >=20
> > [...]
> >=20
> > > **Leveraging External Test Labs:**
> > > We can extend our testing to external labs, similar to what DRM-CI cu=
rrently
> > > does. This includes:
> > > - Lava labs
> > > - Bare metal labs
> > > - Using KernelCI-provided labs
> > >=20
> > > **Other integrations**
> > > - Submit results to KCIDB
> >=20
> > [...]
> >=20
> > > **Join Our Slack Channel:**
> > > We have a Slack channel, #gitlab-ci, on the KernelCI Slack instance h=
ttps://kernelci.slack.com/ .
> > > Feel free to join and contribute to the conversation. The KernelCI te=
am has
> > > weekly calls where we also discuss the GitLab-CI pipeline.
> > >=20
> > > **Acknowledgments:**
> > > A special thanks to Nikolai Kondrashov, Tales da Aparecida - both fro=
m Red Hat -
> > > and KernelCI community for their valuable feedback and support in thi=
s proposal.
> >=20
> > Where does this fit on the KernelCI roadmap?
> >=20
> > I see it mentioned a few times but it's not entirely clear
> > whether this initiative is an independent one or in some way
> > linked to KernelCI.  Say, are you planning to use the kci tool,
> > new API, compiler toolchains, user-space and Docker images etc?
> > Or, are KernelCI plans evolving to follow this move?
>=20
> I would say this is an important part of KernelCI the project, considerin=
g its=20
> aim to improve testing and CI in the kernel. It's not a part of KernelCI =
the=20
> service as it is right now, although I would say it would be good to have=
=20
> ability to submit KernelCI jobs from GitLab CI and pull results in the sa=
me=20
> pipeline, as we discussed earlier.

I'd like to add that both CI have a different purpose in the Linux project.=
 This
CI work is a pre-merge verification. Everyone needs to run checkpatch and
smatch, this is automating it (and will catch those that forgot or ran it
incorrectly). But it can go further by effectively testing specific patches=
 on
real hardware (with pretty narrow filters). It will help catch submission i=
ssues
earlier, and reduce kernelCI regression rate. As a side effect, kernelCI in=
fra
will endup catching the "integration" issues, which are the issue as a resu=
lt of
simultenous changes in different trees. They are also often more complex an=
d
benefit from the bisection capabilities.

kernelCI tests are also a lot more intensive, they usually covers everythin=
g,
but they bundle multiple changes per run. The pre-merge tests will be reduc=
ed to
what seems meaningful for the changes. Its important to understand that pre=
-
merge CI have a time cost, and we need to make sure CI time does not exceed=
 the
merge window period.

Nicolas

