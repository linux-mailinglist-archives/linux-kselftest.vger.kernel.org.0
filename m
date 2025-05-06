Return-Path: <linux-kselftest+bounces-32519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB448AACC05
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 19:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF0F19830D2
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 17:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE77286411;
	Tue,  6 May 2025 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cae0fvxh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118312857FF;
	Tue,  6 May 2025 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746551547; cv=none; b=MYivBDnfheNB9RF/mjrKjxl6HR0WAmQMI0RQK4ReiW3Vt2//WiXr3FGX3RaPXOx967IzZyTYulHgV70+OLajW1E8+SlhujZ/DhYkvv+0QfLGRlDd/2cN5c9NvhNeSQM4J86RJRsO/jzhA6aQowCfeLcowwp5Tf+ypGilTTl09CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746551547; c=relaxed/simple;
	bh=MsdYdJ/KW3W35ZRffxosrmbNz2P9Pc6Brwu9+do3LHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+wcEO89MZbwqqCank/ozQVo/3H9G8jEDY0LtQkzm7GKHVS0b++tPijbyrvhefLpvr9joiirBjXpKbwXCVCfwTh0IgwGiCPF7D3umOA5vUanaVHHdLEBSl13y5tsmEs/66wKtcGia1IQ3b4cfNgkG67bmlIJbnB29w6rKy/8I/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cae0fvxh; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7398d65476eso75276b3a.1;
        Tue, 06 May 2025 10:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746551545; x=1747156345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jPCb39rUpAp5hscXjjz62U6p2DJeSpmSm0JrT60cYSs=;
        b=cae0fvxh+YbbcGGuPDMV+/eP7Shgmky2odpqrMnFPnajyEf48HJkbDAIiBfw45Fqxv
         fglCwHBHgdUZIiNihbxxpQ3pKuOZRwQ7q7+ycPiVTuLMMcLW9e8usSwrUDr+yjW/gfSg
         Q5abNwsB9ygGBuw/q72rkE6puYvAXuvUbAmOjszG9pkvRx1Z7z/BjmBfynJaKzGHhc6Y
         tb1h1i0GnmH245AEIz9qN7aybSzCpoLhqGVQeMNwzeYGil1ftbxQOKQ/+yt+RqRECMLg
         FoHmleCFerGDgGf9Rv6xR8VKcK98QgOkmCId3YWc/Fto3tuJitXwOBnk0ikjXg0rbjU/
         hJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746551545; x=1747156345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPCb39rUpAp5hscXjjz62U6p2DJeSpmSm0JrT60cYSs=;
        b=mJwGOVcLUNL8d1Zl0rwLuUpF08pUFn8tYMioISnQQVbcZesb01MzXZc4Bvt1edm57k
         Ufcv1HaHiZI4PxTZYdYe8StHxcPQ/KUHWXrvmGLtI57iGtIyhQs0t7bYjqAvD6817x6R
         2++WWOOEryFCtATUE48w239KLvLj4VRbYpF+VvuqjIPDUxsJZt3JspJk5IbAFo76WvQU
         YxStf792tAzn6Febe/OfdFadr6QwpVq71iYM7r4UclYsBWEGgzr9J5txGFQAOtfo19lu
         BMVldpNYKfkd7urn/Mijn6Ms760yZmo07brh10W6ZPget1qaDuR0mSwFEyjDhVIYtnHe
         Liqg==
X-Forwarded-Encrypted: i=1; AJvYcCXAvD0yrIVgsRsaTJ3HxGNbzg0FLNVMGiV6pJGEmfHO9dONp7vDBPuxQDRkPkj+pMgfVv2kX11lmhU0nZaz82I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTuPWSUuISuuOF5NtWYWchac7VcYS7MpzbyjpMaFS8pjmLtWio
	k3LQfAWLt6GK9mKIi5XKkycdqph4kHHTbDQBR85T6ZO0F13n+HQ=
X-Gm-Gg: ASbGncvzDuYdRqPpEehytAs+ND7KJGL31ILCKfZWMPzLlRJ+P/kcafLj07xNkE5G80n
	u2OQmL5BJgXIhYIwrG0bQgHsFobA0fz8QweUG+Qx2aAjoLTbHRg9bzCiFd2RrsEweLDqtIKLLiP
	kud97H33WrU604DA3BUQijKNEJMgEZ2EyZXfkLUgCqoAhLgDUeq5zCVJp3EMUzpBsmfGTEfykb2
	5eVhevPz8LGcAYW3ZM4jWwYB84jrjR+kqBCXOaovFwP3t6DuNkh9TUJmraIjw6I/cyqgCXXrJE6
	s3c6ogDVXhIQbJv7HU3u0xijrDnbmKWO3emojUiPJlevnTRImDBccvEpat0KU7NeCMZqz27CB2o
	=
X-Google-Smtp-Source: AGHT+IFsDdDD4rDYe4Kl3G3iViwO3m9GCrV6ZE2hAnc0k+Ve/Xm4RG2pejPfSu30EiVWJGdURKb3Iw==
X-Received: by 2002:a05:6a00:3994:b0:737:cd8:2484 with SMTP id d2e1a72fcca58-7409b6788a3mr804272b3a.6.1746551544887;
        Tue, 06 May 2025 10:12:24 -0700 (PDT)
Received: from localhost (c-73-170-40-124.hsd1.ca.comcast.net. [73.170.40.124])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74058dbba97sm9436665b3a.56.2025.05.06.10.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 10:12:24 -0700 (PDT)
Date: Tue, 6 May 2025 10:12:23 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"jiri @ resnulli . us" <jiri@resnulli.us>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] net: Lock lower level devices when updating features
Message-ID: <aBpC9_SgUaAA2P0f@mini-arch>
References: <20250506142117.1883598-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250506142117.1883598-1-cratiu@nvidia.com>

On 05/06, Cosmin Ratiu wrote:
> __netdev_update_features() expects the netdevice to be ops-locked, but
> it gets called recursively on the lower level netdevices to sync their
> features, and nothing locks those.
> 
> This commit fixes that, with the assumption that it shouldn't be possible
> for both higher-level and lover-level netdevices to require the instance
> lock, because that would lead to lock dependency warnings.
> 
> Without this, playing with higher level (e.g. vxlan) netdevices on top
> of netdevices with instance locking enabled can run into issues:

Mentioning vxlan is a bit confusing here; it shouldn't let you flip lro (I
think). Which upper are you testing against?

Trying to understand if we can cover this case in the selftests.
netdevsim also doesn't expose F_LRO feature... (yet?)

