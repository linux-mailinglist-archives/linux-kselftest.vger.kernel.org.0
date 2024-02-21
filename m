Return-Path: <linux-kselftest+bounces-5107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FB485CD23
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 01:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A7C1C2203E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 00:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE39E4694;
	Wed, 21 Feb 2024 00:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KsyUGATl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A00FC16
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 00:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476731; cv=none; b=TULaTEDyeL40CxMThhMXad+T7jWdT+8VAZVfup6DLr3pZS28UA042z7laRRTstuTg3dDWy78XES2r23O24DF1ty8fs/JyFyPUHzeQvwocczD50PuaWfk9bLiNzimLB0pz304nv/HnKl1vmyPwNlsP2dF9Pojli6emIT3eTa8nA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476731; c=relaxed/simple;
	bh=9WK94qUvGMIRtk5etx9mPVS0NZhg+Y0iswprAI7O23g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFxM/hzuAQdKcVarG8kvMxJAoavDdMbgfRS2cug39LxTY77ol4oIQqnddbYx6eZB2/XcuwZ4JjcHiWkvMvJzYMY6sFFG0hADzo8js713wnP/Dnw2y8ev1aIrHKRl9LKyc8sU//tLai01kw0YdPtS9G3txADCYkBXSTzj92AhoKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KsyUGATl; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e47c503fb5so1029576b3a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 16:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708476729; x=1709081529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2lCsz+v1VYXLr/Jnw9QhtpXgqVzJI761uB6BfnSGSFk=;
        b=KsyUGATlaZzXszYjBLJulj5f/Z7Kazsm0oYKerlLwdKMzYN9Fl5TRD6KwUgKRocFgc
         CcGRHHqp4eWDVzOhXFwtg+NG8Yq+yaXGs0N4Q+jIm2wEC36QIQEz5KKe8+PbsjqgF+RH
         7+29cTGKNw37BA5olsmu+o7MYnPHrkP8oeAXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708476729; x=1709081529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lCsz+v1VYXLr/Jnw9QhtpXgqVzJI761uB6BfnSGSFk=;
        b=q+3GSaW7kyes2aKCmgaksyxGz60yn8xOcWMW5EX2NH2ZYHc1y+ramplEDvvLsdwvRB
         m5lNF0Ur6pmfdtTV0dXZqgxNCyqZIXgZGYlxolCq/k9lTcCdNYQitxm2JDswNEvIgJx+
         IgeGVB61MK0PvCI9v/vk6sYu1nxxlLrYjuqaRQgQ0is8dZfclxDqhx+OGHAz7vDsIFUe
         u/7h+4BWZOpKgl6v47j4hwsD6D81rNdwiNdr29jxQGSS3IHHpqETPhHhXt409VEYvvJr
         N6UmQy2482bMKSiyiAen1JMaveB5TB7lDkHMk9+e1+UsSxdNY+DHpptyW4GamssaSi5I
         7xqg==
X-Forwarded-Encrypted: i=1; AJvYcCUoMAd1PjnxafJVJIdxsH/kDR4IBAKSvQH3yQJo5GC9a+udQRPtFSZCVo7shr0hUIDCSvDmC+hcjwc8vQC25unVKlOcub7zliqjrT7McPa6
X-Gm-Message-State: AOJu0YxKLhpnh2bSSewK2zbAZk7y6zpEPm1fcN3m13aD82i7wlIu8wJI
	Wds2te2tfgLtWcweHSOp40lUZgIHO0KMXvNvDHdEGsMgM6O+58qSMJqUGXBHZg==
X-Google-Smtp-Source: AGHT+IGDKq1WFUbJKN04lJUQbFzZp5Vh6ABFfgeZYdhAWawTlpOMDmSDbq+YYY1nfxnYxMDPBoRY+w==
X-Received: by 2002:a05:6a00:22cc:b0:6e4:5a51:80f9 with SMTP id f12-20020a056a0022cc00b006e45a5180f9mr11536963pfj.22.1708476728817;
        Tue, 20 Feb 2024 16:52:08 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c11-20020aa781cb000000b006e11455bebbsm7431202pfn.84.2024.02.20.16.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 16:52:08 -0800 (PST)
Date: Tue, 20 Feb 2024 16:52:07 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, mic@digikod.net,
	linux-security-module@vger.kernel.org, jakub@cloudflare.com
Subject: Re: [PATCH net-next v3 10/11] selftests: kselftest_harness: support
 using xfail
Message-ID: <202402201651.7C25039529@keescook>
References: <20240220192235.2953484-1-kuba@kernel.org>
 <20240220192235.2953484-11-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220192235.2953484-11-kuba@kernel.org>

On Tue, Feb 20, 2024 at 11:22:34AM -0800, Jakub Kicinski wrote:
> Currently some tests report skip for things they expect to fail
> e.g. when given combination of parameters is known to be unsupported.
> This is confusing because in an ideal test environment and fully
> featured kernel no tests should be skipped.
> 
> Selftest summary line already includes xfail and xpass counters,
> e.g.:
> 
> but there's no way to use it from within the harness.
> 
> Add a new per-fixture+variant combination list of test cases
> we expect to fail.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks for this implementation; this will work nicely. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

