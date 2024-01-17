Return-Path: <linux-kselftest+bounces-3169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89634830C4D
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 18:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9692857A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 17:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0248422F19;
	Wed, 17 Jan 2024 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGqGmlE2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C496E2231B;
	Wed, 17 Jan 2024 17:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705514091; cv=none; b=dJTSgyLyNWlaN0FHlhHbNgj3fTeTMA9MTt3rabK2lrrlrWmD4zrnQWcCbREvcbRgnV3xwwaUTAa8vfBMz0RBD8sPaaCYeq2aMK/jxBmzTGScbq8aaJ4ou/vtleI1/KVR7R1E9SkrJgkB1qyZnUtaAxN0ovzv6BM2Euf+nlZgqMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705514091; c=relaxed/simple;
	bh=J77FS0Bpoh8nK3y4ULhNSS2rlyTKBjXxlnteilrvwrU=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=PL1eijc303G9Wl0aIu3ZkIZzAqiS/kKlbrtKWIF74RxAskpoXjtqEGDxSyW0VCa2+7kJw6Zqa6owxU/A/W6wxJlUUU5nWuI6xpRbpTn20bIYmYmb69hUxLn72MfS7GXYE/UajNrwAlZYJiWXSi8l+Hx9epio/LXq3ljdRKTIMr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGqGmlE2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18862C433C7;
	Wed, 17 Jan 2024 17:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705514091;
	bh=J77FS0Bpoh8nK3y4ULhNSS2rlyTKBjXxlnteilrvwrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WGqGmlE25dqAiZWRrRkWSXIKygA+vpQOQvudOI4smF0yF+9MoHfmQC6PyBFpSWkBk
	 ssQBsIwrkcHj36bazih+ox4UPvJsDWBBoqrvC2nO1FQLqFxRRrSD3aOUfQXqWqyqnl
	 /zgabKW7Dzp1RbLxvTi0UlZcqiRrV6DRYoYe4Fg4yCDru891/7Zz14jA3v25IFJXt/
	 +f1Cjw8QPDdc68I8RiydMsFMZdDk5o+Kg+LyFCj9Oit8z1bJ4a9EsNZTwJcJPKCxV2
	 EQt9YTer5GBiuziU4DiiskqBKqRkDm5xAJPvTFLaCAlyXTHrDUDHQXJOnyL8EKGHq0
	 cK7aTGGHvFV9g==
Date: Wed, 17 Jan 2024 11:54:48 -0600
From: Rob Herring <robh@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org,
	Frank Rowand <frowand.list@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/6] arm64: Unconditionally call unflatten_device_tree()
Message-ID: <20240117175448.GB2779523-robh@kernel.org>
References: <20240112200750.4062441-1-sboyd@kernel.org>
 <20240112200750.4062441-2-sboyd@kernel.org>
 <ZaZtbU9hre3YhZam@FVFF77S0Q05N>
 <434b21afe1899b1567f3617261594842.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <434b21afe1899b1567f3617261594842.sboyd@kernel.org>

On Tue, Jan 16, 2024 at 05:27:18PM -0800, Stephen Boyd wrote:
> Quoting Mark Rutland (2024-01-16 03:51:14)
> > Hi Stephen,
> > 
> > On Fri, Jan 12, 2024 at 12:07:44PM -0800, Stephen Boyd wrote:
> > > Call this function unconditionally so that we can populate an empty DTB
> > > on platforms that don't boot with a firmware provided or builtin DTB.
> > > There's no harm in calling unflatten_device_tree() unconditionally.
> > 
> > For better or worse, that's not true: there are systems the provide both a DTB
> > *and* ACPI tables, and we must not consume both at the same time as those can
> > clash and cause all sorts of problems. In addition, we don't want people being
> > "clever" and describing disparate portions of their system in ACPI and DT.
> > 
> > It is a very deliberate choice to not unflatten the DTB when ACPI is in use,
> > and I don't think we want to reopen this can of worms.
> 
> Hmm ok. I missed this part. Can we knock out the initial_boot_params in
> this case so that we don't unflatten a DTB when ACPI is in use?

You mean so we don't unflatten the boot DTB, but instead unflatten the 
empty one, right? That sounds fine.

Another thing to check is kexec because it will still need the original 
DTB I think. Though if you are doing ACPI boot and kexec'ing, kexec may 
write out everything needed by the next kernel and the empty DTB would 
work just fine. Of course those users booting with ACPI and then 
kexec'ing to DT boot will be broken. Perhaps that's a feature...

Rob

