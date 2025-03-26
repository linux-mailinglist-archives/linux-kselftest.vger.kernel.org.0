Return-Path: <linux-kselftest+bounces-29810-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD443A71464
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 11:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C09518832B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 10:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB841B393A;
	Wed, 26 Mar 2025 10:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ziv9gCRa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6671B042E;
	Wed, 26 Mar 2025 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742983422; cv=none; b=rdgAj1yNt7xkp8YskbtXcjjZwrg1+rEGN2v5y7obqg0Xcy63YZPXfLpsLEVwnj7Mg+tePQHBCPoTDcsFIYYq7fjhJ5XPXH6pGUTvE2+/eZ97ML69uEmmzlSvZEg0oTltVAjKSYVBMCVmsroXrh7O6+0KD/uu9qyf/6POfMQ4PXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742983422; c=relaxed/simple;
	bh=HJ3gprdMqDj0iPn/NsbKYPp2Aox6dbbVfA+al+1YtVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c74Dr+OzQgZtR334Q0J1KxbYej//6vF1Qrfx4BophO78oaPibZQZ+6hq2H6r+zG0DCmSDXEBl3GOelhUTxW9FmCiQ+eCbFVeJVCU/dgms2MJ7q33Sce6RWegqyaZWPVON61UWVoXpLBnD/WdVJRHiYo+q7DYezouTHQ/vMH5jeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ziv9gCRa; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e60aef2711fso4553327276.2;
        Wed, 26 Mar 2025 03:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742983419; x=1743588219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wvv2RTdKEHVFe+FXyA9kfktlP0uXuSbV+dmgE6Pnc+k=;
        b=Ziv9gCRaSPet1NAyPwfhZUAvkYCgcwVmBL7mpYA84TI+pgNgEnatfbgd/kGtL7ohTI
         Y6wmIHgo3vhAOfPpjyGHg+wm6lwDXoKF7bj2+jz0t0LCZuIuBt5Dp8quvRzbuSTmxcvp
         7jcxhO6BtxD8K00bgXK17EyztnzrchbBffdH7CV93yP5EtwTTAw++FJdYW7ZRrXt91am
         gllVhwVikJKLKxRUMC0opLw2itVScqEZatXmtn22n0IP72KSBvYSe24zBS8tVoSKmvKO
         y40HEcIU2VTXQTsZljMTzP1cGrS56wBY4n7nkAbdBnuW3NSDXn/VrRVIoFMeELfRoK5i
         hl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742983419; x=1743588219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wvv2RTdKEHVFe+FXyA9kfktlP0uXuSbV+dmgE6Pnc+k=;
        b=Bn/nPMVkbqmA1eMqFxgUq0IphEW1E+HB3evWWM8lydTzrhSfdBBf6XqOf+G3ZCM1kL
         6OA5RQPfQj6tima9Z1pfgzH5jk+1K0yAghCmtdcuzySF2LOcyHLuz4eu4KpNE9tR7yNE
         dfjWVOLpS46u3QPeqCz1xHnyMWwZEoBIz7YM516NS7jUP5I1rIlXdkj9zgS/TFHfHJEY
         K/YNm6m2VUu8klW0h7+zZyt5Zd/U+gfNvcfkcbve2qSHDb2Ocse8TcfIz3qsaU5J/lqA
         oCNMq74OMeS0TCnP4gHfZ4dH+PIc47EwzILK40MS7reLzuGfJvCI/xbFq+D+rDmezAyB
         /lqg==
X-Forwarded-Encrypted: i=1; AJvYcCU7nWjHxefgY1suAJz071rX9afDXuqbikqZzAnzuZ8OZ/HZtWO2b7VZHzcbFHLHUn0Rkwn05GdD6NCyXdI=@vger.kernel.org, AJvYcCXHSyiaeSnrkd15Rh9K62dj8KGXsg+zjQY5MPdrGJz/CcZkflvjJUIISWXdNrxYzivWJg28OMfv6AtQWck7d307@vger.kernel.org, AJvYcCXXgPc96lHLIZXKdGOjjKcVomLLMHL4gwUIuACmsA+NXb03Xf8+1aRZz1EtZ1ABzKqKjWBffO6C@vger.kernel.org
X-Gm-Message-State: AOJu0YxA9JyrZsqan9K2cAMhihv01/YVNZeUGQbt6JRjkVw1y8BtKJy1
	OIZcsHHGdwSV426KxlODzBQN316LSjNHcKc1s80nWRd55nGX/ba/NdK8v8WCZXbyiT9YLqzZLb4
	3MpAtFYfS+ocrEZhbRENAk+Il00s=
