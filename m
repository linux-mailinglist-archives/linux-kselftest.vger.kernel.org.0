Return-Path: <linux-kselftest+bounces-7295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2703A89A147
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 17:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98E15B2548D
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 15:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E755616F91D;
	Fri,  5 Apr 2024 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IozsLkcW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E5A16F907
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Apr 2024 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331145; cv=none; b=Dz8Df+mWKOfA/Jpr2y3FJc1Ac6BxFpF2ZGWH1ed4M+E0v+C5IU1i68yJqJ5nTUCtugXDQP5vCCWd0Jr4oF4oGn6RRcPEIAezDbZ5MgiKz8GCq9jQDjZZ6c0BIdncMjXNCOk6zF+p/T0QtCZEvNSBA03JwAIdRDFkY5tX7Sv/S34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331145; c=relaxed/simple;
	bh=7EromWr0XaULO1KfVY9RUjIf9QiuQBRV6BTlvsJvh6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shd2iNQ3/3AUt8Gg45OJ0E/wbRaUn5FxDuXKlGuo1lWgxotl7of/8xqr+PQQpIQHMd7j5OKy261hVhJg1hnI+QYy3Of5NH8NnmXhpGtSn+6Kr19sFh2/FZcN2gD4NTCOvbWskucTXXmLI5c13NPDnhYHGe8+HffQjVQwqR+btdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IozsLkcW; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e3ca546d40so4014755ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Apr 2024 08:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712331143; x=1712935943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3zCHuG1riB67zTF6cGFfKkOo6cTBnZXN81xTdOBpCWY=;
        b=IozsLkcWRI5168jxUKU/GQcSs9LOPpGniS3WckvW/fu2aEpu5cSajns+SXuG17A2vI
         LiziQjjmbUruurUN1jmO+0qRgxqnVmRjDrshsDhvAgxTU00y2SvSKMCjXVbhhsFsvR41
         a4kUdgEFDe5ovegHuA1MxMD4CO4dRkjxnSuvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712331143; x=1712935943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zCHuG1riB67zTF6cGFfKkOo6cTBnZXN81xTdOBpCWY=;
        b=HwcdCL/o64BI+IDy1SxLIQ6pzRslJN/JPVBIVwIkksvBQ3REHkPDIitO+IsYpukNGc
         PNIcZGYLyZ2+3s28JcUnuR2NCIfyXSXDzTAFJv6CC9hOsAhYWMFph9xvX3FSKvUnnqfp
         cbXHtKTwSSvg9XqeI0J+moGeJkxCY85W48RnO15kWWkXv5wQYsc2y3pdi7SJv7vN98bT
         mqNU1K3cqSVcgUcx9NDWNI2JBUcbr7SeADwSJQLQNgYWw2MrxvVHBJfTJEEC1MlbVqDO
         OQ/OJ0bZOSuTPc5D8CUEzs63vmqrrWS2JKD9zbQ6CJoUK3j3svH86L4imkeZm5t/0GTa
         3YHg==
X-Forwarded-Encrypted: i=1; AJvYcCXkiZD6gA/7cNwLjeimnvlDKyWBzXng13HG41gJtODmppi0mQ64IWUxFT2CnqSMMFt98mVKd+v+0hyIx1kNk0VaRiBn0YxvczE0peWOhiRo
X-Gm-Message-State: AOJu0Yx/QXNFqWBltqL603dqxhHpTjRgkEkATCLAgzunMdwsaOJ/2Z+P
	ZUlTP9xnlhmhDk8Wj20iv9CXN243jsGcmJXQ5GTUkB1jBKaQgmZP/W1BlpH42Q==
X-Google-Smtp-Source: AGHT+IEcd30JQvThROXLk6blXSCc/d9PBNI1VHjF0rNb0/xAuRQY0RK64NghWzC/QEFJnHzUbp+dIw==
X-Received: by 2002:a17:902:ed8f:b0:1e2:577:f694 with SMTP id e15-20020a170902ed8f00b001e20577f694mr1785714plj.61.1712331143586;
        Fri, 05 Apr 2024 08:32:23 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j5-20020a170903024500b001e29c6d5084sm1698784plh.227.2024.04.05.08.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:32:23 -0700 (PDT)
Date: Fri, 5 Apr 2024 08:32:22 -0700
From: Kees Cook <keescook@chromium.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH 0/2] selftests: Replace "Bail out" with "Error" in
 ksft_exit_fail_msg()
Message-ID: <202404050832.187F972C@keescook>
References: <20240405131748.1582646-1-usama.anjum@collabora.com>
 <2a77adeb-ed22-4a9b-a1d9-ac5d29ae696d@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a77adeb-ed22-4a9b-a1d9-ac5d29ae696d@linuxfoundation.org>

On Fri, Apr 05, 2024 at 08:56:31AM -0600, Shuah Khan wrote:
> On 4/5/24 07:17, Muhammad Usama Anjum wrote:
> > "Bail out! " is not descriptive. It rather should be: "Failed: " and
> > then this added prefix doesn't need to be added everywhere. Usually in
> > the logs, we are searching for "Failed" or "Error" instead of "Bail
> > out" so it must be replace.
> > 
> > Remove Error/Failed prefixes from all usages as well.
> > 
> > Muhammad Usama Anjum (2):
> >    selftests: Replace "Bail out" with "Error"
> >    selftests: Remove Error/Failed prefix from ksft_exit_fail*() usages
> > 
> >   tools/testing/selftests/exec/load_address.c   |   8 +-
> >   .../testing/selftests/exec/recursion-depth.c  |  10 +-
> >   tools/testing/selftests/kselftest.h           |   2 +-
> >   .../selftests/mm/map_fixed_noreplace.c        |  24 +--
> >   tools/testing/selftests/mm/map_populate.c     |   2 +-
> >   tools/testing/selftests/mm/mremap_dontunmap.c |   2 +-
> >   tools/testing/selftests/mm/pagemap_ioctl.c    | 166 +++++++++---------
> >   .../selftests/mm/split_huge_page_test.c       |   2 +-
> >   8 files changed, 108 insertions(+), 108 deletions(-)
> > 
> 
> Andrew, Kees,
> 
> I will apply these to linux-kselftest next as a series since these
> changes depend on change to tools/testing/selftests/kselftest.h
> and need to go together.
> 
> Are you okay with that?

Sounds good!

-- 
Kees Cook

