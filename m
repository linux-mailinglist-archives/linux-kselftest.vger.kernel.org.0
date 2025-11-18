Return-Path: <linux-kselftest+bounces-45866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 642D6C69ECA
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 15:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 990AD4FA870
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 14:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7D135B132;
	Tue, 18 Nov 2025 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nne+YwCX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317A22F99BC
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475210; cv=none; b=SKJm4SF+lDy/o4qi2/xJXfgpgfrVtP1tC0JmmMfywdOmx8WVgA7+ia0JzfyBi8/QLLSU46WTpNDPsC82G2wzKCfi29zQXB3r9duxp3bBVJFYiVXkrQ2jR/EZVYrZ6RJn/PXBbICODePRK6of7kmniDzjU7TvsO9ThkE5PRxxfjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475210; c=relaxed/simple;
	bh=HQUBK4MNv/SXU5ezJKyox6AQ7/NM49FiMg7jsCvMZ/w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Xf7pG06NwcdRG21vti6uYd7bbm1dCmlk7rzz+pAIhBEibqpazYXQByORDNAGK0H32PduPYZnwNXHKfnr6IU/wl8+nVuDD4TWIJTXB2NZOVvVySwECSUWao76CQBvlYuzXFEUulf3pN524fT/x6fOQpZTWHE50fjUgfU82ldFmhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nne+YwCX; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d71bcab69so47482057b3.0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 06:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763475208; x=1764080008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLS+ljDA3ONh+IzG9dzAki9ZmyxqZdSzP94WFziG0+w=;
        b=nne+YwCXQJbCRSPxb7g47EXQNrwVa/g6KwH53yc+Ji0W/sw7fvDDfCwrEsSzkesDAa
         ekC9whtGVoYrx8fCDz0emKaz/r7RUr3aJzZcsvgVpPJcDgvVpwPGY2BQMuVMTR4hCsEN
         GNhFEYojo+lAVp4KRinKyMdthR9kK2c4hLgFGsTsZ2d69w9CPbJyBGzr0Wi4U2web9hI
         KjsGw/2XDs4Y4DyrAs7l1cQAgFawkGHqzhRs3F94mc2ms/I+mcsiY/Qek3vENIqIXFTh
         HcedXW5MoXi4XCzzh1VtwS5Jpl5P2c7Ce5Jtez0+9jouX2zqm/pYutElFsFf0aqw8fFc
         mriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763475208; x=1764080008;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pLS+ljDA3ONh+IzG9dzAki9ZmyxqZdSzP94WFziG0+w=;
        b=NXrpyh61nzom7nRmkIyqiplteF6Z7obVFEFLiZ67AceJF5+bXsSJp04w8WFfPBy/lq
         Pl/NYld/hTPCgtwFvThCWPxl2PJkZgRnfAdjC1Y0iqH12iKUUS0Q54rnI3DgIGYfnSB5
         r4Ngj9Ud/ad2asp1DKN0mC+8gfPSzojUEo1vh2Zx6vGUsbl8bDsyTLaGglgP9h93ZUQA
         +lTUbcIxl19OIReoh9Pqc0hD3BnTFVqqeeKX8sDsCqvlkYCcGMtDCviRP6/QEBMSL4Ud
         IUsDWL2SxG8C46Ur4n+vKjLGET9f4KH1Tmwq+Rxx8LClAvJ63AhUTXEd/IapVbvemY2r
         1Jhg==
X-Forwarded-Encrypted: i=1; AJvYcCUh80AKByt6rDr87dHLB/UQ2TeTmsNlXX4HQqEzvHxOodcGvVG6DVSwW6F8JJbMJNE6yonRJVR+Ke57HeuLlCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4/NF36cFYi6q9BlnWcQdqmc5SiQ1N8IFDbJKYF6BZIa2b7lAB
	Gj1/yU7XcJ9SJvSRrOQfBUotuJpBVJmQs6d1I/Rx3OX4ptwT3PpLtqPm
