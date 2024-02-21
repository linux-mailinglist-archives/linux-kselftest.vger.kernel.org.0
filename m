Return-Path: <linux-kselftest+bounces-5104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA5E85CCF7
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 01:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71710B229AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 00:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEE91851;
	Wed, 21 Feb 2024 00:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="crYWPAsk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141414432
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 00:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476598; cv=none; b=cHk/X7hN/XdMyBvgy+txvQ7gx/adNwwhBO5Asvtu+CGVBKPXf6RM9+M66IlbO1xUetERcuhioJoaEJKAXd9alftbUxbakcMRermYYXJJ5t2x3J4P1Cm+vKAP2St7VZOkzHpyLO1np67YkVkWSqYJd+uQW6wSB8AC0haqo/kgQ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476598; c=relaxed/simple;
	bh=70+cboh+R10PUtYIytfNWxwR6L0MddrmKGm16ZtgHKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpvMtpeROj3H9LCbZX5zRU+ud/BZIx/L3OICfU5mQRomp/rOUXtg161lRpttzMypU3tfQaC0+p62Fj4WgaOW1AkygZcwC4MWeb9rN8dRnfwHcizdpMgwIToPIlvY+8yFU2naO5LJujAw2BFQe/mSQ5UPDdjzc5sccPdP5wzgazU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=crYWPAsk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dbd32cff0bso25976325ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 16:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708476596; x=1709081396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aEpA/O0h+RXbPW9lyhYatDMrYbk8elnxsP4c7EZA4p0=;
        b=crYWPAsku8ZcKPu6VhzjS2X3kK+6ZIvu3grSAe+n19o/qF0Nyoogn1kYP2ZiNZf5rj
         VjLgVusYRJioAGc0hcVCiWoANzhK0/okSFS+P3gKPQK+4AYe43dWSTRCW5FlFJgqw2XO
         GUPaob+7mt7FhiFiXkSBn6avtzYY9xe0U9EzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708476596; x=1709081396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEpA/O0h+RXbPW9lyhYatDMrYbk8elnxsP4c7EZA4p0=;
        b=LDiwi3RzqF9//ODN3HFr8TfCQLrnpdppgLXHrOkKcCina0c6u8qPlWnxI4lVwTsiFs
         0ujrtpxuvxV2NBqHJpyQucNErgaFxh+cEY0wBRBAt7fngvHM9TyGJTJ8YiiBPQQ7Jh+y
         5U5ZoZXqJpeSVmlZWrX4VipDepu1soAXjqr0WjDIwTPVkeORuzx8KpJBz+Mz9qG3EILx
         6xpntACdlK1/HX1lzvMpdVMTWPMXuilNmNJZge+BtO6u0iwDfpZYvWzWz6wW37x3Hd7W
         S2w/weiq+GgrCVaBc4L8EvTxglb+iQeGyVdYzkEFew/glXr1EgxJprVgoqpuQuI7xniW
         D1bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIXQtfMvTIScu1FGQMuXb1cgSi1eBSevdU5SImkHx01SgVM8lrH2jUOa23q4oJWih2Xr1WJsD34j/t/HoxAJL9aplZ0NH0Y036e9MDJB8p
X-Gm-Message-State: AOJu0YympJY6hur/yuwJMgEEOv8RVyozSjJZcilOzTRXvRfO9z8AO6Z0
	lsdw2EXodh2K4+jDQHEApVWsN0rss6LW9PjGDrz5t4UMBJthlXASCS1K8HUdiA==
X-Google-Smtp-Source: AGHT+IHN78NFZuTVNdvjx4fisZqXjohZioxW3mJ5Akp/F3MBFBmZREEQJXW39mALAwt/z7vJqe4Htg==
X-Received: by 2002:a17:902:c944:b0:1db:cf64:732a with SMTP id i4-20020a170902c94400b001dbcf64732amr11375487pla.62.1708476596356;
        Tue, 20 Feb 2024 16:49:56 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902e04c00b001db86c491e1sm6812758plx.32.2024.02.20.16.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 16:49:56 -0800 (PST)
Date: Tue, 20 Feb 2024 16:49:55 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, mic@digikod.net,
	linux-security-module@vger.kernel.org, jakub@cloudflare.com
Subject: Re: [PATCH net-next v3 06/11] selftests: kselftest: add
 ksft_test_result_code(), handling all exit codes
Message-ID: <202402201649.DF5ED3264@keescook>
References: <20240220192235.2953484-1-kuba@kernel.org>
 <20240220192235.2953484-7-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220192235.2953484-7-kuba@kernel.org>

On Tue, Feb 20, 2024 at 11:22:30AM -0800, Jakub Kicinski wrote:
> For generic test harness code it's more useful to deal with exit
> codes directly, rather than having to switch on them and call
> the right ksft_test_result_*() helper. Add such function to kselftest.h.
> 
> Note that "directive" and "diagnostic" are what ktap docs call
> those parts of the message.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

