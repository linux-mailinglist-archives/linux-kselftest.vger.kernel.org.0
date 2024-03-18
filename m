Return-Path: <linux-kselftest+bounces-6379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B73C87E22F
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 03:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C91BCB20BC5
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 02:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58A117740;
	Mon, 18 Mar 2024 02:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8UVOrop"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472578814;
	Mon, 18 Mar 2024 02:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710729525; cv=none; b=fWGQ9RnbTORIdkCBcg5JmI806qix9CFW1boabD/w0saR2Be2lpYz1tzXxckDleRzBRacoXDke1TDUoMi5DAFY4bMqxhzO1MM98rZwk4/4uiGeMzAeAji53kQNZMMMlsKojIN4jOIf8yh1JZjFxaZTGgCbrJQHeXH2MCvy9ZCb+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710729525; c=relaxed/simple;
	bh=WF/f6CCamw+J9eLrDPFmQG50mTmLC8pIzPQMHw5BqEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtc54wl5aESXoc8bUTAuyAZmSAe+Iev4FSGWptUHZDyUnZCw2azhMNKyTl8+wqCHGSoP7E92/OZN22LiIEWLhuTVgA0oiB/oXbSVAGb+j5IKHvPpqIY6chUjWf8cOasJpFQxoV8rq7WR9V6/QrO8yDQC7FCCKSaHV+TnOATKl7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8UVOrop; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e6f6d782e4so2053269b3a.0;
        Sun, 17 Mar 2024 19:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710729523; x=1711334323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mbDMqvrws+XkBBTMQ0YCUnc4hLWNGOlIuRUrBtvBFuc=;
        b=a8UVOrop3lsoMlENR8XXmCLD7AWo1kgK9fSRPcQFvBVF4uZXxIzcPUDaGYJ8LLABoI
         q56O1fEabnLNrJP2pCGfRlaxz+eqPxAG98td8NLupx1zKd3Othcpq4EGkLoBYh5yelCx
         dIeXuXTisEDeKpCv0dHrZUXrYQ9HymUeRStCPVnVW1XWMhCbocRNyXwC6KmRIPj+dXJ1
         VnEBxa/RK/YpkPyS8cKposat3X30xgfMqZnBsKxxkYTyq9zHm6WsIAeoXDQfGTa7YqI4
         ECLhUKllb2t/lIcXzKejuHg6zLyWSKUFU4NzlxRmLUjgh/1b70Sbk1kvqXkfmrSg0jVU
         E+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710729523; x=1711334323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbDMqvrws+XkBBTMQ0YCUnc4hLWNGOlIuRUrBtvBFuc=;
        b=L5M0O08a2TXj07vl6OUqD3IyLs4QQQpK6cVYaIrewWYCkbwriVlXcDspdjsJCIjf1A
         +jM+TYgApAGYApFK6a70tnuT4yHfLf2beGHLL/PtfErg3iTRA4GDl5d09N7Q0eeUKFZN
         rp5SXu8I0vCM7C2B4laaAyr3afyHbx36gJxuwHKDAdl9cJ+78aCkG6lTQTPTz+45dBvP
         AypRAGhINbMWQN1afxd5jLv0k7dHCjDQOWkyQu/bwXot2wKydhuBtWIuIRinoRP1yWaQ
         7gW3TtgWsH2KXiWBaMZ4k5o6TwcQpYGiYYRDB89ucNKAZMmkiZbb0XeanDQ2YXmoZo6u
         P8rQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtxF67SWOzenvaYCk1IB2P5cn0wjbDJu1aBsHilt57qS/tZCfIxj48qsMMSLy72y59ae8EkLpl4b9lhviwb+EBBoufa9xPwa+VbGe1ksmNYk5jNM25v8dj1gxNDu82nYIc7rk/N2ROrJQLY86K
X-Gm-Message-State: AOJu0Yz9K5bY4YGOTswHlkrU7LL3VtX8L46R+8W+gPhilaeKCHKHixI8
	Dm18FGPz1evpv6ZE+620m6WftCcDhlwPRnjhz7utf88tRWbvQPIf
X-Google-Smtp-Source: AGHT+IFzCWxwJh1/DXovSmofPMWc4wI2/C4hwbYM8ThEdMdgGut76PvnNp6mpHmXZp+E2x7cgtYmjA==
X-Received: by 2002:a05:6a00:194c:b0:6e6:8df5:e903 with SMTP id s12-20020a056a00194c00b006e68df5e903mr10765193pfk.13.1710729521995;
        Sun, 17 Mar 2024 19:38:41 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t7-20020a625f07000000b006e6f0b4d950sm6046842pfb.4.2024.03.17.19.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 19:38:40 -0700 (PDT)
