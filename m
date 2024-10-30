Return-Path: <linux-kselftest+bounces-21083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05A59B5B27
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 06:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F463B21A51
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 05:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F100D1990C5;
	Wed, 30 Oct 2024 05:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECljN6qE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ABE33E7;
	Wed, 30 Oct 2024 05:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730265416; cv=none; b=GljaWHogbHzzQrV38VqoFiIwG/bFhF54kcxAMKQ90auDULT3N/IPz+WU0V9l7swC22g+qHr1E+xuqdjrUa0GAPzdddMk1rK6AKMXv5NvoZE4X/BrgkOWDvT7+fq8HsT0bW389M/KrbpqJwQ5zpN+bhNHMB7/DO+9u7Ci/xrf2FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730265416; c=relaxed/simple;
	bh=4Ng+sAjoGKPc64iH0Yjl/NQmTniY/TRLqMyzQ0hldhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=du8bJRDqhir5mTNoz9ti6ZKc3/FonI1qtmF2moSTAgfGmIbZUrakRijIDZVMr1+aJk5zsZIIR6DmHUFaG512htf3z7LRhN4rKUpGrqabW47erWUC986THamGD9GZdadIjiR4KRzyL5hp5iGE25TpLO997LqQw7ZRqbK7Brdu2kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECljN6qE; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-50d4a6ef70aso1939519e0c.3;
        Tue, 29 Oct 2024 22:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730265414; x=1730870214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3t0O0GmcqTq9xrptWk5P2Qqwk7hlGCeWrvNQml6CD0=;
        b=ECljN6qE7jO4fOm/XV7ajxkAr1yfZWiqs5nii5GV4ROpuff4i82vo9f4LgtNwMBS/s
         n7JgvYwOUn2oDb8KQaDBczATgl1C1KOixzZjcPyJDT6H+GdLPwidr9ozAp86RY6JOeIm
         8GTO2g+WAysL81HgOCyeD/4DP+MRmkTAcuRBctGuYF5yFp2ZZASnRBc+2AA6NUAUeLQT
         MDOItI6Nhm6lFVhO8z2glkoi1tgId8IqaCLCtUDi3plTY0ZesBfjh9ELrw5aK94y620A
         JD7ceo4JSgjFvmslzVVIDW19m6PyWZkjxQB0y21qgqEpFnQo/vL18Y2+0NyB2IntqJhA
         hg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730265414; x=1730870214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3t0O0GmcqTq9xrptWk5P2Qqwk7hlGCeWrvNQml6CD0=;
        b=uIVGkCux7ovwAUyNudGJuVs8LRwtdV5UKAw3XXgEQ+3MwO3CAI+3TmS8zZ4gBT2SrR
         0OYvLeSdRMWvIl6ao8ti9N/p3bAxahTUKwB/H/Dpv0FtbJlvGniF204q49MvOPDaZDDZ
         wdpQJZ0P9yPeGQ04rENzFiw3xyDxOCp+0xI/WLSIpl4cXUBfSu9cod8cIA0b2ni8K66+
         eRUobDnmx7fn9vnOcqX8aLjkMjl/BiYEYP4do+7wSmrRQQJ+8BJa48hNShzIBtHzRlJ/
         Cz4FC0wYMGR3Gqhn2KA/WR7tEOhi9/n45RDmKklR437opVCNkcjf/AdzHkYE8tdoN8+J
         dunQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/0gEaZYMhPmyGq1JPPHm6nj6wSxnrtakLJ/xG49OYBe68TejaRhONb+sPc7dn941gQ3AFcMEZpcrSeozSxFN4@vger.kernel.org, AJvYcCU1mwWa9mIpYMvS/YmWymrY+HbXZMQSMxmthzyRvfWaQjgVGmc6wb8Z3wX7DvPUtiC2MGlVAf/T9UzWdYQd9BU=@vger.kernel.org, AJvYcCW1Q9MRcB9rB2f3Ad+EbcedFzz4NFAaqKEzrCJ+8L03b+44Nvp31X48El4hheqyRdYmNwqRPw/StyoQEqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJEAry//6YVX/JPOlouefrq4iiEJF/WE2yWbnrVCs+r3T3PPHZ
	Uh/BAImXI0+qyMLrqBjE3eUsSoCZCw+yNl4TUZFFbNFCHoGv3oitwqglrQ==
