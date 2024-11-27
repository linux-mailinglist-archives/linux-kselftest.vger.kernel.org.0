Return-Path: <linux-kselftest+bounces-22585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A189DAE2A
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 20:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 554A3B2298D
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 19:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBC8202F73;
	Wed, 27 Nov 2024 19:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgfloJGl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D684282D66;
	Wed, 27 Nov 2024 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732737217; cv=none; b=MH/Hjt8Bkqlw/szeR7Hyi9KFZuY3RZlG88iD5JAYrlUtdCt2hHkwUQUG9nDZstebP6WaPBapqTTZfE3k50LKHfpgiHFdw7gq1rOjusBkDjVqi5RhyCZea7QqMmWNE51PpNoL6o9h85Sbqvl6zrY1tLr1TL0tNH9qnx0bLAe4ueU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732737217; c=relaxed/simple;
	bh=jM4rouWICuoJdC1FcQYqeZzWPXGne3NLukzZ69xBI1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9AvI/kEcukJZItug5ERR4OqjKFuSKUcdDZSvv0qF6T1wYszfiX4QWSINgEyROj8U7mQ0o5erbbXWIO4r1EuGD7QRPLgl7nwxLO5TBVWUaA71PHDSb50lLs9L0eT6/u4ad3NF2ZAtFyBR5tROEZMjUkb7RVSTeWr8+7p+ZRyKUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgfloJGl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E82C4CECC;
	Wed, 27 Nov 2024 19:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732737216;
	bh=jM4rouWICuoJdC1FcQYqeZzWPXGne3NLukzZ69xBI1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FgfloJGlWT8hstYCPeq961S8wXnz/E6O6yBhrCEUKDZ0POh+uzdvEzMQ4nfma+ktQ
	 YC26F+wkrKoNmgLxF9AaNmKMAxwCExz/7AZNanPIKsCZK1NhNDmf3lr3sgNktwUhvq
	 K+mPH+MrP5klOkX0WGejyobVG16BVtJeVbKnNv2mbl4OLfDCNc7x/Eywqc00D0IkWM
	 pIbLQ2mZBduIHfGJbrU+KzEpfpGYMBbEW/mXmsROfjgocdYgZg9a+Rdi2sWTW64N64
	 VlBPCGjsmj6O395u9hSOWvK0MbK2M8FF2Cc6+FbroiVjhrtzO+9Gg4apK6uvWCFA7H
	 JCrkzjuWUD5QQ==
Date: Wed, 27 Nov 2024 11:53:33 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, corbet@lwn.net, petr.pavlu@suse.com,
	samitolvanen@google.com, da.gomez@samsung.com,
	akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, shuah@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, wufan@linux.microsoft.com,
	pbrobinson@gmail.com, zbyszek@in.waw.pl, hch@lst.de,
	mjg59@srcf.ucam.org, pmatilai@redhat.com, jannh@google.com,
	dhowells@redhat.com, jikos@kernel.org, mkoutny@suse.com,
	ppavlu@suse.com, petr.vorel@gmail.com, mzerqung@0pointer.de,
	kgold@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v6 07/15] digest_cache: Allow registration of digest list
 parsers
Message-ID: <Z0d4vXuCqjTo_QW1@bombadil.infradead.org>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
 <20241119104922.2772571-8-roberto.sassu@huaweicloud.com>
 <Z0UN9ub0iztWvgLi@bombadil.infradead.org>
 <d428a5d926d695ebec170e98463f7501a1b00793.camel@huaweicloud.com>
 <Z0Ybvzy7ianR-Sx9@bombadil.infradead.org>
 <3dc25195b0362b3e5b6d6964df021ff4e7e1b226.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dc25195b0362b3e5b6d6964df021ff4e7e1b226.camel@huaweicloud.com>

On Wed, Nov 27, 2024 at 10:51:11AM +0100, Roberto Sassu wrote:
> For eBPF programs we are also in a need for a better way to
> measure/appraise them.

I am confused now, I was under the impression this "Integrity Digest
Cache" is just a special thing for LSMs, and so I was under the
impression that kernel_read_file() lsm hook already would take care
of eBPF programs.

> Now, I'm trying to follow you on the additional kernel_read_file()
> calls. I agree with you, if a parser tries to open again the file that
> is being verified it would cause a deadlock in IMA (since the inode
> mutex is already locked for verifying the original file).

Just document this on the parser as a requirement.

> > > Supporting kernel modules opened the road for new deadlocks, since one
> > > can ask a digest list to verify a kernel module, but that digest list
> > > requires the same kernel module. That is why the in-kernel mechanism is
> > > 100% reliable,
> > 
> > Are users of this infrastructure really in need of modules for these
> > parsers?
> 
> I planned to postpone this to later, and introduced two parsers built-
> in (TLV and RPM). However, due to Linus's concern regarding the RPM
> parser, I moved it out in a kernel module.

OK this should be part of the commit log, ie that it is not desirable to
have an rpm parser in-kernel for some users.

  Luis

