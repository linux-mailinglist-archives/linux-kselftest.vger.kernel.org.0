Return-Path: <linux-kselftest+bounces-33205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EC3ABA233
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 19:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34D9C4E332E
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 17:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870F8220F50;
	Fri, 16 May 2025 17:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bq7SPd2r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5E016A395;
	Fri, 16 May 2025 17:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747417881; cv=none; b=ZAN6F0O/bLSy8N/4lvIw+qtE1dqMkodCvA2uTd/qF8hcSpWco1MVWdko3c+gKpa8mCcD4OW4v8UFsznGP92MVjxw2n0fs3mN6EkZuWJGMa7gtRZfeFpCAUmQvPaL3u6OH0XgbhjOVPZn7OWb6lFtheH0d7LKmN40wHK25f2NXq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747417881; c=relaxed/simple;
	bh=zHXB0XLXOtSEBsz0AAmv751cXGjmMRuUq3Cv9rGTUg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4Gne4S18Ykno7lDPdEqBFydazModi2Wn96ZuiewstJufkXkEzKhGZrNiKGc1atrCg+H9npY1BwodJCB/I1GOvREC6h/YQOjJ0/vQ7yYjxb3+E8lVObV/BuFA8LzBibx171TOFLe+wjGdGcproxxRdP42sxcmWLlI+Vd8RBVWYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bq7SPd2r; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7423df563d6so2729886b3a.0;
        Fri, 16 May 2025 10:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747417879; x=1748022679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XfHx99oh3Dk6Ga6XPceoIpKeilGYWFm/nk4SDrQsRmE=;
        b=bq7SPd2rtm14bqxzbqp3gxqQc/N3XkH2WJlBpknGfNGHsYrjSbUvH7itcdSExaLfEK
         O7UGEPGsNR/3Z1Ih6zTbWW9/or7kzgxhI4rNhcocvulYeLpgJZecIP2BYEDKFkrryRVR
         T4OIpqwoeq0grK9H2DBkJwabgBEKwm+y7kSl54TaPCfuID1zmsYlAGPYUes6Ahe8yTuX
         tuXVwLTqoOLZ+eWmRFvlJehVKpBmWr0nIu6EOZObSwguVZOk+EhOlmIh7Z/uJnd4MKgO
         l0SArNMkNiL4gyDTgKgTUq8EmHNx5EpSvdd3T9yF5vJBQVIDFPiUZtkuhuCs5g8Rk2b4
         cHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747417879; x=1748022679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfHx99oh3Dk6Ga6XPceoIpKeilGYWFm/nk4SDrQsRmE=;
        b=LnAC2uY8ftTz+QIg+JAoWUl/tDeNsZO6dZYHta3ii0WztIg/ugdH0CuAflp5aBtO7S
         WRDOkD+O7PataNasI8a0UMhT523M5K+/QDVU+FmYv5a0sfEAfhNEUztEOC8csC1FotAn
         RULGtkrJ4Ty+N3lVCkKv3H0s532S/i4Vt5BwGMv4djM09V2IhCwzg40dE/xaB4pdZRYJ
         OO12zFRxJo2/t9hU5ictTxnkmlYZTBJ01onal/4koTC6ObCiBJawv+kNl0liVQmYjka7
         9rpH+cxTSo1rRP4huuL9BNKjf3S66ybSpNInncIrtrhRWZ+HKx0No20xZLVBqCaypMTy
         Yglw==
X-Forwarded-Encrypted: i=1; AJvYcCUivAWwpiWyH1U366iOeDoFuljGFXwAGrKyTj03tIyCr7g5Bo+qZ8FZQjLi1nnkwI7PIEx7Rck3sEqznbg=@vger.kernel.org, AJvYcCVtRNZB1go/zEOW/d1Fus0P5zCH/4Jyac2A+DO6aOBrE3X8hbt9c8x8+aoGjw6qd8E63iM4W0NqoH6e6Y67l6Lh@vger.kernel.org
X-Gm-Message-State: AOJu0YybZk5Mu+DnJhhG74+nxnFTYi46nYPrPEWifmI3/0M7L7DlB01H
	W3selwCKM3cy1RY2/kxXL8TLagvBW+wc1BnFh0OwuYvJoF9vUBhacCE=
X-Gm-Gg: ASbGncsGoncPzjov5lmrWlU9Sj3xDQOtATfEdjiKRcil5m3rYAkUgfzR6GkpAxKbbkr
	NiUZSNf+E0xjx05HSXbaFvaH/hG+JTM8ZtrBfkK/spfbdDJ0dymRuXIrW7kVrbq7MbUVvYBQM5S
	r6XLMzqgbMJrD6Di+srMjCKwJMRkyWB943ETBNTAeHNOWTX29UYrEQQE+8Q+D/a/uIADvmqleAL
	o00SMDzsM1cqGVfdn9RaKQXnli3YD8kLnMgGTw0szCB0Jlt/mZ2aAVFX7TgE8t9zeACCLdFumN8
	he1AnVO95H2IL+pn6XPlMvx97d0xXxsAk3JHAguftGdnHJpOt1b0dlSR0xaI7ikGj8EnozoDKNC
	uKQjWCP452wwy
X-Google-Smtp-Source: AGHT+IEh/PdHyupWeb9mFydEjbKSIQ8igSnJ8RAKkuDZvB//ovVqKm+nr+xy+x3+11EOX037an7rdw==
X-Received: by 2002:a05:6a21:8cc1:b0:216:1ea0:a516 with SMTP id adf61e73a8af0-21621a0a546mr6727031637.41.1747417879217;
        Fri, 16 May 2025 10:51:19 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30e3340187dsm5472356a91.5.2025.05.16.10.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 10:51:18 -0700 (PDT)
Date: Fri, 16 May 2025 10:51:18 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	jiri@resnulli.us, shuah@kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: net: validate team flags propagation
Message-ID: <aCd7Fj9kr_pbhQaO@mini-arch>
References: <20250515231332.4120071-1-stfomichev@gmail.com>
 <20250516073556.5983d1d0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250516073556.5983d1d0@kernel.org>

On 05/16, Jakub Kicinski wrote:
> On Thu, 15 May 2025 16:13:32 -0700 Stanislav Fomichev wrote:
> > Cover three recent cases:
> > 1. missing ops locking for the lowers during netdev_sync_lower_features
> > 2. missing locking for dev_set_promiscuity (plus netdev_ops_assert_locked
> >    with a comment on why/when it's needed)
> > 3. rcu lock during team_change_rx_flags
> > 
> > Verified that each one triggers when the respective fix is reverted.
> > Not sure about the placement, but since it all relies on teaming,
> > added to the teaming directory.
> > 
> > One ugly bit is that I add NETIF_F_LRO to netdevsim; there is no way
> > to trigger netdev_sync_lower_features without it.
> 
> Seems to consistently fail in NIPA :(
> -- 
> pw-bot: cr

Cleanup is a bit messy. Will add set +e and retest locally with vng,
thanks!

