Return-Path: <linux-kselftest+bounces-5108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFCB85CD26
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 01:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685B21F23731
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 00:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DE04C99;
	Wed, 21 Feb 2024 00:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nLeHnXDS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718FE4A1D
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 00:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476759; cv=none; b=BoaMU4EGUhmNHkwG7dcBrmr99Ju3beTaJgfx8MoBVc3STOyF2nfTCledGO0IjCWK5EN0gkuuPwcS80PkxpKTrHpRbZpeaXkHMrCrbSZDyy0ppcIjke6TD8oW+D2Wev6HSyADAAtJToX9M1rS26BYIOJ6SO7BzXV7iexrthf+QrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476759; c=relaxed/simple;
	bh=J92N7oppbKokaymoordlHfEGYpccRePizL+hh7TZ1dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vC6Q9JUxpKb/EsElW6AhMEPeLq1Fmmw8LaqCI1I3dVsPMigVqxwWVUQdSt2UVRtjkGmLAyxWHJOvsYtps+pnok6nZBT6FhOkGCeYi/do8/riXjQQyMKmKcAeUyrSpXOr40ztx7K1/isNfM7Jr+NOl3k9iP7ttMoLPneb/wl309A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nLeHnXDS; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bb9b28acb4so4139648b6e.2
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 16:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708476755; x=1709081555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R+X3D1ev8b07YP6AkHk335qZFq2tm6Peno4gQaQD+cI=;
        b=nLeHnXDSkzY9OXSC2jWJtHHRiimsg/sJcZdHgcUYmA5dHoJT586otcHXeGWqXqjr4f
         ijDM2RHzxgZDdjyL7NYFnVKZxnh2cpNsc+n4+VAwelNtbyQbGr8vwfBA33Zz32vCdWix
         rOMbdsDUdXEzGH7XbVr2MlNsFHI4q6p+8geCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708476755; x=1709081555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+X3D1ev8b07YP6AkHk335qZFq2tm6Peno4gQaQD+cI=;
        b=hx2J9es+XrqPZGKMJbapdaCPGAvPoZrc79082VBVllqzJLWQ/R9FgJq3rMGtVZM8Qh
         u7PlPhYx9EkToAsZfTx4AQElsnfe0b1WNM+g+c4/aFPPytDlwHKlyHcQcezwsA+RqA3W
         0hAJkMNLpA3dYYluTDOFYrwJqBR0QJwNhfhvtM0U/BLlg0dz5SabGIfbjMupOlgaEGVm
         c6OaZJ237GT7H/QFXkkWeBj6UZCqpv5REWA32HKV6NNqeGS1CSUdkX5dn4J0Qped8vqf
         r4d9SBFffZIVJVGxnI5xfx0kmRuMS8Ei0ctEkJ4ivYq729UYoZuk/g/88mwaTkmaS/Dr
         OtRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkpZnwoJiKnGVDMa2lyNRGA7sC7N7cm9F4uEA54V5wCtsdkOz8KLI8xk/8LJ+4O5gj039p4IkP1aeDdDfq7EL7Mr5JSl1m0lHgH52ixSrl
X-Gm-Message-State: AOJu0Yyi33d9lvLT/2g2GbCr4J3f+ydg8ASHiDpCGZ8OEziEADqU7OO4
	rUJ9Gao0sV2xrytOV8y/0mP36LREDmb779gRjS7blsQtmfy0CTk+g3mLYG5Hng==
X-Google-Smtp-Source: AGHT+IHQovIj/E8PPhTSxpkjPpb9Wj6cTXiVUJOisMr+S4qxc/4l1FXONqKBXYMEfc0hZP57LGgaUg==
X-Received: by 2002:a05:6808:f08:b0:3c1:57a1:bb87 with SMTP id m8-20020a0568080f0800b003c157a1bb87mr7875013oiw.19.1708476755611;
        Tue, 20 Feb 2024 16:52:35 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id du22-20020a056a002b5600b006e45d5f0645sm5211431pfb.101.2024.02.20.16.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 16:52:35 -0800 (PST)
Date: Tue, 20 Feb 2024 16:52:34 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, mic@digikod.net,
	linux-security-module@vger.kernel.org, jakub@cloudflare.com
Subject: Re: [PATCH net-next v3 09/11] selftests: kselftest_harness: let PASS
 / FAIL provide diagnostic
Message-ID: <202402201652.599B4134C@keescook>
References: <20240220192235.2953484-1-kuba@kernel.org>
 <20240220192235.2953484-10-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220192235.2953484-10-kuba@kernel.org>

On Tue, Feb 20, 2024 at 11:22:33AM -0800, Jakub Kicinski wrote:
> Switch to printing KTAP line for PASS / FAIL with ksft_test_result_code(),
> this gives us the ability to report diagnostic messages.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

