Return-Path: <linux-kselftest+bounces-22608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E226D9DBCFA
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 21:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70AB28216F
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 20:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957C31C3F04;
	Thu, 28 Nov 2024 20:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhhvfBS6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F981C1F1B;
	Thu, 28 Nov 2024 20:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732826438; cv=none; b=Z3D7C56CVQUZLN2r0/Z50nVvQGwqAom3T6LKwrtp07l+lt+SI7kVTHqMFU7cGicvyok2RhUMA/xiiMea7r9DzKiWuVG8ZP63bopAE8C/BNXVnXlueijyNN4//M9VI8UUTR4Znk6mlt8jYxTkyZxVUOASV8xuE/PfV2oGDVFxbU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732826438; c=relaxed/simple;
	bh=GAU8BbRYLHftQhaL0pvmhJwvc4IRJK26C1UPU2J5EJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaCbK2NYR6AYbB34c46jJceCfPT4rU/BZywO7L0OdOZbaq4VAajMe7b51QZvUc+S6ijJ9co31jS0YgNPjcnW32d80Z04RxrR/oaE1ASqZP0Z2227KVU+e2zO3DDbTTkDUxMUXU3crLHgedvY0QvcEHN8peC2RsSqJDwkjaJ0VEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhhvfBS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14D4C4CECE;
	Thu, 28 Nov 2024 20:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732826437;
	bh=GAU8BbRYLHftQhaL0pvmhJwvc4IRJK26C1UPU2J5EJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QhhvfBS6wBt1GNJnXrIEba+0KcsznIA8Za4PUFxbwwl5OyUT6pCDQjOT0GxO90lUI
	 NhbsgzxeDijKjyJkxWiLn2JMtiDGmXsKAWk0DZB6KR/OEeC9yNBtER5JIr8n0a7cht
	 GGAMkVLGkSLGXTeu6RpzFNw1/NoiptaGopZrv/rrEM1aIeuB+G+/hkPzs74ld1llmV
	 XP9Qdq8OMTUjiVPcGNSU5n8fpGqdKadp/zrpd52hrtzUyC0S15MbpIKXmN+GnmI04S
	 B72xbbV1S8NUycq/X5VVJZKzNBVcaj16EoqwksRJdPkp4vPGUSIadYi5UotGLWkeyy
	 fVDpXdvDABr7Q==
Date: Thu, 28 Nov 2024 12:40:35 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, mmaurer@google.com,
	samitolvanen@google.com, KP Singh <kpsingh@kernel.org>
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
Message-ID: <Z0jVQ8Q7AT_9NodI@bombadil.infradead.org>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
 <20241119104922.2772571-8-roberto.sassu@huaweicloud.com>
 <Z0UN9ub0iztWvgLi@bombadil.infradead.org>
 <d428a5d926d695ebec170e98463f7501a1b00793.camel@huaweicloud.com>
 <Z0Ybvzy7ianR-Sx9@bombadil.infradead.org>
 <3dc25195b0362b3e5b6d6964df021ff4e7e1b226.camel@huaweicloud.com>
 <Z0d4vXuCqjTo_QW1@bombadil.infradead.org>
 <10c8fd4b53f946c2d7e933a35c6eb36557e8c592.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10c8fd4b53f946c2d7e933a35c6eb36557e8c592.camel@huaweicloud.com>

On Thu, Nov 28, 2024 at 09:23:57AM +0100, Roberto Sassu wrote:
> On Wed, 2024-11-27 at 11:53 -0800, Luis Chamberlain wrote:
> > On Wed, Nov 27, 2024 at 10:51:11AM +0100, Roberto Sassu wrote:
> > > For eBPF programs we are also in a need for a better way to
> > > measure/appraise them.
> > 
> > I am confused now, I was under the impression this "Integrity Digest
> > Cache" is just a special thing for LSMs, and so I was under the
> > impression that kernel_read_file() lsm hook already would take care
> > of eBPF programs.
> 
> Yes, the problem is that eBPF programs are transformed in user space
> before they are sent to the kernel:
> 
> https://lwn.net/Articles/977394/

That issue seems to be orthogonal to your eandeavor though, which just
supplements LSMS, right?

Anyway, in case this helps:

The Rust folks faced some slighty related challenges with our CRC
validations for symbols, our CRC are slapped on with genksyms but this
relies on the source code and with Rust the compiler may do final
touches to data. And so DWARF is being used [1].

Although I am not sure of the state of eBPF DWARF support, there is also
BTF support [0] and most distros are relying on it to make live introspection 
easier, and the output is much smaller. So could DWARF or BTF information
from eBPF programs be used by the verifier in similar way to verify eBPF
programs?

Note that to support BTF implicates DWARF and the leap of faith for Rust
modversions support is that most distros will support DWARF, and so BTF
can become the norm [2].

[0] https://www.kernel.org/doc/html/latest/bpf/btf.html
[1] https://lwn.net/Articles/986892/
[2] https://lwn.net/Articles/991719/

  Luis

