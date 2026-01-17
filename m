Return-Path: <linux-kselftest+bounces-49238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE79D38E8F
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 13:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6176301EA22
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 12:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83872DC333;
	Sat, 17 Jan 2026 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBdKnNWy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58BE2D7BF;
	Sat, 17 Jan 2026 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768654093; cv=none; b=DeGwdpS0JEEamEg1ZC3aQlvngXS8QXA+F9bSXbon7/r93u4BwH+Xf5K/upzVK+ZrurWL8dI4uQl5zudnQBYEbKPZOKmra15dl5noGbBkQo2+ANCW34nC9pBKP5+6zxae9gTMrJiZsm5L4aHCJQPtbx2aDQh9AS5UyyVrZK2GSC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768654093; c=relaxed/simple;
	bh=sM3AR9Ur1rSgBBjuyZ7MZ7PJCrD1NEZsXR51f6/mRn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ge8vM8lml3z/57ARjlm71JLUyyawZ0Rc/j8txei8fZLZQK29u1yOGzlAOpGXu1+lC/Y6SE2zwJdMAMS/9LhkYmElR+HMJn0fndK4g7clwLv4SgrPlMQSeufeSCjAUpx0XXmQjM6alqt201NnzlhX9mnUxU9mU7KGsPAqLsDjNrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBdKnNWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A59C4CEF7;
	Sat, 17 Jan 2026 12:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768654093;
	bh=sM3AR9Ur1rSgBBjuyZ7MZ7PJCrD1NEZsXR51f6/mRn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lBdKnNWyQ5XcUGgnQcx9vWSL494nCNr0Xwxg3vtviutdVTiUocYqUlNt4rRCTeMbS
	 0OG+xCGfgpNW7RBQeeGi7phUKSrHp8/COc1GUB0xNW5HCGmEaKaK6kYI84EL1XjjLP
	 4tDHshcFfQ96VbUjUdp5PO6X/57J7E8JPKzhlJT+Wz2+qssoVwDrj10qt0/HgTEq3f
	 A6niAniEGPz1KQQFHE502yBfwXm10mv7Qy4aAGWnCalZbxBjjmnptIX6eDUO253IxL
	 M6Udu6u9j5CPHvNlL+79bJazxvP6JrLwX4iaBUQ9RUqJRwU+zutUlsJF6zBgKXqND0
	 vFiHbjVWS42sQ==
Date: Sat, 17 Jan 2026 20:48:06 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Linus Walleij <linusw@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 00/23] gpiolib: Adopt revocable mechanism for UAF
 prevention
Message-ID: <aWuFBqIfJpDL9g-J@tzungbi-laptop>
References: <20260116081036.352286-1-tzungbi@kernel.org>
 <CAMRc=MdOCvEb81k0whM9dGCE8Hp=tdxZTUuiFeiL3+WsEei9EQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdOCvEb81k0whM9dGCE8Hp=tdxZTUuiFeiL3+WsEei9EQ@mail.gmail.com>

On Fri, Jan 16, 2026 at 11:35:00AM +0100, Bartosz Golaszewski wrote:
> On Fri, Jan 16, 2026 at 9:11 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > This series transitions the UAF prevention logic within the GPIO core
> > (gpiolib) to use the 'revocable' mechanism.
> >
> > The existing code aims to prevent UAF issues when the underlying GPIO
> > chip is removed.  This series replaces that custom logic with the
> > generic 'revocable' API, which is designed to handle such lifecycle
> > dependencies.  There should be no change in behavior.
> >
> > This series depends on the 'revocable' API, introduced in [1].  Some
> > build bots may report errors due to undefined symbols related to
> > 'revocable' until the dependency is merged.
> >
> 
> Hi Tzung-Bi!
> 
> Thank you for doing this and considering my suggestions from LPC. I
> haven't looked at the code yet but I quickly tested the series with my
> regular test-suites. The good news is: nothing is broken, every test
> works fine. The bad news is: there seems to be a significant impact on
> performance. With the user-space test-suite from libgpiod (for core C
> library - gpiod-test) I'm seeing a consistent 40% impact on
> performance. That's not really acceptable. :( I will try to bisect the
> series later and see which part exactly breaks it.
> 
> I can also help you with user-space testing with libgpiod, if you need
> it? Some documentation is available here:
> https://libgpiod.readthedocs.io/en/latest/testing.html

How to get the performance data?

I tried on libgpiod-2.2.2.tar.xz:
- ./configure --enable-tools --enable-tests
- make
- ./tests/gpiod-test

There is only TAP output.  Also I don't see the difference between:
`./tests/gpiod-test` vs. `./tests/gpiod-test -m perf`.

