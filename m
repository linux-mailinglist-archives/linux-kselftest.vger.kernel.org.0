Return-Path: <linux-kselftest+bounces-5360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF491861A95
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 18:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BF11B2443D
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 17:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B82E143C4D;
	Fri, 23 Feb 2024 17:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PaqJkDVN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8149513B7B8
	for <linux-kselftest@vger.kernel.org>; Fri, 23 Feb 2024 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710538; cv=none; b=fNiP1VpjVSLahNQBZ6Kwd5Q5uX7AkXyc0fBypQ/l5c0Eq2fhdwh0mQl8dy5Zy3Lc4xuhu1Mi1DNWUZkVoswFyqOD9P4nCYIBeuevfUWQC+mllTW5D9tS5k6QJqAvGQwH6sLCI0woUXFkScnkf63QQchZq4h7VJ9IwNKk9Lbhpy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710538; c=relaxed/simple;
	bh=J9CJg+f2XESx0EE8EOWgy7TWOEQmNvNe7CTVEAvMpdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdZtPG9bojP0gbHdZ244DGDXgXtHYBGoQlNqmCS4XLH2AITI2fQBPMwcTVShCg+0fZawoEES7++ioc0ab6oY6f+mFxOIA8uImywX4cCe9EiHJN4VX7ZtzvFxdgzuS2oGgwUznT4j1/o7Bl58PJO3y/caYk/yRaG3gF+JZyyICnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PaqJkDVN; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2995fa850ddso452260a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Feb 2024 09:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708710537; x=1709315337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0xniysJokrJSL4kA+7xMXMFdpfM5voHW8xKXFN/4z3Q=;
        b=PaqJkDVNUvhAcZHYjyaXXhlR47txCPW5nwh7UvN501VLusznbTi0vhhkvcVwVUe96y
         hF9onaV6DcaczNiwnv7KhPHQPymZZRCFIjHroVVHqbkLd0KJRfiRo+86fPpFhLQrtQZE
         gLAV3WtKX9IYx4fP7TZjdHyZMZ5ZsVGOH12c8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710537; x=1709315337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xniysJokrJSL4kA+7xMXMFdpfM5voHW8xKXFN/4z3Q=;
        b=oEzJ0GvZk7M0BJd6xnBDOiPY9JlRgC4WO94+gdnw4BBwwedbwHbwQe3WsdWlYLcm9n
         btmPoyftRxu/fTN7nN2td6u8jY7HC5hlQE3P1r+IPhFdt/kjB0xgSBTmNl+pCndNWGJ9
         eUX/w/ZPd9HVREJQmxG10CDsCD8aEJqYTUa5JtJX6giJL8n0Zhq5shz81cvbEYARy1ZA
         qHovkfnr1R60je5mWRPNRpqVFCT4VbkhXcUiBguHeCOf9vTmZq1EOPVlHlpOUXxKY4RA
         7xUEfniKV2tP1h2h9pEfJIVS2pfhPqZJdd9Cu7u0PjNM0q1awxPM7v/EFUPplh7V5T8+
         3w7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrLhnCJIxP9xUMtW6WcJwA4ecdQJ+Kb+vzfaTWqaum2GAfUwpH5IzEV+ERobWUVgVt7GZYT0eQey8kSQSLV708GqHY2AaSTWqB+ZtGV4Qu
X-Gm-Message-State: AOJu0YwRvLxxpmzlz94MxBu4KYLLbzFXiBlOJACehDwQq2xEEo8HoCAR
	7Yj59fC6D1m8SO3vUHE3pQfVy1VPZCgU57JKUJYSPAM6fpuzn81KbsqmuOVGX4yFcgyiKBVRKKw
	=
X-Google-Smtp-Source: AGHT+IHPn7Lo2ZZEfv0egVA1U0588A9KlqO0T0qP4pZBiF5v6f+M7qkLa0yUFIE4yhmkeXZ+FjLDCg==
X-Received: by 2002:a17:90a:ad97:b0:299:41dd:95c0 with SMTP id s23-20020a17090aad9700b0029941dd95c0mr619373pjq.16.1708710536866;
        Fri, 23 Feb 2024 09:48:56 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l14-20020a17090a72ce00b002961a383303sm1742861pjk.14.2024.02.23.09.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:48:56 -0800 (PST)
Date: Fri, 23 Feb 2024 09:48:55 -0800
From: Kees Cook <keescook@chromium.org>
To: shuah@kernel.org, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com,
	linux-kselftest@vger.kernel.org, mic@digikod.net,
	linux-security-module@vger.kernel.org, jakub@cloudflare.com,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Subject: Re: [PATCH net-next v3 00/11] selftests: kselftest_harness: support
 using xfail
Message-ID: <202402230947.614061ABBB@keescook>
References: <20240220192235.2953484-1-kuba@kernel.org>
 <e0ce5ab05a0fc956ccde61686d7c6c90026e3909.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0ce5ab05a0fc956ccde61686d7c6c90026e3909.camel@redhat.com>

On Wed, Feb 21, 2024 at 01:03:26PM +0100, Paolo Abeni wrote:
> On Tue, 2024-02-20 at 11:22 -0800, Jakub Kicinski wrote:
> > When running selftests for our subsystem in our CI we'd like all
> > tests to pass. Currently some tests use SKIP for cases they
> > expect to fail, because the kselftest_harness limits the return
> > codes to pass/fail/skip.
> > 
> > Clean up and support the use of the full range of ksft exit codes
> > under kselftest_harness.
> > 
> > Merge plan is to put it on top of -rc4 and merge into net-next.
> > That way others should be able to pull the patches without
> > any networking changes.
> > 
> > v2: https://lore.kernel.org/all/20240216002619.1999225-1-kuba@kernel.org/
> >  - fix alignment
> > follow up RFC: https://lore.kernel.org/all/20240216004122.2004689-1-kuba@kernel.org/
> > v1: https://lore.kernel.org/all/20240213154416.422739-1-kuba@kernel.org/
> 
> @Shuah: it's not clear to me if you prefer to take this series via the
> kselftests tree or we can take it via the net-next tree. Could you
> please advise?
> 
> thanks!
> 
> Paolo
> 
> p.s. if this was already clarified in the past, I'm sorry: I lost track
> of it.

Given the urgency for net-dev and the lack of conflicts with other
kselftest changes (AFAICT), I would assume it would be fine to carry
this in net-dev (especially since the merge window fast approaches).

Shuah, any objection?

-Kees

-- 
Kees Cook

