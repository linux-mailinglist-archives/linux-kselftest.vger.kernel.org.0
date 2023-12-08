Return-Path: <linux-kselftest+bounces-1434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2810B80A71B
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 16:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E2E1F214F9
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 15:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE802C187;
	Fri,  8 Dec 2023 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Urb7F/kI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8194A1706;
	Fri,  8 Dec 2023 07:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R35glQOGU4B0yR33HDpJFKOjzNBBa5sMO4yfY0YOJxs=; b=Urb7F/kIqU3YnTZAoccPn2bO2+
	q2hbXOFx8mmv+dghxtqjzkSNZ2c12hs35s+7mvojrvbNE/3pDv36aUANNXyvU58M23xhkCzJUS1FR
	S7jxMn6ur/edEUljTKC6sOLqLIEsENqT6RljN36xWH3STUpTeMWnhQV6UcPLmFuzGLQiBqCraPXVp
	cbDPPlTXGQrnUvSonVWM5h1ZgU3d18O3WJtOk6R6Ozv4Dv0zeCv3BNG5kCaJLoo5e3rsA12YjxwRN
	9T1zqbN1AZYAQfGZ3zb5sntIy9H2P0QV75N8HpgEdtm73hrcjk5klcnltx0GGEPxnyd4HOIK3vXvd
	3ykyfbMA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rBcYE-006cfM-3B;
	Fri, 08 Dec 2023 15:14:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E36073003F0; Fri,  8 Dec 2023 16:14:01 +0100 (CET)
Date: Fri, 8 Dec 2023 16:14:01 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 11/11] selftests: error out if kernel header files are
 not yet built
Message-ID: <20231208151401.GG28727@noisy.programming.kicks-ass.net>
References: <20230606071637.267103-1-jhubbard@nvidia.com>
 <20230606071637.267103-12-jhubbard@nvidia.com>
 <20231103121652.GA6217@noisy.programming.kicks-ass.net>
 <a002f903-723f-40ae-8d7a-421ab2e082e2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a002f903-723f-40ae-8d7a-421ab2e082e2@redhat.com>

On Fri, Nov 03, 2023 at 01:22:54PM +0100, David Hildenbrand wrote:
> On 03.11.23 13:16, Peter Zijlstra wrote:
> > On Tue, Jun 06, 2023 at 12:16:37AM -0700, John Hubbard wrote:
> > > As per a discussion with Muhammad Usama Anjum [1], the following is how
> > > one is supposed to build selftests:
> > > 
> > >      make headers && make -C tools/testing/selftests/mm
> > > 
> > > Change the selftest build system's lib.mk to fail out with a helpful
> > > message if that prerequisite "make headers" has not been done yet.
> > > 
> > 
> > NAK NAK NAK
> > 
> > This now means I can no longer run selftests, I thank you very much! :-/
> > 
> > root@spr:/usr/src/linux-2.6# make O=defconfig-build/ -j64
> > make[1]: Entering directory '/usr/src/linux-2.6/defconfig-build'
> > ***
> > *** The source tree is not clean, please run 'make mrproper'
> > *** in /usr/src/linux-2.6
> > 
> > 
> > I've always done:
> > 
> >    cd tools/testing/selftests/x86; make
> > 
> > and that has always worked
> > 
> > Now I can't bloody well build *any* selftest or risk not being able to
> > do builds.
> 
> This change landed in 6.5, no? And 6.6 was just released. Just curious why
> you notice that now.

And I hit it again (different box etc..)

Can we please get this garbage fixed already?

