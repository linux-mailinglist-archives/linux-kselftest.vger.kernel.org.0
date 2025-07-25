Return-Path: <linux-kselftest+bounces-37986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5BEB11F09
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 14:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5874E5654DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 12:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AE72ECD1C;
	Fri, 25 Jul 2025 12:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfciSWEb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417B02D8784;
	Fri, 25 Jul 2025 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753448146; cv=none; b=klsAmmhIvPqPAJtzuD2TsvgFpaXarsFQJ6qgiM/CPGNOVRu2E3jikhULx7g02HzI4VcgeNwXe+c3vLr8FmvPawyAtgWoO2NiXWOW4S2FEtQefaG947Y76Aln1gKq9ebQtX9bHc5g0jtTIfmNmX2Z96U0NcHzt0FAurxkFBStkRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753448146; c=relaxed/simple;
	bh=+96td86pl6RYvdjPgEXEaY4yH4Llt3TUn3hBrBZc3sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWzxfcmFh0n87UElgWu6n9oHP+ho0wuWmjqmS5JFwk0fkBv5Lkh9a7r7Wh74DRDguhhc0OYGHmRXj3uwVA23nwhIB+VFilfS2Zf4IKxtAHZa5aKBhg1OZI9XU/cjp9/n3B0Vi4N7DtksZwB9ccDxRijrbahvWN3iBOgKmekTAN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfciSWEb; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-31e7e3dc5d2so219767a91.1;
        Fri, 25 Jul 2025 05:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753448144; x=1754052944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qGEpXVAlxD3K+ugg3yuPPR4elZ+lMYltBWlc9KeJ+S0=;
        b=IfciSWEbzFc9tbXLQI9i5nAA5ALGIIv0NzFeuneN1p0h2ysyF0FQF5U3MoZYkeu9Yj
         EiLnds/iCjv3Va6NXCzqVB3J1PsvKBNdg1PaG9jZjTwyJBKAnFEtwpl27tdYsashv6HY
         wdarg8QNOScFyIBp+Xu10qX8glep0OvM6EqcgUS5Go2ATLL+3lZ14vjCyNM09lzQLmAD
         N9XSfiYNwoufvdaQpyUg3V9bljnbTm8gGTEYtEbGgVe4XT2zLqb/+2Urnt7BTi0sjfBR
         3XeE2ORTHXta/Sd3umWk3X6yLEJAbxmy0Kg34wI0Eyg5N4RU38I70exZSCA88hB0ur03
         ciJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753448144; x=1754052944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGEpXVAlxD3K+ugg3yuPPR4elZ+lMYltBWlc9KeJ+S0=;
        b=XSBO2Y1uE6HXYbm4OSGL5WZr31+TElSRQAI8CTyjj96YbJx8isTyXf2ar8g9ggWGUR
         ZnrUgZWfZKYfSaaA2dYWB3hgwVWUD0pCFcR3qjJUMbYpiQk/anFTqFvNz37amR8sFaWD
         TEd5rrdrftwnPIdBIy46lRWMt0QFutY4LixNn6pY8+8cYrEx+FNGI9gCgyX2C55VGjwA
         yhMMoSUi3k5VI+dtEB+ZsrXx3s6dOBXAsozoX0Rk2b4eU6xAfIWVKV7bclSIPLdISP0H
         hnWP/FxFehzYd8e405zziVEuD+xb6FNjDzKkeuV+rleEUuIp3/dGoZH4bnm4v0O1V+Nl
         m7kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQXQGEkM97W7TqatlfMPfqG3QT6xoEzmzpgBH/XdLkmojbVxT3X1D2LdFAMM3UHsIxzf3CuY4TyiE=@vger.kernel.org, AJvYcCVpNYPTNXBeTw7T173MhUKseqLKhX0tERP6xfEIzbCAPYBDFqi+ovkx6f8WfMtODvzUweGLQDDzulWKwlf2@vger.kernel.org, AJvYcCW82nyw5qnCO9UZXvxOTUJzDBO6O9UFkOZrr5ljNTG2USfb11OepIZKaUwZ+F6ZjroKTMjIiC2Lh5SyhYPoIRI9@vger.kernel.org
