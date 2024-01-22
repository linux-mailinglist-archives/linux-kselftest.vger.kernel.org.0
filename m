Return-Path: <linux-kselftest+bounces-3371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CD0837571
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 22:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 641491C267DA
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 21:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E8848CFD;
	Mon, 22 Jan 2024 21:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GdZ4fLHf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7259738DDE
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jan 2024 21:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959145; cv=none; b=nmjGemyAq04BotT3804wJTF711gLr+eA2958AF7y3MZacd9NxOth77HGjvBwRqglskr5rhB1WcDDvf8cksBbnhluBSVCF2islqU+fr1Sw4G0bLAswi6Fwgivz72gUUm76w/lUimHDN8ocSgPOcP3xvIiYu5/bTLF4gJ/jtzxUxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959145; c=relaxed/simple;
	bh=ib9SRx6LkRZhW0h8GTNvFlw5bOTy+G6SkrbOyw6mexU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QakPDB3zMMbw6FKnVjEtsBIeKD8k3IpOAYnetKzzJRAkfIJjw9qtUDYlLz0hYmJePuBmX7uARzWHbW+2xs+uTVsSt3iTsuO1tjvwGEcHjWFacNiVvGLWfIrogfT9FOInDz4TTd5NBzGY4EoQKYWg1U+JQ3L2dlzaFD7xWLudYvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GdZ4fLHf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d6ff29293dso21641815ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jan 2024 13:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705959144; x=1706563944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p2tdYfbNQoyjzZj7eaSxYMIkM7B/ZoCmtQ4lSJqnD8c=;
        b=GdZ4fLHfjIom7nqWKjCRem6qs5dBl8yxh7nvAplvtoAU8cMoELzqYo5fnfP131teKo
         /GVvvDQJaxx8ykGOX78iefYktyyHHW5U3fSQRSWMBGUf3sH2qrQp1jHhHtYw//1K+v83
         HDxwe6Urf9/1Plbftu00LiETFusyR5Gw9z7u8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705959144; x=1706563944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2tdYfbNQoyjzZj7eaSxYMIkM7B/ZoCmtQ4lSJqnD8c=;
        b=vG8h4hFXRK3XLNGdjDUll1/FKXFvcnYmG4faCSfpp7jZ7SzpVZOOoY2g/L5N+JCKPF
         vqaCNjrIK4HoTKNuPNh0WGFv1miEDjR9QVeB3ErkdImJN8D6c76VsaKZVjPJro9wMVsu
         QEIHrU3uYVxezBByCYaewzjT0J9qS4AXa5soG7K8eLGJToZb2nanfN99wSh0Nky1tZws
         epVwBGUmfeQCq4yLQlQiNLl5mLx8cU6t7fwvPYNGEJcoiRWK03qwLLtdT4HFmtPPZ2VW
         DuwTvSQGqNWR4daCqnp3TJOhjnVK+5zwB0i3pVDh8tsC8FW3GVp6VbsaWbwDpZiiDmxS
         ANiw==
X-Gm-Message-State: AOJu0YxZEhWx6vXTe4x5K2K9Q3lqGWH0SoIQx9UQGow9EVLNknrbC3ay
	Pavq4haT+B1hqVaQ2QSEP0EAzqiLwPC7fga5ylXf1993HaQLzl4t+f8aJGPSYQ==
X-Google-Smtp-Source: AGHT+IGdkKz4GRznsc9nMqPp0DRrGmKeDjzgFkStSku0s5GucAOpHvh5RPL6OnXGtRhfhoKOtrm6Uw==
X-Received: by 2002:a17:90a:a793:b0:28f:f4fb:f791 with SMTP id f19-20020a17090aa79300b0028ff4fbf791mr1787141pjq.94.1705959143945;
        Mon, 22 Jan 2024 13:32:23 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id rs7-20020a17090b2b8700b0028d70a8d854sm10131048pjb.54.2024.01.22.13.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 13:32:23 -0800 (PST)
Date: Mon, 22 Jan 2024 13:32:22 -0800
From: Kees Cook <keescook@chromium.org>
To: Mark Brown <broonie@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH v2 2/2] kselftest/seccomp: Report each expectation we
 assert as a KTAP test
Message-ID: <202401221331.2EE8F668@keescook>
References: <20240122-b4-kselftest-seccomp-benchmark-ktap-v2-0-aed137eaea41@kernel.org>
 <20240122-b4-kselftest-seccomp-benchmark-ktap-v2-2-aed137eaea41@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122-b4-kselftest-seccomp-benchmark-ktap-v2-2-aed137eaea41@kernel.org>

On Mon, Jan 22, 2024 at 04:04:16PM +0000, Mark Brown wrote:
> The seccomp benchmark test makes a number of checks on the performance it
> measures and logs them to the output but does so in a custom format which
> none of the automated test runners understand meaning that the chances that
> anyone is paying attention are slim. Let's additionally log each result in
> KTAP format so that automated systems parsing the test output will see each
> comparison as a test case. The original logs are left in place since they
> provide the actual numbers for analysis.
> 
> As part of this rework the flow for the main program so that when we skip
> tests we still log all the tests we skip, this is because the standard KTAP
> headers and footers include counts of the number of expected and run tests.
> 
> Tested-by: Anders Roxell <anders.roxell@linaro.org>

with the S-o-b added,

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

