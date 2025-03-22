Return-Path: <linux-kselftest+bounces-29618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FF9A6CCD4
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 22:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A47823AB9C5
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 21:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55667222582;
	Sat, 22 Mar 2025 21:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9nNlh4P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140DB8BF8;
	Sat, 22 Mar 2025 21:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742679797; cv=none; b=KqS4/bmh8Axed1XSEg62dCrxER8Kh+AZSQ52NpzBE/5fug3ZEAHQGo3nAmtKaBx2YXxM2ns6Wy9z162EEKelCAGfsGyYq6fpWfVsJqyb1/s2W3gG2qmNME/i1s0LbNSbjSQtr4riewU6vmy0XOb85lxjQ2wSFWmuPkNfvPONtW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742679797; c=relaxed/simple;
	bh=5bCoGZGcAjvnQ2yuOtHVcGZyivQ/TivOd5Z/SZ0HmkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auVkzcxUc5sIjMNsMeWaQF1UagCGNXJpBKeiA81gAbid9LVY/jxD5XSnR+qz3sF1setr5Ei06Qc6nR8jyx0wpeCHMOimglyJQTYssNDx3OrOGe0UCXCCcK/kM5fjv0vbbMqBDwe8KfSWxgxiXbRPBJJUw2ZuHSsu673qSDEk7dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9nNlh4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3D4C4CEDD;
	Sat, 22 Mar 2025 21:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742679796;
	bh=5bCoGZGcAjvnQ2yuOtHVcGZyivQ/TivOd5Z/SZ0HmkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U9nNlh4PT1t55mkfZ07SkYx3a9oZkB0wlBt/BcqXQ5g5mbU7NfQDLBsIBuBkOy8hz
	 Ax7tPzyD3i9MeloGdh4FgfERxIDBnvXGLupANF/THnDRDfUrcTTQkhwo+ys16y9/Ub
	 NgxZzRuaJB59wqs0OhIaLRZnD3YYBCJRQRc70bCA0r6Gp4EroQ9AMmhQwsOoRPuzCR
	 BDcNMlP/8h8gKE9/KpQRqCKufspTm2LpmtVyn0ZJSVCJZSJ5CO58qSRMa74rW5AfwB
	 B5soMw2usoooapZZ7PHYIbjUbur2Kox2JIxSUFE7u0Hi6Mp0aP0HvOWVVtvqCOVmow
	 J08+B4P2DUHVQ==
Date: Sat, 22 Mar 2025 23:43:12 +0200
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
Message-ID: <Z98u8BAMJKqUiojn@kernel.org>
References: <20250321164537.16719-1-bboscaccy@linux.microsoft.com>
 <Z97xvUul1ObkmulE@kernel.org>
 <CAHC9VhQ4a4Dinq+WLxM88KqJF8ruQ_rOdQx7UNrKcJqTpGGG+w@mail.gmail.com>
 <CAHC9VhSfPz4fYU-YxxQ++3OP_hqtiD=J9fJXyUHmcj8NHd1pZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSfPz4fYU-YxxQ++3OP_hqtiD=J9fJXyUHmcj8NHd1pZQ@mail.gmail.com>

On Sat, Mar 22, 2025 at 04:48:14PM -0400, Paul Moore wrote:
> On Sat, Mar 22, 2025 at 4:44 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Sat, Mar 22, 2025 at 1:22 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > On Fri, Mar 21, 2025 at 09:45:02AM -0700, Blaise Boscaccy wrote:
> > > > This patch series introduces the Hornet LSM.
> > > >
> > > > Hornet takes a simple approach to light-skeleton-based eBPF signature
> > >
> > > Can you define "light-skeleton-based" before using the term.
> > >
> > > This is the first time in my life when I hear about it.
> >
> > I was in the same situation a few months ago when I first heard about it :)
> >
> > Blaise can surely provide a much better answer that what I'm about to
> > write, but since Blaise is going to be at LSFMMBPF this coming week I
> > suspect he might not have a lot of time to respond to email in the
> > next few days so I thought I would do my best to try and answer :)
> >
> > An eBPF "light skeleton" is basically a BPF loader program and while
> > I'm sure there are several uses for a light skeleton, or lskel for
> > brevity, the single use case that we are interested in here, and the
> > one that Hornet deals with, is the idea of using a lskel to enable
> > signature verification of BPF programs as it seems to be the one way
> > that has been deemed acceptable by the BPF maintainers.
> >
> > Once again, skipping over a lot of details, the basic idea is that you
> > take your original BPF program (A), feed it into a BPF userspace tool
> > to encapsulate the original program A into a BPF map and generate a
> > corresponding light skeleton BPF program (B), and then finally sign
> > the resulting binary containing the lskel program (B) and map
> > corresponding to the original program A.
> 
> Forgive me, I mixed up my "A" and "B" above :/
> 
> > At runtime, the lskel binary
> > is loaded into the kernel, and if Hornet is enabled, the signature of
> > both the lskel program A and original program B is verified.
> 
> ... and I did again here
> 
> > If the
> > signature verification passes, lskel program A performs the necessary
> > BPF CO-RE transforms on BPF program A stored in the BPF map and then
> > attempts to load the original BPF program B, all from within the
> > kernel, and with the map frozen to prevent tampering from userspace.
> 
> ... and once more here because why not? :)

No worries I was able to decipher this :-)

> 
> > Hopefully that helps fill in some gaps until someone more
> > knowledgeable can provide a better answer and/or correct any mistakes
> > in my explanation above ;)
> 
> -- 
> paul-moore.com

BR, Jarkko

