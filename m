Return-Path: <linux-kselftest+bounces-42310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D83C3B9ED61
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 12:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973053A6E70
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 10:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09B12F2917;
	Thu, 25 Sep 2025 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="edjWrsJp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA27264628
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758797899; cv=none; b=QHbFCiByMA9OLEDgMeDHoqoLrWcFdiZqwcVsHN/Xc83XaFY3d7gun3Kbc7SlrY7XKLyst29Z5VzeShqdK1Zv6RBP+FR4I5cZRPuAFRIyamDwQPpwrK9fu7xsleoZYEOQw1N3nPTP3wLsZMXjnVpM2IFKIdJkI80NW4B4f6+hplw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758797899; c=relaxed/simple;
	bh=goeEHV8pp0nSp3KK7+LsINEPmAxyg+E+nyBBoSFwzRE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=smZtPpTDp+w7Pif3I2U+HQpL93RLlXWW+qAYXdwGNuzeR04Qzvs/MIA3SezPUJkvTQdyjBpDFDPWJLP/SNxa+/Z0tDTwpRx1y/Ej5mypJPzDdhnrqNrmzWvPq/USjIvxLL9XlWTBtKCzLvp31fdV+7+xwW9P9NqAZKMJ9n49nKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=edjWrsJp; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b28e1b87aa7so127461766b.3
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 03:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758797896; x=1759402696; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qoutmRJfBiooSSHCtQV7QJz0oS7nanw5QS3919xibtc=;
        b=edjWrsJpcWLUjAgftTi47573qE+Q2uX/ylea3V3EEONhCNHIf2DLvmZ8SvZQGb2KjT
         afCEBcg3p72MbxotM1nz9kMB5kI/42aQ+B7POIUtqbeopzcAHrHKT347OIMG6aetH/RZ
         XWOEOxsr+Ei3h6yBi6i5Amml64oj73cAtYwN5gI0NQPKDevh7WqD3ZRGlBW7cBiM5hAo
         mJs71VaPRjU5N3bal6U+XTCx8+Tt47G8QNWHMptXPSIVeFQradmAWPlhUaUh533GhGrH
         4mXKm3hk1g6BlfT/nJ77+7HTEWgSiKtd3QzRr1rPSpnMpAPGui+RFunYX5FHzElgO54A
         Vsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758797896; x=1759402696;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qoutmRJfBiooSSHCtQV7QJz0oS7nanw5QS3919xibtc=;
        b=Gvisys+ZwK1qmXGJX13PbPGtWZTp3F8jltyMRls/2KTTu/nWGSohYbFoN++vmfugGl
         pPifAmFDC9lH2tlk7EvfaxWScNgUi7q/JictAkdzrqAbPNc5OpUiHy/hFY7EDLuiU+FB
         aCM2d6/f9MGkyBbtfC6NRf4Hn6b3wjnCLOfCLHrzrV+qxwMmyIuZhue5zPzs3ystGzcC
         DtrVaTwhNbBwIBp7vcMid9aF/OTSdXrVturd5V0LkzfwTIC13WKRNTulmABE1uRpqE7P
         CKRYaD4fa0Bd2SJMa/tG7PbPp6fTg+apcE3MzsWwIgYKQrqIeADTQLtaIiqVe3nbGU5O
         x5RA==
X-Forwarded-Encrypted: i=1; AJvYcCW9iaHlS+Z6pgeBxerDFYEogLLBweE51q1yICnrhEjcvp8/9RBfokFHA1V0rHPeY4Mo5U0BaeqA1xFfxTG51is=@vger.kernel.org
X-Gm-Message-State: AOJu0YyckcieXljOu9r7O3jVN2WLH7nwFGjAxkccB8hVtRcV3gVBGJx3
	A62/AXYuerpmAckQFw6o0e+ylex8fiChKWaZpM4J7YcSE3zQvc2lhi3c4GnZO6kohrs=
