Return-Path: <linux-kselftest+bounces-38636-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE0DB1F7FD
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Aug 2025 04:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4093B3DEF
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Aug 2025 02:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3886DDC3;
	Sun, 10 Aug 2025 02:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="nv38w8TK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF798F40
	for <linux-kselftest@vger.kernel.org>; Sun, 10 Aug 2025 02:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754791312; cv=none; b=uoh4cYunGJQYnbbKj1QV4R28sUl+D4NDYE042TdpwG822HaqY+kldKzPk3Ukul57FNuFXJyD3XrSnqwlcI3JGJUZMRw7nXunF6liAMHKB0pLEFNO0+80UKtaU8ERfLtVoQZ3UbIzOGx3A99Ct8+mnVnwcBoBMjjQyUtz8E56aFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754791312; c=relaxed/simple;
	bh=dCvUpFgvClz8ydlEGwgka54i9za6FpnY59NV6CpRBgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fm4mZcloO1BQUhXKRrnBTo7odKNyUlEpzhzq0jzKAbl87/unNw6imOP4xwsJ1AynIMZFJ8kedGpPoJ6rA9ulqQlhrS2kTJy2rdTyX+9CbAyhAY3rFbIqeFZkwXKW84DGKvycLOHNGnjDqNgBKqE0or86dca5CBvtXowmoAlAbf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=nv38w8TK; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b3aa2a0022cso3799498a12.1
        for <linux-kselftest@vger.kernel.org>; Sat, 09 Aug 2025 19:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1754791311; x=1755396111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txwp06lVbueO9WkAKBe2DeTZ/z5GvsnD3cfuHHrHWmg=;
        b=nv38w8TKw0Wr1d2+/1Wmtj6O/NET30TciBuT+DhJboCushtDOBob9UuhUYinPorTxn
         j9sForYxHRgEXX80lRWLQ31XpXd2pr6mOOWDfIciZbjEY4aN/LEjNQ2OQ7efzFWrTwy9
         EXqL0UdKU18ccLrI9BVpU7452Z+PGXXs5xH/e36wyPskn11nn9pBNtIcRP68qde/f4oc
         7xIjpKtnB2cYhTSXzAiXhuLElgJxTN6S/6DtBZas2wDjMI4o4sCqIe2HxhwJ8efAfy2Y
         2EyltTMg9ztc1YW99hhTWyYUKvrySPvGpiby4vv9oYFliShPNzC0oJfwTwDolzVUl3L4
         tmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754791311; x=1755396111;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=txwp06lVbueO9WkAKBe2DeTZ/z5GvsnD3cfuHHrHWmg=;
        b=JjihhIxzCp4Uz0RgNYSALaarHZzaFbmqgt9TNGk+yrqxnVYpS3M6vorWgUT4Sebyy7
         wKy/J6EUCUqgksOKlqfoZIr1kS4PDFx7dWCjdwgswdbkEJuOSbba3W68BzGbdCrxXmj4
         oUg5MruNvB1OCGgATHChYzBo+aOKzCaCpqKlBKRZsXSYy2URlyKSBHUjcNQb50u2Sfh9
         FTTETwjZQHkRDCCyMPJsyg4TMn2MleexZOW20NUtxXNc21hER6lYk0GrUTYEmgBTYQNo
         6s9S00gzXcbl4I1q4Y5NE2s2vks7huuI8ixtdIjFfdxmOwUXAfs4MjCYBaBdw4OJKVTe
         OXTg==
X-Forwarded-Encrypted: i=1; AJvYcCWQxkb7UcFgR2N/AaiEIcwjV9Mqv2aa0cPWsptBLrVvFZWEWXhqaS5uuhPorksECBOnWn5CJ1o6yP8oqB5S9mY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcP8kO8Lt8tH2INN7eVGlfbqj4nGykpZF+mS/Lvqnv1KxMlloJ
	BON+81aGVbPjBgue4DLGQCeyIa4t3PgZAOnfYRCc6a2KxcoCULkxNoIiJvyYmVG4eyI=
X-Gm-Gg: ASbGncvyYdQLPZGZJYg6G4MSKUfpjIaZdxKm7tUTma60n1fsuusBYQNeUlSgCDd6sDn
	+A451vqGdX+q3BD+oI3y1tXF9EMPx/6f+njXCUIRQL6pc4lG6KM/8fKbWtjnHu8sujU05Kz7qS/
	i396fykRxXaEgb0ahGw6Eh6iscJVkgpvWalkyasTmqVo7SbebwL0Wpek5sfw2w5C4ZWXWD2PBTB
	AIq0FimvhZiDaAPcoJv3TJ9ItrovS6oQNOTYm62zzC8Sc1u4I81B5OXigNA3ljwgveFGLw/BhRW
	yRJRmW1M3bPlvtQpSbLrfBSxi7xN9G4FEo/EXbwazBW5U18kMvy0rw6tzue6DtoBmpsQo7OmlRm
	LfluzKE8+/8xMbjUuAUSmrfcWNdpqbGSFRgD55YLQE91JC3T/2VEg/c5oc4iColyN3g/pAgll
X-Google-Smtp-Source: AGHT+IHKQduhhyoSVs024Fbep9JQOWb5NZIDF5VXjs1Qfdqnm3/VRDLWrim+xDf5c7Rf1KdIVjmSLA==
X-Received: by 2002:a17:903:4b4b:b0:240:3915:99d6 with SMTP id d9443c01a7336-242c229ed16mr114172045ad.33.1754791310923;
        Sat, 09 Aug 2025 19:01:50 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976a48sm238757275ad.104.2025.08.09.19.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 19:01:50 -0700 (PDT)
Date: Sat, 9 Aug 2025 19:01:48 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	sdf@fomichev.me, shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] selftests: drv-net: don't assume device has
 only 2 queues
Message-ID: <aJf9jMgcA42sAcCu@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	sdf@fomichev.me, shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20250809001205.1147153-1-kuba@kernel.org>
 <20250809001205.1147153-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809001205.1147153-2-kuba@kernel.org>

On Fri, Aug 08, 2025 at 05:12:03PM -0700, Jakub Kicinski wrote:
> The test is implicitly assuming the device only has 2 queues.
> A real device will likely have more. The exact problem is that
> because NAPIs get added to the list from the head, the netlink
> dump reports them in reverse order. So the naive napis[0] will
> actually likely give us the _last_ NAPI, not the first one.
> Re-enable all the NAPIs instead of hard-coding 2 in the test.
> This way the NAPIs we operated on will always reappear,
> doesn't matter where they were in the registration order.
> 
> Fixes: e6d76268813d ("net: Update threaded state in napi config in netif_set_threaded")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/napi_threaded.py | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

