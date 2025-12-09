Return-Path: <linux-kselftest+bounces-47309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00657CB0F75
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 20:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E83773015949
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 19:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96CC3081AF;
	Tue,  9 Dec 2025 19:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYS/YKwB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48503307AE7
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Dec 2025 19:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765309956; cv=none; b=YfZhoKOx/IF0p1GeA5ttIkWxfZMd9f+vWt/EpS1eLdTiKTjWeUDHmAPhGo0CoIypacuOOLnmqZDgVO6id65wtR0UiuLO0keZBDymUsD17fCeEX0cJaTPmgUGkYq5csAQ6hDNSqmMLoNKcTIDSu+vqPkFfzkVwQV23X6ChJdSwCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765309956; c=relaxed/simple;
	bh=XHL/L/FSKYOnQq3SetiqQKZ3ve52BsUb+UjL14KbL8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3mqlUjLooXQ9FONMJIhZhdUFHVcOnAbPg5GQmDS3/SW5ResAHh2j31Zbjt7Ty2qSG0FXBCVtOHDV6IKr0oQ6MBf5MdvRd496WTipxFbxg2qzZLXNWq377oiok3NUewX8Z+k+R/9Tt4NwN41ZZJg86opZlo3wnRkcnr5zzruBO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYS/YKwB; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6433f99eb15so5424130d50.3
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Dec 2025 11:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765309953; x=1765914753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+S3XRmIfY6Nu+N2ZLCSjBdZjpwngwmUECGmLCvjDHC4=;
        b=JYS/YKwBT9uINGJs0YtoEei+BcWgPlR28O3aqTc7ELWu4ak8jt96qj9N1A6rFEx97y
         UoKYSu15kAi67xNZxzfPs0wRq0bWRh92qZx9kk+Jgy9tw31yGR3fmzJqAjwg4A4MOX7P
         9bL7jbxmonzsi+LHrD7vqtHI1W98N7C8byFw44IVvhL3FBZdJoGQW/pzSoMHW+eGOB9f
         X+g9AEgJDlsgG1Nz1WhPlCaPKHJTvHM68ooA71V4Gw6wC/FqskNUvUrASYlSq6ek7QQQ
         zROMwFssQ7rk32CJwEQmETzhC6q1KpDga/wfeAkXudp4GV0SMqOZ2uQZvhD9Fb7CDd7N
         sydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765309953; x=1765914753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+S3XRmIfY6Nu+N2ZLCSjBdZjpwngwmUECGmLCvjDHC4=;
        b=lDFQKIekHr8gKtLN1SmGu5ckOv7BeI3mX1nNAaOp3AqOdwd02kgyz1RJWmmsYGEyCE
         5J1ms6IBKgi/w/cgf2XVMeq3Dj8oJW1lBEd5qf8fnFaJvdLPGj2+TOAe0iW/+6nqXHce
         xkH03evrOQ/hh1PiGp3Yuh3Ca8n4GMUcCqZ+WkKWCvAx1QQJSWzbEXsCSFGTyAyPOrLN
         w9H+PmH1qyc8W1xcAWqWJyqDYFFaJacpHZt9P7QxmbtWw9vnfspQyPdZYUKayqVvElFN
         2tQuqBwlCSyKrKzNuVgkRXBbSUcM2f2E/D3JFB0V5NhAWxHit88Agj0WfzZjFkcnPi2T
         zBxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqkBKm+PwdXmI0bjVsOfag4nSzg2+qCVMzR3Ts5yiB9+sY1ZKXLKZiY7fLXFaG1w/u+dZxxP1UEKeLXpFC5Bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwW9EglDdrIRKZ2lqIOnYsLiQCoM6A0CQCNGr9/1XXdtTA11rn
	eLOvcVWKfdF208EOFESq6C3rab604PvEjlUvQLoIgSZKPCsPjBK9xWRc
X-Gm-Gg: AY/fxX4UuN2EnYkBI/YtEdM7U22Ad5bD1K3QWzSTcDN8UaJH1apSrSn+p/6Ssa+9y8Q
	holXUEiJHNXR50Dn7YVa1GK+NzcpX2ESg1rjwv19tBTYsx7dyQeQsjwDVuK5uM6eFfoXQVOFG1v
	ZAqa2qnhSf0Qw/zYqUNAxKP85fOdoG1TubSyAE+NBe4uAoorfLEGjpKA2cxm0X8bv6tLpNgGrff
	11qsrY/x6R5byjlScBDuPr5Dn87eUCx9YtpUW1CMSo79GNYeGVqVky6PxXFIRk1WLqokm0GwBkJ
	uyzjmY2jRjH54q2XLwhCQakw9ZarqZqnP1ZfhU2dKF3IYKErDM1OZzSPtI7WunBCl+xhNVcY83D
	UK0UD2+inNQo6iKzdkyO774kS6BrpFfTJ1AmGXdSboqtmmLp3wMgQm67ludKzj/zGcirnaCCxwD
	ZaGR1r9gRV2Kg0wn4buGXHPlVVPr9vmhYiauvFfFUr+fJUpJE=
X-Google-Smtp-Source: AGHT+IGVa6r0iFDuAtcL6wIkP8nbDpeCfCQK9vF2pnYiCLEjTySXlHVWrlq2gK/PVPin4gJW60wg5g==
X-Received: by 2002:a05:690e:2543:b0:640:d255:2d6f with SMTP id 956f58d0204a3-6446e93f952mr78609d50.34.1765309953244;
        Tue, 09 Dec 2025 11:52:33 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:54::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b4ae638sm63277367b3.4.2025.12.09.11.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 11:52:32 -0800 (PST)
Date: Tue, 9 Dec 2025 11:52:31 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v7 0/5] net: devmem: improve cpu cost of RX
 token management
Message-ID: <aTh9/waV23uRZc9E@devvm11784.nha0.facebook.com>
References: <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-0-1abc8467354c@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-0-1abc8467354c@meta.com>

On Wed, Nov 19, 2025 at 07:37:07PM -0800, Bobby Eshleman wrote:
> This series improves the CPU cost of RX token management by adding an
> attribute to NETDEV_CMD_BIND_RX that configures sockets using the
> binding to avoid the xarray allocator and instead use a per-binding niov
> array and a uref field in niov.
> 
> Improvement is ~13% cpu util per RX user thread.
>     
> Using kperf, the following results were observed:
> 
> Before:
> 	Average RX worker idle %: 13.13, flows 4, test runs 11
> After:
> 	Average RX worker idle %: 26.32, flows 4, test runs 11
> 
> Two other approaches were tested, but with no improvement. Namely, 1)
> using a hashmap for tokens and 2) keeping an xarray of atomic counters
> but using RCU so that the hotpath could be mostly lockless. Neither of
> these approaches proved better than the simple array in terms of CPU.
> 
> The attribute NETDEV_A_DMABUF_AUTORELEASE is added to toggle the
> optimization. It is an optional attribute and defaults to 0 (i.e.,
> optimization on).
> 

[...]
> 
> Changes in v7:
> - use netlink instead of sockopt (Stan)
> - restrict system to only one mode, dmabuf bindings can not co-exist
>   with different modes (Stan)
> - use static branching to enforce single system-wide mode (Stan)
> - Link to v6: https://lore.kernel.org/r/20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com
> 

Mina, I was wondering if you had any feedback on this approach?

Best,
Bobby

