Return-Path: <linux-kselftest+bounces-3782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCCE8432A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 02:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7DE01F214D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 01:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459D5641;
	Wed, 31 Jan 2024 01:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bh/INT4H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8B27EB;
	Wed, 31 Jan 2024 01:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706663902; cv=none; b=Vy060Yh1urBI6YqiNrwSM3IZ3ejXTOFvh9qzctds1giyL0eRoW3IyYZlw1VfeGOk7hTBvZvlVsTySokL1EowcGg1W31Gl1wcrbzMaYdjbrXJwpnqe9vlZg2Td5EMzjNVgDVUISjxp4JG/f74KbI+wplls7dMdMsx9cymy7kBLOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706663902; c=relaxed/simple;
	bh=/eo7jrcaFyTtlQyXMPkadl1Y+R9QjbUoZHk96UkE3F4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cGU9CB+rU6GwIyiwG8AtqCszZpSork5NdWmkDsV/hL1vw7sy2yVbBcRRrbig+VXek8EEbP0fAyzwgnZ/yUJtnlBAL4jYHFUR8iwQoFHOPCpApkWk52t3AbN+xyekh3vR5QfxHQE0SmjyXd0BaJtE5PRA64hbWn/fbpwSGaA7ExM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bh/INT4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8B8C433C7;
	Wed, 31 Jan 2024 01:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706663901;
	bh=/eo7jrcaFyTtlQyXMPkadl1Y+R9QjbUoZHk96UkE3F4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bh/INT4Hzotq8dYLpuYI8VJtFtPDkVkD5gDLylqPp5xzmPqvxUopCxbvh1zB60XN0
	 NktMKd6mqb2uVeaLLJTz+J98Gnw1GfaqVRHZCAiZbe6sDzXq01G8UdH5bkx5CeT+e0
	 THj5428S75kE3RBrBMKj39gTIZYI2BngD+34XZ5eLMN2qbKxti+21tAXNMQhmHgPrd
	 x6jaiTY2NeoGf8FaNdpUDGWPLVCXb/2Emvo0SO3jz8S9RQuI7z7IRmt1uT7OJeoX/s
	 va7g+m7kBxq/iNXlosP6cCgoxgMgODQrmZPQzlq5H84K0CqDd1W+QfwKfgWGS5fpau
	 A+WYaDM+KNwzA==
Date: Tue, 30 Jan 2024 17:18:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>, Xin Long
 <lucien.xin@gmail.com>, Florian Westphal <fw@strlen.de>, Aaron Conole
 <aconole@redhat.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: net: add missing config for big tcp
 tests
Message-ID: <20240130171817.1572c29f@kernel.org>
In-Reply-To: <785a9d7b1ce68f8131e6f9c8802981ac7ad75948.camel@redhat.com>
References: <21630ecea872fea13f071342ac64ef52a991a9b5.1706282943.git.pabeni@redhat.com>
	<20240126115551.176e3888@kernel.org>
	<a090936028c28b480cf3f8a66a9c3d924b7fd6ec.camel@redhat.com>
	<d67d7e4a77c8aec7778f378e7a95916c89f52973.camel@redhat.com>
	<20240129083933.6b964b3f@kernel.org>
	<785a9d7b1ce68f8131e6f9c8802981ac7ad75948.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 19:41:10 +0100 Paolo Abeni wrote:
> > Yes, it's VM inside a VM without nested virtualization support.
> > A weird setup, granted, but when we move to bare metal I'd like
> > to enable KASAN, which will probably cause a similar slowdown..
> > 
> > You could possibly get a similar slowdown by disabling HW virt /
> > KVM?  
> 
> Thanks, the above helped - that is, I can reproduce the failure running
> the self-tests in a VM with KVM disabled in the host. Funnily enough I
> can't use plain virtme for that - the virtme VM crashes on boot,
> possibly due to the wrong 'machine' argument passed to qemu.

FWIW I think you can fix this by passing -o " -cpu Haswell" to vng. 
Yet another piece of knowledge I wish I didn't have and which I should
probably put somewhere public :(

> In any case I can't see a sane way to cope with such slow environments
> except skipping the sensitive cases.
> 
> > FWIW far the 4 types of issues we've seen were:
> >  - config missing
> >  - OS doesn't ifup by default
> >  - OS tools are old / buggy
> >  - VM-in-VM is just too slow.
> > 
> > There's a bunch of failures in forwarding which look like perf issues.
> > I wonder if we should introduce something in the settings file to let
> > tests know that they are running in very slow env?  
> 
> I was wondering about passing such info to the test e.g. via an env
> variable:
> 
> vng --run . --user root -- HOST_IS_DAMN_SLOW=true
> ./tools/testing/selftests/kselftest_install/run_kselftest.sh -t
> <whatever>
> 
> In any case some tests should be updated to skip the relevant cases
> accordingly, right?

Which reminds me I need to send the meeting notes from the netdev call
:) We went with KSFT_MACHINE_SLOW=yes for now, the NIPA machines should
have it set now.

