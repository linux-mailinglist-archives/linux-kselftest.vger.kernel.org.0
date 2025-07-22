Return-Path: <linux-kselftest+bounces-37853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0EDB0E380
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 20:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B166C540448
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 18:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CF928000F;
	Tue, 22 Jul 2025 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsWODkJ2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51F5279DCA;
	Tue, 22 Jul 2025 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753208944; cv=none; b=kbMoJeVUiA3NCwbJGVJq67WJVBocDE+bt9bNCtfukpXkKPJuCoFTUpQ2fzMoQotGGDmCa1XyxmIuqdEupngSGx3/Av1jOLo6hau2yF2GlPIHhi7XVN79TmvtOtTN1SuOamo/rKxynar9Pzhh1SEMdK9pSY6J+TnGaonBXD0odlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753208944; c=relaxed/simple;
	bh=RkkNdI9vuLQPiw+fmWHYyUPaYD/kN0qVxA2pr7pBEqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbpgAx5/jnRCx2+iomG7TpD1paITJ7i2q45/cDQgdL2Hqn5udcajfpi5M3RHrU3TAMVqKpLqWzhddifU5Q5JlBYc1YASgGeuVcW9xBIfcW19+yDSnyTOMtJO+XVu0TIezdlJC0aIvhK1e+FVuUdPaHnnUg2PmcLUrrctYnNZe8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsWODkJ2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-234bfe37cccso45744515ad.0;
        Tue, 22 Jul 2025 11:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753208942; x=1753813742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ncnqQH/L5XHCltFY0Cw0EuBCxvGsfMZiIzARQQHUSw8=;
        b=YsWODkJ2KwwgVCs4OkqmvuBqz78mJw1dhm0L3TTTtT5RxYC4Xe+KzT1yjh6gSSnNQ4
         LYZzilxrOlBJ1qlxrNw1oP7/DYL8d/Vv1LcePh3qyPsAYHen3U6gulXev7aP2GrCquYF
         pfyhYiN1wKy3CVt9XQfTX0kQCTL2PjMTwUQlOC6mgIjmK4omZYGpUsrIZ4k8tOdHuEvS
         K4UXf9vgwuYy+0wEdhnLQLOF1ZrIHXPUiOtpt13qb8A0Laz8U+NQ7yM7NTw04+lsJPYg
         NCSYqD+7thrh6SBV74K1ciSyX5jU+vmENVDzX74petSuFX0VJYR6tme/if6ROh6Cfkqh
         /n6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753208942; x=1753813742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncnqQH/L5XHCltFY0Cw0EuBCxvGsfMZiIzARQQHUSw8=;
        b=XaG+LHJaQyRiJmOtVtKP4JiYFmW5g222K/nXUDNtOwO/AVV1wlsdAH0Y7wz7HWFhv8
         /UJzvtj1chRrIN9LQFe9CZ4sW0S7gWf4fIxOWh4tgdW2Abqkd73eo85owha2pdqjEjYg
         QNpnOASx3yEnYvLkWjycMMQfN0BICDgN3rgQZouxKpT2qleTJ1Ttl/xO23Qfr29SW7XR
         EOpnQBRQKAX5pOMvvlsaQ3IikoodyYqaMhoxKlit5GF/hxEz3UT13poDX3YPNaJUiJNn
         vyxbp8ExudwL5lQpqeOc7sQuRCvU9mz+jNhkWv/v4n4xPx+vQ2Us3h6MBKTPgOYF+Ex7
         5FXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8xe2wj3LkgtdbFU5PZ0Fq6YdgvoSfy8/XhaYoO11IGeOabbF5OoFjs17c1w0A/wOSs/xCcIhYQXZ9lPFMadmN@vger.kernel.org, AJvYcCVuFnt52sNkMM047SaPP50uJ4BHz/BdBJiFmJVzKbi+xzkMo3+fOaapfPFe7fC7/WJLvHVrGee6cQILt+M=@vger.kernel.org, AJvYcCWMLpzx3/DE4/PFdiNooABCjVnYb2jew9xNFblDN6DOHbVqn+GVtZpu6yPEgf+TzCgUcMoMpKRQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+EA+N5uZcZP5P09XxLI3BfsbkqRY8TBffETTflMmIKkdBXw+1
	Yzh3dycX9yIIb5v/FpqxDJogufVv9kQYmoBAXU4rwQb5QaQzngV5Gtg=
