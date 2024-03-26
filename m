Return-Path: <linux-kselftest+bounces-6624-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6FB88C3E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 14:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3891C3AC9B
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 13:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBE48061E;
	Tue, 26 Mar 2024 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWG5AHu2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104198005B;
	Tue, 26 Mar 2024 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711460435; cv=none; b=OyHqcNZWNciLbDBa9NKgbabkzR/+L/sotr7JtNvgcFO0bDIV/feYY7Mxm4DL0inYHYae1dtnAvhEqm716a9rdrlReDim/O3ECsA87AcRalQY0ThkOG9JTASs1lo0A+vNQt36OBuL+lMLOD/z2NT6ezUr8rlIrOKDuPHN0choDKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711460435; c=relaxed/simple;
	bh=/Jc0MWHCp4fuAc5CLYtUxmc90iQbiyIL1jxufTmq4K4=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=KZ19pwjIiHy7NXMWM8ng05qOtaUZDBJ3GXPX2AmvqqGzBgRYj0CFQg16Lr1G+RLg4/qYWB7hnPQNdktoEsmv0RcCEnQqrtap5dcUAm99Ae27xHk4suhz6rllCoBSSREHGgxx4MYMGEkgvnDEZblJsYL4bQin4md0tJIfhlbHlIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWG5AHu2; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-788598094c4so261356985a.0;
        Tue, 26 Mar 2024 06:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711460433; x=1712065233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cKb2/u7bTUjCLAuXknqnuW2euAxMzzYcAXpS6k1T8I=;
        b=GWG5AHu24n0ofkFTp5wlES/dO/VstowhuqK6IsWUa6y/fubLHqvzb4iq7UFBFTW8aT
         kGnFdELzfHEAkInn5hxA1Tqxaxe/53L0FMhbIvNv0/ZkBB+jmXKCMx0C7g08QKbMHNlC
         z7On5J6oPcNbgRV/FqhQwvpPBTQJWtstMAH1hayqOW9cWVS8ZKFifEamoAvZ72umUx4U
         zfYhYLQdNVE4Ft80EaTBnEJEGnYubStKkIoh0PW9SGR/qvSpIdOroZiL2UNvh2IKv6Si
         jIn6r4kO+ro7JOPEl1cSniDdGQvs+cCORhphJvoMv2tBD6awON9kpLvR3r2oZl8Xd7CT
         gcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711460433; x=1712065233;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cKb2/u7bTUjCLAuXknqnuW2euAxMzzYcAXpS6k1T8I=;
        b=uwwKm/gfLysQE8nFHhSqbLiRaiUabftURVb1pWmz+RCo4Q7Btf7Sg3fvEu4NashVfn
         mEEPvlaTzCAqbDKSXIvPB9NR0+8r1/J/W1MCZ0nKde71vGGhEmLyIfK/G5NZSuX4K/P6
         ZsJGmfQDtj7ZXBWZM83JjpiJ+STvFad+K47Nxdrz0GEkNd8nxGCnr2TBzryPhMy4Ashd
         18eMqAmCOUvbPJfM+ldcKRZeD/piUSzMZ5aHFxQQ6IDa08HNcmAimKpQbxD39edqucvD
         Wu6aFuyeaUNTbf9OBgx4+FiCTvT6aTwE2nbIHBz6GwNQLxyqSDTxLzOrcRHa9RhgHjgP
         NTOg==
X-Forwarded-Encrypted: i=1; AJvYcCXYaeQdtTM+N/Syz9ipDkNm6sWiHo/Dtv58tO63U7DxXGB/q09k6V/Xw1TQIsQ5FRK484OLrHpeer997mhgZdPpLg3vuZ+qwULCBZqPAoSBZeO86kiOnMjZTMTpNIl+r+h9M9SdK1SVOgRYyf8s4g9rVDf1SkRfRx/2CXldCWvGKuS5V2/5
X-Gm-Message-State: AOJu0YylwmnpimxG3lhDY9npTmWpCgn+ldYePKofq9+Xtgxyi+YA/03H
	MIv3YMZOZbZXgBeU2igl0RbmEwfh7r/jZUcb+UTJq3dieNsDNr0J
X-Google-Smtp-Source: AGHT+IED33vhTtcX4UL0LWOVjztttUhUL+F7bTRE2mgHIwp2zhvbcAhTRJiumZ9zpSTsUF3lo1ekZA==
X-Received: by 2002:a05:620a:55b2:b0:78a:5c88:9b04 with SMTP id vr18-20020a05620a55b200b0078a5c889b04mr2959946qkn.73.1711460432892;
        Tue, 26 Mar 2024 06:40:32 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id o15-20020ae9f50f000000b007882fe32acasm3017567qkg.3.2024.03.26.06.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 06:40:32 -0700 (PDT)
Date: Tue, 26 Mar 2024 09:40:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 xeb@mail.ru, 
 shuah@kernel.org, 
 idosch@nvidia.com, 
 amcohen@nvidia.com, 
 petrm@nvidia.com, 
 jbenc@redhat.com, 
 bpoirier@nvidia.com, 
 b.galvani@gmail.com, 
 liujian56@huawei.com, 
 horms@kernel.org, 
 linyunsheng@huawei.com, 
 therbert@google.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <6602d05046526_13d9ab29498@willemb.c.googlers.com.notmuch>
In-Reply-To: <494e8cac-e87a-4bc4-8a77-1801a703fd86@gmail.com>
References: <20240325182543.87683-1-richardbgobert@gmail.com>
 <20240325182543.87683-5-richardbgobert@gmail.com>
 <6601c830c1daa_11c6072943b@willemb.c.googlers.com.notmuch>
 <494e8cac-e87a-4bc4-8a77-1801a703fd86@gmail.com>
Subject: Re: [PATCH net-next v4 4/4] net: gro: move L3 flush checks to
 tcp_gro_receive
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Willem de Bruijn wrote:
> > In v3 we discussed how the flush on network layer differences (like
> > TTL or ToS) currently only affect the TCP GRO path, but should apply
> > more broadly.
> > 
> > We agreed that it is fine to leave that to a separate patch series.
> > 
> > But seeing this patch, it introduces a lot of churn, but also makes
> > it harder to address that issue for UDP, as it now moves network
> > layer checks directly to the TCP code.
> Currently the logic of flush_id is scattered in tcp_gro_receive and
> {inet,ipv6}_gro_receive with conditionals rewriting ->flush and ->flush_id,
> so IMO the code should be more concise when it's in one place - in addition
> to not doing checks against non relevant packets.
> 
> With this patch, the fix will probably be simple, most likely just calling
> gro_network_flush from skb_gro_receive or from the relevant flow in
> udp_gro_receive_segment. Since this bug fix should be simple and it being
> not relevant to the optimization, I'd like to solve it in another series
> and properly test that new flow. Do you agree?

My main concern is moving this code to tcp_offload.c, if it likely
soon will be moved elsewhere again.

