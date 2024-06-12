Return-Path: <linux-kselftest+bounces-11785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 639679059D1
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 19:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178F61F225CA
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 17:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A606181D06;
	Wed, 12 Jun 2024 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0Q06Ogc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047233209;
	Wed, 12 Jun 2024 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718213055; cv=none; b=ANfIcP6cQzcLFZCQzAZ8TNSfZh3d9UIqTRr2oIgTxdqGUCC31PPJ7+Qs+w1C/e3Veguw1V6pp75XjptOuLYYV3/IxrlfzCpQW5w5oaRG+d7Tq+9arYkl5HvdZgqFeYxyH1s34/a0uvpdGvqcsdkJ8mc0YVP85qMe0Qk0OHupPsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718213055; c=relaxed/simple;
	bh=VEP6/pbsoq4tingsui+FiHXJGFOhZC3JaHgSPFWU6mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AoX3EN8ug9Qjq4arXLSaDk4YSez8yG6EFUf8f2SCn85Fr0YkIsw8RI/Fqz1usgZw7VL4HNN9KC1W/OKcfEioXGWUnhb4MftLMyuAawfduHdTv+RVeIzBpSgT6Ob9nNgVNqZo1RJ3epkHIuJv9lfDFB833Pf+/dFd558znhs0iw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0Q06Ogc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4A2C116B1;
	Wed, 12 Jun 2024 17:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718213054;
	bh=VEP6/pbsoq4tingsui+FiHXJGFOhZC3JaHgSPFWU6mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E0Q06Ogck67T3YyvvwKZ6YCLKjIXPGwvgIyl5znav4NfousuzZYo71KBpvEwS1p56
	 A6rxMMP4xTnaag8d66Mh3iNk41YULjPod4ac3blokxLKvroAnWen2tfzXHEb96o5dR
	 nEhK1WQev1bKH8ndeUmfwYukd9xDZqQd9fB5HscNC8ng3f70y5Ddq4EXh4AN8ZjwCG
	 kOpaNMEcNPmV3FPABKbu1UvbhzKXgAmxdoqtaV2jSopaSZ8tIxBbzSuaHAbxcoQBlM
	 ABr6jorhzTPCnmqTiq6wWIXg67BaS5sNP7QiQ1p0JVq2dXAotCldXBan3v4dNyhWfz
	 xGnF+AOXKWkuw==
Date: Wed, 12 Jun 2024 11:24:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@meta.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"paulmck@kernel.org" <paulmck@kernel.org>,
	"davidgow@google.com" <davidgow@google.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"venkat88@linux.vnet.ibm.com" <venkat88@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] nvme: fix namespace removal list
Message-ID: <ZmnZu-QceHYbYf0S@kbusch-mbp.dhcp.thefacebook.com>
References: <20240612155135.3060667-1-kbusch@meta.com>
 <20240612155135.3060667-2-kbusch@meta.com>
 <5cb2c809-bfa3-4389-8f60-ea0edf742724@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cb2c809-bfa3-4389-8f60-ea0edf742724@nvidia.com>

On Wed, Jun 12, 2024 at 05:20:48PM +0000, Chaitanya Kulkarni wrote:
> On 6/12/24 08:51, Keith Busch wrote:
> > From: Keith Busch<kbusch@kernel.org>
> >
> > This function wants to move a subset of a list from an element to the
> > end to another list, so do that with the new list_cut helper instead of
> > using the wrong list splice.
> >
> > Fixes: be647e2c76b27f4 ("nvme: use srcu for iterating namespace list")
> > Reported-by: Venkat Rao Bagalkote<venkat88@linux.vnet.ibm.com>
> > Tested-by: Venkat Rao Bagalkote<venkat88@linux.vnet.ibm.com>
> > Signed-off-by: Keith Busch<kbusch@kernel.org>
> 
> not a blocker, but it'd be really useful if we can get a blktests for this,
> I've asked OP to provide steps at least ...

Recreate the original report: detach the highest namespace id from your
controller. Let's say it's nsid 10, and let's assume your ctrlid is 0:

  # nvme detach-ns /dev/nvme0 -c 0 -n 10

blktests supposedly has something that detaches namespaces through the
nvmet module, but it doesn't seem to be catching anything.

