Return-Path: <linux-kselftest+bounces-4343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C88784DF77
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 12:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225A51F2940E
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 11:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EFA433A9;
	Thu,  8 Feb 2024 11:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aN7om1pw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3EA6E2B8;
	Thu,  8 Feb 2024 11:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707390675; cv=none; b=QZykDY8ZIHnQ2b+IMAdNwxo/m5JlhUA2lw1jOGOWx/nEMLTLen2/54Ltq2HLccIBRsbQvtjGTFzod1Lydt7ouNMfZ7KoPitqoxCnYjyJHjbaLViYlmUWyaAafCBl7XxF9XAfTD3TL1NaS3aRePlTleTK27g9WnXmvb9snLiSYFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707390675; c=relaxed/simple;
	bh=7TN8p2o2cm1xDIfUQsYOBcvgE0rursFvpxIIGEQ5Aks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCk0M82gLPiJDDKFh8spQYSy89oteNsb6j6I/ahuDyYiSkB/bpP6VBndsdoMbolTaWBxi2SfdlXfRMR0FI4dWcBdKbRHmCbla1WypQltAJN1xCkJtwd9tI1dnuVrSgBOWORuMixJsIXSgHEooac3/SjOsSOaEJNMqZppoG+vLtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aN7om1pw; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5600c43caddso1784194a12.2;
        Thu, 08 Feb 2024 03:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707390672; x=1707995472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dkltV/LKNYv+rODcoWYZtA6BeNijF5We+gSy0yOyWBU=;
        b=aN7om1pwk+cOqgLLLW8ttpyi3G8nIfyUQbTKoBgpI42Y9UilelUgOXF9z6HQnqBn5T
         lNNr0NTvf2YyAtP995klUhnTM6NMELHRjNB3hyvHhqOmuyumLi5NGRtATOmEgboJJLb0
         rjPfUvxHXbk+HQBra5vrYfwBX3QoqJvg8ZrQlQKLa/aH5Kd5ueuFKbSRSM30iVEgI40A
         ej4x/MfV0p8m+oSmgjztcR4uZRm9DeG5MapFD6wVr8bS6idkh7piebj8zcQobvmarZUn
         vbz19TIx/Cuk5y7Qy3CPdAYGY2s/SyunYR5pthavn5Luzl99ooiWxC29MnMbOKc9M6RP
         jbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707390672; x=1707995472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkltV/LKNYv+rODcoWYZtA6BeNijF5We+gSy0yOyWBU=;
        b=xHYohe9Ig5ohrTlAKqnusN2IjeJHwG41wAPqBUA8MQ8aMqtTCPZw/6p/Ka46tAUjer
         bunVXOGbBi2+x+pbtOJkYbLhloqewJ1mIb9Q9lyav1QMhWvGaC6VeceFLO2tpKLjsHDq
         Jts9w2er0sP4pxG2VeD/q7u8/oRGvn2iaGCdl9lbc2Ccm/Dw3bQjTTEKa0qfMfpU2n12
         l/yT2sM2JqQ3fa7BkP54RGbQS4ZjwcD6LFAxFKC52OgqImvLrm745eqG2+20QY6cA92A
         NhZ700SAI74uYd3TEms3cI0WeI+jAhC8Bp7WLHfnRv0fOSYHNZ9IIxrZkL3E8b8u5V0e
         lNhg==
X-Forwarded-Encrypted: i=1; AJvYcCXkcxON69Z+Wv/I7EZzORwjGnwK+RjBOOz86DAopPlpcbhvI0f4xyyZvQKjILpLtWCLnvGSwwNY5cktADWMGskh4+2EanPmtHLGgpGDFltbmTIef+6Fe5ceGdUQ9uVi3mdrP73pdaHvuBn/Ajm4bn36qHHIA/EvV2zwG1LXD7sDI9E8kE33SlSG
X-Gm-Message-State: AOJu0YyvDzD/5AxYl9iHHs6oJRH5isWy3yASXo5Nn/FBbWUrp/Qmg3qx
	ckvSe4O//eFqtxwCDV18TPGZ5Qlc4s5lnTc8PV2Sajb0PRRn1NZN
