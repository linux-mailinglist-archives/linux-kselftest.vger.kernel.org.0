Return-Path: <linux-kselftest+bounces-24152-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9664AA07F09
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 18:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C783163E33
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 17:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D002D19E7F7;
	Thu,  9 Jan 2025 17:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxYDKtFm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDF8191499;
	Thu,  9 Jan 2025 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444413; cv=none; b=FqsQeOyIP35AndS351rNHZlkRjYkQCjSfdpAv2ZGaeC4fafoKjI9e5XpVGR+hG8gEMdXF2VK5eFxB0iWTmy9ah1aYFzaMpO0UKmp75WNmwXT9bFgBSJvQ2+Y6QRry3V1QL/6zUiRogG/6f9+fLjpN6IESzYnkC5YjH0S9xMHqEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444413; c=relaxed/simple;
	bh=sgY/WTgpLVob/H26v16vqR9o2OrCi4sBG/wp4T0MeF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8FjNXQNn8RbNtP8kguG9TNFuPiUAtLk1dNP+l7oPPrZ6tCgD0Jsfxr5eIP5w4n4XtgArJr3JMCEKUqXCR2G1lBCuua2/OoiGer6qGhsqqxLLVoK7Dh8o/CSfxd7R0ovJrpo7od9TlUALW7MirAQxab2r395brKQc4k+Tdm5uEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxYDKtFm; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ef760a1001so1964313a91.0;
        Thu, 09 Jan 2025 09:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736444411; x=1737049211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tWpZAtZ5fwsLcgO5aqlcO3OYh1NgLbgjWHyNFFao33Y=;
        b=kxYDKtFmK/XZikqpNb+WWnSfItRCtjNabdE5eMqKZHR0qwpi4hrZu2d7roxLzTuxTl
         T6M4hxEXM7WaIJpdDW2w2pJnbkHcFZ4BvDVrZpNU2fLHoNx+0qUaz0I+RgZbYPLujNEj
         quJIzXvcC0lr2QdO6vfVNSowux256wEWDejv0lZcyfUcTEcQJKlEdQPXShyazaL/1UA7
         cFmLgnHzzrMxuPx5TaOI9TGM64s4lzTkunbQ6RMQ05k6S7oxZNwTCUm/uA0GB5Yjaa8m
         89dBS0m6oiZDht7ml3k0c23Fif7RWg/X6d3vvpY+SjRrOAJvGdWiw6/fL7Fwt3CEXPTT
         Xwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736444411; x=1737049211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWpZAtZ5fwsLcgO5aqlcO3OYh1NgLbgjWHyNFFao33Y=;
        b=Jf40ld+WFRiwiBC0FRv0vlYEvsPWw8pJPZLUfc56I8ng6xbwjc4vk+Yu0Elh4ZWE0c
         P4MCqNJmn4PuVcfr1XIsu4vuoy190Y/LKSO21Aa5f8LjZzIm8EjGebmtlXVfUOKCsFLY
         p+vhCEwIgkrWXXSMh2pp2CGPHZBPiXwNThyh/Jg6IrdcfoUd91g/t/rg7Ye19zaMDY5l
         RsXUFfqmPAnZxB50oNTWQrJK3LUN1LsImNewQ2C+qalZBofOZVUOYfb3aKv1eQU8Cku+
         fRE3OHFNMXWqvM1+OdjjBL38yXA/biFwM1qwscKVKaUx3cxhOdxHC1jWEttrlaJPsvPC
         ixOA==
X-Forwarded-Encrypted: i=1; AJvYcCUGJ5op8VYK09mtia2uE7i9jF4UVGbMP5cGtJ0wk1dyGTMZkDjXudqW5uglRULRGMs2qx3FhAjZd3mTOEBwDG1Y@vger.kernel.org, AJvYcCVAEkseggCGr0TfYIV7d8XK10RMYQDalDqWLgiB22v47FB2MD3zkjIvzYNAuZcAhXUVF/uF9zfSKXQW5vzv@vger.kernel.org, AJvYcCWDCS18WAh/6P1R0FzgyXK3HcQjKxt9zng8DUbQZOgzy/6nlBw3a4nUJrEeXcxKplt0xgBtX1eKDA4N@vger.kernel.org, AJvYcCXDeB/wR1M77ih1ePzIZ1CIlqbzKN2OXjhS4z+F5b6haxSGYgP04KPKIlULq3eccaesv5kDdTA/@vger.kernel.org, AJvYcCXzh/DZ5xCGecAiv+fFmE5x2fdk6eu/scEtiAa5zjPYVf3+yKddoBEUym5e6Za6Egy+gbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+xgZTp3EhVcmhdc8ZeuRZG036JDQBNubpLL/lq+7omGK2qptQ
	WU0zzO1HnSNmRrFAyxZNFNclmJd58o3QZH19tKbB7pqiD9diM4c=
X-Gm-Gg: ASbGncu2N1IRhXg5M+2Ad0GWGg4OZ9pJ3xM5u2c6qYNXIVV5dd5kgztcLzEDYCpKawt
	NUdoZNWTZ+GmJX3GKBnmXu/9YURVR5rZkD+lL6mkUbC9ql4u+lLT4oCpywKmu0Zd7jkrhvL1tmD
	rls4iT3Z8maiGY0ArioKOGvQWAsYIZzsYp6jph4laRy/rC6eBHRI4vQ1lOuj0Jd78oGGylBngvS
	72wQBiQxg+FtRp1KM6YPNwWpkDDPhUy2PPt/F2NleUqOLPdY3D5COsS
X-Google-Smtp-Source: AGHT+IEZHpA+1As7rYRP/wbYTv7BBI8EycFV1R1kQaORb6ULu5g6y7WttO6FZ+OmR/qIEMsz9TCzbg==
X-Received: by 2002:a17:90a:d887:b0:2ea:7cd5:4ad6 with SMTP id 98e67ed59e1d1-2f5490dbefemr9659697a91.32.1736444411540;
        Thu, 09 Jan 2025 09:40:11 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f5593d0911sm1848116a91.8.2025.01.09.09.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 09:40:11 -0800 (PST)
Date: Thu, 9 Jan 2025 09:40:10 -0800
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
Subject: Re: [PATCH bpf-next v4 1/4] xsk: Add launch time hardware offload
 support to XDP Tx metadata
Message-ID: <Z4AJ-pIyAUbXJJpx@mini-arch>
References: <20250106135606.9704-1-yoong.siang.song@intel.com>
 <Z31bQ6xEkyQvbutN@mini-arch>
 <PH0PR11MB5830D33B679A0ACD3FD6E23CD8132@PH0PR11MB5830.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5830D33B679A0ACD3FD6E23CD8132@PH0PR11MB5830.namprd11.prod.outlook.com>

On 01/09, Song, Yoong Siang wrote:
> On Wednesday, January 8, 2025 12:50 AM, Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >On 01/06, Song Yoong Siang wrote:
> >> Extend the XDP Tx metadata framework so that user can requests launch time
> >> hardware offload, where the Ethernet device will schedule the packet for
> >> transmission at a pre-determined time called launch time. The value of
> >> launch time is communicated from user space to Ethernet driver via
> >> launch_time field of struct xsk_tx_metadata.
> >>
> >> Suggested-by: Stanislav Fomichev <sdf@google.com>
> 
> Hi Stanislav Fomichev,
> 
> Thanks for your review comments.
> I notice that you have two emails:
> sdf@google.com & stfomichev@gmail.com
> 
> Which one I should use in the suggested-by tag?

google.com should be bouncing now. sdf@fomichev.me is preferred.

