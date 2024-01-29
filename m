Return-Path: <linux-kselftest+bounces-3685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B76840105
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 10:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EABAD1C22440
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 09:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B258FC0C;
	Mon, 29 Jan 2024 09:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EFf6mSDo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94D855761
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Jan 2024 09:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706519523; cv=none; b=EiaprtdHka6+iDiwMeXLrGbq/6XDLXcxalzUbHSwBOzNDXYx+S97UjhE7Mh3ScEWe5hF/ds/JeuLoIN4XVjg2CLAQjcG478eWNnl82pnbDOm/EskbktSTPptBDlyHa5EbHQBut99Q7uZ+kLAdLeFu9t7HphDr9xflq/f1JQs81c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706519523; c=relaxed/simple;
	bh=LqBkBGTAm6oybIMF3P1Kb1YffmGgr5KxITxp2gE5Ssw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nDZ4ceaYpN2AI1JA+QOkqFbkHp4aa3RzgLshdXJlJyyZ0segLeau1T++0KWiJiKcMV/jtxl/jcAjGiQtYUPiPtre+9c7/C8zT1yWU+tGkXYz52KD871v90WBR8/b/9ReyIwPwj1xMl5vF6kanz4dYjtvTWoxg3nipT91v86d7mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EFf6mSDo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706519520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=61gVbeeuFx/zhWGnZ5Oevqxqi7AWMc0Ap5lSoiBqd5U=;
	b=EFf6mSDoV6xsC4WusByBdtD+gyvfDJhvNTjBPd9xtvYmL6UBkQmFQfn+5M6lKPB2Ytk8y6
	6D0ZCoI/lQe//YsLWSb53k+NEVwGcLbExAZBENB/eoZMgNUSHfg2BLSrj6bsTrrwkm9hMZ
	1ySWCfhfAU9V/LOM393lFbywAdLOHGA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-vPKrMtUdPziT5vRHqefOhA-1; Mon, 29 Jan 2024 04:11:58 -0500
X-MC-Unique: vPKrMtUdPziT5vRHqefOhA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-510146aa159so390732e87.0
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Jan 2024 01:11:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706519517; x=1707124317;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=61gVbeeuFx/zhWGnZ5Oevqxqi7AWMc0Ap5lSoiBqd5U=;
        b=HGFHKD9fivrOqe1maYlqg45QSXvuKyY96tK0PJwIUMtS2tmse1hlj40fJOLENz3Akw
         ivm3nkHrUQItOhqpTV0PpDwEaRzN70yELQEAqEBUQtg+Go6xljK4An6TYPKa7NKTy2Eg
         yjJVLoL2hYK8em3FXaegxpDdaTAqYbkhXSk/dKuNS5SjVdFBiripCYQoWu6tjaF+t/wc
         aBxwOi7jTgAKt9m3J2tw4Q3rpM3Lhol5L8PBDOgFHV/O7v7FJrIKbPfK8JjUMVwjbxoJ
         wRLlFWimZgIsbSr+AkA/fTXMdIG4YvLuULjDzdP5GbYbq2RpsgVd6EZdTZXnMXv8qQ+p
         kFsg==
X-Gm-Message-State: AOJu0Yzq9eRWnC49yOuHTTA2ZyHtgXexWcO7vNT4bwuJHYSf0ymnglL/
	EUf0Q/VXymylYzqjlK5pAEdwHmTyMgD3gyckgH9i99pTJGmgZrzcn3IcD1nURM7Eb6HrtaluVNM
	zbZiOg99Hq6pk0vscO9wiXCLX4oHEW82N78zeY35UXzMjtQkpyUhpnOVKA1Paakg3NQ==
X-Received: by 2002:ac2:5f86:0:b0:510:1758:f3f6 with SMTP id r6-20020ac25f86000000b005101758f3f6mr3747427lfe.0.1706519517188;
        Mon, 29 Jan 2024 01:11:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/EhJvQcElL09+My1qrH6FIUytKNMug1gSGXt7Ly+HVcXD3NGwNuoZVZnEM40zqLz0C2v+rg==
X-Received: by 2002:ac2:5f86:0:b0:510:1758:f3f6 with SMTP id r6-20020ac25f86000000b005101758f3f6mr3747415lfe.0.1706519516816;
        Mon, 29 Jan 2024 01:11:56 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-230-151.dyn.eolo.it. [146.241.230.151])
        by smtp.gmail.com with ESMTPSA id bd19-20020a05600c1f1300b0040ed1d6ce7csm9576688wmb.46.2024.01.29.01.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 01:11:56 -0800 (PST)
Message-ID: <a090936028c28b480cf3f8a66a9c3d924b7fd6ec.camel@redhat.com>
Subject: Re: [PATCH net] selftests: net: add missing config for big tcp tests
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>, Xin Long
 <lucien.xin@gmail.com>,  Florian Westphal <fw@strlen.de>, Aaron Conole
 <aconole@redhat.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 linux-kselftest@vger.kernel.org
Date: Mon, 29 Jan 2024 10:11:55 +0100
In-Reply-To: <20240126115551.176e3888@kernel.org>
References: 
	<21630ecea872fea13f071342ac64ef52a991a9b5.1706282943.git.pabeni@redhat.com>
	 <20240126115551.176e3888@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-01-26 at 11:55 -0800, Jakub Kicinski wrote:
> On Fri, 26 Jan 2024 16:32:36 +0100 Paolo Abeni wrote:
> > The big_tcp test-case requires a few kernel knobs currently
> > not specified in the net selftests config, causing the
> > following failure:
> >=20
> >   # selftests: net: big_tcp.sh
> >   # Error: Failed to load TC action module.
> >   # We have an error talking to the kernel
> > ...
> >   # Testing for BIG TCP:
> >   # CLI GSO | GW GRO | GW GSO | SER GRO
> >   # ./big_tcp.sh: line 107: test: !=3D: unary operator expected
> > ...
> >   # on        on       on       on      : [FAIL_on_link1]
> >=20
> > Add the missing configs
> >=20
> > Fixes: 6bb382bcf742 ("selftests: add a selftest for big tcp")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>=20
> Ah, great, I was missing RF_RAW in the local hack.
> I applied manually because looks like this change is on top of
> something:
>=20
> patching file tools/testing/selftests/net/config
> Hunk #3 succeeded at 73 with fuzz 1 (offset -1 lines).
> Hunk #4 succeeded at 82 (offset -1 lines).

Ooops... yes, indeed it's on top of the few patches I sent in the past
days.

> While at it I reordered the values a little bit to be closer to what=20
> I think would get us closer to alphasort. Hope you don't mind.

Sure thing I don't mind! I'm sorry for the extra work on you.

Cheers,

Paolo


