Return-Path: <linux-kselftest+bounces-44629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B238C2A0AE
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 06:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EA71134669A
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 05:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB09145355;
	Mon,  3 Nov 2025 05:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKTdPFrq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F20F13AF2
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Nov 2025 05:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762146774; cv=none; b=tAs2hC71MgiB1u1eDiWbDMmDK0sZOubHUfnZIeoT5bgaO8EoHk2o9xZEHo3/dg44+j8UG+Ttd8/FoXpTimaINGzh8coupeQqchbIeaeAqAZN8cxM7nudkPM/xKs26GionEgJ90xDNCBDW2Nw2iE5G5o9juRVhD+3N6e5UuO3c+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762146774; c=relaxed/simple;
	bh=YrlqCfaqyBZJL8zxbvPY24vo8xlmOetjJXuiQh+Lm7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRpifcv1YwUj1CjnXm6kHMmrw47skAiLhj9u4SYxAwQrurdG0Sg37P2GF7asFtS6X+LdFD04EzNyqwvoP2PaYHDmieLRmLLEa4vauXUv1im+bbpd2ddL0uClYSwdJNAh1HkVQP7keFIRhiJMbqPPf3jPQ7uO5eheGT8yuDCS+4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKTdPFrq; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7a4c202a30aso4001138b3a.2
        for <linux-kselftest@vger.kernel.org>; Sun, 02 Nov 2025 21:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762146772; x=1762751572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=53Y4J0pYrNQqP0ePl9L2M/4VMzg2WxKWv9mG/vikazQ=;
        b=ZKTdPFrqJzNiXDeyzBehgo8wpIvcTk0VYUMtv0mJFzK1qu19p+U7HfPIVivGiVf3ux
         gNB5370LbchwS4DY8kAGTAQ128Odx5nGA1vG3EaVQUP614mcs/BwkN337YfI5d4iR9C0
         /kJ9ZQCkg+/Q9EYmS5vbz8j6ZqjiFebs16YVC3LML4KyGrdSsMfsC58tzGt2eZ7fsC/A
         2w58qgqu7VmhDWk91SCtNcBRBaBoU5DNteXcw9/41v8KA4eT7GvXWZsOL4GlysQYyAlH
         r3YH814JI9FNAyFM6rcLH7yzUtXX9nI8/C4Sm+wFOghQQxrK27PnLHb+MXO9GLBJRKtv
         sXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762146772; x=1762751572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53Y4J0pYrNQqP0ePl9L2M/4VMzg2WxKWv9mG/vikazQ=;
        b=Jb5IvpCEW6kBQHYNMZ8Glh+gZKYimsZGOSNgGUIrIfzrwQ6z857MXZcBBx5gQIfUb7
         TGEMdm2Vzd3KTlV8di+ybYLxgLhxMT/Z1LOfbfTrDgq7Py6N3fdyZCUZQPcrEOdJtHKj
         P3hRk/F1S3w/90ezq4uj62vvhhHkqXa4iDeoQZS2t3497eMYPmVycUNBD2XxSW51LEL7
         /OkJvtdUwCyUeCePwy2KtreFbJzi9vMiFoDWVbNh0/QnZVSnNqbt/IFOUhhDc1K6LoNu
         WXbnNNzK4oBi0xgdfmIx6/Ztg/m0j5uYh8YxMzeXzcIrxgs1Lv3E2XO+8vcsAxeFGetx
         uecA==
X-Forwarded-Encrypted: i=1; AJvYcCW4JJd6P043mf5EQr2XIufV9K/h5j+qMDzrXUi7YWvAJIZ6HOmNah8nT5Kb8QNKmqyq8vSd88z4IL5qJkdaxRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbOqiCJ57akUwbJJ3JS6Jn8yUUZJxLUx7rSgvJhwOhtKzJLfCF
	IriMRqjLcMhSSNa3tRUS/6Z+m98wPkpUlkpRjPnILHAZLqhBxWC1OLUU
X-Gm-Gg: ASbGncuYhsIGA8YSZlrRXy1GrF7kLUH0eURPAIDXrYKtwqj0YqoBtcwrAsiv0NHdYG9
	uQREDiHfrdIl5o6+f27TImjdIkzCMSCDD1gykZ31IIGLrSeKJtUzBmlRvW7zdcE6BMxwivwC7kL
	uuy4F4A5mzvSsARMJUA7lmwYU5+T2ryP5i9Leu9iM9p63Uj84epXrFwQ00isoc7wnTV8IykZDJM
	wUOLgLrUWhxai6C5ABT3XrGwNO82h9adkDgVK87/I42uJ6s6ZZMYY+sapqW5n7Lu6E5ufU+Qlog
	ejuVZ5IYqmkflNQb7o8++Fk38tbyVasyjy21NXEe+eVeUz1ux/jNPxRgtnBr5XX/E/u8ULx51MG
	4Gbysp3q5L+1EmZOKL0Y1yXki32XsnGQyJpqEnO+h13A5hw6SvEhnnx2VLG8zWl8SvJzBmDXC6X
	bCFKXD
X-Google-Smtp-Source: AGHT+IEFKuT4chWVteF92qguLHXYW1uXR8F18FiEVrtnfDbDi+7SKkfi8PSIO4tIekZXseQLHk4yjA==
X-Received: by 2002:a05:6a20:5491:b0:341:84ee:75af with SMTP id adf61e73a8af0-348cc0c0a17mr15804544637.49.1762146772523;
        Sun, 02 Nov 2025 21:12:52 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b95c44f7363sm6919427a12.6.2025.11.02.21.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 21:12:51 -0800 (PST)
Date: Mon, 3 Nov 2025 05:12:43 +0000
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
Message-ID: <aQg5y_Feg6YQ7Odl@fedora>
References: <20251029082245.128675-1-liuhangbin@gmail.com>
 <20251029082245.128675-4-liuhangbin@gmail.com>
 <20251029164159.2dbc615a@kernel.org>
 <aQL--I9z19zRJ4vo@fedora>
 <20251030083944.722833ac@kernel.org>
 <aQQVYU1u3CCyH8lQ@fedora>
 <20251031112406.403d1971@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031112406.403d1971@kernel.org>

On Fri, Oct 31, 2025 at 11:24:06AM -0700, Jakub Kicinski wrote:
> > I just do `make install` in tools/net/ynl. Both the ynl scripts and specs are
> > installed. So I think the specs are also tested.
> >
> > I didn't get here. The `ynl` calls pyynl.cli:main, that should be enough.
> > Do you mean we should find the `cli.py` path and call it like
> > `$source_code/tools/net/ynl/pyynl/cli.py --spec
> > $source_code/Documentation/netlink/specs/xxx.yaml ...`?
> 
> More or less. But it needs to know how to install itself when kernel
> selftests are installed. Maybe it's not worth the complexity and we
> should add the script under tools/net/ynl. Easier to refer from there.

Hmm, how should we execute the script under `tools/net/ynl`? Use the cli.py
like:

./cli.py --spec ../../../Documentation/netlink/specs/xxx.yaml

Or use the installed name `ynl`

ynl --family xxx ...

Thanks
Hangbin

