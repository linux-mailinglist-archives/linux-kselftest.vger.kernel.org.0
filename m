Return-Path: <linux-kselftest+bounces-15164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C670794F17E
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 17:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72D391F23076
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 15:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1CE17C22F;
	Mon, 12 Aug 2024 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y87enGWq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE88184520;
	Mon, 12 Aug 2024 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723475850; cv=none; b=lgHDwEXGRopbhGiFfeuRJn2FQoaFzVQ1BgmfIy0533Zs9QjGQOwHlKrXHHO1eTCmAN/ld2J/YrCAEdi9YNS2Kv3G2waXdQUSsonXWz8Wx8LOvXoDEJXHZgpSV+e3vVP7RSdkWY8W2OsWjLSXytbiz8hRJ6RC7Kyxp+qTA8uNk5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723475850; c=relaxed/simple;
	bh=T/kWS5+wOAtBmqm+/2JuGpKJ+4WnI29hdF71Zz99svU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l03lcQFESKIRWSjtCGBV+nYnt6gJoQX7fgBupFD7Mp1U40dGV7xi6RgcwOFYalJZdXyJDpyPsf/e9J3OhhHcw6y2tYTwCKGXMyTWSrhatnlt4Gn1axZiaqKRjxWK5wmw9SAo6FrTwY/NxwDyhbfaZe1Gca29lOe4rC1uG0d7vZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y87enGWq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5473C32782;
	Mon, 12 Aug 2024 15:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723475850;
	bh=T/kWS5+wOAtBmqm+/2JuGpKJ+4WnI29hdF71Zz99svU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y87enGWqTzLOe2rtSqwulExntmBLYKN6eIolvvOTKwmOZIiyr/aI5GVVjf74R1a5p
	 D1ZIPwn1HmuAC9uNh6YAPEx4O2Fmb68LplAPsjtkn3+56EheOC4VLaLAR9SzZ6KZif
	 /OTvIgf4NuY42wgGkKQgcYHy3vYT05RcySa4G/cPqK3IogeBhOu1ylCAX+iWeVwrfp
	 c4jo2eUF3hK6eMV8z31eSjtHeiN7ZBHt3MEbCxSc51Vd6Y1t/FGoYGIRZRXP0nF9Ww
	 n78M3vhd8aLHvSQF9hweaV4OzrvAvj8MnaGQFUkwn7teIttigg6mCAhS3gm38uhJnD
	 UhDrzMEz2dgEQ==
Date: Mon, 12 Aug 2024 16:17:25 +0100
From: Simon Horman <horms@kernel.org>
To: Mirsad Todorovac <mtodorovac69@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v1 1/1] selftests: net: af_unix: cast void* to char* in
 call to macro TH_LOG()
Message-ID: <20240812151725.GB21855@kernel.org>
References: <20240812002257.23447-2-mtodorovac69@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240812002257.23447-2-mtodorovac69@gmail.com>

On Mon, Aug 12, 2024 at 02:22:58AM +0200, Mirsad Todorovac wrote:
> GCC 13.2.0 reported warning about (void *) beeing used as a param where (char *) is expected:

nit: being

> 
> In file included from msg_oob.c:14:
> msg_oob.c: In function ‘__recvpair’:
> ../../kselftest_harness.h:106:40: warning: format ‘%s’ expects argument of type ‘char *’,
> 							but argument 6 has type ‘const void *’ [-Wformat=]
>   106 |                 fprintf(TH_LOG_STREAM, "# %s:%d:%s:" fmt "\n", \
>       |                                        ^~~~~~~~~~~~~
> ../../kselftest_harness.h:101:17: note: in expansion of macro ‘__TH_LOG’
>   101 |                 __TH_LOG(fmt, ##__VA_ARGS__); \
>       |                 ^~~~~~~~
> msg_oob.c:235:17: note: in expansion of macro ‘TH_LOG’
>   235 |                 TH_LOG("Expected:%s", expected_errno ? strerror(expected_errno) : expected_buf);
>       |                 ^~~~~~
> ../../kselftest_harness.h:106:40: warning: format ‘%s’ expects argument of type ‘char *’,
> 							but argument 6 has type ‘const void *’ [-Wformat=]
>   106 |                 fprintf(TH_LOG_STREAM, "# %s:%d:%s:" fmt "\n", \
>       |                                        ^~~~~~~~~~~~~
> ../../kselftest_harness.h:101:17: note: in expansion of macro ‘__TH_LOG’
>   101 |                 __TH_LOG(fmt, ##__VA_ARGS__); \
>       |                 ^~~~~~~~
> msg_oob.c:259:25: note: in expansion of macro ‘TH_LOG’
>   259 |                 TH_LOG("Expected:%s", expected_errno ? strerror(expected_errno) : expected_buf);
>       |                 ^~~~~~

Thanks, I see this too.

> Casting param to (char *) silences the warning.

It seems that all callers pass a string as the expected_errno argument.
Perhaps it's type could be updated to char *, if that is what it is.
I think this would avoid the need to cast.

> Fixes: d098d77232c37 ("selftest: af_unix: Add msg_oob.c.")
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Mirsad Todorovac <mtodorovac69@gmail.com>

...

