Return-Path: <linux-kselftest+bounces-37470-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D1BB084D7
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 08:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909C216FA33
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 06:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D16C2153FB;
	Thu, 17 Jul 2025 06:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvL6y+Aw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3573B19D09C;
	Thu, 17 Jul 2025 06:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752733437; cv=none; b=u+srtToLaYAkaBgTfjyuFAx/1+WqlVRIEYZVLEpBdbMnfyUtZr7mMpz4cgs6yETemlj6I23dTI+a+QtNR98uue3c8TwATdO8SZNnFksYdOTocMU4HBuyZDlUo1z+yEWNDotialGK+v/XCrHYYKcQxa3Msj6mUFj8pKBG4sj5eRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752733437; c=relaxed/simple;
	bh=grCqqOhvrUeiogwwXn1hgC2+UR2PNKwWKTQf5JysCHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/uU5ZVsHzrT+ma430T9KDrxvqhGEgxrreCrAE4iiO+LDb+1sskKztNMdw8eQ+2UWhGSY4XLxZqtX4V/E5fZMEKhVN6D4aSgu1lyt2U5nDJW4ekjDNS7PzGvJ5hxHTmPkVbHijX+ht90BnikO9w1AdtCFpAt0X/S4B6oZ4hYvRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvL6y+Aw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B466BC4CEE3;
	Thu, 17 Jul 2025 06:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752733436;
	bh=grCqqOhvrUeiogwwXn1hgC2+UR2PNKwWKTQf5JysCHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OvL6y+AwE70BcSEKYDbamLABzepC1/VOf94wmaIIwzg+54NZsU5s805mYUHt5+qjP
	 AhVzcvjfopmhh6biXMWf1agj3s1/aznjxnPwIViG/GyS8Hhf5qgg1jGppszDmefFBp
	 5ZyvGF8Mb3bjVy9MKcOtpW4hN6qjRAYaZBTDo8IrOW7QN+AyCywGTe3k2lv6WvvBew
	 UoZV9XXTMR5BVrw5hYd8LbKcYCjFIMvAqkM+YEsAe0G0mXVzQXIMfFoC1e4FF8ARCz
	 MwM5X2erYpFRgbsvw54xmJHKTebVdUzFpeArnvdFo9ZroFWZcHvh2bHxyW6qq1q3iW
	 tAO54/U6NLGCw==
Date: Wed, 16 Jul 2025 23:23:56 -0700
From: Kees Cook <kees@kernel.org>
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH v4 2/6] binder: Store lru freelist in binder_alloc
Message-ID: <202507162323.8A11B97@keescook>
References: <20250717011011.3365074-1-ynaffit@google.com>
 <20250717011011.3365074-3-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717011011.3365074-3-ynaffit@google.com>

On Wed, Jul 16, 2025 at 06:10:05PM -0700, Tiffany Yang wrote:
> Store a pointer to the free pages list that the binder allocator should
> use for a process inside of struct binder_alloc. This change allows
> binder allocator code to be tested and debugged deterministically while
> a system is using binder; i.e., without interfering with other binder
> processes and independently of the shrinker. This is necessary to
> convert the current binder_alloc_selftest into a kunit test that does
> not rely on hijacking an existing binder_proc to run.
> 
> A binder process's binder_alloc->freelist should not be changed after
> it is initialized. A sole exception is the process that runs the
> existing binder_alloc selftest. Its freelist can be temporarily replaced
> for the duration of the test because it runs as a single thread before
> any pages can be added to the global binder freelist, and the test frees
> every page it allocates before dropping the binder_selftest_lock. This
> exception allows the existing selftest to be used to check for
> regressions, but it will be dropped when the binder_alloc tests are
> converted to kunit in a subsequent patch in this series.
> 
> Acked-by: Carlos Llamas <cmllamas@google.com>
> Signed-off-by: Tiffany Yang <ynaffit@google.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

