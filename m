Return-Path: <linux-kselftest+bounces-23713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB059F9E33
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 05:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AA0716A4DB
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 04:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3E1154444;
	Sat, 21 Dec 2024 04:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPX/BEX0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594422905;
	Sat, 21 Dec 2024 04:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734753959; cv=none; b=gdwArsmVg6T8PWG4/WFsL0AU9Qw5Lx/63lJIIslJU939jQwoYL2iQzC8ZaJ1QSyw/sSaD516OVv2Foyar6rZRcZjc4suIzU/DV4K3ap6WIrwJ7Qf66LYMCA/Wn/uFZq+7KWYqJVKJV5hQLpll8w4m4CuG5clwVkaCT8ZGYW8GG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734753959; c=relaxed/simple;
	bh=1WaPko44qPzgQph8NDihAxRlF2tass6KzBoO4iXRFJI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=An1FGqIfteF/Lum3/0v1CgCU0QOu7WbKs64bINPKmWd7mRmGduHGprq+HC0OWJiRE3MZL5vFogGQNojW2WZYxd4LxByqeGMzceeMdrAuShqRu8LvnMtAkRCrBdzy/ZppGV9C96hW4wO9b2ujZSDdS4Zz9/Vs533yTPC+d7gSC4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPX/BEX0; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b6f19a6c04so215028685a.0;
        Fri, 20 Dec 2024 20:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734753957; x=1735358757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzN8QfUAkxpC4Y01O5VArX/c81H4WRdPrqVwM/67j4c=;
        b=mPX/BEX0/cHHV6JFv3M1vOZvZh1b4y1L3XX8SkIFRd21Ov8cKTDf0fRZVC6Eqq3s+t
         YHmd/Dr5NWQcxg4riT7oUJvV0Y0PN5Rb+b1qxmT8AsVRS9swxzPe6VbhoiAv3pfmmJgF
         QkuCZ2IMdCAl4nyK4Jo1ie8YrpHI8VYOXf3wUAl/Reus3lleiUMzTLKApisUfU/902jx
         KYnGcm2zA+DV2JHulLR6n65gjytUdTaRJwI1cz4SxQKFmkaA2ki7FpNsaW6VJStJ5yYG
         s5mEDv1U1tci8JDNP6x5gujKz/3tKAo/1HqTm33si+PhwvzOPCSNAIqoWeAp+mh6bQYC
         yG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734753957; x=1735358757;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pzN8QfUAkxpC4Y01O5VArX/c81H4WRdPrqVwM/67j4c=;
        b=VZybjeqTVWx4UCyRj1xC/73GnoaeW+KglpvJLw5XJPN2dGH+qYW7W9NHxdIkhxeyZY
         EWgShOWfp/WWWOKXchCbTaSahRPbIJgao4wifAYeGjDSL+rX4FZQKxOxOcJu/OALpOpn
         43Jz5ri9+qdkK4KcVWCeAsXKBxXBjqsJXyX+K9aARQFop+f+ySOXTSSi3xLgueM/NDwA
         +9ACw5g7hahvuxSzUfhH4hUXPNdzti4LBnqhNto892MjhCmUn27cdU57sAUZMq1xCdjc
         Me8hLDnJm+tXg55NvCG/EDfPh/tptETHrqj4vhYehJIdRIItW6WBqsbd07QS+0NEH8h3
         efkw==
X-Forwarded-Encrypted: i=1; AJvYcCV7eLJAjQN7XdGcweEEMwg5HFUPb0wX1ABJ+pVhD46AuIUsqHGHCLZwgX28/rGNomyHsnmjkR/VZfUClPJy1b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxuW42M+b/GSFhHtSHowXElN4Tt5qtWH35L43nkho7GXk0vwfR
	v5g9bZI4hdxvVZKJm5f5qTTcDNkaYtKVz1Q/1oGEkzegJ+2WtDGg
X-Gm-Gg: ASbGncsnEcSNwQrC7+xZBkwtM0GRI5IJLq/muMBUU6vedQYQDPjKbra+w0KtNZWK1Lc
	VTvkv/xY3P6dlXEfUkur718jEIuhP/P9XWzwBkBu6x31jQkbx7LtwdOn5nxdOgq7Oa2OrpeLWH6
	dLyzWbvJiqp+rr6oN2199cnmmQy2tXanfZ2AAy90H7oT2hondRmWKOcf92AL8TyyDRYzossrZZm
	9tD1auPHxAnD8Scmq0FvhIpCJckoe9nWItiukxze3jxUWf8HI7lDCGuR73JQlqPsBMoePe58y1/
	iBUelRYvzdLCGjNKqQhYvSYcUOL2b7hUSQ==
X-Google-Smtp-Source: AGHT+IGA/Io+YQNP2P8lF5/4s/q2WOKbzSQ4EMuL2ypI+Wl9az589GEn2mxVpZjMM0VOd7PVMA8UGQ==
X-Received: by 2002:a05:620a:1915:b0:7b6:73de:f340 with SMTP id af79cd13be357-7b9ba716869mr736590085a.12.1734753957028;
        Fri, 20 Dec 2024 20:05:57 -0800 (PST)
Received: from localhost (96.206.236.35.bc.googleusercontent.com. [35.236.206.96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2df40bsm193508685a.39.2024.12.20.20.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 20:05:56 -0800 (PST)
Date: Fri, 20 Dec 2024 23:05:55 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 Jakub Kicinski <kuba@kernel.org>, 
 shuah@kernel.org, 
 willemb@google.com, 
 petrm@nvidia.com, 
 linux-kselftest@vger.kernel.org
Message-ID: <67663ea38bdc6_2bec4f29445@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241220003116.1458863-1-kuba@kernel.org>
References: <20241220003116.1458863-1-kuba@kernel.org>
Subject: Re: [PATCH net-next] selftests: drv-net: assume stats refresh is 0 if
 no ethtool -c support
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
> Tests using HW stats wait for them to stabilize, using data from
> ethtool -c as the delay. Not all drivers implement ethtool -c
> so handle the errors gracefully.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

