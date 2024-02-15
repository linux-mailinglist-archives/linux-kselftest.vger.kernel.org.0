Return-Path: <linux-kselftest+bounces-4714-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9265885585C
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 01:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4728B287A12
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 00:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A764C818;
	Thu, 15 Feb 2024 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="INrSyyJ+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20097623
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Feb 2024 00:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707957624; cv=none; b=CCMSHEV68BuYVrgt18bcfQHXXnb3vM09XK7JECoZjr4+//dtnzpuH8JiauWtlZVzQ/ZRIH1I4ky8VM2tfMEOm86HUhoErIRXbkDN+eDmiDYcM2SNT+iOxSIphtqcquGQ8CtGfp3Zbi5K9onrDYDmR4pIHJS3bmBkGx/KZRH2N+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707957624; c=relaxed/simple;
	bh=Q9IeUpIJA0j86M2DqhKzbwQToSPMVb/PtqeD7PQAZ2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oauWCzmsFq8k47m6tOV3cgZhdthEIcwhKjnf05jcL4vj6UvmBFeEZRoH+3fTnP9nxlwVVaoYLI6VVWHX+3ZOrIJ5IRl8YKwKFMr+gi3AsKl4nqDP/AsAICXvZyl2bfTkioudsUtmy53uy45QhD8xEjUDLungt0BP0r02eZ4IeW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=INrSyyJ+; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d918008b99so2542405ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Feb 2024 16:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707957622; x=1708562422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uwcMgjPyVlBAmwoFyTwsrTj2qvQr3k5FygwJVgzdCmc=;
        b=INrSyyJ+Me3VRIS3L9VaRFTK/RR9l+ukft3dwQJ7XxvrQBijOWEoOkkxHQySMWXJ92
         VeHTWNPnL4it+1sO63S5GzrLDsx3b2kzahrlR3NJUEkzn0UCEOU6siaEzuMiebdu3p1U
         IFcD+345Pqq8CUfr1APBHndeo17Xce6xJajPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707957622; x=1708562422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwcMgjPyVlBAmwoFyTwsrTj2qvQr3k5FygwJVgzdCmc=;
        b=vYgRFjqSGu71jcmlEnMRXDaz9YNWiqup6jXnY9CmEg1SkdZceRg32cLGIo/vhlQ7LQ
         JFiioCIV/IgSku6r3F4hv1wOy2me0y3R3TDDUjCNfuXNn4sRKotKxRLxMuous/iFzoTY
         Ro09YYz4BQqcf/IvmGm5koal1bZAokbU06W5DrU1I74DJpmFbujwI1u7cJ3KGHxsMxqg
         H1tF00EWKwdLqaoSlFkrDp9RScU2wFGEysE3PiSuByFVwM3ZDKOtAPqCcuXUytLj/6jC
         bxwM4gFzcwtrqQ8nOf5LcFSMpdt+RJIlNMQhgB32uPXyWKDjMbBBd/h1Zd3qtl8Wlokv
         s1Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUNBu8aRKEWvZCKp1kuZ8RwRKlxNCMPUj3uCmK9WBtyXhKFCIZsL+TK1Lcuow7NFpDCRF4f3LogcBzSjnk9hiWyDfEhm3kR2xnpQ+tTEEwD
X-Gm-Message-State: AOJu0Yyx7bx2rtj74pHEhZatjDQUn7K098R8eBH8VmSbWtFdMp/Hc0je
	JWcc56sc8CY5I3XfuSDPStl94nPX2JE+madclRHR41vfDyxiIFhMQ3gXZvw/VA==
X-Google-Smtp-Source: AGHT+IHf+svFTUBLyHlRK2LgJNWl8mGOFquGWqMmr86+ocvziB2WifvIOl6dECgfNhbPclIKpKALEA==
X-Received: by 2002:a17:902:c105:b0:1db:68cc:61fb with SMTP id 5-20020a170902c10500b001db68cc61fbmr283463pli.35.1707957622498;
        Wed, 14 Feb 2024 16:40:22 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902684c00b001db55b5d68bsm51299pln.69.2024.02.14.16.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 16:40:21 -0800 (PST)
Date: Wed, 14 Feb 2024 16:40:21 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] selftests: kselftest_harness: support using
 xfail
Message-ID: <202402141639.B84F9F9607@keescook>
References: <20240213154416.422739-1-kuba@kernel.org>
 <20240213154416.422739-4-kuba@kernel.org>
 <87o7ciltgh.fsf@cloudflare.com>
 <87jzn6lnou.fsf@cloudflare.com>
 <20240214162514.60347ac2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214162514.60347ac2@kernel.org>

On Wed, Feb 14, 2024 at 04:25:14PM -0800, Jakub Kicinski wrote:
> On Wed, 14 Feb 2024 22:46:46 +0100 Jakub Sitnicki wrote:
> > > On second thought, if I can suggest a follow up change so this:
> > >
> > > ok 17 # XFAIL SCTP doesn't support IP_BIND_ADDRESS_NO_PORT
> > >
> > > ... becomes this
> > >
> > > ok 17 ip_local_port_range.ip4_stcp.late_bind # XFAIL SCTP doesn't support IP_BIND_ADDRESS_NO_PORT
> > >
> > > You see, we parse test results if they are in TAP format. Lack of test
> > > name for xfail'ed and skip'ed tests makes it difficult to report in CI
> > > which subtest was it. Happy to contribute it, once this series gets
> > > applied.  
> > 
> > Should have said "harder", not "difficult". That was an overstatement.
> > 
> > Test name can be extracted from diagnostic lines preceeding the status.
> > 
> > #  RUN           ip_local_port_range.ip4_stcp.late_bind ...
> > #      XFAIL      SCTP doesn't support IP_BIND_ADDRESS_NO_PORT
> > #            OK  ip_local_port_range.ip4_stcp.late_bind
> > ok 17 ip_local_port_range.ip4_stcp.late_bind # XFAIL SCTP doesn't support IP_BIND_ADDRESS_NO_PORT
> > 
> > It just makes the TAP parser easier if the test name is included on the
> > status line. That would be the motivation here. Let me know what you
> > think.
> 
> Good catch, I just copied what we do for skip and completely missed
> this. As you said we'd report:
> 
> ok 17 # XFAIL SCTP doesn't support IP_BIND_ADDRESS_NO_PORT
> 
> and I think that's sort of closer to valid TAP than to valid KTAP
> which always mentions test/test_case_name:
> 
> https://docs.kernel.org/dev-tools/ktap.html
> 
> We currently do the same thing for SKIP, e.g.:
> 
> #  RUN           ip_local_port_range.ip4_stcp.late_bind ...
> #      SKIP      SCTP doesn't support IP_BIND_ADDRESS_NO_PORT
> #            OK  ip_local_port_range.ip4_stcp.late_bind
> ok 17 # SKIP SCTP doesn't support IP_BIND_ADDRESS_NO_PORT
> 
> I'm not sure if we can realistically do surgery on the existing print
> helpers to add the test_name, because:
> 
> $ git grep 'ksft_test_result_*' | wc -l
> 915
> 
> That'd be a cruel patch to send.
> 
> But I do agree that adding the test_name to the prototype is a good
> move, to avoid others making the same mistake. Should we introduce
> a new set of helpers which take the extra arg and call them
> ksft_test_report_*() instead of ksft_test_result_*() ?
> 
> Maybe we're overthinking and a local fix in the harness is enough.
> 
> Kees, WDYT?

Yeah, let's separate this fix-up from the addition of the XFAIL logic.

-- 
Kees Cook

