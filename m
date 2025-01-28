Return-Path: <linux-kselftest+bounces-25309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F5BA20C37
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 15:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3733A5D5A
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 14:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7514B1A83E5;
	Tue, 28 Jan 2025 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlRZLirg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5F019EED7;
	Tue, 28 Jan 2025 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738075542; cv=none; b=UKNRXI8jMVGFOjTr1xQW/zzgK0UAIQ7ECPGa4qfqhya8n5WJxwPCHOGcJ/Rrl75YnKK1xySdCXxTD0jhNBVXVKb2nYWbwJ8mzied1qfAKtW43J4uO8ihyGJIEqF0lZkt0lpNSMv9ABz9++/6+5qIccLBl6gbj3x4PeFXz6reRAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738075542; c=relaxed/simple;
	bh=/csEvLRUMucPRyRdSUwZOs8F0rkU5vIyJTNl6uyBlR8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=cANS/6VhZ5adXYIkkI8cXMp3bfiN0wmZkkfEXt8NSJr1bzABT84ANyQ/sqOxI9gLJgJEa+4dgh6W5mUMH0V0mqO7I4GEw/mn9CXVFgNnBC/9ezlOEWWdaNUHzD791p8uaRaArgfLlSdU19Y5/xdPjUcA8kjr2WLojgU7w44vjko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlRZLirg; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-51640f7bbd3so1821312e0c.2;
        Tue, 28 Jan 2025 06:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738075539; x=1738680339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fakcm+rH6Ht22JqZeovxMYLDOTFTQ4rDAH4rXh1qvOE=;
        b=mlRZLirgudvDOE9ztoVVFpVNUIyEP1s9M0yN+PR6IUlr2APgSiCgrhTOepExplldS1
         UbYzmcyX1mBv2cyikPNgyyHSGJxwc6DKAIe89UYTz4wcDc80ROI+kySx4Bp5eRetPWqp
         scD3RnOqjoymVgMaY6liCaCtqK6u6iR5k5YmGLUVT9k7aTfg1EHPLwEcbba8+lPWzX9K
         YbmnJqVEVQFJpbeTsn4GAToaTJaiinHGeGozRjEppG8gT+VSDLP4r9tKgNMfop8UbVqo
         RgC5znHf+yq9rj1ofCpqIA7xIWSjfTwMXNWXiIQKPji/PtcTU9vuNKlLvmEveglJaNLg
         FUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738075539; x=1738680339;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fakcm+rH6Ht22JqZeovxMYLDOTFTQ4rDAH4rXh1qvOE=;
        b=vCug+FnIM/PFP7lL8hExBSXWlc5eLTJQPEGYYqG5GKA9aRFR1BYpIK7QYRTllsLeFu
         T24dKaBm8R7gFIcNg9+sYN/bd4SKHWY40sPBpHErMYrFJl8qT2MHhCbWmZjMPGk6LfBp
         I9p23QT6ugWiOStpWpPj2mELyW7dDbfALbkaD9MlYDw8FUXhwvDCZXZh2dpH7WgvYVyY
         /sWJBQuTIGisIc+ySawnXqbomtcHtSZHcaR9Wu5UgHpdv+JL2U0Fq9rYKMfoi+bmEOpF
         EEd7H2EvG/smwICG7psUnuYjUSvCLgy13u9K/JDLSlPL+bcrKDUJEdyzWUfPC5YY3NJP
         SCHw==
X-Forwarded-Encrypted: i=1; AJvYcCUN3WVwZeTVwiacZtMNJXV91XYrFWMVChh5+5g14eEDl09AVQXHCkMRBFBH8fVZ2LiigeoCQXaCpKxkFDQ=@vger.kernel.org, AJvYcCWXDsauzQr/F/WPqiUBKewgm7KZaeGD63/QBgMp+z3Dk3BF+obsJz3/WVWQRI/S0LckkQ5gsqVJzr4O98SBdKNt@vger.kernel.org
X-Gm-Message-State: AOJu0YyXDbPp4kpsmP4FVEfugzFS94Zj56uId3L9apitLGwG/kxnq89V
	mcO49WqqxmjxK0rQH9cKiLzmRezkMtagorlsS6vlt54xbvfwErMn
X-Gm-Gg: ASbGnctWAPHNLob2jYg9tctAs5tbHufDr51mHR5IXmzaOdIApRNUArKMT0ujAACFoPD
	z+sQapljqBnjod2dhxEsIY/4JpScWliMWpdTaWRfsDgGaZQNgBp1udk/j2A3co6L03LlH1vkQb9
	H8psj2keB3enpQPJATAOnJKRfW5E9gDx9em6OsVAudrOHWPhnkOAaB10PUgM44szX8MH6TnwrQT
	8gkGflLfidFgRsqLmcU/hRbFj2nY2rCuC3mUk9KjVF1HS6oP4zRIkgE5paOW2f+JuaN7qYvt8YE
	2+EJtGeHtr7+HMigMJy5Qba/xG+LRdD3Nm932LN2k9omrDY3yKhIKgMUw70omjY=
