Return-Path: <linux-kselftest+bounces-17346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F05696E7D8
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 04:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14E6EB22C46
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 02:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD0132C8B;
	Fri,  6 Sep 2024 02:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcW+EeQi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFC71BC59;
	Fri,  6 Sep 2024 02:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725590755; cv=none; b=r1oa0TCHEgUu18M/861KvZFKC52fdSG+WEU0BUt9WJUvojOmtxVG/nDRMbyGriR1Obpw7H3pp2D7lUEBQILjmpj0vfYdlRFr41JX/Sc2rEm8M2NQYHKLS6lXwhhsRu5JsyRkC/yRbjjsVS92zJoc4sUWxEh+2jTvi35ck2VzBE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725590755; c=relaxed/simple;
	bh=ixNLaOAtVMGoQC1gtQD3vczSbizq28Rh27a/PBzkGaI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dskdHeynVl/McMonwAMmYI8hHv6duNirK9SoqxVrm9kJRHC15dM9ZEZbFJIXzIqbGCwy1JQVw/ouIsgYIVwIUNW64T0kS/Bgyngici0ONIJ2BBa0ymBzvNEprZ6ZUoNEsnE1nPAaU0FRID1rADR2aHVSXjfXRYwwte/NOZTnA98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcW+EeQi; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a802deeb9aso100081985a.0;
        Thu, 05 Sep 2024 19:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725590753; x=1726195553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+XQr8t+aPYsPo7Nk3RSgvzNeOgekiEJiS+0t7Ud70g=;
        b=TcW+EeQiZ4GawQ95AIEMwZtlQz96NyHy9H7QF1gCM922z8MG4WDB7DcTaUqb0igAAR
         9dv9ONIoHMqoflK4knV50m7pgDdifKvm/VTRbo/aQy5i5j+xiTgHWtglLlQQe9ILrImx
         KkpnKAb4dIVJXMg7LHWQC14xW7Z1IgI6ZAs0Q8fCmRLOFPTs0onhD7SNtrhaU4BFwLPW
         4/KppMHT0Rbhp2cdFgdYPFqniEwDSGECct3LD5QnATChgC1hjVXWNehIfIB/oACbIeGP
         tapI7subuHG0zMsdXFR3PEzdCeMH02hsUdfeW2NRiDh6gRZfb94FnrPnRtZS7pzFyme0
         YZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725590753; x=1726195553;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O+XQr8t+aPYsPo7Nk3RSgvzNeOgekiEJiS+0t7Ud70g=;
        b=iOBC4nXv3lgnrQKiif/uxRlKMjD8xq9Oh4DkQGSXT7PE483JTUHyG/kXRwR2Nl2tnk
         4YaU3mouaQAYhEVvLYE/AILSaPcTZ6wrVIZ06KKl+eaZd+mbf2xK7oWDauVgcZz2Xyrj
         iHzqpws86c7PyhaC26SZY9emcLcfbX1TnHpGvtnbr8xiSJK8HCq2yLAZUroaIKQaEjx/
         Q21WJewyf8vPRaI9oJNnerKabd9J9O4TDgJKw2JArwpVXnQlhqnaxiM7QMGhj1DyROAw
         a70WOxJtaSHvcu7XCoBZ2Fr4Pq3JORejxV30f3NOP+Ihz0E+RvSs+bwnSfBdgu5NkIq3
         yALg==
X-Forwarded-Encrypted: i=1; AJvYcCU2vWCZOhQjjdlCtq/mtrpQnKT2cCL5c5Cva5y6wRX/gfodBNQXY+KLtI3Iqu7uzM+OKQda2z3nPLP0zhPITJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbh8hnxPH1tULded+miW1AfA6clsW1IbHPXotNirntVBqsY7W+
	myTlxLX+cxDQglykEVa1epnGfJU6+689z1+DbhwHLDaf/AE+EeeO
