Return-Path: <linux-kselftest+bounces-9053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7B08B5E56
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 17:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A58284985
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 15:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9B686253;
	Mon, 29 Apr 2024 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ii8sjjsx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956CC8614C
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406282; cv=none; b=HCKiT/N0muBRuQF1xNlgl3nKyHT6+Tjd7VKR7lz07of8kyxG32zbl4lk5kwvZT0LABzS7glGB+zvothnDBrJwYtWldmynWbrktRg84SuwIGbag2SdrOhANa22ygXgPBIB/KCyUp4Tiespwp72OURetNo7+dNT1YPAyUDQWGd2mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406282; c=relaxed/simple;
	bh=elJxk/k9sqYtC/MCZ2vFryQvPeupAL5xKULnIW6JfRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C88dzaQRUlO5Ha2+Z9ySLesC44d02YKFqcUiUaqXWfi6fnIjXUIOEgBNi1boNNkVzX61zpuDozPcNqrsCiH0rRflzSKN1CBiXyPh8/7zDgecZ8Cm/3jI6EHiy28H4mnD1al1ABS+Dkh4AG6O3OLOGxJjXIWDnyhJuQTK5I34iho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ii8sjjsx; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f28bb6d747so3930616b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 08:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714406280; x=1715011080; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LXesceeVx7eAybXSMHvtACUpIAJaYRLCSDSMv3aiI6Y=;
        b=ii8sjjsxUUoI7UJi0f+z1jQ/aZRF88qHkGEXQDr+zAffx5BYMijcwiwyB4dFA0o9wm
         6jjVzaDFx9TOAQ+f33y8SRxnklbiFS9I6WS3Ia0t0CUD50obUEwy7AsguDN3iTo446so
         TJ1y09rTSRdkD/nIXBLNDyJ2XAji/yACrcxFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714406280; x=1715011080;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LXesceeVx7eAybXSMHvtACUpIAJaYRLCSDSMv3aiI6Y=;
        b=ld+X9X6Af9X0ZtFZBnRD5iaTHsqbQuS1DVj81oOTUNomwvgvKhbmjGcpkOFqETdQ9j
         78eHvN5X/PQLRr/GQcKqygEj+t5RiarkNUpRWIkdlk9PcNBrf0Frk+jVf5QhqxbGzUL7
         oiJIpwECSJOQxWKIGS0ogB7WMu4pN5xTMRdAVKrBh8EJQBKywDX59enxE5QYNUzdUyR1
         bVYCzqrYDIh2YaAMLW0jYtMv2o1cOA+NkXACqvZVGNT4ZD4Idgxhy28OktrlQf9zPhdq
         WeZ90Q9HbqGpnXcRciqUpAvvbC3wOAsorNOvkJ8KlVvD9JKclefGI6egdALJQcL7zG1m
         JS+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIpY4hbaTPFa/xTPQtCg/3nHyP88Es//VzzCLrAVh1XG9piT1rbjk7uNKc+yNWX3lUqoXgTRlRl0ZjJul/hcbT7ab293EUZS86jQYXh9Pw
X-Gm-Message-State: AOJu0YzSUdVtN9KQc6SoZKpEpnxzgkRzlNuC3E+Kphiifoy9q48K9k2k
	9Cs00Sr65QTUnAqy4QGwM/XVk6dtzQgQlYIsu2Eb8ZjjALTCXrgTwQchbNmCOA==
X-Google-Smtp-Source: AGHT+IH5mn+xNGRLvYr66gOyWrbSH5iYC8VFZwOPTFbEPOgPuBjIRhHvM+Dtaw5Y0QSIqnQeruOFzw==
X-Received: by 2002:a05:6300:808d:b0:1a7:6262:1dd1 with SMTP id ap13-20020a056300808d00b001a762621dd1mr9709716pzc.51.1714406279974;
        Mon, 29 Apr 2024 08:57:59 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m19-20020aa78a13000000b006e697bd5285sm19380439pfa.203.2024.04.29.08.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:57:59 -0700 (PDT)
Date: Mon, 29 Apr 2024 08:57:58 -0700
From: Kees Cook <keescook@chromium.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 9/9] selftests/harness: Fix vfork() side effects
Message-ID: <202404290857.4BEAF6D55@keescook>
References: <20240429130931.2394118-1-mic@digikod.net>
 <20240429130931.2394118-10-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429130931.2394118-10-mic@digikod.net>

On Mon, Apr 29, 2024 at 03:09:31PM +0200, Mickaël Salaün wrote:
> Setting the time namespace with CLONE_NEWTIME returns -EUSERS if the
> calling thread shares memory with another thread (because of the shared
> vDSO), which is the case when it is created with vfork().
> 
> Fix pidfd_setns_test by replacing test harness's vfork() call with a
> clone3() call with CLONE_VFORK, and an explicit sharing of the
> _metadata and self objects.
> 
> Replace _metadata->teardown_parent with a new FIXTURE_TEARDOWN_PARENT()
> helper that can replace FIXTURE_TEARDOWN().  This is a cleaner approach
> and it enables to selectively share the fixture data between the child
> process running tests and the parent process running the fixture
> teardown.  This also avoids updating several tests to not rely on the
> self object's copy-on-write property (e.g. storing the returned value of
> a fork() call).
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Günther Noack <gnoack@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Will Drewry <wad@chromium.org>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202403291015.1fcfa957-oliver.sang@intel.com
> Fixes: 0710a1a73fb4 ("selftests/harness: Merge TEST_F_FORK() into TEST_F()")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

Thanks for splitting these up! I found it much more digestible. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

