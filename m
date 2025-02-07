Return-Path: <linux-kselftest+bounces-26017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF99A2CAF1
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 19:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE736188A500
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 18:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531D619DF5B;
	Fri,  7 Feb 2025 18:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIKOh63l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34D5199EB7;
	Fri,  7 Feb 2025 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738952075; cv=none; b=JpQp67fx2tneHHkJ4iAIPFyoZLiDqhWIWSfXbHoY923G7nxDXpDHbdjNOh0z+lAfDIf5Hw6t7rHK+RviGOngPK092MwZwL6RG51uaZ70zPqf1d7kKCD+yjUcB2FpIgjQkbTlKUUcPOMw4AziJFrVPYAiRZxq5f4trXIOHBm/Rzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738952075; c=relaxed/simple;
	bh=wc2Uo4qAIKE4YpBCI6MhwPDzpuOUfeuKc6K4dUFY00w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dFag6ZHUDeu/52Hv5CE+KBWmEjrkDl78wSMakd7/GYdy5qwwT7hb7l03O4Uu9Zlcb7EKO7ksi2WgpW0knoQ2BARlTCgWfvqYozGrkZPHnOZEJaJC3voRfPpo9Tp8Z6fiG2Odsu9b9q89YfacfXTx6v9V7DAVhv9QQaWG74plMeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIKOh63l; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b6fc3e9e4aso212550785a.2;
        Fri, 07 Feb 2025 10:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738952072; x=1739556872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cpR/catNjUKVLPE8TnRdeFUXnQLkPZNrbuMZWab4WE=;
        b=aIKOh63lN2xo1cU/Nij2fJLX7Hd2psSrLfqeW2COJiFU9kkBGv5xy9daITK4pvelsv
         G8NeKH6SkB63w3vj2oUXbVbZV7pdrbD8QvpVP9FBGM1O2Qf28isd8+kDAGZbMV7GcMok
         3vD00dF4b9Udr0fkfWHQA7m8z00KusWJj89Xmdg9Y6f6xfLn3GsGWkERglGQfcf4kOzu
         gCJI4yebn77ec14DyuCZcMPTHfh7L+QxMg3Q0P5X9F/4h+5ftvspJuF7WN0+DVxnIP37
         L7IDorZiSh+dS4/fAyxuWwqqmORs2PjsUPjfrZSkNdaXyXn7p/3xB1lFhxIEvqH8Ezc/
         aRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738952072; x=1739556872;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6cpR/catNjUKVLPE8TnRdeFUXnQLkPZNrbuMZWab4WE=;
        b=uus/5XK2IGjd40BBQ/GlQBn/6Hy9MDP+Il4fe5puFXwa5vcb9bmFsWWy5JWxYB2wGG
         WXYQmo6pbi+StFBFKZ99OxNsi9jeeq/BS9/UbxqMyCNJkfw6Zp5Et8RCtMlbaKwLVZG/
         qL60DmXyfEW97xD2fhJ4+EU37XbksbJwnCz6wIokb8B4wAM65cY4kI9CRhloTvGLo+Jn
         TUcgdK8Onc8FpyV67fSnM/gaDf8FWyUTaGib44Ffxj1eSW2samWYVtscgUd2LGcxVGvh
         oab8ZFAZJg2A+l/g+I2DhBOTtuXJ1Rfrq0z++M6FiD8OHE47RQ52sm/9HbBdL00TgrU7
         Ry1g==
X-Forwarded-Encrypted: i=1; AJvYcCUwQRmyRKXNQGZZIRLd2y7Wbbjht4ix9Bzg22ZS2Sb29UJG/koypYKSGynSxwIuPcbLU1Ih1RXF7/18+t3PXis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw70PuyMKITkOs5SfBHK6xSRYIrtHoZn6J+KoWm+JmZBquufrAU
	y6WLDefbG9pokr1XS6AbrLAtklpHkna2gJz1TljOoNOa7jT7daf2
X-Gm-Gg: ASbGnctL7IPupv13H2QXlcEKY2rhpyPxkmifTF8bcpeoQcluIC9DdfVkopF4Yl+sb7r
	z1JaLJgdriw9HAdq967ENjY1fQ6s6Bsi/cE/8eXruo2cg5jVrGQbKNAx6LCGzPAP4IHP20JmDSA
	nYoRzb3WPqsT7IvZS3HZBX58blGGGfZ5uEd9WwghOsfh5wbqXrG8UAmvETOZ0irwsvRO5VU0EzL
	GIW8gBuwCOQhi1uIHbIFt2VgdUeE+kGP8UvSqWG2i7S2UFoKvd9XYnH1+E8f4hjfYlmQXoN6Upw
	4TO5X6gQurLfoFyHlBtmGKQX6fytYonSlkHrDdS/ZZlndR7xT1lJTn16CYxAML0=
X-Google-Smtp-Source: AGHT+IHcZed8Y6N75kfOPaZKLNyruXtqM3If5ETw+a5qwmO6s3qeq+mVUwkgur5WqipW3FrL8J3u4w==
X-Received: by 2002:a05:620a:45a5:b0:7b6:c92e:2e74 with SMTP id af79cd13be357-7c047bbc521mr580447785a.20.1738952072471;
        Fri, 07 Feb 2025 10:14:32 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041ded1c5sm220032685a.3.2025.02.07.10.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 10:14:31 -0800 (PST)
Date: Fri, 07 Feb 2025 13:14:31 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 shuah@kernel.org, 
 willemb@google.com, 
 linux-kselftest@vger.kernel.org
Message-ID: <67a64d879b34e_2b3e7e29442@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250206235334.1425329-3-kuba@kernel.org>
References: <20250206235334.1425329-1-kuba@kernel.org>
 <20250206235334.1425329-3-kuba@kernel.org>
Subject: Re: [PATCH net-next 2/7] selftests: net-drv: test adding flow rule to
 invalid RSS context
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
> Check that adding Rx flow steering rules pointing to an RSS
> context which does not exist is prevented.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

