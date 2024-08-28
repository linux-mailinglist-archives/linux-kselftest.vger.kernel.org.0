Return-Path: <linux-kselftest+bounces-16555-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2F4962B1A
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 17:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 269C71F25984
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 15:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3B31A08CA;
	Wed, 28 Aug 2024 15:05:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0B419EEB4;
	Wed, 28 Aug 2024 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724857516; cv=none; b=hGUUatOw+YB0z3jujvGpyUa7NjWptmK9EbU+EbVXw1dYR6lRdYnA6iF4NU/ns3oC5/YIjtYjVViRjR1h46Bj/S1gho6mI76qUEoAjUrBWatfI3uHy95eYnpWoQWLYNARb9ddtyRLHIzgeywDyIv6lnSIFrKcljfsI+XKvsUqTHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724857516; c=relaxed/simple;
	bh=rQN1NnWw59rc0ehdKbCQiHtcOfGAVzYccDBUOyXFDL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDWSLG1kpa10D5ZyGAQhAH5IGMhR46gg+17K4dRKQep/lwo+XOaGsZva2ly3uvGp0is5eFqMtsYiZHqYDDf/4ATHndBSgiiU6tsj+Hby1cf0y0P8H71sHJpDNAX+oWvaNT6FO8A5E+cESYuleVxb+p9J2/yL7Ws5xhcNqAGK1U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a86acbaddb4so640070866b.1;
        Wed, 28 Aug 2024 08:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724857513; x=1725462313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TuYT2i2Tg70NxH0LAL70Y/Y33RmifmVfww3J5Zmauzs=;
        b=dL4JIVD4R6C9RP/NYSpsXld6gC34wkLPyhBWjCDtDFBcPJNseLCAQdy1DmUF+Nzgo0
         UT1dXQU+yjqFF/rCpaRMc3pQ/gpGIKPRD7mWgZb+dSVSJ0wcUdaTBoGhCPO3mp+L6viv
         GZueFoQ7tvp6mzRZ6PPMpn+ZdjLVAsS2F5hMpEOxYr+R6uosXM4bnFLmvqoAH1Iwq+44
         HLFSrU7I/Cch1fyvigZPvSg3JJVe6F9trEn8ZB3PA/07p503waxjue/uhz3ybwrhAKA7
         n+yCSAjUxVjblmF8/JnkSyHG4I29N4iPWXaVM605sRw03d4RivBFRPlrfq4NeGruuKOp
         vA9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDM3m5911sKXgP9HNiUydDNQMZoNcLmsHliO6oWG8m9H66UgGppBB8s1jRBw5ykP2TFxhCYFCo@vger.kernel.org, AJvYcCV5BAcwu0napAHz4a6eXBrqaWuckpZy9GEHXGQxBqrtWQ9i3ily1OjA2AMfvlJeAtY+vk8wgXtgMv9WMFoEfj1f@vger.kernel.org, AJvYcCWkNXZa0lM7fco84p980Lt6vRJ4c08+xnJIyiNDxReunvDWmb5vkEWUlAkd45gd/xJWxFn74wj1Jng4ytE=@vger.kernel.org, AJvYcCWrM1sXFgMRYW0V9E2aindSi23wjMYLbdZ5Ece2KJYXrp26HmjRrjaWmBs11i8R+cKFHwDphSULZ/8Aau/QDnw4@vger.kernel.org
X-Gm-Message-State: AOJu0YyjD+xFFcvtul1XGfmjcOcMgdpBbU+unWs+2uEmNrCtPwGKHpdq
	6auYDZ/p2nqIkDti5++a1FiwWS1Bl3jFG1gHsI2+SiSI44cKKA2g
X-Google-Smtp-Source: AGHT+IEs2/vUDPbR2501Lk2Nc8GsO3aMZpIqkf/S/B+zWnIJHjvZLlNWva7nkStLC5ddJRDSspQ2Rw==
X-Received: by 2002:a17:907:3f9a:b0:a86:a12b:2cea with SMTP id a640c23a62f3a-a870ab474a3mr208888066b.67.1724857512332;
        Wed, 28 Aug 2024 08:05:12 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-011.fbsv.net. [2a03:2880:30ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549d8d0sm255308766b.70.2024.08.28.08.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 08:05:11 -0700 (PDT)
Date: Wed, 28 Aug 2024 08:05:09 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: fw@strlen.de, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	rbc@meta.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	"open list:NETFILTER" <coreteam@netfilter.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH nf-next v3 1/2] netfilter: Make IP_NF_IPTABLES_LEGACY
 selectable
Message-ID: <Zs88pbEadxLWLLbn@gmail.com>
References: <20240827145242.3094777-1-leitao@debian.org>
 <20240827145242.3094777-2-leitao@debian.org>
 <20240828074240.2abaa74c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828074240.2abaa74c@kernel.org>

Hello Jakub,

On Wed, Aug 28, 2024 at 07:42:40AM -0700, Jakub Kicinski wrote:
> On Tue, 27 Aug 2024 07:52:40 -0700 Breno Leitao wrote:
> > +++ b/tools/testing/selftests/net/config
> 
> You gotta check all the configs, net is now fine, but bpf still breaks.
> There may be more configs we don't use in CI.

Sure, how can I find which configs I should care about?

> BTW I'm not saying anything about the change itself. There's a non-zero
> chance that netfilter maintainers made the option hidden on purpose..

Right, but it seems there was a plan to have it enabled in the future,
as least that is what I read in a9525c7f6219c ("netfilter: xtables:
allow xtables-nft only builds")

	In the future the _LEGACY symbol will become visible and the select
	statements will be turned into 'depends on', but for now be on safe side
	so "make oldconfig" won't break things.


Also, this was discussed in the thread below, and it seems it is fine to
make the symbols visible:

https://lore.kernel.org/all/20240822132022.GA25665@breakpoint.cc/

Thanks for the review,
--breno

