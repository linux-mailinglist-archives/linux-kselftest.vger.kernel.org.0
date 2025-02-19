Return-Path: <linux-kselftest+bounces-27000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE77A3C46E
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 17:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3213B5DBF
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 16:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EC51FC0E7;
	Wed, 19 Feb 2025 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LypH+wNQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EBB1E8331;
	Wed, 19 Feb 2025 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981126; cv=none; b=TS6qz3hbDhsq1/et7kFJ2zYSLzruk/hM0WvIck4xLMJakMKL9WZfS3Kt6o0wvLqkooSRinpJv7JLpeyM1orfl5TCOtz6ONg3xZ43Fygq0q1xFZo4n9d65fT0zqUlR9lrCq5MYyAE1Ya+n85RXTFIEJyMLDnkTb3Ht98dwVnkpvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981126; c=relaxed/simple;
	bh=igAClwkfq5DcZ5TKUcEF3Pr1lpY24mUIhH6nIav4dK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMyOPmbf8wNBhYaRVR6vMtvVDXxRa7crPlVUnnb9GXIDsSpX7UJ94Ad28W+fCifOUA5SzLJOaC1B0WiomLeryKQ42NgwOQqcY3i/jdXeQT1pMtElY2fznCzkEOxxJENKlW2aDc36WgNtG39YVHvh9JJn9FmEpf8EJsjYmdtsVFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LypH+wNQ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220ca204d04so96848305ad.0;
        Wed, 19 Feb 2025 08:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739981124; x=1740585924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AYlD69kvWtpMbGvOd+NkdSH57E2XODHtfvTbFzIFAwc=;
        b=LypH+wNQF/iVpz/Di1LF2fMPeyqRk4Q2IPzUexg6sm8snd3fNHL38LbLidb6RQy62d
         r7KyeJMaLFv8E0XN7vGWh0tqC9pnDYXfSIy+6F1eutJlDu5Q/i1lsmkX5LsXBlMkCb/q
         9La3SUC1J58E7N/eoCOlppm+sZe6psaLZDAu57h1Lt+sy0zjlLgxgnY3HulfZsjiDd5M
         hUIMQYiXZQ9+Hxy4hEK48d6PEc2DLqlOiRViRMQVZyfDMZWisgnNiKlHzgW1esdS0qNX
         EM4rwn4Kb5qSAWtsuOSjtCrciyLGp9HgzidWKX6Tg60XWa4Bp95WC+q7HKXN/jSkvnkS
         9hSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739981124; x=1740585924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYlD69kvWtpMbGvOd+NkdSH57E2XODHtfvTbFzIFAwc=;
        b=B1nVWmGlj3wM1tN+S92btjMesEwFOB1ivnO+yVmtqejjoZ/y6OHTOaY3U0uPVpROyw
         9Aj/NlpxcEZeAohuNodaUWW5ShHzbcFrdtI9G16J+qTAxXj95KlrulsSgN6cGQmPX+qo
         5SXmQY9chRPt986hcWaS5odIVHKqh8wkTM3KK1Tdt6pDDbZQWcZp/NVk1Fg0b8equoK2
         i2M9dS90Jm+jXnivbxodJahLS66EAK0c30ICx2E/nOGCWawYkw6bqv+rRi2VG9zlxVGc
         qq08STHNwsXcwXiwkdhTerq/FPrxL9SDfmlTaLlJTBV9JgxQccxAfr3wBqGFNInG0yc7
         uYQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpodOtjynzrfUlOJUpQsfz0fRImmOinG09TEOzhE35/7Z6S9U7DfN5IxMx5I6xbSR62CglUmZya4wAzOKu@vger.kernel.org, AJvYcCVf4GR7I1gRsEPiVTSKGqQMNAgehcQMN7NV4p95zzW1hR0Q5k2jxvxajoFR8ZWSTLCMMMI=@vger.kernel.org, AJvYcCXCPPiZf2OEEagmiUjd77No04En4BKw1c1r0RAlKc0noSRSz/n481wQuKnpcFFeELgmFO6OcoJH7Ulhe4MFWciq@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvhp61mR3WAY3GOFnqGNWpONHLWX+hfSk8aEop3i3Mtqu+zCI6
	7bZj+sz0+w0HmDFZ9aYpIZApPObzA2LsPu8eBMKcMF2gackRZz0=
X-Gm-Gg: ASbGnctk/bFTN2pvnHvM/Y7kEH6GRHV0uUwJD9xiC/+pgafWYf83UpCC8IoVY40ol20
	iRPekk8K9d0vxvANTIl+K5pXaLLwd49UZwBNUDFxQ4lU5inTxpKtEWmZCzOEpSuPvwjlivLErjz
	n/ssAbXXm19yDDWnbwrf3fvTcomliJox4bBVpMc5cOKTypYDMgclB4dM7LVylotRLipcLt7+XdP
	36cDqJk7aAjTjQ6H+hO2f2KiClSCxgkGZLDhfeMVXpI0zf/Kfc0m47Q7IF7RFRW3Jai16r9K0Wj
	TkYIU8WhWWIGFmA=
X-Google-Smtp-Source: AGHT+IGBOZ+MiMfKPYNCRijM/bSC9Z7x7ZyejJBgvB4ZfzDLvfk9R42skexeGgbA7bzrrSce6qQCow==
X-Received: by 2002:a17:902:c946:b0:220:faa2:c917 with SMTP id d9443c01a7336-2217119ed05mr61114895ad.34.1739981124467;
        Wed, 19 Feb 2025 08:05:24 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d536443fsm105891555ad.66.2025.02.19.08.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 08:05:23 -0800 (PST)
Date: Wed, 19 Feb 2025 08:05:23 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Alexis Lothore <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 0/4] selftests/bpf: tc_links/tc_opts:
 Unserialize tests
Message-ID: <Z7YBQ0M_6kzC1ieD@mini-arch>
References: <20250219-b4-tc_links-v2-0-14504db136b7@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250219-b4-tc_links-v2-0-14504db136b7@bootlin.com>

On 02/19, Bastien Curutchet (eBPF Foundation) wrote:
> Hi all,
> 
> Both tc_links.c and tc_opts.c do their tests on the loopback interface.
> It prevents from parallelizing their executions.
> 
> Add a new behaviour to the test_progs framework that creates and opens a
> new network namespace to run a test in it. This is done automatically on
> tests whose names start with 'ns_'.
> 
> One test already has a name starting with 'ns_', so PATCH 1 renames it
> to avoid conflicts. PATCH 2 introduces the test_progs 'feature'.
> PATCH 3 & 4 convert some tests to use these dedicated namespaces.
> 
> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
> ---
> Changes in v2:
>  - Handle the netns creation / opening directly in test_progs
>  - Link to v1: https://lore.kernel.org/bpf/e3838d93-04e3-4e96-af53-e9e63550d7ba@bootlin.com

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Thanks, looks very nice!

