Return-Path: <linux-kselftest+bounces-23700-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 035199F9943
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 19:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35F4F189F5C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 17:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B04421B1BF;
	Fri, 20 Dec 2024 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EMRFwXXe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD38078F45;
	Fri, 20 Dec 2024 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716650; cv=none; b=SDl5HeIUzAd5spZiU8W+IlTPQbSFxuGyxFqGxBTbYrFFdG8goyfdq7ExV7O1zqtbfe1AEUZgcITMOc6sjmyYSpbXVVcUuSI8LvN1c+HHVJ4e0vcu3Xj7S9ZE7FxxdFl19D6KIEXOGHf+2zd6q38x7wMA8i29sWt/Tg9iHgREtaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716650; c=relaxed/simple;
	bh=UQjRp4WEMsK0PaIze1+a8/Q9BV18lKFAgNrZxnZw95Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sctmfytHOyTYFz3J3fUC06h9Ywa8ks49NGIWRzrThkF95H9Ih1+MgXn+XS3hFo+m9R6oCSdyVJDhXTwKP9/NCdcr+tYTuCM+MGVvoACE3SJFayEjoujgFNwdavaxYWqXCPXUOPnZoZgm2ZTU95Zdf+Tvm6tdhWZi2v3IHGJJz3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EMRFwXXe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6055C4CED3;
	Fri, 20 Dec 2024 17:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734716649;
	bh=UQjRp4WEMsK0PaIze1+a8/Q9BV18lKFAgNrZxnZw95Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EMRFwXXek5Ja8t6VV16qNUg7h0pbvdTpjcv2xvbBOeQFnNOpSGmLTGnfxl7wjps5+
	 nL3S8+/4XCPFqQcC1Jbe/r+EfSFlBoqRThSMrseeWZkDPFX6QEez97/U1qyaUb9M4i
	 v+NUWU8FVjMDXIg3WZ8Q4iaT/1E9Rat8I2zSiR/k=
Date: Fri, 20 Dec 2024 18:44:05 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: David Gow <davidgow@google.com>,
	Brian Norris <briannorris@chromium.org>,
	Maxime Ripard <mripard@kernel.org>, linux-acpi@vger.kernel.org,
	Rae Moar <rmoar@google.com>, Rob Herring <robh@kernel.org>,
	linux-kselftest@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v3 1/3] drivers: base: Don't match devices with NULL
 of_node/fwnode/etc
Message-ID: <2024122056-catnap-purist-a866@gregkh>
References: <20241216201148.535115-1-briannorris@chromium.org>
 <20241216201148.535115-2-briannorris@chromium.org>
 <CABVgOSmZUETNa8OfqTvMuGg8Dim3UjLzvKdeJia6aCV7Ydgzdg@mail.gmail.com>
 <c8e232e9-78ff-4051-995b-41454f9c4b51@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8e232e9-78ff-4051-995b-41454f9c4b51@linuxfoundation.org>

On Fri, Dec 20, 2024 at 10:33:51AM -0700, Shuah Khan wrote:
> On 12/18/24 22:45, David Gow wrote:
> > On Tue, 17 Dec 2024 at 04:12, Brian Norris <briannorris@chromium.org> wrote:
> > > 
> > > of_find_device_by_node(), bus_find_device_by_of_node(),
> > > bus_find_device_by_fwnode(), ..., all produce arbitrary results when
> > > provided with a NULL of_node, fwnode, ACPI handle, etc. This is
> > > counterintuitive, and the source of a few bugs, such as the one fixed by
> > > commit 5c8418cf4025 ("PCI/pwrctrl: Unregister platform device only if
> > > one actually exists").
> > > 
> > > It's hard to imagine a good reason that these device_match_*() APIs
> > > should return 'true' for a NULL argument. Augment these to return 0
> > > (false).
> > > 
> > > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > ---
> > 
> > Seems sensible enough to me.
> > 
> > Acked-by: David Gow <davidgow@google.com>
> > 
> > I assume this series (including the KUnit test changes) will go in via Greg.
> > 
> 
> Works for me.
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Thanks, I'll take these in a few days.

greg k-h

