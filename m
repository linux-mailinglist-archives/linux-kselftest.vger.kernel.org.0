Return-Path: <linux-kselftest+bounces-29990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4224EA77F7E
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 17:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E1D162D7F
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 15:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D1D20C486;
	Tue,  1 Apr 2025 15:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pg9hd6bO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A745020C01C;
	Tue,  1 Apr 2025 15:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743522607; cv=none; b=SJCENRdJmh35YbAPUHqn2FjecI2WbLEYj8DaZMZGv+PdRclomPnuPPYbWlPSkiOVqrqCfCWJjkyqtVCJspZyb/GxjdwCfow4XpL+0Xg7fkinRJ8eSDTX/XJLKaLcraC6TJb+J+moD0AFdjSDoV1kovnIyY+Cl6CH5rGlSgMh3DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743522607; c=relaxed/simple;
	bh=1hkJIObXU6D6g/m6PDf5eOhm8XieoCe72AgLZFtJ1tY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQkjyyS2S9n3iHrYGp2lXYTjJfEwowWt+DXuiLuJQOKDcVr3A6oemgHOIZimLciIotYhoIIA68ZiCM4cHv1e4eJlQytsGmUCETsz/MPHPxlgTGOuZ7DoVLXzKLoZ3cn2wTVVlZNa4OMhkr09yn7bWTcNWqErJDWlcAq7FdQ/ajA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pg9hd6bO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFFEC4CEE4;
	Tue,  1 Apr 2025 15:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743522607;
	bh=1hkJIObXU6D6g/m6PDf5eOhm8XieoCe72AgLZFtJ1tY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pg9hd6bOaGA/LYOFZN8mY4c003tZBqGisSy1eGSSPOnbpvECWNvOgduhC3WV48xYp
	 mzn/SLSFf8UozljIiONEJAh1yqrMkNGkPlDuXflY8TprZ3FeTfabYNro4cwehZWBhx
	 aaaOauK6U+4vud+mQfyTDqL8OIyJEW5/FuhabMNYjH98UkDm01FORoRs7vcZzJZVrH
	 Pi/ff8O/1EUuU1AOzgdLPQfUj/EfCSei+ij4B8QYBY58MsTjdmaSkG4UiH3GHWb/T0
	 ORw0oMtC/KKdafl0LcV6605G+s7nkKpYuhXOo6JyRvCEki5c5wdOYjX36z5Wp3UHkh
	 B59gg6SPSZewg==
Date: Tue, 1 Apr 2025 18:50:02 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jan Stancek <jstancek@redhat.com>, Neal Gompa <neal@gompa.dev>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	llvm@lists.linux.dev, nkapron@google.com, teknoraver@meta.com,
	roberto.sassu@huawei.com, xiyou.wangcong@gmail.com
Subject: Re: [RFC PATCH security-next 0/4] Introducing Hornet LSM
Message-ID: <Z-wLKhlfJ5EQqvJC@kernel.org>
References: <20250321164537.16719-1-bboscaccy@linux.microsoft.com>
 <Z97xvUul1ObkmulE@kernel.org>
 <871puc7wb8.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871puc7wb8.fsf@microsoft.com>

On Mon, Mar 31, 2025 at 01:57:15PM -0700, Blaise Boscaccy wrote:
> There are two flavors of skeletons, normal skeletons, and light
> skeletons. Normal skeletons utilize relocation logic that lives in
> libbpf, and the relocations/instruction rewriting happen in userspace.
> The second flavor, light skeletons, uses a small eBPF program that
> contains the relocation lookup logic. As it's running in in the kernel,
> it unpacks the target program, peforms the instruction rewriting, and
> loads the target program. Light skeletons are currently utilized for
> some drivers, and BPF_PRELOAD functionionality since they can operate
> without userspace.
> 
> Light skeletons were recommended on various mailing list discussions as
> the preffered path to performing signature verification. There are some
> PoCs floating around that used light-skeletons in concert with
> fs-verity/IMA and eBPF LSMs. We took a slightly different approach to
> Hornet, by utilizing the existing PCKS#7 signing scheme that is used for
> kernel modules.

Right, because in the normal skeletons relocation logic remains
unsigned?

I have to admit I don't fully cope how the relocation process translates
into eBPF program but I do get how it is better for signatures if it
does :-)

> 
> >> verification. Signature data can be easily generated for the binary
> >
> > s/easily//
> >
> > Useless word having no measure.
> >
> 
> Ack, thanks.
> 
> 
> >> data that is generated via bpftool gen -L. This signature can be
> >
> > I have no idea what that command does.
> >
> > "Signature data can be generated for the binary data as follows:
> >
> > bpftool gen -L
> >
> > <explanation>"
> >
> > Here you'd need to answer to couple of unknowns:
> >
> > 1. What is in exact terms "signature data"?
> 
> That is a PKCS#7 signature of a data buffer containing the raw
> instructions of an eBPF program, followed by the initial values of any
> maps used by the program. 

Got it, thanks. This motivates to refine my TPM2 asymmetric keys
series so that TPM2 could anchor these :-)

https://lore.kernel.org/linux-integrity/20240528210823.28798-1-jarkko@kernel.org/


> 
> > 2. What does "bpftool gen -L" do?
> >
> 
> eBPF programs often have 2 parts. An orchestrator/loader program that
> provides load -> attach/run -> i/o -> teardown logic and the in-kernel
> program.
> 
> That command is used to generate a skeleton which can be used by the
> orchestrator prgoram. Skeletons get generated as a C header file, that
> contains various autogenerated functions that open and load bpf programs
> as decribed above. That header file ends up being included in a
> userspace orchestrator program or possibly a kernel module.

I did read the man page now too, but thanks for the commentary!

> 
> > This feedback maps to other examples too in the cover letter.
> >
> > BR, Jarkko
> 
> 
> I'll rework this with some definitions of the eBPF subsystem jargon
> along with your suggestions.

Yeah, you should be able to put the gist a factor better to nutshell :-)

> 
> -blaise

BR, Jarkko