X-Gm-Gg: ASbGncsnceepDqvE15+Ky45ST5P5PQNVSg8IiLBEv/t7jPXIqGivpv8f+6fhL3E94HF
	YCnriGV3x3pylHac1DjKp2cguZsyLBUjmg+clzmyDXZIioApvbesYUoYlrJYk05MMilaz1ML7+1
	KESvzZmpiG7XnwvJrJvuaK+55Ql6P2LVZ5vO0nPmxvJ5z+6qeYUpLEhRHFdizdsEtdHs9vVTXlI
	ucBtLL8gGaV0gkxT1kiD8yqkc17+MOugpT3MALiiVL19jhURM16PLPed+6jJGJMyVJnZaDHb42O
	p3AJdkgJSbybeEFIc+lmBVjZqBZZr4kZrWgQhBL5SZepE2kwbtITMz6NRABhRZi6xj0Ff/iRGU7
	lS+ZhjAFbtxoZHhAlLRyeFLMr47RIQCxAEfTQJ3VkyA6OsFlBp4WFurQcJ4I=
X-Google-Smtp-Source: AGHT+IFRqRgH5nBI3wyQnIhjc30c5pwMRyVnycr06EYwVUjXAPmUT7KBxaujhM7aPhesuvyYhscZsQ==
X-Received: by 2002:a17:903:19e4:b0:234:c65f:6c0c with SMTP id d9443c01a7336-23f98171bbbmr47285ad.15.1753208942004;
        Tue, 22 Jul 2025 11:29:02 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23e3b6b48e5sm80681325ad.101.2025.07.22.11.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 11:29:00 -0700 (PDT)
Date: Tue, 22 Jul 2025 11:28:59 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, sd@queasysnail.net, andrew+netdev@lunn.ch,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net 1/2] macsec: set IFF_UNICAST_FLT priv flag
Message-ID: <aH_Ya_81eYzoiZZT@mini-arch>
References: <20250721165423.990313-1-sdf@fomichev.me>
 <20250722163645.GP2459@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722163645.GP2459@horms.kernel.org>

On 07/22, Simon Horman wrote:
> On Mon, Jul 21, 2025 at 09:54:22AM -0700, Stanislav Fomichev wrote:
> > Cosmin reports the following locking issue:
> > 
> >   # BUG: sleeping function called from invalid context at
> >   kernel/locking/mutex.c:275
> >   #   dump_stack_lvl+0x4f/0x60
> >   #   __might_resched+0xeb/0x140
> >   #   mutex_lock+0x1a/0x40
> >   #   dev_set_promiscuity+0x26/0x90
> >   #   __dev_set_promiscuity+0x85/0x170
> >   #   __dev_set_rx_mode+0x69/0xa0
> >   #   dev_uc_add+0x6d/0x80
> >   #   vlan_dev_open+0x5f/0x120 [8021q]
> >   #  __dev_open+0x10c/0x2a0
> >   #  __dev_change_flags+0x1a4/0x210
> >   #  netif_change_flags+0x22/0x60
> >   #  do_setlink.isra.0+0xdb0/0x10f0
> >   #  rtnl_newlink+0x797/0xb00
> >   #  rtnetlink_rcv_msg+0x1cb/0x3f0
> >   #  netlink_rcv_skb+0x53/0x100
> >   #  netlink_unicast+0x273/0x3b0
> >   #  netlink_sendmsg+0x1f2/0x430
> > 
> > Which is similar to recent syzkaller reports in [0] and [1] and triggers
> > because macsec does not advertise IFF_UNICAST_FLT although it has proper
> > ndo_set_rx_mode callback that takes care of pushing uc/mc addresses
> > down to the real device.
> > 
> > In general, dev_uc_add call path is problematic for stacking
> > non-IFF_UNICAST_FLT because we might grab netdev instance lock under
> > addr_list_lock spinlock, so this is not a systemic fix.
> > 
> > 0: https://lore.kernel.org/netdev/686d55b4.050a0220.1ffab7.0014.GAE@google.com
> > 1: https://lore.kernel.org/netdev/68712acf.a00a0220.26a83e.0051.GAE@google.com/
> > Link: 2aff4342b0f5b1539c02ffd8df4c7e58dd9746e7.camel@nvidia.com
> 
> I think that Link: should be followed by a URL
> 
> Link: https://lore.kernel.org/netdev/2aff4342b0f5b1539c02ffd8df4c7e58dd9746e7.camel@nvidia.com

Whoops, sorry, forgot to prefix the message id with a URL :-( If this
gets a CR, I'll repost with a fix. (presumably should be easy to fix
during git am)
 
> > Fixes: 7e4d784f5810 ("net: hold netdev instance lock during rtnetlink operations")
> > Reported-by: Cosmin Ratiu <cratiu@nvidia.com>
> > Tested-by: Cosmin Ratiu <cratiu@nvidia.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> Hi Stan,
> 
> I ran the test provided by patch 2/2.
> When run with with a debug kernel using VNG.
> 
> It reliably passes with patch 1/2 applied. And fails without patch 1/2 applied.
> Where fails means the kernel panics along the lines of the stack trace in
> the commit message.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> Tested-by: Simon Horman <horms@kernel.org>

Thank you for testing!

