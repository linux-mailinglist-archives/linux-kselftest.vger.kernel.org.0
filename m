Return-Path: <linux-kselftest+bounces-10671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A998CE7B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 17:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FBC91F22120
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 15:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F5B12DDAB;
	Fri, 24 May 2024 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fh38IQp/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E715EEC7
	for <linux-kselftest@vger.kernel.org>; Fri, 24 May 2024 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716564023; cv=none; b=AjOhfc5qUeBHoEkdkGvbDgtJ3KVmSGgVqi8i1WVulkt3djtLhY2yQIREuIwZBea93fp7QUkdZiqwwsE1NSTklhwr9T9L7W1apdaAGcDz4PuWshUgbvcJQEe294qNXQRYo9//buI2qpyZAuBu1vSLImbkuERo5r1Y94O3KR+HR+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716564023; c=relaxed/simple;
	bh=RV6GVQYfwTsyL7UPNTTHnloYfII7Z62+QtP4agNDYW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLJa9+zPtjQ980IB/NpxPhq/+Mzb22POWR6Xd6GG+COZuOb/qDnOLs5Pxbf/fPnzCB56mmXzJbePzE3lFKc/CWSb4gMXZnmnz9OYeaPXHgdyNSRgMXtu5lz1JEaDdOPxHZVQ5w/UgQMw2+BQsCsgS4jHC3g8wlSRLx4uFIxm1V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fh38IQp/; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a5a4bc9578cso1274104266b.2
        for <linux-kselftest@vger.kernel.org>; Fri, 24 May 2024 08:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716564020; x=1717168820; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ANScwS6KgdmEu/PK27HSIOzuKwtA30ga/nb++C3vkQ8=;
        b=fh38IQp/aMmMQQA4BZo/qZfrYrMMAyeUgjnfrKUon6eT8gznWavPGh51IQpXzhAyKL
         2qMuXEvQ4AG61g2LjFqoSS5uJ57CqD6Qls8wulZxjYabIo7cPXejklegKR7+d5hsnuwX
         60XqkpNJm9bAniCH7/Rh04z7hTl9K9DXcC3yE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716564020; x=1717168820;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANScwS6KgdmEu/PK27HSIOzuKwtA30ga/nb++C3vkQ8=;
        b=XUwEaCcw6ARh21jxPtXTpI28HDVAySziGOlFkTxPeQpQ75SnwsoB+EIDvIqaThRkLi
         LFCp0WNrw8pdDf58b7E7Rhj16L9iVwHQsCT0dmC2IeFvvdLP1Bn7AFCJ/eD3IC9fkxMC
         /zmbbkVhBG4uwZ6B1AIC5WlIOPLDb8hxSavx+3Hgx4ORIlP8TAZZ18ZDwHPO205uTJQm
         WlKG4ZdlqC3ELuiCWHxb8fa5zGnColfxcqF/3T+e4WBpo3Us6W7fQ9XnD0ymvtnxhpV/
         9kAaNz8A/0M+CyZ5Dyh+HtixacQTxYUQ3ARbtemlmrFt23MNhfglpkYN4AwGlXwIJ9zA
         aDjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPkG9iY8RygXKJZpoUTNrxMZNQNJEw5pMVdoGLu/cUDD/43gVJLOYsuNr8UhChU8WMba5DuclXBn63gI+MMIkm642YX9Rj5wcFN+AQlfxS
X-Gm-Message-State: AOJu0YwVah4QnhCUakZ1/TIOrkWwZOBGhU5Rv5kPqGa1gq22PZDAgsGl
	fKEt/HFEMLWvMYVtMxvf7DYUshiRBsrBCWwszCR8cVMB8vcPRQpGRmRT49T6Jg4463axzJWaYoO
	n0FKAUw==
X-Google-Smtp-Source: AGHT+IGSFBd5BLbRuOzyACInMt7ku9H0hIYCdENRyiJfj9AoPfiBW0OekmebJ2d2nzQpP+cgZj2sag==
X-Received: by 2002:a17:906:b0c5:b0:a59:a48e:34 with SMTP id a640c23a62f3a-a62646d1dd9mr253034966b.32.1716564020264;
        Fri, 24 May 2024 08:20:20 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cda4b99sm144006666b.204.2024.05.24.08.20.19
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 08:20:20 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6265d3c488so139850566b.0
        for <linux-kselftest@vger.kernel.org>; Fri, 24 May 2024 08:20:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGvU1JANfAsUApMAf35BavGdWK7/0CAOOkCf1eujEb5c5m8FXco4FfrO1fmhWRnL496kscrF5TiC1S22kx2EKtoK3tOPUlpgXgcSx12r1M
X-Received: by 2002:a17:907:bd1:b0:a5a:893a:a73a with SMTP id
 a640c23a62f3a-a62641c2e68mr221556166b.10.1716564019461; Fri, 24 May 2024
 08:20:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
 <202405141251.8E9580E@keescook> <202405231628.BBBB9787F@keescook> <20240523165418.242555ffc2372e59f88cabbf@linux-foundation.org>
In-Reply-To: <20240523165418.242555ffc2372e59f88cabbf@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 24 May 2024 08:19:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiKNsQck3eGc37Da7hAKDNL6S9viwV8ir8BFTu7dsig6g@mail.gmail.com>
Message-ID: <CAHk-=wiKNsQck3eGc37Da7hAKDNL6S9viwV8ir8BFTu7dsig6g@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Introduce mseal
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, jeffxu@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	usama.anjum@collabora.com, corbet@lwn.net, Liam.Howlett@oracle.com, 
	surenb@google.com, merimus@google.com, rdunlap@infradead.org, 
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 May 2024 at 16:54, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> The testing and implementation review seem OK.  But from a higher-level
> perspective Linus doesn't seem to be on board(?).

Oh, I'm fine with mseal.

I wasn't fine with the insane "m*() system calls should be atomic"
discussion where Theo was just making shit up. I honestly don't think
mseal() needs it either.

               Linus

