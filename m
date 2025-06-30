Return-Path: <linux-kselftest+bounces-36122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D09AEE620
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 19:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3048A7A1AA1
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 17:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7953F292B50;
	Mon, 30 Jun 2025 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ly3gIhns"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DEF242D76;
	Mon, 30 Jun 2025 17:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306042; cv=none; b=HncPjvdJzA+KPK0wb5fcdH14b/0VN/5Phn0VYOdSp7pvwn2jsLb0r+DRCipejQ5eIsCsZQwv4ZquqqNQdd/b0LYGtnoZoVtCW/12plz2WWrGckFOSKpLQi4VoL3yoFoOVfWKo+FyAC9jK3ZPKT/VNOTyhwghFtWgwOX4Z+wL1SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306042; c=relaxed/simple;
	bh=x+YSlI7VytRXhxbdrep65VDqbh/BQdR9Q3jWy4WuTeE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=T2Vl0Wn7eMVr75FQHTwkqAqEI/0Ob/IyATzs0sYCTx3T0Sb8hXBNJGfYcMrnRl+Kk+VhdxfEo8bHfJBrBCvPh5BJFfbdYKFLE4a/ciHZyLP91o2l0G+Tq48bTMazvcTSEyhmWS3ecnhqojN9GIH3spUYVGX/V6jCZx76PEMIXFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ly3gIhns; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-710bbd7a9e2so24228727b3.0;
        Mon, 30 Jun 2025 10:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751306040; x=1751910840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzKVoMY2Tti8DrCv+qU2/jwZeY1NQ0avwn4qkKdjcUs=;
        b=ly3gIhnsqrUmjKxCmjafC5C9naWbHKazrEv9Vj79YkFr1cxINcKlmCD9GlWrMtpDxC
         7qesUWRFEpX7WGP0sgSpZ2LP3OGKlYwBt/NylNRtD+x65Z3govS/9Aq9eo6ajQngnJ9e
         5O2JFqw4q0KVoC3EilPmFG7TNN0luIuCeCMiTSwqNZms9MyE5KtOagTqnz5G09HthL70
         VRxAGP4meEq0VLcI9+W72kU6OQI087ChHcRmaws52KPWN2+KKmDfDsk13duhPLnO+41N
         S3LrGemrP1DuLI35i8FKa8Uq4Nb25T8cKUJzXwB6MpKMnhDI050o/k3BUl9v2FeY9ziF
         2yVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751306040; x=1751910840;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tzKVoMY2Tti8DrCv+qU2/jwZeY1NQ0avwn4qkKdjcUs=;
        b=TGlazjmrAKLld0w8k1R4XWCmz0bEMmlbTs6z7vP+NzAwifohe5QKnq4ieXBEyBbPi3
         QcC32ca1gYuMRjU/L58fV5QxIfIDLYUP9nnWOMu8CEb3HShXXWBzFZxVcJFb616XOWX+
         RHucriYItBfHYVZmn1VElRc2ZPQFe+Fa2cG0hKk21v82Ggd8R251nb6fPGVgF+EylX3K
         DCUthyTJTrywikvOxqNQ3FkVSPruxJurnhigF402/n69NYKxNBWg/1L/MmlVm1Dt/7QD
         Iq0zXu96DMgENrhZcOqEo772GbhQvLslXd53RMXwILw30XS8XM5diLPxyKH8T/zWZUJ8
         PJog==
X-Forwarded-Encrypted: i=1; AJvYcCUwQYgA8AkMRQtFDJemJr9Ycpz3PFQdQGFF3+r5ZgAT5Kr/6BNbZlcIvfgGSLbXq4C/T3pg1cr+rJvyR7p0@vger.kernel.org, AJvYcCVhpi+4JkZrsf9TzR6MEM7zUAoWEiQ8qIHB8V9hjdvW0Ztqej9jBt1Y1smfb1vGsEy0RS+VepHN@vger.kernel.org, AJvYcCVqSyEVSB+JnN0Tcx2jOCDO4XVCOoCkLBJhPOW51cl/YfPHYdcNkemvlNQwSqyqQ1IJvrcSOsA8rT5KnwjA8atz@vger.kernel.org, AJvYcCX+A/hp9j4sxJQqkGgdCArrD1y58XrUDNDZLPmZvOeBYR0Wtfc5XD6pRQqaQ+wNGUZ9WGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGv/Rq0YoOko2PvX1ShuUH5q+ZGEW/ytXz4X/sJ5AEmOMXwwjz
	lRnHTnw4uRYhzcx9eCHhEYyeD3cEZakBdLASi8MvLyX4mZtOp5U0mxbU
