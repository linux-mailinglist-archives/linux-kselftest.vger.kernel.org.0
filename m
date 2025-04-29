Return-Path: <linux-kselftest+bounces-31918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F365BAA16C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 19:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6422A9A1473
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 17:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156352522A2;
	Tue, 29 Apr 2025 17:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUItvwgE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725BC250C15;
	Tue, 29 Apr 2025 17:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948056; cv=none; b=r6KAxkHBiI4yNeb2XjQjGxxCg8xx9CbdmpRG+s0GmugUIALbV3/A/Jafhccv4ubPaPlHywVan/uolaBH3LM5Lwyvq6yPuI2r0eCmGh96zCX9q0BlDmWoVeOtbanoTnCZ4/DmnIX2JS+Ux0bNsZIhobfaNAzuAHrWwMV+qSWt7xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948056; c=relaxed/simple;
	bh=d5V8elTkHGnnuKPLDFPs1e9b5tOMXPDhsj+gi96a3qw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=KCJG61t7fX2pu4lSbR8AR3vfZw2uMUr2pTUxVRzk2VyrWnIk1NoCCEkKjjS9RLG80eqto8pb9Uaak/XbUSau11/GOe5s6ROigSJkYDSjJxS4VF08XKH2CKRUKxa8rfGno3LVLZ6jdLfFlO7mxsuANR6bWSqEGuXZIYw+0oB7nXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUItvwgE; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c546334bdeso545594185a.2;
        Tue, 29 Apr 2025 10:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745948053; x=1746552853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2BlWprHgUULyWpepcai3eQsAD4wofT/O/1QU5FajYk=;
        b=EUItvwgEjz3SH5jLVZwl2HEfmwS7giGbJI9p/2cGvwRU5Kxhi/y/WS1VTWmvdabRAL
         M1NUspqkzrpwHmd8fa1GXQNh0K5jW0QRCWv0S9G53OSvNmrAhpxQjkLVj1kDr9ywAOB6
         T56ojOXY/44YBIEyT6GbqSJ9Z1+uokvAi+N9VEHQ9gNmogLpueKW0mvsi4v3NqKVhaSs
         w6CdWMvzh0gBPtvJH8wKrFkpEztemEgbwzjPFIpmbMergFSPHvC/dDp5RLSh/YR+jT3+
         lygpqwriFXFVjn3iEJOLEOQlmpb3IhA2YP1iUW/w8aRk2ELC9yeM1sfS/2bUrNqYjYiI
         Frfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745948053; x=1746552853;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q2BlWprHgUULyWpepcai3eQsAD4wofT/O/1QU5FajYk=;
        b=bZGvG9nKtSrwv1kt06joinwq4862eB+2OJtoJQWN1bolf3/FymzjLtYcb776x8mU6T
         3C59OCpcPJIypDV8pc6E9xuZBVyfbl8pZariduw+Q371egOCLVBqr0XHzoNs6VjIcvjd
         Wm+F/SWHKDqo02PU1Wm7gcliccgKl6XFCcTEkl1t7m9zCsEzhMO3Cmy10PQ5gSqPcvpg
         Jgf9MhcvfpsMEyLlPZ/6aDdbyPpS6rktytt6WLharaioTxbn7cB2fwtjaVleuSovIPRu
         5oKucxvxawvuNHGsaWTI0ctI8qOqTt0Vwh8nbvJkK0UqHjk+7DjWuko+OZOz5ee6pmpl
         WJvg==
X-Forwarded-Encrypted: i=1; AJvYcCXkqgeVMdNs0Jxz2h+kauDsuqDsP+8QxU01F05iNPH45oY1keK8kNKZ+lUHnJU7BF1Zch4B2Y6C9G+t3FjtT48=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYeOelHia4XwF8rOwTmXlhdhJsASeMOSTR2UWkQo4d40aH2XsV
	l4DHsFtYMWcOeGCMDoMxHBQ4RvFx4eTlTirerGVuReeOvppcf7au
X-Gm-Gg: ASbGncu8ZCZXOViC4ZdZ/fx29MPbhZm9MumFfGBjECLMvn1pp1kLztL5xanuk/4spXu
	N4B7QKV/2SajjNUD1pNzhCcKgvUBgVYApwrbTk7XH3TuK9s21pdXQve7ZwOoH0tF66PfmInZ+Xz
	kKfqGXWYOrgblOZzuuks42qtFvLkak89hjfGGRjtN/tOKjmHDIRJDt+L+FGqKyF1s0U1IPxoE8n
	LOr+Qcrv+gAG9+2sy+T/QccmO3qpAqOBBHXrNq+HToZWaTWtL5kVmUrP3PtyiDD3CG909vnvsvV
	RP2aMETYv58gUQu8PQDnErJI6TXFN62Exh4a9vCD9hzTaGtyKarQHoE0suhw7dvU54HIr8095o/
	YQvhddEt12Z4ZIUgANVT5
X-Google-Smtp-Source: AGHT+IFFXFzJNyFiyEqCbrtNcx5BvBlOj81hFo+xiuTzcLYEVa4GvHb4oE2pd3AGLE1gsGgbSgYvdw==
X-Received: by 2002:a05:620a:1793:b0:7c7:bb3f:fd40 with SMTP id af79cd13be357-7c9668634c1mr1976762685a.5.1745948053141;
        Tue, 29 Apr 2025 10:34:13 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c958cbd99esm757597985a.37.2025.04.29.10.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 10:34:12 -0700 (PDT)
Date: Tue, 29 Apr 2025 13:34:11 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 petrm@nvidia.com, 
 willemb@google.com, 
 sdf@fomichev.me, 
 linux-kselftest@vger.kernel.org
Message-ID: <68110d93972c2_29818629436@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250429170804.2649622-1-kuba@kernel.org>
References: <20250429170804.2649622-1-kuba@kernel.org>
Subject: Re: [PATCH net-next v2] selftests: net: exit cleanly on SIGTERM /
 timeout
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> ksft runner sends 2 SIGTERMs in a row if a test runs out of time.
> Handle this in a similar way we handle SIGINT - cleanup and stop
> running further tests.
> 
> Because we get 2 signals we need a bit of logic to ignore
> the subsequent one, they come immediately one after the other
> (due to commit 9616cb34b08e ("kselftest/runner.sh: Propagate SIGTERM
> to runner child")).
> 
> This change makes sure we run cleanup (scheduled defer()s)
> and also print a stack trace on SIGTERM, which doesn't happen
> by default. Tests occasionally hang in NIPA and it's impossible
> to tell what they are waiting from or doing.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

