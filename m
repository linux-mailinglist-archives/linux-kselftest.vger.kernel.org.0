Return-Path: <linux-kselftest+bounces-46298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FF4C7C2B1
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 03:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 248EA34B854
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 02:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A51262FD1;
	Sat, 22 Nov 2025 02:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmjpBe+Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C2B212F98
	for <linux-kselftest@vger.kernel.org>; Sat, 22 Nov 2025 02:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763777820; cv=none; b=ZvUvlTAdMhcoZ3oQokC+vil6ethZqrtHQZUQN/MEvZjfllVCMYVDF4zHFD1n384Kc31d8QFCK++zaxsnIU9m0xAYPI/at4jAMFi+/L7wlZt0vM16X0X1kDhqB+4HdRqvgBYtio1Bo2IkDoNmUDhrX9R9l4dSJahZPsioKXYRp9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763777820; c=relaxed/simple;
	bh=HcTrfLl0nwxO5b2LTWB2R002IRkel0ACVCeGY+W8t2Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=B+GgpcGWIrndCtc0EHgpPghLHK+ptaBlc8L+1mbDvUpu0J8MU3j8PL5e5wC5bFfRXfHWOukdMgVFABVYk5dqbsoXqcWgDtR+1nu5jPzHJvtywKib52ubXdkvgk4+QCHtoToGlRmTfcymDq3KfrGaRPRifE8qWbsxxpN6mvcdtxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmjpBe+Y; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78a6c7ac38fso29971577b3.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 18:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763777818; x=1764382618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZH1duZnEPXr5MV5XSfY2om1ciAirSpLv1SrLG39apQ=;
        b=OmjpBe+YkaMd06KW4juBXlmrzO5506AxVnV/FI6Fu27wVtgb8Yj+S7NHg0ZSEB7p6s
         gmlc/+8GhJj8Aki7a7D8Tp2gHkxrFORSFkcbH/RzG9j3w5AY3GyvMyWrifVwbleb+t5t
         GbT865EVyXawPMEbpD0rICtHvCPI+UxhewrHzQ3ETGonSxuzvGa8Ld8lYqO51LOYmFY1
         Unarl5Vq3ifIg6I4yxvFlFc/Gy5gEH1iAygdGNRe6yyoZNeHX/f5IaMJj4QZSVsHdBMQ
         2FdCDYiwtWEgvwd3ammzbPJ23U5bftyZ+6zBqAK72xqIUqzRIETg1tQ59DibYvrz8nem
         HbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763777818; x=1764382618;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fZH1duZnEPXr5MV5XSfY2om1ciAirSpLv1SrLG39apQ=;
        b=KKT656Q8nHsrVTyK9UxWapKK8BPl8W2kJqjEmJBwz4RqLaPjtatsGY4Uljjpy6VYJh
         XOVQVZofAH/6rODvGcxRoVk4thL7E3ZP6jATReFZOLNW+xvomf/Hr0o27b245MWXi329
         h4M1BJYAi1yog61BDt7ghgVuzoIFtLT9zd/EWuhF3OHWWPejKqa08Q4e5ZrqSYaI4aAQ
         1qTJi0dLe5J24dFeXyE4k8VW7vyjR+fYyeeXC0kVH3JjtrMk8FHsB3PeyHcLmb6pvMes
         zN08W7nrFd1AsfM2F8z3M8gOWRjVTGGgT/4Rj25/mr79XjBh3krYZqXgeJEVqKzWCROY
         OeTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGbAhYnq35aiydSuaswGQODec86JpOMy9ednIIXUBsnXTGWTE0mhKBQ5T6JCF3tSsNCm6Lc0p3o7vYQNLswnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YydoisgLKfayrbAKxiYaXMiRuWVPQXWJMd1K2uNtJJMg5wsv1al
	3IQc7Kjj1tekjbIDKpax8MS72VacMYN9ePjaFAuZtjUZVKUeZqIUMzKz
