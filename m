Return-Path: <linux-kselftest+bounces-36456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC26AF7CB4
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 17:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F085B3B1899
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 15:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E97222561;
	Thu,  3 Jul 2025 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLd8g3Y/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D721D2CCDB;
	Thu,  3 Jul 2025 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751557266; cv=none; b=XMmwteEgdCr9e//aOpXm2GjGMtWC5bpUikVjJaSkypTsCQR5WAfki8SuKlSdUR3wnf6t13T+PzP+FjH7v7bHdoZ9qohBCCP+DMz6qlvsF0K54JfrVdeVNsXzRUaB+02emfhRLOiQz1lRtclKGdfv7Eh1uJlPgcHE0Ua8xHez1Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751557266; c=relaxed/simple;
	bh=2Q0H0oTEI6osKgmBUcQ0Vx1DeiJYeVXnIbeTyxj3y0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvV8hArPfN9RExpI8ysikQeZupuXVDY3Sv4+CdiQfodOb2kJV3DHvIBElc7MFAZ/tc1P0s1D9dxWMFjRCQ/JiNybbxF+Gy6Mz5X6aHFB2ygfNShh5fg8xx5B516WhLqJefWcKtIiIzrfqGI4IgHJb1/gLb6j3mLiCENLO1361Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLd8g3Y/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-235ea292956so896635ad.1;
        Thu, 03 Jul 2025 08:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751557264; x=1752162064; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QAyU9d8D+QfTEA5qpsji/SqbWZy0ORg7+EhfvcHP5XA=;
        b=CLd8g3Y/YojehmY5g8onPwlCioaVBqH5g8pp9/Cki2+eIEkN+Lt6ro1JIjdtu2P8Kr
         F7d/Cmtq0qXUq61C0aA8Y4ULqHFG/tXy/XcWBRG0Ora3ZH2g6YESFRmpQ2MVTRbIyeuY
         eHJJuTo9kryTDPHDyP4L+cbuJUUCVtFLELzW4zHSyadsuMA2LaVig1jDLa9sGNq/amPR
         8F1lM6PbAdMQX4Xfhll57FJXP1K2tZJrGI2YCnVOorP8mPbWQr0EpKaBrQN1oJAiIdh6
         n5SyCgIb3J4/ebDGXh8gw9eynFAsWD6bppMJ1EDX+eksZinqi41kMWywAe5Ww+2ivvHT
         0Y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751557264; x=1752162064;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAyU9d8D+QfTEA5qpsji/SqbWZy0ORg7+EhfvcHP5XA=;
        b=kEgEG4+xvt8EusSt4qSYEZostV1tl380aciKIYwQUX4yZOvO2N2G56e2NExrErVKEB
         0lflhMk6EWLlMRbUJNChr6BwhQPXLi+ydhyQd2vdXywL/cpxsBEs+70LTDLUSOS7JUtx
         RBbKwEajoG6zPA6pOVt9DtUdByQkQdYpVHjJxUNw3nqK9quGLE3z4LEOL/z6IBYNuxAU
         lihLB++qFoJXSil9XZCwtHBMF3K1G8YqTWFCkNaeEsdo2k1Y8XroUTbwMHxEKeJ2dcXN
         1yp5HKtDzS6YM+/Z/BXZvsKRUXm6l6z9zeR2gFJhrlazfoxPxHXAKH2DgDW0hdbu8tQd
         5Ghw==
X-Forwarded-Encrypted: i=1; AJvYcCU+GeBaqFwL4zLYoXFlZzwSPDAC+ABbw+Bj5E1wBNaM5vxFSOKETawr/4ft6x5BrWbluBxNfuzN@vger.kernel.org, AJvYcCV0FlcPPVPv1L3NtpgLQa89oHxWI7VoVcTg5yZdrdRkQYGqpmVcVaaFFblE+P7qDACfdLQR6Wu1iL0tnU8/F8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl8AvXjK8BMNpae7tcOTOoR76cxovW4IeocoEIww/Va8flIQ0c
	MeayrdqeZAVK7SJCIoeBY+vPRESiUDXgpNazPn8003MMT1vN77vv5G8=
