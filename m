Return-Path: <linux-kselftest+bounces-41376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BED15B54E6D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 14:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06511C21B1C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 12:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DD2309DA4;
	Fri, 12 Sep 2025 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0z/kSoo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84283305E09;
	Fri, 12 Sep 2025 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757681376; cv=none; b=qWGJwjgnQdJ41SJT9ysZr5Ic47wuH1cxfarKcWmnGUnzzWxkArTsaH1JB0YgRU3GjekzbZ3uVFSMm+VLmvbURoLt/poE+6C+Db1/AU5jqYIBzsVUBylXuUzPIVoxY82YxCSZlXOhoPtzDUDLjWbMVXRG/hXfUKFkN9WYNO/5Trg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757681376; c=relaxed/simple;
	bh=cJOJH3yU/kwSOFEWL3cknqHk3CDHphTlrhQNFHKX2TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDOeZJATOtQa6ya52T+yiHJX1gNyyIzqobMCUkIM37fRL0+52yNT7m6DRxoOYhoQcuP36VoNnhUo/7LGpS884L/wEn4DE4/W/79f+Ki5MrWH9XMu92EMVkWXMrJoJWgq3PqmBQkbPSCQmOrBi2dqDcytAm4gGho2bshN+Ywf9Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0z/kSoo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3FAC4CEF1;
	Fri, 12 Sep 2025 12:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757681375;
	bh=cJOJH3yU/kwSOFEWL3cknqHk3CDHphTlrhQNFHKX2TQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V0z/kSooxMApXq2NR67i6CL/A5Mf8HOrK0a2IkGC5YoU1uouX+LEnpoZnf8dKPuoR
	 oZFaizNtY+yIa/IElaW7FFd+v0Q4mnd3MFXQsED/WA41t05OtpTD9Y/cmO0PRpWgov
	 OC5ZNQEgfyvKL7yVPc6OjAbenW6IusZ3KVhyDgIxa8aYAuCcDnXH7U7cS7lCnszegu
	 sIXuN6n6XxxoNdYFqhvC7z723wrdtVJlV8gVC3PqfytoL+AatKrH9DhngrZgHJtUQz
	 yLlEKCwT2n2B4b32+72FsWoVQ2KruW7f/01kVtW0QOzdZOcfC3ubl66AUQkqMmjHtP
	 hTpLKb1LZNKuw==
Date: Fri, 12 Sep 2025 20:49:30 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Dawid Niedzwiecki <dawidn@google.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>, brgl@bgdev.pl
Subject: Re: [PATCH v3 0/5] platform/chrome: Fix a possible UAF via revocable
Message-ID: <aMQW2jUFlx7Iu9U5@tzungbi-laptop>
References: <20250912081718.3827390-1-tzungbi@kernel.org>
 <2033c6cd-4112-4c8a-a9ef-2ab34f3504b8@kernel.org>
 <CACMJSeuKH+WKOXLNU92dMssqhK02xG3z=cT0VeXYM+ZGuPCB9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACMJSeuKH+WKOXLNU92dMssqhK02xG3z=cT0VeXYM+ZGuPCB9g@mail.gmail.com>

On Fri, Sep 12, 2025 at 11:24:10AM +0200, Bartosz Golaszewski wrote:
> On Fri, 12 Sept 2025 at 11:09, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > On 12/09/2025 10:17, Tzung-Bi Shih wrote:
> > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >
> > Thanks for the work. Just a note, please start using b4, so above Cc
> > will be propagated to all patches. Folks above received only the cover
> > letter...

Thank you for bringing this to my attention.  I wasn't aware of that and
will ensure this is handled correctly in the future.

> Thanks to Krzysztof for making me aware of this. Could you please Cc
> my brgl@bgdev.pl address on the next iteration.

Sure, will do.

> I haven't looked into the details yet but the small size of the first
> patch strikes me as odd. The similar changes I did for GPIO were quite
> big and they were designed just for a single sub-system.
> 
> During the talk you reference, after I suggested a library like this,
> Greg KH can be heard saying: do this for two big subsystems so that
> you're sure it's a generic solution. Here you're only using it in a
> single driver which makes me wonder if we can actually use it to
> improve bigger offenders, like for example I2C, or even replace the
> custom, SRCU-based solution in GPIO we have now. Have you considered
> at least doing a PoC in a wider kernel framework?

Yes, I'm happy to take this on.

To help me get started, could you please point me to some relevant code
locations?  Also, could you let me know if any specific physical devices
will be needed for testing?

