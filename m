Return-Path: <linux-kselftest+bounces-5665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A84E86D354
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 20:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993081C22567
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 19:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C864C13C9F7;
	Thu, 29 Feb 2024 19:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TD9nXLrq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D2C13C9DA
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 19:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235519; cv=none; b=IdMFb76/qdNxaVEw/uCIOgHxfKUh8bHUSvGtAwdXqcV91pcNfMhh43ZFqcNtYJyzEbEyB2O+teuP3pZ13iWIsrtFMZ6/20mjVIKvAg4KujKr+HTFatKDNUe46O3BNdKrNRr3pOVD5faAlGMCRed2515KHnPgbg3NrCXMn1WMB/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235519; c=relaxed/simple;
	bh=4aW9MYhuIFjdLhubgiG7js2bZ/KKs/H3S5wRJKpoVzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SumgchI/9gz/XYeuhSBk7XG+2JMQUxjiT/1ZgTnpwofEy+gSk6Zz+a1ED0hrZLBv9ch7rxCLe61EOA/Do8Zm/inkVQU+y06U/ePoGqscriyleYinQh3QgaN8Qf+qT32AUO3MDIDSuRii0HaUtnFRh2WDr3xLD3aKr93rPXbQNbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=TD9nXLrq; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dcc7f4717fso13074405ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 11:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709235517; x=1709840317; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rcIkG6HFp7uZcYBkm60c3cGbHaaSPPHBdXFb5C4zZf4=;
        b=TD9nXLrqzbhs3NYuVki1G1ktfdGoNAy0+EMDRaNz4iVHNAlwzLuET+oLPnffra7tjo
         PetgQsZB5ACGahEddvt8mXrGeEqfOfnI5ZBt8BkVax9kNyX/kT3OSBYP74a0j36EldRz
         51PeGymirMoJN3iNnCFeN3rJ0qQ2/+RDVYDaAeT2TLs+5KSl9BwsEtfw+WYdinj6vTUh
         KjlNoKcfMi8i1xDz/nJnwc6P8Ip5sjHSXIpMvhwQInIcGtO0qD8b8ytYdwWsPtfoxC2F
         Bk3luh6z2/IruzBVUqzIBD3Et+ev7/eJkbZHlAC4l7KxTDzXCQUmPWW+8vAuBhWMJHAp
         qXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709235517; x=1709840317;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rcIkG6HFp7uZcYBkm60c3cGbHaaSPPHBdXFb5C4zZf4=;
        b=LbytHKmzyEOaGHBm8+S2/8us5/GSZDpd0cxj5rQdA0Gr5UgtNzi1+IzYCglKV4lmKy
         4BY4i9ACqHt7hnr9iIKRiSi77osFn/uJuL3uIfBbQGw4xLF3GmFUgZGjmbsr+4gRIlhI
         jZDlDstYaDqsjT02BCahrMjaZZoaeZXx/CpID5ex3EJ9KBaIlMZ9iXqCH9FbHVyA1oHL
         3qA5v7/eo+It8x8sQ7C7gF4iUUJvBlZRaBE++XR5g07/DUwsxRuysudbwSJB7gNxaz/9
         XNEA72oS5ybgeIysSs6iJSauCxzsIQKaI/wYRAln9mjn9mKOU9TLkTRtyT5T09w9zmnf
         Z17g==
X-Forwarded-Encrypted: i=1; AJvYcCX/Yq3957ilfHqY6NHU8fZ6u+aXS+vtk4SLmu9kVdtHTKyBYJiF/1IziesdJxy/5M2D6E2FmQYrP4Ppz0Hl2Y1JDUArkUyXQ3Tely4Y1wJW
X-Gm-Message-State: AOJu0Yxwy/wGpL8jnSGVW+yPSFJSCmELyxpXj+hHttlkVs8kBAKqJxVn
	8YUdyk0h40VUPlaGZuIKhpLWgtvHY//9788JrcMcPPYSUTCKPpA9ZKrDkiA83nw=
X-Google-Smtp-Source: AGHT+IEc/+N/zfBWL2SjIGOuFZU9HIIzbM7d4fTNXNz5BNU0WgDZNIZtrvJHlvscGNOnWmqdoKxhBg==
X-Received: by 2002:a17:902:f806:b0:1dc:2755:16e4 with SMTP id ix6-20020a170902f80600b001dc275516e4mr3088414plb.22.1709235517284;
        Thu, 29 Feb 2024 11:38:37 -0800 (PST)
