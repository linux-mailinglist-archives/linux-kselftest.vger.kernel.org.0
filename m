Return-Path: <linux-kselftest+bounces-18864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AD898CCFF
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 08:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36432B209F0
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 06:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3254A5464E;
	Wed,  2 Oct 2024 06:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J2Zyd1+U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840642581
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Oct 2024 06:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727849763; cv=none; b=pZ2g984LCMNehxGDm7GYW9nK+E7UDXa0IK7OnDQI4zC3TA1wDAYgXORQm0PP5bLOTXm9N86meBpaIucN5WRIdkWVhVuXSRlkpcYKfyW30EHPRJ6kf/FBtFV+oHnRXjpxIcsMZLMicbkAbxIvgy9cRU1zy27mwknpij2pbjKZXxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727849763; c=relaxed/simple;
	bh=FacS+RxJ3BW4bmTumlrVfS7MPk3cld+LlzDq2XVlxoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/fH3cv5rvG0RS6LfbrA1hPI1wf4rUIytPGOpJy1GSUstE4adsPEwASqPeMvmxAUJsIGIWnQIHL5TUmRtjRiTWRqAwKxSRgjAO65K0b/lDZRMtMNNVsPM2cWwaosdA833lJLerfCZl/lQWPKRjRB7ZbTjPgkYckdbhk8IfTcTE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J2Zyd1+U; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cb3a412136so10207186d6.1
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Oct 2024 23:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727849760; x=1728454560; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QusyBxhWG6kce2Y5x4Y+LHwtNZweZbMz+ILN7YtljGo=;
        b=J2Zyd1+U8IRsYHwnG5XWat+hUOIcUV0HqNdDFIPl8sx6oRePwFP+PXc578ORIj2Hbj
         MPdsEw7iypJ5p92HHhblj8yXWJ+rMjBqP4U84RGBkJ9epqCMUkmjfdnorpQuMVUaQNUA
         TK2xpp2JKOzlOtzuUQ8gRrXgEop3YTe7WDmPJ+1gEW5Gsf6zWgkUeinCH1XnSXK/6yI2
         Chjlm5nyuaXjXYurZijBpkPlsegQs9WmIuqRBbPhiuJ7d2aoo62OUh3U2vrdYrLm9K2k
         PDldqnekW9ARa2Xb8GhAOklph7wb9ZHx7lWKkoHe59ST2Ha98OxeX08/P7rOWHy5Gjf8
         Jr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727849760; x=1728454560;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QusyBxhWG6kce2Y5x4Y+LHwtNZweZbMz+ILN7YtljGo=;
        b=lz+SDCZeorQd44hIE055L4vGd7f3IXPlGvrHYyo6MnY9FRVGEqhMm7AdTtquFBH7iF
         MxU6/IYwh6YQymeZaEsijwdZ9jifyy7pDH6QK9/eMivLbWoOKhTUmhHVQfnyEY89TbpZ
         cryTeJHHFPFZJgK/5oWFYuHsDefdep3nCqtfLnEoGMjgNKXO/LRzID6P0EY9TDC7kNi9
         5jSYSrnTGh8joEmFDqgn/5WlvBXRy9Tt9ZxFzbWNTexrWlj88xtYjH5VtSrLzqtm7wiv
         S05EZoXnGlinfCXW1KN4MUia085KV1Xr0JuBv+fBOULvZ8hPEFbntlUp/8YA/Lx5p0vD
         8jiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7EHHNn2nN6NnC/9dnzKH/gta9nXMreAr9iVOSs5wSOXhdh+MZf/v0TuGbEK4wUhogvpWrC3csaik8Pc0Go7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0thWUH8AyCuttFevTLTA1/CisEHgfRCW4RTSjVIM3ExXYwFKS
	O6HElJi5RbjZ220H3WR7rXyPF5Z+llU6t8k7IHUye1pEtJ+OVmAzAoDojGTtvAUTXHiBISxpchC
	0WKCmVjv1r1dz9AmE0j0CcNXa8zjQLPtA/sbsiw==
X-Google-Smtp-Source: AGHT+IGAg4TCemPw86guaqJaE1WEUtkb1Aps6zw6PogBPUaG3ligTBAvVmjeOroQni0OEFKdUHaR401CeP6tSqSI7b4=
X-Received: by 2002:a05:6214:1bc9:b0:6cb:1fad:82b2 with SMTP id
 6a1803df08f44-6cb819c4132mr14420456d6.3.1727849760430; Tue, 01 Oct 2024
 23:16:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916075655.4117151-1-anders.roxell@linaro.org>
 <952aeec9-c21f-46ce-bf68-e6ffce51630c@linuxfoundation.org>
 <20240920123827.715ff109@kernel.org> <3f0d12ba-0e52-41f9-9cbd-34bc1225121e@linuxfoundation.org>
In-Reply-To: <3f0d12ba-0e52-41f9-9cbd-34bc1225121e@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 2 Oct 2024 08:15:48 +0200
Message-ID: <CADYN=9JO-h5L8+CBE9rKY9fnA2sJmam6_MzpZB38Bmn5D4fdPQ@mail.gmail.com>
Subject: Re: [PATCH] selftests: Makefile: create OUTPUT dir
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Jakub Kicinski <kuba@kernel.org>, shuah@kernel.org, willemb@google.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Sept 2024 at 19:26, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 9/20/24 04:38, Jakub Kicinski wrote:
> > On Thu, 19 Sep 2024 09:51:47 -0600 Shuah Khan wrote:
> >>> @@ -261,6 +261,7 @@ ifdef INSTALL_PATH
> >>>     @ret=1; \
> >>>     for TARGET in $(TARGETS) $(INSTALL_DEP_TARGETS); do \
> >>>             BUILD_TARGET=$$BUILD/$$TARGET;  \
> >>> +           mkdir -p $$BUILD_TARGET;        \
> >>>             $(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET install \
> >>>                             INSTALL_PATH=$(INSTALL_PATH)/$$TARGET \
> >>>                             SRC_PATH=$(shell readlink -e $$(pwd)) \
> >>
> >> Doesn't the "all" target mkdir work for this case? Why do we need another mkdir here?
> >
> > I was wondering about that, too. Looks like the code from the all
> > target is copy/pasted in the install target except the mkdir line.
> > Best fix would be to make the dependency work, I don't understand
> > why it doesn't already, tho.
>
> I think this could be the issue:
>
> net main Makefile doesn't have handling for subdirs. It looks
> like the way this is handled is by adding an entry to the main
> Makefile:
>
> TARGETS += net/af_unix
> TARGETS += net/forwarding
> TARGETS += net/hsr
> TARGETS += net/mptcp
> TARGETS += net/openvswitch
> TARGETS += net/tcp_ao
> TARGETS += net/netfilter
>
> So the solution would be similar adding net/lib to the main
> Makefile.
>
> Anders, can you try the above and see if it works.

Sadly that didn't help.

>
> Another issue - lib/Makefile
> TEST_GEN_FILES += csum needs to be TEST_GEN_FILES = csum
>
> thanks,
> -- Shuah
>

