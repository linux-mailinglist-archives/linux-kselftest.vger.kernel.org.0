Return-Path: <linux-kselftest+bounces-9525-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC7D8BD28D
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 18:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E0A21C2223D
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 16:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79D7156253;
	Mon,  6 May 2024 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="QVGJW07x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667D5156248
	for <linux-kselftest@vger.kernel.org>; Mon,  6 May 2024 16:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715012560; cv=none; b=Be+z8dEYAwDzUP7SZWFB8GQgVQrqeYN9/+T8a8os0HQEgHIGroOrk/VZhNyjjdADhoF7AZRx3YsOm1vv0xxOn//QeFq0ZmUeY1wsdTxjt1X3LfLNVl79m5Xx8temko5ygdJ8IxRhzkUDb+lBuVcCNc6iN743EZjcTEKTXgO+IXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715012560; c=relaxed/simple;
	bh=frTG5OBPlS3cpKFuLzpv3nMYxGsgU18EpPK6RPYW230=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Onkg2oQVT8hmRziGgQayIhuV8SK8LQh1J481d4JSo2wEN+qh9+LXwWABosCBEqgvJqXkqhqA5m94+3eDypMlruPWvVsjSWg6JNNX51VHYBcNj7eDKxUtYfO6rWr2W6lGvYgNNJReZ6rSr9Y/JSduJnlNpT11IPHASCEzQokWc5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=QVGJW07x; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VY6BX035Yzv5F;
	Mon,  6 May 2024 18:22:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1715012547;
	bh=frTG5OBPlS3cpKFuLzpv3nMYxGsgU18EpPK6RPYW230=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QVGJW07xk8eHL6UpWADM18ljmNpCsUZFZ/y+hnujvAG4wypA725OzVnlFCVIrzeIC
	 hLijnFYam4uOXYA7uIhnwTtwavFoEY7K9tQ4KEDq+PhS9u4z/2SnXX09JSBL1tqE1e
	 POk3pm5g+TTYR6xyTDIy65DL078axdOiRswSeqfc=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VY6BV5nyRzpxL;
	Mon,  6 May 2024 18:22:26 +0200 (CEST)
Date: Mon, 6 May 2024 18:22:25 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Sean Christopherson <seanjc@google.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Mark Brown <broonie@kernel.org>, Shengyu Li <shengyu.li.evgeny@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Will Drewry <wad@chromium.org>, 
	kernel test robot <oliver.sang@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v5 10/10] selftests/harness: Handle TEST_F()'s explicit
 exit codes
Message-ID: <20240506.Ceeche0coolu@digikod.net>
References: <20240503105820.300927-1-mic@digikod.net>
 <20240503105820.300927-11-mic@digikod.net>
 <ZjTx7BYvbrqFSNuH@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZjTx7BYvbrqFSNuH@google.com>
X-Infomaniak-Routing: alpha

On Fri, May 03, 2024 at 07:17:16AM GMT, Sean Christopherson wrote:
> On Fri, May 03, 2024, Mickaël Salaün wrote:
> > If TEST_F() explicitly calls exit(code) with code different than 0, then
> > _metadata->exit_code is set to this code (e.g. KVM_ONE_VCPU_TEST()).  We
> > need to keep in mind that _metadata->exit_code can be KSFT_SKIP while
> > the process exit code is 0.
> > 
> > Initial patch written by Sean Christopherson [1].
> 
> Heh, my pseudo patch barely has any relevance at this point.  How about replacing
> that with:
> 
>   Reported-by: Sean Christopherson <seanjc@google.com>
>   Closes: https://lore.kernel.org/r/ZjPelW6-AbtYvslu@google.com
> 
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Sean Christopherson <seanjc@google.com>
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: Will Drewry <wad@chromium.org>
> > Link: https://lore.kernel.org/r/ZjPelW6-AbtYvslu@google.com [1]
> > Fixes: 0710a1a73fb4 ("selftests/harness: Merge TEST_F_FORK() into TEST_F()")
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > Link: https://lore.kernel.org/r/20240503105820.300927-11-mic@digikod.net
> > ---
> > 
> > Changes since v4:
> > * Check abort status when the grandchild exited.
> > * Keep the _exit(0) calls because _metadata->exit_code is always
> >   checked.
> > * Only set _metadata->exit_code to WEXITSTATUS() if it is not zero.
> > 
> > Changes since v3:
> > * New patch mainly from Sean Christopherson.
> > ---
> >  tools/testing/selftests/kselftest_harness.h | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> > index eb25f7c11949..7612bf09c5f8 100644
> > --- a/tools/testing/selftests/kselftest_harness.h
> > +++ b/tools/testing/selftests/kselftest_harness.h
> > @@ -462,9 +462,13 @@ static inline pid_t clone3_vfork(void)
> >  		munmap(teardown, sizeof(*teardown)); \
> >  		if (self && fixture_name##_teardown_parent) \
> >  			munmap(self, sizeof(*self)); \
> > -		if (!WIFEXITED(status) && WIFSIGNALED(status)) \
> > +		if (WIFEXITED(status)) { \
> > +			if (WEXITSTATUS(status)) \
> > +				_metadata->exit_code = WEXITSTATUS(status); \
> 
> Ah, IIUC, this works because __run_test() effectively forwards the exit_code?
> 
> 	} else if (t->pid == 0) {
> 		setpgrp();
> 		t->fn(t, variant);
> 		_exit(t->exit_code);
> 	}

Yes

> 
> Tested-by: Sean Christopherson <seanjc@google.com>

OK, I'll send a v6. We really need to get this into -next.

> 
> > +		} else if (WIFSIGNALED(status)) { \
> >  			/* Forward signal to __wait_for_test(). */ \
> >  			kill(getpid(), WTERMSIG(status)); \
> > +		} \
> >  		__test_check_assert(_metadata); \
> >  	} \
> >  	static void __attribute__((constructor)) \
> > -- 
> > 2.45.0
> > 
> 

