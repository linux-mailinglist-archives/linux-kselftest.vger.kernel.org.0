Return-Path: <linux-kselftest+bounces-17655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4632F974472
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 23:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0707B284B45
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 21:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987721A4F10;
	Tue, 10 Sep 2024 21:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYeSD21K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9871F951;
	Tue, 10 Sep 2024 21:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726002075; cv=none; b=fKuGf/ws9VTBb0fAkdfuKtokJnk2mpCp9vzxvrsvF6l81ESAxu3RaD97R2x7XF9l3wJ2iqyhoWLg2Mk8fdBSuTVfcmoNRT5Czab3MwBjtX2+HqlUmSWE2K54DctdWWLlXZU+3V3x4PfOjw3KK5NhSQIGgJIYaahRCr2jFLhEnRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726002075; c=relaxed/simple;
	bh=pQEzz9uu6HA47UQNtXbTieMHkKkIiD2cU/VMlkQtn0o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YdFg/Y4O4Pyj8Y05OMD7X7GrpRSqrqZWRAkBLZzcgk2fB1h1GAYSHaw4KQLwtWVGzaIW8x1Er9UCd3rpCr7F4dKVzpxZA4iwh59R9gQiIr0eJ6++2kZk0eG2Vzk1d6IeSIPNaFxkOmsKjH2CB2GIa81SBCfPM7XUojwBMiAyCzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYeSD21K; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-45826431d4bso21345061cf.0;
        Tue, 10 Sep 2024 14:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726002073; x=1726606873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvU7bPE0YTvJNd42Gq/dgA4uWVcW4I0b36sTHfp39JY=;
        b=NYeSD21KqRthg/9ftrcJ0sGNuJJ1R4MkVrTvFIJQJWSZ9bq/cfX/dAZ9ROZBMnP+mm
         5Ifb6bKo75YHZaHs2ebE4Jmb/SQf2RNgDXeyJncvIxJWBtxr9hTeUC3DloqFCNFjrPBj
         tMTcnAbdJ2WNWiq02JdpKmttmd/gLqcdLsCiiQqzQV596S65fFG2pyWMvhNDa0V+8Xlv
         0+lRqcI5MFVvQr/y8YaB4M8bFBAFvdqh5JLv/DmJICsR5mu+eMJfnQEb5syCaqlrqWHO
         +un8yjy+JJRacIRDQlilEkqMPcglaohvBPBTs9XxR4Mj1PRU+ryZlDFfnPXM3gzpA2vz
         9zXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726002073; x=1726606873;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bvU7bPE0YTvJNd42Gq/dgA4uWVcW4I0b36sTHfp39JY=;
        b=DTEPuzKaSCKN5+FKwSsabdyE8KDcCj2ZhZNUnSJY5F3m2mCnvAfDJh8OvFcVoxStrr
         l76Y1Hv2xb0zScDBM9Pv+qRv7tTT4DqPdEwSfmBiLPWO7Ze8U6i56xXY4nnYTkuQXHIg
         7iubp9XMkVl1y9g76fGL7VNQJJ/gsuZ/QjGov8kEJwAXUp5opm7FRRkN3/NlS/D8OkwM
         U7RwXJU0GoUFW+VHusIp733WM+xZzQ4Enmh4c44LLX+3YwKleDjuW5DLOaqioxeLoVsL
         kP5rSeECWOSmSMVEZy2BWkBluhjXCOboklE1Re+7gDax1wTCUjUk8SwyPQQHV4wbe+GK
         tAPA==
X-Forwarded-Encrypted: i=1; AJvYcCV80S3SiSIZmn3R6L4EpK27YkJ9GF12jgjnmFTqY4XlVEmFshUk2ilAd5XL0M20BOrfHe/3Fw2nuhM7pKg=@vger.kernel.org, AJvYcCWzIOtf9QNw5nZXVS7o1ZRcScq2VZ3o51811464RLpjohz4UauHv0QXX4Lngz4Ulql6De9yJUMM@vger.kernel.org, AJvYcCXFa9SDUQkaYvfkSn91aMTOtnj3MXTwvI5+F3ArXb8+xTuVxv8O7cR3RNH7ayhhjezNK1I1I0PSp0rh6GCpuyCk@vger.kernel.org
X-Gm-Message-State: AOJu0YzNoeZvL1+L+5NMYhidb+SnhugLKywVne0gEzTKGkrQWtrpj6gA
	R011OkIDLRZK5hJCTpuk/NuuE3LySeamr4Byocrg48Np8wxWRAvs
