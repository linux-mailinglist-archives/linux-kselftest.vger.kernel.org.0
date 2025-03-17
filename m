Return-Path: <linux-kselftest+bounces-29221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B43A6515A
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 14:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB701883DF1
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 13:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B5C23BD0E;
	Mon, 17 Mar 2025 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="PZesGYZL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BEAEBE
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742218585; cv=none; b=MBfEurz+nlTxdCinSvbqWtlAyiZOkLdG/FhKPl4LjWbG6YlL/Zb3m2ibrD/Nkz6kt6QCV4hQaEhx47bVzbMBd0AJvSTc867uoJRUnwfwN27GWVgaOFJTKrOsNhyParoQ82EN0M9VOFSs3pmalj29uJBlffgvGMFeHJUsrN+3JBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742218585; c=relaxed/simple;
	bh=Trb02ucwdNT7njn5fU7IQgeC1x6g8J7T0PM9NITVyU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vBz6qIb447WglyZHczwx4Ib1er4PjO97EJcyVgXEWvg8rzOEeyFkDdAijIKOVqDGzv7pfmysXLM1kJEPAX9dyXjQ4WOG70aka0XvUSkagIYNbKcL5Za9jAaebFBxYf97qrtJ+PL9V8Osdfm1N5t21iw+P+61hqy+N28pljjGvFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=PZesGYZL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22548a28d0cso118087095ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 06:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1742218583; x=1742823383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bM9J0DqT2fl7geMphRuEwoWQW8kW6asNpCDgXyvg7U=;
        b=PZesGYZLWG6r3VpIBTT5XAiDbrq8yJUY+xEk3amSGxF+/SQZVpJOWSD9M47AWQ+OiP
         hc+fjsKX//dy2eTAeRdw8RjAJFn8e7sPhGnyvks3YV+9Q3hSZSDUPiTboj1CP8aPiOy2
         Uwn5vpD9/GlqNTvzs1xxSVTcNa/N/L7QWzR3GgnwDpSgfdtBD49SIijh0BBH6BYtk0d7
         3ver5PaGwFjm5YZjtJe80ptV/J0QDwU6h5jlnCHVDytSqpIMSGZyqge8duarZbOa9DZK
         muewJyx3AYQ56F/9ACT24yDHWEnTgJSHSwKsyf7MHztgMWpJDWphPti1Zo2hdFF0gkgp
         hJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742218583; x=1742823383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bM9J0DqT2fl7geMphRuEwoWQW8kW6asNpCDgXyvg7U=;
        b=t7zlIkdsG11b8dNgURzaKdGTPtzMo4f5FkGSABCdesDEjVmrlKwKoB1PnS1J76go6z
         wkwLrG/n7A7Evs61S+aI4YZjVWm/1MhvV/OwyEjFT4btJdVNnjxzZCpE+f9CXzWdK5VD
         QQgeoQ6z7CZnP+1cnt1/hYQYwm/9z+kQJ+k7DK42r8eERR2KyEBLpmwW54//UxJEvYQG
         mj8sDVUBGkCVweWIoBnb+ikx1YiSCQT+Eo5OEAOno4eW560hB1oGlXZxM092cQME5B3T
         US34hD62nNiqt9rdSj6uDU9BNrx/MFyHIBGdVPYFZXYWjVJHimKaIV+CBt972yE0xeHp
         cITg==
X-Forwarded-Encrypted: i=1; AJvYcCV5Bjn59af9nsZVX0Uer0VyRir7SLgJrQHc/t915kJzDpdtQBsRZLZXV5qGMPGsedyfR4P/3e6ltkA7eaEJy3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuNur3N1IXx9KMwPfsxjuOSWixPgmfI12lMxvOO/q7+G3ATVSy
	i7ABP8sg0/97QVPCZTYs3k7nOj1By0hnT+wLr3WkLEaU+17/pvI/tJqRk4PGE3k=
X-Gm-Gg: ASbGncsLpVeewxEu2McI09aS74TkHLaCkFPqFBlwY4YXzoCur6C6BX9yPgDP2/bLei7
	kT7m27bh3HSkQZYryXAiVGG95LTxoW/SIEQ/EDH/DXx0L50i1KC1pisd3+WB8JgIWTls/nZmlU/
	gZzgdrXx9zwLRt786hRuuaU+/0Icphz45U5DW9X16FjIhVg05Wylggibz5c8diWZMjvukWHQtLk
	dVsSb2tz8sfxHiOzpoe3Fo/9O5DwbuaG0oHOx62p6Q9PKHio+fnw7Lgc/BoYE22I8BJlCXou1UK
	dC6IjYSvHcm/djeg/9EPiLTW1jNNL2boHBzsPGJn/OElFe6cDE03Ouf92N8jyWG5Ntmjpo0jUQf
	CWQBy5ZVODhZgBZJF2HzBOQ/5168OPcqv
X-Google-Smtp-Source: AGHT+IEl6kJWDflT3Rn8WDp+ZhQkPU3xUJHHdwZaiwpfDRF2sCE9f35xMBvQNtn+dAgTXcRv+AElKw==
X-Received: by 2002:a17:902:e74f:b0:223:26da:4b6f with SMTP id d9443c01a7336-225e0a369b5mr135088635ad.14.1742218583022;
        Mon, 17 Mar 2025 06:36:23 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a403fsm74737375ad.61.2025.03.17.06.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 06:36:22 -0700 (PDT)
Date: Mon, 17 Mar 2025 06:36:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
 jhs@mojatatu.com, kuba@kernel.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com, Olga Albisser <olga@albisser.org>, Oliver Tilmans
 <olivier.tilmans@nokia.com>, Bob Briscoe <research@bobbriscoe.net>, Henrik
 Steen <henrist@henrist.net>
Subject: Re: [PATCH v4 iproute2-next 1/1] tc: add dualpi2 scheduler module
Message-ID: <20250317063620.30d24269@hermes.local>
In-Reply-To: <20250316153917.21005-2-chia-yu.chang@nokia-bell-labs.com>
References: <20250316153917.21005-1-chia-yu.chang@nokia-bell-labs.com>
	<20250316153917.21005-2-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Mar 2025 16:39:17 +0100
chia-yu.chang@nokia-bell-labs.com wrote:

> +static int dualpi2_print_xstats(struct qdisc_util *qu, FILE *f,
> +			    struct rtattr *xstats)
> +{
> +	struct tc_dualpi2_xstats *st;
> +
> +	if (xstats == NULL)
> +		return 0;
> +
> +	if (RTA_PAYLOAD(xstats) < sizeof(*st))
> +		return -1;
> +
> +	st = RTA_DATA(xstats);
> +	fprintf(f, "prob %f delay_c %uus delay_l %uus\n",
> +		(double)st->prob / (double)MAX_PROB, st->delay_c, st->delay_l);
> +	fprintf(f, "pkts_in_c %u pkts_in_l %u maxq %u\n",
> +		st->packets_in_c, st->packets_in_l, st->maxq);
> +	fprintf(f, "ecn_mark %u step_marks %u\n", st->ecn_mark, st->step_marks);
> +	fprintf(f, "credit %d (%c)\n", st->credit, st->credit > 0 ? 'C' : 'L');
> +	fprintf(f, "memory used %u (max %u) of memory limit %u\n",
> +		st->memory_used, st->max_memory_used, st->memory_limit);
> +	return 0;
> +

You should support JSON for the stats as well.