Received: from ghost (mobile-166-137-160-039.mycingular.net. [166.137.160.39])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902b28500b001d6ee9d8957sm1864423plr.281.2024.02.29.11.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 11:38:36 -0800 (PST)
Date: Thu, 29 Feb 2024 11:38:32 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	David Laight <David.Laight@aculab.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Helge Deller <deller@gmx.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Parisc List <linux-parisc@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	KUnit Development <kunit-dev@googlegroups.com>
Subject: Re: [PATCH v10] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Message-ID: <ZeDdOH0zBY8qKrVH@ghost>
References: <b13b8847977d4cfa99b6a0c9a0fcbbcf@AcuMS.aculab.com>
 <Zd0b8SDT8hrG/0yW@ghost>
 <cdd09f7a-83b2-41ba-a32c-9886dd79c43e@roeck-us.net>
 <9b4ce664-3ddb-4789-9d5d-8824f9089c48@csgroup.eu>
 <Zd25XWTkDPuIjpF8@shell.armlinux.org.uk>
 <Zd58jvN3PjQSe+yt@ghost>
 <c0449c0a-33bc-49c4-97e3-56a79a6ce93e@csgroup.eu>
 <02bb92c3-a14c-4a77-a3b0-a7c857d1d60d@roeck-us.net>
 <CAMuHMdW-sUYr8_y6av9Dbtz6JJAxBUsiTGZcK2QYEHo0x1z44w@mail.gmail.com>
 <e9112858-76b8-4b91-88b1-b5694cda3350@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9112858-76b8-4b91-88b1-b5694cda3350@roeck-us.net>

On Wed, Feb 28, 2024 at 07:40:43AM -0800, Guenter Roeck wrote:
> On 2/28/24 02:15, Geert Uytterhoeven wrote:
> > CC testing
> > 
> > On Wed, Feb 28, 2024 at 8:59 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > > On 2/27/24 23:25, Christophe Leroy wrote:
> > > [ ... ]
> > > > > 
> > > > > This test case is supposed to be as true to the "general case" as
> > > > > possible, so I have aligned the data along 14 + NET_IP_ALIGN. On ARM
> > > > > this will be a 16-byte boundary since NET_IP_ALIGN is 2. A driver that
> > > > > does not follow this may not be appropriately tested by this test case,
> > > > > but anyone is welcome to submit additional test cases that address this
> > > > > additional alignment concern.
> > > > 
> > > > But then this test case is becoming less and less true to the "general
> > > > case" with this patch, whereas your initial implementation was almost
> > > > perfect as it was covering most cases, a lot more than what we get with
> > > > that patch applied.
> > > > 
> > > NP with me if that is where people want to go. I'll simply disable checksum
> > > tests on all architectures which don't support unaligned accesses (so far
> > > it looks like that is only arm with thumb instructions, and possibly nios2).
> > > I personally find that less desirable and would have preferred a second
> > > configurable set of tests for unaligned accesses, but I have no problem
> > > with it.
> > 
> > IMHO the tests should validate the expected functionality.  If a test
> > fails, either functionality is missing or behaves wrong, or the test
> > is wrong.
> > 
> > What is the point of writing tests for a core functionality like network
> > checksumming that do not match the expected functionality?
> > 
> 
> Tough one. I can't enable CONFIG_NET_TEST on nios2, parisc, and arm with THUMB
> enabled due to crashes or hangs in gso tests. I accept that. Downside is that I
> have to disable CONFIG_NET_TEST on those architectures/platforms entirely,
> meaning a whole class of tests are missing for those architectures. I would
> prefer to have a configuration option such as CONFIG_NET_GSO_TEST to let me
> disable the problematic tests for the affected platforms so I can run all
> the other network unit tests. Yes, obviously something is wrong either with
> the affected tests or with the implementation of the tested functionality
> on the affected systems, but that could be handled separately if a separate
> configuration option existed, and new regressions in other tests on the affected
> architectures could be identified as they happen.

I think I got confused here, is this an issue with the tests included in
this patch or is it unrelated?

- Charlie

> 
> This case is similar. I'd prefer to have a separate configuration option,
> say, CONFIG_CHECKSUM_MISALIGNED_KUNIT, which I can disable to be able to
> run the common checksum tests on platforms / architectures which don't
> support unaligned accesses.
> 
> However, as I said, if the community wants to take a harsh stance, I have no
> problem with just disabling groups of tests entirely on platforms which have
> a problem with part of it.
> 
> Guenter
> 

