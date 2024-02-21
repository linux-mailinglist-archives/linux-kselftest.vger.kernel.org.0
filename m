Return-Path: <linux-kselftest+bounces-5105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683AA85CCFA
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 01:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99BEB1C2199C
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 00:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126411851;
	Wed, 21 Feb 2024 00:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lE0dubW5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3BC1C20
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 00:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476621; cv=none; b=Pf8JwBhqvoodo8JjjQXpl+52EKQw81lbpjNGu6dfulidhCkMRLXS31OKeFpJa9qpq2/zxmGNLIny1i0dyvgyoYPZeRJ9CsQBSF6TM6czZRjbBAKywFow1iZQn8bD8WIwnKus+zvPOBJaWX5DEAPgNV0rb/YntINMl2dLeHI0/JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476621; c=relaxed/simple;
	bh=f9TmN17be0BaI4aB4G2ImJIieb6TnIzTskoR+maJi9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhO2YZD00Iquzc4zW/L1m+++87/rgcwHI1rXP9DEPtzCZPyAlQ/BeIY46HRe2gpTUJb1tU9ih6j6gcXfwBhVvY6JqRyRbyZ2zQoehCxUqSuNMHRTkZ+jTlCZcWlwLG6QeON6zKqSKL78nfvZuqVrqVVo1LYcWEHz4F99jaNyOQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lE0dubW5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d93edfa76dso37775835ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 16:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708476619; x=1709081419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nKM5GL8m3XPROV8hICjNZ8s5cqcbwcRO2YeI2T2e7Ec=;
        b=lE0dubW5kPAvNG0fg01b8yevuMMXGZdrQ0IfjtD25Otmsy2zKUackh8v8Jwi/fTUq1
         sCyxU9NM5j5egrHrsW9VBZ6zbKMLJ0Cfs725Chds6rECRRybcCFMsQU4776s6kZwDNY0
         3nmQmMA9j+HJUuV7NVGt7Lw/a0wCFfZ6N0Wv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708476619; x=1709081419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKM5GL8m3XPROV8hICjNZ8s5cqcbwcRO2YeI2T2e7Ec=;
        b=unuBLsV6eQa2l2afjU2zdi4+w3RwJz3s5WTVT9/w2zKi94/eIbHLbRjYfEZK9Y0d2e
         +snXJZFSN4fWpP6wOLqBU2dVm4LkL0r/pZRx3jn4umffKXMJcaFRo1P3F/AGkxApAWJn
         iaQdBLBTwJ9kQ/SO1SMNtxfx3BYSmSzJ6UxRzbOT3xLL+uOLJDMkY7dtNud9Ygg4Rb8q
         9j1DEJ8yq+n35Uov3iy+h1vjuhpwBDOOGrchPvBc896Es/eZMnN8Na9BgTVn9mqV11ba
         LmHP30bwezx+ZOEkWNBu4u/ArIYurtIQagXm129V/fOOA+XoC5KhZ0u9xY01QnqeEV1u
         IiGw==
X-Forwarded-Encrypted: i=1; AJvYcCWhMG1A0EXIIRGITmaeeRxe0XvB22qwfjNU74tmaYNaK+yFispSq5UO7GrLRAk/Wy6vE+2a3viXoYqGlhMC8D+Wdt/8zt6IKNQA4yvBuBUa
X-Gm-Message-State: AOJu0YzHWSe0ivjIrb1ap4/9lUld/MBYh+3hlCCCmulhHVtsgpNKefTw
	ai+FMm1HzUeJpWVy7qHhuJkYhDrMGjZysSL8Ch8dj7iA+KyuIxnhM2DEZrT6kQ==
X-Google-Smtp-Source: AGHT+IEazzxps3jRajILlFOY+5/E6qDJS761uzHL3rRBg0GvHV+XLM76OnqMweREN/0hvlp4UejQSw==
X-Received: by 2002:a17:902:f68f:b0:1db:ca53:41d with SMTP id l15-20020a170902f68f00b001dbca53041dmr15021488plg.31.1708476618971;
        Tue, 20 Feb 2024 16:50:18 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kx11-20020a170902f94b00b001dbad2172cbsm6863205plb.8.2024.02.20.16.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 16:50:18 -0800 (PST)
Date: Tue, 20 Feb 2024 16:50:18 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, mic@digikod.net,
	linux-security-module@vger.kernel.org, jakub@cloudflare.com
Subject: Re: [PATCH net-next v3 07/11] selftests: kselftest_harness: print
 test name for SKIP
Message-ID: <202402201650.5B12F716@keescook>
References: <20240220192235.2953484-1-kuba@kernel.org>
 <20240220192235.2953484-8-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220192235.2953484-8-kuba@kernel.org>

On Tue, Feb 20, 2024 at 11:22:31AM -0800, Jakub Kicinski wrote:
> Jakub points out that for parsers it's rather useful to always
> have the test name on the result line. Currently if we SKIP
> (or soon XFAIL or XPASS), we will print:
> 
> ok 17 # SKIP SCTP doesn't support IP_BIND_ADDRESS_NO_PORT
> 
>      ^
>      no test name
> 
> Always print the test name.
> KTAP format seems to allow or even call for it, per:
> https://docs.kernel.org/dev-tools/ktap.html
> 
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Link: https://lore.kernel.org/all/87jzn6lnou.fsf@cloudflare.com/
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

