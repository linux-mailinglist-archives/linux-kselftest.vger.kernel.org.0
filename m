Return-Path: <linux-kselftest+bounces-4570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E40785394F
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 19:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1D2CB29B2F
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 18:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDBC60DD0;
	Tue, 13 Feb 2024 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YmQdptuL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFA760DC7
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Feb 2024 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707847061; cv=none; b=NhHArliQgLTGcjXQu9lCmvfo7Vstvpv6D6KtXSGON4YMyVAP7B3wYdBd7aEPdAS+ZmqB7F3y4GBb2rthHhWqX1YQ9lFxoR3IG/e5GHsjyTAo0Usz9iZkabuptSyRfJihC10Uty6FjmD8sG+vMx82vaQFiCoxwcSlpGpguLH5Gkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707847061; c=relaxed/simple;
	bh=mzkb144e0NW42eo6oZ2glolC5rnBygkOh58rUHmMWV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsLGLwLLJBrEFf2VVAPwaynKsxkjPVtBQbSGKkXu+CGCWVlu6MdEcBDAYmSIirrS7jE1kmj+VDnrr7rXete1nhekcRpsfLP5mlO0f52gubqQPCVUVf/pCxsjVy2kkynf0639sORLsxNHwTT9cZ8ANU8nom805M6HlmP3GdisMyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YmQdptuL; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e2e6bcc115so1216487a34.3
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Feb 2024 09:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707847059; x=1708451859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TosQgHYmNmcrCVsxzpW3Hrt1D9gkfZ69Zo+egpu0V9g=;
        b=YmQdptuLCXabp8CBE3bXlx4ztiuOGG1RpNjKzOmXdy959hslBnI577jNeerLurdZFo
         lmRoiFj14zJ/rXQrrEyzopvgIVSy0dZhK7mOYu7KMSEdh2iHyHB7qLq5kvQfzA+/ch8s
         euvwnwdONU+wIuweujRh/+nZmEyd2ySyVO9Zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707847059; x=1708451859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TosQgHYmNmcrCVsxzpW3Hrt1D9gkfZ69Zo+egpu0V9g=;
        b=i7uXuscT8CRE6zKjyCez87jUnym7e5OLAILKpvwhPWhBfItRq0hE7UyNUJqyZ3+dNu
         SHq5rfK9phL71jDfDXQ/UjhhknW/b8XGX74jDQ3YFY+BQylHHUMT/j5xgCRRbZXRBLOM
         iHN8W9HopUtVJmEHu8dX16p2OZ0XLwcIYbSoKhJahiJUj4I1XVEEnEA4pUmtxEqArgnI
         R9VW22Wk2X4imZZdUyIEvhvU2rKfZvyggL+hh8QbBjN1uebw9T683E7KtXZnmJsGCzLd
         Bk5XwrjeQb+dbpHU78r41ysNyidyYGqkyF927V/zWExDXkRA1Us8xD+hrcfTymdKW5nM
         F7vQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBLlzxy8c5BZHzMC3l1W+1w0VDeoNg8VDNGEr2BzA1kRgXtRpIJN4AZkxkXpsMC21gqGHrm6cenIZDEPz4d62L2ldd+Nf1xwkXFsalSoRd
X-Gm-Message-State: AOJu0Yz3KvCAH/YftZuoWJc7ttK1Jqy03NUtF1QAAEgljZF8JacRKoFQ
	rJhERb3oWe+LgMxZdk88mIj4HEKuwmzdX3kuQ2JfkQGAFhLGJjjhcbtT4ctaabKgrw+lStG0HzU
	=
X-Google-Smtp-Source: AGHT+IFCbZM+b104gnRGdedYpGNTS4oBTTu0IiBU9Iwu/rIirgHxDAHg0987g8ZzLYF9cUwgBDA7Kg==
X-Received: by 2002:a9d:7755:0:b0:6e2:f432:29c8 with SMTP id t21-20020a9d7755000000b006e2f43229c8mr367759otl.15.1707847058743;
        Tue, 13 Feb 2024 09:57:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXdGxW2ftWMHh0JC3cGkEcY9/lK1HpWR+bRy1IS644SeaJqbXnH5g4VAoHN7BgBiHA/BAsLKLcDHowUL5KgUS6iv0jUuyhQLdbUsTAqR/DGq/GEcQNwrJgTtVRoKM6avc6UEMBbwsuFfi+MwVNzU5u0wx7ovsQxPF2BgwDBqQ==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m186-20020a6326c3000000b005d34cf68664sm2747606pgm.25.2024.02.13.09.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 09:57:38 -0800 (PST)
Date: Tue, 13 Feb 2024 09:57:37 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org, jakub@cloudflare.com
Subject: Re: [PATCH net-next 4/4] selftests: ip_local_port_range: use XFAIL
 instead of SKIP
Message-ID: <202402130957.769D44F@keescook>
References: <20240213154416.422739-1-kuba@kernel.org>
 <20240213154416.422739-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213154416.422739-5-kuba@kernel.org>

On Tue, Feb 13, 2024 at 07:44:16AM -0800, Jakub Kicinski wrote:
> SCTP does not support IP_LOCAL_PORT_RANGE and we know it,
> so use XFAIL instead of SKIP.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

