Return-Path: <linux-kselftest+bounces-1460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1A480AF74
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 23:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03831C20AC1
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 22:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E5C54657;
	Fri,  8 Dec 2023 22:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FGvjnfZ7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892B0171D;
	Fri,  8 Dec 2023 14:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/0Qz43yXWHKRpnVXenO5RhbNzM7+gVncZQ63SMwE3i4=; b=FGvjnfZ7+Por6qLX7oGRUbZTeQ
	I0DhdI59LFdS83KUNARfpVoB+NROGqZhSY3HVXg+Y+Rk5vz82vI++nvPojoocbk1Y5foyoi2CsFFk
	m1nr7LWznGR+iTy0g+3uD3GMwKRciZ16K8R+/iSMbk0x3FBdU8o0NKH9PEzPl/p6/cYh/t3O1PLcg
	d0Y2znNuzkjlkSqx4MBusJPC3X/nUn0pWmcJUTUhUtNlsA5TTkEr3qrLJfq/m3D06BD5xtJ0XoZXY
	nXrMxljNFpzAr10nWbH7zGfxOeNK8ax6cLAgGb1tx4fTva0JyTouSkV9HlNDWd/Ggq+3yHez0eDnS
	7yuK3HfA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rBj2u-006fJt-EM; Fri, 08 Dec 2023 22:10:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 76E993003F0; Fri,  8 Dec 2023 23:10:07 +0100 (CET)
Date: Fri, 8 Dec 2023 23:10:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>,
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
Message-ID: <20231208221007.GO28727@noisy.programming.kicks-ass.net>
References: <20230606071637.267103-1-jhubbard@nvidia.com>
 <20230606071637.267103-12-jhubbard@nvidia.com>
 <20231103121652.GA6217@noisy.programming.kicks-ass.net>
 <a002f903-723f-40ae-8d7a-421ab2e082e2@redhat.com>
 <20231208151401.GG28727@noisy.programming.kicks-ass.net>
 <990feea2-c7a8-4cd9-8a6a-bc4bc1c2ffab@redhat.com>
 <c54b4059-e3a7-40bd-84dc-013dc3b15c65@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c54b4059-e3a7-40bd-84dc-013dc3b15c65@nvidia.com>

On Fri, Dec 08, 2023 at 12:29:37PM -0800, John Hubbard wrote:

> I don't have a strong opinion about how this should be done, and in
> fact I believed at the time that I was bringing the system into
> compliance with what everyone wanted here. :)
> 
> There seem to be two conflicting visions:
> 
> a) The way it was (much) earlier: use ifdefs and defines to get by
> without the latest kernel headers, or
> 
> b) Requiring recent kernel headers to build the various selftests.
> 
> Shuah, Peter, others: can we choose a direction please? Either
> way will work, and I personally don't care which one we choose.

So as David already argued, the current thing does not in fact help with
b. You just have to install once and the error goes away, then carry
that tree for a year and you're running old crap again.

My biggest beef with the whole thing is that I simply do not want to use
'make headers', it doesn't work for me.

I have a ton of output directories and I don't care to build tools into
the output dirs, in fact some of them flat out refuse to work that way
(bpf comes to mind).

