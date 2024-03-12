Return-Path: <linux-kselftest+bounces-6285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85809879E1F
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 23:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D491C212FE
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 22:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D868143C53;
	Tue, 12 Mar 2024 22:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A/TNZHOd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D001D143C48
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Mar 2024 22:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710280989; cv=none; b=MsMRWZUyYMXb3KHWs2MGfDMKD3E8d9yNWMAGLmc1x7Lu84a9ASx+rFYolh2PSJyQf3I+Q0j6HRDCHrVrU+cc8QcBkwXtzWRoklnZqm301fLBAa90flxRn4lNWGDJKNLm6tB6f5j2+GPeh1tkkSUXd0RxkrEcyyKH4b61wME08cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710280989; c=relaxed/simple;
	bh=D4lY7fxdRPJh4W1hrWZC0Kv5/fDQzdNIZGvAvIvgwj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qY/OfP4sfYTkJ2cHkPOXKLK/U8PHAjvq9r9sl6c/M/u+VrSRMDXL/tNjGPeagx+l2B1KqF9UAtrC7nT5fjuWJNny/F7OUFXfxDYga/CzCuPk0LFtjr/M3dBnsEKNkbtVg9oi0uS3zNNkosKptI6/GQMWispQzAeYQA5U9Mle7XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A/TNZHOd; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3662d7c79a9so2193655ab.3
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Mar 2024 15:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710280986; x=1710885786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bFZkOPzjUiG9hBeGxmULl/XMqNk9IbEaqEvdeXcgD8s=;
        b=A/TNZHOduTDw50espaicZGUQX6jYzVKJBdIDeVnj4Ef+T1kYvYyYeHd8S7/kNrpvGD
         3RH+VH5SOhmcdBNAHJ8Ce3Yzv+nkQ1baRzAymYdkEDF7B0Re6olgpjR2rwsAoVR/EBe7
         bazE+AsiGg4KmyHLPgOg49cRkO+/ghkrdd1OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710280986; x=1710885786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFZkOPzjUiG9hBeGxmULl/XMqNk9IbEaqEvdeXcgD8s=;
        b=B9bo52wTOOpV02XazDHG/r+gmhU4dqX378vE2LJTR9buPZn+hFmFCo2lvGFpsutt88
         BhR+MK82hMl4twmc6IepITdDvbF8hf+mUeiOGaUo6tH+iFXDb6qyHlVkT1m4O+lAxZJS
         LjNCPgRQETi/fxWY8sd5h+fML57hIKPoVS3Qvqus6OyP7rYl1HNEIeRySnGnUBCudWoM
         UTrLyQr8QYd8YlWeJ0c+vg8+nmUW0dUlILZ0IfFWOHcIIHTEMdo7Bj7fX/y5YbrVI4dj
         0S4WLMqNlrvnC/+3zTCuySJwr21L56H/5plMVpl7/xnpP9CCGfmKYocH37VBUuvbnBh2
         +FEg==
X-Gm-Message-State: AOJu0YxoNs0qmwK2kuEF2chDk2jDqg8bTQeM0arguhPq4MSl+IJVNb/Y
	/6dfLGNF77JvUqrZ6Op6BmjyqPn7lwnxawuIIxQn5vsc7Ty5DK81FJnDu8bg/g==
X-Google-Smtp-Source: AGHT+IEdwN1SY2GeciEHPDmRWgTgdPa04evl6KEFQYoPJeYQSV2BmWI4216WoCmzy6l7zJDsrZVhNw==
X-Received: by 2002:a6b:e719:0:b0:7c8:bf15:5653 with SMTP id b25-20020a6be719000000b007c8bf155653mr4918871ioh.20.1710280986087;
        Tue, 12 Mar 2024 15:03:06 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m14-20020a63ed4e000000b005dc816b2369sm6650251pgk.28.2024.03.12.15.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 15:03:05 -0700 (PDT)
Date: Tue, 12 Mar 2024 15:03:05 -0700
From: Kees Cook <keescook@chromium.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, loongarch@lists.linux.dev,
	netdev@lists.linux.dev
Subject: Re: [PATCH 04/14] kunit: Add documentation for warning backtrace
 suppression API
Message-ID: <202403121503.B97DE8A60E@keescook>
References: <20240312170309.2546362-1-linux@roeck-us.net>
 <20240312170309.2546362-5-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312170309.2546362-5-linux@roeck-us.net>

On Tue, Mar 12, 2024 at 10:02:59AM -0700, Guenter Roeck wrote:
> Document API functions for suppressing warning backtraces.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

