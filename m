Return-Path: <linux-kselftest+bounces-18966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 275A898F1B3
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 16:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5AB1F22455
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 14:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7367819F424;
	Thu,  3 Oct 2024 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="K87whl/U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A7E19F412;
	Thu,  3 Oct 2024 14:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727966482; cv=none; b=Jz37GXJtkQDCmygqNUWHR3hB0diFheeTcBMZmBnX4m/vMc68WMFEiVebiWRk8d6EaIKwkzPpcZImZrWEkRdPfcS6Uxc4+lWg3o1R7eGZtBTf1uIzeZS32a0Z6fvkrgbsBZQJZs90wN2JGy3bfUANM5kV0D72GY5rcVvkwubKVNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727966482; c=relaxed/simple;
	bh=3KUgYZAvBROUVRlj9xA2dwDZBFvPABlTt1AcVlOUlXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPZ3YUxA8dCErl3QbbzWs9xqyVIiZXPt5Z6zvZW8MUIqsZJJzkVVOGMHWElJ7kGShZXZnzptwVFz6d9WSv/tpXSBfLs9yHIdyug9sNGn6h+nCUkGE3I7Nt/7pAv9PVyF6BmEznw2hJ3EX6mG4fQtKguLiDtd/nKIYaask80e/i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=K87whl/U; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727966477;
	bh=3KUgYZAvBROUVRlj9xA2dwDZBFvPABlTt1AcVlOUlXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K87whl/UPgzHZr6nvDL/vuqKx814CKy7hkJumknnGce9dCIjhik4v+dIMtXQybjPq
	 g1LTU3JFFRJHzEscbD7fO5rzyxZ523HCqxXBREmUknoWVE8wlMFQo37Wm3aYOFdfai
	 vPuc2gxk9jJKcFWnodnS525rh5AQCsxaktnz/CRVN6AIwFqNzi1WeX+wjJNFkN2++U
	 XQyL5FsdPu7zzepnx+TJHRPft6ciayl9HhaKhixD6jp5dgMO6ymb0/PZB/Wb7ZdSdJ
	 Rl08qZuweqXXyWXpGtPaAvnzF/PT5KYZkctKDcm3uk79NzO9QL6GamnNtgbqEutg02
	 2Uf0cCTO65hdA==
Received: from notapiano (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3769D17E35FD;
	Thu,  3 Oct 2024 16:41:16 +0200 (CEST)
Date: Thu, 3 Oct 2024 10:41:13 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	kernel@collabora.com, linux-kselftest@vger.kernel.org,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernelci@lists.linux.dev
Subject: Re: [PATCH] docs: dev-tools: Add documentation for the device
 focused kselftests
Message-ID: <ef428a44-783c-43c3-81c6-9abf88ae8949@notapiano>
References: <20241001-kselftest-device-docs-v1-1-be28b70dd855@collabora.com>
 <0040a842-de9c-4f9c-9d61-c1bfbd010470@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0040a842-de9c-4f9c-9d61-c1bfbd010470@linuxfoundation.org>

On Wed, Oct 02, 2024 at 12:00:10PM -0600, Shuah Khan wrote:
> On 10/1/24 09:43, Nícolas F. R. A. Prado wrote:
> > Add documentation for the kselftests focused on testing devices and
> > point to it from the kselftest documentation. There are multiple tests
> > in this category so the aim of this page is to make it clear when to run
> > each test.
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
> > This patch depends on patch "kselftest: devices: Add test to detect
> > missing devices" [1], since this patch documents that test.
> > 
> > [1] https://lore.kernel.org/all/20240928-kselftest-dev-exist-v2-1-fab07de6b80b@collabora.com
> > ---
> >   Documentation/dev-tools/kselftest.rst       |  9 ++++++
> >   Documentation/dev-tools/testing-devices.rst | 47 +++++++++++++++++++++++++++++
> 
> The new file needs to be added to Documentation/dev-tools/index.rst
> 
> Docs make should have warned about this?

There is no warning. I have added this new document in a new toctree in the
kselftest.rst, as you can see in the hunk below.

Since this new page is specific to kselftest, I think listing it on the
kselftest page makes the most sense and will make it easier to find.

Do you want the new file to be listed in both places (ie kselftest.rst and
index.rst)? It will show up in the index.rst next to kselftest rather than
inside it.

Another option would be to do like kunit and create a directory for kselftest
and have an index.rst there to point to both the current kselftest.rst and the
new document. Structure-wise that would probably be the best approach.

> 
> >   2 files changed, 56 insertions(+)
> > 
> > diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> > index f3766e326d1e..fdb1df86783a 100644
> > --- a/Documentation/dev-tools/kselftest.rst
> > +++ b/Documentation/dev-tools/kselftest.rst
> > @@ -31,6 +31,15 @@ kselftest runs as a userspace process.  Tests that can be written/run in
> >   userspace may wish to use the `Test Harness`_.  Tests that need to be
> >   run in kernel space may wish to use a `Test Module`_.
> > +Documentation on the tests
> > +==========================
> > +
> > +For documentation on the kselftests themselves, see:
> > +
> > +.. toctree::
> > +
> > +   testing-devices
> > +
> >   Running the selftests (hotplug tests are run in limited mode)
> >   =============================================================
> > diff --git a/Documentation/dev-tools/testing-devices.rst b/Documentation/dev-tools/testing-devices.rst
> > new file mode 100644
> > index 000000000000..ab26adb99051
> > --- /dev/null
> > +++ b/Documentation/dev-tools/testing-devices.rst
> > @@ -0,0 +1,47 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +.. Copyright (c) 2024 Collabora Ltd
> > +
> > +=============================
> > +Device testing with kselftest
> > +=============================
> > +
> 
> Get rid of the extra blank line.

Ack.

Thanks,
Nícolas

