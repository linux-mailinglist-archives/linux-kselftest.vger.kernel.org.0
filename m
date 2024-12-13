Return-Path: <linux-kselftest+bounces-23379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AAD9F19CB
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Dec 2024 00:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3414C166721
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 23:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281611B3724;
	Fri, 13 Dec 2024 23:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XebVGns7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B934C194C7D;
	Fri, 13 Dec 2024 23:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734131947; cv=none; b=N8tEFrwMCV3Vm0L4saycuS8er7Mi6b3PciAvjp6lLWR3eZRaYn2sHrcC0CA1xkHt9mhMBcTLI/kNpHuKmWUSsy+topJY0ar7xWDnvyrCZ8ubWT+HR7+rK427SgSHah4ijKajMbbf6Y2nzyJsxV8Inin8YpA33rNnJ0AUMs3JfZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734131947; c=relaxed/simple;
	bh=buSXj9Eu3v5WysNxEm8QcbC/XQhDnt9c4n4hd/cbp3o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iyOuS6PDUzWeAh5gZ8c9Rvm56UaQU7OSpPEN+5NXLy14ReFpvpvthZxXOVwT70xcGO6rlA2bgxSpkqKwrNYga/PmmL9kljlCBvPxKVR0BJFOio9PzZekoyTp5mOufC+mNnpFMsjXNJBBgtIx9aPOzJPg/mhFPqRafFfyFfFnxpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XebVGns7; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-728f337a921so2469294b3a.3;
        Fri, 13 Dec 2024 15:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734131945; x=1734736745; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=buSXj9Eu3v5WysNxEm8QcbC/XQhDnt9c4n4hd/cbp3o=;
        b=XebVGns7taFZvtyTpsmRSeXVJ9T3bkmimNyVWsnrUVvbmQhUxwiNNWVhZxRjtt4OJp
         9Em2KxiLs476PKkg7Ucsd+0fxo3qDnSK1xvHMliOABoMVVZCvEP/xSLgCsLruA+olABg
         5Asic4bVi3uQUoEutDHN//0ho+f6dLw1V75DXPYOdgELDpUbWyrka5uW5qtALdnokiRK
         WImdZ9uP4ee3w1C+MZpkpl91d4bcrqv9SMIqLikqpCBQ9GnH9g0tEmR3RYtrgqSYKnSx
         2rqNmXraIdcpX0klfyy90W3fsu0/Przzp2QiUoXVGjHSvfm6LccNF2WToPRhQW3pQkzG
         Tfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734131945; x=1734736745;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=buSXj9Eu3v5WysNxEm8QcbC/XQhDnt9c4n4hd/cbp3o=;
        b=mhz0fqxqc/m9NU/2fE09QcCwC7HdnHNPP6jywtVTe3n+qmTd54SlnvnGaV5m3hRnpr
         IG1Yhl2jaBpFIKXYs95GdbFBni1cEeKibY8zY8b+MuS3KlyU0aKoTiPizjVLcbPc8MKX
         bC8ZTKVD/Eca48WbXU67quS692B0uSKGuzza5zhuO+cINsePD0iRVggYJ1eZKDuOVw2T
         KD2NY3y0v9SYKDkYZeXG4bs7ILy45pbXOx9RLxNeoaB6ar3GrZrJLqgiZgr5iLSC37wR
         x5MAGUqt9lJwa4GAsfcV1WMMH/U+9ASsjLw7RoZ3/s+zi47p8IkABj4YEVvSJUErJA22
         kRcg==
X-Forwarded-Encrypted: i=1; AJvYcCUIOhsXq/Jdm7C+RrQ+YwBhPWAaAr13Utk5LmrLqfWm/ikwi2L4+DQDqt31UIRluMWwu9Ffvjr9QfkKXD3P@vger.kernel.org, AJvYcCWiG/ZavX8aHlznt0QIpSgHL2bw+B/SwRICwBvBVTUR67y20AKxNN7mzmbsw5XOMe0kU1mZ51v7O94CZ9HRscFn@vger.kernel.org, AJvYcCXW0+l46fMjoXig9lSLasTgt/RqXzhLbpi/I0cxu8w/MyUEBRPCjtoXtAP3VN4b6T49LaMMFFDP@vger.kernel.org, AJvYcCXlmmo0klgjEmDKiSstgLEtjy29u31fd24WfhFVZt5WTbZlVDB+iDW9uyxAGeZDY/E0OUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2C9LH4J6Em4SgBiD3ckXyAv0KKg6LqXQ+1GygmUYFUybO8TeR
	gXy6SmVO6gEz0NG6JQzhesmjailbNdCLabIDUsonQTEy2/kdGIAt
X-Gm-Gg: ASbGncu+I3e8NBpb634BfaGSor2uHaTkgg09IekdS4Oxl1cniN29uWlPyM9jLXZUVcH
	f5IF7QwweaYGe4l0lRKMDySSy9e2BnomsHHtrkaGtmzN3w5MK+IFYHfoXpZU06YQ1U//Lfvj4Eo
	a0m3bMlO6Vgdp8PEatGbVv/1zW9uQ7BBjrBka1jPdaOL4NgshbhbXMfL9U0VTlxm9/7iImG4E/P
	np9fZKL1mn2vYQWlKLH46ALI4ABSg2YHs20YjElaNatz323EwjtyQ==
X-Google-Smtp-Source: AGHT+IFAZ3aQ/IPrf/Ya3bUc+Pvgb9Vh0D2C49sG8d1FwoFV5ZloaqsCFeu0BSkRbqo7WmToNT6ftw==
X-Received: by 2002:a05:6a20:3947:b0:1e0:c8d9:3382 with SMTP id adf61e73a8af0-1e1dfe6a67bmr6134972637.45.1734131944960;
        Fri, 13 Dec 2024 15:19:04 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bad9d2sm313385b3a.157.2024.12.13.15.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 15:19:04 -0800 (PST)
Message-ID: <0eb169a27a61eb29f8a0c1ae44904934c9b4f14d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 4/5] bpf: verifier: Support eliding map
 lookup nullness
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>
Cc: andrii@kernel.org, ast@kernel.org, shuah@kernel.org,
 daniel@iogearbox.net, 	john.fastabend@gmail.com, martin.lau@linux.dev,
 song@kernel.org, 	yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, 	jolsa@kernel.org, mykolal@fb.com,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, 	netdev@vger.kernel.org
Date: Fri, 13 Dec 2024 15:18:59 -0800
In-Reply-To: <f99a31f62c19262fcad7debf10ede0bb0b970af4.camel@gmail.com>
References: <cover.1734045451.git.dxu@dxuuu.xyz>
		 <92065ca054beccd6d0f35efe9715ef965e8d379f.1734045451.git.dxu@dxuuu.xyz>
		 <CAP01T76UQgb=Y0kh6bKPABt=p8=JRmDHsFc31rsijXSrK+5+8A@mail.gmail.com>
	 <f99a31f62c19262fcad7debf10ede0bb0b970af4.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-13 at 15:14 -0800, Eduard Zingerman wrote:

[...]

> Great point, I'm sure this does not happen.

I mean, mark_chain_precision() does not happen at the moment.


