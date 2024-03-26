Return-Path: <linux-kselftest+bounces-6601-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF5388B71A
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 02:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E13211F3E511
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 01:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866DB288DB;
	Tue, 26 Mar 2024 01:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyTUbtTT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2D0208A0;
	Tue, 26 Mar 2024 01:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711417957; cv=none; b=E+6VqVNkELlWk11W9PoXpaxOz8CTudJtZnkl5UL+lYPyIJi7bDjmQwRJMWGQ8GfUMqpU6X5JjagcbzBqYqqOcHuZDfz/FI+hfuWv2hAf3AL/uB+iBhtADSZUYO/M32tKF0kUI5+Vx+LW+Tmayr9PCcge9WHPU36u++5qCIu1qgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711417957; c=relaxed/simple;
	bh=41HzCcmKGdpC5F2Ac6G0iIm2fkdlbujw9uvFa0tJEh8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fr/GYkkFJ5x90XvztdcTTgIE/lhX9w3YG/qTSub0lSfJ5wfs6k0k/8vL/jWypkOZj0utu3k/doffuRhZYWjvrV/qjtjN3aChCj8+M/t9DkFFf3qCRhqpYb7mOV+KUdEedNSg8bzhyhGgKI3Mxpy0haiSBmAJGZAgKGhqcI8eVag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyTUbtTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B70C433F1;
	Tue, 26 Mar 2024 01:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711417956;
	bh=41HzCcmKGdpC5F2Ac6G0iIm2fkdlbujw9uvFa0tJEh8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GyTUbtTT/+lK39/t1cAhOoP5DswYTsi6hk2B5d43nkrVsvlJ/fcIxIRKMpJJFDMor
	 5ayovZsp26/P+PSTLTSU3h334wLThM6mxS+aEtq7Zsb77ReMdZ1ESmiDIAjmepaErd
	 R2VATHqvZqTdc7rjlfIPELACI9CynhopuLXq1NJoeVphzbL33F1FqJF4H79PlBv17q
	 lOsRnuZb/j0golrV6oTbWtjyQsopxto7B3O56FagUPttf7Y9MQyXAujBuZW6qfMolj
	 9+1qvXqH7see4+ynEbvnmKkgXTnBQ5jaZHQ3mR6nrzeCqftFWXMByuVVnD3dZ40wzH
	 D4MxfJ7j2pszw==
Date: Mon, 25 Mar 2024 18:52:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Johannes Berg <johannes.berg@intel.com>, Brendan Higgins
 <brendanhiggins@google.com>, David Gow <davidgow@google.com>, Rae Moar
 <rmoar@google.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, x86@kernel.org
Subject: Re: kunit alltests runs broken in mainline
Message-ID: <20240325185235.2f704004@kernel.org>
In-Reply-To: <b743a5ec-3d07-4747-85e0-2fb2ef69db7c@sirena.org.uk>
References: <b743a5ec-3d07-4747-85e0-2fb2ef69db7c@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 15:21:33 +0000 Mark Brown wrote:
> Hi,
> 
> Commit 28b3df1fe6ba2cb4 ("kunit: add wireless unit tests") which I can't
> seem to find on lore breaks full kunit runs on non-UML builds and is now
> present in mainline.  If I run:
> 
>    ./tools/testing/kunit/kunit.py run --alltests --cross_compile x86_64-linux-gnu- --arch x86_64
> 
> on a clean tree then I get:
> 
>    [15:09:20] Configuring KUnit Kernel ...
>    Generating .config ...
>    Populating config with:
>    $ make ARCH=x86_64 O=.kunit olddefconfig CROSS_COMPILE=x86_64-linux-gnu-
>    ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
>    This is probably due to unsatisfied dependencies.
>    Missing: CONFIG_IWLWIFI=y, CONFIG_WLAN_VENDOR_INTEL=y
> 
> UML works fine, but other real architectures (eg, arm64) seem similarly
> broken.  I've not looked properly yet, I'm a bit confused given that
> there's not even any dependencies for WLAN_VENDOR_INTEL and it's not
> mentoned in the defconfig.

I'm late to the party, but FWIW I had to toss this into netdev testing
tree as a local patch:

CONFIG_NETDEVICES=y
CONFIG_WLAN=y
CONFIG_DAMON_DBGFS_DEPRECATED=y
https://github.com/linux-netdev/testing/commit/9a632301bf3dbc9ba553562a0ba2657af6fa84d1

We run using:

	./tools/testing/kunit/kunit.py run --alltests

it got broken after we fast-forwarded to Linus on Thu, so I assumed it
was kunit itself that changed. Not that I found the relevant commit.

The DAMON config was also breaking UML for us, BTW, and I don't see
any fix for that in Linus's tree. Strangeness.