X-Gm-Gg: ASbGnct/p7Xmkbb7riw0XysVMlA6lID977RP8SDG5h7qb78pbdpgjH62Iy6pYxgZufE
	WASYlTVRu1818VD1e+IznLL5WekgpmLxoTtJkB6hM9skbL5fuX87NZ+R4cXNs7wFv0Lcv+ESe98
	rsmd8Bi2UKmQPdXHU04OwkSm726RT2mO5m7Co4MXy+Du3PtP+svBuy9hF9QWvoFB/TBOYxJrO09
	eyfmTt/Ag49Mb8RUQoo/+6zd7QxJQI7PtNGuEGDPYolZEleOYEKwpXS8166QNxBZtYPr1NC/P2h
	hf5ZlhZpmt+DLLI3CovNbbY9Eii7/o2QzGnNvGhBMbIoHEZukDMlmyqcaYhIQcWP1mv97OJ1Yjg
	K/FQey8OU80NStdL/bVojv/qv74QGm58RdFDxuycD0Jhj8ZaxTL4/DNRDkhY5JK0y7rkd82u/iW
	aCmMY/dZch21TVT5maA/AR1fDqYfIcU1teRjLWB5kGjofGjaiLGMEHCOhJYv3Dnrbm+Ow=
X-Google-Smtp-Source: AGHT+IHoO6qNAUPw4+8PucvKAsU+85vfg1dtDVD5lxUKXjlhSCB8zRWLNk0AzYZnMtp7pZX7xPRC8A==
X-Received: by 2002:a05:690e:1511:b0:63f:a324:bbf3 with SMTP id 956f58d0204a3-64302ab18damr3307134d50.42.1763777818152;
        Fri, 21 Nov 2025 18:16:58 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-642f707a9b9sm2278959d50.6.2025.11.21.18.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 18:16:57 -0800 (PST)
Date: Fri, 21 Nov 2025 21:16:57 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemb@google.com, 
 petrm@nvidia.com, 
 dw@davidwei.uk, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.53e77e2eea78@gmail.com>
In-Reply-To: <20251121173203.7bc1a3f4@kernel.org>
References: <20251121040259.3647749-1-kuba@kernel.org>
 <20251121040259.3647749-5-kuba@kernel.org>
 <willemdebruijn.kernel.224bdf2fac125@gmail.com>
 <20251121173203.7bc1a3f4@kernel.org>
Subject: Re: [PATCH net-next 4/5] selftests: hw-net: toeplitz: read
 indirection table from the device
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
> On Fri, 21 Nov 2025 18:12:16 -0500 Willem de Bruijn wrote:
> > > +	if (rsp->_count.indir > RSS_MAX_INDIR)
> > > +		error(1, 0, "RSS indirection table too large (%u > %u)",
> > > +		      rsp->_count.indir, RSS_MAX_INDIR);
> > > +
> > > +	/* If indir table not available we'll fallback to simple modulo math */
> > > +	if (rsp->_count.indir) {
> > > +		memcpy(rss_indir_tbl, rsp->indir,
> > > +		       rsp->_count.indir * sizeof(rss_indir_tbl[0]));  
> > 
> > It can be assumed that rsp->indir elements are sizeof(rss_indir_tbl[0])?
> > 
> > Is there a way to have the test verify element size. I'm not that
> > familiar with YNL.
> 
> I suspect the reaction may be because drivers often use a smaller type.
> But at the uAPI level the indirection table has always been represented
> as an array of u32 (I mean the ioctl). And in the core we also always
> deal with u32s. The Netlink type is not allowed to change either 
> (it's a "C array" not individual attributes so members must be known
> size).
> 
> LMK if you want me to add an assert or rework this. We could technically
> keep the rsp struct around and use it directly?
> 
> Not fully convinced it's worth a respin, but LMK.. :)

Not at all. Thanks for that uAPI context.

