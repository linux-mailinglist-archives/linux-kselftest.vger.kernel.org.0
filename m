Return-Path: <linux-kselftest+bounces-19555-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3A799A9CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 19:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E2A1F22734
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 17:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAA61C32FF;
	Fri, 11 Oct 2024 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4ucttWL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A6D1C2439;
	Fri, 11 Oct 2024 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728667235; cv=none; b=Xh70047aoACdAo3Syz5Nc0bWMHRK1cHddzOpihnlWimDfbFrQolNIxGLXhMBzfZvTb/NZ9ePiz4SWMmtMtUfd/wjYNA2wy77Tr+SWjOGgFudBY9qD5kCsYXHrsbzAuaSwkcHsBOthPKBL6KLAN1gGfkbP6Bgz9XIAeYIpvOjbrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728667235; c=relaxed/simple;
	bh=ct5mcVL1s3VFUw/Gqyz+JTWhmBjEfAb+VOBWtRXjerw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYB6XHNLXQb+svHcYdx2hNWROscBl5Wq8YyPxHV5KtFe5p2ssLy6Pa9hTGN/A9j1xQxBJA02RH/7zmfQRexqZc2kEimENg0elewcP3R1nVjuAIoRnYOVY1IVzsWir/aTtHFsbtR7LFfWtftebJAYAn/RQ1/QozWgLokSNs1zRRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4ucttWL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2F8C4CED0;
	Fri, 11 Oct 2024 17:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728667235;
	bh=ct5mcVL1s3VFUw/Gqyz+JTWhmBjEfAb+VOBWtRXjerw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k4ucttWLgcPBfZaTKf/cK3yy05UHRJs/T2ZxEIvnMUY265p5hBbHt2T+wMChA6tCF
	 DkewU/dL6da5oyvv4VO7zyT4A+B7j36k+leRwXJIBdjm/C614g3A0mV9NA3HM0Uljv
	 ErU5X6x/vXcoLMNxCFrddWBzkxEaE+INeZH573hVPMMD+/ThUGQWyMmj/R+UwZycBq
	 pFjnQ7tpZJdZvDrNK8IDtyu3Q0+W48kx0v/FVKl1136h7eTe78rGQWA4ME1Pn7mZd/
	 UrLD/yNSZOm6/4Ler4EpHqylSITNVoJXCKsk+mZ3UF5c0C6uVf7oMqRoz7XSmw6923
	 RnseI8NGQz2sw==
Date: Fri, 11 Oct 2024 10:20:32 -0700
From: Kees Cook <kees@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Andy Shevchenko <andy@kernel.org>,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Brown <broonie@kernel.org>, linux-hardening@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Daniel Latypov <dlatypov@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	David Howells <dhowells@redhat.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Fangrui Song <maskray@google.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: Re: [PATCH 3/6] lib: Move KUnit tests into tests/ subdirectory
Message-ID: <202410111020.0DB6E2BC1@keescook>
References: <20241011072509.3068328-2-davidgow@google.com>
 <20241011072509.3068328-5-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011072509.3068328-5-davidgow@google.com>

On Fri, Oct 11, 2024 at 03:25:07PM +0800, David Gow wrote:
> From: Kees Cook <kees@kernel.org>
> 
> Following from the recent KUnit file naming discussion[1], move all
> KUnit tests in lib/ into lib/tests/.

Thanks for picking this up! I hadn't had time to resend it. :)

-- 
Kees Cook

