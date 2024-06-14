Return-Path: <linux-kselftest+bounces-11925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A90EC908AE9
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 13:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C4211F22138
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 11:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA7C192B8F;
	Fri, 14 Jun 2024 11:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyePAv0I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C7B14D29B;
	Fri, 14 Jun 2024 11:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718365018; cv=none; b=FdrAWs/e72O/xx3nnseYbOmQJK+Siouiz91qI+G6zPny7jOgkcmf1MQWZTKVb3aZldv3Acw+ppV7o7aYC2Sosn4lUANxt30JhU/cjKLlK34whc7Nl+buVn27lz8CPqPQxQRlnviXXtB3umkwtncU8nXjnQ869NAZGAEN9I0MBXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718365018; c=relaxed/simple;
	bh=TsM72t/kj8KowE2bo/L2KdBwCsqbTTAtJdzAE9Bbsdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QtClMUXYzIkwKmXzxkSsmOsymozMXWV3CGZGGRwwZuQ09IHHypNyva7gHY4tfU0U5Tb8Qynvng9WmUVK+LjeQlJ1yVYWqMDYFL+JCmsZy11PSzI0pvJBy04Lpj9tP3W83nEM9D2LUuU3xOOIloNqS4jhHv+l8eyQoBpLZiHj/TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyePAv0I; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d24724514eso1043995b6e.0;
        Fri, 14 Jun 2024 04:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718365016; x=1718969816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsM72t/kj8KowE2bo/L2KdBwCsqbTTAtJdzAE9Bbsdw=;
        b=GyePAv0I7kr+P5ZjlhILOrl6NUu/dhJ+d+CUIW/3Ohqbby1c84BbePUe1JZv70MFa8
         xPfkLEr9Tvby1L2xtdPCt1Ppwa96uNEek+YPFpCHE4+CQLl75edcWnXXl8Vo55PM00/1
         dtgK5HWTq4xkc2C4vhf51aMjspiemldNvxefHviRpF6K3oZruD9KsABJ0PsvclGWnROc
         TcRcVmBB21InFF1YId/9tqcAmv6FjAq0KgiLkeqU9gvnrFfSslOjs9tYcFBEBXLi+7QZ
         4J0w9VkmReIsRPoJUOr2nnoJh9CV1gKSJK/OZ/o9ekbKRTKDEZlMKz6Mb3lszJQWU+qE
         HKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718365016; x=1718969816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TsM72t/kj8KowE2bo/L2KdBwCsqbTTAtJdzAE9Bbsdw=;
        b=PYt7MiB37TITBgvKdNQ3Ptj3GnrVY5M369uV4JNOZPbnOvJDWCIMmXpo+4Yw+8tmr0
         JCXQ2LPbG8aK9+DIVwwwLQwjFc/WSeHsDlZkpyD6deorZmrm/mgtQBepsYAGwqo8Ppii
         m0UNh/0FyLer54vABYIUTk+zRwjviVNL6eiCVWgGxVPZ8/qCrC9OBGqoLuCqzMQ2DOTM
         ieWJPHEKb4T6duFrNdP2yt8epjXF7C4iO02OFhseJdhWR3Nbb2l7YWpyCtKsVBBgNCA4
         jS2VIriu8ZXw9dw/0K5lwa6nKJ2oOVhGB0k/ucIvt1SCt5hZWyJ3bYq+mEyIq8AKrAnf
         L1gA==
X-Forwarded-Encrypted: i=1; AJvYcCXLZ3BixUm5dwn9d1/xZoVLunzMM83ad5hfnMR+SHHFhDjcHMRnLYPqSyd4x+XDdlgEgKwDctVw2fk4vYTTTudC+G3W3oInxEhsDWeigFT6G3DPf3+8BOOPmdP1ESrMdkLogIPbgJvOTe9IqpY29RcFD2VnTQAV7I0HUFQqRlsaje2dEyXx
X-Gm-Message-State: AOJu0YyCEMw1tz995EkHZ01UMHjXxPrsX/A0B7rBq/+T/W8MYIBgke0r
	WVMawc+4Yh1LkHrI9watk3TWB9x+3OU5X1m1/Sg5LUru0qAuULev
X-Google-Smtp-Source: AGHT+IEsS78gFtAusdZgMhfDIoCJVclm7bXmHaZfmZMhVY6hHo8+Azf9b9ovd599I/CNZaq9SGEV2A==
X-Received: by 2002:a05:6808:150f:b0:3d2:edf3:6fd9 with SMTP id 5614622812f47-3d2edf389d3mr945922b6e.11.1718365014633;
        Fri, 14 Jun 2024 04:36:54 -0700 (PDT)
Received: from dev0.. ([49.43.162.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb6adcbsm2842978b3a.161.2024.06.14.04.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 04:36:54 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jain.abhinav177@gmail.com,
	javier.carrasco.cruz@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v2] sefltests: net: Add on/off checks for network interface non fixed features
Date: Fri, 14 Jun 2024 11:36:47 +0000
Message-Id: <20240614113647.41574-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613184938.0cc8cc56@kernel.org>
References: <20240613184938.0cc8cc56@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 13 Jun 2024 18:49:38 -0700, Jakub Kicinski wrote:
> You do off then on, so you assume the feature was on to begin with.
> Not all features will be on. You gotta change the order based on
> the initial state so that the feature goes back to what it was.

Thanks for sharing feedback, I have sent a patch v3 addressing this.
I save the initial state of the feature and set it back after I toggle it.

> Because I'm guessing the VM does not have any interface to test.
>
> Before we extend the test could you please make the test automatically
> add a veth or netdevsim device if there is no testable device on the
> system? Make sure you remove it before exiting.
>
> You can look at tests in tools/testing/selftests/drivers/net/netdevsim
> for inspiration and library scripts which can be reused.

I did the same, I have added a veth pair in case if the network device
in the positional argument is not there. If it's there and just a bad
device name though, I am printing an error. Let me know if I should use
the veth pair in those cases as well for testing.

I have sent patch v3 here, please review:
https://lore.kernel.org/all/20240614113240.41550-1-jain.abhinav177@gmail.com/

-Abhinav

