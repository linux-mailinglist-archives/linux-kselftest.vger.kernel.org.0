Return-Path: <linux-kselftest+bounces-15028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E91D94BD84
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 14:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3026BB24D8C
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 12:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00D118C910;
	Thu,  8 Aug 2024 12:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNgCi2wp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B06154C17;
	Thu,  8 Aug 2024 12:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723120136; cv=none; b=ouAwWbKz/4tr2xE73jkRYdtO1MIK0GHgCnQejSZhLiHaoEI+JGyyUmhoNKlnWIcjMQJO+E//xn40OYgF3yFxbe/4p76ycrmWP1bUWSCiFh7F45hF9HoOWKH5nON/YC9/FStOGiOHYTCcdf8b5ECElpD3hyoGDjLyXueZS45j0FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723120136; c=relaxed/simple;
	bh=0FdOeou9MfhtoDpBtONpO0k3RoBpQmdH3thG2TSFsD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JotMc7NkM4IrGtVBI4AT0XwbEVKsULfLZTN8EraXPFGhMUt4RBeMEAqUxkOafqWG+f9r11F/kkY+4Fpn2sNYr3VZfkZ6twVbOXdeyuITW5oe9vF7T9vkXWrlcmq5Geq2q9GFpfgkarSek4BWdQwFbpUYMZjFk+DmOs/kUS7V2NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNgCi2wp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ff1cd07f56so8054765ad.2;
        Thu, 08 Aug 2024 05:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723120135; x=1723724935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FdOeou9MfhtoDpBtONpO0k3RoBpQmdH3thG2TSFsD4=;
        b=CNgCi2wpUmRZojjGLmBAkNq3kvT8jIEYdD7CWiXrtrhenXBtPhEwT/M9hEZn1kvMc4
         Q1YYY4y5/4ONbFM3lr3p/+JSMQdX7g/jwcaopeVq22+uwPc4BIq+mYBNcKgSLkd9O+Pf
         Wfk6b+CxlMhJOopRH0O/mCUOwfKVTnNE/i2FhEFEWps4riOauiKq+gClfe6CEev62wgl
         9CdWXPaCdau9vVfE4XcVo4ulxW+wQtMaIgc8OEoXl6m6sYRKCu0RFd95ehVO003Y7aLV
         m2lgtKuhkixUv9V+j3Zb3aIP2J7hrfXwtmePsUPhacHy3ABOb5IZE9+ds8vev+e4cJ/h
         AEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723120135; x=1723724935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FdOeou9MfhtoDpBtONpO0k3RoBpQmdH3thG2TSFsD4=;
        b=tzke7E/hCCQvd63Tm51o6CZE+SaxBHiPa9HTfxf4bJoHGccnkfBrRDpvfDT50lzcU1
         9KrZBi8WMkR0Jxu8he5x/8gMnD0M4IW4FeM27MDeqnVnaJJZ3q6hv7VroT8BcHgxXMOA
         jgvw4tHdbo3HTDVP3AzgiHI4gTUK4KzHqvXYW+WR2UHJY2hlknTzFehc7Xewic0zaq7Z
         lUdxkxKU7eanEH8/CPFWzwjePoN/vdK5StmjRAv2AiPxQSPSyVZ9l2TT4XmQGgELEk9d
         QrzYNbg24swbn+86DzxJjgFZWfaXMeZwspF0TjFqb4/ygvh1XE+vBhYwCbhmATU1hPCQ
         HTIg==
X-Forwarded-Encrypted: i=1; AJvYcCUlmvdHBiLdz6D2gxhDIAj3SlACCXtRxRjPKCYns03GqoocQwZpoqeD2otxHAbLx5C5eAR1/oY82Dc7aZNV5+S5ErYqZtgjd7qTmGiIb/+A8vUQ22RUiGoYoPI/hR3oI8gRKc9JjaU2MQsphd835j6ZQAnHdTgXil0DHdAv8rO/UkQJTnPM
X-Gm-Message-State: AOJu0Ywfr/J1nQ2CiFBA4XL9EaYnOSJf3J4GY9gjPgb0489vQzHsofom
	jdusNinoIiob9JcLYmHqZy2PQbIhvi5mw/6jZN2sajojB1SRi+Jp
X-Google-Smtp-Source: AGHT+IFlI/nsaAsoAwlZ930o2MviWWEEUgxZQpRbcm/HigNXs4xBllGLYD/zd0E0rXPSBOqj+jqbQw==
X-Received: by 2002:a17:902:ef10:b0:1fb:94e2:5643 with SMTP id d9443c01a7336-200952248e8mr18880575ad.12.1723120134582;
        Thu, 08 Aug 2024 05:28:54 -0700 (PDT)
Received: from dev0.. ([49.43.168.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5905f64dsm123258585ad.126.2024.08.08.05.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 05:28:54 -0700 (PDT)
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
Subject: Re: [PATCH v4 1/2] selftests: net: Create veth pair for testing in networkless kernel
Date: Thu,  8 Aug 2024 12:28:47 +0000
Message-Id: <20240808122847.25721-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807182834.25b8df00@kernel.org>
References: <20240807182834.25b8df00@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 7 Aug 2024 18:28:34 -0700 Jakub Kicinski wrote:
> That's not the right syntax..

Thanks for the feedback Jakub. I have rectified this and while at it,
I tested using vng on a network based kernel and found another issue in
veth removal logic. I have fixed that as well.

Please kindly check the v5 series here:
https://lore.kernel.org/all/20240808122452.25683-1-jain.abhinav177@gmail.com/
---

