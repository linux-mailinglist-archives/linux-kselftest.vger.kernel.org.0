Return-Path: <linux-kselftest+bounces-10320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACCB8C7E8B
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 00:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058D6282CEC
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 22:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF4E381BA;
	Thu, 16 May 2024 22:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oKOTPOm0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E0525622
	for <linux-kselftest@vger.kernel.org>; Thu, 16 May 2024 22:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715898606; cv=none; b=S0L0nh168YnA4YG7IaDOio+KY6SJUeqU8Qdspg30eYeZlnqkg1LpZMJE+x5MpUEaTNfRmqz5mAIr8Ohxk9MFKjSSZFPKx42VEd1SV0HeaOz2pSUqh1ZOV4rHhEl9l1TVI45YNONpugTsy0wcXA7mhLgmhbRvojPeS0vsoNdbOUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715898606; c=relaxed/simple;
	bh=bxJEArpiEg25RQVYJ7nQ2XjgM8pmuWp4LpMZBqOClSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEmBAW/G3iH1XuAaDt1N1DqvGeyDmxrpHoLUTdkHPM1lSK9rp2NZuvtQLZO+kXchTcyLCynsvEDZZgfBNe99KUZ/Qf99RnHmSAneFLi2iGVz4BzngYMUyKjCSLTLQyPQJ0nR0iAqMjjO+btTeOytSoJFGH+qeASBc7a+ju4XvEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oKOTPOm0; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f0537e39b3so283325ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 16 May 2024 15:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715898604; x=1716503404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hxv5sqy4ckTc1L4pK/+kikfrwo0o601loVWwBqZZcRA=;
        b=oKOTPOm0cF6YZHXG39HygnpLjkLYCHKVRctrkfe0HOzqj6cq1poZt+Y2szOiA/TOfd
         p9JgjJyVXHGh8r/+ySsSlaFLaIhgHw0cNdtmDItEF1LfTqvXm1/s0poxHG22CRNwXNym
         fjFcRjZGAMSFh09qIxwPkI8VwCRbKLo9BJTH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715898604; x=1716503404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxv5sqy4ckTc1L4pK/+kikfrwo0o601loVWwBqZZcRA=;
        b=LsWNiRUQbGAfzlWpzERNY5qjYuZuJIDZTbjoZmw5xIpcnSpjWZYBa2QyaiC63n76Kj
         ckxTnj9awETS60trHBFGeqVbjVKFSOuANsfCsNqcG+jHel4S67v2gFI6hx8LGPNykIpe
         qdnywPoHNXY8rAbOHosiFfgoJzdezkfngZw8rEtl3bflKiFprO2PH3PaILwL8aYURdzD
         pblz9zjxtOOGvOns2GWVEd8jmncTdDcMKz6cJbdwYCRGXJ4w3EL/CB3HgGNbe0DvYCCh
         GhK1T5rIf0h1rVKHyn0lqu7Wcr0ZgAGkC+uypkFxE2yrV99SGMtGQtjsw0tn/2dzjtQE
         C4tg==
X-Forwarded-Encrypted: i=1; AJvYcCUoOW3CpWDPzkCAbLW5GBRO6cZr/x/IUrCru5/6XqDQCddia7lmSkWift8F2Piqrpl5FqCAT01VgkkNUDRDNbErJnQlV/jLb/WhlXT07M/l
X-Gm-Message-State: AOJu0YwCnDvMwW1y1AMMJxa1CzfRmWrAnEdUPKaiORXuh4PTJAXK2xtm
	pcuNT62ljXhR5poAXWhy1UZ/GOrJo9G3eSLYN4si4o0gV8h/WBS783cJuhxZyA==
X-Google-Smtp-Source: AGHT+IFjAjuJ64KMGDPWNwFpNItuwLnAZXU5qrJU+caeXV3r2Su1wQ35UrWZx4wDd/Noatyf85y8Lw==
X-Received: by 2002:a17:902:dacf:b0:1ec:c9e0:c749 with SMTP id d9443c01a7336-1ef440505a0mr240359545ad.48.1715898604590;
        Thu, 16 May 2024 15:30:04 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c1394b8sm144923735ad.271.2024.05.16.15.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 15:30:01 -0700 (PDT)
Date: Thu, 16 May 2024 15:29:55 -0700
From: Kees Cook <keescook@chromium.org>
To: Mark Brown <broonie@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>, Edward Liaw <edliaw@google.com>,
	John Hubbard <jhubbard@nvidia.com>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest: Desecalate reporting of missing _GNU_SOURCE
Message-ID: <202405161529.1D2B5F3CCF@keescook>
References: <20240516-kselftest-mitigate-gnu-source-v1-1-a0e814ff2874@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516-kselftest-mitigate-gnu-source-v1-1-a0e814ff2874@kernel.org>

On Thu, May 16, 2024 at 04:28:48PM +0100, Mark Brown wrote:
> Commit daef47b89efd0b7 ("selftests: Compile kselftest headers with
> -D_GNU_SOURCE") adds a static_assert() which means that things which
> would be warnings about undeclared functions get escalated into build
> failures.  While we do actually want _GNU_SOURCE to be defined for users
> of kselftest_harness we haven't actually done that yet and this is
> causing widespread build breaks which were previously warnings about
> uses of asprintf() without prototypes, including causing other test
> programs in the same directory to fail to build.
> 
> Since the build failures that are introduced cause additional issues due
> to make stopping builds early replace the static_assert() with a
> missing without making the error more severe than it already was.  This
> will be moot once the issue is fixed properly but reduces the disruption
> while that happens.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

