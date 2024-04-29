Return-Path: <linux-kselftest+bounces-9060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A548B61D9
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 21:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDECFB22393
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 19:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BF713B59E;
	Mon, 29 Apr 2024 19:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="XmkR207c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B7E13AD31
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 19:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714418342; cv=none; b=Vvyrc83L3/yXogt2hxR9D+ye25O0eigjmndqV8oRyZI2QOxdyvGTPbnpDCIdMMIsrEYIvikZBC1HQ2FHRvrqm/iCqRnnAHQIVz7ibKxO/nCqS6JfK2Knc8w2rx0y1XWCnGbnS91xm5JCrg+o9TVUuqdLqZnigQS1o/1hVNZjaF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714418342; c=relaxed/simple;
	bh=rJgKKRzmF2JN7UHlVGkVK78Xzd3bmyE6CF3mTysODzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B31fxgWryA5n39JIxar4vbq9DzvS6SH3/h0pJcQzQXvZPHckfBz90qyNakkW/+8RfnHOqGXi8nVCPBWREclytn64SazxKr1llCeWwtG6pnUKseO4J+kQiMnRRJgH0Ul6ksJm1M1psrjAxgOpNraYDEmrYhFSu6X5JMX6INFwDGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=XmkR207c; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VStRJ0rXgzRfx;
	Mon, 29 Apr 2024 21:18:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714418332;
	bh=rJgKKRzmF2JN7UHlVGkVK78Xzd3bmyE6CF3mTysODzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XmkR207cTzdvhuM7ib5xxNLMcuNznAau20zPLCHzu2c+/RwCTQmPDHThukU9dtGN7
	 /i/MaIt43BmAXHeA2/zERg3CORptxmTx432yIQ0uf5aH8JgcQpQ3/hjXvF8A91Pr9R
	 zxt3qexP0imMh550Mt2/LYYpFSWN5EkJW3oyCSOA=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VStRH17SvzSjs;
	Mon, 29 Apr 2024 21:18:51 +0200 (CEST)
Date: Mon, 29 Apr 2024 21:18:50 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, 
	Christian Brauner <brauner@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Shengyu Li <shengyu.li.evgeny@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Will Drewry <wad@chromium.org>, kernel test robot <oliver.sang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/9] selftests/harness: Fix interleaved scheduling
 leading to race conditions
Message-ID: <20240429.Eitho4foo5he@digikod.net>
References: <20240429130931.2394118-1-mic@digikod.net>
 <20240429130931.2394118-5-mic@digikod.net>
 <202404290852.C327596A@keescook>
 <20240429101647.756a1ac7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240429101647.756a1ac7@kernel.org>
X-Infomaniak-Routing: alpha

On Mon, Apr 29, 2024 at 10:16:47AM -0700, Jakub Kicinski wrote:
> On Mon, 29 Apr 2024 08:52:36 -0700 Kees Cook wrote:
> > > +/* Wait for the child process to end but without sharing memory mapping. */
> > > +static pid_t __attribute__((__unused__)) clone3_vfork(void)  
> > 
> > Why "unused"?
> 
> Right, static inline is enough

Indeed, I'll fix that.