X-Google-Smtp-Source: AGHT+IEEWXxjvYajrj+ffBOf0TBzzuP9ICjuT1QYGYz/eU4QT0la6EvKjoLQCTtA++B22YmIXIxl4Q==
X-Received: by 2002:a05:622a:1194:b0:458:2d4a:d670 with SMTP id d75a77b69052e-4582d4ada2emr109741671cf.60.1726002072699;
        Tue, 10 Sep 2024 14:01:12 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4582fcad2f4sm22735991cf.78.2024.09.10.14.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 14:01:11 -0700 (PDT)
Date: Tue, 10 Sep 2024 17:01:11 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sean Anderson <sean.anderson@linux.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 linux-kernel@vger.kernel.org, 
 Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org
Message-ID: <66e0b39776d60_cbc9e2947f@willemb.c.googlers.com.notmuch>
In-Reply-To: <1cc769ba-c732-4155-8d96-5b40140a0d49@linux.dev>
References: <20240906210743.627413-1-sean.anderson@linux.dev>
 <66dbb4fcbf560_2af86229423@willemb.c.googlers.com.notmuch>
 <9d5bf385-2ef0-435d-b6f9-1de55533653b@linux.dev>
 <CANn89iJaXgR6c+moGB5kX6ATbLX6fMP0mUBQN=SAsZfdz5ywNw@mail.gmail.com>
 <66df2fd2d6595_3bff929459@willemb.c.googlers.com.notmuch>
 <20240909165116.1bdb4757@kernel.org>
 <66df9a6d42871_81fd3294e8@willemb.c.googlers.com.notmuch>
 <6d5ca057-87a3-4ec2-a733-8f0c1fb11158@linux.dev>
 <66e084ff8f8aa_c435329483@willemb.c.googlers.com.notmuch>
 <1cc769ba-c732-4155-8d96-5b40140a0d49@linux.dev>
Subject: Re: [PATCH net] selftests: net: csum: Fix checksums for packets with
 non-zero padding
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Sean Anderson wrote:
> On 9/10/24 13:42, Willem de Bruijn wrote:
> > Sean Anderson wrote:
> >> On 9/9/24 21:01, Willem de Bruijn wrote:
> >> > Jakub Kicinski wrote:
> >> >> On Mon, 09 Sep 2024 13:26:42 -0400 Willem de Bruijn wrote:
> >> >> > > This seems to be a bug in the driver.
> >> >> > > 
> >> >> > > A call to skb_put_padto(skb, ETH_ZLEN) should be added.  
> >> >> > 
> >> >> > In which case this test detecting it may be nice to have, for lack of
> >> >> > a more targeted test.
> >> >> 
> >> >> IIUC we're basically saying that we don't need to trim because pad
> >> >> should be 0? In that case maybe let's keep the patch but add a check 
> >> >> on top which scans the pad for non-zero bytes, and print an informative
> >> >> warning?
> >> > 
> >> > Data arriving with padding probably deserves a separate test.
> >> > 
> >> > We can use this csum test as stand-in, I suppose.
> >> > 
> >> > Is it safe to assume that all padding is wrong on ingress, not just
> >> > non-zero padding. The ip stack itself treats it as benign and trims
> >> > the trailing bytes silently.
> >> > 
> >> > I do know of legitimate cases of trailer data lifting along.
> >> 
> >> Ideally we would test that
> >> 
> >> - Ingress padding is ignored.
> > 
> > I think the goal of a hardware padding test is to detect when padding
> > leaks onto the wire.
> 
> Which is the subject of my second bullet.
> 
> > If not adding a new test, detect in csum and fail anytime padding is
> > detected (i.e., not only non-zero)?
> 
> As noted below, this is only a problem if we leak kernel memory in the
> padding. Otherwise, any kind of padding at all is completely standard
> conformant.

Ack. I actually was not clear on that.

