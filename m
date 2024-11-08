Return-Path: <linux-kselftest+bounces-21706-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A639C245E
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 18:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE082872F8
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 17:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F3621CF84;
	Fri,  8 Nov 2024 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oo7o7259"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D2621B439;
	Fri,  8 Nov 2024 17:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731088042; cv=none; b=MKcySvWVRA4f4lDo5ma1fiA0vC+EHkE7KwHSRlG3mJm5cOE7lqNhs9vg8EeYVDoujvXHp3w10NYXetf6Vu4VQTTWXlN7jp72VrX6aOM6h8EykH/xWjpjAN4JZh0ZfXn/5f+yzB7vR+IdzSkd+5vU/nvUJ0sxbnv7GDZtf/ek2ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731088042; c=relaxed/simple;
	bh=dADnfZeg0HdL7dMu2atATH92JAGovNANecVZthp4TaE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VTLnoh+JjmofbDZjv0UvmY8QjBCuIWLZR2OdbudLZKs8yVFlDLSLxB/jcOdQTlFLmbDjI2ajZkXqqigVddmCByfRACX15S4JSbUGiAB34xzEt44VMHFiVekRqU7AsQw2sqINK1GotGdpwfwlN5PqMhgt4UFAvLuatWWOdTDOD1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oo7o7259; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b13ff3141aso155594885a.1;
        Fri, 08 Nov 2024 09:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731088038; x=1731692838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yygs82dWB7I6pOgGT7ov6wBlnikb1ysgl9gP06/W3qo=;
        b=Oo7o7259mRkuCrHdl4on6hYLEZPYzoPgTCi5Un7Bcsbf6OjWiSXhI8RQwKERfmal2b
         5WbjlzMvlidh9PIdMO/qbvhsCv4fNcbDkbqWYU1n/Jgvm4FkeRTgCWvYjiz+if7/NOsB
         CrAVuosQ8n2yLolzmhFXC7Z0qrYmUwIUOU7xQgUSKchKnl5slk+QaDt1LwdzooHFkMrU
         GDcgbRhXk6ZKFDGiaJtfkkUKnV3XggWxtAi4k1hp/oW0ptCwB/ecvsGndnpVAgS5BbRJ
         FgDa6s5P3qNqd4DuSua2dAZXs1gHYFEoMfuXxHfRQUrPQpOHjeWzCyr3RUIk6BsQ07dZ
         I+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731088038; x=1731692838;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yygs82dWB7I6pOgGT7ov6wBlnikb1ysgl9gP06/W3qo=;
        b=qgMgGFdLrNp19JyjYt/MfirRtYZ7dmZMXLLqaX6JwFbeDwrYzSSkH371lwYdKvMTcr
         oqr3R1Wx1X5XVERjl/oYGDp1+FmobpmnnKX8UwhrIHNt+vbgSeJ978VZzJj1iDx+2TO4
         NsY/3xEPrlBc26iftK6BUD85tit/FRuEoL0MxDTiVNfbhJd9Jk+hlV14wCXAwkniWEU1
         b7Q+dS7yBzH1HGbcd9TsT8P8sJIMLk00rljijZtaS16rUR5YUnI3X735n6huPaEDXeD0
         GTpeE0KnMCl7wWNbuAGqRlDqKF3YUeG0FRrwKnA2i/gfy9fcPo3hjpZepweMHmTgvEuS
         pU1A==
X-Forwarded-Encrypted: i=1; AJvYcCW6syYjmBKxXeQsXtbu3TpDjLSnJd7e20bKCdsmwvp+tL4jEz04xy44WydChbQW8fspCtsy/4+FwKXMRXPTynGH@vger.kernel.org, AJvYcCXdfCurBbyJqHjIYj8r0j9uWYvQTR3rcUTRbNXdSQ8nSK4OMF+AHrPYxcHn5At3uvZ13AHhOwi5BRuOqLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvKtBJP5Kz7js2mBSOr73zsyUc5AQObA2/M21mYO4/kdyBv/VF
	MonddCCsam6dXleG48jZOrfCOx186xFg1vlb7yM6pDDNE95x4lXR
