Return-Path: <linux-kselftest+bounces-21436-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7599BC3E2
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 04:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD951C21123
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 03:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC421714B4;
	Tue,  5 Nov 2024 03:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/unJz1S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5F53D9E;
	Tue,  5 Nov 2024 03:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730777521; cv=none; b=lptTHMBQN6sClpO0ZeXdrEb+eEdimeYb89IlZc+eyGjkqNYH/MbiYbOOTKIm7QUYSnXr8LfT+/IHem6IpCaQeFKRpbi97DxXyq/9PfCJ/vWr77c3H+CT0cw20BiKgfgd4orfoxbQWeBA5iz39NxDpmqaG92SZGS2P0qfjKXSjD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730777521; c=relaxed/simple;
	bh=M6q8jWfnoqSJeNKe5Q2MrOE2M617kJff3iOfX1aQV8A=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3x9H6iwt0wouqjFuWSwMuq3wbpuNhDM2z6BlL9YqEsr2YkABNPUrj7JNyesjDdL1mMK3ced929OLSGJBySWWK99/SxyshgX4sciscnk7/oqX7NUk8eBZpURkX/K/qCU9VJ8rC3A+dLELIibktDp8p/mVN4oNGaDd2a4tFPY4tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/unJz1S; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2113da91b53so15851025ad.3;
        Mon, 04 Nov 2024 19:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730777519; x=1731382319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/BKUeGL7P6699SsUhj9FODeTe7yaB1R3gH0XtlnzNQ=;
        b=C/unJz1SIoam3eWnAXRo/bb3K5d4WG6Pw14/t7wHQJftMAoPw4cNTda5CmhxDmeQxI
         k3KMbUkQ2wTYURFVMTCvcvSPR+FOrQPbyqoDDuXoOPfskGWhFXEWr+A++Dq9Is3bvWO0
         jdNVZpnXgIz0lwarF5bHW8uPnv48RLkM+FCd+TNSrxhGVHO+Kv/wbt0gSTTbhcMVEn2G
         F9s38RQCytkRkMuV/JBQv6TQ+fwiuKlVYcGj2I8r3sFQYlsG0TtdisYFNC3XvbNR2ZEm
         Pb3Uo/Cc2HDJpomepXFZvayIuvWkHfVp4onWrLa1ewmVOudTjJ4O6QPWKqpeXLcJRi9z
         QaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730777519; x=1731382319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/BKUeGL7P6699SsUhj9FODeTe7yaB1R3gH0XtlnzNQ=;
        b=c2Xd81idYvKbclIu8zesh6Gihv+ZwV2wy/zr3stbMeG+7UNswfcKhR4hiloj6oCklM
         FNPJBR8MIchmaQurKF1BLPXe0K87ZzsZQhYikWjOe846ljcgTYjz3UeTVWc93sYvCfcm
         SK0MA08jvROB/dYY8NBGec06SgTy9/mKEm+u5FfM6/zsSoRB8qOLNknOquGl9/jvz0w/
         A+uhAMc7BNQl1Xz5KeFihXIreHGi0kyBhpsgocO+WlMg9opti8zB2NT4C1S9/sZw5+rY
         algoIKMLNTh6oTG0CLAVlNvmIgC6/eTvEyMQwTcVuyu3bBiaw31HILJRTvstgxGc42mf
         k1vA==
X-Forwarded-Encrypted: i=1; AJvYcCUDZoJW7trec+1RagcaGoIAu1MFdjs8w9NqMXU3tpnTn8kdSbMx6DbN6HI+RnK1plLcUJ8aRwVi@vger.kernel.org, AJvYcCViURF5EN8UTXMiOl8upQ6UefUHP1XEtIRccj7dQOnTZbEg1PjO7IE/hQl8eChrO6FO8qGt8gvVicrYzLM=@vger.kernel.org, AJvYcCWQFsiH7M+lyK6Yr3DHqLjM0hYEnSyckk8nqF6b9nqJy31x/LnshvBino5wmeMqMM6FmoMDHw5xgf+3yvga9Lv2@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+l8QYNkrjH9HNT+qcIiUm7G6Lg11rEjKht/BCv66R7tzlzmlW
	NtJB5FAnyDq31yzJmTfvT2tEAnCg2nzzicP8WEr0E7SiRZtHVM8=