Date: Mon, 18 Mar 2024 10:38:35 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Ahern <dsahern@gmail.com>,
	Po-Hsu Lin <po-hsu.lin@canonical.com>
Subject: Re: [BUG] selftests/net: icmp_redirect.sh: 12 out of 40 test result
 with [FAIL]
Message-ID: <ZfepK3xItcv3ARVV@Laptop-X1>
References: <dfb4b2fa-1728-43f2-ad73-f06145399fc9@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfb4b2fa-1728-43f2-ad73-f06145399fc9@alu.unizg.hr>

Hi Mirsad,

On Sat, Mar 16, 2024 at 11:59:54PM +0100, Mirsad Todorovac wrote:
> Hi,
> 
> With the commit v6.8-11167-g4438a810f396 in vanilla torvalds tree, there seem to be problems with
> the icmp_redirect.sh tests.
> 
> The iproute2-next tools were used, commit 7a6d30c95da9.
> 
> # timeout set to 3600
> # selftests: net: icmp_redirect.sh
> #
> # ###########################################################################
> # Legacy routing
> # ###########################################################################
> #
> # TEST: IPv4: redirect exception                                      [FAIL]
> # TEST: IPv6: redirect exception                                      [ OK ]
> # TEST: IPv4: redirect exception plus mtu                             [FAIL]
> # TEST: IPv6: redirect exception plus mtu                             [ OK ]
> # TEST: IPv4: routing reset                                           [ OK ]
> # TEST: IPv6: routing reset                                           [ OK ]
> # TEST: IPv4: mtu exception                                           [ OK ]
> # TEST: IPv6: mtu exception                                           [ OK ]
> # TEST: IPv4: mtu exception plus redirect                             [FAIL]
> # TEST: IPv6: mtu exception plus redirect                             [ OK ]
> #
...
> #
> # TEST: IPv4: redirect exception                                      [FAIL]
> # TEST: IPv6: redirect exception                                      [ OK ]
> # TEST: IPv4: redirect exception plus mtu                             [FAIL]
> # TEST: IPv6: redirect exception plus mtu                             [ OK ]
> # TEST: IPv4: routing reset                                           [ OK ]
> # TEST: IPv6: routing reset                                           [ OK ]
> # TEST: IPv4: mtu exception                                           [ OK ]
> # TEST: IPv6: mtu exception                                           [ OK ]
> # TEST: IPv4: mtu exception plus redirect                             [FAIL]
> # TEST: IPv6: mtu exception plus redirect                             [ OK ]
> #
> # Tests passed:  28
> # Tests failed:  12
> # Tests xfailed:   0
> not ok 45 selftests: net: icmp_redirect.sh # exit=1
> 
> These errors are not introduced with this commit, but were already present at least in 6.8-rc7.

I tried kernel 6.8 with net tree. All passed.

# ./icmp_redirect.sh

###########################################################################
Legacy routing
###########################################################################

TEST: IPv4: redirect exception                                      [ OK ]
TEST: IPv6: redirect exception                                      [ OK ]
TEST: IPv4: redirect exception plus mtu                             [ OK ]
TEST: IPv6: redirect exception plus mtu                             [ OK ]
TEST: IPv4: routing reset                                           [ OK ]
TEST: IPv6: routing reset                                           [ OK ]
TEST: IPv4: mtu exception                                           [ OK ]
TEST: IPv6: mtu exception                                           [ OK ]
TEST: IPv4: mtu exception plus redirect                             [ OK ]
TEST: IPv6: mtu exception plus redirect                             [ OK ]
...
TEST: IPv4: redirect exception                                      [ OK ]
TEST: IPv6: redirect exception                                      [ OK ]
TEST: IPv4: redirect exception plus mtu                             [ OK ]
TEST: IPv6: redirect exception plus mtu                             [ OK ]
TEST: IPv4: routing reset                                           [ OK ]
TEST: IPv6: routing reset                                           [ OK ]
TEST: IPv4: mtu exception                                           [ OK ]
TEST: IPv6: mtu exception                                           [ OK ]
TEST: IPv4: mtu exception plus redirect                             [ OK ]
TEST: IPv6: mtu exception plus redirect                             [ OK ]

Tests passed:  40
Tests failed:   0
Tests xfailed:   0

# uname -r
6.8.0-virtme

You can try enable verbose output and see where the failure occurred.

Wild guess, the last change of icmp_redirect is my netns update. Maybe there
are something default sysctl settings in netns cause the error?

Thanks
Hangbin

