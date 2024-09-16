Return-Path: <linux-kselftest+bounces-18053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C7C97A889
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 22:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA494B2170E
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 20:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665CF15C133;
	Mon, 16 Sep 2024 20:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cN9SclyR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD1E200A3;
	Mon, 16 Sep 2024 20:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726520054; cv=none; b=EqzMVcXYySh6XWvWLYcCyQm8qc2psupZCMPbW9tzhF37zssm2stY7x877JsXI0VCLx+OXEqJsoiYKC+0OnQrTrtxlfcGWJPEcHdjBdvWGWH2FmZ2NzLlcJ28mMvavyDh6uoHRkdm0p3JeNKHuiCoKtnkLKNfpOxixxC/3mokQfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726520054; c=relaxed/simple;
	bh=Xxd2/QeYrhizxq4XTR1/ovg0e+NrKnQsX44DrCba2sI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=fdqrpiPPgjYo2zRc4TWeFraIlzYq5vBu1JzyKtPSS1vlGmVulyIXPzoHHPyY+AMK4Yp5DwarcXw5wdrcJWjk/y8E5TUFaIckdRp9SoFI7AIgQPSiBXjRsvHCjy/F3FM3O145xrT2j0BdF5ki0jkt0vDV9DP0XcAWaLtZkAR7KmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cN9SclyR; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6c524b4a3aeso39628016d6.3;
        Mon, 16 Sep 2024 13:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726520051; x=1727124851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+xVEh/Fun30CfnS0s+qAjskdsNGiEH1QQx4TBqmgWA=;
        b=cN9SclyRLLu1hUxoFd07vySw7dYdrTCueBcO9PYilAceaKl9+0kIGKq8og1g0Pzjtw
         fSEIl6zgy0EOUUOImmXM17eTy+eIP52M7fJ5iidSP90jgI1fymlXYYQRPtXj9nn3DRmh
         q1fMVStj9hjYiD1trWubNm8Vi48lauq/u/7RRNNesd+jzQyiQMS2PJsPhfD++rdl/fRx
         WvFfIMp5NSrKh8XBkA9+z9AQm39l6mh2svM4ZpB9IaIx+RRv9S2tWIC20gnWFnxiSvr3
         nBz1Ys0qFoYT295jrnFradD6nP2g66AgPLiFRqMNp7xULR/+huIYBHpHL9C1vrO80H1g
         it/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726520051; x=1727124851;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1+xVEh/Fun30CfnS0s+qAjskdsNGiEH1QQx4TBqmgWA=;
        b=l32/7pC0aKI8k/RwexcdMHtf4DqFvD+9rfeD24JAN93u8yAUr96fAPjvK5frSYhBI7
         Uc/0su0cdFnHxuxjU/JzOzYnWGm8Fh5r1CYBV9RdnFPafXJAdTbCvXyVPQrFl/JZ7EPl
         12ZDblAxDA9WkaOLRQmivgPa46qQTVkvoYbKmX037be9povT5OyutRRXrl69agAPVr0H
         lQ/Bbcc8GDsNtTdwEAMi02u4ZTgZflI04ISBlgKoONVG7oRKQyHjJtryUjEJ+pGRuJ70
         M/ygkOoepIww7rdT7NaHnYheRWb7ENQjen+EHVX+ZT0Ihrc7Xuog8QFG3Awk7VUFVWfw
         QNkw==
X-Forwarded-Encrypted: i=1; AJvYcCULODtBegK4gURXPBFuS09NP0ecvjhAl7JkhtkpRkYQvqqgc2ANrvIl6YHcMLxobp3l8FNO+FSH@vger.kernel.org, AJvYcCWyJqlg6iTV2CTRh+A2uxQNLqOpsbTJzibkVAagx2gYrkmLaGQgos7G5DlGRJN0H0UacsK7MYVM7h8N0O7rmrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTW+soTythdk5dqtjsNorb3p1BqbZwEYzwJaItV3dXPqPIvYOv
	Fq4a13lENfTIsSXWdYWbC2bGVC+8FfcoTIM3Fpvqq/OA4dPH4hGz
X-Google-Smtp-Source: AGHT+IHgECk6w7DBYPH0rHBywyHjQjb2oqc+jBVZgIBdLTU6TJsmW2Q85pOyUKkk6Ntb2slkXsqRdQ==
X-Received: by 2002:a0c:f40c:0:b0:6c4:79df:a2e5 with SMTP id 6a1803df08f44-6c57351aa2amr279927166d6.20.1726520051414;
        Mon, 16 Sep 2024 13:54:11 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c642265sm27788776d6.61.2024.09.16.13.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 13:54:10 -0700 (PDT)
