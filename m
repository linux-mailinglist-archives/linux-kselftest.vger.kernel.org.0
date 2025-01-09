Return-Path: <linux-kselftest+bounces-24140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B678EA07EEB
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 18:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEED83A723B
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 17:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BD3199239;
	Thu,  9 Jan 2025 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLrvEsCs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332DC191499;
	Thu,  9 Jan 2025 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444362; cv=none; b=LDv5pUDOce92N5aPmHJV/jLfagZpOKkhM9U99Sp/Q21Mn5aoz8vXOsKrZr1j7YsyE9kVR73fgvV579G5x8+Zunh6SjQ535uyX9XuNSGuVxdMD56eUHIXq5SFlo3A7oTlqpXfH1/Wl8zyRLL5vEKPVezzhjtntuwqKcXOhzCYYl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444362; c=relaxed/simple;
	bh=zVcyNZXN3VvSpw0kulxzE8v0LRQqK88fl5EDuOLBaYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUQEbYFEuD2YWaMqUGOF2HVp4UoRhBi5KUbvpjbo0ZLQzyrBzA3lqHi1SHGbNpY6/FTN5ZThG8MWGix2TUhEZqj4eFcmsmGjEOmH7R8zUvGHosswvJ8SaNE2IpFX4djprw+v4li94nWyvo+24N08KlVYR6/aQjdbfAUuwuW86vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLrvEsCs; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21669fd5c7cso19315555ad.3;
        Thu, 09 Jan 2025 09:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736444360; x=1737049160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6KsRQIc1JxQBezEIVdfkOzKqKFxNDLhEnsfcwp5vSS0=;
        b=fLrvEsCs266ief/HIKVkKkTSNjOmMJiOS4K7TNmKEujm8Gdh+vT9ph1wCXv21QQPjR
         Pqgm1XSaL6lq1d9m2E54KYtkAQLS1klnrcPB5db8qbSjOqZsQ3l/R7PZ3H1Fiayp7BF6
         55Imw0JiaB8OGDiqNWaFDA6WrwldNZgMYNOMO866AVcnPgM4TZHFRHH2/A83zwli7Ngx
         3iQGvdIWonPZQGGbxBoass/ex5BeArOnPxZgXReKKLv9vUl8Or0f4KY2mveArgKZYl5v
         I1SK80dNcFmH72/2FJJMLfNHzMyBslyP6n/M1UntC5nmq3Y/CD8/t4ajwIP2w6wD9XK/
         zYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736444360; x=1737049160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KsRQIc1JxQBezEIVdfkOzKqKFxNDLhEnsfcwp5vSS0=;
        b=TN9MVYiqc78zZN3SUAUJvYcAYcrxj/jPAL4XUqMm+w5FvWG98c62O4VagwXXDKwcoB
         FDBgaa3CvGqHqqITWkXDQvBiUDEqlSm2EupDDDgx7FmIeaen7XIg8r01XmHP67BNmSub
         L/PUeZX0G8FcfsXfkvChqnrObdF0wVE1YUene6OunBA9nvOD7lLZ1nxLsIcO1nAjRrHj
         PEtuvkMeHPqlD5Z5x3pjcjY3lVEJt7GVXyDld9ja8m9hIfBRuylAMPxSiinxUlZrw74I
         gBdOMLoo/q7zKnRNv6ZDu9m4IMLBqhYLPwBNpS6VuSffTgB9L7+xXE19psgtlGr/9JM6
         1Liw==
X-Forwarded-Encrypted: i=1; AJvYcCUkQKrHdvkeBGP7Q9EURSXIsJpNxb9BGEj31qhFF3N/xDSP/A+dpj8Tr/EEGOyRj6+ATnX7ggzH@vger.kernel.org, AJvYcCVdHXX+LHB50g8azcQIN34c7oxzkcEeOdl8cASenIOANiqGgcCxmGp4+xCML1shj2kn8X9FQPHJ91nV@vger.kernel.org, AJvYcCVgzZ6kBNZTnxPjr0TOZOQtICjKIj351vk2HCinPxa0B38GSNhB6+T5vogVHUp4uOl6mizEKfefMrkwhk1SyUoj@vger.kernel.org, AJvYcCWAcauJTO5abggW2v2bH6YjbwmKEprqiGaTL9aWXM+B9yXUi/4DVuUvPxNKt3yYi0Mg4t8=@vger.kernel.org, AJvYcCXxLUxk6EKjlcCWQHM4A0bkczSIi2RaA+knTwJeELooVTZIvuK0vyUEAcAdg6/NjHsKK0gTt94bXlegcDxF@vger.kernel.org
X-Gm-Message-State: AOJu0YxE0LYCf33TD53/smm9C6ScijrVyNb2xwLrZnxIaKAdk3aEM2UP
	9xz/h/s6v55h+no/gH8cU4C0juonfJ4nD6hIX0FkMlWSsj2mlGo=
