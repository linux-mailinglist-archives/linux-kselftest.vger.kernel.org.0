Return-Path: <linux-kselftest+bounces-24638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4164BA1369E
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 10:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1FCF3A6F07
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 09:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61711917E7;
	Thu, 16 Jan 2025 09:31:50 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDC333DB;
	Thu, 16 Jan 2025 09:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737019910; cv=none; b=YGOeXZvfqdirdkWi6U+N+H47vRupXr/GdgB+/+uhn9SGtBbRRFV6RGRNsFVlZSRQWaZAX0bzur6DXvctRUxrJx5wepY5TeQDcM/els6M0ECysb7baUoTYxY0rGVn2kKGAPI5nxn01DZ6taxK6xXi/shZYeCeRNsE2AQ4yEI9prI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737019910; c=relaxed/simple;
	bh=7szx2gxdaewH7rPgIQ2jNbT1I3KzNgWe4RC961FzvD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tc9L51Iy/arMfvA9NSY6J0fH4oRWbOoDlREeJiYEFsSh8Nn4aC/ZMNNxdeoMm+Ix+mAbjlCBVe+pYCeyLMXC08IvwFy9xMoHWAZPYIrt+pVVZQkvGkz+L0P6wCGbhbNRiajmEAQZc8O7PTaG855UkWpxBs4b9fio2opUq9MrPtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aab6fa3e20eso132369666b.2;
        Thu, 16 Jan 2025 01:31:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737019907; x=1737624707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2P5Op0PE0ntDX/4CbdjSlAdBOP2yikx9ameN+GlxVA=;
        b=YfEMackOWuQgZ031BIAgnQW7MGEkZjs0e3bSGr8iKeIDqrsPeAiD48Rxlob+n3O7p4
         Rqn4PITtMbtr3K+9Crv9CEP0ekmJKTpkTApMOyJ5346Z/IBN4XaNSIYjouZnIeVotp+Q
         SGKV2Bsf0XNjSKhygjzEv2PK/ax5qToDVUUS4TrHnyyGyYmFZ0ihRvn5wyK+HM6rFsbr
         sISdUvfyAbYguxE8PH//E9COISCPFMVVPTHSMElOg/lm4Cr7lM0YuOGxMvJWwDMGZbvH
         3r10l47rX1Qmz0i9kKNfKmyQu7PyV61b9fVfuriGUgTp8684ElJiwUBFcJ/fwmHHdc45
         TYew==
X-Forwarded-Encrypted: i=1; AJvYcCUaotVkDxWBVy9LHv2MsD9F3G/vGoLtVYFbyQ/QDtAS0KI8ugmxj5GCSKoCd9HPZCRztMP+SNsKZxSmvjB+bH72@vger.kernel.org, AJvYcCVZkq4vAWzzC+vnRM5I6os1nYNQ0JFFge67Z8CsJ0GxY4LN7HEg1XTtJw/t5AwxCtknM9QLmCtm@vger.kernel.org, AJvYcCX+CMv7kqW9KGw6ire4HLIbuMD7jVR394i3gBdFKMv3unZov2ppPbz05cdUNfwfNNJJRrxTIFi19AdV8woA@vger.kernel.org, AJvYcCX5Za9K/si8nIamkhn3vmvI1KsCT6zEfNrm+dmPkpyeLGwn7MREl+gB1TyY1TTyME01VZANFnJLZvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE5T7e+sO7N9hnlqJZktF0eP2JBGL5+1kEM+7JbfKjsmuSenNj
	TFudKZvgSZmeDZgUnCc27KSuAjHdE85YlWg52kyVfuLP3O8Qflsg
