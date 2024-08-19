Return-Path: <linux-kselftest+bounces-15698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF31957478
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 21:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877961C23ADF
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA662156861;
	Mon, 19 Aug 2024 19:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n9MRhPyV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1218143AB3
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Aug 2024 19:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724095929; cv=none; b=UAkPFWFPsNol5IAlBoxjUUR3qjlDUMzYpIL/RHhYsBORtJy8okeQccO42zmJ1+0JwowDdjqdaGvg88N8J9UDksKo39wlgHbZVGX7u4TMxg6gDLPfVwZ+xf8edaeQANgcU4YZfe/fzwDI0O+OzxYEDN6qA7jtzTZe9f+OFz5dYak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724095929; c=relaxed/simple;
	bh=IBAIrayjaY18zkCGKENrwSI+bJswIFyqRGdQ10te1bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quCL74sPCx0J1fa2aAFWW5RcZ7XWGLPqyfZjpsK1halB598VdgtRkr/YiyMw/Bb4QS+OerR1VXeQ4l6BbCNlRaVW0tiHZDN7NGf/0WvwCnH+NuVxItnphbP4ZXocpIPyRyH1CTrA2WWJ0vrBgXBKOSFGg82hVO+1PmsR9TC0ie4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n9MRhPyV; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37198a6da58so2551030f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Aug 2024 12:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724095926; x=1724700726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5iiMQkHuMqh6MeejOMXk5KhRCfXbI7rErK/gftektqc=;
        b=n9MRhPyVEcR0yNNTDntX9tte9sLTfM3bpUnP2BdldC8QDyMEdhmpfWbo99v1+LjU6b
         U1DYrtVykoYfiF8UOSH/C4MWt423oSkur3m/CZGQ9RR6/PQAh3D+M5HL4xpJssFWuSUX
         G7Af006JIvQ947PgacsYEl86XeDiqSIA8MKqUc+sPc1krnaajd/voR9w7xCDefKnq+8u
         Ryezbw1/NV5mpW4hAWVA+pyo4lz0GQ6oeGD0AjQo3A0f8j1J/9QfhlT0pYkNKjlwOl1z
         Iu1ohhyRi45by0Y2aJln0Ag/78VDkxs2tFARZ5wyx1j0arbkLjHO3DY/4QlfMv0Z/4jz
         B1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724095926; x=1724700726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iiMQkHuMqh6MeejOMXk5KhRCfXbI7rErK/gftektqc=;
        b=kG00WEVwH8jW6aJcoLvFLyukMK/1DbjNThfmFhS9y9YJ6veUS7L1eQACchKMTSLcc4
         z/U7rwFTl3UEMcv2UfHn+qvNw1niI0rUQf2LzIpVoT5bU3N0M4XK++1mSplpI7avGYsb
         sihpLbeHdwdaonIf8iQcqPi4S9gl9ZTos27M7mSUaW+AiUXpg5JcPaMexdzLSNEG6nVt
         v9nG7qXaNfeQsCLrX441IlyUVGjC08ZNqXEYiO2bhp3GoUbCohrAqNwsYcUvVCaUeOcr
         gGYtnn4LFJ8Qfw7LB9YBYtAHmcocpLyhI7fW/qmWGL87IAoPR3cOU4d5/iB3neSPcJHE
         IljA==
X-Forwarded-Encrypted: i=1; AJvYcCWZxcWwbznUu0SmJjLgug+HQ/r4QC7aHMPHp++RVErz0SoCIKaaf19Y47cabOILnrknAGM2Wb/0f2QOru44PMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjx9gl+tfajQox9vq+5cM61ZwQXqPlpvfMah11NTznALn7NVjy
	J7frR0t28DLEuUDRfs4VYhLpsLHDP8pwPHJ0u9SAdHx936KP1uEmOQMYER/68+Y=
X-Google-Smtp-Source: AGHT+IH/2vjG/GUMc9QoF6wDq7bU/JjnmIsBM8wYayWWOvJ0VGi5nf8rUXn3/4LsR/hkXcGyc0ZWkw==
X-Received: by 2002:a05:6000:185:b0:368:e634:1520 with SMTP id ffacd0b85a97d-371946c2fe0mr8845522f8f.59.1724095926195;
        Mon, 19 Aug 2024 12:32:06 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718985a6ddsm11233965f8f.58.2024.08.19.12.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 12:32:05 -0700 (PDT)
Date: Mon, 19 Aug 2024 22:32:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [bug report] selftest: bpf: Test bpf_sk_assign_tcp_reqsk().
Message-ID: <54f8f67c-e47f-4da7-9172-d17b5f656587@stanley.mountain>
References: <20240819190705.23030-1-kuniyu@amazon.com>
 <20240819191413.23841-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819191413.23841-1-kuniyu@amazon.com>

On Mon, Aug 19, 2024 at 12:14:13PM -0700, Kuniyuki Iwashima wrote:
> From: Kuniyuki Iwashima <kuniyu@amazon.com>
> Date: Mon, 19 Aug 2024 12:07:04 -0700
> > > >     488         mssind = (cookie & (3 << 6)) >> 6;
> > > >     489         if (ctx->ipv4) {
> > > >     490                 if (mssind > ARRAY_SIZE(msstab4))
> > > >                                    ^
> > > > Should be >= instead of >.
> > > > 
> > > >     491                         goto err;
> > > >     492 
> > > > --> 493                 ctx->attrs.mss = msstab4[mssind];
> > > >     494         } else {
> > > >     495                 if (mssind > ARRAY_SIZE(msstab6))
> > >                                      ^
> > > 
> > > Here too, I guess.
> > 
> > Thanks for reporting.
> > 
> > Will fix it.
> > 
> > But I'm curious why BPF verifier couldn't catch it.
> 
> Ok, this off-by-one report is false-positive as the test has
> 
>   mssind = (cookie & (3 << 6)) >> 6;
> 
> and the following (mssind > ARRAY_SIZE()) is just to make verifier happy.

In this case, I was testing code that Smatch couldn't parse completely.

But also I have a different check for "> ARRAY_SIZE()" which deliberately
ignores the value of mssind since I was missing "false positive" bugs like this.

regards,
dan carpenter