X-Google-Smtp-Source: AGHT+IHmLlosF584MVLHK9OSUZ96/YmbPjIvKtOBXrm4rB8HVaeF8modVB1MzQqd3Do5AJSM20koqg==
X-Received: by 2002:a17:902:da8d:b0:20c:d76b:a7a0 with SMTP id d9443c01a7336-210c6879efbmr453369225ad.8.1730777519247;
        Mon, 04 Nov 2024 19:31:59 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ee3d8sm68492995ad.20.2024.11.04.19.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 19:31:58 -0800 (PST)
Date: Mon, 4 Nov 2024 19:31:58 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Joe Damato <jdamato@fastly.com>, Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v7 10/12] selftests: ncdevmem: Run selftest when
 none of the -s or -c has been provided
Message-ID: <ZymRrhOcrWchdGU7@mini-arch>
References: <20241104181430.228682-1-sdf@fomichev.me>
 <20241104181430.228682-11-sdf@fomichev.me>
 <ZyliszeFtcZqfsnm@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZyliszeFtcZqfsnm@LQ3V64L9R2>

On 11/04, Joe Damato wrote:
> On Mon, Nov 04, 2024 at 10:14:28AM -0800, Stanislav Fomichev wrote:
> > This will be used as a 'probe' mode in the selftest to check whether
> > the device supports the devmem or not. Use hard-coded queue layout
> > (two last queues) and prevent user from passing custom -q and/or -t.
> > 
> > Reviewed-by: Mina Almasry <almasrymina@google.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  tools/testing/selftests/net/ncdevmem.c | 42 ++++++++++++++++++++------
> >  1 file changed, 32 insertions(+), 10 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
> > index 044198ce02a7..270a77206f65 100644
> > --- a/tools/testing/selftests/net/ncdevmem.c
> > +++ b/tools/testing/selftests/net/ncdevmem.c
> > @@ -76,7 +76,7 @@ static char *client_ip;
> >  static char *port;
> >  static size_t do_validation;
> >  static int start_queue = -1;
> > -static int num_queues = 1;
> > +static int num_queues = -1;
> >  static char *ifname;
> >  static unsigned int ifindex;
> >  static unsigned int dmabuf_id;
> > @@ -731,19 +731,31 @@ int main(int argc, char *argv[])
> >  		}
> >  	}
> >  
> > -	if (!server_ip)
> > -		error(1, 0, "Missing -s argument\n");
> > -
> > -	if (!port)
> > -		error(1, 0, "Missing -p argument\n");
> > -
> >  	if (!ifname)
> >  		error(1, 0, "Missing -f argument\n");
> >  
> >  	ifindex = if_nametoindex(ifname);
> >  
> > -	if (start_queue < 0) {
> > -		start_queue = rxq_num(ifindex) - 1;
> > +	if (!server_ip && !client_ip) {
> > +		if (start_queue < 0 && num_queues < 0) {
> > +			num_queues = rxq_num(ifindex);
> > +			if (num_queues < 0)
> > +				error(1, 0, "couldn't detect number of queues\n");
> > +			/* make sure can bind to multiple queues */
> > +			start_queue = num_queues / 2;
> > +			num_queues /= 2;
> 
> Sorry for the beginner question :) -- is it possible that rxq_num
> ever returns 1 and thus start_queue = 0, num_queues = 0
>
> > +		}
> > +
> > +		if (start_queue < 0 || num_queues < 0)
> > +			error(1, 0, "Both -t and -q are required\n");
> 
> And then isn't caught here because this only checks < 0 (instead of
> num_queues <= 0) ?

In theory it's possible to configure a netdev with a single queue. I can
add an extra 'num_queues == 1' check just in case...

