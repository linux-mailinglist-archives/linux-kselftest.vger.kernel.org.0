Return-Path: <linux-kselftest+bounces-38742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B804CB21A6A
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 03:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62AC6628240
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 01:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618D92DA758;
	Tue, 12 Aug 2025 01:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItOeHoro"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F339C155A4E;
	Tue, 12 Aug 2025 01:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754963632; cv=none; b=Mj0BOSZF3vyazlQO3JhuW0cYRSGErl67g2OaNkAZpN0lkDOl+UT18/TgoODb8Cq2zVVpbC2usf1wmrS6zAGGEfEBOO8SC+U7fx+RHAzhuNTevmdbVOrhecwupKCnEp0t2aMRCubNcAXCPrAnXk1gu6Z/QRIMxRT4d0ThjyN7B5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754963632; c=relaxed/simple;
	bh=kbjk1NE25U+D+cdIZ8WClPsz5FPrJ9ZGpFCxJb02zSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPfrBWGaejlx1R6hsXsTZBSkiV8bfntPsy1aigPEvGiQO9dmYAZPj1UjxmpM2IcNLxbeKPDovdpy/2UyU+fkqsYQQAf5vMzDpkcGKvoPIDe+1vJedZNy2RtqeQyPa0kBx5s0eEqMVbJZNzmMXi2yro0mhBqjyz2BKFVm80ph7kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItOeHoro; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-af51596da56so3806879a12.0;
        Mon, 11 Aug 2025 18:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754963630; x=1755568430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2TM2/7lE7zgF0cwNVS0H6okln7+yKWK+fmjDA20yXco=;
        b=ItOeHorotzqoOfAi62HfYv00md6rQrsFSw7ydKqW3eOV4izfTjoR3URgivJKPQejQP
         cONURLG3UNURFScWKfLWycrfvhlJZU7jaXlv9Tc2jrB4bajZAucSkJUILk1RSM8m2fI4
         iIJglDSm9knb8KkG5AxgBs632JEsqVIRKm54E4XceKxKp9Vbs5V4RtT3wjdGEWVBOlh1
         5TCqePp4/I0M2CbdiSlk3Xky+AIRfGqCLzda3d1C4iKS6QfT0tJsLAiqUFFK6PLSWhg3
         wMVqufIWJT+wNx7zSaNDEmJNLjD34syzct98h1TtANn0H5aaZ1zj8duKs7IRd2/HntV4
         E1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754963630; x=1755568430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TM2/7lE7zgF0cwNVS0H6okln7+yKWK+fmjDA20yXco=;
        b=QoGH55t1luK0C1Pm1cDaBPLoI6rnQcQHS3ZQI0ESSdu3EQuxCKcNjfXhgDbnF8CGl7
         R2SefPmkdxs1u3O326rH5jySvwKywJgxdNObaXwtFhdtBPk7iu7zX7V7Iwr/fNmL//s7
         ioJqtp67XjaaPNSlUEBFangN6Age8bRBohTiukO5NN+bFtsAz8kCaOR8skoC3xML/fj6
         dS391m16gW2d98jTwyyWfQZ/O/HCC62+Ez6XVbs59sU2Os0h1nwHuKS/CynTm6NFTd5U
         dBPwaixA6oSZ/+8WRy26ao5h0GWZEgIXq4J5tKVEnpBlzs5NZJD5vad9O8/jaDMSTYn8
         VDDg==
X-Forwarded-Encrypted: i=1; AJvYcCVQz8Vf7SdmyzgkkIH/DksJLdM4TMkfxWE8G96CkZFWMIefJ51w+W15yBYMkLCC21fSNzSkiXQx@vger.kernel.org, AJvYcCX2UTZnafs/zXHJtLme2HMknVTqQ3iM3JZrM4evpU+gG8qAVljD7oC3CXxr4qE8yxN0cNC9Rh2ipsPSUGo=@vger.kernel.org, AJvYcCXMycmrDx4mLBrSL+wXcmeF0HHlzuUCOeMf3s9Yet1qZ2/HEn6gXoe5+kKcJvk0fxVU/CWIf6+R08/UFPM+7EHN@vger.kernel.org
X-Gm-Message-State: AOJu0YyYk84mUV6GBoVClH5GnMGBtJ5X6b46iomQY+km+1ojvM9m1lgB
	R/td72hrM/TV7FHgLjI0c2VBmOf9KVfbvxTbeqFtJuoC1CPWZPdsdql+
X-Gm-Gg: ASbGncvYoL5NpR9UjGzndL1Ncq6gVyHhDTTzyZwHVj8Y08uJqhZjJgcLiV/znOxUV2k
	oAS9QVZ7V8WVKo44G8uPoIqNLK2tnROcqkN073S48+k1490Jk+5X0hSD1xuNXWK13yiWs4v9qKi
	DSKbMYxCNYFMIZMsGYQ1Wyn6dvYCDMehF7Yl9q3P+HPEJ5sq50R4qoNMu9+Ucfj8cYnyCZGCRkB
	28EfBwSsZ4WF81dv95aJCA1Uqx9xYd0EPKjXPSvsoz6CDf1tDiav/RSOwNHE7xuD/hNkz5cq7yL
	7yrDHyaQ3V+xo3gzN3ea1loiknhP0sqZVgR+OCjDVBmrLkF5uzPfG9NikK76bCPz2tKrr2FoCby
	PNi7GPJfGjGk6dj9bxCPyb3yhSSk=
X-Google-Smtp-Source: AGHT+IEu6V5UHqfMhjN/LVoyKCA0Ke5eBONL1yJNKfnYSGTC0pmHyZAZe/NtCLnUSOsVGOs4pRo9ZA==
X-Received: by 2002:a17:902:d603:b0:240:25f3:211b with SMTP id d9443c01a7336-242c225644amr212881815ad.51.1754963630158;
        Mon, 11 Aug 2025 18:53:50 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0f603sm285233875ad.48.2025.08.11.18.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 18:53:49 -0700 (PDT)
Date: Tue, 12 Aug 2025 01:53:40 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jay Vosburgh <jv@jvosburgh.net>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Wilder <wilder@us.ibm.com>
Subject: Re: [PATCH net] bonding: don't set oif to bond dev when getting NS
 target destination
Message-ID: <aJqepGpobcDGak_C@fedora>
References: <20250811140358.2024-1-liuhangbin@gmail.com>
 <783435.1754922439@famine>
 <20250811093328.70343754@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811093328.70343754@kernel.org>

On Mon, Aug 11, 2025 at 09:33:28AM -0700, Jakub Kicinski wrote:
> On Mon, 11 Aug 2025 07:27:19 -0700 Jay Vosburgh wrote:
> > 	Generically, I'm wondering if test updates should be separate
> > patches from the functional changes as a general policy.
> 
> Yes, not sure if we made it a hard requirement, but I think it's our
> preference. It is the reason why we don't require cover letters for
> submissions with 2 patches.
> 
> Hangbin, please update config for bonding tests, looks like vlans 
> are not enabled there today.

Ah, yes, I forgot to update this part.

Thanks
Hangbin