X-Gm-Gg: ASbGncvuzxxiaXMKOHbxH9VJPtCgOKxGYphXuutnNR5fM4kszK9SPwP5sMZRJkvcjdF
	QdhwXgg+Hy66oCaNWdPrWPCmgfwEzQUZgAUJGCX/GMguyBMCmbBilZj0dkuJd1CzIYAXjpa5k4O
	MklrreHu2AIWYcwxnp/j7TTdi54lZFP/PSAN535hdiej8Gk6QJ269N+sofrHy3pVCHtKvhjnKz9
	ibEdWtxtASKeAv/hgiYszPShMm1qR8St10Zgt4YTCxq3baABHgCyifOl1HakPKd9EvibGOveVlc
	ShB+5JEOmJWTaML9OGp8R1c3VIU+9mGysVF9I4Iwp/c1Q1ZO7bjHh3UpfPRfanK5O7SubNKcwjD
	E4iIZbGEBlAS3xwtaJkV+Z7t/tJRYHis8OQ==
X-Google-Smtp-Source: AGHT+IHKNfRLpB6X9hZLBetFIoSlCL3dAmPtI5SvyXFahjwKQz4TRC//q6fRdJ7Ig8G52w42c0yqDw==
X-Received: by 2002:a17:902:da88:b0:235:880:cf8a with SMTP id d9443c01a7336-23c6e4ac48emr103895625ad.15.1751557263915;
        Thu, 03 Jul 2025 08:41:03 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3ba55asm155062795ad.198.2025.07.03.08.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 08:41:03 -0700 (PDT)
Date: Thu, 3 Jul 2025 08:41:02 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, andrew+netdev@lunn.ch, shuah@kernel.org,
	almasrymina@google.com, sdf@fomichev.me, jdamato@fastly.com,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 net-next] selftests: devmem: configure HDS threshold
Message-ID: <aGakjsP3ya6mJE9V@mini-arch>
References: <20250702104249.1665034-1-ap420073@gmail.com>
 <aGVSMYsoMvlBPtC4@mini-arch>
 <CAMArcTVYyGWAY0B1mem2nosQk1sJsg5nq9Uz5qB-wa7MFsqt7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMArcTVYyGWAY0B1mem2nosQk1sJsg5nq9Uz5qB-wa7MFsqt7g@mail.gmail.com>

On 07/03, Taehee Yoo wrote:
> On Thu, Jul 3, 2025 at 12:37 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> 
> Hi Stanislav,
> Thanks a lot for your review!
> 
> > On 07/02, Taehee Yoo wrote:
> > > The devmem TCP requires the hds-thresh value to be 0, but it doesn't
> > > change it automatically.
> > > Therefore, make configure_headersplit() sets hds-thresh value to 0.
> > >
> > > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > > ---
> > >
> > > v2:
> > >  - Do not implement configure_hds_thresh().
> > >  - Make configure_headersplit() sets hds-thresh to 0.
> > >
> > >  tools/testing/selftests/drivers/net/hw/ncdevmem.c | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> > > index cc9b40d9c5d5..52b72de11e3b 100644
> > > --- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> > > +++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> > > @@ -331,6 +331,12 @@ static int configure_headersplit(bool on)
> > >       ret = ethtool_rings_set(ys, req);
> > >       if (ret < 0)
> > >               fprintf(stderr, "YNL failed: %s\n", ys->err.msg);
> > > +     if (on) {
> > > +             ethtool_rings_set_req_set_hds_thresh(req, 0);
> > > +             ret = ethtool_rings_set(ys, req);
> >
> > Why call ethtool_rings_set again here? Can we move ethtool_rings_set_req_set_hds_thresh
> > to be after ethtool_rings_set_req_set_tcp_data_split ?
> 
> I think tcp-data-split will fail if a driver doesn't support
> hds-thresh, even if it supports tcp-data-split.
> So, I separated them.

Sorry for going back and forth on this, but in this case your v1 is
better (maybe improve it by not printing an error for 'not supported'
errno). And will probably better be suited for Jakub's suggestion of
adding undo.

