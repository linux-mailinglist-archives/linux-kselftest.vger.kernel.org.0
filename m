Return-Path: <linux-kselftest+bounces-43512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDA7BEDCD2
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Oct 2025 01:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DF05427912
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 23:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C9127E07E;
	Sat, 18 Oct 2025 23:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BZ6S2Xs4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD39262FCD
	for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 23:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760829090; cv=none; b=fyckxYpQ8GUKYCLII0zDiOtKCcMi/BNC8Ds94Zq4gRdt8nhZXS7ve65Oz/pDk3g/gsxzsisB/NibCu9Ih928LYFbExgOuiDeONVHIbIhW1CAbHzEHT0se8AnY+kXU5IpbR+pvIlMAQXtJSksba29hjQa7foEFnYBkfwusbW2M5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760829090; c=relaxed/simple;
	bh=nlTGgh1j4rnsma37VDwy3XvjnEutOrYN/Saoiw9k0/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGTUrXMo0T/0XWv2AAyZGP1aQnb7wb/HCcYpzxuAoYntKR8olYKCm0QoR7+tUqxomBWWP424lVoCOQkPgNVHA4EjhAPPitbWjcw3D/nDQB9Jc5P/FAZplYDjBfRJDXU0PmtQa92AZXM9d2HDeN6rPc3bx2EOt0ut9N3IXEGle9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BZ6S2Xs4; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-44181f9e5b4so1922014b6e.0
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 16:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1760829088; x=1761433888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nlTGgh1j4rnsma37VDwy3XvjnEutOrYN/Saoiw9k0/M=;
        b=BZ6S2Xs40U9WQeq7NwydR9GbhQbdvOjDSv4Qbr9KKeCYizlk6xi5vEFooSbU8ymvLl
         WSBq5lAT1yCWnNc6H16VrjD0JeAdPqqNvYBxmG52hVSP/t1bdV0YhO0yBVZQ+S0wsrpY
         /QPFLN0zDpppP7ApdEaqJsD1GF7o5OP+bYGjdmMJOGm/Kt6tuFeThxoQFTLzXKtqoWHh
         CteSEOebSSDXqi99VukwnkUrG/AMT9Obl/oLUprKxkOT9lYdjoQ17DHql8pZX8V6Y37P
         TrqnH3iTSdnsI1yr9Uoy+JIq0ccrtZoBfQcv+rDIlNoL4H0lhLQyB623WY2d67VJJy9j
         0TwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760829088; x=1761433888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlTGgh1j4rnsma37VDwy3XvjnEutOrYN/Saoiw9k0/M=;
        b=K3feDmb6djo6RxpQGpiX2P9RTF3RkCRb5XBc0sCl3iG8kxcO8ALiIwuaed1otY+pDd
         82xuyO2hL/RzJulLSyeFh+PhuJgWBKQtPI2P9QzoisP5OMR14iKPDPmxPLIlTwNHJp86
         0cw9SVLd85/rqAOjx4o/uw3TFKwID7Y3ivfHOpWKqPerTM1M/iZ2Q/3m80s6tCxDFvDe
         2Chej6iKkOklixt7cPHb2VC3eCfSMyVqYoCEa3fmVtTaZXdPVmVh45uog0TCaOv7MjtE
         NcYQAP6x21zO0Dazsuyd1htSqStHOVLKZG/uxCge/IezzbmSu5rI8AcD+y+J6YoZsMaO
         3dAA==
X-Forwarded-Encrypted: i=1; AJvYcCUXAxEz6jgusUL9J91cD6DG1K8YAFRqCQUjZVTv1H6WPtHoGH0eER4CANcTRTmQSJfKbcU796WUiRQshvwJEe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXWV0UYTpvVnZOdFLR+A+j58KBZ7lh0CgmVWdXt8rND+iIB/Ee
	239ednnOvQMzI8cZDrq57zqNpI07Hz8dKSUTdta5Tp4wuxb1PRSx+VqnSWq3pOAEMnk=
X-Gm-Gg: ASbGnctB8B+QyZsKbl8SRUthGQKeTWCxDCQoeXyaWZVL8PDw+61rxJ1UD6fC+vPTnjD
	AdzUUCvvWUnujm3/kdI03H7zGTOxteALyVEOWOfxDJpxmMyBZg1eph8hbgL8rqjbzphZ1CrlPkI
	m6tt8CelvIwgOHzlIciGNfS3m50k8hlT0K4tI1b5hAXgN+ZSxjAybljdkcWoqtxHnVpBWJqtjww
	4YZ0bSNOt4RPDPTrGQzpLRtbdMhjEcy+E8PfGV23ldNdPY1Dt60uM/9jrf0TwkIKyEOEGSv0iB/
	cuZsMak6GwUT35r9Vv95LPGpeGIh78IMRKyima6mj5Da10Z+4SlBLYQIXXBpAJK/YqZqfq9Th7M
	CPmKPBDj+KdjmnxbEJ2aRGhnEKQkNcRuCFoZ0aX8s224C2Enjt2WgejXDZn2i
X-Google-Smtp-Source: AGHT+IGjutQW9FOpunwPbl54R4lmphJmatLWLrvDMN3YzWlbvrTlVJ+kuMrXHSfrl8ye5jNWMdw9aw==
X-Received: by 2002:a05:6808:2388:b0:43f:5fc5:e04a with SMTP id 5614622812f47-443a30af9cfmr3465468b6e.31.1760829088069;
        Sat, 18 Oct 2025 16:11:28 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-651d3f8d640sm899440eaf.20.2025.10.18.16.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 16:11:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vAG58-00000001dfK-14RB;
	Sat, 18 Oct 2025 20:11:26 -0300
Date: Sat, 18 Oct 2025 20:11:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vipin Sharma <vipinsh@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, bhelgaas@google.com,
	alex.williamson@redhat.com, pasha.tatashin@soleen.com,
	dmatlack@google.com, graf@amazon.com, pratyush@kernel.org,
	gregkh@linuxfoundation.org, chrisl@kernel.org, rppt@kernel.org,
	skhawaja@google.com, parav@nvidia.com, saeedm@nvidia.com,
	kevin.tian@intel.com, jrhilke@google.com, david@redhat.com,
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de,
	junaids@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 15/21] PCI: Make PCI saved state and capability
 structs public
Message-ID: <20251018231126.GS3938986@ziepe.ca>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-16-vipinsh@google.com>
 <aPM_DUyyH1KaOerU@wunner.de>
 <20251018223620.GD1034710.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018223620.GD1034710.vipinsh@google.com>

On Sat, Oct 18, 2025 at 03:36:20PM -0700, Vipin Sharma wrote:

> Having __packed in my version of struct, I can build validation like
> hardcoded offset of members. I can add version number (not added in this
> series) for checking compatbility in the struct for serialization and
> deserialization. Overall, it is providing some freedom to how to pass
> data to next kernel without changing or modifying the PCI state
> structs.

I keep saying this, and this series really strongly shows why, we need
to have a dedicated header directroy for LUO "ABI" structs. Putting
this random struct in some random header and then declaring it is part
of the luo ABI is really bad.

All the information in the abi headers needs to have detailed comments
explaining what it is and so on so people can evaluate if it is
suitable or not.

But, it is also not clear why pci serialization structs should leak
out of the PCI layer.

The design of luo was to allow each layer to contribute its own
tags/etc to the serialization so there is no reason to have vfio
piggback on pci structs or something.

Jason

