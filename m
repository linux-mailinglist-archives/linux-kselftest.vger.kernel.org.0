Return-Path: <linux-kselftest+bounces-45875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2909CC6AD8A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 18:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6408E4F5B28
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 17:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46ED3A1CED;
	Tue, 18 Nov 2025 17:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fStEeX8i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2986D393DFE
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 17:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763485430; cv=none; b=VMVZiZ9Zt9Yab5FNGmLn6ezEjtRRyrBXZVmIimy3YtfTpS4angk0u54t+u+ItOXE29OWd6bYZXDTLXTP3LoIwYknCKuJ2zi+1TVc7zdjEmFwYNCWWD+EGSiLby9TqD/eP5lXQsZZ0K8uFk2tS+4qSNK2fNrxx7AcRjet/sctrNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763485430; c=relaxed/simple;
	bh=51cj9zyo4AJIL2wDmFJ6SWh28X7zA4bhpBChfHPXGBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFFD0DQk1HdhMBVFXEEcG5qDV04ndy7AFyshJpkQS8f9HOLk3PbOfnQK7GJi/V5ccF86RZoAqVo+DKxeG+tTXcbMsWf4cNwAJCqsWV8Xrc4KOYntV2h1YdxD/xjJWJfL6NxUZDZEp83akfVQVAAGPaXVUq4Lxu7gMyf6i0R96kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fStEeX8i; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-343806688c5so6166993a91.0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 09:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763485428; x=1764090228; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CvT3yUYq4hrxMRho5Iv8PoiK/Gg3Fovsi24MWBGpqWU=;
        b=fStEeX8iERT9AkSH9NYRgLtGlRRyfw6+cFFiL2BcXxgsZv9JIxhve/jM/8u+DmsmSa
         NOb84HEgfdF5lKRbdfWz+D6vZplThGBYAYndtOU8fXdxtrjHohVCJi4uW2sWyzO2rUWq
         yLvT/4hDWZaYr0bNt7G65ElCFnAIczrqMHegMUUwGVpvLHjjxO3yjgqvSbQYbJJvwx1i
         6liQrQZhBYpS0WJBlkJI2StM4psCSYkBVlReHcyGTaf/eldZclSHoqOznMWOaOVVZIYH
         qBJ2VHHAdstVnGwEsXfGoOTaRJNfRucaRuIpKkO50ak4ujWB26hbycz3/HB22tagvG4C
         2Ggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763485428; x=1764090228;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CvT3yUYq4hrxMRho5Iv8PoiK/Gg3Fovsi24MWBGpqWU=;
        b=lj9iEjsldFhpexgHPSCxnG/8FNpQeSikHttjMBAeIaLy77yZP9HeLpLmTxLgIqTVBy
         p8TS721yMKJhctTFRiUqWZ4UNBqov3gpCY4zV4Cck3vJJgz0Fpqwa3Jd50kmeCKRZZIw
         8B1v/ET1I6HHlAyXCzTe2Hofgyh91i3xJfJgwNAH+x/E1Kayt4anjOTvUuFmKXLR5r+w
         flICaPnD9i2u2U4HSs4d3BB1l2GJWO+NG/gHXr3KPedAEHXhsdWEYey0+7uFLMzuEh6u
         SJmS5BWVnKuQE7qwlF7b340rVaKLolwYeNupJNANM6ARBecxPiTjQEv/wAjcmxporRC8
         WmTw==
X-Forwarded-Encrypted: i=1; AJvYcCXwwnAT7xaNXMRNYrEjIeq9hPz/TrdfVLrpxZ/oNSn+nB+oShFejPLmFqipfjked5qDEAaNQW3/jSR43daN/LM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeE0H82ArwsuWPqPQt9rZtHQ4HlpSA18X3WwSanJASZalVR3eQ
	nmHxWaVCZHnJ/8FVlAWGVXODpUxjKIIDAhvQfQGVaKdQ5Bic2YSMZkzJ
X-Gm-Gg: ASbGncue8fjUY1m+YHai1sD/XOzmpE06yBSAWXa7yszp27NYbMleRhrIRHBvVixtjXg
	KjbWlNIz76kPG4PKu6qezK1DYnXi/qeT61z21PiRsBvOC/zOpBiY284KNq7l45uP6OnFxZktS9R
	UXA9TK8HW1CoZblDUIxz3ylMaApXTYZYklePqDgmihPcwoWU2V3gX++nN0edO9Le6czpQ+Ewuao
	KN2K4G+3dvFPmk+1k3fedOyTxi5JBsPgIfVvqoUtgEXH0empoMaWqbdYegNDdNJr3879GEbu84u
	P/GRREOiovPLGYKW65xr2zusQnmetbysVi3taLX18zxFOoCRveDNWJU4HIn+kFrzMGYKWLg24D4
	JYeSywbrBFBfDNZiVyT49XMjJzMePnePvS6jH/ah6ywRUkg3WUpiRZ1KDm/8h6G/u8HfiJm/buV
	IJ3wxAR2Jzy2VgA8QX6izj78BWLU03E4SIoCIZ2gWSiJW5dufv9Ww=
X-Google-Smtp-Source: AGHT+IHZYJX1pCWD/N46OSg88wwDwy7LwVqzDdC+rriSUKMZoZSIslmtB29azG5vTyIlze6Vb+SWUA==
X-Received: by 2002:a17:90b:58ef:b0:343:7714:4ca6 with SMTP id 98e67ed59e1d1-343fa62be93mr16111610a91.22.1763485428213;
        Tue, 18 Nov 2025 09:03:48 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36db21a0esm15420005a12.8.2025.11.18.09.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 09:03:47 -0800 (PST)
Date: Tue, 18 Nov 2025 22:33:41 +0530
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Darren Hart <dvhart@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kselftest@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH] selftests/futex: Fix storing address of local variable
Message-ID: <aRym7c2crY6rmyKN@fedora>
References: <20251118162619.50586-1-ankitkhushwaha.linux@gmail.com>
 <078950cf-01d0-42b0-868f-15096afd97e8@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <078950cf-01d0-42b0-868f-15096afd97e8@igalia.com>

On Tue, Nov 18, 2025 at 01:34:59PM -0300, André Almeida wrote:
> > diff --git a/tools/testing/selftests/futex/functional/robust_list.c b/tools/testing/selftests/futex/functional/robust_list.c
> > index e7d1254e18ca..d1aab1cc5a37 100644
> > --- a/tools/testing/selftests/futex/functional/robust_list.c
> > +++ b/tools/testing/selftests/futex/functional/robust_list.c
> > @@ -510,7 +510,7 @@ TEST(test_robust_list_multiple_elements)
> >   static int child_circular_list(void *arg)
> >   {
> >   	static struct robust_list_head head;
> > -	struct lock_struct a, b, c;
> > +	static struct lock_struct a, b, c;
> 
> I believe that the right fix here would be to drop the static from `head`
> declaration, WDYT?

Hi André,
I have tested your suggested changes.
It works fine. will send v2 patch for this.

Thanks,
-- Ankit