X-Gm-Message-State: AOJu0YyIhuCDXXMzJDKMDJP+0YPQphXxNy7TaoAqyPtV+n1KiL2nzV1J
	sgwkYAw/uSLvridxSuL8A4WQRzvBMdtOtfmyvPpAOPUy/fIFmoG4bYz/
X-Gm-Gg: ASbGncuLcahbDDZ1TzRKOjYixirTwBgNOb9WIeJBJLiYI4CXCvc0aTDR17BMgKxKH89
	FhW43uaSMbSxPBT6zRU050nyZ3/9JoqXqmF88RH/Az9og16bl+QUu+fklXVy4d9pvirrg56GEVk
	W4Ve7fF0slmvdtuHmKZXUBlrmP6tu22BRzYYE70N4IQR7znSUe0NNjDlktSTimTWpTyJ1ML8OjB
	srTLUIyV3aZdI6twk1ysDen12zJWJk/0R4vKVJd3J4hPiXidXtCxmSUjFBKBXIDokEQjDWae7ej
	/Xgs7G4kKA4ZbdlA1kz7MYj+qqU8g7fLxzE/BKI0jG9XXzYestl9S0p+enj66BPgbb05plJYOn5
	MNH/NAzuu37Wa8FzsjcfeauFzch8=
X-Google-Smtp-Source: AGHT+IERyHyW3IcBP+fSmwCMOKFhQWtZFxxc56mB48/vivDFg9NwEVPKFDWWB5I+SUZCA98cM3tnPg==
X-Received: by 2002:a17:90b:1b45:b0:311:f30b:c18 with SMTP id 98e67ed59e1d1-31e7785ee72mr2444832a91.4.1753448144231;
        Fri, 25 Jul 2025 05:55:44 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e662f6ebdsm3461314a91.37.2025.07.25.05.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 05:55:43 -0700 (PDT)
Date: Fri, 25 Jul 2025 12:46:00 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Petr Machata <petrm@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alessandro Zanni <alessandro.zanni87@gmail.com>,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] bonding: send LACPDUs periodically in passive
 mode after receiving partner's LACPDU
Message-ID: <aIN8Rpc8YELX2QD6@fedora>
References: <20250725062848.18889-1-liuhangbin@gmail.com>
 <20250725062848.18889-2-liuhangbin@gmail.com>
 <367f9bbb-537b-4828-b8c8-cfc9d8ca8c2c@blackwall.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <367f9bbb-537b-4828-b8c8-cfc9d8ca8c2c@blackwall.org>

On Fri, Jul 25, 2025 at 11:49:00AM +0300, Nikolay Aleksandrov wrote:
> On 7/25/25 09:28, Hangbin Liu wrote:
> > When `lacp_active` is set to `off`, the bond operates in passive mode, meaning
> > it only "speaks when spoken to." However, the current kernel implementation
> > only sends an LACPDU in response when the partner's state changes.
> > 
> > As a result, once LACP negotiation succeeds, the actor stops sending LACPDUs
> > until the partner times out and sends an "expired" LACPDU. This causes
> > continuous LACP state flapping.
> > 
> > According to IEEE 802.1AX-2014, 6.4.13 Periodic Transmission machine. The
> > values of Partner_Oper_Port_State.LACP_Activity and
> > Actor_Oper_Port_State.LACP_Activity determine whether periodic transmissions
> > take place. If either or both parameters are set to Active LACP, then periodic
> > transmissions occur; if both are set to Passive LACP, then periodic
> > transmissions do not occur.
> > 
> > To comply with this, we remove the `!bond->params.lacp_active` check in
> > `ad_periodic_machine()`. Instead, we initialize the actor's port's
> > `LACP_STATE_LACP_ACTIVITY` state based on `lacp_active` setting.
> > 
> > Additionally, we avoid setting the partner's state to
> > `LACP_STATE_LACP_ACTIVITY` in the EXPIRED state, since we should not assume
> > the partner is active by default.
> > 
> > This ensures that in passive mode, the bond starts sending periodic LACPDUs
> > after receiving one from the partner, and avoids flapping due to inactivity.
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> 
> Shouldn't the fixes tag be lacp_active commit id?
> E.g. 3a755cd8b7c6 ("bonding: add new option lacp_active")

Totally forgot that I added this option -_-!!

Thanks
Hangbin

