Return-Path: <linux-kselftest+bounces-17814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB779768BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 14:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87AE5282912
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 12:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C2719F40D;
	Thu, 12 Sep 2024 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8/kXq8e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2B72C6BB;
	Thu, 12 Sep 2024 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726143007; cv=none; b=ZxLBqJAUjbmVM69XqDKJqK7c4Vm6hbs9GCYQt5krxS+ksrur5Wyboyij/KDmvnEQ1Aou9J3CabKlR/K2u+DLIhqna9GCkIDRNYF+OR2fgrHTdjnyqAAJFE2OZ9a7zaobV9RVzQ48941XPFOVxVXqZgXkCKqXQI0nIZ7EV2vyvnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726143007; c=relaxed/simple;
	bh=lVvZUUG+zyn/ZfXGNBItiXEKNsLuGv5HEwMfC6/HDw0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WyK3cMYUJYSxBFAVnB4vrQeud/YPoPKhOzao9JjGlX08PaTp0cuSyfUPgnToogSv3HDn7pkw5sxqIxUzUuQwgXvU5db2bq6ta9/DU9kD5BKpEmea6Z4dXAWUomaoQYEr2daMd8Hb4Tu5myZqJ3Ki7r/KZWY4Xe/r5rcwNUHfelo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8/kXq8e; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6c159150ff4so6757076d6.2;
        Thu, 12 Sep 2024 05:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726143004; x=1726747804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msixuc5DjYAhtMCMiouAiME28Ctun/SSEXrHmmI1f7Y=;
        b=S8/kXq8eYjOURLVnUWEjqvDgx2PleXQgjeSQNWkyD5AGqgGFljzRn35LUXcH9j3iV/
         W1IYLkhsnP1v9SMTd+B55YVGbqhcbQ2XB1DwAYlWCIvkJHCYg8I7LYEDznW+CZnJqcGD
         HvT6Y4J/4v9iodARjDqmrobR0ngvgkF8bsp484+y50VAagdylnuGpPUGvlfFSSfrLL1W
         WOBEXALTYdb7Uu5ZAO3HCu4fxoicXuFxunmISGuo3PqBeMou+fkxPxwd9yjx2ya5lVGG
         4wVr38gL54456Hey6MjzuwdEIPpkRViEIPne5eFnqTCDzqi3cFLbSs9tOFE4rOFy7uuh
         xZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726143004; x=1726747804;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=msixuc5DjYAhtMCMiouAiME28Ctun/SSEXrHmmI1f7Y=;
        b=TDAx20zkRjx8Pm570d9OHE1WCuH6kPc3hOmBg+b0qeFCq5iwdOAi4p7gTBKMOKnELr
         NDhCNnIHFtPExrktRtTyQFzz5fnYdDAAqe6owxb3xdcsbuxguQsF1sVigCnYoQ8Iscxh
         rzkBqTUobesqrJ7UEFc81E9uEbE77zvquiUkY2qMLScEipOsfWokHYUXaLiYsiZpGMl1
         6YKMeDMjLPZXAFyGOuQUDxWy6Ngqv0be9Q7E4kebVJhHm0f6c95jkc4OzYwzQMZOQFrd
         NQNG3Xf7+oy5cHgkxCoWTGlkv2iukmv5kaZ5XeWFaXjLoNzAPrj0fxAATSGpWldO0re+
         xRbw==
X-Forwarded-Encrypted: i=1; AJvYcCWHOTY2g1I/ocCZ/7wcQ25MXPyBeS6FaCAvW7hiQIIzQU3zDHFuzPaZqMY/LdXXUCd87zuAsrzm@vger.kernel.org, AJvYcCXYp1YOlG7uGAw3gtEeL+4GNu56s7shoN7WeUVUeOjblo0px4PfcJiDBoiEGt5T54seEmynDn+2efBX7ms1+Oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeH+RultqOuCXkhjbgb6jVPM5UtGDOH2Xzkz69INaK6DYZUjaY
	V3/QZ9E0uWweZj8it99L92mJlzQZCdMl6ZO1QW+uC3cS6kI7+MPz
X-Google-Smtp-Source: AGHT+IExa2ElXKLKc/w9WjBtRYBCBXPtGboQdVxdbXGPlYF7+fDNkNgtONBgfbsBwqo9oUDLBpeM3Q==
X-Received: by 2002:a05:6214:3c85:b0:6c5:5326:18a5 with SMTP id 6a1803df08f44-6c57352ac57mr42674486d6.28.1726143004063;
        Thu, 12 Sep 2024 05:10:04 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c534787340sm53159836d6.143.2024.09.12.05.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 05:10:03 -0700 (PDT)
Date: Thu, 12 Sep 2024 08:10:03 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 ncardwell@google.com, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <66e2da1b440cc_14a89129431@willemb.c.googlers.com.notmuch>
In-Reply-To: <ed54ad21-4a5b-4bbb-8f16-22fbfe1bd738@kernel.org>
References: <20240912005317.1253001-1-willemdebruijn.kernel@gmail.com>
 <ed54ad21-4a5b-4bbb-8f16-22fbfe1bd738@kernel.org>
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

Matthieu Baerts wrote:
> Hi Willem,
> 
> On 12/09/2024 02:52, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> > 
> > 1/3: run in nets, as discussed, and add missing CONFIGs
> > 2/3: import tcp/zerocopy
> > 3/3: import tcp/slow_start
> 
> Thank you for the v2. This new version looks good to me:
> 
> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> 
> I didn't pay too much attention to the new tests, because they look
> good, heavily tested I suppose, and I guess the goal is not to diverge
> from the original ones for the moment. Still, please note that the CI
> reported some timing issues with tcp_zerocopy_closed.pkt when using a
> debug kernel config, e.g.
> 
> > tcp_zerocopy_closed.pkt:22: timing error: expected system call return at 0.100596 sec but happened at 0.109564 sec; tolerance 0.004000 sec
> 
> https://netdev.bots.linux.dev/contest.html?executor=vmksft-packetdrill-dbg&test=tcp-zerocopy-closed-pkt

Thanks Matthieu. I did not run the dbg variant often enough to observe
that. Note to self to run more times before I submit.

It seems to fail 2/10 times on the dbg spinner. I don't have an
explanation for the failure yet. The line itself has no expected delay

# script packet:  0.113203 S 0:0(0) <mss 1460,sackOK,TS val 0 ecr 0,nop,wscale 8>
# actual packet:  0.107191 S 0:0(0) win 65535 <mss 1460,sackOK,TS val 0 ecr 0,nop,wscale 8>

   +0.1 recvmsg(4, {msg_name(...)=...,
                    msg_iov(1)=[{...,0}],
                    msg_flags=MSG_ERRQUEUE,
                    msg_control=[]}, MSG_ERRQUEUE) = -1 EAGAIN (Resource temporarily unavailable)

   +0...0 connect(4, ..., ...) = 0

   +0 > S 0:0(0) <mss 1460,sackOK,TS val 0 ecr 0,nop,wscale 8>

I guess the expectation includes the +0.1 delay before calling recvmsg, and that
timer fired a bit early.

I previously shared a draft patch to adjust --tolerance_usecs in dbg runs.
May have to send that after all.

https://lore.kernel.org/netdev/66da5b8b27259_27bb41294c@willemb.c.googlers.com.notmuch/

