Return-Path: <linux-kselftest+bounces-41504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EF8B57EF3
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 16:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C9A3A7C6C
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 14:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25A231D756;
	Mon, 15 Sep 2025 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAK1rDeA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FB030C62F;
	Mon, 15 Sep 2025 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757946590; cv=none; b=RrYbsyRnd3ZFfr5HEreqhHlIClLH2WB5FxmmcNtJghxPg2ZThKErryZeeFkERvdQMfhfXd4Ec1QpssIFKukSC211ZzcTAsVPaQE26USJcELn2K/ACqHtPL8wg25AikLkDbxJ1jb/uUA77MhFgwo2lKtT01EkSNRZLdd3Aeg6ZR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757946590; c=relaxed/simple;
	bh=7lI5MZHznx5ErIR/NXuFs+vw+Oq/SkPWnTHMUhPjQl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzQLqJUYowmbsTfbV+Qo5UYxBb5RlGNUk9f1vpSsNxRUTSilrY7uKN4tAYBA+7q8ebkfphduyQN35izNqwCEqYay0E83Xs59SW1EGzoWln2Sx4e9DkNhxyfymXZVaexs0rzWb+5Xh9ZsmAvNeKsiPu3GPwfhEucVL5NS6wxcxQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAK1rDeA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFF0C4CEF1;
	Mon, 15 Sep 2025 14:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757946590;
	bh=7lI5MZHznx5ErIR/NXuFs+vw+Oq/SkPWnTHMUhPjQl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RAK1rDeAsbkVB1QN1pawukGo03AAEGBrU9s0pA9ityTV+p+baNry4RLRRrbOSVkNP
	 teQ8GcIaWRWIfcyvrPvC/uH1j8tGZ9MbmtEKdQasecFybVogEfiYpKZnxPM1lvBHyA
	 rMQqwWf9gnaThMz1rbkU37dCcxChkuJQ3bXTUx4gsImlfcpzIcc6iVMPyFwR28Lrr5
	 2BMh+JaYnOx/6Gm4aNTdzk3wfDtlJddMsT6sstoxOPJzHGM3iwYk8QXhBveSDse1Eq
	 j6C25OM55yTiDV9v/gCsb5sQxkbBvBxZPahokEDSIZAlQWvzACphHCNFEGY+aL2i3O
	 pjZa2cqjefIow==
Date: Mon, 15 Sep 2025 16:29:41 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Kees Cook <kees@kernel.org>, 
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, Deepak Gupta <debug@rivosinc.com>, 
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>, 
	Florian Weimer <fweimer@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, jannh@google.com, 
	Andrew Morton <akpm@linux-foundation.org>, Yury Khrustalev <yury.khrustalev@arm.com>, 
	Wilco Dijkstra <wilco.dijkstra@arm.com>, linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v20 4/8] fork: Add shadow stack support to clone3()
Message-ID: <20250915-aneignen-notdienst-c901d4b6df24@brauner>
References: <20250902-clone3-shadow-stack-v20-0-4d9fff1c53e7@kernel.org>
 <20250902-clone3-shadow-stack-v20-4-4d9fff1c53e7@kernel.org>
 <20250905-nutria-befund-2f3e92003734@brauner>
 <0ff8b70e-283f-4d56-8bab-bcae11cd5bdb@sirena.org.uk>
 <202509050900.8A01B1E6@keescook>
 <8caf310a-7179-4d4f-be73-2e25496a915f@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8caf310a-7179-4d4f-be73-2e25496a915f@sirena.org.uk>

On Fri, Sep 05, 2025 at 05:02:33PM +0100, Mark Brown wrote:
> On Fri, Sep 05, 2025 at 09:00:51AM -0700, Kees Cook wrote:
> > On Fri, Sep 05, 2025 at 04:43:22PM +0100, Mark Brown wrote:
> 
> > > discover the problem fairly rapidly in testing.  ss_token would shorter
> > > but the abbreviation is less clear, whatever name you prefer is fine by
> > > me.
> 
> > Bike shed: shstk_token?
> 
> That also works and is fine by me, probably better than my idea.

Can you do a quick resend based on kernel-6.18.clone3?
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=kernel-6.18.clone3