X-Gm-Gg: ASbGncsDDULw+Fh9h81v3+Yuiph9//4h4nM9QVwwUDC2MfMne5JydSOpTczWWDr0te2
	KMkPTKndiU7B/cYpLnlMICR0K8LKKwrQgy1gJPnoVP6qIimvcCbpHSb1r/tvRc7MmnBSErS2x81
	CRhc7jzS2Ze6rbLFiXHNcGt32IfixhcO2xHXgbuEiRr2WIkdFZ1YnvlciGxYY=
X-Google-Smtp-Source: AGHT+IHfEOzHO1fYx7U+bN8g64kmS09vUyTz5cc994A7TecNF6Wc4s6Y44wxmCJ+lWJwy6Ib66Bha0rOE1l7VZLPNi0=
X-Received: by 2002:a05:6902:230f:b0:e63:6f6a:ab01 with SMTP id
 3f1490d57ef6-e66a4dafdf3mr25734001276.20.1742983419395; Wed, 26 Mar 2025
 03:03:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318-b4-ovpn-v24-9-3ec4ab5c4a77@openvpn.net>
 <20250325020802.7632-1-dqfext@gmail.com> <58712444-1de7-4076-b850-4c6035792931@openvpn.net>
In-Reply-To: <58712444-1de7-4076-b850-4c6035792931@openvpn.net>
From: Qingfang Deng <dqfext@gmail.com>
Date: Wed, 26 Mar 2025 18:03:18 +0800
X-Gm-Features: AQ5f1JodHKEa5grFLdeljTe4mQhPAz1IoFEnU6LC0ro2dUjIEtLY-zmsGMtFm9U
Message-ID: <CALW65jZ=Jngf0THLTuWHuhpQb0NDM=4x4HN_Xj922nmq71EMUQ@mail.gmail.com>
Subject: Re: [PATCH net-next v24 09/23] ovpn: implement packet processing
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, 
	ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Xiao Liang <shaw.leon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Antonio,

On Wed, Mar 26, 2025 at 5:41=E2=80=AFPM Antonio Quartulli <antonio@openvpn.=
net> wrote:
> >> +/* Get the next packet ID for xmit */
> >> +static inline int ovpn_pktid_xmit_next(struct ovpn_pktid_xmit *pid, u=
32 *pktid)
> >> +{
> >> +    const s64 seq_num =3D atomic64_fetch_add_unless(&pid->seq_num, 1,
> >> +                                                  0x100000000LL);
> >> +    /* when the 32bit space is over, we return an error because the p=
acket
> >> +     * ID is used to create the cipher IV and we do not want to reuse=
 the
> >> +     * same value more than once
> >> +     */
> >> +    if (unlikely(seq_num =3D=3D 0x100000000LL))
> >> +            return -ERANGE;
> >
> > You may use a 32-bit atomic_t, instead of checking if it equals
> > 0x1_00000000, check if it wraparounds to zero.
> > Additionally, you don't need full memory ordering as you just want an
> > incrementing value:
> >
> > int seq_num =3D atomic_fetch_inc_relaxed(&pid->seq_num);
> >
> > if (unlikely(!seq_num))
> >       ...
>
> But then if we have concurrent invocations of ovpn_pktid_xmit_next()
> only the first one will error out on wrap-around, while the others will
> return no error (seq_num becomes > 0) and will allow the packets to go
> through.
>
> This is not what we want.

Got it. You could replace it with
atomic_fetch_add_unless(&pid->seq_num, 1, 0) and check if it wraps
around to zero.

However, what about the opposite scenario? If multiple threads
concurrently invoke ovpn_pktid_xmit_next() and all detect the
wraparound condition, could this lead to simultaneous calls to
ovpn_crypto_kill_key() and ovpn_nl_key_swap_notify()?

>
> >
> >> +
> >> +    *pktid =3D (u32)seq_num;
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +/* Write 12-byte AEAD IV to dest */
> >> +static inline void ovpn_pktid_aead_write(const u32 pktid,
> >> +                                     const u8 nt[],
> >> +                                     unsigned char *dest)
> >> +{
> >> +    *(__force __be32 *)(dest) =3D htonl(pktid);
> >> +    BUILD_BUG_ON(4 + OVPN_NONCE_TAIL_SIZE !=3D OVPN_NONCE_SIZE);
> >> +    memcpy(dest + 4, nt, OVPN_NONCE_TAIL_SIZE);
> >> +}
> >> +
>
> Qingfang, may I ask you to remove from your reply non-relevant code
> (like I did above), especially in such long patches, as it becomes a bit
> tedious to spot your comments and I may miss something.

Noted.

>
> Thanks a lot!
>
> Regards,
>
> --
> Antonio Quartulli
> OpenVPN Inc.
>

