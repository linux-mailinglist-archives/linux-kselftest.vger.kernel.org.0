Return-Path: <linux-kselftest+bounces-28534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31897A5785B
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Mar 2025 05:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652A3176519
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Mar 2025 04:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCFE17A313;
	Sat,  8 Mar 2025 04:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fdu7wRuM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8509E182CD;
	Sat,  8 Mar 2025 04:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741409515; cv=none; b=cJMSVkH6TrbMLWrkVbkmDBY/+4FoUlzihn5BWo5C1NQJ4lfbXlSSfNoin25oxkFkQsMZkD2bGz0F/fWcyalaMbPmF2gc3AqTsEQzTO03CD5JsiKbHAgdzUiTMiW0W7/Na+wO9E+nSFt6l5IEU6G4+FIOq1eZiouSuUTLlr/vNEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741409515; c=relaxed/simple;
	bh=yixqUdJLX3fxBfaChgOIVmCPqXedAmvEv7BDqYj4+L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Df/JLgahZnnDwnT+rBF97FS0IVoJcIxWSEAK257DxVt2q/RDqp1ACtfI+cm4JOr9B+b/2E/nLAGB+VPtpMOxNo2AXOR6Rf4IXxwZRBJt8JXmliaNqOFgB53g0wNS08bBq4SCxdGLJ+15NU2AK0OdgYVXholJX1j9cRznTjqutzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fdu7wRuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF96C4CEE0;
	Sat,  8 Mar 2025 04:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741409515;
	bh=yixqUdJLX3fxBfaChgOIVmCPqXedAmvEv7BDqYj4+L8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fdu7wRuMUl5b9wm6ziCwGa4GLuNSUQBd/6fy1pwDf0qZZ9w31EMW4PKL5zmyimpIg
	 cSFuu6D7iEg0mRIlWchG0xkvTEtDeTmwWT3sq+IOW0eUNlnl5uR66kpGi5tDyaulfP
	 bvAEzzRyZhCnsvKgOXPs6dt2f6YkE/VZIwdVpv0bWdRvLvGSJtqILCx1ZNcej/Bqjs
	 H+bS4X+E72WQTH0XhFkooFf2quUY3VRwLPKAPYY33a7HlOi3edAOG9XhfbkphSnl/N
	 uDmF62+8+cyociEaGr3NQ7n1qjAUD3jDlzrc3cmaFOtnv7PP6DIWEeJcp8fB+Jhwq+
	 2JpW4IoauhwCg==
Date: Fri, 7 Mar 2025 20:51:52 -0800
From: Kees Cook <kees@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 0/2] scanf: convert self-test to KUnit
Message-ID: <202503072051.6CC5F0E682@keescook>
References: <20250204-scanf-kunit-convert-v3-0-386d7c3ee714@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204-scanf-kunit-convert-v3-0-386d7c3ee714@gmail.com>

On Tue, Feb 04, 2025 at 02:25:54PM -0500, Tamir Duberstein wrote:
>  lib/scanf_kunit.c                    | 800 ++++++++++++++++++++++++++++++++++
>  lib/test_scanf.c                     | 814 -----------------------------------

If you can rebase this on -next and folks Ack it, I can carry this in
the "lib/ kunit tests move to lib/tests/" tree.

-Kees

-- 
Kees Cook

