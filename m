Return-Path: <linux-kselftest+bounces-27264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF541A40933
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 15:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3B4517D6B8
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 14:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A3713AA20;
	Sat, 22 Feb 2025 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIZkJLAI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61FE4207A;
	Sat, 22 Feb 2025 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740235552; cv=none; b=f630EwWziIilPBgMbnWRxmubwqD4W1DGv+C5nEIBdzq0RYygvgD1WyJRUFX08hfC2jHJZ0bBhRFrtjCoULF9RSb8s3HFa3nR1OhJVQg5IyHvqmJIzt+1a3N1jUjB1GBtMKyj6K8VB6FinQ66HtwCQV6WN78FMq/LBSzloZDoung=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740235552; c=relaxed/simple;
	bh=OkFGj/9nMJzmMfPxfNzPnWPh4YI/vfWiImjcZu17aBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3gT21vXgETLkgUFx8DU5R7pn/Mgc0PVXQ4LGAugYSeyYwhAaahhN3nrWbD1uGJHt2h/su3E/xSJBWYfgmmxbCUg2iE4JKdKJgiNk7y9pF16cKgnknIv78y0ovyh+cX5pZXyQeAaRkmjzWN6EbyZMfA2HFzw3hN9BLThkBK2mQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIZkJLAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D22C4CED1;
	Sat, 22 Feb 2025 14:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740235552;
	bh=OkFGj/9nMJzmMfPxfNzPnWPh4YI/vfWiImjcZu17aBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JIZkJLAI+KxUTboLRKIte9+mIaN8L1uNDHYlAhuEfiC+LtKJS9X7FbY6y+BEM0zMn
	 o58+nWOSFzCwA4ziKK5nJeBETRj7XpLh9RfBoR0a2VX0e6NqDKmZmFnn/LmDQZc2ck
	 MLGvROLrE3ZePpur5ybAoAjo3vyDdUbFhv8UYRCkNA8eC81jMvrxhz35lQZXAVVgi6
	 sUPP82HpvAea0KeS6tQ5TUPZRJmZ3ae8tN+BrE7oosW89U3BTJM5zW3zybLrCNqPpd
	 fjozgP4SL71W6PqgECLCp8HBfsoDOu3RIoQtiCRYYvIoxLBrZWrzid6HoFR+9jxGs+
	 8DBAWuXu22Ocg==
Date: Sat, 22 Feb 2025 06:45:48 -0800
From: Kees Cook <kees@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, oliver.sang@intel.com,
	oe-lkp@lists.linux.dev, lkp@intel.com
Subject: Re: [PATCH] selftets: lib: remove reference to prime_numbers
Message-ID: <202502220644.94FD6D25@keescook>
References: <20250217-fix-prime-numbers-v1-1-eb0ca7235e60@gmail.com>
 <174018582427.3369509.6023266709728991391.b4-ty@kernel.org>
 <CAJ-ks9n6s_nUzZ5NxLFuySskKCEf0cEXht1R0uP0iF2BN_4ZSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9n6s_nUzZ5NxLFuySskKCEf0cEXht1R0uP0iF2BN_4ZSg@mail.gmail.com>

On Fri, Feb 21, 2025 at 08:04:05PM -0500, Tamir Duberstein wrote:
> On Fri, Feb 21, 2025 at 7:57 PM Kees Cook <kees@kernel.org> wrote:
> >
> > On Mon, 17 Feb 2025 08:30:44 -0500, Tamir Duberstein wrote:
> > > Remove a leftover shell script reference from commit 313b38a6ecb4
> > > ("lib/prime_numbers: convert self-test to KUnit").
> > >
> > >
> >
> > I fixed the Subject typos and applied to for-next/move-kunit-tests,
> > thanks!
> >
> > [1/1] selftets: lib: remove reference to prime_numbers
> >       https://git.kernel.org/kees/c/03d0e920d775
> >
> > Take care,
> >
> > --
> > Kees Cook
> >
> 
> Looks like you traded one typo for another ("selftestss"). :)

Hah! Ugh. Thanks for checking. I've fixed it harder now. :)

-- 
Kees Cook

