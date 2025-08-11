Return-Path: <linux-kselftest+bounces-38649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA9FB1FD62
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 02:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E9B164F13
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 00:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A57158535;
	Mon, 11 Aug 2025 00:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDc62sLc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8CCB644
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 00:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754873520; cv=none; b=thN9LYVi/bdVVH/fEGu83KUfTZF3RvTCGjlvTJEu9NzYQhSCqEEc8u8tCLv4QD1Hfp+V+NjezNyQGicDmZSna/s9nrov49sh2yXlC6JyYpoCCz8lMzFJgdjFq2e7zS6KZehRzkh/Ke5IRfgfTPD9/MewDHWCFxP3dntbxCoBu6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754873520; c=relaxed/simple;
	bh=e1uTlGkBo8Y/5DwsXovlCoiBDpCkQW5dWWmsPXOh+oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8X+W+9ZZrD0tTf7lcwnK5/ll/8+tzGAQgYy3b+FF+0nj+oYU9q5iDwqHKdgyu66CeZwAi6OQe6O805Qi0ygpn/3e0IMA15hLAtXRYD5iMxF19Y+vvEVjH0DJyWIUutFwOKTVThCm2VIfN7KtQoDY6KafK5/Gu1LYBEuSvDg+Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDc62sLc; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-af95525bac4so695974566b.0
        for <linux-kselftest@vger.kernel.org>; Sun, 10 Aug 2025 17:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754873517; x=1755478317; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zv1IJoqgxHSXKcjtgFeyhterOz3vH8r5AnhGfX89cOc=;
        b=UDc62sLcGUGTWJ+dxo4RBpjXjgTB+sg8hLOIbLbhTBhomzXVKL4vekSDrsgHJwr4oM
         EVVTr19v0ro3epCCQA8zkomS766DxdcQfuw9960eyMU8uw03NHgmaILau3yDTpm5boW7
         T1TD5MeWBNOaVqTo/isXqTQTRAq++0KbB5AldVvFNOce4kNFNt1iAnho4Cf79iN0pvAC
         lxJJQb85nrdfWihV1jc2nVhrLRiue/+qFSfwU7IZhDu/f7Kkeb/WKl+LaLRJS9P59rBL
         OD211f8A+I4Z1PsRHAYLqiyxU2ywyd6dCblrdQAOiPidUos8MAm+4sYiXGbHhPZoGI65
         edNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754873517; x=1755478317;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zv1IJoqgxHSXKcjtgFeyhterOz3vH8r5AnhGfX89cOc=;
        b=s9b/+esltm8y2KDyO6lkuuqr5k5LmrEpstsXIdEmiqHT3ZTKBR+jf+qf+VLxJRa5pP
         vP/QcMwLCSqlXUyCnkWkZ/NAhiOsfOBtvETrGcaWH/Ln4KBuh3VsXd4vPJbcdbA4O8hS
         yrn2O6ZanjZX7hlya476cWYYWZDsKOrxmVUqQ9cBNKIe8D5Jeqlx/O0o2E9bnWiVTdMt
         m329zlEl7OSyEKRnrEnv39VMdT/G52FM7Mw2ZvxEIF7vlduNw3ulyAyTAjowWonSsBrr
         namVWDUzjpAGTc0/GgPo7to3CT0h5ix5yqPY8Warfr7epmGmt/0tFTNl+5G4xvQDSQqK
         +DLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrokcsCs4lyKKyVYRuvUna0wXqlSjCdB76zHcjTjHPkix9RSZf9GRgjZHGwwEMecuLNG/gaGMw6MRTu/WBEiE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+/N6oobZ44Nz59dIKSxsf9PQY5XIGYsHrBKvzVAhBXssULw+l
	ny4+PzKGYC3pxTWlCca0Fnskt8RdynKRpIocg7VprATA9dUNJDZui0Qi9X08PXGx
X-Gm-Gg: ASbGncvhezDEN33ypv7FsZkpRWT28lsrQVRSGQD4wTyIaavqqO3ImMc7PzTrC1ws29d
	vN3HI0ZqCZ3Rq59SdqxAVYu3eaMkJmykfibuSfCgZoclWpXX4vOkzZo4W25FmTzaqAHnQqQwsk0
	HcJ+UVxaipiZf37BJc8ekLp4kTZtb8UnaWm/dei2DCOo6umqP5pObWUh0sF4hvktFmzkZAgbeDE
	wC6tCNyR1r0ujXdjbCglpxb+84F9gF4IHNCSmzuffhN2SbniozKPjWyFIlffzGl18qBZULAFPPs
	u69QweWdSYDN5RgMGKUUOKi073cP18vv3lEGZz67go6sV8btOkRWpJyHXMTwKyd5Dj/YeRZW1Vk
	EOM5WSzxfCiwE4kkj3wnwqA==
X-Google-Smtp-Source: AGHT+IHmYldaSBeO6dV/S7Yiju4l+VlWOSTR9stI/72nkU6ACRnZg3Ldx8ZoStARl/SNqNyVBZrAEg==
X-Received: by 2002:a17:907:940c:b0:af2:42e8:ad92 with SMTP id a640c23a62f3a-af9c65b2f50mr987442566b.61.1754873517397;
        Sun, 10 Aug 2025 17:51:57 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a37a8sm1937794166b.40.2025.08.10.17.51.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Aug 2025 17:51:56 -0700 (PDT)
Date: Mon, 11 Aug 2025 00:51:56 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, Wei Yang <richard.weiyang@gmail.com>,
	Zi Yan <ziy@nvidia.com>, david@redhat.com, dev.jain@arm.com,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: do check_huge_anon() with a number been
 passed in
Message-ID: <20250811005156.rbvgf4y3xhls2koi@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250807082707.30647-1-richard.weiyang@gmail.com>
 <0467FDBA-A2CF-4CF0-ACCD-760ECD30BA8A@nvidia.com>
 <207BD61A-5561-4E8C-B867-D1CFCAD37509@nvidia.com>
 <13D32FD8-FAC8-468A-9C92-23A1B61610C3@nvidia.com>
 <a1c64bca-9ed1-4d77-a838-4e74a35a1131@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1c64bca-9ed1-4d77-a838-4e74a35a1131@lucifer.local>
User-Agent: NeoMutt/20170113 (1.7.2)

On Sun, Aug 10, 2025 at 03:04:08PM +0100, Lorenzo Stoakes wrote:
>Yeah just hit this,
>
>Adnrew - can we please drop this patch from mm-new for now? It's breaking the mm
>self tests build.
>
>Maybe then Wei you can do a v2 rebased on current state of mm self tests?
>

Yup, v2 is on its way.

>Thanks!
>

-- 
Wei Yang
Help you, Help me

