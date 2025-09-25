Return-Path: <linux-kselftest+bounces-42265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DA4B9CF93
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 03:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F0D33BFB46
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 01:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E66A2DCF61;
	Thu, 25 Sep 2025 01:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAV2cPN0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0742D7DE6
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 01:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758762361; cv=none; b=QlbxkP3Dgqa/IZzV/67OuoSF1lzM+cuJapi0okx839GTquPTZueXch6abytsY7Uh7e0bC2O7hkf7OKg3blcJ9ZpPpt1ZI7EIaKNB6Cs+29sPM+pohqc7Yo58euMCZhhHInZuiPPy+hFs+bcgo+TxWL0ELTMMeE2mYp7uzG0tlIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758762361; c=relaxed/simple;
	bh=QtTNRMNsCZXoPgwJxEVdzGgxg8j9AnQphmi2AsF15T0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XDWDkr3gAir2U7NYOK0haozFlAoF/hKiAc6dGO9a5IGT7m8qidts1eEuyISoqtNKLqSzRJjaRpgZbePrVPC7+D+eKv+XIpSIQ8v3niYDaYUvQMIpGc+cjrJ4OvDMuGxDG0SI3FYdrcujPtowsUMuorGmjcd05PkaXJQUncXI7L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAV2cPN0; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2445805aa2eso4309185ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 18:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758762359; x=1759367159; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eQt75DdC8qDrtyjja2Oov+kDMmzEtd4kIyWgE1cwVHk=;
        b=dAV2cPN0OqdwvgjQSYURQOgTMkaRxCWIgeeDWW2VpXyBDNCh00+5BscRoMoeqaDk+I
         63bemuscX+Gvdhi9KklvLwtO4gIAOf6zI8RaInjV7VUEYS/CY73W9kt6LgRc1xvOP6rm
         U9LDCXC+HCAqANPzvdWQwrh6JSQ6wfOXml+L7rDVDN346WiUVb38VO5KyLo/GE9eSnRs
         M76fOW1kugq0J8/9nVuJ7UtzdhP3ofYEz58Q4x6EvaU+eZhMEEct5zMKBOBzO4HzQz9Q
         d1sRpL1/xuB+O5acvXT8CdNy4eSjAWqhp3braJHtYNOCwMkVazk5cQQL+Q3JRgeS7Bd0
         kb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758762359; x=1759367159;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQt75DdC8qDrtyjja2Oov+kDMmzEtd4kIyWgE1cwVHk=;
        b=mAhhabhbnmTIJl2I7AnYFYNvEbp8M7+aWnFrLs57F6M/LHpz0grMagY1BVgT1doCxG
         aER2IgtLYvb0wWKuo3PlcPhSW2Wmie3g0CoMJqje8Ugl8f/6m2IIOg/vOwxZwC0a1LTr
         4LILTTdP/uSXs3sG3nkFx4pt1MyTWo41PyJrNPhOdu5Ygx1yI9JJPMxLsXaG1hGstkC0
         vlWWAVDbtCy4nHrgtG7wT+DiXRouEDq2RnSgyibIdYRZSVvRQfhhgwmbIEtwtcJzHITX
         rVFVAOiLNrv+g4viIz3YFpKwJwjl+cGrUxhO8fKKrHsHbLA3p6SxY5Tb2Y6l5IXCvbmJ
         7jYw==
X-Forwarded-Encrypted: i=1; AJvYcCUj5y9FXHZ4+8TWvrhEuVH26vx4/doG8McRcLhJ9vwvI5i98bCX+ay8uiQR9Kvc3dh4/K6HU7GznW50zxJFViY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbMuf6jmmu/H+qqd+jOxToGETjb9qC3fIUu2iGqIS4LdIXAoEF
	nhdCOuosCAoVD9+KRSJkYlGyoHUjoQwlYBlAHLFfxRNr2ggacSdGRJGR
X-Gm-Gg: ASbGncs2rsjnQ/AR/4JbI5nElofS5QvNUY4TiN8yJwhDNTeMP7SePYY7bnnHevIZ94t
	T8IbwtLlCKEI0A88uv8oUpZ0E125aiqYtiRx4Qtuq3DWhUieGEzgoYFTTFm/giLdvynJ6a3fTow
	EB6doBF/j4VeUZPwV+tRraSwPw2DDKzrK9dp8x3NQip0fsKgBIlSfx7OJMdgTNaoQ51g1ThqFYm
	bu+cGId56e7kuHVKUcdn0RUmS6/pPQKXV3P9MS0Yq0eVMu5UQGFBgI0grlLPSaNQ+xoX73Z4FrT
	hL9+aX4KlpceoXFpKAac+RHZgi1I4LHNJm35dtLzXawkbgc8VDr0y0OiwsjoTC91fETsaUySJ4I
	Fu4Segs7MbJ8eCpqRPaEottIK0ezegnpkxUVZCpEYlB09nNMHfXBoInOv+iTdQvc0pi2WEOVm3D
	qDKtkn5OnSdYI3ilFpVHcCRbDZLw==
X-Google-Smtp-Source: AGHT+IGwHElmVODhLjzcGQwYiLLF8PustJQtiHPJXl154Q9y4nWgofjfbBNw4V3dkvm+lgwYi65hdg==
X-Received: by 2002:a17:902:f541:b0:248:e3fb:4dc8 with SMTP id d9443c01a7336-27ed4a7eabdmr16878415ad.39.1758762358734;
        Wed, 24 Sep 2025 18:05:58 -0700 (PDT)
Received: from mars.local.gmail.com (p958197-ipxg03701okidate.aomori.ocn.ne.jp. [180.22.82.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d3ac4sm6088475ad.5.2025.09.24.18.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 18:05:58 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:05:53 +0900
Message-ID: <m2plbf734e.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: w@1wt.eu
Cc: johannes@sipsolutions.net,
	hch@infradead.org,
	benjamin@sipsolutions.net,
	linux-um@lists.infradead.org,
	linux@weissschuh.net,
	linux-kselftest@vger.kernel.org,
	acme@redhat.com,
	linux-kernel@vger.kernel.org,
	benjamin.berg@intel.com
Subject: Re: [PATCH v2 00/11] Start porting UML to nolibc
In-Reply-To: <20250924033217.GA9039@1wt.eu>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
	<aM15eChUObXfxLzs@infradead.org>
	<4354d88c2ff7a57a7324cc39b4ce5ed4ebe5277d.camel@sipsolutions.net>
	<m2y0q47mbs.wl-thehajime@gmail.com>
	<20250924033217.GA9039@1wt.eu>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII


Hello Willy,

On Wed, 24 Sep 2025 12:32:17 +0900,
Willy Tarreau wrote:

> > just curious
> > 
> > - are those issues not happening in other libc implementation ? (e.g.,
> >   musl-libc)
> > - same question to nolibc: is there any possibility that nolibc will
> >   evolve as glibc does, and this evolution introduces the UML issues ?
> 
> Nolibc focuses on early boot programs. That does not mean it will never
> evolve towrards more generic usage but this remains unlikely, and in any
> case there's the goal will remain not to degrade the experience on the
> original target (early boot). That doesn't mean there will never be any
> breakage but we're doing our best to keep things in a clean and workable
> state. Regarding threads, it seems unlikely that they'll arrive any time
> soon. But if they did, assuming UML would by then be a long established
> user, we'd certainly find a solution together (even via build-time
> defines if needed).

thanks for the detail background of nolibc.
I understand nolibc will evolve with the carefully considering the
issues we faced with glibc.

> Hoping this answers your question.

definitely, thanks again.

-- Hajime