X-Google-Smtp-Source: AGHT+IExNxDbHcLYVVbVySRZGWORe981ejf9nZ3Tj95iByf6mv66AIx7CnDeMVaPXJhy3hlNtRREeQ==
X-Received: by 2002:a17:907:3c25:b0:a38:551d:ff1d with SMTP id gh37-20020a1709073c2500b00a38551dff1dmr3401759ejc.73.1707390671390;
        Thu, 08 Feb 2024 03:11:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXIhbezgSq5pUviM5QD+tULi2vsu2weRt7MQTg2TgJ07ngjjOJj2myeyRzken1n6fgRGqMxQuVSeWNVHbvNA4qZZkJP5O/4hMsxgB3XpN2KCcAWtD9lcTad4awznh3Xqt4ONHoYS0rDhhPaxkfjDiiDtEjZtJVj2CtihTCLpzRmfVIwJYZPl7WpZhDlfR4tsHMLVdSNVcnWuFOCxTgg7hsLE65KG1isAtpZkVVBw8unjAL3e0K2ZBE6MU/ACqLVDp9MJ10rD+ULDsaXUi0r88hfdVl4+MPZCZMXUtgMDpG3zYs0JbxO8oRf0FWuPoswdq6Xipmo3r/7f3fty7VT9jFncxgKRCGYlVTNWqsLzFZlqzk1m7G5xn7DvAfMZmhu1FmODnVJilkxhvhZq3mUJowBW2sLJXHWDXoe+P8J7ETFz6l+4D1sZOk+3Gyi8950ePUVEV3muF5wNZ0nVvgPIZJTq6pNIS5Reyzk56V/fUsBNWxlXHrpiNf45bCeS2F6QIw0wEAmqYE2TFq8d/7yvclqvlqSXL76FGWOHf2jpRCxk6d4meLQyMLl6aLrjST2FHAm9eJHC/TsIAU4pih45hZhIXSxV2I0NvzIJeZXJucnMk3nC1Kgbc1DlZDiZXo1LVZJyBvYLsotP8OqKxUWPUT+9hlgDYhZXV0G507luAa45djJWzzzRpzos8L9XpBjyIoEI/8twbxUL0XnKTyvp2mOEpDO0N32RHTH302/hDy8QTwvDaeSBCdfW2JM5+AHWONdNoT9spayByfZYKzpxUGVeqlqHZQZMImktsG2ZR8Tir1C5H1Y/Ef26R4Hpg==
Received: from andrea ([31.189.46.254])
        by smtp.gmail.com with ESMTPSA id oz14-20020a170906cd0e00b00a38620c3b3dsm1777453ejb.198.2024.02.08.03.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 03:11:10 -0800 (PST)
Date: Thu, 8 Feb 2024 12:10:52 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Christoph Muellner <christoph.muellner@vrull.eu>,
	linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Anup Patel <apatel@ventanamicro.com>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	Andrew Jones <ajones@ventanamicro.com>, Guo Ren <guoren@kernel.org>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Will Deacon <will@kernel.org>, Daniel Lustig <dlustig@nvidia.com>,
	Brendan Sweeney <turtwig@utexas.edu>,
	Hans Boehm <hboehm@google.com>, Andrew Waterman <andrew@sifive.com>
Subject: Re: [RFC PATCH 0/5] RISC-V: Add dynamic TSO support
Message-ID: <ZcS2vDZjQzDARefn@andrea>
References: <20231124072142.2786653-1-christoph.muellner@vrull.eu>
 <20231124101519.GP3818@noisy.programming.kicks-ass.net>
 <59da3e41-abb3-405a-8f98-c74bdf26935b@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59da3e41-abb3-405a-8f98-c74bdf26935b@huaweicloud.com>

On Fri, Nov 24, 2023 at 12:04:09PM +0100, Jonas Oberhauser wrote:
> Unfortunately, at least last time I checked RISC-V still hadn't gotten such
> instructions.
> What they have is the *semantics* of the instructions, but no actual opcodes
> to encode them.
> I argued for them in the RISC-V memory group, but it was considered to be
> outside the scope of that group.

(Sorry for the late, late reply; just recalled this thread...)

That's right.  AFAICT, the discussion about the native load-acquire
and store-release instructions was revived somewhere last year within
the RVI community, culminating in the so called Zalasr-proposal [1];
Brendan, Hans and Andrew (+ Cc) might be able to provide more up-to-
date information about the status/plans for that proposal.

(Remark that RISC-V did introduce LR/SCs and AMOs instructions with
acquire/release semantics separately, cf. the so called A-extension.)

  Andrea

[1] https://github.com/mehnadnerd/riscv-zalasr

