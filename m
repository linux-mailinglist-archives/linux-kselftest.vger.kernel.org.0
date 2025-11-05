Return-Path: <linux-kselftest+bounces-44786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0745CC345D2
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 08:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E65D24E05D8
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 07:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE102BEFEF;
	Wed,  5 Nov 2025 07:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKJnnlB3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943DA35965
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 07:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762329358; cv=none; b=B/icqNTxqd+mNBNY60yYVP7mVhjhO66jqyfGWQwsfSkEksZas0AKGq+sBm0/29hOGiJ+cm+a7TpMLdPZy3PsL+k9vb3l/hvJp6QFwT1ICdXANL857UlOPPI+thrlN+7WnMohlTIKcDlmN2SqMabeVk0rRAbCyLTJhvFS5NepZ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762329358; c=relaxed/simple;
	bh=AbDuRmZXeMPetp7OedkIwGRtdY1JYUDRbpkaMbMziX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5/5Y498J2ok/x0vOJIIAUEmujYyiG/Z5c0W2pqLY5cbdbSdUmzn48UulOvijZ489P5h3RP33FRAWysMuEDsiGHgLDzOn1KdIAp934AzJP9cr8OBsdIpZmeonkdOOXYU7Ejoc01EKg42QonITL7NNH5HvVXGi7jOpYQnLCM8zhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKJnnlB3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29524abfba3so51499445ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Nov 2025 23:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762329357; x=1762934157; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G7v4p3X4ILgkmSzKG/xaZQHmVRIUznEUAF2qixE0ubE=;
        b=RKJnnlB3ZqxyQ416SmhjpJrA2cyFgSVkpjG/nMX1Nw0qUcKs3BNdff/96r6t//v8OR
         RHfoOycq3qZQNC03XRxcPCOI/o7npzgkLSj4ba6IxnzLJzlVQlpsmlxF2Qgs9oKbuniq
         H8N1BH53mdWsMPhGcGyMQFdCcLITnowDECwDOBTkojmQpvIn5v3WK0BYA4Jwc1ELb3b7
         Ax0j64WEh/+fvxmLU1ua2H4tu8D3UGQqzKBJ2FWSUpTh0W1NW5E44OO1D48VhIsNqmQo
         31OOdeVHpnyBDOIA+aY/y2bBZWK9WDUZoNxQ9+0UD4NLU2yhMcx4Ox54p9h+h2lWoNsW
         q2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762329357; x=1762934157;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G7v4p3X4ILgkmSzKG/xaZQHmVRIUznEUAF2qixE0ubE=;
        b=EFgJvYrquKe4ERmeOj+ySnBjuvWp7jyUaYWALeHarCqHBE/qXcCy+4/cwyeKeAyTIa
         pfM5h27ov+YLZDs6ePIZOSMo1t24LmjOXnI6uh9fh/dkPPS5g2MFQaPTxYtrSqaQKXDB
         WCpIhoCSSxDFRXSNIY+ytcYvWAQjseUlHKNe2WfychC+dIiucH8e6oYAnAg88jb+TBUk
         2Tz6DOgoAWHH1CiMUwRhM1dVUs4NX5uyOC/QJF9/mhnHK6x2X8VslHZFCjbnaaT9RuAX
         7six6196KpbzgFTrkxHyoIGRtTzIlJMEIHaUI5zWmMZbSXBZjmjrBNp9TBmaFBiQrrHA
         38Lw==
X-Forwarded-Encrypted: i=1; AJvYcCXCCenGpgDZfcBsWud0KbDKc/wIlg5jGJytjDOO7j8uQNFU+oH+71hfSNHifi0RGUUjWqYO76zBAdswFeBSghQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMAMDUfwhBifKXp2otiNnW1qi/NJYQTuzN9puKOsVfhkP3ehMo
	zw7mi6juwr8QUzmRPtpvb4iNOr54qne5KU4c+VRgsO9gYCMGGxhgffpN
X-Gm-Gg: ASbGnctihvU+eD6cMVLGNBRS0G5PrICMXzCKaS216q/VvG30BEfdu09j8NB+kdIKN1B
	vzJfYlP07cYkLoB37zjDU4wQzK+v4GqQxN3q9rvtR7P9SRKZlZx/o1ty1Uw39Y9zK+ucR9Ait8V
	w8SqrlKKdJvT/JrAP02DC4ahV3iySb2sKO0c5Lh6bo5Ynl97kOhC/PWQLzdkbGcqiQkPnhmO1fY
	BebuLpzpxBdlHDUedWfUSNV7DKuPOPywkn2xGypjfC9w40G9iPDameleRZ2Ut7DYL23ApcN0SC8
	AdPzfvULQ6X9WUJ7acCgMVNkq1pPL8s/iEBDjYsK3DnfoQdVVgRGpvzifMzxW2nrbCBPlaUmv3I
	vWODk/VdKIU7P89Ta7WOX7XpRQe6SbXRrEWbtM1lEGrlDHGyXAjf8Nl82cMyhzspiXGA56Docb6
	crECiyx4OJbkPnCo8AHscoAViZkg==
X-Google-Smtp-Source: AGHT+IFORckqmpACXLUcSu5EfRyS7PDFOGfdE0/YK3mQ3vQaO+BarSBlRiLSVrcGVNLWr2Gsr5XDzw==
X-Received: by 2002:a17:902:f544:b0:250:643e:c947 with SMTP id d9443c01a7336-2962ad8857dmr35644135ad.28.1762329356844;
        Tue, 04 Nov 2025 23:55:56 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601972892sm50941165ad.23.2025.11.04.23.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 23:55:56 -0800 (PST)
Date: Wed, 5 Nov 2025 07:55:47 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jan Stancek <jstancek@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] netlink: specs: update rt-rule src/dst
 attribute types to support IPv4 addresses
Message-ID: <aQsDA7ufLlIwSf1h@fedora>
References: <20251029082245.128675-1-liuhangbin@gmail.com>
 <20251029082245.128675-3-liuhangbin@gmail.com>
 <20251029163742.3d96c18d@kernel.org>
 <aQnG8IYsY3oyYekf@fedora>
 <20251104164804.540a9b8d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251104164804.540a9b8d@kernel.org>

On Tue, Nov 04, 2025 at 04:48:04PM -0800, Jakub Kicinski wrote:
> > Hi Jakub,
> > 
> > I just realize that most of the address/src/dst in rt-addr/route are
> > dual stack. The same with FRA_DST. We can't simply change binary to u32.
> > So can we keep this u32 -> binary change?
> 
> Ah, should have looked at more context..
> Yes, and in that case without the display-hint?

The display-hint is required; otherwise, the displayed src and dst fields
appear as binary data, and setting the rule’s src/dst values also fails. I
haven’t checked the code yet, but with
  - display-hint: ipv4
the IPv6 addresses are also displayed correctly :)

Thanks
Hangbin

