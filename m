Return-Path: <linux-kselftest+bounces-5103-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D98F485CCF2
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 01:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16B681C21DB6
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 00:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C11C1841;
	Wed, 21 Feb 2024 00:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PEo0tGgy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846CA1FDD
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 00:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476568; cv=none; b=hEa9O1aPgtFPJCtfI9MwXUnDxcB4FzCjThY1mgVK3KsBCR6dJAa2Pfv/VLGvBxCIEeakC1/tbT4l29S/hO6WxqnOjsP0G2FExJwlpstpeXHVIEKN/HmeCo2T73NfHwWzdca5fRxscgh13agBtpxqsKZPZl3JZOyDfHuD+Vz+oa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476568; c=relaxed/simple;
	bh=cIRuw18MgK3s3QPYG5bF8HaUdZMx7uHI+euu6IBW8e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCO5U6TVZIyeJHgltLvttyUTXBEmSBTtLIYOpRijLPuaWL00xO3CnsOFMJFnMXh63ox7zqiBa7FfxYaf7/htR+a2d+l7817wjUbHwD6tyPfeqfTbDxLUAucatYWf6jHrSko9bv5uCJBzCwcHSewXH6kGVeR17jit3c39qzVS6JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PEo0tGgy; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc139ed11fso10422005ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 16:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708476567; x=1709081367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l6iZPQkJ9eVozTwMvVtiCWD1JWn1A/ViHwX542hh6CA=;
        b=PEo0tGgy8iKWLybFGwoJXcTltbGU1p3TqNEKJWGiLDhDlDgH9lkOtyG1WDia8JuaWn
         wYyDFYqOJHMABYWB2qmfvsNovoNoZ2Mk1kBNMcWffnb2WUtIwSZwMUbOsjBw3tThctWW
         ibYukAqdeBTArIYb9VgX8sEf/vXlZnbxss/G0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708476567; x=1709081367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6iZPQkJ9eVozTwMvVtiCWD1JWn1A/ViHwX542hh6CA=;
        b=Ns+CskhZw/043POPzT0DycMIm39l4CyMjUL2sT9EFR+GOlQlhUq6Tbk0Qms6D0v4gK
         JzbPMtSa7C+h8zUjuG9vaOdX9Hre+52W8AG2GwTjhOnIVH5jO0beXhtqrtG9apFpHz+b
         s1o/E+miIANOXZUPWD+hxVUR3DhwRDI1pXMQP2VTIubCkgkzgD9ZdXVLkeOjxcgNrfnL
         hwzK8eRWbYZii5Jro7M1ry4bKDEAfjo5WrcV6Vf1r3dAsoHdsq0Z2Z4BNHQJ9e1PYfSj
         UKIfjlo7ApSFi8v3lIO2Au306lqbKwroXlV074ypdwhxZmcIPTlemV0Xkp5jGC2ZQiYS
         KDdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFGLoY26RdJmNpwlPiNNunFGo1CXTJKYYXvoBWC19Qt9oQI5TfMjg6oG/HauoSVlSPRDmQuWZc9lVT29G2n7Ak/nHKIYXtL3ycbRIcoYlk
X-Gm-Message-State: AOJu0YxVp36KCU5G2l6Bcs/PpLGwsoEhURKA9LsPZkFLtxW6c09UU9U/
	s57lwLu3WeQsyh9PBoz9K6Zzq2pybuWFsf3JjQw0XXQEq05efauGuwLqzLxTTFJS3BLVeT+9zGE
	=
X-Google-Smtp-Source: AGHT+IGrH8eYOJ+QTDt/PHAS3tq4N8QvcVgEEHaffSlr+I8HL+Yj6EPAOIVXls/P99vM+K5FbSBvRA==
X-Received: by 2002:a17:903:183:b0:1dc:2ee5:3f3a with SMTP id z3-20020a170903018300b001dc2ee53f3amr608581plg.0.1708476566981;
        Tue, 20 Feb 2024 16:49:26 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s2-20020a632c02000000b005dc98d9114bsm7242084pgs.43.2024.02.20.16.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 16:49:26 -0800 (PST)
Date: Tue, 20 Feb 2024 16:49:25 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, mic@digikod.net,
	linux-security-module@vger.kernel.org, jakub@cloudflare.com
Subject: Re: [PATCH net-next v3 05/11] selftests: kselftest_harness: use exit
 code to store skip
Message-ID: <202402201649.C83025144D@keescook>
References: <20240220192235.2953484-1-kuba@kernel.org>
 <20240220192235.2953484-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220192235.2953484-6-kuba@kernel.org>

On Tue, Feb 20, 2024 at 11:22:29AM -0800, Jakub Kicinski wrote:
> We always use skip in combination with exit_code being 0
> (KSFT_PASS). This are basic KSFT / KTAP semantics.
> Store the right KSFT_* code in exit_code directly.
> 
> This makes it easier to support tests reporting other
> extended KSFT_* codes like XFAIL / XPASS.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