X-Gm-Gg: ASbGnctrnKE9P5agziqblp/jv2u5b3zZudHItTJfgjihpJ3ahow8IpD6UzZ8TxGEo6b
	ZSvqLNe/GN3Xitw+u8BlQhmx3ibKA4KizGjm/QohLfLZrbbuGoLd3bfHOZnwF1ELPR8U7U0COe4
	SbPhNKSE2AHDXnDKDcYmSgmuMHQpMRhA+jiRznWkpIijoOECTiEJCP+coOSjsKQMViGlBg0NOoM
	FXP2KJVj7ZW0tfug2MP/J0f7PE9+ZTENWZzsQCbGrWMZrnX1E/RqEjZ
X-Google-Smtp-Source: AGHT+IEOsPd8gi8EzkqvvII6DaS7kpXwJUDoEvR9sz6x99GD7Aypk+y99jv+WqRaCxVsNJdjbVm5kQ==
X-Received: by 2002:a17:902:d2ca:b0:216:56d5:d87 with SMTP id d9443c01a7336-21a83f8ea52mr112422135ad.34.1736444360267;
        Thu, 09 Jan 2025 09:39:20 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22f051sm516575ad.203.2025.01.09.09.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 09:39:19 -0800 (PST)
Date: Thu, 9 Jan 2025 09:39:19 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: "Song, Yoong Siang" <yoong.siang.song@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	"Bezdeka, Florian" <florian.bezdeka@siemens.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Bjorn Topel <bjorn@kernel.org>,
	"Karlsson, Magnus" <magnus.karlsson@intel.com>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"Damato, Joe" <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>
Subject: Re: [PATCH bpf-next v4 3/4] net: stmmac: Add launch time support to
 XDP ZC
Message-ID: <Z4AJx-a-eY3pgHNv@mini-arch>
References: <20250106135658.9734-1-yoong.siang.song@intel.com>
 <Z31fXHxWuKNog_Qh@mini-arch>
 <PH0PR11MB58304082BF0EA96D1A74E4C5D8132@PH0PR11MB5830.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH0PR11MB58304082BF0EA96D1A74E4C5D8132@PH0PR11MB5830.namprd11.prod.outlook.com>

On 01/09, Song, Yoong Siang wrote:
> On Wednesday, January 8, 2025 1:08 AM, Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >On 01/06, Song Yoong Siang wrote:
> >> Enable launch time (Time-Based Scheduling) support to XDP zero copy via XDP
> >> Tx metadata framework.
> >>
> >> This patch is tested with tools/testing/selftests/bpf/xdp_hw_metadata on
> >> Intel Tiger Lake platform. Below are the test steps and result.
> >>
> >> Test Steps:
> >> 1. Add mqprio qdisc:
> >>    $ sudo tc qdisc add dev enp0s30f4 handle 8001: parent root mqprio num_tc
> >>      4 map 0 1 2 3 3 3 3 3 3 3 3 3 3 3 3 3 queues 1@0 1@1 1@2 1@3 hw 0
> >>
> >> 2. Enable launch time hardware offload on hardware queue 1:
> >>    $ sudo tc qdisc replace dev enp0s30f4 parent 8001:2 etf offload clockid
> >>      CLOCK_TAI delta 500000
> >>
> >> 3. Add an ingress qdisc:
> >>    $ sudo tc qdisc add dev enp0s30f4 ingress
> >>
> >> 4. Add a flower filter to route incoming packet with VLAN priority 1 into
> >>    hardware queue 1:
> >>    $ sudo tc filter add dev enp0s30f4 parent ffff: protocol 802.1Q flower
> >>      vlan_prio 1 hw_tc 1
> >>
> >> 5. Enable VLAN tag stripping:
> >>    $ sudo ethtool -K enp0s30f4 rxvlan on
> >>
> >> 6. Start xdp_hw_metadata selftest application:
> >>    $ sudo ./xdp_hw_metadata enp0s30f4 -l 1000000000
> >>
> >> 7. Send an UDP packet with VLAN priority 1 to port 9091 of DUT.
> >
> >Tangential: I wonder whether we can add the setup steps to the
> >xdp_hw_metadata tool? It is useful to have one command to run that
> >takes care of all the details. Same way it already enables HW
> >tstamping..
> >
> >Or, if not the full setup, some kind of detection we can signal to the
> >user that some things might be missing?
> 
> Sure. I can try to add the setup steps into xdp_hw_metadata
> by using ioctl() function. However, there are some device specific
> command, like the number of queue, their priority,
> how they route the incoming packet, etc. I will try to find out
> a common way that can work for most of the devices,
> at least work for both igc and stmmac.

We can query the number of queues (and everything else you need) in the
tool, similar to what we do in
testing/selftests/drivers/net/hw/ncdevmem.c, take a look. But if it's
too complicated, maybe at least print these commands on startup and tell
the user to run them.

The reason I'm asking is that I hope that we eventually can run this
tool from (automatic) testing/selftests/drivers/net/hw testsuite to
make sure the metadata stuff keeps working.

