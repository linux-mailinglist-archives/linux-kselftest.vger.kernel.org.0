Return-Path: <linux-kselftest+bounces-18041-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F158297A637
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 18:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0CD6282000
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 16:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B939615B97E;
	Mon, 16 Sep 2024 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEDwuiOx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3466D15B57A;
	Mon, 16 Sep 2024 16:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726505342; cv=none; b=t2+ZioTohmISfteqG5V9l80PKgGm93KGHBO77bN7NBSQICGHjSYrsD0kcWC3F7CrR34XXzwbeBcanSH4Z3HtwJsk2E+8FKZgLzZG1Mylv8IlwDD3OAXVEQ2nJrXN680PquUTdXBDxVLxKODYkyRJcV2XpScgsceDPmxbGeRa/IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726505342; c=relaxed/simple;
	bh=iCifxO/L2Lc+9fPqxiadaaVsvhT7cN1M0jmxrRgVrYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgQxtotNKxN8FmdXb6LsyGnNMJjlVzsBdaIUiK35isyd9X5Fz8RlbuYg7qGw3ql9e7V/+5X0ETsuR5hn52Wz0wlRml7pZJJDNRYAOz7rPJSlg7il7Otki99bRr1efM5dWM/A014LYdcFNf+b6ILKXCyeiXuv5SGGkklI+y+WnyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEDwuiOx; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20551e2f1f8so38457165ad.2;
        Mon, 16 Sep 2024 09:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726505340; x=1727110140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M3njoMW9W06+zFFMF2oAAYOkQ8sptf+PvpVp1o1UipE=;
        b=MEDwuiOxBQITR5HLbKRxo4RsVshpJO0xMVlMdF3/A01DVZFGybxECyw+1CidbvQTgy
         OMLthaycMigY/jjaVTiuSJRCrVebjzfHBaWl+i9jc1tEoUbZf8TUpKcsObgbQsuoFx2e
         Lo9ki6Vd/Td0b6LJiLhCd6ljfmLRIFuxK5cw2dWj/gO6HjurIgx4+HpPyLSQront+Y3H
         ARalGKUAPT7YEydTBA0eKz7wW5ESfKfmjU9rMtPyxx3HSkCHR3Mcs548htOuMMENNz3v
         jFE4myRtymfQ1K2uEKLxe0dn/i7KpjM0T4EaQsuCwsxcBxMzrFRiJvNiyllxMoLPfIl2
         gJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726505340; x=1727110140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3njoMW9W06+zFFMF2oAAYOkQ8sptf+PvpVp1o1UipE=;
        b=ay8svN6HeH5aKOMIUYJjWUBhYQ9wZsPKd/sl/yP8h/WNVz7IibIxFkF2VZvVufas6l
         wgShVCnKgrDJ5eV4vKv1ufDEueeBCGZRzuPYpYvq9Y70Fn5HMMNL9+4rks5RjJWD38LK
         sf4zkYvf8UQXriOCtW2X70Ju1zvOgfHIpr+jQ55xoQ+IdkPx4G9z7cL0TLWKGfdIu6De
         uG5DNU7YDdtnJHFkrqtNnGa8R/GFdQouF44G3k+B9B66yJ5PrQ06fHYevbtDh6fhPWWc
         a31kZnN6edej+V5O16oWUmlCSEOYEOW8xWp9j0Nb2D5os7sLBgXJyx8nQAfRITuZiym6
         JSMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUET34wmyij9U5z9UPGBnkGY/Axj2AAm8eHD2Dn33xeWhUce4LGlJoz7RqzCoDV2Mfbj4nVTCyb@vger.kernel.org, AJvYcCW9zty1ycqNIZ47aFDn9bDaGyY+qCgn59cB8g7SpGVT9yiJWCynh+v6i3fshUmuKltkYJlzjwYwIs5JNHYzLXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6rKn3frNMcfSzhs03NWKz5AmjKhxQ2PEx8dDj21UZc/TpfFui
	e4mAw4mlMcOlR1IquqEezVcw4ku/31xT78jQLf2aLfz6HbsCx4A=
