Return-Path: <linux-kselftest+bounces-46648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 31643C8E7F4
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 14:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 43EDD351FB5
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 13:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F84F257AC6;
	Thu, 27 Nov 2025 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hY7928W7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BC1246BB6
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Nov 2025 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764250393; cv=none; b=asUo4tGUBW0ozqKyRTX+VP0wbGVsDnO9yY92RBjdUgDOnrLwyTeTES3SPZdoKczVTTyCcXCPmBHgKP8wg7Hf8U2iVxsJUH0B3/XvFkdayGW7oC1QaF2hy5OAig5mZcmZZ+wLmbSETx+aEqS0I5Io66IB4mxyS3iIK+giyiDoL0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764250393; c=relaxed/simple;
	bh=PKnMN7L8VSS+kJC9dPTUoVxP1v3xNVRK25ulK7BmeeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qn5JSB/3K3IGkKT952wTJoonAvPKeIVuLC1NCHdG8+k9v+Own4UOMWF60WRXq/YhSQSP72gDXjAYo9+LSZO8Bb6eQQ1jO3vN4E1tH4yQ3qW0c1rLMiuzOCZSXxI9Gm9b+vguCsp0P8V1/7DGDj+fDThkZ/XEg7XbVuoIUjg+O0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hY7928W7; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3418ac74bffso559168a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Nov 2025 05:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764250391; x=1764855191; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1fpTM6tqyqWgHaxiKCBQC8qkvCctuubNQhJsNf2o1nc=;
        b=hY7928W7eLWh6R/O7mutlun1gqj3czXFTiKSTK5i1ehJNtKTgDoLDEe1HGgbFGvOT8
         RtJF5SETKzlOf7DgeX/5baSyo60btbP9hjsqP4WNcbzNXwTCze0nzIMYYduL1b37yA+O
         01l1LidCxx8Oc+z79M7xC1HL7xbv+wVLWclIWdFXanv4LFXEHsnGVzvllqRfbW+FuFEA
         mR9gBN2rIhzGF67HvygxLZwln9VYKzRuAX4A/ytMLDv8Ojs2Rxm09yJhFKsSZ3ab1R+w
         3gtaea2MJ9cLL9rhAmFAXzCa92/D3PbhownDhhGIzWXqUSVAzTlSa19vNrvpklwOYYi6
         wbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764250391; x=1764855191;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1fpTM6tqyqWgHaxiKCBQC8qkvCctuubNQhJsNf2o1nc=;
        b=XE27pJ5h38q+oPyfcgUYmEFy/6oae4E7gEQbVX/4oAPhU/jFkOqw6cdfMR2fFzp/2p
         ZcB+gmXn8rqxW71f6pP+gU4n3zrnpZawKFO2Np4aO3qwv6tOVCKDyJ2e/cqHoEcUvVcU
         TA6I3st7DWGc2AR+5TO4a0wEC/w/THTbVHuFttld7xqRavVpbToGoCF2JQ29+xRahJ9N
         VooFYID1mEl9D3Nzrg1HilrDqmNYJeZLvy+T2IAwNp5SJdLQ46tG6ZoR1q1kNNqAuxCQ
         v+qFdh8jUMEaDyxVA/XkUoWj6LUBeKlGtAbYLzZ9t5cpLviTmomgZTAzaWZSQeNdsEsj
         Kebw==
X-Forwarded-Encrypted: i=1; AJvYcCU6PanPz237fRob/BxfTS1eSLhEvjccddD2idMtpEwOFqUDmmVBeDvM0W6grv//34GSgYa5LDFaas20uhm4NhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtFMGZBwPX7nc2MRwEymILauTgjsZ39Xx9TJjauDGqG0khwS7t
	KTLbPKT098xhB7GqNSx15MOCiK1+jatMgAziLmjndw0mJa8ZYufGc6Vp
X-Gm-Gg: ASbGnct4HiVd6jvHgtP1g2Fr1RpdtOcobUT3uKLWZXU4uITTMgtaDxoCA8hzHcjCQ/C
	c/N3qbTYwF0ljPj6SYUwEBFy+hqCNasOHIGJs5NSjCXTKwnSkICeLNANDm0jR201HwoLqtAI0Vq
	ieB9lzXvx9XR/Ewu4MmoGNka1xFVEHLqwa3xvLyg+fQ0Tcom2E+zSthkHSveKAU6n+H1r3nb8W2
	Ym4GIak+84Uvp+eTazWVarOdqTcOvmrW0DehgchMmbxDr/qVOAeXdcPJKhC1vlXPk5fOrLs9H5R
	DyLjmpQWacx6Jola/SKfLhAQ2o4XgzaHF614w5rzOFnLi3q/7GEe4zoN2yo0zdfhWf6QmwqZQXl
	M5vIh+TuIKUF0/a3R1pGfG60wDdCXloImYWAFYlR2ThkZaKiAZWdcP6YWKXMoW9wtNlo4Bhi9yd
	f8HgJX6/c+cgC6U1d8zsg/SccRLQ==
X-Google-Smtp-Source: AGHT+IGZgefJ9FF/0TIPU2sVzMBGCjWda13CanScSDwN5wkfyEQhDOWujx2ObUAwK3Eeo4CdaWyGjg==
X-Received: by 2002:a17:90b:5744:b0:327:9e88:7714 with SMTP id 98e67ed59e1d1-3475ed7d917mr11260306a91.37.1764250390903;
        Thu, 27 Nov 2025 05:33:10 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d1516f6970sm2041436b3a.17.2025.11.27.05.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 05:33:10 -0800 (PST)
Date: Thu, 27 Nov 2025 13:33:03 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Mahesh Bandewar <maheshb@google.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 1/3] bonding: set AD_RX_PORT_DISABLED when disabling
 a port
Message-ID: <aShTD0PAqLOtQChR@fedora>
References: <20251124043310.34073-1-liuhangbin@gmail.com>
 <20251124043310.34073-2-liuhangbin@gmail.com>
 <63768c05-e755-48fe-a4be-9715f8b5ab2b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63768c05-e755-48fe-a4be-9715f8b5ab2b@redhat.com>

On Thu, Nov 27, 2025 at 11:15:24AM +0100, Paolo Abeni wrote:
> On 11/24/25 5:33 AM, Hangbin Liu wrote:
> > When disabling a port’s collecting and distributing states, updating only
> > rx_disabled is not sufficient. We also need to set AD_RX_PORT_DISABLED
> > so that the rx_machine transitions into the AD_RX_EXPIRED state.
> > 
> > One example is in ad_agg_selection_logic(): when a new aggregator is
> > selected and old active aggregator is disabled, if AD_RX_PORT_DISABLED is
> > not set, the disabled port may remain stuck in AD_RX_CURRENT due to
> > continuing to receive partner LACP messages.
> > 
> > The __disable_port() called by ad_disable_collecting_distributing()
> > does not have this issue, since its caller also clears the
> > collecting/distributing bits.
> > 
> > The __disable_port() called by bond_3ad_bind_slave() should also be fine,
> > as the RX state machine is re-initialized to AD_RX_INITIALIZE.
> 
> Given the above, why don't you apply the change in
> ad_agg_selection_logic() only, to reduce the chances of unintended side
> effects?
> 
> /P
> 

I think setting port->sm_rx_state = AD_RX_PORT_DISABLED and
slave->rx_disabled = 1 should be an atomic operation. The later 2 functions
just did similar stuff(not same the fixed one) on other places.

Thanks
Hagnbin

