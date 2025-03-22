Return-Path: <linux-kselftest+bounces-29617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B263A6CCC8
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 22:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38ED13AC117
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 21:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2420E233D93;
	Sat, 22 Mar 2025 21:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/49ssj4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C121622A81F;
	Sat, 22 Mar 2025 21:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742679751; cv=none; b=W/BwCjJyWfRaiHyNlBhYA+6G6pCR/JgIbNWN7fqRB7CGEsM/yEmn6TiDFu/SSkvvm5lJJXBMlxVlqO5WnzSoj/lD09JwT0yz/GGYtyS0b/NT0Jpz8FSvvh/H8/Rbh9yubGDMLmg75QMnpgbEo2wP1dT0Kzy1Ba7wmund9zDWBJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742679751; c=relaxed/simple;
	bh=exq6iWzoUThYOY0optbQ3p6M5BiGjaqnyiIoG504lPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxIn1+FAeMnA4AQvFS3pgU8+hsnSBMg8c2Kz8L9+axGTTemYylu0sL89pEtR4NzBacaEBbmwPGFOZ+iKXneNHiMTr6aOh+sOfnuYVptVzEvGWZM4YfpOH7fbOmspwvm06zHyeeSBKTiVNWIHWdfSHLCsF3JXh2CuPpnmwp0EwSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/49ssj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9722C4CEDD;
	Sat, 22 Mar 2025 21:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742679750;
	bh=exq6iWzoUThYOY0optbQ3p6M5BiGjaqnyiIoG504lPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z/49ssj4d1Luorycc97EbgRyUWPSujwRGtWM9LvwFdZ4BfQiKo5V700eg7gSFP2dk
	 aIUQMT3pCGAvLq+9+lpFY4xzNiJhBGNV+Ed716WJHWUrWa6hp7C0Lb9EPR9AkzpEoz
	 DWlQAiRSwgmstJR5WpUXuADjy0LVZLAvks5QpoSnBW4OuQyS4aSnuHNn0PomQU+4ZB
	 EfrWhFUiSfW7qY4EtWMVcwTRmx1CmjcYJVYfqbdkMNXBuTd/i6ESIyPM4cax3GEIiu
	 jQJ0TBSaYxab0DLXzKgf6ZEcXbpG61+G1CKCPynSzwnDd176YMkTyEJTHq5LCyxtL8
	 bFOkYc4chu9FQ==
Date: Sat, 22 Mar 2025 23:42:26 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	James Morris <jmorris@namei.org>,
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
Message-ID: <Z98uwvHOTleafw-9@kernel.org>
References: <20250321164537.16719-1-bboscaccy@linux.microsoft.com>
 <Z97xvUul1ObkmulE@kernel.org>
 <CAHC9VhQ4a4Dinq+WLxM88KqJF8ruQ_rOdQx7UNrKcJqTpGGG+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQ4a4Dinq+WLxM88KqJF8ruQ_rOdQx7UNrKcJqTpGGG+w@mail.gmail.com>

On Sat, Mar 22, 2025 at 04:44:13PM -0400, Paul Moore wrote:
> On Sat, Mar 22, 2025 at 1:22 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > On Fri, Mar 21, 2025 at 09:45:02AM -0700, Blaise Boscaccy wrote:
> > > This patch series introduces the Hornet LSM.
> > >
> > > Hornet takes a simple approach to light-skeleton-based eBPF signature
> >
> > Can you define "light-skeleton-based" before using the term.
> >
> > This is the first time in my life when I hear about it.
> 
> I was in the same situation a few months ago when I first heard about it :)
> 
> Blaise can surely provide a much better answer that what I'm about to
> write, but since Blaise is going to be at LSFMMBPF this coming week I
> suspect he might not have a lot of time to respond to email in the
> next few days so I thought I would do my best to try and answer :)

Yeah, I don't think there is anything largely wrong in the feature
itself but it speaks language that would fit to eBPF subsystem list,
not here :-)

I.e. assume only very basic knowledge of eBPF and explain what stuff
mentioned actually does. Like bpftool statement should be opened up
fully.

> 
> An eBPF "light skeleton" is basically a BPF loader program and while
> I'm sure there are several uses for a light skeleton, or lskel for
> brevity, the single use case that we are interested in here, and the
> one that Hornet deals with, is the idea of using a lskel to enable
> signature verification of BPF programs as it seems to be the one way
> that has been deemed acceptable by the BPF maintainers.

I got some grip but the term only should be used IMHO in the commit
message, if it is defined at first :-)

> 
> Once again, skipping over a lot of details, the basic idea is that you
> take your original BPF program (A), feed it into a BPF userspace tool
> to encapsulate the original program A into a BPF map and generate a
> corresponding light skeleton BPF program (B), and then finally sign
> the resulting binary containing the lskel program (B) and map
> corresponding to the original program A.  At runtime, the lskel binary
> is loaded into the kernel, and if Hornet is enabled, the signature of
> both the lskel program A and original program B is verified.  If the
> signature verification passes, lskel program A performs the necessary
> BPF CO-RE transforms on BPF program A stored in the BPF map and then
> attempts to load the original BPF program B, all from within the
> kernel, and with the map frozen to prevent tampering from userspace.

When you speak about corresponding lskel program what does that
program contain? Is it some kind of new version of the same
program with modifications, or?

I neither did not know what BPF CO-RE is but I googled it ;-)

> 
> Hopefully that helps fill in some gaps until someone more
> knowledgeable can provide a better answer and/or correct any mistakes
> in my explanation above ;)

Sure... Thanks for the explanations!

> 
> -- 
> paul-moore.com

BR, Jarkko

