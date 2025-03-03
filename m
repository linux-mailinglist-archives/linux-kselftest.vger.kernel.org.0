Return-Path: <linux-kselftest+bounces-28211-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C91A4A4E1F9
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 15:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E1A6189A021
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 14:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74546279348;
	Tue,  4 Mar 2025 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LEuwjdfT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1749279341
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099824; cv=pass; b=tv3nWhlNeqBoFqyYyXP3ncmp1ngKymWCJeX73KbOTHOS4PkKXOjcBt1jaWH1MPiPNLeAtVb3KF8O7Qwk0IY733aLgJPcEK71bK7dUc4+7pk+l3kAIdKZvdZRB7d6+p5MdGz0l/LO0qs1pFehatDGNAf3QUwBRofumieOpgpSDrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099824; c=relaxed/simple;
	bh=lpDLopW56ZiJmp1XcvXqO0pzbDV6pWgE4pCJfBENgvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSOtZUD93YPpdui2Rb1qNFE3H3EpRv5dzLuRgpU6YuzfOEOD1h9dqTUjy+vhQRUMRKQi+oAEqHjhZUAAPOuLErrVGIdMHTi28j2hzuS6oNR+rKJwEM2G2Chx8aeLWh+ZWGWFv2gF+i672CUw3hRmUJrukGZqW/R42NK50Z6el5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LEuwjdfT; arc=none smtp.client-ip=209.85.128.43; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id CFD2140F1CC6
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 17:50:20 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=LEuwjdfT
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dp85jBlzFxLD
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 17:48:00 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 6008E42723; Tue,  4 Mar 2025 17:47:40 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LEuwjdfT
X-Envelope-From: <linux-kernel+bounces-541394-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LEuwjdfT
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 33C8C42BC2
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:38:00 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id BDB6A2DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:37:59 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4483B88C5
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BF41F3BBA;
	Mon,  3 Mar 2025 10:35:03 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A478C1F30C3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998100; cv=none; b=lZyOMgroQA//DlO17cBYYByqFpUZc6ElaIU92ceZsHVb/CPDZU2O9wFqj17tsn4HCohhv8ne/lxbLwUqPokksYsiBhOOwGHPk8GXH24PCGJQ9Pfueiave9rj7lSEG9EPAFFgGWdhPLkqecqUALwHorKZ0ZtaJcEqKMrzn3NhpkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998100; c=relaxed/simple;
	bh=lpDLopW56ZiJmp1XcvXqO0pzbDV6pWgE4pCJfBENgvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3dEDoUpkGnOwD8vKysISAwcfxg6VP8Kq6Rw6iCsyCaklvvPRsazvUVMdaHf+2k+i4axV9Vhf/VvkEIVUKdlCOaGYZxxDvs7c6tAGy+kfBDqSIZIjGt6B/F1fgjVQnqWIasWmvTt4UbT/jwme+o0yuhBt/f7laKMIP+w1o+csVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LEuwjdfT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43ba8a87643so76945e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 02:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740998097; x=1741602897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+bSaBNG5Yoq7k/pu/7absa0rkEVoeKeNE/Soa/XJKAg=;
        b=LEuwjdfTBYUvSNpHfqrKJk1ufwL4Ps93/JmuQ7fKw1leSFtC9ZQS1HazDR5j2r91LR
         OkPPlYIqsAn1801FSJSJDWbY2Qfm0pyObUq/KuczBk15F8+gJgic6HrLxQkI9IFAD6+E
         Fp6d/X5Ip4o4+w/Dp205g4Exsaw3G01CHKrk9uAG1ir7hFTfBbzsLmlmkardaSdO4ayU
         p0PYgWpxCoJGfZ464Wxv4dDq5vAdN6sAdV/x4/XR2XrceKvdyFKhbaZTh0+3KTLl1iEG
         TM3q3hv+7w2UlUYKxzIPMMmkAAMeOUk+6uRg1geugTK7C46Vl7XeITmtl+d3KJgFxy1Q
         ZA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740998097; x=1741602897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bSaBNG5Yoq7k/pu/7absa0rkEVoeKeNE/Soa/XJKAg=;
        b=Yan9rxqmmaaGieBwCjcSOjtU2Nz8/5V87Yt0m5gsj1d045tpDwpaii/ZzmOjLoo6Zl
         r8Fr1HtwaP9CxjCP93RTh3E85sD4v4/Tt2Ojkkg3++N4bYQf6pbEhw+UuIZv8Oi3C+C2
         aKWObZ49QDK+5MMH1VfE6uTMYcjwmkA2ZSifKxmsa2XaZkToe2D9e0IOQVwltKjvdvcJ
         tBNyBBm/9FYWhlfUfvOPlt7HFeeT9FeanI2PvmKj2V4gNPb9kxMfbx5+kSVmTk/4yYXY
         nnrX9+C8XupZabjY08+KaRHQg6Ld4O4MK6QMHIUQCgvWYteF4sSLTQKpR1/Y8/efk2Kd
         X0TQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRDUg8+8nqYZCL8E3T3hEQgt8mIvAlc5XyK2YYXOLeRrjGuVcq5EwqpN6WHUw+c7vjMWFDtr+eH2wNCXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6lnDfcDilTiqwhyqjUgi1KlmaCSQzskAPfK+Z3uViB5hE3LwP
	PIhemeXpnmsyn25uqMa+EYVw0iBf9YP1ExIkzt85b3zL9hDhNcgrSf28n3yGZg==