X-Gm-Gg: ASbGncufP4IzyoBlOfJJQvHCqhaw0js/s7XAEz3ECkrOukwJsOsEpp/W0CeQYa5ASAv
	If8Uo5MntTSma6TQ6u4JaWbI9ZQs8kjObFvEnuGL7XT6ZwTT4x6NIkMdDsDlD2L2uMe+gRt7kli
	vRL8LwLLmud3cVNKv2/Nq2DkSPt2dRqMFmHsOGIgvueU6/sHotijVoe4uybxvADr2QjuicTy+gS
	277fN9Qc7PQQ/bSEAHHJZPW6WxXStjd+7tIMRcbDj/bcTQApAFkPdvKYTjUDwcr+yKZr53/kpSq
	4krwSL903yi7tr3tnQZRb8d0HVF7PMNm2BFat/VTeJpiZ7N34xdL/3D5dLjg7PvAvqFcwfxvzyq
	ZSh/xaqEIF2WObBq9XPwPlC0j9mJR0+cHB7hNLS8=
X-Google-Smtp-Source: AGHT+IECTL3RoUV2TcnuP7TkMjm+s+TzIbFnBWoR5EqNlbGHSjor4CVYrDzKwwQkr41xGvXtTTaM5A==
X-Received: by 2002:a05:690c:4a12:b0:712:d70b:45d5 with SMTP id 00721157ae682-715171af5cemr209495367b3.33.1751306039784;
        Mon, 30 Jun 2025 10:53:59 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-71515bf09cesm16493027b3.24.2025.06.30.10.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:53:59 -0700 (PDT)
Date: Mon, 30 Jun 2025 13:53:58 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, 
 ast@kernel.org
Message-ID: <6862cf369fbcd_162c24294b@willemb.c.googlers.com.notmuch>
In-Reply-To: <aGKgG+uE+UXEIIbf@gmail.com>
References: <20250627-netpoll_test-v3-0-575bd200c8a9@debian.org>
 <20250627-netpoll_test-v3-3-575bd200c8a9@debian.org>
 <686002d028f_a131d29458@willemb.c.googlers.com.notmuch>
 <aGKgG+uE+UXEIIbf@gmail.com>
Subject: Re: [PATCH net-next v3 3/3] selftests: net: add netpoll basic
 functionality test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Breno Leitao wrote:
> Hello Willem,
> 
> On Sat, Jun 28, 2025 at 10:57:20AM -0400, Willem de Bruijn wrote:
> > Breno Leitao wrote:
> > > +NETCONSOLE_CONFIGFS_PATH: str = "/sys/kernel/config/netconsole"
> > > +NETCONS_REMOTE_PORT: int = 6666
> > > +NETCONS_LOCAL_PORT: int = 1514
> > > +# Max number of netcons messages to send. Each iteration will setup
> > > +# netconsole and send 10 messages
> > > +ITERATIONS: int = 20
> > > +# MAPS contains the information coming from bpftrace
> > > +# it will have only one key: @hits, which tells the number of times
> > > +# netpoll_poll_dev() was called
> > 
> > nit: no longer has ampersand prefix
> 
> Good catch. I will update.
> 
> > > +def ethtool_read_rx_tx_queue(interface_name: str) -> tuple[int, int]:
> > > +    """
> > > +    Read the number of RX and TX queues using ethtool. This will be used
> > > +    to restore it after the test
> > > +    """
> > > +    rx_queue = 0
> > > +    tx_queue = 0
> > > +
> > > +    try:
> > > +        ethtool_result = ethtool(f"-g {interface_name}").stdout
> > > +        for line in ethtool_result.splitlines():
> > > +            if line.startswith("RX:"):
> > > +                rx_queue = int(line.split()[1])
> > > +            if line.startswith("TX:"):
> > > +                tx_queue = int(line.split()[1])
> > 
> > Does this work on devices that use combined?
> 
> Not sure. This is suppossed to work mostly on netdevsim (for now).

Okay. Given that the test targets that. LGTM.
 
> Since I am not familiar with combined TX/RX, I've looked at ethtool
> code, and it seems RX and TX wil always be printed?
> 
> This is what I found when `-g` is passed to ethtool.

I'm also a bit confused about how combined is supposed to work. This
was discussed or documented somewhere recently, but I can't seem to
find an authoritative reference.

To my intuition, "tx N rx M" is equivalent to "combined min(N, M)"
plus the remainder of the larger ones. So "tx 1 rx 1" is equivalent
to "combined 1". But not sure if this is true for all drivers.

Anyway, as said, targeting netdevsim, so can leave out of scope.

