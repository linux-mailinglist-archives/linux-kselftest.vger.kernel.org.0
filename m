Return-Path: <linux-kselftest+bounces-44389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9C6C1E93A
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 07:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A38864E50F7
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 06:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8AE2F9DA7;
	Thu, 30 Oct 2025 06:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IF8UAmLy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDCF37A3BB
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Oct 2025 06:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761806129; cv=none; b=U8YyI1ENf1i1KgtA+rJ6KpTjQjQsAZXSqwlPulzRGfiIT6PXD7eacjAcHaujp8tv93e7N3DIY38IuHopX/3BYj8O+o2gF8wDB382/GZycr+gzqPwR1HtaHEm3Y+++QMipj5vZpy7t1Q9LqITDjnVsR31KZLkb/rhIU83DTGMMzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761806129; c=relaxed/simple;
	bh=jnkRr/o96U6GB+V6Jok5Aq8jZFjNnKuWb6LJxrZjtX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9sQ/m4n0GZclWHMkWMN+zGzVhD1N/lo1ClVgQwWqYCIpOoFn4D/Tkfkd6WZXQ+c5gw1SCxK2kqyjSbSqUuUAmT3g2NlRFSK/pbezXYWg7FIy0FnoXAygj0jr0ve3d6pyPc6pjgN5vIMkV4qn6NgJWn3EOtW1nsR8UPJtFPm7qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IF8UAmLy; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-28a5b8b12a1so7113695ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Oct 2025 23:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761806127; x=1762410927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6GH2hPiy7GhdUU4HV6KSqVEBs6Wse9wPYwwUBAC7Ots=;
        b=IF8UAmLycFxeSDoSdb7algvfNTnolzHQV8iSx2nmB2Jh5b3B1OuTEvOea8TL3biBn+
         YI4BQB10so8lU0lXhPMoI8Rvp+a008QZQzVOfgCjinKWO3kfG6/zEx8xGOOWJ3X0mOl7
         vYKq3aiABVoW9jqtWE3YO/RpNLIpCHloo6KhQfhjlGsUTehxVjn7qeMYKskH5ZUQXx0k
         s2VRBGtDCIM+QupGA+fvSMVQlSPWV67vZy8wFRH/w2i/PfkMHMHzeh9MDYOfIWXhd4/I
         x6Lme1juOvHn5nfAsBFs4qK5uftLI/KUizyGWwm/lntMEy6ItbscHOLsXe4eFc5bltb4
         XmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761806127; x=1762410927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GH2hPiy7GhdUU4HV6KSqVEBs6Wse9wPYwwUBAC7Ots=;
        b=hrnsm6Fd9l5LMWIauaqgs3NqHX7MBZtT+a0zBjqEZRrxnHDtlWduG1kLS3QzTpQpIK
         LEPXOaCuFEcZs3HHZxU2Nes3187vE81kARQ1BYmlirVApG3VrnLKaaTdQMEEX65USRFQ
         nROk1WzgKoC2SM63cSqk0SY6s8BrnMAiDmgDkZeABjtPhRraOPa6Z+LWk4XQiiDNIZp/
         YmYVslFPsckHGKIgXZ4c1pIowO9Vu0tUmI70N5LuJHPL/CaYK6QYWyj+5cjjeZ2GDUad
         nU3KUmF9j8w0OX1vfZ3V3SNpa5mcOKAJchMSpv3xizgn9I6i/+B2sHEqEflg2F6+FrZo
         n3gQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhb0XuDEMmu4HXo6JixxOjqzySBfdIkv/o+THzm1HP2hb0aSq3IweXCv35L3UKA0h9e+uCFTToSl2cSA+b2XA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP3M61j6YMbt1R6w304SHGr9GhIQ2D6foSjzpPGDAh3FKBl/Dh
	KhL/1P2PeBddJW8xSlmnlk7nd1PSLfDrO3UtEyMhop+B4htlEXKEhhVw
X-Gm-Gg: ASbGncsgqsXA7WgymRjgOOBWRh9VoQZnDIuFHdD06dZ+oslKuYRNlvTKBnu2LFo330C
	tHV4c3NE9Qnzd0Gz8wKpmqnA90oBRK3f5J3lfnbGVjRLy4t/pvsRbjoHidtXtDWXZxv+HfkgcRs
	zgWGTeJqQ1O1QRRdxDhToA9K7A9ybSVT6etbyxIZUjSFgOvHdHnyWklWXnQNvjF8tK/3G9c9B+m
	bvg9qffrWvcvMsSbJiLu+xKahKBe04rLMb2j4aFc34gwy3Hsec1GpZmLeKKMPXtzcG38k6KWrre
	AIiRornDf0VrBmyletGMovr5MZj0U9C4aGYS/gzqxvKGw3qDaTYGf+RmKLsUsccBtQMAK52IEX2
	Cc/i/ffk12CVkeRwYExvAjBW96QDuLjjbxSWn9nIfp6B3Y2Rs35foKChz7l4Cwp2HUDwUjactrY
	7vyOS79ey/uYX7iYY=
X-Google-Smtp-Source: AGHT+IGY5r22edQtye/eJlYxvm5st6DLjzGYvCRNGgRUU9gWKlQ9aub02V0VpjYCGi8gMJd4CPzbmA==
X-Received: by 2002:a17:903:1c2:b0:293:57e:cd70 with SMTP id d9443c01a7336-294deea93bemr69108265ad.28.1761806127417;
        Wed, 29 Oct 2025 23:35:27 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-340292c0d81sm3657855a91.3.2025.10.29.23.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 23:35:26 -0700 (PDT)
Date: Thu, 30 Oct 2025 06:35:18 +0000
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
Message-ID: <aQMHJlwcchqtoAa7@fedora>
References: <20251029082245.128675-1-liuhangbin@gmail.com>
 <20251029082245.128675-3-liuhangbin@gmail.com>
 <20251029163742.3d96c18d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029163742.3d96c18d@kernel.org>

On Wed, Oct 29, 2025 at 04:37:42PM -0700, Jakub Kicinski wrote:
> On Wed, 29 Oct 2025 08:22:44 +0000 Hangbin Liu wrote:
> >        -
> >          name: dst
> > -        type: u32
> > +        type: binary
> > +        display-hint: ipv4
> >        -
> >          name: src
> > -        type: u32
> > +        type: binary
> > +        display-hint: ipv4
> 
> This will be annoying For C / C++, and you didn't set the max len 
> so I think we'll also have to malloc each time. Do we not support
> display-hint for scalars?

Ah, I didn't notice this. Should we convert all the

 type: binary
 display-hint: ipv4

to

 type: u32
 byte-order: big-endian
 display-hint: ipv4

Thanks
Hangbin