X-Gm-Gg: ASbGncsPa9z497SA9lPPIvVfgsbhRDY+JLzKNNSFGrYNDx3MdGf899arEdvvtdQcrni
	xo95SWakakwaOZgFd1Qg9UrNNgEsf7tExlOEZmDCJg6RWppUbv19vXoJ2G22XjeBiLHupjWb01n
	WWcmC4RuhL4RdQkDX4wXZ6QFRBaqPxw0uz8oIBDnAqEHbyQ1xc2JmnjjcWK953SycGI5ggIqCfm
	YXXAjIzbRzul3h2wTs06tZRAxP6lYsAuJfOuI9WA5YVOG2AmO95H8v513EhbAmIjAwIIwzGRniB
	1eo0gVZACPF4qxRNfB2OyYPyb62PP18n0skJXD22bMdONsw4z35oDTY2QMuJG3bv7Y1/0Sqz+FG
	9l2Wi
X-Google-Smtp-Source: AGHT+IH5+lAh4aDnKOfBgCart5GsF44/Ttw0+2rACrYtMiBk/Nmmsik0qBemWNe1gfOZHSa/eQkRBw==
X-Received: by 2002:a05:600c:47d1:b0:43b:bf3f:9664 with SMTP id 5b1f17b1804b1-43bbf3f96f9mr1090565e9.5.1740998096859;
        Mon, 03 Mar 2025 02:34:56 -0800 (PST)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bbf2ed24asm41351505e9.23.2025.03.03.02.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 02:34:56 -0800 (PST)
Date: Mon, 3 Mar 2025 10:34:52 +0000
From: Brendan Jackman <jackmanb@google.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/10] selftests/mm/uffd: Rename nr_cpus -> nr_threads
Message-ID: <Z8WFzISSAmtjtu3L@google.com>
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
 <20250228-mm-selftests-v3-4-958e3b6f0203@google.com>
 <b5b1e43d-0298-4772-ba0d-acec63a05149@arm.com>
 <Z8V6xYvqqkPxULgN@google.com>
 <18ea9794-3901-4802-875c-b0327984a9d6@arm.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18ea9794-3901-4802-875c-b0327984a9d6@arm.com>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dp85jBlzFxLD
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741704517.73967@2rhjLyILNTUQt1DZbj+6VQ
X-ITU-MailScanner-SpamCheck: not spam

On Mon, Mar 03, 2025 at 03:48:38PM +0530, Dev Jain wrote:
> 
> 
> On 03/03/25 3:17 pm, Brendan Jackman wrote:
> > On Fri, Feb 28, 2025 at 11:06:35PM +0530, Dev Jain wrote:
> > > Taking a cursory look at the test, it creates three threads for each cpu.
> > > The bounding of the variable is fine but that being the reason to rename the
> > > variable is not making sense to me.
> > 
> > Hmm yeah the name needs to be more abstract. Do you think nr_workers
> > would be confusing? Or even just "parallelism" or nr_parallel? Or any
> > other ideas?
> > 
> > FWIW I briefly looked at just cleaning this up to remove the global
> > variable but that's a bigger time investment than I can afford here I
> > think. (The local variable in stress() would still need a better name
> > anyway).
> > 
> > Thanks for the review BTW!
> 
> Your welcome.
> 
> I personally prefer leaving it as is; unless someone comes up and completely
> cleans up the structure, let us save our collective brain cycles for more
> meaningful battles than renaming variables :)

Hmm, I think that's a false economy on brain cycles. A variable called
nr_cpus that isn't a number of CPUs is bound to waste a bunch of
mental energy at some point in the future.

Unless you strongly object I'll go for nr_parallel. It's not a great
name but, well... I think that probably just suggests it's not a great
variable, and I don't have time to fix that.


