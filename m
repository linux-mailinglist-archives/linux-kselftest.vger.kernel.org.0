Return-Path: <linux-kselftest+bounces-5935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383B58723B5
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 17:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9E71C232E7
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 16:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9E112B160;
	Tue,  5 Mar 2024 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ViLNBG4z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F28128399;
	Tue,  5 Mar 2024 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654774; cv=none; b=RUJ9r34Do+RPZ/taziBly+kU55E+3saUw0JNopveVKx57w7ZYDEQQd1IJEjtesU6TkE4a3cPIL/RgqHAjZa1ap5fDklUvN1JbFkVHTNfMFlC0wziumkEM+NENVZHjFVapv2CT+ZwMWecei9nsRiySF8CH4ElKCzH4A3bW+uPbp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654774; c=relaxed/simple;
	bh=z5qhYq1wOr3LpvwmDPTLIjklmi92wexHHTkNSwgx3KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYtf9EBHxXXwxEG4HjczBOV6apIjzpEQ5i7BBEhqfdpbEBjhOLEr7H3x528mLzSPKhlQSwz1POBqOMARyfCxhYE6RErPiX6La40jd9dwx49y6zqeM6JP4SDUzW/Tp3Nz2ejHJvQOwso9zeRqf+Vr/jA0ZmWQxzPnU3qePv9Xq2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ViLNBG4z; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tq0mC1WqKzQZM;
	Tue,  5 Mar 2024 17:06:03 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tq0mB45ckz3c;
	Tue,  5 Mar 2024 17:06:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709654763;
	bh=z5qhYq1wOr3LpvwmDPTLIjklmi92wexHHTkNSwgx3KA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ViLNBG4zZyHukjR+pPE3Npp+xJMeeEdAtJ5bSJBdhDr0r74HIFUI9xA1A2l28Vz43
	 tRVTIzqkaR62K7ViMK3MFbC8izVwZI13GRWY1R1Kie/fmkjM9bkMwo6B4b+SX1uitI
	 m/P1Mm6nPAGLs0zkHr3IRA9oqePot/VUUC/qf3SU=
Date: Tue, 5 Mar 2024 17:05:51 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Kees Cook <keescook@chromium.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>, 
	davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-security-module@vger.kernel.org, jakub@cloudflare.com
Subject: Re: [PATCH v4 00/12] selftests: kselftest_harness: support using
 xfail
Message-ID: <20240305.phohPh8saa4i@digikod.net>
References: <20240229005920.2407409-1-kuba@kernel.org>
 <05f7bf89-04a5-4b65-bf59-c19456aeb1f0@sirena.org.uk>
 <20240304150411.6a9bd50b@kernel.org>
 <202403041512.402C08D@keescook>
 <20240304153902.30cd2edd@kernel.org>
 <202403050141.C8B1317C9@keescook>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202403050141.C8B1317C9@keescook>
X-Infomaniak-Routing: alpha

On Tue, Mar 05, 2024 at 01:43:14AM -0800, Kees Cook wrote:
> On Mon, Mar 04, 2024 at 03:39:02PM -0800, Jakub Kicinski wrote:
> > On Mon, 4 Mar 2024 15:14:04 -0800 Kees Cook wrote:
> > > > Ugh, I'm guessing vfork() "eats" the signal, IOW grandchild signals,
> > > > child exits? vfork() and signals.. I'd rather leave to Kees || Mickael.  
> > > 
> > > Oh no, that does seem bad. Since Mickaël is also seeing weird issues,
> > > can we drop the vfork changes for now?
> > 
> > Seems doable, but won't be a simple revert. "drop" means we'd need 
> > to bring ->step back. More or less go back to v3.
> 
> I think we have to -- other CIs are now showing the most of seccomp
> failing now. (And I can confirm this now -- I had only tested seccomp
> on earlier versions of the series.)

Sorry for the trouble, I found and fixed the vfork issues.  I tested
with seccomp and Landlock.  You can find a dedicated branch here (with
some Reviewed-by and Acked-by removed because of the changes):
https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=kselftest-xfail-fix

Jakub, please send a v5 series with this updated patch and your
exit/_exit fixes.

> 
> -- 
> Kees Cook
> 

