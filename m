Return-Path: <linux-kselftest+bounces-41393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9ADDB550DA
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 16:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 726B63BBC9D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 14:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C88230FC08;
	Fri, 12 Sep 2025 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qifY4tvr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AF430F7F1;
	Fri, 12 Sep 2025 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686797; cv=none; b=tfKBMEixho3dQGhS7XDsLi/VZuRMkhDHAIoLMmgQCcj61L8HiVSi1vNNarnJf5/hL9meBfaJpX+zceEbeWdGHBI44tW1q4vADzSRgPrmx2O/lUuYgdY9xJcwFTQdJRqjp9qlukftK2lk/kQeYqZifONa33Ct+9TGZSv3ZlVOPRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686797; c=relaxed/simple;
	bh=QUXMDuE3Ma8vzkfL39l7mfcOIc9ESGxGFxKoLdVbTlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTmff/ZtevJunoI3OWS5AeWHPrFcysk7cz8P87pyibpBaAP3fiOYVI/BDLYwG5etzGSmgOSuk7WbOzYKyAbKAMa/RHphe5bLK+Wl4uP64H4+jqtgyCAIjY1TK61oLFBLZDEIAGpsrsA1Glk40lyMIcSI36XabL3vW3Pj2wIW/Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qifY4tvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5C9C4CEF1;
	Fri, 12 Sep 2025 14:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757686797;
	bh=QUXMDuE3Ma8vzkfL39l7mfcOIc9ESGxGFxKoLdVbTlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qifY4tvrygTbEUbLIGH9VKd+sDejOP9hpbjxum/qvmX3uToUvzPp70EeOvzboI6vF
	 9QZ9ZpbFLCV8wZ1zcaWvhFV9IdXwpUytbw4/1GDhVgv8h7K44wl+W6wCQEV5Ar8v7m
	 tCzWz7iaNyBIHENrafq83PdfD87AxpM4olJy7VQM=
Date: Fri, 12 Sep 2025 16:19:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Tzung-Bi Shih <tzungbi@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Dawid Niedzwiecki <dawidn@google.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v3 0/5] platform/chrome: Fix a possible UAF via revocable
Message-ID: <2025091220-private-verse-d979@gregkh>
References: <20250912081718.3827390-1-tzungbi@kernel.org>
 <2033c6cd-4112-4c8a-a9ef-2ab34f3504b8@kernel.org>
 <CACMJSeuKH+WKOXLNU92dMssqhK02xG3z=cT0VeXYM+ZGuPCB9g@mail.gmail.com>
 <aMQW2jUFlx7Iu9U5@tzungbi-laptop>
 <20250912132656.GC31682@pendragon.ideasonboard.com>
 <2025091209-curfew-safari-f6e0@gregkh>
 <CAMRc=MfdoB50o=3Q2p94o+f7S2Bzr=TAtWWQcDrC5Wf3Q5nqAA@mail.gmail.com>
 <20250912135916.GF31682@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250912135916.GF31682@pendragon.ideasonboard.com>

On Fri, Sep 12, 2025 at 04:59:16PM +0300, Laurent Pinchart wrote:
> On Fri, Sep 12, 2025 at 03:46:27PM +0200, Bartosz Golaszewski wrote:
> > On Fri, Sep 12, 2025 at 3:39 PM Greg Kroah-Hartman wrote:
> > >
> > > I have no objection moving this to the cdev api, BUT given that 'struct
> > > cdev' is embedded everywhere, I don't think it's going to be a simple
> > > task, but rather have to be done one-driver-at-a-time like the patch in
> > > this series does it.
> > 
> > I don't think cdev is the right place for this as user-space keeping a
> > reference to a file-descriptor whose "backend" disappeared is not the
> > only possible problem. We can easily create a use-case of a USB I2C
> > expander being used by some in-kernel consumer and then unplugged.
> > This has nothing to do with the character device. I believe the
> > sub-system level is the right place for this and every driver
> > subsystem would have to integrate it separately, taking its various
> > quirks into account.
> 
> That's why I mentioned in-kernel users previously. Drivers routinely
> acquire resources provided by other drivers, and having a way to revoke
> those is needed.
> 
> It is a different but related problem compared to userspace racing with
> .remove(). Could we solve both using the same backend concepts ?
> Perhaps, time will tell, and if that works nicely, great. But we still
> have lots of drivers exposing character devices to userspace (usually
> through a subsystem-specific API, drivers that create a cdev manually
> are the minority). That problem is in my opinion more urgent than
> handling the removal of in-kernel resources, because it's more common,
> and is easily triggerable by userspace. The good news is that it should
> also be simpler to solve, we should be able to address the enter/exit
> part entirely in cdev, and limit the changes to drivers in .remove() to
> the strict minimum.
> 
> What I'd like to see is if the proposed implementation of revocable
> resources can be used as a building block to fix the cdev issue. If it
> ca, great, let's solve it then. If it can't, that's still fine, it will
> still be useful for in-kernel resources, even if we need a different
> implementation for cdev.

Patch 5/5 in this series does just this for a specific use of a cdev in
the driver.  Is that what you are looking for?

thanks,

greg k-h

