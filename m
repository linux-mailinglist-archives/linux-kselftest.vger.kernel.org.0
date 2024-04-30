Return-Path: <linux-kselftest+bounces-9151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8BC8B7D4C
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 18:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9C31F21A47
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 16:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF335140E3D;
	Tue, 30 Apr 2024 16:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="p/5SfwwV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFBE4EB54
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2024 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495128; cv=none; b=u9U39H3n1YhZHoEuNcp8BmLZt7KM5OIoD0QcjW9Lv2Q+PPAyU0O6Vxu40X2hw/fkWzyCuvAq78qrYflWlpz9tju+5TUc7RB0SA8r317w2KYjPFxyBB8sKQBFWla2nwGDfvVA6qvlAWmqYeDmHL9FoN5dZzBhUFfNvmqqGxNZyS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495128; c=relaxed/simple;
	bh=TPJelmihLrbu2CVr5wwchjHw/2tE6/xg4OjvfPXki0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9SNi49vwzChOUp9GVQLSc4KcGdALtMO2d1Td5bm04uTsSrDLfhfkrf/EOOkG0aTeUlofkHoFgS7w1YzGJyRw3ftOq1Pc2lYAaVy4TrxWRbHbFEz7XM82S4iT2JM4kzbEWWu6hqrKxbK7FzBrpjyFiMFVu6sniK3MUwSdNnrxkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=p/5SfwwV; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VTQr24jsRzXDW;
	Tue, 30 Apr 2024 18:38:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714495122;
	bh=TPJelmihLrbu2CVr5wwchjHw/2tE6/xg4OjvfPXki0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p/5SfwwVdJHMdwfAJgbIFlJi/EFyaIfL0b24setfBAWgSQct5pz7agheGejFzusfU
	 2YQmaML6iQDCxqrgUp6sQrcyio1h26NA2d52rY7YxoL4O5bXLmEDTCRvIew7aaPasv
	 qWj0M4FVmfkQmHw8HYhQYHiwCfSAnrvnPhr/Wxyc=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VTQr13qVDz82J;
	Tue, 30 Apr 2024 18:38:41 +0200 (CEST)
Date: Tue, 30 Apr 2024 18:38:40 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Shengyu Li <shengyu.li.evgeny@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Will Drewry <wad@chromium.org>, 
	kernel test robot <oliver.sang@intel.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/9] Fix Kselftest's vfork() side effects
Message-ID: <20240430.joh2lae1Ooch@digikod.net>
References: <20240429191911.2552580-1-mic@digikod.net>
 <20240430.eudae0Mahbie@digikod.net>
 <20240430081304.0cc6bd8d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430081304.0cc6bd8d@kernel.org>
X-Infomaniak-Routing: alpha

On Tue, Apr 30, 2024 at 08:13:04AM -0700, Jakub Kicinski wrote:
> On Tue, 30 Apr 2024 15:54:38 +0200 Mickaël Salaün wrote:
> > Jakub, can you please review it?
> 
> I looked thru it. I don't have the cycles to investigate and suggest 
> a better approach but the sprinkling of mmaps(), if nothing else, feels
> a bit band-aid-y 🤷️

The only mmap that could have side effects on existing tests in the
_metadata one, but in fact it would reveal issues in tests, so at the
end I think it's a good thing.

I'd like "self" to not be conditionally shared but that would require
changes in several tests.  Let's keep that for another release. :)

I also noticed that mmap() is already used in test_harness_run() with
results.

