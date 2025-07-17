Return-Path: <linux-kselftest+bounces-37468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D64B084CE
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 08:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566971A684E4
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 06:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB4F217709;
	Thu, 17 Jul 2025 06:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJKOmhHf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E9A217659;
	Thu, 17 Jul 2025 06:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752733374; cv=none; b=ksC2welhONnWMfYF+7RSErggF6DdnCkN9asEX/iHDOGDHMafTHHXB/Xi3aMBO2/mqdXbIUvfX68M5SO3e8nmzyQ/kloCYw9IMN8xDVjzKGsJdQZ4KW1AKKK8s2C5kA4SwQTBA/56pFsBmdhjSDMoXzK8jIrZgwKIb5ezw4igW2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752733374; c=relaxed/simple;
	bh=a2DEtYcv0yy9yCXypKXbO02hAT2Ch1ygjJ56KmKkXS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hb4Uhlx8wGm3ICh9QMe6phrr17mjaqMVhpyBwmnT/LQ6etSq5xilZD6bBHBKmpRNHLoytAJY8so/BlZN4b5mzTQckQ4OZp9Uf/yy+jFHMdD/gPutsG9HzgOOmlQYOGA0D3lqW34+CFoCsZFKRXOpZ5xWgcoOjEB1lzdczckD1Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJKOmhHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152D0C4CEE3;
	Thu, 17 Jul 2025 06:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752733374;
	bh=a2DEtYcv0yy9yCXypKXbO02hAT2Ch1ygjJ56KmKkXS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NJKOmhHf7U1+42clAB94qorTRUPVQ7h1x1pAF+YJ0VN1U0MbJdQdcKKsolrEwAuYm
	 2DVxK1ObLZZHTqXU//JRHyaqu46emZsv84byumEUW/yiMK++OdKZh+syUuFwbfhbIq
	 QmLMDe47btXpbayPFhvqLXMjzfW7WL5z56FxUpJhifTek4xbwvP5pkhemj1LbSrO/t
	 zU7f9l6ziqfTMWOUf76G5PocXnLmKVtSDgUoJsm5CZXfbWFGwtdjGofqeclwulYL1J
	 1ypRw9nSH/l67bwFjHXrIRDm3q3BczhIGOWoWwa/UqNOX9/fLKDO0ePorQ0Mt/Wosf
	 c/YuYIXe5WTlQ==
Date: Wed, 16 Jul 2025 23:22:53 -0700
From: Kees Cook <kees@kernel.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Tiffany Yang <ynaffit@google.com>, linux-kernel@vger.kernel.org,
	kernel-team@android.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH v3 4/6] binder: Scaffolding for binder_alloc KUnit tests
Message-ID: <202507162321.33950FA92A@keescook>
References: <20250714185321.2417234-1-ynaffit@google.com>
 <20250714185321.2417234-5-ynaffit@google.com>
 <202507160735.C76466BB@keescook>
 <dbx8seiv4voe.fsf@ynaffit-andsys.c.googlers.com>
 <aHgq8nub0DaIMPbp@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHgq8nub0DaIMPbp@google.com>

On Wed, Jul 16, 2025 at 10:42:58PM +0000, Carlos Llamas wrote:
> On Wed, Jul 16, 2025 at 03:28:49PM -0700, Tiffany Yang wrote:
> > Kees Cook <kees@kernel.org> writes:
> > 
> > > > ...
> > 
> > > I'm used to the "#ifdef CONFIG_..." idiom, but looking at the tree, I
> > > see that "#if IS_ENANLED(CONFIG...)" is relatively common too. I don't
> > > think there is a function difference, so I leave the style choice up to
> > > you! ;)
> > 
> > 
> > IIRC, I had tried using the #ifdef to inject test-specific code in some
> > places, but that created issues when we were loading KUnit as a module
> > because it causes the built-in code to be built as though the
> > "CONFIG_..." is undefined. Consequently, I started using IS_ENABLED by
> > default, but I'm not sure if it's strictly necessary for exposing
> > functions with a header file since I'd assume "CONFIG_..." will be
> > defined when we're building the module?
> 
> Right, IS_ENABLED() is the "short-hand" for ...
> 	#if defined(CONFIG_x) || defined(CONFIG_x_MODULE)
> ... which is what we need here.

Ah-ha! Okay, thanks for the explanation. I don't do much module work,
it seems. ;)

-- 
Kees Cook

