Return-Path: <linux-kselftest+bounces-2131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B20D816930
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 10:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64EB1F23053
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 09:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBC210A3A;
	Mon, 18 Dec 2023 09:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkeetnyI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5111118F;
	Mon, 18 Dec 2023 09:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3b9ef61b6b8so2492837b6e.3;
        Mon, 18 Dec 2023 01:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702890327; x=1703495127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hUaORyXJtV85V7Mu0MoyFI+3+zmAJo7uX2NhdndJAnY=;
        b=EkeetnyIKRGTVHRM+74v/KR7dw/smHKhWWVktXEjQb9Edqngk1yCYSx7haU42k7wWl
         IiFJrPVqfx5GmvXdxIpvYu00k0jpLtnPpXuWOfQClAoHHiuJiIC445k/3MCJVSf83gfz
         utk1zkdaCKKUkMNofllR7ikUc437tsZvlP+gfiLGaRyvO9j/yEZmprEFFvxDU2LJgrGn
         uabXi+Yb8T+Ox72y0x3J/Mgtu4sJMW4R+mVGlciJbvS6XKt+tFzB6acJKaDl7u81eEsH
         hXSzpaabbIuwUbHFv+KkQwpDzAa2eZymWcF7B40C8+BsOXpftEnaHupzF7aLrCRBSEmQ
         McSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702890327; x=1703495127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUaORyXJtV85V7Mu0MoyFI+3+zmAJo7uX2NhdndJAnY=;
        b=erC+yZ5yDo6B2zJ2jr2Qh4PcyO7Ut7vGZ5c5gLgwB8rR/QDwQTHlW/FMoympobwYs8
         /G0a7mozsKyRJUgxAZh2Yy1fKVJG/V0DyVOK8f6uL7c+GNq3PQzcGd3QTEEu1pdn+mlb
         U6Rax0c4rv4N4GSxjd8H2LBKhp4lmXnlrHBpiPxHYnq4ggNO4t/RtWByRBBZKnKpMghp
         tlTjOiuTSL0wJl75Mw1r+ot1zaDmcwkCeQ0sHDAxSGC9uvtcI4bU02YNHalhQBkf1iqd
         +ba4rTqtIUvugldtvckYOoiTPwTGm27I5G+5VtpFhdO44Z7ZV8GK4wqkeA5zhZeNOmsk
         Vifg==
X-Gm-Message-State: AOJu0YyA+b2/pzFua63Zm+OxcuOWd0HM/oNWBi57ao1g3XTf0iI/5jFd
	yCSzGwyJawDJ2Tyd4LmYJ8k=
X-Google-Smtp-Source: AGHT+IHC9opzn76r24DJTdfbmaQp6hr3JCR76QBVfyMRS+pzV07C7AGUB8B74ei3FyKlzOOuhJJMhg==
X-Received: by 2002:a05:6358:78a:b0:170:ddbe:d051 with SMTP id n10-20020a056358078a00b00170ddbed051mr14810443rwj.59.1702890327177;
        Mon, 18 Dec 2023 01:05:27 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p31-20020a635b1f000000b005c21943d571sm737830pgb.55.2023.12.18.01.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 01:05:26 -0800 (PST)
Date: Mon, 18 Dec 2023 17:05:21 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Dmitry Safonov <dima@arista.com>
Cc: Shuah Khan <shuah@kernel.org>, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Salam Noureddine <noureddine@arista.com>,
	Bob Gilligan <gilligan@arista.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [PATCH 04/12] selftests/net: Add a test for TCP-AO keys matching
Message-ID: <ZYALUXDln552uUeW@Laptop-X1>
References: <20231215-tcp-ao-selftests-v1-0-f6c08180b985@arista.com>
 <20231215-tcp-ao-selftests-v1-4-f6c08180b985@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215-tcp-ao-selftests-v1-4-f6c08180b985@arista.com>

On Fri, Dec 15, 2023 at 02:36:18AM +0000, Dmitry Safonov wrote:
> Add TCP-AO tests on connect()/accept() pair.
> SNMP counters exposed by kernel are very useful here to verify the
> expected behavior of TCP-AO.
> 
> Expected output for ipv4 version:
> > # ./connect-deny_ipv4
> > 1..19
> > # 1702[lib/setup.c:254] rand seed 1680553689
> > TAP version 13
> > ok 1 Non-AO server + AO client
> > ok 2 Non-AO server + AO client: counter TCPAOKeyNotFound increased 0 => 1
> > ok 3 AO server + Non-AO client
> > ok 4 AO server + Non-AO client: counter TCPAORequired increased 0 => 1
> > ok 5 Wrong password
> > ok 6 Wrong password: counter TCPAOBad increased 0 => 1
> > ok 7 Wrong rcv id
> > ok 8 Wrong rcv id: counter TCPAOKeyNotFound increased 1 => 2
> > ok 9 Wrong snd id
> > ok 10 Wrong snd id: counter TCPAOGood increased 0 => 1
> > ok 11 Server: Wrong addr: counter TCPAOKeyNotFound increased 2 => 3
> > ok 12 Server: Wrong addr
> > ok 13 Client: Wrong addr: connect() was prevented
> > ok 14 rcv id != snd id: connected
> > ok 15 rcv id != snd id: counter TCPAOGood increased 1 => 3
> > ok 16 Server: prefix match: connected
> > ok 17 Server: prefix match: counter TCPAOGood increased 4 => 6
> > ok 18 Client: prefix match: connected
> > ok 19 Client: prefix match: counter TCPAOGood increased 7 => 9
> > # Totals: pass:19 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Expected output for ipv6 version:
> > # ./connect-deny_ipv6
> > 1..19
> > # 1725[lib/setup.c:254] rand seed 1680553711
> > TAP version 13
> > ok 1 Non-AO server + AO client
> > ok 2 Non-AO server + AO client: counter TCPAOKeyNotFound increased 0 => 1
> > ok 3 AO server + Non-AO client: counter TCPAORequired increased 0 => 1
> > ok 4 AO server + Non-AO client
> > ok 5 Wrong password: counter TCPAOBad increased 0 => 1
> > ok 6 Wrong password
> > ok 7 Wrong rcv id: counter TCPAOKeyNotFound increased 1 => 2
> > ok 8 Wrong rcv id
> > ok 9 Wrong snd id: counter TCPAOGood increased 0 => 1
> > ok 10 Wrong snd id
> > ok 11 Server: Wrong addr
> > ok 12 Server: Wrong addr: counter TCPAOKeyNotFound increased 2 => 3
> > ok 13 Client: Wrong addr: connect() was prevented
> > ok 14 rcv id != snd id: connected
> > ok 15 rcv id != snd id: counter TCPAOGood increased 1 => 3
> > ok 16 Server: prefix match: connected
> > ok 17 Server: prefix match: counter TCPAOGood increased 5 => 7
> > ok 18 Client: prefix match: connected
> > ok 19 Client: prefix match: counter TCPAOGood increased 8 => 10
> > # Totals: pass:19 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Tested-by: Hangbin Liu <liuhangbin@gmail.com>

