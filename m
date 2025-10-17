Return-Path: <linux-kselftest+bounces-43366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 51649BE6ECB
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 09:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CC0973592BD
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 07:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114E2245016;
	Fri, 17 Oct 2025 07:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cn8T0uS4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEEC23B0
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 07:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760686020; cv=none; b=KR8wyID4Pp4HUD+1XRpB8u1Df0Z653MEdyQlIs4WyhGYeefk5Efl5qrIlnAF0h2+Q7vAI9bJNeIoQpznXy/kduil23nvuGeVK9TBBJg2hVrBbFMAonK3R8AS86GZB2zv9WbEzAKBp190WNYlJbe0sVuhusVj+cnzbsIM0bNX0CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760686020; c=relaxed/simple;
	bh=GCBl6653lWa78N7RH6M+S5kR+os7zVST2WlS6oF2HuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1gX9Yqpr7CR7+vHu31J1hk5quvkIuhmCd3tnpOK5IkdtAqAE42W9ElTX3IWh9K7hluB4GdT3Fi4aFiwXMxPGwPM+SGMBj5zm0i1abWj2lhZxAa3+gKiZPxCc3oU2W3I9NY8quxolP3f82eaZp64IjsIaoDaPo0/7v+2g8Iyf/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cn8T0uS4; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7811fa91774so1500564b3a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 00:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760686018; x=1761290818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kf5e4YTd6snb2PllKG9ZR9zTajfPGJaAu+fzuKXtH4w=;
        b=Cn8T0uS46PvpJ5nMxlnfofEjeR5urtgDyMF4+XXByqYb4Meh6BBhEtVv4833TIeLox
         KIwN+N16OUMME9xCREPvVEWxvTaktmA4lPX8x2ool1D9kzgUwaOxfJc6V5ig2fT3VJ0f
         RjTusXLgVaKWtmY86xZBdPC50ikcUyouzQQueLR5CSKQdWHRdKYulxopxxgc81c32y9Y
         j4UxtxnndMYCRN7Ga9bAn+0Nqtk5bDFCnnoQYVJFmjRMJXMXKMRwqOW2degmRzSXBK2N
         Ql2O1SuWd9T7AIOsT3Snu8FBZWUZlSFv+D5UxvNA2MqqcPa7awUoh/OGRJcQiqV1CaGE
         tvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760686018; x=1761290818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kf5e4YTd6snb2PllKG9ZR9zTajfPGJaAu+fzuKXtH4w=;
        b=cDoSvctytsyztof0nz9JGc92XT8bzCezUuT8zEAxY2Y6ohRojJY6iYwNjBn5cvp8bX
         /g0qcqVmRlVn6EknVuXL5UViW6KyhFGHeV1hpjsFR/qVqC59U5y2s8lo6iA0GUo+wXey
         3JURRf8oLWSqG8eU5ggSQi4jAL6PuDlO5dF2lVLJ+M/QBP5y2aMrAPpVgjwtJiKgMB+e
         9WOeHNNhz0LajREpxaYGhN2s2DJf70r0VDsG9ov6kTOE+nzff0FAjbjjjz9eiWpgL1/y
         re8Z7ywoMj8cedK9OZqe3ZDQVRx0EsR0tv3F1VxQnSZFj7Zd5QyY0IeE2y4NYNQbDK24
         ApUA==
X-Forwarded-Encrypted: i=1; AJvYcCUZLRsancwtgKlBRJkS70YCPpg8SUBmnuGGBhZ+h8kUHzJSXAnzmwJ6svLbHbosgcuE+pDbHXjcOrK7w86bsaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMAtK8DYH8LFK1DiicqTdtXWFdHVBcMkTskEbJNgqK8xLTkhOm
	GBoajOmIm9wI1yJa5v4E3799vnx0qhiTnzutkjJF7ZySYv6PK1YITJ0+
X-Gm-Gg: ASbGncvdtT3oju9UEEP0SC+nQ0Z9VXACXTduBtFrwtxld9S0gv9Kdokil/E0ohPzLF5
	m3nlIVgWOSvdZ/1eRgRszs9O1DfD9zuSnOg7Ij5qawakQXGwnD7YR+wNgsYjBxI94Fe2Y7NLEno
	Pl27/6HrveFO65PSI088urX0gKpAzMlyYXnTxg87IycHOp+5/47utqY+I2VT1WgRFnOYnZ5UBOy
	9RcMXTnv7S6ZQF0r3jpxDL3Q4IUfJ+8B6GK5fs5y/fRMtztq4nK2YLFgc+7WoJYfONmhjfrnLO3
	Z6clUDVV1VBPFZ9Qw6pLT/0HPS4OWP0Gh6F+q+97wQc/TdpHQFN0D+ABsB4efTpRJQYAgiklhei
	lf641cKG1DtbTnmfh3Km4FUdwzIqI/PRKK5ewPjizJMl9xICEJiR2SXz43iivfckaOPJwW8AqrQ
	SfDh/DRBXQgvNxIxk=
X-Google-Smtp-Source: AGHT+IG98ymXZuE47eP61t1UV4b3qHAOGIr5qGKIAuQonWiYTPovPdLc+FiKd0DLQZ0zSRKQyMW/sw==
X-Received: by 2002:a05:6a20:72a3:b0:334:a045:4a55 with SMTP id adf61e73a8af0-334a86141d4mr3825734637.41.1760686017900;
        Fri, 17 Oct 2025 00:26:57 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b921711sm24723412b3a.27.2025.10.17.00.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 00:26:57 -0700 (PDT)
Date: Fri, 17 Oct 2025 07:26:50 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] bonding: show master index when dumping slave
 info
Message-ID: <aPHvunOUhX6iYnFi@fedora>
References: <20251017030310.61755-1-liuhangbin@gmail.com>
 <0be57e07-3b90-44f7-85d5-97a90ac13831@blackwall.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0be57e07-3b90-44f7-85d5-97a90ac13831@blackwall.org>

On Fri, Oct 17, 2025 at 09:10:09AM +0300, Nikolay Aleksandrov wrote:
> On 10/17/25 06:03, Hangbin Liu wrote:
> > Currently, there is no straightforward way to obtain the master/slave
> > relationship via netlink. Users have to retrieve all slaves through sysfs
> > to determine these relationships.
> > 
> 
> How about IFLA_MASTER? Why not use that?

Ah, I didn't notice this. We can show the master info directly with this...

# ip link show dummy0
3: dummy0: <BROADCAST,NOARP,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 ...

Please ignore this patch.

Thanks
Hangbin

