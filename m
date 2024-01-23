Return-Path: <linux-kselftest+bounces-3429-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA8A83968D
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 18:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577D6285711
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 17:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54DD80058;
	Tue, 23 Jan 2024 17:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyYPcmvn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C0D7F7DC;
	Tue, 23 Jan 2024 17:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031515; cv=none; b=QJh9QMrmxX4hU3/0g3uWfijuru5ioWZp589MGZCGVHP9wOepKVBoT1Kv23pf4E9jV9Hvqn04e5TJBqpUYg0w6tgbiD1oozOK4nrbPEWbQ5e0afPBmyTOjcoInx13zOKuQk56dog6DA18lOZ4FlRwFbv41Vk23OH2ky459AdG1nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031515; c=relaxed/simple;
	bh=bIsJdjJZWEU6xNDyk8cHPXzvvfDLZ1YMX9qL8aAZnjU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IX8aEMwjT4k64dIM0J1CI4sQEmE+awlf9zD7jYgKQdoOTJQWcfPmLN+I6eVGJ6DBiTW+fIWyVWkmtzZxxum5X0USJP40g4jSQH6L/Q5RfbAl6w2/+jWm+GeJFhLNtsHYB0Q6xs2dNLE5Ish6FW7LOgTKJ3lZK0xP0UUaBDmGycg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyYPcmvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A06C433F1;
	Tue, 23 Jan 2024 17:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706031515;
	bh=bIsJdjJZWEU6xNDyk8cHPXzvvfDLZ1YMX9qL8aAZnjU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DyYPcmvn3IFYjPPU/IYBz+m0xuoa/F4Fpop96QN9pWBZVFa218EgM3R6xIRG3cTRo
	 q13f2Do++Oq+xWer+tA7Psgo3LGYGsLzlH98FUEVh0DuWzZaZNrGG2k/+g6Ke0E8Y6
	 7sSzk6MyIuQRjs2HpmtdTHN124hyPW9837RZwGD12zGPR+f9fOorZB1u/0sPg4DPR/
	 tIUiQYbDtOUMtNQRC4/GgSMDk4D+ZxLSpSRMCeLZ976EWiiJfbAg1vTDymPaXr/UrA
	 +zhgKW6k+9ld18thNVrp74JAS1c2hBxtfXCPgsql6dTXvEVJD/B+bK/d+RGFNUrSwa
	 nxnUdaZbqGWZw==
Date: Tue, 23 Jan 2024 09:38:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [ANN] net-next is OPEN
Message-ID: <20240123093834.23ea172a@kernel.org>
In-Reply-To: <87y1cgm040.fsf@nvidia.com>
References: <20240122091612.3f1a3e3d@kernel.org>
	<87fryonx35.fsf@nvidia.com>
	<20240123073412.063bc08e@kernel.org>
	<87y1cgm040.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 18:04:19 +0100 Petr Machata wrote:
> > Unless I'm doing it wrong and the sub-directories are supposed to
> > inherit the parent directory's config? So net/forwarding/ should
> > be built with net/'s config? I could not find the info in docs,
> > does anyone know?  
> 
> I don't think they are, net/config defines CONFIG_VXLAN, but then the
> vxlan tests still complain about unknown device type. Though maybe
> there's another device type that it's missing...
> 
> What do I do to feed the config file to some build script to get a
> kernel image to test? I can of course just do something like
> cat config | xargs -n1 scripts/config -m, but I expect there's some
> automation for it and I just can't find it.

The CI script is based on virtme-ng. So it does this:

# $target is net or net/forwarding or drivers/net/bonding etc.
make mrproper
vng -v -b -f tools/testing/selftests/$target
# build the scripts
make headers
make -C tools/testing/selftests/$target

vng -v -r arch/x86/boot/bzImage --user root
# inside the VM
make -C tools/testing/selftests TARGETS=$target run_tests

https://github.com/kuba-moo/nipa/blob/master/contest/remote/vmksft.py#L138

You're right, it definitely does not "inherit" net's config when
running forwarding/net. I can easily make it do so, but I'm not clear
what the expectation from the kselftest subsystem is. Because if other
testers (people testing stable, KernelCI etc. et.c) don't "inherit" we
better fill in the config completely so that the tests pass for
everyone.