X-Gm-Gg: ASbGncsLup8SuNkTX/Qv925Xwv0Au/NHRItNyUGslFGpDF/DLOZVGqmuRPDN182i7rz
	ymQXIXhzEXZagLJmQz85BpscqTf4GzbifEBxcBQaofxWSIf/gy1E4Unb0Xa647Wpe9jXxPf/SIl
	+KpGWYhOYHCUK+4IRMe1271KEDOAY59Z4ASRDD9WtNjr+JfW5z69cfPUhK8kfh+pubd8uF3NL3/
	zHwmDCqnw+u0t31NWKQC6SlnSRskXwiK5tTXoxeiPRJFxe+4FUuJ86sDvWpDbPCGd53LDx8XUDG
	e+K645Oc/gmmRoRuoaG5uVal4INlbwwC52OZkhdfXHsITs/Cw0Io0WsXbHsrZAOtQHlG/ly8EBD
	fqcVvGCiH0QJ/YpG9LL4PbFR/ct4oeIOoFV7jMvclT0GNKqbMzUgKtfBi+sYJ4+Od8D3+4GY854
	06qynhlNs9pjDFjd+TWRtKcdjY6re3jbQtL3xdSbk/ueusGf9SukyGTcTx4GOFnXgKc8Y=
X-Google-Smtp-Source: AGHT+IHgSy/PQp+8usU/2GA+MvxgTlVGrnZkbhS6n3nlE+QkTkTY7hmkNE9CD+jFUePzw0+lAB/nZw==
X-Received: by 2002:a05:690c:25c8:b0:787:c849:6544 with SMTP id 00721157ae682-78929e2580amr155150137b3.5.1763475208112;
        Tue, 18 Nov 2025 06:13:28 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7882216723csm53160337b3.50.2025.11.18.06.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 06:13:27 -0800 (PST)
Date: Tue, 18 Nov 2025 09:13:26 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 krakauer@google.com, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.24bd73d3718ec@gmail.com>
In-Reply-To: <20251117205609.4b0fa035@kernel.org>
References: <20251117205810.1617533-1-kuba@kernel.org>
 <willemdebruijn.kernel.31c286e47985d@gmail.com>
 <20251117205609.4b0fa035@kernel.org>
Subject: Re: [PATCH net-next 00/12] selftests: drv-net: convert GRO and
 Toeplitz tests to work for drivers in NIPA
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
> On Mon, 17 Nov 2025 21:11:31 -0500 Willem de Bruijn wrote:
> > > Note that neither GRO nor the Toeplitz test fully passes for me on
> > > any HW I have access to. But this is unrelated to the conversion.  
> > 
> > You observed the same failures with the old and new tests? Are they
> > deterministic failures or flakes.
> 
> Deterministic for Toeplitz - all NICs I have calculate the Rx 
> hash the same as the test for at least one of traffic types. 
> But none of them exactly as the test is expecting.
> One IIRC also uses non-standard RSS indir table pattern by default.
> The indirection table will be a trivial fix.

Ugh yes we've had a bug open for ages internally to add indirection
table parsing to the test:

    The (upstream) RSS test is too simplistic: it calculates
   
        queue_id = hash % num_queues
   
    Real RSS uses an indirection table:
   
        queue_id = indir_table[hash % indir_table_len]

> For HW-GRO I investigated less closely I mostly focused on making sure
> netdevsim is solid as a replacement for veth. There was more flakiness
> on HW (admittedly I was running inter-dc-building). But the failures
> looked rather sus - the test was reporting that packets which were
> not supposed to be coalesced got coalesced.

The reverse is a known cause of flakiness, due to the context closure
timer firing. But unexpected coalescing definitely seems suspicious.
 
> BTW it's slightly inconvenient that we disable HW-GRO when normal GRO
> is disabled :( Makes it quite hard to run the test to check device
> behavior. My current plan is to rely on device counters to check
> whether traffic is getting coalesced but better ideas most welcome :(

We probably have to maintain this behavior, but could add an override
to enable only HW-GRO.

Alternatively, just for measurement, a bpf fentry program. But that is
a lot more complex than reading the counters, which is sufficient
signal.

> > > This series is not making any real functional changes to the tests,
> > > it is limited to improving the "test harness" scripts.
> > 
> > No significant actionable comments, just a few trivial typos.
> 
> Thanks!



