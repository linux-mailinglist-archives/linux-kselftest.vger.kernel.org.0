Return-Path: <linux-kselftest+bounces-23615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D269F844E
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 20:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18DE27A15D9
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 19:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70DB1A9B49;
	Thu, 19 Dec 2024 19:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSWTUFTm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C5B18FDDE;
	Thu, 19 Dec 2024 19:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734636707; cv=none; b=jmgHH/rBE3f+kiq4PFkU7OfLLOCnbS+N57iwju8zl+sxAVlRuGeXy7HrV3ltaTvVuFCIcQiNxb2jl2spaZi4r4Ohzft/tf6AEouaLyD6nidr/OSYucve0OkTzsbBrhn95cI14djyhOH/PcSNvRhmFnuIbzkuC9b4SbExjOSPaPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734636707; c=relaxed/simple;
	bh=lIkXuYkHofM3zKLqd3A2z5rU75fCZBSoUiQH2bs7RNM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=uC1ch5kul1xI+ggFepg8SpsXeX/1acPBJm1QNOr8Uf4nES44iATKthDy9myWbdKY7P8gePFEtcVpNFmg9Flor1zSLPniLZznGIPNaUzASTK3JjJPauz5HUPOftiG7n8j5qOMCRjohcrQ5voYQj9p3DfCoYFpySXdmpXyLCD/8yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSWTUFTm; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6dd0d09215aso9909556d6.2;
        Thu, 19 Dec 2024 11:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734636705; x=1735241505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Z844X6Da5s46/TzyTdyAhEhyKPiFroXYSczgYFWbPI=;
        b=nSWTUFTmYkM2nFFigouXAmbuOGHbXXqUdEufKwjeVQ8/evPL+NPAoNUby+HJnAxTyU
         eQjBgHk1N5q+Xo77ziDkfS/1Irsxe+AS9UmVYeELKEAIunpe/vlcO9K50b8RCVJ3Fdvc
         9AxK/V61U9yxbHLpJ8J3X86IZN44nPACuGs4RpxSjp/5Gy+0IJRGChNETU4uqAqNl+E6
         6ZmbJwb8utZT0rX5SLnoua7srHWDLnTm5MnVVro8ZAUQR3vwJB9ttdIflVbO1JbQPfNh
         wGO01v/BPOoWcmPRvnga1b25Rtz14rE1SNgqYOZCJebtAAf4trSDaYy+tNNbsOn7FGw4
         Z/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734636705; x=1735241505;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1Z844X6Da5s46/TzyTdyAhEhyKPiFroXYSczgYFWbPI=;
        b=GphQBRbqeOTe73cBta2VjycGFIZRI8+YflXQaTbzsKBSccm6rbIdgBphg7qfwabxr+
         UXWs9orrtTqEfR15I2ykhZocYI8aBfRIoplOFTrpbJRClkU8H64ObywOPyHksxC4GKM6
         FvV8Yoe1ekQIRbQm3k9qqy9CQ+rx10qeMrx0KjE0A65vOGTwrXIjwSFeZL/bKSIg+7eX
         OoO0p/ne8diiAJRJoUKpVbl6giVhheZraQJ6dOrHLh1+wDDjgWDn8U6s6Fi1jqRLUpdC
         HPfl3gup82BUsBAyTQ6tiTasadiby8wIcg59RFk4jXwnoyONYo2NP/ojrMcBicrH0YEn
         Wj0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBcs9ThKSIe5sk5lrBmuqMt2JbWBbMgieWT7bW9IQncwrjo3AB2kMpUE6kqC0DfmzrM+MX+voxDX7ihAPFc4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+iki5iokxWtP62qyF9zCGJyt1vj4jwWzJrpPGzutLQneC/8m8
	6Xcje1Qo1DpSF3v0TYX1EFV76s2JaBq1g4O6BJO6CGY5LXRdhQVm
