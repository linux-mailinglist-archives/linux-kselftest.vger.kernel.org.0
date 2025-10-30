Return-Path: <linux-kselftest+bounces-44384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3617C1E7D4
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 07:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6DB1189D930
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 06:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAE822A4DA;
	Thu, 30 Oct 2025 06:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVu1WSoz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076F5213E6A
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Oct 2025 06:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761804035; cv=none; b=T+7CHnOVnP1QfUgYPZv2M4MAT2H4Huc+Tld+I1+5R7vFKaL7clux0M7nCwKzgyYTv4dLNepIFdeg+yjD9ZfvRq3Dl+KbSwS+qAVcFeioxMhjRuU4l74PK+3XuvWI7RgnQDBuVll1VeonwUOKRJBZcohxIwKhgzvyo+cP3gfPK6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761804035; c=relaxed/simple;
	bh=XEAjlwYYF3NQuyc7FS9cFXhCUN5UMP++EuqVshoBY3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLjorGmBXoZJmVKpbRShU81ABVN+Yp7drSkikNK7wEhEUk+g4EjGfw9cHeN1QR8m2bpzHMjWnbP6Gsjta8SYDitem3P3AI1Ft2DXyoL4/pNp7d6YDppeCiDIXE8EfzW2JunhUBeYGLKUxlwOVsa4lVrGr14IJGbPGSyAR41lWzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVu1WSoz; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so684663b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Oct 2025 23:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761804033; x=1762408833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4uR81dh1lUx0VLG29+RqKpRKmy+JaoTRfZUvtKc3mPg=;
        b=eVu1WSozcmCeyuJlU2bjQPfHQ1lOyNLL+HY3Q+nBMSlouc9dXaDfLCOmjWHuq0O8I2
         ZyW7qnypVTTPA3JoJEW1AhvlK36tVnzROvyRjn6B+BEy0qKmgo/Ce1J2gZsYDjDu7c1K
         UTe3EPy4fO6XozrguzbztA/Iyi2BK7si9hT9XtoHM1Wy21cbFdCK3gaxmYDEq3oYfy/8
         v02soMRh8clDGOorIUW6KedX4NwV+VhSG6cGSDpoWtNa5CXdJkiXo38r74TShJ99gnqD
         Ibj/yX/JBN7gVR9xyXhMB1cwweNlPoZw1dR1ASlns0PgXvRbKMtRRQU8GejKvRQ1069X
         5wNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761804033; x=1762408833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uR81dh1lUx0VLG29+RqKpRKmy+JaoTRfZUvtKc3mPg=;
        b=w6/9HXo+CMsowCqEKg1mRbqGqfEwa9WczqUdp+GRgB5+pzf/K+2BBTw8IGSaowZ57D
         YWoqQ1naWb1cVLOsrFA0QWXja3LzOrNuEeccZeO6GGgYzMEeea6BOMFmP7eh1cOARIas
         fO3pEfWsVtdwps/GD/Ss9wk2ZQkfCdVEvx4WkFE1LhhjZr9TZL9pT2V8cD54RH8UBln5
         chHhj5P3HLixnQFMpM51jW8sfUNE3P0q1kmJr+v7Z5ygpEM+mCgo5tVEJ/5NwWYyd3hq
         b9B6LUxmvVq2pIy9y4Xlbq9FwCAXctW85fyG5GFtxHMtzEw1RuIy3UwMyrujfbBOIK0D
         pnfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuBToHUH26hdyS16Yx/zHvxyjIemU1hUwuijdgNyTonFHclocgPkDHKdARSHR5fsG6h2N6ccV2o53mPDd0au0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0yalExKREC2mNBSIF3MmlIuLehfUAJFE4muEg9BxgPtumuO2l
	W52l+/NfVTGtkE542UOCWFo6iEZczeY18u3fAs6uqakPGFSvGPc13PGP
X-Gm-Gg: ASbGncsaYWU0u7SzAZpwvM8rrwW37/DX9uztmkgq8a5gZpSSII63gW+UnfC+YzkvPBZ
	sX0U9pfQ+ztuM4w+qnANCkxtN9VyLbJgv65N93tRydmbEnyD3+D4lvcSJVb6ENOxX5JqK8zG5BN
	KNAMAwCddHbGHQk5s1KGKtEjMuAMyd1Jqgjt6OBzrFZaXSYdnE5yQuXkAiTp5GONkCAGeK3Ja8B
	NdxS65n4p11bSO0ewE/sWTdBSstAz+Tjgh9kBEsCmzExnGuyBgUXagav0r663+DUwIkmjq3UBZp
	TimK5udIR1u/iVYTRSW1Uby6dv4vQe5SCzCp7oeEC1UTZF+mf99Zhok5REzoAQudM25/CGQFHc/
	7ea+JpmiP9hGYySFcjsZPQ+oyssZNmOg27LtJUaY2Wbjpo3txdAUQ5+DvU96Hs0hg/AdpiKz71F
	wKnl6nmEMAXRTAKEE=
X-Google-Smtp-Source: AGHT+IHkrFWmM0YexxS5c3JBOQRGZUBm0Gg/W5HZtvWbmHHj7ZUGTnyMBtNr/t6pp99vomcNW46A6g==
X-Received: by 2002:a05:6a21:3510:b0:2da:3fe0:3299 with SMTP id adf61e73a8af0-3477aba1180mr3086189637.7.1761804033077;
        Wed, 29 Oct 2025 23:00:33 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b71268bdd50sm16016865a12.0.2025.10.29.23.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 23:00:32 -0700 (PDT)
Date: Thu, 30 Oct 2025 06:00:24 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jan Stancek <jstancek@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] selftests: net: add YNL test framework
Message-ID: <aQL--I9z19zRJ4vo@fedora>
References: <20251029082245.128675-1-liuhangbin@gmail.com>
 <20251029082245.128675-4-liuhangbin@gmail.com>
 <20251029164159.2dbc615a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029164159.2dbc615a@kernel.org>

On Wed, Oct 29, 2025 at 04:41:59PM -0700, Jakub Kicinski wrote:
> On Wed, 29 Oct 2025 08:22:45 +0000 Hangbin Liu wrote:
> > Add a test framework for YAML Netlink (YNL) tools, covering both CLI and
> > ethtool functionality. The framework includes:
> > 
> > 1) cli: family listing, netdev, ethtool, rt-* families, and nlctrl
> >    operations
> > 2) ethtool: device info, statistics, ring/coalesce/pause parameters, and
> >    feature gettings
> > 
> > The current YNL syntax is a bit obscure, and end users may not always know
> > how to use it. This test framework provides usage examples and also serves
> > as a regression test to catch potential breakages caused by future changes.
> 
> Hm, my knee-jerk reaction was that we should avoid adding too much ynl
> stuff to the kernel at this point. But looking closer it's not that
> long.
> 
> Do I understand correctly, tho, that you're testing _system_ YNL?
> Not what's in tree?

Kind of. With this we can test both the system's YNL and also make sure the
YNL interface has no regression.

Thanks
Hangbin

