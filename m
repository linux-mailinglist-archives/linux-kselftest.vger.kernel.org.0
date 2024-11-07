Return-Path: <linux-kselftest+bounces-21624-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 689339C0C05
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 17:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDAE31F22732
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 16:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D3321620A;
	Thu,  7 Nov 2024 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guuUxMAb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002351BD007;
	Thu,  7 Nov 2024 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730998473; cv=none; b=mHYJ/q0jpu2ULc+PWJnOEWEwf44kaWdCSoMSUTFgMZOzT7UUVt63En6CPoSMOXAqlbE9gNZo2a2RSTBNNpcoHi9QhKkS8xABHcvtRM58qj1+vq5Hr8McgdnPp45VQju9cfMuxtStXc6vskv2Grdd+dW3rpd6AqgaljOgoIaQnhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730998473; c=relaxed/simple;
	bh=YjR9XgoTaD6j/UmnPPlZ7iV9/VGfZG8Hi/1ZKtVLbcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ruR6krTRpO+zws58Cnow/vxXNYVqB6m1gthw+4wX2+p9/KTMMLqXvcUcu6ovSFcB1w4IkwSkvudKHosO+dGfajMYUhhMHlIXhL10WgR5w70B9jBQbODuK1uADszSI9ZeOXZwnCloTJSalg+49v2/Tl/BFoe1MmtiyCFU2baujc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guuUxMAb; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d6a2aa748so725073f8f.1;
        Thu, 07 Nov 2024 08:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730998470; x=1731603270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjR9XgoTaD6j/UmnPPlZ7iV9/VGfZG8Hi/1ZKtVLbcw=;
        b=guuUxMAbZ/fZBhVXjph1XsOVGgPFRLIunKP9beqA0Q9j7CyVvXw60LZYPYn/CtjHTt
         XB1IjQSzo6eMIsAAF4XYJw07bCv/X+xr2JzmNUlAQ+lNI6EaZckXYouVByP0R0tnwUmI
         9hYa0q7tovX4Ic03dwckue7oLgObLO1lP5JR7iQhFgn71JS4LNjpG2haFOqHXKM0ZByZ
         hsfhEKFzguvw6VHwjHjwQA7TdxPpNMzr8K+JwJIrMfYstpj2rfNnbkNBZDg6DOiXxByB
         wXqvi+vcD2/FZp5VDPOKfUV/jZUz4UFSu6UjCoZStbVixlBEMWeEx9bkS96Ass5iY+MG
         UdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730998470; x=1731603270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjR9XgoTaD6j/UmnPPlZ7iV9/VGfZG8Hi/1ZKtVLbcw=;
        b=Cad2kdeCPciIV7ECDZaaSnp0qDhf3ighY1W23oZnDRtZfO2vu/RztKXIZkgjp5/rwF
         yfV5FzPpk2qU4QIyu5SfCGJfOrRqRnFnF3M5Y/7D0/kWfMjPhIAnhqxzAeICY2Jw/8qQ
         EwAery/tihBZnOE5N5geJzEIkxTd3mbQBHCWtHqj24YS9s8ZJMICZu1oO/+kZlk5CUOQ
         MO1pcObrMm8kBjg8GDZoJnZJ0ak0c9pKxkj2mmJi1YHMDHz70WKHWGcj6Ua22R+yXEQm
         V0Kni3yL/8zCzJ4ItN7ygG9sjhkwrsapqtIf7W1APjWo5Yt8p4/NFW7INnEERuvWtN3g
         atwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFJad/D8yNnhTaehmL0NXT/Jp036K6mXYoyZcLvpJvQ0sIpsQ+w39jPZk66EC9JEUx8tflAbdA+Kf292fKRxQ=@vger.kernel.org, AJvYcCWpiBV1CS/PXrCBlZm0f50KSDQNHW8oNmlnBhTTkP1cXn9W9MpemO4StgzuBkphiokp45m03JL6@vger.kernel.org
X-Gm-Message-State: AOJu0YxdphoxSuwj9MAiehL2ScjrdYgyWJp0TGFYhsUj/uOcPW833Ri7
	+akDrwZBcunMz6+0F4Sr19y0mh5++HpAR5h5bjBb1nmbELO+uIg5qjBINbLgZM7s1B2/xTrG5Rm
	KF4exMg0i72w3drxtZPsznUL9k/0=
X-Google-Smtp-Source: AGHT+IFbC+Sb2iP0XOwEMN7bNiSSUnyt16wp7V2RLOlj6Qx5ox4TKWGJWhoIHGCKICdvmlbDEjyuTeJwi+2y2XBLp20=
X-Received: by 2002:a05:6000:1f8e:b0:37d:3301:9891 with SMTP id
 ffacd0b85a97d-381c7a4c0e6mr17589877f8f.17.1730998470087; Thu, 07 Nov 2024
 08:54:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107133004.7469-1-shaw.leon@gmail.com> <20241107133004.7469-6-shaw.leon@gmail.com>
 <CANn89iLvC0H+eb1q1c9X6M1Cr296oLTWYyBhqTAyGW_BusHA_A@mail.gmail.com>
 <CABAhCOS8WUqOsPCzQFcgeJbz-mkEV92OVXaH3E1tFe7=HRiuGg@mail.gmail.com> <20241107075943.78bb160c@kernel.org>
In-Reply-To: <20241107075943.78bb160c@kernel.org>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Fri, 8 Nov 2024 00:53:55 +0800
Message-ID: <CABAhCOSvhUZE_FE4xFsOimzVBQpQYLNk51uYNLw+46fibzfM2Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/8] net: ip_gre: Add netns_atomic module parameter
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Jiri Pirko <jiri@resnulli.us>, Hangbin Liu <liuhangbin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 11:59=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 7 Nov 2024 22:11:24 +0800 Xiao Liang wrote:
> > > Instead, add new rtnetlink attributes ?
> >
> > It is to control driver behavior at rtnl_ops registration time. I
> > think rtnetlink
> > attributes are too late for that, maybe? Can't think of a way other tha=
n
> > module parameters or register separate ops. Any suggestions?
>
> Step back from the implementation you have a little, forget that there
> is a boolean in rtnl_link_ops. User makes a request to spawn an
> interface, surely a flag inside that request can dictate how the netns
> attrs are interpreted.

IMO, this is about driver capability, not about user requests.
As you've pointed out earlier, probably no one would actually want
the old behavior whenever the driver supports the new one.
I added the module parameter just for compatibility, because ip_tunnels
was not implemented to support src_net properly. Yes it's possible to
add an extra flag in user request, but I don't think it's a good approach.

BTW, I didn't find what's going on with module parameters, is there
any documentation?

Thanks.

