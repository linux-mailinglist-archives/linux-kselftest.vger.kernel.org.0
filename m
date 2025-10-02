Return-Path: <linux-kselftest+bounces-42661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A46BB2429
	for <lists+linux-kselftest@lfdr.de>; Thu, 02 Oct 2025 03:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C191C7748
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Oct 2025 01:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E10572628;
	Thu,  2 Oct 2025 01:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPBnYoGy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13A235958
	for <linux-kselftest@vger.kernel.org>; Thu,  2 Oct 2025 01:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759368057; cv=none; b=tb5ME6SDD/+PSSGznzKAKrzb05sgrakE4t6IATpnQqTQohOJmBEYJeWke7zSrmIKBOVtPvXsE1AY5PaUlH8kzGIJaOKlgeoMEiPawPtKOISJAPRxh9tY+sB2hWoW4hYbtUVcfGFNi2R/kKyhH3gCxMWhfbvhUjGbU/z/bhQx/Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759368057; c=relaxed/simple;
	bh=Z41QyY0n4HiGjS42Gcj9FbnEZ55TMO+9hpoyZqI1VgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdWC8mBhYirZupr/kDIYwj+GFRMuVuaHKSvSF4KIUEv8y3O2Jg52jD9H/mGGofmSemaEC9Ux61zOODAOHCVMQVHBwbwfCnVnABpj5/y52OChyPiDc9osY0/8ebjH3azqDwAL/D1yBmQCy59ysNOA7c8mnf0r79vhzlFqDF8eNdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPBnYoGy; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-273a0aeed57so18983605ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 01 Oct 2025 18:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759368055; x=1759972855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z41QyY0n4HiGjS42Gcj9FbnEZ55TMO+9hpoyZqI1VgY=;
        b=iPBnYoGyD23G2zM27Q5H2ak9C3hyGVOxTWIL9tnGdcbP7ZLisa080VYIQztgrRULwU
         3x33toZSucOJJrerM/lRBThD0Yrnu3ljUtk6hNKQ472bcl2y/c4pCThm5yu39XD55mBb
         niByWu41SxqM5yiNZTbbaqzXe1qTuEMWFzfk5Cd209ZB76zHQ2ybfxGDc7/ECGiECnQB
         3jxXnr+pebb+yLWg6fqJ5nw6U60JIewdWsUeXYjuP4XVNhUDAkolvrRzoY1n0ub6jDzf
         2/ROq+3JsO0IcxROweqSJP6B48GZ851MtwILX4L0+iH7itQDwrqEewTP4ORvC6Y1zPcb
         FyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759368055; x=1759972855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z41QyY0n4HiGjS42Gcj9FbnEZ55TMO+9hpoyZqI1VgY=;
        b=JBA3mlqwr6n0T6m/qeTGeKKZ0zgQehUVxV2zzFv5kqv4TdVPh7ngqeGZrd65c5poBo
         kmGfb7j3ha33uTHaRN5g8NPey+LTfT1hjqupoPwfklB3gk2yivpT8TBdXjVcI37xHPQZ
         +drKsH+FX74rtLnvx8NsLrrBALD//S6Yb0UYWQtSEhrhTB7zieTx1sJ6SPUJV1CwVzZr
         ZIFdwcdW9/5pvSEc7MLtEMy7OqI4YnCeEGfErp2qgBrndk7+x6+ovcw/ULjHpJ8bQ69D
         2DJenfGazHqnDloJ6zs9pJ+rdQQ3z6iOvLoQliqSOzM+9abTw/6DstgBR4eNNSHs3w8s
         esRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+5fooUAjwaAQfikQ+ofOmB30bKwOqQsirxkTjESRrkGH9HZjoVNvsgp9KOAbCU4EybqMxGtty35Ah8Gvys+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeNz6t4GaxZa1waeOjkM9jeUtxX7WwL+nbScy2MU/zKSl0ldVn
	AetCuPFrSLLUz2RuNxbxldoR1xVY2A24cOJ1lxYAQA83IEBUm1rxV5/m
X-Gm-Gg: ASbGncuylegtja1RUsPRpQLHHQqjZAG87ovbvT3ugz3jR8Q2Z/NsJhQOcAQlVR1t53o
	dBaMT45zpdfL+XPUL7VUC3deCjFk773aNF/bVHm4DRMzn9mZiBzUdO0mSKq6V4EKZw2472+Jb52
	uvw1YWwEA5smFUVaxcBPLoh0zPFC7jKwJvaS5bwoF9HeVLCDRhgrFR89RvkEXzYOJaPx8o5jCa2
	aqtEjqNob8vk6cvuNJJ4+5yGcyUa3RubqJT4nz0RVTQLZ8GY1w42hNDiTsYnZNmmLgmQaO7kGXj
	2ASd8ru1pSL0fjtjEpU3Q7iFstNaw81ugrrYHPZ6KaoM58CA6njGl04Ck5AsC3IOUy62R1sBecG
	PIEicGxaUVJFRnFdCQrAjDnu91PFu8lwr9hKrD0pkBXjUTZu4XQU=
X-Google-Smtp-Source: AGHT+IEHwTg9edEG0pePemjlwRyRAUMtg4MTI4M+82HGHYEB70fkCi0HpVswM/WLP3OEkT4weA8pTw==
X-Received: by 2002:a17:903:246:b0:269:b2e5:900d with SMTP id d9443c01a7336-28e8d024a64mr20075435ad.5.1759368054835;
        Wed, 01 Oct 2025 18:20:54 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d584esm8685815ad.107.2025.10.01.18.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 18:20:54 -0700 (PDT)
Date: Thu, 2 Oct 2025 01:20:46 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>, linux-kselftest@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv3 net 2/2] selftests: bonding: add ipsec offload test:
 manual merge
Message-ID: <aN3TbpJ0nOg_VkKn@fedora>
References: <20250925023304.472186-1-liuhangbin@gmail.com>
 <20250925023304.472186-2-liuhangbin@gmail.com>
 <f4f61cb1-a2f5-4105-b051-0b16427fb12b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4f61cb1-a2f5-4105-b051-0b16427fb12b@kernel.org>

On Wed, Oct 01, 2025 at 10:37:51AM +0200, Matthieu Baerts wrote:
> Note: A way to reduce such conflicts in the future is to sort each entry
> by alphabetical order instead of adding new ones at the end. Same in the
> 'config' file that is also modified in this patch.

Thanks for the suggestion. I will update Makefile and config to use alphabet
order next time.

Regards
Hangbin

