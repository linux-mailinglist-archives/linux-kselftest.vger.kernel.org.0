Return-Path: <linux-kselftest+bounces-26318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAD3A3014A
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 03:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECE58161FC2
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 02:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F2617C91;
	Tue, 11 Feb 2025 02:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eryJ62hY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A40126BD85;
	Tue, 11 Feb 2025 02:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739239558; cv=none; b=u3z9JVf94Knug6R3E2VJNY2yEotwemgX8aKDVFr2wF2GIp3hgdWo1Rp43ULPJcndZHlP9JeiKG/n5i9LnKyvlIc1nIMQlwexBeF+XXBX2xxBqhKNDxB+lk3CZJlMjQVGp7DR7KPsCdLijha5C4/j7bhyKY2Ag9gIjzX/YKQdSJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739239558; c=relaxed/simple;
	bh=5Fp9R0gFCKQLKh860i/FrZ5xiDeTgU5wB7XiGWA1vZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjRBLER0k9QdKPA7HHxsf+Fd5hsbQdMAgZIULZr520bIwSWT/eyHNGPjx3OHti3PyhGlBP5CO9pI5/NOozk5SonLd296F1bR7Pf/5bqp8/ncJCXss3AEjQMCmwObqtxEZ+/Mq73/7Mma4QniVPUgRGtIeAqYkiTu4Yxz/a3/c10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eryJ62hY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4ABC4CED1;
	Tue, 11 Feb 2025 02:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739239558;
	bh=5Fp9R0gFCKQLKh860i/FrZ5xiDeTgU5wB7XiGWA1vZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eryJ62hYUtI7mrWuBEMRhhoHJTt8s2gbdMMrGS9RtKjf/ykmNdVdkLwye8AmhVwLN
	 u4sKnMro55dbumfs/vccXp1vq/LbrUPwBU+Pu79/TlhHeKOI2uQ3SiZP7vq0wY5/zW
	 F92zjOEzWtLqhyBfdANopH++UqLt/+oZjsPyEUAck665EXSNhXVhnkZ2qpkIihOv9l
	 bT991oQ5+9BZQK+L5OnJlzKJvbFXf+gFafFbmR3XMP39O8iHdUCw5YzoemKVjx31CW
	 S8iPWeVhC2v6eBR6F6BisaPYdidUf8kKqGkF75V7f0Gr6PJGm12vRQb9q9bh/ASwco
	 tth03cqLTl1BQ==
Date: Mon, 10 Feb 2025 18:05:57 -0800
From: Kees Cook <kees@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Gow <davidgow@google.com>,
	Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	Nicolas Pitre <npitre@baylibre.com>, Rae Moar <rmoar@google.com>,
	Pedro Orlando <porlando@lkcamp.dev>,
	Danilo Pereira <dpereira@lkcamp.dev>,
	Gabriela Bittencourt <gbittencourt@lkcamp.dev>,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Diego Vieira <diego.daniel.professional@gmail.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Bruno Sobreira =?iso-8859-1?Q?Fran=E7a?= <brunofrancadevsec@gmail.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH v2 0/6] KUnit test moves / renames
Message-ID: <202502101805.2D6F62A10@keescook>
References: <20250211002600.it.339-kees@kernel.org>
 <20250210171124.9917819a078c16c6442480a7@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210171124.9917819a078c16c6442480a7@linux-foundation.org>

On Mon, Feb 10, 2025 at 05:11:24PM -0800, Andrew Morton wrote:
> On Mon, 10 Feb 2025 16:31:28 -0800 Kees Cook <kees@kernel.org> wrote:
> 
> > This is rebased to v6.14-rc2. I'll carry it and folks can send me new
> > tests, etc, as needed to minimize future collisions.
> 
> Actually seems designed to maximize collisions.

Eek, that's not my intent!

> I'll drop ("lib/math: add Kunit test suite for gcd()")
> https://lore.kernel.org/all/0eaf6b69aeb2fe35092a633fed12537efe645303.1727332572.git.zhengqi.arch@bytedance.com/T/#u.

I will pick that up?

-- 
Kees Cook

