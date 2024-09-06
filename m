Return-Path: <linux-kselftest+bounces-17341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9720D96E6BC
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 02:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51955286B61
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 00:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05B2946C;
	Fri,  6 Sep 2024 00:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbqoG7Mm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0558C0B;
	Fri,  6 Sep 2024 00:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725582009; cv=none; b=sQLzfMqvpI9soZOfIa+UA6h8a4dveE/xVEqNVYaoYWGt7taYoiFY1Wd1K+r7NoRZ2R1zL7qCTBcn1ito4aI1iM0hOy0qkHZjCLV2uffUhBVWTcxsqJtWJviPzUCnR27NhgI2uutd1DhYBOm/n2Lo9+zwgTbJVOEjWE72CTFn+SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725582009; c=relaxed/simple;
	bh=k6HdsAxoeA8RN4oFUwCtYdv0OJumnCAJBq3cA5p2ouE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=laJO4GwA14dicdU9QRAJb0t9SUsnoQ0jm0KjMb8suRxtxvoQ8vMITehSEM2v8WXFz94EAvmi+tRJTi8zOFLxqlPpeHyEmQas5RZd41zD00w9IEdqd8ALbps9jDXCROZapRSOQBk2XdgRgKPiJn4l9cK/v/Nfx+iCZKd2MqqdCOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbqoG7Mm; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e1a9e4fa5aaso1527441276.2;
        Thu, 05 Sep 2024 17:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725582007; x=1726186807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwUnGvgcdVUsv9NnxXJyKjm/Pvuz799SJrkUxeDj1qg=;
        b=fbqoG7MmXlZrBscZsF7TJ1rxVH5H96Uz2iL491RyhiJVhLaP03JlOZqRd5lPnKbWd0
         8pxQN5ixu2cn0wKgC0LHJPMOXRN6QYz0rubSsnr8+g6cCvwOGqVtzBJr6dZn903o0qex
         DFva7QOjbsN1U5Etv+rXpcDGs9YXX+umWwrXIXIDK27zNVic/aQhQvaWLg7SqHamLR3v
         hOOM4TqPQIKQ7RxtVbXogBkaqhy7c82PZiF5fMPIe6z4cKM5+7DWXfXVPuz/td3CbEWY
         kBjCGZwdwjO0DCan15Gd0J4LONZvz8lZwH7WpChICkIvLscXrcpRVtu/01JaaKbc4SOz
         f13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725582007; x=1726186807;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bwUnGvgcdVUsv9NnxXJyKjm/Pvuz799SJrkUxeDj1qg=;
        b=gNo3Dyin7hBDvAA9RYu7tHrE2FCdJN31x/W+EuRn0lPgZ585CusgKz0XCq4SFh9tPB
         3XKDveZNo64YgB+vtWP6KtPd//6cZKb7rf+uLYUZjCR9GTw3gJ/abP5bE1/9GUm5tcQT
         LDfLOOpIFrM40UfeFOqY+HDUA2mFF1zGUdAwkbVKFt4ixYwMEmcL5YMRJOJ1e/qfU7UG
         v1o1eEp6OWPd8f1S2/B3ebqkG1jSSWV1SsB91U+V6Oz1UntkWx8ZZk+qhI+1fFkhid8A
         goK/yBrGqvwX7PZ3xsDe0JpMsUCY7eZaPU+4WBPz3ugwYZMgBL333LncyBjdaXhvMfxf
         PKgw==
X-Forwarded-Encrypted: i=1; AJvYcCUpBYchrjPFdqiTQWhCszVNZghYurpH5DUxmVOmkpcB8VhN6mK0XsZAiUMGp74Y6DHea9P4VS+fhkqpLg6lvb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS7kRbnueiZG4ej77KTUIus9J5pdrO3qKyVeQocy+wfNiEvwom
	rydqeNggarLTVNNNuSaJxqjy6UEQbzabamHhNbq+deC7CFUqrTGx
X-Google-Smtp-Source: AGHT+IGumt+v8v+Ykj6JASAC76hryFaHwDPu7JeY3jkYr8idFoziDoH1COgIxvxze0w+9EeRF4ffhA==
X-Received: by 2002:a05:6902:2846:b0:e1c:f239:4dd5 with SMTP id 3f1490d57ef6-e1d3489864amr1180872276.29.1725582007112;
        Thu, 05 Sep 2024 17:20:07 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c5203152dasm12099046d6.95.2024.09.05.17.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 17:20:06 -0700 (PDT)
Date: Thu, 05 Sep 2024 20:20:05 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
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
Message-ID: <66da4ab570989_269be02944d@willemb.c.googlers.com.notmuch>
In-Reply-To: <66da3dabc3f71_25102d29476@willemb.c.googlers.com.notmuch>
References: <20240905031233.1528830-1-willemdebruijn.kernel@gmail.com>
 <20240905031233.1528830-3-willemdebruijn.kernel@gmail.com>
 <20240905143128.0dde754f@kernel.org>
 <66da3dabc3f71_25102d29476@willemb.c.googlers.com.notmuch>
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

Willem de Bruijn wrote:
> Jakub Kicinski wrote:
> > On Wed,  4 Sep 2024 23:07:03 -0400 Willem de Bruijn wrote:
> > > +++ b/tools/testing/selftests/net/packetdrill/config
> > > @@ -0,0 +1 @@
> > > +CONFIG_TCP_MD5SIG=y
> > 
> > Looks like this is not enough:
> > 
> > # 1..2
> > # open tun device: No such file or directory
> > # not ok 1 ipv4
> > # open tun device: No such file or directory
> > 
> > https://netdev-3.bots.linux.dev/vmksft-packetdrill/results/759141/1-tcp-inq-client-pkt/stdout
> > 
> > Resulting config in the build:
> > 
> > # CONFIG_TUN is not set
> > 
> > https://netdev-3.bots.linux.dev/vmksft-packetdrill/results/759141/config
> > 
> > Keep in mind the "Important" note here:
> > 
> > https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style#how-to-build
> > 
> > I recommend using a fresh tree or mrproper for testing vng configs.
> > 
> > Feel free to post v2 without the 24h wait, it's a bit tricky to handle
> > new targets in CI, sooner we merge this the less manual work for me..
> 
> Oops sorry. Thanks for the pointer.
> 
> Sent a v2 with CONFIG_TUN and a few other CONFIGS from reviewing
> the existing configs and defaults.sh. The above steps work for me now. 

Packetdrill scripts are sensitive to timing.
On the dbg build, I just observe a flaky test.

The tool takes --tolerance_usecs and --tolerance_percent arguments.
I may have to update ksft_runner.sh to increase one if a dbg build is
detected.

Let me know if I should respin now. Else I can also follow-up.

Need to figure out how best to detect debug builds. It is not in
uname, and no proc/config.gz. Existence of /sys/kernel/debug/kmemleak
is a proxy for current kernel/configs/debug.config, if a bit crude.

Another config affecting timing may be CONFIG_HZ. I did not observe
issues with these specific scripts with CONFIG_HZ=250. It may have to
be tackled eventually. Or CONFIG_HZ=1000 hardcoded in config.