X-Gm-Gg: ASbGncsqwBOcqB0Meq8Bvg5bxhgmbVBI0E76mqz02aSHgzCphNxL6teYXYL5Cq9A6rW
	khfC8H3H0nILLA+rcCNALzU9vMrF/dgaLha4g7v/nV/BQ8mI0FRrjVzawL1m6yeoDSSlVgLEhTu
	8dcekUvDeH+I4Ts0Hf7cHHaikI8fTzrTL3n6tPn/OnaNso4/7j9CVfYM/ekLYS6qtIaYQsghMGP
	mCMcL/Ks0Qe5brIvnSR15LkMljw6bhhIySHCU6Wrn+osbRI1/qemUobuGOpfqJzIfCfiaaqjdYd
	B7ezTSOr3zTDiVDCIRqnAUOgaWypCrFdYL6EI3dyMCm3Op6sjeYOykd2a23svvULqbUov91ndmx
	NFmqH5IYAQUHUEFw=
X-Google-Smtp-Source: AGHT+IEinH3OcipauCDmRqja5aQEPZ/J+HFOTVgp17H/W3ZS2eXjpFNwJ5ilU5Q4ue35F4Z7ahPnlw==
X-Received: by 2002:a17:907:3d90:b0:b10:3eb2:2074 with SMTP id a640c23a62f3a-b34baa34934mr375500866b.18.1758797896306;
        Thu, 25 Sep 2025 03:58:16 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:d677:295f::41f:5e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353efa4c35sm143452466b.26.2025.09.25.03.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 03:58:15 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,  Jakub Kicinski
 <kuba@kernel.org>,  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Simon Horman
 <horms@kernel.org>,  Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Jesper Dangaard Brouer <hawk@kernel.org>,  John
 Fastabend <john.fastabend@gmail.com>,  Stanislav Fomichev
 <sdf@fomichev.me>,  Andrew Lunn <andrew+netdev@lunn.ch>,  Tony Nguyen
 <anthony.l.nguyen@intel.com>,  Przemek Kitszel
 <przemyslaw.kitszel@intel.com>,  Alexander Lobakin
 <aleksander.lobakin@intel.com>,  Andrii Nakryiko <andrii@kernel.org>,
  Martin KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
  netdev@vger.kernel.org,  bpf@vger.kernel.org,
  intel-wired-lan@lists.osuosl.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v2 0/5] Add the the capability to load HW
 RX checsum in eBPF programs
In-Reply-To: <aNUb2rB8QAJj-aUX@lore-desk> (Lorenzo Bianconi's message of "Thu,
	25 Sep 2025 12:39:22 +0200")
References: <20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org>
	<87bjmy508n.fsf@cloudflare.com> <aNUb2rB8QAJj-aUX@lore-desk>
Date: Thu, 25 Sep 2025 12:58:14 +0200
Message-ID: <87tt0q3ik9.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 25, 2025 at 12:39 PM +02, Lorenzo Bianconi wrote:
>> On Thu, Sep 25, 2025 at 11:30 AM +02, Lorenzo Bianconi wrote:
>> > Introduce bpf_xdp_metadata_rx_checksum() kfunc in order to load the HW
>> > RX cheksum results in the eBPF program binded to the NIC.
>> > Implement xmo_rx_checksum callback for veth and ice drivers.
>> 
>> What are going to do with HW RX checksum once XDP prog can access it?
>
> I guess there are multiple use-cases for bpf_xdp_metadata_rx_checksum()
> kfunc. The first the I have in mind is when packets are received by an af_xdp
> application. In this case I think we currently do not have any way to check if
> the packet checksum is correct, right?
> I think Jesper has other use-cases in mind, I will let him comment
> here.

Can you share more details on what the AF_XDP application would that
info?

Regarding the use cases that Jesper is trying to unlock, as things stand
we don't have a way, or an agreement on how to inject/propagate even the
already existing NIC hints back into the network stack.

Hence my question - why do we want to expose another NIC hint to XDP
that we can't consume in any useful way yet?

Shouldn't we first figure out how we're planning to re-inject that info
into the stack?

