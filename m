Return-Path: <linux-kselftest+bounces-26984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A25BA3C31C
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 16:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970671782E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 15:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4094E1F4621;
	Wed, 19 Feb 2025 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDIHF1rZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A00A1F419B;
	Wed, 19 Feb 2025 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739977622; cv=none; b=HI7tpwsnIewiSu2LzWZbAJWaVEyWQJIlj5yathzn7Myk4PsKfmttxbPdS1IxVFHOFbLkJWr4BEemZDc8jJWzNbH+Tuh0HG9Bh/t5hskDe08kB8924wvY6AILX/z/Xq7/RfEhO2KYGKF9ip9RVDTBklXyiaBi8YWTvSfmXOVYrKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739977622; c=relaxed/simple;
	bh=C4rzID1fsb642n2ypixekW06YxEC2w9WG1TtwpNSOaw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NR3kJ3JGrDwnO7zt3c2SEPd1rOsuZQ62l336XXTgJh7fXW6D2B4smzZDtbpVaKMhtK/JPrOiTBPUOpJB5IFpv+4E3AsV2V8nEuGbm6c58qbGiNH7fcbfKNm4EckWXxg4WoJdH123cFlr0PZ8Y/p9tBE0d3RQmYmBn/a63Plrs7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDIHF1rZ; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6df83fd01cbso33886766d6.2;
        Wed, 19 Feb 2025 07:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739977619; x=1740582419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZN9/JWs6uATVsw+HP9fYNfS7rnjBMcGMSGHQzOGC8k=;
        b=cDIHF1rZG1EKtr0tcmpsFtOP0qDSkbT7Zw7oG3StcUkN5VR56Wj0Caeu+QZARCctMZ
         ydgdrRuAvQP48BDiSsS+tBzzBrjkXi0gUhlYNXocz2gOTqVqsyo7sRA3SzCEVNDvFRRF
         Fk6nRYeXzjWDh2vvd0TKdwrxwia1xBb1b7UEHEsHCtfiMbQtaXlQEHCJzjYx4KpUCj+z
         U4TTeFNZZGxftEhyYXsu2QyDmKXqIOLDJan+Np/kMJ0EEoiKL66rLgXLkiEcLhOZ/FQ8
         RfSyI8EN9ivXxOL6oRuTo25ASNr8hv/R6QNuEYnv6X32sErAdVjXrW/Z3a7jyfWvC6an
         Qb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739977619; x=1740582419;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sZN9/JWs6uATVsw+HP9fYNfS7rnjBMcGMSGHQzOGC8k=;
        b=FXawc2/h1Rd7UX5lycJ8zeHT5+a0pUovsCcqOvg4Wp+txWdM9OM4dHGLxrHQh6a7ka
         mN81YLUMwXJ/5KRbUIeaLak/IzD6PBAd1PPMHcL+bpVRx4RUrKdL4sDIkE2Ga7j/1Tjd
         4l/ja3hgEkdh63KgHK0gQufaQPhPX/yH3aoxbbFuhFg4X466ewSYWGHAfbtRxjgwSjqb
         +R/gVZSS9OfukAtTwca0wQRXewDei4UOjBRf833UqL1/UPrOwRXhROIr6M6IvHssUa58
         JJySNK2eFQ/RoO/7YmX7sL2/ogqLu/hGN2B+BGmhX4yzFzE5F5uDL8npExXHw59nSD8w
         wJ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUA7GNjPlAGdxp2ucykFP3exZn6TIgVirrOmgctPB0UzWb/LCWQTl7F46yx8FdSTvyywZ7HGugJINRRpm69@vger.kernel.org, AJvYcCUpsKObTwhH1awnIEogLjTAiXqtUqWu+PT3RxaZ8pZFaAVyr4Wo3LPJYTcBvjHV+o+lSBA=@vger.kernel.org, AJvYcCVpuyQr3/WJ+n36Qgs5xZprNBi6whkjugkPyPibsKuLVuZ0Ym/d764R4+y+w7/zJQSm6+FGw+z4@vger.kernel.org, AJvYcCW9/sqOdVoMizNtB5of7pEKn3iWy26Jd87vOqpnFbDlRzuIEYUGEWSizDSIAutHtjFZSNpZv0hPkG/vfvX5j2+R@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ569qY3FIHnFN9C9H9i74I+k+OlkRxERXAO0nMoR1UP3EGyuZ
	WVKbMz9ilOAUxTsc1SGF7xsHDZ1AyUGhN0GOB6+DJhhi3W+5YkREthtJJg==
