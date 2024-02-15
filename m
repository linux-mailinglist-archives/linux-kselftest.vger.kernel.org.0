Return-Path: <linux-kselftest+bounces-4789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C46B856B32
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 18:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7EAE285C74
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 17:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96D1138481;
	Thu, 15 Feb 2024 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eQO52yak"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F80137C5D
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Feb 2024 17:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708018691; cv=none; b=c7hItQ6m4fkXfTwiohBhXuZ3ffBY7kRWn8PKARWqFSuNdHpejcgBqtYLU/XjKI4UtzYSbvRL0vfug6JWfs8xrJ4nh8AgBe4gBNI7VwkdYrErrvWaZ2l1zY7RMpwvRN9Rfw2/zf0+EJvNZYSqEKmHKpvnL892ERwfqgkd94T1oaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708018691; c=relaxed/simple;
	bh=CmA2yNqbhHxRJP/sPUsviXqi+eveftIcv605DlHS1OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhIf6nKay0WTmZwPXykjrkgciqS5VJQjSvCYNxCzd/Z7alROXZHSDRS9CbRlyTUg1jsddqPGNi5XsAJZU+93zOD7K4rmoj3cJOP5hkNuEJUWQUk0T0qk3cMhJ2FBy0UTQo/6N3VyldzqNFFt4QWDB3xRI/PwORZ5BtZdGjnAvVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eQO52yak; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e09143c7bdso768250b3a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Feb 2024 09:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708018689; x=1708623489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WKujQBQrVUJjXR80iuACMbDhu6cNiLpIU8q///YY7rg=;
        b=eQO52yakXn32UfP3BdzLziWgogY/qQw7FaSCkE5iIrnX8qgGech6NCf46WztkBTJvq
         BRkqKGGRJt8MkR3n+k6HR6I6Jrbhaz2uCUoqPJW+IAQjdgiPaGw1+rak0J7p3YBfBhbe
         MXc60dUUqvc2NwnRBgQlKoRJK9gmUr2oTSDoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708018689; x=1708623489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKujQBQrVUJjXR80iuACMbDhu6cNiLpIU8q///YY7rg=;
        b=UlAHUzRLUgByEFNwwWzXbyOc4J4we0Tfv+Y7SdMCHs+0KvZSwMuSnbibcm3kMXh/kd
         r0f1bEW9RAuoZZl0UiopeppkOfnkoymElbvYZFFH6tQSNZYyGn5g5T4e6MYYVHWdBCUy
         FZepiHEJ3pYprT1o0BX6XAY0dxYvQpObRBWDzoHnyWiV+u0WLVqwrBRYRlJfsv9ifnju
         gYAYba+beR15mi9BFk5Bgs2CWvFV+vFjatguGnXPUnfAdOYHeYEVMHInG/ELG65Dgh1U
         yOqvQDOUHU93OmkSJZ3CzNk8wxLQXFZMWSc4vuPIzg2jHJNX7L9zVo0hdlJOgUWwtfuH
         tK8A==
X-Forwarded-Encrypted: i=1; AJvYcCV9Aq/mcboDyGyVCXWu98I4xynnSSoyqY/SQe+NApQF/zmJipKMLQPebIbmtao1EGwQu/QHPnLKS00iduDfwqOxGRBYTtXpFuM3Chhv1Ed7
X-Gm-Message-State: AOJu0YzBr7RqqApkLD57NPkW1NgZNeLTGSW98opLg1WTT+xTilGW57JM
	iXdOoO8Wotg2wCQ4TVZBT+KYXF7kcnEak1Ndf7yawj/UHiIrc33MGSLqoX6hcg==
X-Google-Smtp-Source: AGHT+IEmUMsadd1ltbUlWE409OqLhKhvGNE10Bn2f8xDtB+k6aT9AM3aTWrJUCSsRXb5eYsZq3jeBA==
X-Received: by 2002:a05:6a20:d90c:b0:1a0:841a:64c3 with SMTP id jd12-20020a056a20d90c00b001a0841a64c3mr928295pzb.39.1708018689482;
        Thu, 15 Feb 2024 09:38:09 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e4-20020aa79804000000b006e02da39dbcsm1665651pfl.10.2024.02.15.09.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 09:38:09 -0800 (PST)
Date: Thu, 15 Feb 2024 09:38:08 -0800
From: Kees Cook <keescook@chromium.org>
To: Rae Moar <rmoar@google.com>
Cc: frowand.list@gmail.com, davidgow@google.com, Tim.Bird@sony.com,
	shuah@kernel.org, brendanhiggins@google.com, dlatypov@google.com,
	tytso@google.com, gustavo.padovan@collabora.com,
	ricardo.canuelo@collabora.com, corbet@lwn.net,
	kernelci@lists.linux.dev, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [KTAP V2 PATCH v3] ktap_v2: add test metadata
Message-ID: <202402150937.3CAD9E69D5@keescook>
References: <20240215171859.1907668-1-rmoar@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215171859.1907668-1-rmoar@google.com>

On Thu, Feb 15, 2024 at 05:18:59PM +0000, Rae Moar wrote:
> Add specification for test metadata to the KTAP v2 spec.
> 
> KTAP v1 only specifies the output format of very basic test information:
> test result and test name. Any additional test information either gets
> added to general diagnostic data or is not included in the output at all.
> 
> The purpose of KTAP metadata is to create a framework to include and
> easily identify additional important test information in KTAP.
> 
> KTAP metadata could include any test information that is pertinent for
> user interaction before or after the running of the test. For example,
> the test file path or the test speed.
> 
> Since this includes a large variety of information, this specification
> will recognize notable types of KTAP metadata to ensure consistent format
> across test frameworks. See the full list of types in the specification.
> 
> Example of KTAP Metadata:
> 
>  KTAP version 2
>  #:ktap_test: main
>  #:ktap_arch: uml
>  1..1
>      KTAP version 2
>      #:ktap_test: suite_1
>      #:ktap_subsystem: example
>      #:ktap_test_file: lib/test.c
>      1..2
>      ok 1 test_1
>      #:ktap_test: test_2
>      #:ktap_speed: very_slow
>      # test_2 has begun
>      #:custom_is_flaky: true
>      ok 2 test_2
>  # suite_1 has passed
>  ok 1 suite_1
> 
> The changes to the KTAP specification outline the format, location, and
> different types of metadata.
> 
> Reviewed-by: David Gow <davidgow@google.com>
> Signed-off-by: Rae Moar <rmoar@google.com>

Thanks for the updates!

Reviewed-by: Kees Cook <keescook@chromium.org>

We'll need to update the test runners to adjust their outputs...

-- 
Kees Cook

