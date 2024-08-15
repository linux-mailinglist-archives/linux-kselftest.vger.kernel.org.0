Return-Path: <linux-kselftest+bounces-15401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F152952D3B
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 13:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95DA4B22080
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 11:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF6F1AC89F;
	Thu, 15 Aug 2024 11:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNIlMLFX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37521AC892;
	Thu, 15 Aug 2024 11:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723719892; cv=none; b=QBRxvy1kphFFzFxrTarEBjLhqK2Yx+yoqS0+QCkeWVot/gSlwtwKbd4Xo2VC8vEoITcXvIgsM/ymvSt7hWzVM1bXInSrg4r7LBOoFiJ77ZD2ZpFBUs5xlvgFZ+2pHg1VfL3C2GsazjoNOiZZ84xIY7NurDoGE6TLYMZphx3SsPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723719892; c=relaxed/simple;
	bh=4nvrFDnN4EPoSXCLaFR7WKT17RVQVoqlBFtSjb8NQQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=USF6mUG6INFSB8Ab79onxEoTKgcP9py3b8BqWk7qW2GGF07C9vZMnOFQJzsXkvadKYH340YiLBFc8VEudkqa3Bfa9xWzxVErnvLIaqJFTwPG3d+QpnLm6oTC2fT4Ac4ha04V/kn3PJWK/fMOZ+y5IjrKz6K3iBH/o3mZAJPvxoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNIlMLFX; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70eaf5874ddso622224b3a.3;
        Thu, 15 Aug 2024 04:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723719891; x=1724324691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MO8YWOqY0SzIOTQqdA2QCR7JDaNp1DiScS6bAzhozDE=;
        b=FNIlMLFXOAyuP0btu7/u4WuMGt1AQ2XHcf92Aw0kVp1XLJnp+5RTO/u+XXbFFZLtW1
         SybNwzo1NDiTeRBruiVYd3p3KTx2SeIkOPxO91nMzO/J/eZBieQzcfazVclNjaaXWDMG
         7G2yfRYCB/1elo25xhVeLqlS/7EN4FKSR9tkGhBfcKRdTjV5N2tgVGD9OJ2vd4UWq/uY
         Tq8srBNH1RrBwq/yuxjQbx3/qWtJez77R3ydqQhG/Fi8psS//4aCINuOuGoE+U0wcpKb
         Ks7KoyN4yLtFZTFBKV0NNnrvGU1fP+Jhx522rmxLnOuAADQD6lizoeJxiY2t8a6f2Kbu
         sLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723719891; x=1724324691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MO8YWOqY0SzIOTQqdA2QCR7JDaNp1DiScS6bAzhozDE=;
        b=rBeuM65hRRhRF5WPugk8XmWdM76rq6QEX2LprUqQeen1miSUuygYz10nzoI8eGmlyv
         uDo81ZHUXPm6zjWzTDE6Xtwqv5ZFlZD628nV7m5lSeR3G8qvIRbXOcFMixXSAr5JUv2d
         XHBmId1UR4p8OsetyDw6lNBWrTV5jcKeFX58IuctfIkDRIwpCwSGfXyYfrmsoqOHk3RH
         k9g/YEqOE5IhGMzCLHnC4yAth1zdVSm79t80gtEWA+irMuhRDReuiYzWR1SegqIpfviY
         +5zhQKbjRCtjBbXWcLUo6ZFGEem0xyrcT/5KjudkQmi8jsyTMuompaV8FaAkJ+txOfLn
         fzpg==
X-Forwarded-Encrypted: i=1; AJvYcCUzk6cQ8RPKnLO8xoMKkKLM3rQTu16fmTa4VG/4sqBNLpValZ1af0G6qYP/EydOUheU1bT5IiA7bYWoEknIF1pJ@vger.kernel.org, AJvYcCWkmr0z/q8Ey3W3Zxvxjnyo7LkdMTtBb5V74YEw/79e6+D41KtsLpML+BeTblCfZBlbAAdN/9yi@vger.kernel.org, AJvYcCWx1VvlA4plKYYcqyJRkyWXNv/GtDJk7P4mV6eCkiYHeoQPOJf/PHkmwLxcHaZ4XXZHqkwv96vBWkjFBL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2b7AX0BjC7x3rUtKao+gwyzIpECdltOW0rvE7j5DYaxrb30RM
	p7EHb/3HQ8eATRrPrTJC0AcGMGYnIygPvHT82/dFU9u+XKcSysncFmvrEA==
X-Google-Smtp-Source: AGHT+IGiI28eQW4aNoADjB2yJ7jMZYp79VlkylTg4Ld4J1kWlBZBteUIluYpWSPSrpsghDldwqQwTg==
X-Received: by 2002:a05:6a00:4656:b0:70d:11d9:8a3c with SMTP id d2e1a72fcca58-712673d7e72mr7330479b3a.26.1723719890769;
        Thu, 15 Aug 2024 04:04:50 -0700 (PDT)
Received: from dev0.. ([2405:201:6803:30b3:f070:7306:329d:c8ca])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127add7c89sm812678b3a.5.2024.08.15.04.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 04:04:49 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	jain.abhinav177@gmail.com,
	javier.carrasco.cruz@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH net v6 0/2] Enhance network interface feature testing
Date: Thu, 15 Aug 2024 16:34:42 +0530
Message-Id: <20240815110442.1389625-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814175748.35889b6d@kernel.org>
References: <20240814175748.35889b6d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 14 Aug 2024 17:57:48 -0700, Jakub Kicinski wrote:

> On Wed, 14 Aug 2024 17:56:51 -0700 Jakub Kicinski wrote:
> > On Wed, 14 Aug 2024 19:15:15 +0000 Abhinav Jain wrote:
> > > Changes in v6:
> > > Use XFAIL for ethtool operations that are unsupported instead of SKIP.  
> >
> > One more:
> >
> > tools/testing/selftests/net/netdevice.sh: echo "SKIP: $netdev: set IP address"
> >
> > I think the SKIP -> XFAIL conversion should be a separate patch (for
> > total of 3 patches in the series).
>
> P.S. and please change the subject to [PATCH net-next], it's a net-next
> change, not a net fix.

I have sent v7 now with net-next instead of net:
https://lore.kernel.org/all/20240815105924.1389290-1-jain.abhinav177@gmail.com

For set IP address part, I have added logic to XFAIL if veth pair was created 
and to SKIP if that's not the case in third patch of the series as directed above.

Right now, there is no logic to set IP address in the script for normal interfaces
either and it is a TODO as well. I will focus on it next after this one is applied.

Thank you for all the help Jakub.

