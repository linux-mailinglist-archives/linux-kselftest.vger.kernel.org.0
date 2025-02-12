Return-Path: <linux-kselftest+bounces-26489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 253F8A331D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 23:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D849716829F
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 22:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB64200BB5;
	Wed, 12 Feb 2025 22:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEYVcxBG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F521EBA0C;
	Wed, 12 Feb 2025 22:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739397673; cv=none; b=DQoGLHF1iwZfUBviuRK4g7A3IOgvW4PVcrLkOZSLLWWOjxI4ap88FR/FC06cE3zUkkoMA1IL6ThHpyYwpgoLkp7EDgwnQiiVmC8SNsrBSQdFZbSaglKm6RcumfpMCqSW8WvyDQShljRm1hl/5/DznJoxzQHAUieoED1QQkH74jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739397673; c=relaxed/simple;
	bh=JsxQrQLoRzxEnInmKjF+mVhcdpr1cU7XFb9bT5+5QDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lvi07/qHuPM2NaG9XIleWlDw3gms1aoq+1Pe/F7h5ca2w2NuXT0XLQcmh0h/SFnVzM0a9x4+lE07jukUQmE+ryxkDkGJSjo1FFbs3q+29kjg6+RLMF+a8i5QGOCD6orYQWm0RVD1OlNpZ/CylaaoCkYA6dqndkNf8haX4QSYlVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEYVcxBG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85B0C4CEE4;
	Wed, 12 Feb 2025 22:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739397672;
	bh=JsxQrQLoRzxEnInmKjF+mVhcdpr1cU7XFb9bT5+5QDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nEYVcxBGLr5QfQfMsR8ytHEOK7NGL6+RTqamyfq6va4w3fwRD5yBZWliHFQnqSa/Z
	 UteO0Wl/RFveNURpAQzq6efcNHz2tqggnnEyKL89LtOYR7qviSxSmG0HEKKnOzX4Lo
	 da4r+r4oBXNwZFtoVBOMU947NeYhFGKHBWkLy9NfmIQYWIfQsbvDQo3LnPPaRxgcUV
	 4NlFUrN7nnvZ0omISHMc7w2rD+2A6VjCYh9T7WhETIBtSS126uJ878t1KXyqibdAoM
	 aLdIoazYcBsb+C4Xtom/n8W/gbsof7O7sljgZ8uW24a1aelvXS9b4EhOUrF+9XZFD9
	 R4t70Vw+S7DoQ==
Date: Wed, 12 Feb 2025 14:01:12 -0800
From: Kees Cook <kees@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: David Gow <davidgow@google.com>,
	Gabriela Bittencourt <gbittencourt@lkcamp.dev>,
	Pedro Orlando <porlando@lkcamp.dev>,
	Danilo Pereira <dpereira@lkcamp.dev>,
	Shuah Khan <skhan@linuxfoundation.org>, Rae Moar <rmoar@google.com>,
	Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	Nicolas Pitre <npitre@baylibre.com>,
	Diego Vieira <diego.daniel.professional@gmail.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Bruno Sobreira =?iso-8859-1?Q?Fran=E7a?= <brunofrancadevsec@gmail.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v2 6/6] unicode: kunit: change tests filename and path
Message-ID: <202502121400.EEDE42C8@keescook>
References: <20250211002600.it.339-kees@kernel.org>
 <20250211003136.2860503-6-kees@kernel.org>
 <87pljnw4r1.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pljnw4r1.fsf@mailhost.krisman.be>

On Wed, Feb 12, 2025 at 10:40:34AM -0500, Gabriel Krisman Bertazi wrote:
> Kees Cook <kees@kernel.org> writes:
> 
> > From: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
> >
> > Change utf8 kunit test filename and path to follow the style
> > convention on Documentation/dev-tools/kunit/style.rst
> >
> > Co-developed-by: Pedro Orlando <porlando@lkcamp.dev>
> > Signed-off-by: Pedro Orlando <porlando@lkcamp.dev>
> > Co-developed-by: Danilo Pereira <dpereira@lkcamp.dev>
> > Signed-off-by: Danilo Pereira <dpereira@lkcamp.dev>
> > Signed-off-by: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
> > Reviewed-by: David Gow <davidgow@google.com>
> > Acked-by: Gabriel Krisman Bertazi <krisman@suse.de>
> > Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> > Reviewed-by: Rae Moar <rmoar@google.com>
> > Link: https://lore.kernel.org/r/20241202075545.3648096-7-davidgow@google.com
> > Signed-off-by: Kees Cook <kees@kernel.org>
> 
> Hi Kees,
> 
> Last time this was submitted, I have reported this patch breaks the
> build when the kunit is built as a module, and it wasn't fixed before
> resubmission.  Thorsten Leemhuis just reported the same issue is now on
> linux-next and I confirmed it is still there.
> 
> https://lore.kernel.org/lkml/2c26c5e4-9cf3-4020-b0be-637dc826b4e9@leemhuis.info/T/#m2e2ddb3b2600274e5eae50b93ea821914dc85f20
> 
> The build error is:
> 
> fs/unicode/tests/utf8_kunit.c:11:10: fatal error: utf8n.h: No such file or directory
>    11 | #include "utf8n.h"
>       |          ^~~~~~~~~
> 
> The problem is that the patch moves utf8_kunit.c into tests/ but doesn't
> fix the include line above.  Can you fix it in your tree since it is
> already merged?

Ah-ha! Thanks. Yes, I've updated this now.

-Kees

> 
> Thanks,
> 
> > ---
> >  fs/unicode/Makefile                                | 2 +-
> >  fs/unicode/{ => tests}/.kunitconfig                | 0
> >  fs/unicode/{utf8-selftest.c => tests/utf8_kunit.c} | 0
> >  3 files changed, 1 insertion(+), 1 deletion(-)
> >  rename fs/unicode/{ => tests}/.kunitconfig (100%)
> >  rename fs/unicode/{utf8-selftest.c => tests/utf8_kunit.c} (100%)
> >
> > diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
> > index 37bbcbc628a1..d95be7fb9f6b 100644
> > --- a/fs/unicode/Makefile
> > +++ b/fs/unicode/Makefile
> > @@ -4,7 +4,7 @@ ifneq ($(CONFIG_UNICODE),)
> >  obj-y			+= unicode.o
> >  endif
> >  obj-$(CONFIG_UNICODE)	+= utf8data.o
> > -obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) += utf8-selftest.o
> > +obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) += tests/utf8_kunit.o
> >  
> >  unicode-y := utf8-norm.o utf8-core.o
> >  
> > diff --git a/fs/unicode/.kunitconfig b/fs/unicode/tests/.kunitconfig
> > similarity index 100%
> > rename from fs/unicode/.kunitconfig
> > rename to fs/unicode/tests/.kunitconfig
> > diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/tests/utf8_kunit.c
> > similarity index 100%
> > rename from fs/unicode/utf8-selftest.c
> > rename to fs/unicode/tests/utf8_kunit.c
> 
> -- 
> Gabriel Krisman Bertazi

-- 
Kees Cook