X-Google-Smtp-Source: AGHT+IEWROEGc6AdtmAfD3T42iutxzkwY2CwsMKZe4rlrsYUL2Bj9WCrxa74az9ayAKJ2rD4zfbqQQ==
X-Received: by 2002:a05:620a:4612:b0:7b1:41d9:7b30 with SMTP id af79cd13be357-7b331e755a3mr369119885a.60.1731088038137;
        Fri, 08 Nov 2024 09:47:18 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac57015sm180260485a.50.2024.11.08.09.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 09:47:17 -0800 (PST)
Date: Fri, 08 Nov 2024 12:47:16 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Joe Damato <jdamato@fastly.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 corbet@lwn.net, 
 hdanton@sina.com, 
 bagasdotme@gmail.com, 
 pabeni@redhat.com, 
 namangulati@google.com, 
 edumazet@google.com, 
 amritha.nambiar@intel.com, 
 sridhar.samudrala@intel.com, 
 sdf@fomichev.me, 
 peter@typeblog.net, 
 m2shafiei@uwaterloo.ca, 
 bjorn@rivosinc.com, 
 hch@infradead.org, 
 willy@infradead.org, 
 skhawaja@google.com, 
 kuba@kernel.org, 
 Martin Karsten <mkarsten@uwaterloo.ca>, 
 "David S. Miller" <davem@davemloft.net>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 open list <linux-kernel@vger.kernel.org>, 
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Message-ID: <672e4ea4e979a_2bc2f629490@willemb.c.googlers.com.notmuch>
In-Reply-To: <Zy4-GUoYKBo_inRc@LQ3V64L9R2>
References: <20241108045337.292905-1-jdamato@fastly.com>
 <20241108045337.292905-6-jdamato@fastly.com>
 <672e26ec429be_2a4cd22944c@willemb.c.googlers.com.notmuch>
 <Zy4-GUoYKBo_inRc@LQ3V64L9R2>
Subject: Re: [PATCH net-next v8 5/6] selftests: net: Add busy_poll_test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Joe Damato wrote:
> On Fri, Nov 08, 2024 at 09:57:48AM -0500, Willem de Bruijn wrote:
> > Joe Damato wrote:
> > > Add an epoll busy poll test using netdevsim.
> > > 
> > > This test is comprised of:
> > >   - busy_poller (via busy_poller.c)
> > >   - busy_poll_test.sh which loads netdevsim, sets up network namespaces,
> > >     and runs busy_poller to receive data and socat to send data.
> > > 
> > > The selftest tests two different scenarios:
> > >   - busy poll (the pre-existing version in the kernel)
> > >   - busy poll with suspend enabled (what this series adds)
> > > 
> > > The data transmit is a 1MiB temporary file generated from /dev/urandom
> > > and the test is considered passing if the md5sum of the input file to
> > > socat matches the md5sum of the output file from busy_poller.
> > 
> > Nice test.
> > 
> > Busy polling does not affect data integrity. Is the goal of this test
> > mainly to get coverage, maybe observe if the process would stall
> > indefinitely?
> 
> Just to get coverage and make sure data makes it from point A to
> point B intact despite suspend being enabled.
> 
> The last paragraph of the commit message highlights that netdevsim
> functionality is limited, so the test uses what is available. It can
> be extended in the future, when netdevsim supports more
> functionality.
> 
> Paolo wanted a test and this is the best test we can provide given
> the limitations of the testing environment.
> 
> > > netdevsim was chosen instead of veth due to netdevsim's support for
> > > netdev-genl.
> > > 
> > > For now, this test uses the functionality that netdevsim provides. In the
> > > future, perhaps netdevsim can be extended to emulate device IRQs to more
> > > thoroughly test all pre-existing kernel options (like defer_hard_irqs)
> > > and suspend.
> 
> [...]
> 
> The rest of the feedback below seems pretty minor; I don't think
> it's worth spinning a v9 and re-sending just for this.
> 
> If anything this can be handled with a clean up commit in the
> future.

FWIW no objections from me.

> Jakub: please let me know if you prefer to see a v9 for this?