X-Google-Smtp-Source: AGHT+IFtiIOWZ4mcKegzsvUdmQHpMCTsHsx3Oh70Mq637y2edVbZ80fvqYNEV9zCsyBD/BTRud5Vlg==
X-Received: by 2002:a17:902:e54e:b0:1fd:791d:1437 with SMTP id d9443c01a7336-20781b476efmr186169645ad.6.1726505340292;
        Mon, 16 Sep 2024 09:49:00 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d64f5sm38109875ad.132.2024.09.16.09.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 09:48:59 -0700 (PDT)
Date: Mon, 16 Sep 2024 09:48:59 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, ncardwell@google.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v2 0/3] selftests/net: packetdrill: netns and
 two imports
Message-ID: <Zuhhe4-MQHd3EkfN@mini-arch>
References: <20240912005317.1253001-1-willemdebruijn.kernel@gmail.com>
 <ed54ad21-4a5b-4bbb-8f16-22fbfe1bd738@kernel.org>
 <66e2da1b440cc_14a89129431@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <66e2da1b440cc_14a89129431@willemb.c.googlers.com.notmuch>

On 09/12, Willem de Bruijn wrote:
> Matthieu Baerts wrote:
> > Hi Willem,
> > 
> > On 12/09/2024 02:52, Willem de Bruijn wrote:
> > > From: Willem de Bruijn <willemb@google.com>
> > > 
> > > 1/3: run in nets, as discussed, and add missing CONFIGs
> > > 2/3: import tcp/zerocopy
> > > 3/3: import tcp/slow_start
> > 
> > Thank you for the v2. This new version looks good to me:
> > 
> > Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > 
> > 
> > I didn't pay too much attention to the new tests, because they look
> > good, heavily tested I suppose, and I guess the goal is not to diverge
> > from the original ones for the moment. Still, please note that the CI
> > reported some timing issues with tcp_zerocopy_closed.pkt when using a
> > debug kernel config, e.g.
> > 
> > > tcp_zerocopy_closed.pkt:22: timing error: expected system call return at 0.100596 sec but happened at 0.109564 sec; tolerance 0.004000 sec
> > 
> > https://netdev.bots.linux.dev/contest.html?executor=vmksft-packetdrill-dbg&test=tcp-zerocopy-closed-pkt
> 
> Thanks Matthieu. I did not run the dbg variant often enough to observe
> that. Note to self to run more times before I submit.
> 
> It seems to fail 2/10 times on the dbg spinner. I don't have an
> explanation for the failure yet. The line itself has no expected delay
> 
> # script packet:  0.113203 S 0:0(0) <mss 1460,sackOK,TS val 0 ecr 0,nop,wscale 8>
> # actual packet:  0.107191 S 0:0(0) win 65535 <mss 1460,sackOK,TS val 0 ecr 0,nop,wscale 8>
> 
>    +0.1 recvmsg(4, {msg_name(...)=...,
>                     msg_iov(1)=[{...,0}],
>                     msg_flags=MSG_ERRQUEUE,
>                     msg_control=[]}, MSG_ERRQUEUE) = -1 EAGAIN (Resource temporarily unavailable)
> 
>    +0...0 connect(4, ..., ...) = 0
> 
>    +0 > S 0:0(0) <mss 1460,sackOK,TS val 0 ecr 0,nop,wscale 8>
> 
> I guess the expectation includes the +0.1 delay before calling recvmsg, and that
> timer fired a bit early.
> 
> I previously shared a draft patch to adjust --tolerance_usecs in dbg runs.
> May have to send that after all.
> 
> https://lore.kernel.org/netdev/66da5b8b27259_27bb41294c@willemb.c.googlers.com.notmuch/

Not sure you've seen, but tcp_slow_start_slow-start-after-win-update.pkt
also just popped up on the dashboard for dbg:

# tcp_slow_start_slow-start-after-win-update.pkt:39: error handling packet: timing error: expected outbound packet in relative time range +0.600000~+0.620000

https://netdev-3.bots.linux.dev/vmksft-packetdrill-dbg/results/774981/1-tcp-slow-start-slow-start-after-win-update-pkt/stdout

Do we want to follow up with that '--tolerance_usecs=10000' you've
mentioned above?