X-Gm-Gg: ASbGnctRUMV5wMblLQ2zv4rZ2zjPP5dM7H+QgYXnP0rZYjLqRDyqoMCDDz7/Aa8nkFV
	5fZppJ7XA2xTYPPHOQ85+76F4UIfk3ko9405IFmvsG6diHL0hyUBNBc/hDf+m2NNo7sJCY2sLVD
	iLDw/E1eDoP3vPY96hs55gretGu2skkiQUoozchxFP6YgALZcTTZkwCJwd2YxG4Z78qi6GQxbUb
	AljCS4zRE+j08kPAup1pe+3Ec4WHppXVxW4JAZEeYb1ERfBh5psvsbZnzPoj5Uvf0oFY40ih+dP
	LSPkMwTJ1GHBYNDGOvD14Vn+bRBZolwfkA==
X-Google-Smtp-Source: AGHT+IE9KioQFjy3p+/1y/KdZ5xiLRJy/6ykl5+Mowxwu3TzTGHEfUThm0H9GyYCanUUsFSC79Sgsw==
X-Received: by 2002:a05:6214:240d:b0:6d8:8f14:2f5b with SMTP id 6a1803df08f44-6dd23345712mr2514436d6.19.1734636705195;
        Thu, 19 Dec 2024 11:31:45 -0800 (PST)
Received: from localhost (96.206.236.35.bc.googleusercontent.com. [35.236.206.96])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181d75c8sm9349486d6.116.2024.12.19.11.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 11:31:44 -0800 (PST)
Date: Thu, 19 Dec 2024 14:31:44 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 Soham Chakradeo <sohamch.kernel@gmail.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 linux-kselftest@vger.kernel.org, 
 Soham Chakradeo <sohamch@google.com>, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <676474a0398f0_1f2e51294ad@willemb.c.googlers.com.notmuch>
In-Reply-To: <19df2c4d-c40c-40c5-8fec-bb3e63e65533@redhat.com>
References: <20241217185203.297935-1-sohamch.kernel@gmail.com>
 <20241218100013.0c698629@kernel.org>
 <19df2c4d-c40c-40c5-8fec-bb3e63e65533@redhat.com>
Subject: Re: [PATCH net-next 0/4] selftests/net: packetdrill: import multiple
 tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> On 12/18/24 19:00, Jakub Kicinski wrote:
> > On Tue, 17 Dec 2024 18:51:57 +0000 Soham Chakradeo wrote:
> >> Import tests for the following features (folder names in brackets):
> >> ECN (ecn) : RFC 3168
> >> Close (close) : RFC 9293
> >> TCP_INFO (tcp_info) : RFC 9293
> >> Fast recovery (fast_recovery) : RFC 5681
> >> Timestamping (timestamping) : RFC 1323
> >> Nagle (nagle) : RFC 896
> >> Selective Acknowledgments (sack) : RFC 2018
> >> Recent Timestamp (ts_recent) : RFC 1323
> >> Send file (sendfile)
> >> Syscall bad arg (syscall_bad_arg)
> >> Validate (validate)
> >> Blocking (blocking)
> >> Splice (splice)
> >> End of record (eor)
> >> Limited transmit (limited_transmit)
> > 
> > Excellent, thanks for adding all these! I will merge the patches
> > momentarily but I do see a number of flakes on our VMs with debug
> > configs enabled:
> > https://netdev.bots.linux.dev/flakes.html?min-flip=0&tn-needle=packetdrill-dbg
> > 
> > In the 7 runs so far we got 2 flakes on:
> > 
> >  tcp-timestamping-client-only-last-byte-pkt
> 
> Quickly skimming over this one, it looks like it does not account for
> the increased default 'tolerance_us'. Kernel packetdrill set it by
> default to 14K (instead of 10K IIRC).
> 
> I guess this statement:
> 
> // SCM_TSTAMP_SCHED for the last byte should be received almost immediately
> // once 10001 is acked at t=20ms.
> 
> the the follow-up check should be updated accordingly. In the failures
> observed so far the max timestamp is > 35ms.

Thanks Paolo.

All three timestamping flakes are instances where the script expects
the timestamp to be taken essentially instantaneously after the send
call.

This is not the case, and the delay is outside even the 14K tolerance.
I see occurrences of 20K. At some point we cannot keep increasing the
tolerance, perhaps.