X-Gm-Gg: ASbGnctLW1mh8iiWmgjhxfBJUOo/KWHFp0YRFSw1q2S/FPDl8VUF0gBpDqyUvdhp+vr
	gIcTq02rimBtnOOQzgTtcqU3Zkk3HVZ2kUe2u/Xs+zlECTvATSRKePTDZiflDwIlWqSX9y9LWYl
	hRpKSFFr2gHqh7OK/R94w7SrEKm8Rmrv55ieIOqayEwVWL4taEkMVnZGc8b51NqPFK49gxG/5pP
	bBcEycvnopEfP3D7frZmI0T07THExkcsZ3oX5PjMt99PA0=
X-Google-Smtp-Source: AGHT+IGZV6lgbdhuVrLEd33Yv8qOfJzFESHNVW9Z/XSMD0r82hvlj3BkZQGz1iGhAAodDKfqxHlc2g==
X-Received: by 2002:a17:907:7d92:b0:aae:b259:ef5e with SMTP id a640c23a62f3a-ab2aad118b5mr2958827666b.0.1737019906742;
        Thu, 16 Jan 2025 01:31:46 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9134403sm897933666b.90.2025.01.16.01.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 01:31:46 -0800 (PST)
Date: Thu, 16 Jan 2025 01:31:43 -0800
From: Breno Leitao <leitao@debian.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@meta.com,
	max@kutsevol.com, thepacketgeek@gmail.com
Subject: Re: [PATCH net-next v2 5/5] netconsole: docs: Add documentation for
 CPU number auto-population
Message-ID: <20250116-ethereal-vigilant-duck-0bcffe@leitao>
References: <20250115-netcon_cpu-v2-0-95971b44dc56@debian.org>
 <20250115-netcon_cpu-v2-5-95971b44dc56@debian.org>
 <417a5115-891b-41b9-bd2c-a77e813b4ef0@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417a5115-891b-41b9-bd2c-a77e813b4ef0@infradead.org>

Hello Randy,

On Wed, Jan 15, 2025 at 02:56:06PM -0800, Randy Dunlap wrote:
> On 1/15/25 5:35 AM, Breno Leitao wrote:
> > Update the netconsole documentation to explain the new feature that
> > allows automatic population of the CPU number.
> > 
> > The key changes include introducing a new section titled "CPU number
> > auto population in userdata", explaining how to enable the CPU number
> > auto-population feature by writing to the "populate_cpu_nr" file in the
> > netconsole configfs hierarchy.
> > 
> > This documentation update ensures users are aware of the new CPU number
> > auto-population functionality and how to leverage it for better
> > demultiplexing and visibility of parallel netconsole output.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  Documentation/networking/netconsole.rst | 45 +++++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> > 
> > diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
> > index 94c4680fdf3e7e1a0020d11b44547acfd68072a5..bc9ccebdae7adadd7c57aef20a726536d7ab3173 100644
> > --- a/Documentation/networking/netconsole.rst
> > +++ b/Documentation/networking/netconsole.rst
> > @@ -17,6 +17,8 @@ Release prepend support by Breno Leitao <leitao@debian.org>, Jul 7 2023
> >  
> >  Userdata append support by Matthew Wood <thepacketgeek@gmail.com>, Jan 22 2024
> >  
> > +Sysdata append support by Breno Leitao <leitao@debian.org>, Jan 15 2025
> > +
> >  Please send bug reports to Matt Mackall <mpm@selenic.com>
> >  Satyam Sharma <satyam.sharma@gmail.com>, and Cong Wang <xiyou.wangcong@gmail.com>
> >  
> > @@ -238,6 +240,49 @@ Delete `userdata` entries with `rmdir`::
> >  
> >     It is recommended to not write user data values with newlines.
> >  
> > +CPU number auto population in userdata
> > +--------------------------------------
> > +
> > +Inside the netconsole configfs hierarchy, there is a file called
> > +`cpu_nr` under the `userdata` directory. This file is used to enable or disable
> > +the automatic CPU number population feature. This feature automatically
> > +populate the CPU number that is sending the message.
> 
>    populates

Thanks for the review, I will update.
--breno

