Return-Path: <linux-kselftest+bounces-38638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B13B1F803
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Aug 2025 04:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925F5189C0FF
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Aug 2025 02:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F583594B;
	Sun, 10 Aug 2025 02:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="kaEncN1U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E241367
	for <linux-kselftest@vger.kernel.org>; Sun, 10 Aug 2025 02:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754791558; cv=none; b=u8NYSJD4fd4/BqlWksnIczBJ75YdlyWZ6j4GF0v64y8JEy3YCD1fJHMUn4H3WruZf+MmhdywhmtJWH595Ckx9YGP6hi20lrkhmZ4gVHVhc3BaDMBJxuAj09r8IqlFKqQydfM3k0m8xl1U3wGx7jfq5qAIFNNjTnPQUDb4tON8fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754791558; c=relaxed/simple;
	bh=s7wQGYp05L9HfcQFejriC4r9sjnCHXs7CU+Ln53RY9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/qunkpTSDUSu3wGn7jjSiyz9uoLZts3mLmSwatntarlMjvrRFQ+B+XxfrAJdkz/sAxTjugfeAiXI9Ev1uCrmoq4jI4bPEw3Fz9tlwYBhJSwCB8conavQMRb1gj3NM5/hgggbVI9VciRcty8XfqTt7UmBtg7nXjFC6sa/zIOqcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=kaEncN1U; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2429d9d3755so31971585ad.3
        for <linux-kselftest@vger.kernel.org>; Sat, 09 Aug 2025 19:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1754791557; x=1755396357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pb6zcooEg3RRvTiv3EjpCkXeNvci0on4KfGHqARNl58=;
        b=kaEncN1U4woODhAoO9OHwrdDVTotjq7yqj5UKCirULLEcoIQIsFFtWMdkQQA4HAIO3
         mH7UEGxEg12Il45cd6PMSvneShzpNER5Rjp3d8IibeFWJASj1FQAbgxdydN/6NVjEbAd
         /ikEH02XTvU1KF/ret9og1m2auLjxNUy2seUV0SKsbxLsx23l+qtfnFOP/lBjl3OwDfm
         uN4uIeffcAznwtYpLxo9cIOJXH2mcTPNVsVEbjCHNbiEsw4ZTj2OI6ViuD3llBBedg/J
         RCEJTf0E4t4ex+csA9uYaWjruDkxpJAwgNTI+0PbRlLv9zCDiM6m8hBlCo1xvx+mNfho
         ZdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754791557; x=1755396357;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pb6zcooEg3RRvTiv3EjpCkXeNvci0on4KfGHqARNl58=;
        b=QqlG+ogemz1NocHFiQhCwzV2d13cTQqTyJZJis7pwDDHeXkrWPLscLy4suPjqknsd1
         RY4V8cLEQYoe8lWjpldMn+1QBKAODe4SI37xb0uE9XxJjoMmat6RioUIrDzM+oCNLe5W
         V0k2VZP0FCJZc18lO75iCTTNT4NiM7Cv0yosEoEYq9d2jiUV21KvrTXqslEbeWP++5/Q
         7fotwFrs7k9E/7lQZpz/H6knAm8Ci7rPpsS2YSzj1biJREcj2HJvePtVdGek4NcP7rNr
         q+Pk5iMS8FJ7cWgMNdjwEHVLdyoTxfOkmhyKZJf7Ez85Za1VzpQOJrwm48jGsGLMeIKJ
         TbFg==
X-Forwarded-Encrypted: i=1; AJvYcCWvdzV9GREFwGisC14GMRRE47WNSoxBxAGxJvEmsPqMvWhO1FdLfGy0vVOA5ht+Dp3w9x1agbqmR1fLbLgvivQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF6c5gPswGpSzRWfgMMPbZiTfRRLEXm3uNPYEBTx0JEXf3o6ub
	vEGgZNVg2BAjkJfyF39AzxQwgYjmR1uU/yQjYVBeOelAdVItd514Aak4+04r/GZpcuQ=
X-Gm-Gg: ASbGncvHgMjXolzKP8Xbo25z1dk01q84Fy6ac1RC9Z/vEeozwuQpfGEnFXRuTWuMNpw
	LzMU2SYT6DFE3+WsaO6CPdMXHOuf/UBqUFSzAY+dEnINSPYbmhupPP/9e4j9dVE1/F2fEv+/o9X
	1mYMd5BdfqkmyCM2T2+wmQ2cHFMu/41CYL60dTKed12x4xOEc7bjb6VB3WTmbCPRVl/jIQPE6yG
	crqFvD+v2cJo107B5bhTe/D7VuyyJoE+TqkTvGqCgepcb5EFSUbyHQYo6SeGRXlTP0PxmwC3Sqy
	SdseAbhtLD1XvmdEZu9NQHqp90sXppFwhwjoC05sfEf9vRr2/+LYhJeJz4617RN0V/fBC1QAt7l
	Vp1DEMlMPkuQ/O8F4FbbEgxlrlfW84U2G91DE+TQpr3z3VOpjQuLuEeS5lV6Il46vc4cot9uy
X-Google-Smtp-Source: AGHT+IF1TFqQOJkKBEjGMqAqbfj9fuF7MJ8nc7ELVFSJtdFjC/wviyjT7cTygqCqjzheWp7D/l2Vow==
X-Received: by 2002:a17:902:f611:b0:240:468c:83e7 with SMTP id d9443c01a7336-242c20030bamr111421885ad.3.1754791556680;
        Sat, 09 Aug 2025 19:05:56 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89a3acfsm239911345ad.146.2025.08.09.19.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 19:05:55 -0700 (PDT)
Date: Sat, 9 Aug 2025 19:05:52 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	sdf@fomichev.me, shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 3/3] net: prevent deadlocks when enabling NAPIs
 with mixed kthread config
Message-ID: <aJf-gL4n6xF5V-rk@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	sdf@fomichev.me, shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20250809001205.1147153-1-kuba@kernel.org>
 <20250809001205.1147153-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809001205.1147153-4-kuba@kernel.org>

On Fri, Aug 08, 2025 at 05:12:05PM -0700, Jakub Kicinski wrote:
> The following order of calls currently deadlocks if:
>  - device has threaded=1; and
>  - NAPI has persistent config with threaded=0.
> 
>   netif_napi_add_weight_config()
>     dev->threaded == 1
>       napi_kthread_create()
> 
>   napi_enable()
>     napi_restore_config()
>       napi_set_threaded(0)
>         napi_stop_kthread()
> 	  while (NAPIF_STATE_SCHED)
> 	    msleep(20)
> 
> We deadlock because disabled NAPI has STATE_SCHED set.
> Creating a thread in netif_napi_add() just to destroy it in
> napi_disable() is fairly ugly in the first place. Let's read
> both the device config and the NAPI config in netif_napi_add().
> 
> Fixes: e6d76268813d ("net: Update threaded state in napi config in netif_set_threaded")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/core/dev.h | 8 ++++++++
>  net/core/dev.c | 5 +++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 

Reviewed-by: Joe Damato <joe@dama.to>