X-Google-Smtp-Source: AGHT+IEnOcZXGUTKVaYXyJaAMXPkvTr53n/gkKo0Ltw7Rw2vEnrdj4C744uk532l9yr1uO9p9u0mTw==
X-Received: by 2002:a05:6122:1796:b0:50d:160e:de73 with SMTP id 71dfb90a1353d-5101503520fmr12493138e0c.6.1730265413811;
        Tue, 29 Oct 2024 22:16:53 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d2ab5f9sm484066385a.70.2024.10.29.22.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 22:16:53 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id C9BAA1200043;
	Wed, 30 Oct 2024 01:16:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 30 Oct 2024 01:16:52 -0400
X-ME-Sender: <xms:RMEhZzgW6ULsvv5dCUpCmQPST-Tnj_Zd_rEPXBa_6y_H0_bvFFapWg>
    <xme:RMEhZwDiyjrAwlZODv8s4aEA5vXWnlTwa9uK_hPUgx-8kpeU_sdjBoMH1LRDK-lUz
    vnHQnc7Pcw_54Ogjw>
X-ME-Received: <xmr:RMEhZzGSzp6djL3Mc_a1BSibs7wEN3W2mPt59RgohMx41mk6kHR6ANWXuTM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekvddgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegurghvihgughhofiesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhho
    shgvrdgvgihpohhsihhtohekleesghhmrghilhdrtghomhdprhgtphhtthhopegsrhgvnh
    gurghnrdhhihhgghhinhhssehlihhnuhigrdguvghvpdhrtghpthhtoheprhhmohgrrhes
    ghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilh
    drtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthho
    pegsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopegsjhhorh
    hnfegpghhhsehprhhothhonhhmrghilhdrtghomh
X-ME-Proxy: <xmx:RMEhZwSxW72_o-vt9G1-syqfPoQN-duNA8VaCUYnFVHqOxkBX611xA>
    <xmx:RMEhZwy7B-Ux8YHm0g7HvXHs_Ptl7Xb4GhyuIuG3vfqoDvEqlE2kXA>
    <xmx:RMEhZ24ITs6sD1P3B4jQ8KGJwmeGiauraYvDmnSkNhMjjstVb_bX_g>
    <xmx:RMEhZ1z80Y6cJHktE9s61gsizLo8HufjDIpYsENepIWHOBSnzwmUzg>
    <xmx:RMEhZwjoo-2oxWH9ef2IMZwENSkDL_KL9nw89p52h8B4iQMvJyiu3TAs>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Oct 2024 01:16:52 -0400 (EDT)
Date: Tue, 29 Oct 2024 22:16:51 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: David Gow <davidgow@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	=?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>, Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>, Benno Lossin <benno.lossin@proton.me>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Matt Gilbride <mattgilbride@google.com>, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] rust: macros: add macro to easily run KUnit tests
Message-ID: <ZyHBQzR_17qfcpng@Boquns-Mac-mini.local>
References: <20241030045719.3085147-2-davidgow@google.com>
 <20241030045719.3085147-6-davidgow@google.com>
 <ZyHACjac2gk4M5MX@Boquns-Mac-mini.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyHACjac2gk4M5MX@Boquns-Mac-mini.local>

On Tue, Oct 29, 2024 at 10:11:38PM -0700, Boqun Feng wrote:
[...]
> > +
> > +    let new_body: TokenStream = vec![body.stream(), kunit_macros.parse().unwrap()]
> > +        .into_iter()
> > +        .collect();
> > +
> > +    // Remove the `#[test]` macros.
> > +    let new_body = new_body.to_string().replace("#[test]", "");
> 
> Yeah, I want to see how you do it this time ;-) So if you do a
> `.to_string()` on a `TokenStream`, you lose all the span [1] information
> ("span information" is a term invited by me, hope I get it right ;-))

Not important: I meant I am not a procdure macro expert, hope "span
information" is what is used when discussing span preservation ;-)

Regards,
Boqun

> e.g. if there is a compile error in the test code, the compiler cannot
> report the exact line of the error, it can only report there is an
> error.
> 
[...]