X-Google-Smtp-Source: AGHT+IEKnSw+TKSc+8yZkRq/O5vfEer6Po/gobR0i/TDnW6OKsztIOL/l0LbaaJpubdHfEZmAPciLg==
X-Received: by 2002:a05:620a:4146:b0:79e:e302:7392 with SMTP id af79cd13be357-7a99733a677mr145515185a.32.1725590753231;
        Thu, 05 Sep 2024 19:45:53 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98efea9c1sm130024485a.75.2024.09.05.19.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 19:45:52 -0700 (PDT)
Date: Thu, 05 Sep 2024 22:45:52 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 ncardwell@google.com, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 fw@strlen.de, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <66da6ce0f72e_27f00d29441@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240905184204.797a4c49@kernel.org>
References: <20240905031233.1528830-1-willemdebruijn.kernel@gmail.com>
 <20240905031233.1528830-3-willemdebruijn.kernel@gmail.com>
 <20240905143128.0dde754f@kernel.org>
 <66da3dabc3f71_25102d29476@willemb.c.googlers.com.notmuch>
 <66da4ab570989_269be02944d@willemb.c.googlers.com.notmuch>
 <66da5b8b27259_27bb41294c@willemb.c.googlers.com.notmuch>
 <20240905184204.797a4c49@kernel.org>
Subject: Re: [PATCH net-next 2/2] selftests/net: integrate packetdrill with
 ksft
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
> On Thu, 05 Sep 2024 21:31:55 -0400 Willem de Bruijn wrote:
> > > Packetdrill scripts are sensitive to timing.
> > > On the dbg build, I just observe a flaky test.
> > > 
> > > The tool takes --tolerance_usecs and --tolerance_percent arguments.
> > > I may have to update ksft_runner.sh to increase one if a dbg build is
> > > detected.
> > > 
> > > Let me know if I should respin now. Else I can also follow-up.
> > > 
> > > Need to figure out how best to detect debug builds. It is not in
> > > uname, and no proc/config.gz. Existence of /sys/kernel/debug/kmemleak
> > > is a proxy for current kernel/configs/debug.config, if a bit crude.  
> > 
> > Should have kept on reading. Will use KSFT_MACHINE_SLOW:
> > 
> > +declare -a optargs
> > +if [[ "${KSFT_MACHINE_SLOW}" == "yes" ]]; then
> > +       optargs+=('--tolerance_usecs=10000')
> > +fi
> > +
> >  ktap_print_header
> >  ktap_set_plan 2
> > 
> > -packetdrill ${ipv4_args[@]} $(basename $script) > /dev/null \
> > +packetdrill ${ipv4_args[@]} ${optargs[@]} $(basename $script) > /dev/null \
> >         && ktap_test_pass "ipv4" || ktap_test_fail "ipv4"
> > -packetdrill ${ipv6_args[@]} $(basename $script) > /dev/null \
> > +packetdrill ${ipv6_args[@]} ${optargs[@]} $(basename $script) > /dev/null \
> >         && ktap_test_pass "ipv6" || ktap_test_fail "ipv6"
> > 
> > 
> > > Another config affecting timing may be CONFIG_HZ. I did not observe
> > > issues with these specific scripts with CONFIG_HZ=250. It may have to
> > > be tackled eventually. Or CONFIG_HZ=1000 hardcoded in config.  
> >  
> > I will just add the CONFIG for now.
> 
> Not sure I follow the HZ idea, lowering the frequency helps stability?
> 
> We can see how well v2 does overnight, so far it's green:
> https://netdev.bots.linux.dev/contest.html?executor=vmksft-packetdrill-dbg
> (the net-next-2024-09-05--* branches had v1).

Great!

I saw one failure in manual runs and was unable to reproduce it with
a few more iterations. Let's see how it goes.

We do adjust these internally, to the same value for KASAN.
 
> FWIW status page lists two sets of packetdrill runners, probably 
> because I 'reused' an old team-driver runner instead of creating
> a new one. It should straighten itself out by tomorrow.