Date: Mon, 16 Sep 2024 16:54:10 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 ncardwell@google.com, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <66e89af24d4a3_23d205294e4@willemb.c.googlers.com.notmuch>
In-Reply-To: <Zuhhe4-MQHd3EkfN@mini-arch>
References: <20240912005317.1253001-1-willemdebruijn.kernel@gmail.com>
 <ed54ad21-4a5b-4bbb-8f16-22fbfe1bd738@kernel.org>
 <66e2da1b440cc_14a89129431@willemb.c.googlers.com.notmuch>
 <Zuhhe4-MQHd3EkfN@mini-arch>
Subject: Re: [PATCH net-next v2 0/3] selftests/net: packetdrill: netns and two
 imports
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Stanislav Fomichev wrote:
> On 09/12, Willem de Bruijn wrote:
> > Matthieu Baerts wrote:
> > > Hi Willem,
> > > 
> > > On 12/09/2024 02:52, Willem de Bruijn wrote:
> > > > From: Willem de Bruijn <willemb@google.com>
> > > > 
> > > > 1/3: run in nets, as discussed, and add missing CONFIGs
> > > > 2/3: import tcp/zerocopy
> > > > 3/3: import tcp/slow_start
> > > 
> > > Thank you for the v2. This new version looks good to me:
> > > 
> > > Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > 
> > > 
> > > I didn't pay too much attention to the new tests, because they look
> > > good, heavily tested I suppose, and I guess the goal is not to diverge
> > > from the original ones for the moment. Still, please note that the CI
> > > reported some timing issues with tcp_zerocopy_closed.pkt when using a
> > > debug kernel config, e.g.
> > > 
> > > > tcp_zerocopy_closed.pkt:22: timing error: expected system call return at 0.100596 sec but happened at 0.109564 sec; tolerance 0.004000 sec
> > > 
> > > https://netdev.bots.linux.dev/contest.html?executor=vmksft-packetdrill-dbg&test=tcp-zerocopy-closed-pkt
> > 
> > Thanks Matthieu. I did not run the dbg variant often enough to observe
> > that. Note to self to run more times before I submit.
> > 
> > It seems to fail 2/10 times on the dbg spinner. I don't have an
> > explanation for the failure yet. The line itself has no expected delay
> > 
> > # script packet:  0.113203 S 0:0(0) <mss 1460,sackOK,TS val 0 ecr 0,nop,wscale 8>
> > # actual packet:  0.107191 S 0:0(0) win 65535 <mss 1460,sackOK,TS val 0 ecr 0,nop,wscale 8>
> > 
> >    +0.1 recvmsg(4, {msg_name(...)=...,
> >                     msg_iov(1)=[{...,0}],
> >                     msg_flags=MSG_ERRQUEUE,
> >                     msg_control=[]}, MSG_ERRQUEUE) = -1 EAGAIN (Resource temporarily unavailable)
> > 
> >    +0...0 connect(4, ..., ...) = 0
> > 
> >    +0 > S 0:0(0) <mss 1460,sackOK,TS val 0 ecr 0,nop,wscale 8>
> > 
> > I guess the expectation includes the +0.1 delay before calling recvmsg, and that
> > timer fired a bit early.
> > 
> > I previously shared a draft patch to adjust --tolerance_usecs in dbg runs.
> > May have to send that after all.
> > 
> > https://lore.kernel.org/netdev/66da5b8b27259_27bb41294c@willemb.c.googlers.com.notmuch/
> 
> Not sure you've seen, but tcp_slow_start_slow-start-after-win-update.pkt
> also just popped up on the dashboard for dbg:
> 
> # tcp_slow_start_slow-start-after-win-update.pkt:39: error handling packet: timing error: expected outbound packet in relative time range +0.600000~+0.620000
> 
> https://netdev-3.bots.linux.dev/vmksft-packetdrill-dbg/results/774981/1-tcp-slow-start-slow-start-after-win-update-pkt/stdout
> 
> Do we want to follow up with that '--tolerance_usecs=10000' you've
> mentioned above?

And more tests coming. Looks like it. I'll finish it up. Thanks for
the pointer.

