Return-Path: <linux-kselftest+bounces-15887-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E5D95A3CA
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 19:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28796B21A52
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 17:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA431B2516;
	Wed, 21 Aug 2024 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwwShDyu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269A71494D1;
	Wed, 21 Aug 2024 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724260917; cv=none; b=ScRqABtBmmH90D6QUa73GjQkIFEi2Z7fsax/4TKzofFFs7bDnTEHTPfkLM9MFN9YQffMxZdWtgbk8Ba19cxdb+b8yQ0YILKeIlii7tDL4KxjFQQfPkBqRz+Pl8jbleKZ6lv1xeV107n+7EABE+iI0JS/KQhyqVJ2QJf7eng6nVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724260917; c=relaxed/simple;
	bh=sKPoAYf57+hToI6UbeW+ihZav4oxCix0Plxz/d46A88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AKV+Q+14zk3BSAchxJPMHumyigOZWQxFJTPJ4GZME1eXrN67A8+Ha3N2gmHK+eIIv1xUSezQ28XXRH6vIl1CGvH1wbceZl2Rv5rpLDSPJBHbh5cr9C6hRKwn9u1dmtHHdOW8jJdXeje0eHdx95+mkzr8tZb/UgLljNlj2w7goFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwwShDyu; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-27032e6dbf2so2667824fac.1;
        Wed, 21 Aug 2024 10:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724260915; x=1724865715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRHLUFe+LywX38Cr1uTxqwwQ3KNcmiw4BEYPfkJSfA0=;
        b=gwwShDyuiRKgUEfqYQmSjYzHHSCW0PgQLnj5Ow8wAYodVsRx3aQeqQIj0MCTlDyHCY
         7TR/N+MUxAOSlUVB+oDFUJY7OxJ/SkdBCYtMOLDWyS3T+q9XIPIQeqECKstkLGokq6xM
         h407sMmfPo9Uvvc0lqXlHB8RmPoSBIR3Q5s18ew1S2rjGiNHYvXYlRJ0yv884tIw2Dd7
         qQCMe5SEi4qHVydEr5HfmApIXLULMaschKN3LsE+VfFEI69XLWNyZT3DqDow3T5Ftthx
         JjrnGwpI2bb20bMxgi1J0pZUZ60FxvTUV64Ke6Yrt+N3v9vNC3Wxn8FIK0w7PICr2H2m
         DErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724260915; x=1724865715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRHLUFe+LywX38Cr1uTxqwwQ3KNcmiw4BEYPfkJSfA0=;
        b=VGjeJ8nvabcMZM/RBcuEU42iv8Ozo8g8sNg3fho4E6aQhRGZFBNlv2JPpUm4hYEG5Q
         9Ehllyh5wW4U5csqigkPmtargxLIJ96lKJyivPlU0zJ/60k7W7tMvfDZDlpsAz32v8bV
         pfEmPInp+n38EL9h15Cucq/AQeIe8T/xl2Pa+F5+iJDMh5XAMDrMf5Ntpw7EScq+dv0x
         t++Oh0Q0zLqJTOq90ibStStHKU1ZCZXp/Cm9rFCMOFL3ygf52+FLTIrAsAoQsiKcdD0h
         yv1/DQnHp9tGtBV+GmoN519xvb0va1lrx8PxPK0IAU3VSJdjD4wFxYkjAFKZ/FqTQRRJ
         3qMw==
X-Forwarded-Encrypted: i=1; AJvYcCUSrRD4rFUq7rBKGucQlJvfGM3vyws1BPUZSKpCWU9UIGqQHHOQFjdSUx37nJLyvP0rODJxtKck@vger.kernel.org, AJvYcCUgRKPyXiDPyDP5rzMiY7CauRhBaCRr0Je+7urM5GiDi4jmGSRT7+T50WZfwoMJEbOaI1ys9PVY/pYgR5M=@vger.kernel.org, AJvYcCVxE2bUYhvihxFc1lQzTfMcrqgNFHtA7uHrYVGa6nq0oAOADUHOOU7tOp72c1ZHCmJUr5vK/2MoRLRSWfk9+sRW@vger.kernel.org
X-Gm-Message-State: AOJu0YwyFyGJxpqS0/nul4pqxY3REh+kzWHFIGq9EFqYmq87vFILpNch
	cWCNRJBUxhtR6dKpQF06Lq0fclU9rLbdegjZhAGZgUqDYd2Cr1mpP/Ms6g==
X-Google-Smtp-Source: AGHT+IERO1RjXSPMs8qscc9E/L4klT06zKW3kuVa0lcGArWZ+HlEMKphefnuwaYC8NSC3/ob7hYjmw==
X-Received: by 2002:a05:6870:3286:b0:260:3ae9:c94 with SMTP id 586e51a60fabf-2738bee13d5mr2707937fac.51.1724260915117;
        Wed, 21 Aug 2024 10:21:55 -0700 (PDT)
Received: from dev0.. ([2405:201:6803:30b3:2256:a75d:4176:9e6a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af3d945sm10185388b3a.189.2024.08.21.10.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 10:21:54 -0700 (PDT)
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
Subject: Re: [PATCH v8 net-next 1/3] selftests: net: Create veth pair for testing in networkless kernel
Date: Wed, 21 Aug 2024 22:51:46 +0530
Message-Id: <20240821172146.118441-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821090041.53df4147@kernel.org>
References: <20240821090041.53df4147@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 21 Aug 2024 09:00:41 -0700, Jakub Kicinski wrote:
>> I presumed that we would want to run the interface up/down, setup and ethtool tests on both veth.
>> If this is not required, should I submit a v9 removing veth1 from the temp list?
>
> Yes, please.
>
>> Also, while sending v9, do I add the Review tag from Simon or it has to be reviewed again?
> 
> Yes, you should add the review tags

Thanks for confirming, I have sent v9 accordingly:
https://lore.kernel.org/all/20240821171903.118324-1-jain.abhinav177@gmail.com

Please review, thanks again.

