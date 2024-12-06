Return-Path: <linux-kselftest+bounces-22927-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 268249E78D3
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 20:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC65D1885FD8
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 19:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD231F3D26;
	Fri,  6 Dec 2024 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Do6mWkpE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970AA2206AC
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Dec 2024 19:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733512885; cv=none; b=E6ywdcyfHoU2dQDKqpbpbFSuD0Kqrr+a8Z5r20STOIWUuZvba18k/uHN0G5rGehA7UME51Uo9bks4ofw6ZL2KlDx7ZNVcjzrreHYfQNYyCdJg9gw+98kR1shh0GNF1pJbQ3jZ3Ab1xLQiMVfGzPZGohuVqrifajCsBa39y7QMtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733512885; c=relaxed/simple;
	bh=SM42RONTh8qCA5NHC+SsljIwfy8DI8r+osk8IgE9ZSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EPOAWV/hSRsZRKf1gLWTgLS0ex2D1H0Epny9d4NjzewWHYCt0l+fld2ezO4rdfbMViVD0Hcvq16+CVQdEdgChdnfLwNBXHK5EKeti6732J9xH/yJd9qgEGzixeUcC8iiLRTpyM6tZJKtEp+AFAmhqXMFN5yosXedIvG9ooaGPxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Do6mWkpE; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ef60e500d7so16409567b3.0
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Dec 2024 11:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733512882; x=1734117682; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SM42RONTh8qCA5NHC+SsljIwfy8DI8r+osk8IgE9ZSw=;
        b=Do6mWkpE9cYE7nRiGSJjnwxW99kzWdXtn0NbY/J1+40le9pIassZuEYDqwRgWXtHrk
         qUVZjJ76XEumyRnCaFvXTub1l0jRVovJD10zLS4w8qBmP5NPb63H6aH1v3Hc8ZuDwmi5
         nSZH2ieCQFggGWFNBXCHK/cE06cw0F819KRnbCRgBTkbTiepmlotDQykeC3iZd5MANOe
         C/c2O2Mzi9bsCG8s4i4UTBP8YQOZIXsoATE2+Wh7hHVj/2evsLzokmmgt85b68J6jco1
         ZCTqjrl/fFbvFBNk+8capycA+Xk3dbXCJzDry9BQxit20Z8DpnPMX2LOKcGXZXEPeOp5
         +OxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733512882; x=1734117682;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SM42RONTh8qCA5NHC+SsljIwfy8DI8r+osk8IgE9ZSw=;
        b=U4Tu9wzC05TxnKdbc1ItDFi5eBvMJnbJXq7rYM6X+Jt9mKXb1NazYGeBHu0/jzJeaL
         9swetIgPywWxvaroPXNQEZ7B0nkyIC47drgLxT/Zu0tDqv0t4VmJWieMGxc7E3yaAtlo
         MHDGDlTqpc4tiAXH//6RoStCv+Ey7XcWCDqBmd0UCwqP8sr2g9XDb9qceXY3T2OFw/Ux
         NtLEsT31ZzS8HPYwBR+4lbHZN8hCDcEt6RKOjkt/Cucf5XRRO37WFMDUrmj7HaTmSVG4
         Rregidc32SH/91nekR5lyPMwZgI2QiEJNq5Ch5Wtc+RmmqnD+oFn46WXMZ23zJiYqSNV
         pRyA==
X-Forwarded-Encrypted: i=1; AJvYcCU37Wir/oHRjbH6Rwl34gYKv3T9k7efTcPDGjm/msQI7X1G+td3u+0lqI2Vh1s+OqUtVYYN60wj1q579HPL/yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCZeuDr+NXCHPAYn+vwgk8yCCNnfb67TWM9HpcevU3HO1AfJdX
	X2Cpetwq+yxcJhYMnCfeM51c8pko2AKLvdWjFaUTayAHDjBlZXl3qes7ILHbXJZr/q3t+6wSaZr
	A5Kt+BghqQXtDa+9Ut0fh6YcbdYY=
X-Gm-Gg: ASbGncuP1FSVgS/r+G0it0kwSC3wgyUU93jIb7Cd0y8gaqwyaGF1e9OJnfm7GJepeHA
	JkHz+rzj4OuK4Y/UI2EWTrTLb39h+IRwZ
X-Google-Smtp-Source: AGHT+IG8tjAM2TNOyrA1WZsbKL/U2l8jqTN19frzeOwyACq3STyilDSXXcbX3fonabUUsRxI+v5qDiKzPDgz5KVazWQ=
X-Received: by 2002:a05:690c:9c09:b0:6ef:7c8e:eff8 with SMTP id
 00721157ae682-6efe3c750cemr39749057b3.39.1733512882616; Fri, 06 Dec 2024
 11:21:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205114757.5916-1-simeddon@gmail.com> <20241205114757.5916-3-simeddon@gmail.com>
 <6564cc2e-745d-49df-900d-263177c1ea19@sirena.org.uk>
In-Reply-To: <6564cc2e-745d-49df-900d-263177c1ea19@sirena.org.uk>
From: BiscuitBobby <simeddon@gmail.com>
Date: Sat, 7 Dec 2024 00:50:47 +0530
Message-ID: <CAGd6pzPEUun=t4=DGauX-zGhzMnDJsEcHGwZfH5DZkwmffeC-g@mail.gmail.com>
Subject: Re: [PATCH 2/3] selftests/lib.mk: Introduce check to validate
 required configs
To: Mark Brown <broonie@kernel.org>
Cc: shuah@kernel.org, mbenes@suse.cz, Petr Mladek <pmladek@suse.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Dec 2024 at 21:05, Mark Brown <broonie@kernel.org> wrote:
> Should this be a build dependency or only a runtime dependency, or
> should these be separate options for cases where the selftest builds a
> module?

Hello, thanks for looking through my patch. Some tests fail to compile and
throw errors in case their required config options are not enabled.
This optional check was created to prevent such issues.

> If people are building the selftests once and then using them
> with a bunch of kernel builds it might be surprising if some of the
> binaries vanish.

I'm not really familiar with packaging selftests, but this patch does not
remove existing binaries when running tests. If I misunderstood what
you are referring to, please let me know.

> Shouldn't we try the current kernel tree, and for runtime checks
> /proc/config.gz would be good to check when it's enabled?

When I looked into this, it seems (according to the config.gz man page)
that the contents of /proc/config.gz are the same as
/lib/modules/$(uname -r)/build/.config, but /proc/config.gz is only available if
the kernel was compiled with CONFIG_IKCONFIG_PROC enabled.

It does seem like /lib/modules/$(uname -r)/build/scripts is not always available
though, so will send in a new patch directly checking build/.config
after checking
it out on a few more systems.

