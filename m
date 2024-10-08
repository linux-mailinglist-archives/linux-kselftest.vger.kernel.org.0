Return-Path: <linux-kselftest+bounces-19243-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BA79951AF
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 16:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D24A2874DF
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 14:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3B01E04A1;
	Tue,  8 Oct 2024 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGkV9mJe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B62F1DF997;
	Tue,  8 Oct 2024 14:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397611; cv=none; b=kgZrFgyB/eW80yWxTBPMIXbV05pLEJmzNOobNNXYoCxvsP5Q4fpbPA/qh1PRtueXTJX1x+FKfNGB5xdHGSgG4nwNqAcBT4VwtxwW2pd1ksITz3819xDzljYmM56Jcz4qH+0wvplxPVP6o5+HBIEO3tfL4duRONwrQ+crn9tTl88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397611; c=relaxed/simple;
	bh=5ou9s79hZP7IJi0atBe2w+sGV08MvzEwGEPv46Ev4SI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=gjX4nOV4vijc+kfV6MNE3yJmt/JgQcSCequDUujSBoCOEry1Nr5ITruQIW0GKnFGvNiZwJ48ZEaOfd0oA6R8dpgIYwrf/BF7P+xoXjW9cPWn774T0HDQAGl8UgjsLz/fg6kTgJSvwyToaIbbf0PGj/QyJmVQ51zzeDOjNVL6qt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGkV9mJe; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cbc565ec74so3539386d6.2;
        Tue, 08 Oct 2024 07:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728397609; x=1729002409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uxRQHc+uPQaV16IH3xwpSF/k0OvqVA7/Q2MK0pWFB0=;
        b=fGkV9mJe++P67WGU3YuBanHFL4keij/yVyBudh7+o+oZrJS4LRV9y5ICD6XjYfnkA5
         1TfhEmXXr1vD46M1xhQMEewoA4pxhUOCIhUAHw1XG6UAm9WwSOKRnYgxkI6vaQAcYBax
         X2qsDnKkJ7zVyn3Pz5rudRkOI9oyOl5Qio5QZKdT3XkLaV3sbYksvRWqf2ciatQLjjYj
         uisGc/cvswUg247Udl81qDLqAOxOCnkihyi9RKZ/GNFf5hfFnz9J0m7fVjlcyPFjhDk8
         GHBFvpZbZVe4uAfehMh1EFUzccZf7i+grzCAsegr6yMZ5FyDyVklQNlatzWhbq2F4GRv
         q9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728397609; x=1729002409;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+uxRQHc+uPQaV16IH3xwpSF/k0OvqVA7/Q2MK0pWFB0=;
        b=QbYZRy+5mlCBk+g8oD6/epcV0AzRZieflNp6z2LgHYc/0g7bN9xhpE6iLBv5vfOIjy
         mgupqWZeQl3E4bXOR7sf973L9ejGIlqH6q2OsU6Siezdgw/yfmcT6ZrHZxbDDi8aAw50
         fEYPXW/pAkzEo4bbsiGE3O9jznlI4gvXm4gtjnAJHn0RYUKdrpSL4IEq9ZmfNQkVWJlH
         eOL6+BOH5ztFpyE2IOURCa6CxQa3BXMglASHpVHvmMMQAUZK1T+515HmUh2J8Hg0ZBhP
         JoozEot2mB4hUAjxPzFeib+hcbyxPiQduxOVGjODf8bUYc5jHaqQMkk/5mKiSZqfs2p/
         iTSg==
X-Forwarded-Encrypted: i=1; AJvYcCUOtqDmsSc8u4UCMwwa9FWlRddl5Q7C2Ie78LMoZR4bV31OEVbO/ygyFx3XaJbSCUsuik4lgg+grJaG9YTKX4+k@vger.kernel.org, AJvYcCXsb388X/WitTeC2cVcZQr5wA5lArFJEGSVjpI89dc39ty4N6yFn3W36kHvbpk8XnEZ3uHJIDCHYpWpt80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/lEhax0BJddRM12QwP2beepSLMW4h8rXqkCZRAPNLZa4mvxkJ
	OcGf6EJImxBuPaa8Ins8ipJBhzi6M8bvgRYwa7oi3Oyv8GlJVf1l
X-Google-Smtp-Source: AGHT+IE4jKK4xIe2uPWyxTBGz2FMwZiAjK08LFfGYKVQi7oYYTllFNlIG9gucViV8dF0Wew1mIKE3g==
X-Received: by 2002:a05:6214:3c98:b0:6cb:3c08:30a0 with SMTP id 6a1803df08f44-6cb9a49d136mr282176306d6.49.1728397608977;
        Tue, 08 Oct 2024 07:26:48 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba46e3a8bsm36099356d6.58.2024.10.08.07.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:26:48 -0700 (PDT)
Date: Tue, 08 Oct 2024 10:26:47 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Gur Stavi <gur.stavi@huawei.com>, 
 Gur Stavi <gur.stavi@huawei.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 linux-kselftest@vger.kernel.org
Message-ID: <67054127bb083_18b21e2943f@willemb.c.googlers.com.notmuch>
In-Reply-To: <05852e3043d2b0a7a5ca51d456e82966dcb72f03.1728382839.git.gur.stavi@huawei.com>
References: <cover.1728382839.git.gur.stavi@huawei.com>
 <05852e3043d2b0a7a5ca51d456e82966dcb72f03.1728382839.git.gur.stavi@huawei.com>
Subject: Re: [PATCH net-next v02 1/2] af_packet: allow fanout_add when socket
 is not RUNNING
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Gur Stavi wrote:
> PACKET socket can retain its fanout membership through link down and up
> and leave a fanout while closed regardless of link state.
> However, socket was forbidden from joining a fanout while it was not
> RUNNING.
> 
> This patch allows PACKET socket to join fanout while not RUNNING.
> 
> Signed-off-by: Gur Stavi <gur.stavi@huawei.com>
> ---
>  net/packet/af_packet.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index f8942062f776..fb2cca73d953 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -1846,21 +1846,21 @@ static int fanout_add(struct sock *sk, struct fanout_args *args)
>  	err = -EINVAL;
>  
>  	spin_lock(&po->bind_lock);
> -	if (packet_sock_flag(po, PACKET_SOCK_RUNNING) &&
> -	    match->type == type &&
> +	if (match->type == type &&
>  	    match->prot_hook.type == po->prot_hook.type &&
>  	    match->prot_hook.dev == po->prot_hook.dev) {

Remaining unaddressed issue is that the socket can now be added
before being bound. See comment in v1.

>  		err = -ENOSPC;
>  		if (refcount_read(&match->sk_ref) < match->max_num_members) {
> -			__dev_remove_pack(&po->prot_hook);
> -
>  			/* Paired with packet_setsockopt(PACKET_FANOUT_DATA) */
>  			WRITE_ONCE(po->fanout, match);
>  
>  			po->rollover = rollover;
>  			rollover = NULL;
>  			refcount_set(&match->sk_ref, refcount_read(&match->sk_ref) + 1);
> -			__fanout_link(sk, po);
> +			if (packet_sock_flag(po, PACKET_SOCK_RUNNING)) {
> +				__dev_remove_pack(&po->prot_hook);
> +				__fanout_link(sk, po);
> +			}
>  			err = 0;
>  		}
>  	}
> -- 
> 2.45.2
> 



