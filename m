Return-Path: <linux-kselftest+bounces-16125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44E095C239
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 02:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7216528215D
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 00:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97481171A5;
	Fri, 23 Aug 2024 00:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQAvZtuz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F8712B6C;
	Fri, 23 Aug 2024 00:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724372296; cv=none; b=jZGNaZfwXQr9bBeu+8bsthj02cQOsSHoqfcZaqgiB28vAH+QYsMKXwWD1ZJYsR6syMMnI92l6H21xota+lfM3Z6v1b6btEX/rFzI1j/HC29X10avDdxTgYgX+OtdcL+4PJPvDHBEunIgGfXjbNxsnWS8YaRyqWsx98dSoJ7qrvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724372296; c=relaxed/simple;
	bh=2HVUjJT8ysAAiOf7lEZcT9lCdiA5BBbCXrDdPmIUcNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoTxT0emSmSo/7CLKJ6rOvUmHFOk1BwnLWl7au2nSuzzCR4f37HvHV0dRQGFt36lLAfGjAExSQE2lA5y1CurytB6hH3tkRvOgiInAhWY/Iw66cg2yI/zwxjzSIHZHRZQvfWT9ZNbi2zjFeWE+tZ1DDH+iO8m2MPQE43Wc0Jd7zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQAvZtuz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434A5C4AF09;
	Fri, 23 Aug 2024 00:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724372296;
	bh=2HVUjJT8ysAAiOf7lEZcT9lCdiA5BBbCXrDdPmIUcNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PQAvZtuzpNYxB2uELf0d5qDY3obDWfFhPA0o45PDaSrQD3a8FQYcWes6DKm7l1XEF
	 VR2Rfe6xpQ31NRd3yHh3tdCi8OixGO+Ewj19j91vYid1HQ7nSaiFoIbIrQbAwuNrfU
	 omAQI3dNoZ4qpnc7NLt+wN/rw0BBaVbKtuXVeD5NhLJLpvcTOL0+vxVfVryVgxTqKL
	 t1sTZC8e842HNFwELMwFhVuhAtjrwbEDNnPd4b4NvJsjexeveJW1HhsJeha55320Pi
	 vezfQflMJ9wzQpd1AmvQHjsJMoPwbi2Nf4W+nK5vrSvu42XfAaCFEAjopzRQYffii5
	 w9v0VgIxCEEcQ==
Date: Thu, 22 Aug 2024 17:18:15 -0700
From: Kees Cook <kees@kernel.org>
To: David Gow <davidgow@google.com>
Cc: John Hubbard <jhubbard@nvidia.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] Documentation: KUnit: Update filename best practices
Message-ID: <202408221717.1138DB3D1C@keescook>
References: <20240724201354.make.730-kees@kernel.org>
 <CABVgOSmXqv_+20OKjVAPJoqrP1EvBk+1WUqF4wBsefegxYNiWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSmXqv_+20OKjVAPJoqrP1EvBk+1WUqF4wBsefegxYNiWA@mail.gmail.com>

On Fri, Jul 26, 2024 at 03:14:36PM +0800, David Gow wrote:
> On Thu, 25 Jul 2024 at 04:14, Kees Cook <kees@kernel.org> wrote:
> >
> > Based on feedback from Linus[1] and follow-up discussions, change the
> > suggested file naming for KUnit tests.
> >
> > Link: https://lore.kernel.org/lkml/CAHk-=wgim6pNiGTBMhP8Kd3tsB7_JTAuvNJ=XYd3wPvvk=OHog@mail.gmail.com/ [1]
> > Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> 
> Looks good to me. (And it seems like sphinx is okay with it, too,
> which is always nice.)
> 
> We normally take these changes in via the kunit tree, but if you want
> to try to push it through along with the naming changes, that's fine
> by me.
> 
> Reviewed-by: David Gow <davidgow@google.com>

Hi! Just a quick check: I haven't seen this land in -next yet. Are you
still planning to take this?

-- 
Kees Cook

