Return-Path: <linux-kselftest+bounces-3884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 879AB8449E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 22:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F6ED29081D
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 21:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED6239AC6;
	Wed, 31 Jan 2024 21:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llC1U/5u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8419B3A1A2;
	Wed, 31 Jan 2024 21:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706736048; cv=none; b=ir0kncvGfHbgKRl83ip1uAueoRa81uNEmN4rKHX8cx9c2F4Kn5vWikycZqgM3/nfSzpv3uZvVxyDX1z4ACfczRNMbICEFmeSQbsje2zOcZGdpoK3d000yplXvCMKSQQ9a6FPbvKKuTofltdoROoE3VBs0nXPx9fEc2gQoydB0bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706736048; c=relaxed/simple;
	bh=ZcfxmVRkI1dTH0y4SBPuuQwyg2BYD8kmsGl+cRwbNB0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VHGoRh3X4me1dqNqy2x7LGUvtPlYFT+Tx0URp9Oz0j+cbeAfmz6Ous8pRtFRDYH5JD1hjU1bxLt1sgTcDGHedM0q/eyLjXBf6hUf/++X5qTx1gTwus6X+3fwEKz16sWEFFlDAixtqscsiZNti+3BdPjiah0D+AHzF/kdTlJtoTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llC1U/5u; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-783045e88a6so18166185a.0;
        Wed, 31 Jan 2024 13:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706736045; x=1707340845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVEKFXye73BBUZuEzbRTnsuc4JygH9rgrXk+g1IQDZ0=;
        b=llC1U/5uCJG2WEbCy0YF1eUDaKlT0EXRJmLUBPvTgsNtWfKVL7FG4E9ox4P6fGL/X7
         bvTm/4Eocgka0vPqGHVMUT/R6yM60GHa8FylaK8LtRU0LbHbcBB02YOsKybjB2LKw9ni
         bVDQAMgGkOEk+B0mNg7iTIgP/A/frTLjaQW30bznOEAeLxx59OaDRyDGo47uzr4ESObu
         ZLdMawD3Bt4wDDMPbk3HC7VvRj8KNi2rAnD+SctL76M5cbkWvfeatpbCRFXXDQIrSlhk
         B3m0eu2w9ZQmQzFlgc7J6V39v7okPgfL1DYtVJzGgPR6I8KenuTYry04MgE6MTsJbNoN
         DD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706736045; x=1707340845;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BVEKFXye73BBUZuEzbRTnsuc4JygH9rgrXk+g1IQDZ0=;
        b=cjt4+bsaa9MtLhcOQD3+YikfvjgkPRKLEjf/k5Hl+wZC7zcWyuEytWlRQ30+JwLeCK
         Fq86hjKDFzRIvrDPiHTkZUsqudf3bSRW4uUid8Soa8Z25T1cu2UNMwvvtM6Zzo8my2Fp
         wHCCxHrubBMhaWHlpOSqcZVXUlKgjWyyTCfFtTPGqXGDLeyzClYMM81ASF4FBEAAgejY
         Az+/TVj22h2K8myph4+eGM199ktSvn+nR2vFC9YE8MQBwbLE9YJttg84pC0cdAtyQLZ4
         uWoWo8mt3ULXTQJUgfVPATamXk6Nojh6WWsVrvaAd6AKzG4Ic4FMClLcOl4TJBR6oD8J
         ZVxg==
X-Gm-Message-State: AOJu0YwDXz+2qYxGsajxQ5k1Lh9emVVILsiWATww30RJJqtNf1B4dwwS
	1Qj3vY3/IxeZcNwBF6IWW+B8/4rSyCZVxRcgSMbjI6sil4TfyM+14ndFTv43
X-Google-Smtp-Source: AGHT+IGcmsOPcVOU1UDLAmPBm3iq55IBUitHRtCnC0aylWqDBiLYaeDNZSgjTi6irVr1M+OiR+WE/g==
X-Received: by 2002:a05:620a:103b:b0:783:f9e1:daed with SMTP id a27-20020a05620a103b00b00783f9e1daedmr644530qkk.27.1706736044787;
        Wed, 31 Jan 2024 13:20:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWIigt21BlgyKQFMpseP4DsyWSpX5geFX7uMb+cPF6dHRh2bCMFDYUK2KIw+YxSuaujlN7lqKljVOKxlMIFUJ54MS+B2pStY4GFVP6gMiuUNlYsf+YvGk0ZYWt3shiwsRWhah73+W23cd25Sf5MLylC1e+uu2NK7D0EJeE+rz/Zvp93vLWBkYLRUINfSUMMrOa78CRkw2TRo+iLXm2tth41wJTDWoBRfiROnaQZPpBYV2oKcilPXiXp5/PXUXXCxvkFKEgARM8=
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id n23-20020a05620a223700b007840071706fsm2684481qkh.96.2024.01.31.13.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 13:20:44 -0800 (PST)
Date: Wed, 31 Jan 2024 16:20:44 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: pabeni@redhat.com, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <65bab9ac3fdaf_1c8a1f29426@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240131125819.25c7c372@kernel.org>
References: <20240127023212.3746239-1-willemdebruijn.kernel@gmail.com>
 <20240130174736.03c79071@kernel.org>
 <65ba61ea978b4_1699fd294eb@willemb.c.googlers.com.notmuch>
 <20240131102932.6caac1e2@kernel.org>
 <65baad3627cef_1b52d2294bc@willemb.c.googlers.com.notmuch>
 <20240131125819.25c7c372@kernel.org>
Subject: Re: [PATCH net-next] selftests/net: calibrate txtimestamp
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Wed, 31 Jan 2024 15:27:34 -0500 Willem de Bruijn wrote:
> > Jakub Kicinski wrote:
> > > +1 I also think we should run and ignore failure. I was wondering if we
> > > can swap FAIL for XFAIL in those cases:
> > > 
> > > tools/testing/selftests/kselftest.h
> > > #define KSFT_XFAIL 2
> > > 
> > > Documentation/dev-tools/ktap.rst
> > > - "XFAIL", which indicates that a test is expected to fail. This
> > >   is similar to "TODO", above, and is used by some kselftest tests.
> > > 
> > > IDK if that's a stretch or not. Or we can just return PASS with 
> > > a comment?  
> > 
> > Flaky tests will then report both pass and expected fail. That might
> > add noise to https://netdev.bots.linux.dev/flakes.html?
> > 
> > I initially considered returning skipped on timing failure. But that
> > has the same issue.
> > 
> > So perhaps just return pass?
> > 
> > 
> > Especially for flaky tests sometimes returning pass and sometimes
> > returning expected to fa red/green
> > dash such as 
> 
> Right, we only have pass / fail / skip. (I put the "warn" result in for
> tests migrated from patchwork so ignore its existence for tests.)
> 
> We already treat XFAIL in KTAP as "pass". TCP-AO's key-managemeent_ipv6
> test for example already reports XFAIL:

Ok perfect. Then I'll do the same.
 
> # ok 15 # XFAIL listen() after current/rnext keys set: the socket has current/rn
> ext keys: 100:200
> 
> Skips look somewhat similar in KTAP, "ok $number # SKIP" but we fish
> those out specifically to catch skips. Any other "ok .... # comment"
> KTAP result is treated as a "pass" right now.



