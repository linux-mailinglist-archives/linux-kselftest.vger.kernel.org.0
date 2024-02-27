Return-Path: <linux-kselftest+bounces-5504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC8886A2CC
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 23:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD422B2427D
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 22:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B6B55C07;
	Tue, 27 Feb 2024 22:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EpZfZxfX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928715577C;
	Tue, 27 Feb 2024 22:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709074138; cv=none; b=eWeHg5GMKTa57CwWHks+33nN2mQ9zqowqe+IdvKQAmF3DUfSyJRCnZUv4M7s62A8vwGgo9oe4OWITgnsqX5HQuLVhbyvkeFK1Igm3LdOyJAPwzWbd3lgiaGgwRkt8T2lcXd8wvosRozS9J0iVSMR+T+x3qu8rxsPckkioPhzdZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709074138; c=relaxed/simple;
	bh=6aSqfFICPv39xftFdZw4ZDLNhvPLmaXK2sCiT25TTNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Afo7MtlSPw/tJBLZoRdXU5efuYyNKKIwfbo4eml/Dwpd+1cnZeeFX4wzj9OC3fVAmZnR2v+nkNp7g6B8Y1n6HZXU4BXJux0h5+oeUeKImTA5WOTbsLwoHAEi6DQ7oUpY0mk2FwkJu1SPnJKsJhJlV1H4fvSnUaXLwjrYb/vhX+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EpZfZxfX; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 23256E0003;
	Tue, 27 Feb 2024 22:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709074131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QzbrrxNlmtkyJPkPXOAQ3Vi2FcRLI5aLxFCBrtjaL3U=;
	b=EpZfZxfXqbqRaDVjijJHQoInyGWg+vri8zdceJ4B7N7f34VEuYZP/FYsn7U8EJ1WRLORLy
	A6BlkTa3RGWIiiPEhqe5pYJv3JBtDp8sjryUNnUJF7RDlVq0i1qNkPhfOBnwjV6/28OYTZ
	jeX0u3rrPUBJNdNv/dwo4aLzVvVH8QBnVgGivZfKJpgxkJ+/VPcQMPKxVxR0r5h1M1RzUG
	BQFSQITGA1qlokbIRX/3D/QspUn6W8VKR7RqnibcQq1PKBDohw3KSTnN31wdYzJA+gHjiN
	lcQlHS7S0xYfHc9BkYp9sX2cl1K024Ju+BGDQorum+y1UeQ4xrPoVm6VkkZNXA==
Date: Tue, 27 Feb 2024 23:48:46 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: David Gow <davidgow@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>, Rae Moar <rmoar@google.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Kees Cook <keescook@chromium.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Florian Westphal <fw@strlen.de>,
	Cassio Neri <cassio.neri@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Arthur Grillo <arthur.grillo@usp.br>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Daniel Latypov <dlatypov@google.com>,
	Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org, linux-rtc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 5/9] rtc: test: Fix invalid format specifier.
Message-ID: <20240227224846c7846f20@mail.local>
References: <20240221092728.1281499-1-davidgow@google.com>
 <20240221092728.1281499-6-davidgow@google.com>
 <20240227203243070e7d85@mail.local>
 <56680d34-59f1-460c-a835-f1258abf4569@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56680d34-59f1-460c-a835-f1258abf4569@linuxfoundation.org>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 27/02/2024 14:23:29-0700, Shuah Khan wrote:
> On 2/27/24 13:32, Alexandre Belloni wrote:
> > Hello,
> > 
> > On 21/02/2024 17:27:18+0800, David Gow wrote:
> > > 'days' is a s64 (from div_s64), and so should use a %lld specifier.
> > > 
> > > This was found by extending KUnit's assertion macros to use gcc's
> > > __printf attribute.
> > > 
> > > Fixes: 1d1bb12a8b18 ("rtc: Improve performance of rtc_time64_to_tm(). Add tests.")
> > > Signed-off-by: David Gow <davidgow@google.com>
> > 
> > Who do you expect to take this patch?
> > 
> 
> I am going to be applying this series to linux-kselftest kunit next
> in just a bit. Would you like to ack the pacth?

Sure,

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> 
> thanks,
> -- Shuah
> 
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