X-Google-Smtp-Source: AGHT+IH15H9JPwbH1F+JmB7HXP9OTFcSXFQ71rdpzS8md7yeH76V23u8pEHPsJ4aRsKMybm2dXZw0w==
X-Received: by 2002:a05:6122:29c2:b0:518:865e:d177 with SMTP id 71dfb90a1353d-51d5b33f5c9mr37756715e0c.9.1738075539555;
        Tue, 28 Jan 2025 06:45:39 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-864a9ada068sm2406919241.5.2025.01.28.06.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 06:45:38 -0800 (PST)
Date: Tue, 28 Jan 2025 09:45:37 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Yan Zhai <yan@cloudflare.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Josh Hunt <johunt@akamai.com>, 
 Alexander Duyck <alexander.h.duyck@linux.intel.com>, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <6798ed91e94a9_987d9294c2@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAO3-Pbqx_sLxdLsTg+NX3z1rrenK=0qpvfL5h_K-RX-Yk9A4YA@mail.gmail.com>
References: <Z5cgWh/6bRQm9vVU@debian.debian>
 <6797992c28a23_3f1a294d6@willemb.c.googlers.com.notmuch>
 <CAO3-Pbqx_sLxdLsTg+NX3z1rrenK=0qpvfL5h_K-RX-Yk9A4YA@mail.gmail.com>
Subject: Re: [PATCH] udp: gso: fix MTU check for small packets
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yan Zhai wrote:
> Hi Willem,
> =

> Thanks for getting back to me.
> =

> On Mon, Jan 27, 2025 at 8:33=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Yan Zhai wrote:
> > > Commit 4094871db1d6 ("udp: only do GSO if # of segs > 1") avoided G=
SO
> > > for small packets. But the kernel currently dismisses GSO requests =
only
> > > after checking MTU on gso_size. This means any packets, regardless =
of
> > > their payload sizes, would be dropped when MTU is smaller than requ=
ested
> > > gso_size.
> >
> > Is this a realistic concern? How did you encounter this in practice.
> >
> > It *is* a misconfiguration to configure a gso_size larger than MTU.
> >
> > > Meanwhile, EINVAL would be returned in this case, making it
> > > very misleading to debug.
> >
> > Misleading is subjective. I'm not sure what is misleading here. From
> > my above comment, I believe this is correctly EINVAL.
> >
> > That said, if this impacts a real workload we could reconsider
> > relaxing the check. I.e., allowing through packets even when an
> > application has clearly misconfigured UDP_SEGMENT.
> >
> We did encounter a painful reliability issue in production last month.
> =

> To simplify the scenario, we had these symptoms when the issue occurred=
:
> 1. QUIC connections to host A started to fail, and cannot establish new=
 ones
> 2. User space Wireguard to the exact same host worked 100% fine
> =

> This happened rarely, like one or twice a day, lasting for a few
> minutes usually, but it was quite visible since it is an office
> network.
> =

> Initially this prompted something wrong at the protocol layer. But
> after multiple rounds of digging, we finally figured the root cause
> was:
> 3. Something sometimes pings host B, which shares the same IP with
> host A but different ports (thanks to limited IPv4 space), and its
> PMTU was reduced to 1280 occasionally. This unexpectedly affected all
> traffic to that IP including traffic toward host A. Our QUIC client
> set gso_size to 1350, and that's why it got hit.
> =

> I agree that configurations do matter a lot here. Given how broken the
> PMTU was for the Internet, we might just turn off pmtudisc option on
> our end to avoid this failure path. But for those who hasn't yet, this
> could still be confusing if it ever happens, because nothing seems to
> point to PMTU in the first place:
> * small packets also get dropped
> * error code was EINVAL from sendmsg
> =

> That said, I probably should have used PMTU in my commit message to be
> more clear for our problem. But meanwhile I am also concerned about
> newly added tunnels to trigger the same issue, even if it has a static
> device MTU. My proposal should make the error reason more clear:
> EMSGSIZE itself is a direct signal pointing to MTU/PMTU. Larger
> packets getting dropped would have a similar effect.

Thanks for that context. Makes sense that this is a real issue.

One issue is that with segmentation, the initial mtu checks are
skipped, so they have to be enforced later. In __ip_append_data:

    mtu =3D cork->gso_size ? IP_MAX_MTU : cork->fragsize;

Also, might this make the debugging actually harder, as the
error condition is now triggered intermittently.

