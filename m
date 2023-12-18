Return-Path: <linux-kselftest+bounces-2138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FF3816986
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 10:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84061F23242
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 09:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E26C111AA;
	Mon, 18 Dec 2023 09:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTM4oZND"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17D515483;
	Mon, 18 Dec 2023 09:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d32c5ce32eso28100805ad.0;
        Mon, 18 Dec 2023 01:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702890736; x=1703495536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l8wf06F/XJLNPFw5y4gVtxQ1Sn+Ur9N/zSmsQOxOZr0=;
        b=GTM4oZNDvpdrT5b5SY3MT86K0UVKmfUaftKFxYSOJKdlRKAlgLLUtY7+9B3yFmUhQZ
         PYQZBf0RP02WY1v9rt0MmiExryp3zX8MnGLo7r+Z6RzFGcQEEmZnIufbQnTEcDCXzmPU
         vsvUrxPW5mdHLRnASXU4+dw07tXQqkPxj0vy5CZ860wrNpbxzSgAhD7oe1xpRtejwtmi
         GStWeyy6YKyQFUi0t8DtG1uiEJiZu0rogG8TRxCXA2AF2d36avd5dQA0dd6gw7qpoF9c
         CppIG7q/Dc5/Wx8sCkOqOVIF8+F7+/JzBD1MFAGIWDlIL+KqRa2aDOZiyl+nmn1Rxcfn
         O2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702890736; x=1703495536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8wf06F/XJLNPFw5y4gVtxQ1Sn+Ur9N/zSmsQOxOZr0=;
        b=JJtZhDO5ENtg5ywh8kH/NEeHUZYJP3xOb4ltO6N0XPUHk7ptVH8INdQ493jwaj4aml
         hadgmW2Sc8OeunAL3KaLZRo5tJ6hjPtJjTIbs//mziLXPy7TVVJ2x28cUVkqrKteHGMo
         mx9QKQZKLxx9AEQzYJ9w1VWKEDkM9KkHhq6Ltjm1GOEpOP/wYL2PcaDdsDZmZMfc+xzh
         ZLIzKxnoMldaWHIySka+oxq+Wbivq+8J+SeFeDxYEXVOIZT398KKSQ4hosDiqtavc0TM
         5tu9VJRDEAKYG9Avp2DpUb9af1Lr4owethJm+FTC7vsqwjM8zTMsCgPfkrF7m2ww8Zz5
         xNQw==
X-Gm-Message-State: AOJu0YyuvFu4ZOtE4EawPbSHUS4B3IdfamBR0C1G881oFtntbk01SmAI
	SCvb6988EMm7zYkAucOtoj9nzl0vrWGo6R2m
X-Google-Smtp-Source: AGHT+IGFD8Jz5ulAxVNCVNJzA/QZEO8b7C2RAtooPiF2BKrw73oalg3e2fULzLq5x9rOhBOAvgBOAw==
X-Received: by 2002:a17:902:e54b:b0:1d0:bf4c:166c with SMTP id n11-20020a170902e54b00b001d0bf4c166cmr20889261plf.1.1702890736006;
        Mon, 18 Dec 2023 01:12:16 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t18-20020a170902e85200b001d0675e59f9sm18525659plg.200.2023.12.18.01.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 01:12:15 -0800 (PST)
Date: Mon, 18 Dec 2023 17:12:10 +0800
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
Subject: Re: [PATCH 11/12] selftests/net: Add TCP-AO selfconnect/simultaneous
 connect test
Message-ID: <ZYAM6ioeJEq5FnJf@Laptop-X1>
References: <20231215-tcp-ao-selftests-v1-0-f6c08180b985@arista.com>
 <20231215-tcp-ao-selftests-v1-11-f6c08180b985@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215-tcp-ao-selftests-v1-11-f6c08180b985@arista.com>

On Fri, Dec 15, 2023 at 02:36:25AM +0000, Dmitry Safonov wrote:
> Check that a rare functionality of TCP named self-connect works with
> TCP-AO. This "under the cover" also checks TCP simultaneous connect
> (TCP_SYN_RECV socket state), which would be harder to check other ways.
> 
> In order to verify that it's indeed TCP simultaneous connect, check
> the counters TCPChallengeACK and TCPSYNChallenge.
> 
> Sample of the output:
> > # ./self-connect_ipv6
> > 1..4
> > # 1738[lib/setup.c:254] rand seed 1696451931
> > TAP version 13
> > ok 1 self-connect(same keyids): connect TCPAOGood 0 => 24
> > ok 2 self-connect(different keyids): connect TCPAOGood 26 => 50
> > ok 3 self-connect(restore): connect TCPAOGood 52 => 97
> > ok 4 self-connect(restore, different keyids): connect TCPAOGood 99 => 144
> > # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Tested-by: Hangbin Liu <liuhangbin@gmail.com>

