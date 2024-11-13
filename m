Return-Path: <linux-kselftest+bounces-21960-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6C59C7A30
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 18:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13D43283640
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 17:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30841202F80;
	Wed, 13 Nov 2024 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fh7hERuu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE2B202641;
	Wed, 13 Nov 2024 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520022; cv=none; b=gzL1IXKrAf564tdXMxCMbi22U7V8uKm2DFTosi6Nace+lrwlLA+ncvHXFL3nDyOddiws4qQftowLwEQ0edZWRzxIg1OWrl1O0xJF0xyfeN/J5BWGPmiIp6IvbnDTQ4qKsOyeCEzCt/BFr2r4Lk610wLQQr8LaS7ekXvvgZ2PVYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520022; c=relaxed/simple;
	bh=TdopnMjVf6e1oyxe85x8iupGX8z8YRMU4vXP7J6L3S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9/VLmXzobF1QbEw8sQ83sje/diEdQoeXE+vhrllpZLjcoP4owg/6iWWYxDfTZ15H+KZOvezaC2xyDwehFQTUwYpZP8soIPVqWJyKHnls0J5rO4FD4TR+h80aXrBE3uHWlOlHuDP1HGayKl5I4v7hG8TLEk4CRXj6Qo6iqHoWng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fh7hERuu; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c70abba48so71130295ad.0;
        Wed, 13 Nov 2024 09:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731520020; x=1732124820; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TdopnMjVf6e1oyxe85x8iupGX8z8YRMU4vXP7J6L3S4=;
        b=fh7hERuuYiau3EJYl26hXLm27R0dk1O4ZwKDMjHwRBO17xfBwNxCEJ5X/w3gm4/HxU
         jqDHPfqa5buvWLONdwQaa16/fPCPb4H572afO4fzUwdgAUdD8mM12Fn0xzHOeKjYJkBi
         gd89fCYBbxOj8P0fLfcaS6cqbc1rTci8YOX9WQ2ArtVEZHUwpvEdXwR9DNPGx+vSsxPw
         7ItXebeT67Iab6DuTxdJS2wmVVaUe+g8SLTCBGo1mWPzVU/1hmCbQwzXGqGgsozAi2op
         QjdD11xf2DQGZmTiSpoVnp3p2rPEFV9v5SXSNGU5ZccYDdc4kkoNieB3KeBescKrAE+Z
         O6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731520020; x=1732124820;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TdopnMjVf6e1oyxe85x8iupGX8z8YRMU4vXP7J6L3S4=;
        b=WjtboUsumHyLCc9h9mACnPl7D41Vzu4AHOPppUKNG7m+HnQwLHr5UjWJzYW7dBYeN2
         YVFlCHOlmJj9bir9J54Z5VUxHid/lJ/odKDN08tIuYmNKzsefY4+qZ+1LKZst6xpOoUO
         dViAd1pwPNTqOo0k3znoCOh2eu1AnVmMn1ZYholBc5PnqS6nua4dYABH7KISOKMfmuIW
         5XYkHPECdUtxSWd0CTbnZF39ihzchDrGzjChwUkdoTJWSbAfFEPjcEVmdpddEb8Q27o7
         apc8zkSB4Kf9x7YlRomllQ71GEXNMXxdQ4jdwxk0Yqf6w9JUQqrtkz33vIn4oFQD8wn2
         F9Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVTuivlI+O4WwrV6zxlQ+OGmhi8fdIy7a7Acug7/OxmLbKqtcMQGEdcDmqtTmRXWUaX6Hfnfo5Cg+5X2QJEWmM3@vger.kernel.org, AJvYcCW6uQ5MNpQd9P5LNNMUB6YwE/m4SA2O+SEQwJ9TIyavmtOrrpCU5+AJYYmcSLzyqZnUVQs=@vger.kernel.org, AJvYcCXpGHf/8OW+m2KTPEr0u2hqWnZufz1la7h9kJPHKtbMLCIssp6XDDaB4LEWPD0gmi9AoSoPrBqltrd66FUf@vger.kernel.org
X-Gm-Message-State: AOJu0YxnmACXgqMpshLNX0URaKVISFbu1oWHLzTPVs5Ix9cnMAS4XeuX
	LqbjIiGclIdH95jbBxkVSDap7he797b1TsCFViOb0je9QkbqfNs=
X-Google-Smtp-Source: AGHT+IFDSSAN8qtbqTUOdypFJgOKjXPRRSQT8QpCWMn0rJrf7Dr0W7xeGjgtY83HAyv4wx20T/RxXA==
X-Received: by 2002:a17:903:40d1:b0:20c:a189:c006 with SMTP id d9443c01a7336-21183d55546mr282351525ad.45.1731520020065;
        Wed, 13 Nov 2024 09:47:00 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e44807sm113065235ad.155.2024.11.13.09.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 09:46:59 -0800 (PST)
Date: Wed, 13 Nov 2024 09:46:59 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Alexis =?utf-8?Q?Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, ebpf@linuxfoundation.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Petar Penkov <ppenkov@google.com>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 06/10] selftests/bpf: add gre packets testing to
 flow_dissector
Message-ID: <ZzTmE81yt5TXlfWj@mini-arch>
References: <20241113-flow_dissector-v1-0-27c4df0592dc@bootlin.com>
 <20241113-flow_dissector-v1-6-27c4df0592dc@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241113-flow_dissector-v1-6-27c4df0592dc@bootlin.com>

On 11/13, Alexis Lothoré (eBPF Foundation) wrote:
> The bpf_flow program is able to handle GRE headers in IP packets. Add a
> few test data input simulating those GRE packets, with 2 different
> cases:
> - parse GRE and the encapsulated packet
> - parse GRE only

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

