Return-Path: <linux-kselftest+bounces-9275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD938BA1D3
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 23:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4CB2830EA
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 21:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B00B180A7B;
	Thu,  2 May 2024 21:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="AavzbeBd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005B6180A81
	for <linux-kselftest@vger.kernel.org>; Thu,  2 May 2024 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714684044; cv=none; b=rf7tr45AGBh/NVDYrL7Osc0M3tlNy1IdNh/W08MVnYUJpieikQ1B4CpDAqnLumxeXrGlHHKJUuIp84OTNYEYaiD8v5eFdi0lSunu4SooYgWV5U5A89lpxTdFTPHWI2RnZTIPVrptH/L/6C0H9Va8zhE47oPG1CvU2jgfsEHZpmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714684044; c=relaxed/simple;
	bh=W8Q5bXKOZUKtuPudohNxres0JDqyULeUWiZldw1kbLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlTMbOmYPB0Q2vD0dQCqKM/EXBVUwVA18KA/qg3mHOFg/356KO+gBOkgUJn0PJJi6GDYjr9v0ytvG9u4VKI+kjd52/vSrSNJv87UgxSh3tjgJ+kd3SbJhham2mWAumUprRL7Rz8vcUFpGFHk91KMjGVrwCWyabnr6TPx3NVgPG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=AavzbeBd; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VVmhv40Z4zPgv;
	Thu,  2 May 2024 23:07:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714684031;
	bh=W8Q5bXKOZUKtuPudohNxres0JDqyULeUWiZldw1kbLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AavzbeBd1JzJy9ac2M35nOFcEwjk3UPv+jtBfdHt6P0+Ts+gEYQTJBX/xpj42vfpP
	 iSIUeSyyGwnHplQdEQujtEUvgeftsRNs3v4DfQFLbnYoh1d0uxDQPwU1IFho5+ZThh
	 WtJv7oYLIWMvoRuexkTcHD0XxXT3Hz4qnKUV422w=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VVmht4Kgjzt3M;
	Thu,  2 May 2024 23:07:10 +0200 (CEST)
Date: Thu, 2 May 2024 23:07:10 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Sean Christopherson <seanjc@google.com>
Cc: Kees Cook <keescook@chromium.org>, Jakub Kicinski <kuba@kernel.org>, 
	Mark Brown <broonie@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-security-module@vger.kernel.org, jakub@cloudflare.com, kvm@vger.kernel.org
Subject: Re: [PATCH v4 00/12] selftests: kselftest_harness: support using
 xfail
Message-ID: <20240502.iwu8buoQuah1@digikod.net>
References: <20240229005920.2407409-1-kuba@kernel.org>
 <05f7bf89-04a5-4b65-bf59-c19456aeb1f0@sirena.org.uk>
 <20240304150411.6a9bd50b@kernel.org>
 <202403041512.402C08D@keescook>
 <20240304153902.30cd2edd@kernel.org>
 <202403050141.C8B1317C9@keescook>
 <20240305.phohPh8saa4i@digikod.net>
 <ZjPelW6-AbtYvslu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZjPelW6-AbtYvslu@google.com>
X-Infomaniak-Routing: alpha

On Thu, May 02, 2024 at 11:42:29AM GMT, Sean Christopherson wrote:
> +kvm
> 
> On Tue, Mar 05, 2024, Mickaël Salaün wrote:
> > On Tue, Mar 05, 2024 at 01:43:14AM -0800, Kees Cook wrote:
> > > On Mon, Mar 04, 2024 at 03:39:02PM -0800, Jakub Kicinski wrote:
> > > > On Mon, 4 Mar 2024 15:14:04 -0800 Kees Cook wrote:
> > > > > > Ugh, I'm guessing vfork() "eats" the signal, IOW grandchild signals,
> > > > > > child exits? vfork() and signals.. I'd rather leave to Kees || Mickael.  
> > > > > 
> > > > > Oh no, that does seem bad. Since Mickaël is also seeing weird issues,
> > > > > can we drop the vfork changes for now?
> > > > 
> > > > Seems doable, but won't be a simple revert. "drop" means we'd need 
> > > > to bring ->step back. More or less go back to v3.
> > > 
> > > I think we have to -- other CIs are now showing the most of seccomp
> > > failing now. (And I can confirm this now -- I had only tested seccomp
> > > on earlier versions of the series.)
> > 
> > Sorry for the trouble, I found and fixed the vfork issues.
> 
> Heh, you found and fixed _some of_ the vfork issues.  This whole mess completely
> breaks existing tests that use TEST_F() and exit() with non-zero values to
> indicate failure, including failures that occur during FIXTURE_SETUP().
> 
> E.g. all of the KVM selftests that use KVM_ONE_VCPU_TEST() are broken and will
> always show all tests as passing.
> 
> The below gets things working for KVM selftests again, but (a) I have no idea if
> it's a complete fix, (b) I don't know if it will break other users of the harness,
> and (c) I don't understand why spawning a grandchild is the default behavior, i.e.
> why usage that has zero need of separating teardown from setup+run is subjected to
> the complexity of the handful of tests that do.

Thanks for the fix.  I think it covers almost all cases.  I'd handle the
same way the remaining _exit() though.  The grandchild changes was a
long due patch from the time I added kselftest_harness.h and forked the
TEST_F() macro.  I'll send a new patch series with this fix.

> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 4fd735e48ee7..24e95828976f 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -391,7 +391,7 @@
>                                 fixture_name##_setup(_metadata, &self, variant->data); \
>                                 /* Let setup failure terminate early. */ \
>                                 if (_metadata->exit_code) \
> -                                       _exit(0); \
> +                                       _exit(_metadata->exit_code); \
>                                 _metadata->setup_completed = true; \
>                                 fixture_name##_##test_name(_metadata, &self, variant->data); \
>                         } else if (child < 0 || child != waitpid(child, &status, 0)) { \
> @@ -406,8 +406,10 @@
>                 } \
>                 if (_metadata->setup_completed && _metadata->teardown_parent) \
>                         fixture_name##_teardown(_metadata, &self, variant->data); \
> -               if (!WIFEXITED(status) && WIFSIGNALED(status)) \
> -                       /* Forward signal to __wait_for_test(). */ \
> +               /* Forward exit codes and signals to __wait_for_test(). */ \
> +               if (WIFEXITED(status)) \
> +                       _exit(WEXITSTATUS(status)); \
> +               else if (WIFSIGNALED(status)) \
>                         kill(getpid(), WTERMSIG(status)); \
>                 __test_check_assert(_metadata); \
>         } \
> 