X-Gm-Gg: ASbGncsgn+JiRsrSY4FKzotNlKZym2HlSxr7KfrRgjakdTDOe8PhjMC30pxZVix3zB0
	JOEeR/anzpvXPLEmu9HDfalQvtnwRJf3uTEwiYNRGq5EqsO1O2Onc/N9Qthf4qzv71wEdbaKwK5
	yHbeH6c+1t8SZKSeuADPTh08L5yyiHAWeuywWZjvj37fiw9+o5cn+2E246kEfsj81lxoG5aq8jJ
	LkH2bI9S6Vcj9OtitwYfJlW57xiwoNZbpDO8kq4vBdYU8qeFLUmQIHXCAJxY9KZsN3RE0/aNkq8
	sd9dmT6NhYdY0a7njBMaaZ/eEBQew2fV3ZRNoULSWTY5VLkhLDYKx0K4whJeyJY=
X-Google-Smtp-Source: AGHT+IHN0e1fpOoTbsMAs2QQufi3FSf0J+4G+aZV5JjMvZYozX8ZWEgVgEOCKkM+nr9xawgbfp8JOA==
X-Received: by 2002:a05:6214:2485:b0:6e6:6caf:e6f6 with SMTP id 6a1803df08f44-6e697506db1mr65816956d6.16.1739977619274;
        Wed, 19 Feb 2025 07:06:59 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d9f31b0sm75212816d6.90.2025.02.19.07.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 07:06:58 -0800 (PST)
Date: Wed, 19 Feb 2025 10:06:58 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: jasowang@redhat.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 mykolal@fb.com, 
 shuah@kernel.org, 
 hawk@kernel.org
Message-ID: <67b5f392408d7_1b78d8294e7@willemb.c.googlers.com.notmuch>
In-Reply-To: <dee9bc39-e666-4d97-8a42-240ffb458bcc@hetzner-cloud.de>
References: <20250217172308.3291739-1-marcus.wichelmann@hetzner-cloud.de>
 <20250217172308.3291739-3-marcus.wichelmann@hetzner-cloud.de>
 <67b3e6b6b9dc6_c0e2529482@willemb.c.googlers.com.notmuch>
 <dee9bc39-e666-4d97-8a42-240ffb458bcc@hetzner-cloud.de>
Subject: Re: [PATCH bpf-next v2 2/6] net: tun: enable transfer of XDP metadata
 to skb
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Marcus Wichelmann wrote:
> Am 18.02.25 um 02:47 schrieb Willem de Bruijn:
> > Marcus Wichelmann wrote:
> >> [...]
> >> +	metasize = max(xdp->data - xdp->data_meta, 0);
> > 
> > Can xdp->data_meta ever be greater than xdp->data?
> 
> When an xdp_buff has no metadata support, then this is marked by setting
> xdp->data_meta to xdp->data + 1. See xdp_prepare_buff or
> xdp_set_data_meta_invalid.
> 
> In the case of tun_xdp_one, the xdp_buff is externally created by another
> driver and passed to the tun driver using sendmsg and TUN_MSG_PTR. For
> now, the vhost_net driver is the only driver doing that, and
> xdp->data_meta is set to xdp->data there, marking support for metadata.
> 
> So knowing that vhost_net is currently the only driver passing xdp_buffs
> to tun_sendmsg, the check is not strictly necessary. But other drivers
> may use this API as well in the future. That's why I'd like to not make
> the assumption that other drivers always create the xdp_buffs with
> metadata support, when they pass them to tun_sendmsg.
> 
> Or am I just to careful about this? What do you think?

I agree.
 
> > This is pointer comparison, which is tricky wrt type. It likely is
> > ptrdiff_t and thus signed. But may want to use max_t(long int, ..) to
> > make this explicit.
> 
> Ah, I see, good point.
> 
> So like that?
> 
> 	metasize = max_t(long int, xdp->data - xdp->data_meta, 0);
> 	if (metasize)
> 		skb_metadata_set(skb, metasize);

Or just this? Also ensures the test uses signed int.

    int metasize;

    ...


    metasize = xdp->data - xdp->data_meta;
    if (metasize > 0)
            skb_metadata_set(skb, metasize);


> Alternatively, there is also xdp_data_meta_unsupported(xdp_buff) which
> could be used to make this check very explicit, but I don't see it being
> used in network drivers elsewhere. Not sure why.
> 
> >> +	if (metasize)
> >> +		skb_metadata_set(skb, metasize);
> >> +
> > 
> > Not strictly needed. As skb_metadata_clear is just
> > skb_metadata_set(skb, 0). But also not wrong, so fine to keep.
> 
> Oh, haven't seen that.
> I'm following a common pattern here that I've seen in many other network
> drivers (grep for "skb_metadata_set"):
> 
> 	unsigned int metasize = xdp->data - xdp->data_meta;
> 	[...]
> 	if (metasize)
> 		skb_metadata_set(skb, metasize);

Thanks for that context. Sounds good.


