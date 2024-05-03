Return-Path: <linux-kselftest+bounces-9348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 775B68BA816
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 09:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F44282ABC
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 07:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AFF147C78;
	Fri,  3 May 2024 07:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="wx5xxcGZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8CD139CF1
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 07:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714722675; cv=none; b=sk/sKKYnOoYkoGeXIhgvierhMb8QQ2kVGN8pr0EDxjBV/5aoyAB8xxgH7+Gdmdf14O1vz21ScxavP1D2j8EMZiEIn8lKVhYAiz9d/dn+lk8YTUKo7+Ga4utDB9tLzUnU2WOYK4yQ7ED9a02Cox97p8f0ELIVuL7baYbE03DZvGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714722675; c=relaxed/simple;
	bh=6c0haiQoTMm6CuVFZmVqDcjCcgLU9+wd+9CRI4uiK0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YT9Z8TeN9fClt0EmmRLJOdbdUuBttK8Lxjlcow5F/9K53+PxDcqM65MydqZ8rZrlDe2qDwezcJ1OEXqTL9qzRwUnYgi6jerN4oA8n/XBJaNP1W80QmlVn6CujJkWFT5jiex54KKz/9LjPrgOXlbv0eoVk10x0JRVe92JxdK0DrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=wx5xxcGZ; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VW2zv14ZWzgcK;
	Fri,  3 May 2024 09:51:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714722667;
	bh=6c0haiQoTMm6CuVFZmVqDcjCcgLU9+wd+9CRI4uiK0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wx5xxcGZpH3eufHQ7rxuS+5ylmeNv5Ytla2iQrw6capOvA+poACjyD6S8fDq/z4ph
	 xz8Guyk8+5WSOwN4XCSUV1J/5mpVWGCtpUtqTGnfmkf1NoSRWkPt1iytVCmjNGJEzu
	 CsJKb9NN74GuWhgCTnhKC+XHCEZ9uP58VAzeBG3I=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VW2zt0QQkznrQ;
	Fri,  3 May 2024 09:51:06 +0200 (CEST)
Date: Fri, 3 May 2024 09:51:05 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Sean Christopherson <seanjc@google.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Mark Brown <broonie@kernel.org>, Shengyu Li <shengyu.li.evgeny@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Will Drewry <wad@chromium.org>, 
	kernel test robot <oliver.sang@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 10/10] selftests/harness: Fix TEST_F()'s exit codes
Message-ID: <20240503.Ioj0ahCi7aeN@digikod.net>
References: <20240502210926.145539-1-mic@digikod.net>
 <20240502210926.145539-11-mic@digikod.net>
 <ZjQXghB6imRFU4HX@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZjQXghB6imRFU4HX@google.com>
X-Infomaniak-Routing: alpha

On Thu, May 02, 2024 at 03:45:22PM GMT, Sean Christopherson wrote:
> On Thu, May 02, 2024, Mickaël Salaün wrote:
> > @@ -462,8 +462,10 @@ static inline pid_t clone3_vfork(void)
> >  		munmap(teardown, sizeof(*teardown)); \
> >  		if (self && fixture_name##_teardown_parent) \
> >  			munmap(self, sizeof(*self)); \
> > -		if (!WIFEXITED(status) && WIFSIGNALED(status)) \
> > -			/* Forward signal to __wait_for_test(). */ \
> > +		/* Forward exit codes and signals to __wait_for_test(). */ \
> > +		if (WIFEXITED(status)) \
> > +			_exit(_metadata->exit_code); \
> 
> This needs to be:
> 
> 		if (WIFEXITED(status)) \
> 			_exit(WEXITSTATUS(status)); \
> 
> otherwise existing tests that communicate FAIL/SKIP via exit() continue to yield
> exit(0) and thus false passes.

Yes of course.

> 
> If that conflicts with tests that want to communicate via _metadata->exit_code,
> then maybe this?
> 
> 		if (WIFEXITED(status)) \
> 			_exit(WEXITSTATUS(status) ?: _metadata->exit_code); \

I prefer this approach handling failed expectations in the fixture
teardown too.

However, the direct call to _exit() doesn't handle failed asserts.  I'll
fix that.


> 
> Or I suppose _metadata->exit_code could have priority, but that seems weird to
> me, e.g. if a test sets exit_code and then explodes, it seems like the explosion
> should be reported.
> 
> > +		if (WIFSIGNALED(status)) \
> >  			kill(getpid(), WTERMSIG(status)); \
> >  		__test_check_assert(_metadata); \
> >  	} \
> > -- 
> > 2.45.0
> > 
> 

