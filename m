Return-Path: <linux-kselftest+bounces-25856-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B134FA296A9
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 17:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D4FC1887FEA
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 16:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DDC1DD9AC;
	Wed,  5 Feb 2025 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COwGFWWK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CC91DCB0E;
	Wed,  5 Feb 2025 16:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738774019; cv=none; b=hieQcTfxFIMvVDFGfca5mmwYhVCeWM3es/wh9UfvP9y5v5eP/gdtvaZGupC6WHNe9sE8iUCi1bpjM+i74dzJmZnImy/LjTdISj6EkaykJgHXWpOZDapPL9gJ/KEQQ0RVMzcV/Og8v54wmdQVa0q0EfP2UZEwUHKDHyV+8X/PcI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738774019; c=relaxed/simple;
	bh=XeISXqd42exqvAVPrwIHSyfym3b34oGhEhsDoQ3MUaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=np+o+80UkN4BeclzALzLN2EzpFw5Mn0A0KETfI00LtfMGc2DElqfqDD1l/L7yB7nUmhkvpGUPcUKxxFd3nPpt3p668hVp043BlYNTE37rx7IahMecUO5nbBJJHfC/70wtE+EKXb+X5Gd71K83Ta8dN4H1lJTZv9yPOjLj9aeelI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COwGFWWK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2164b662090so386305ad.1;
        Wed, 05 Feb 2025 08:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738774016; x=1739378816; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aqXBwBRPHN/O69xxywYWHqng9DShzTJelOs40Bbp68A=;
        b=COwGFWWKTj46Kx6fY24q58XV0T76x2wItxppxKve1oH8qJImS6queUdm2f2xg0AY4s
         jVPalJS+8cVBosk1JKPL0pAwIamt9i3eM6+fMDCTDfPc4JQ2eolywBSWrOezg6E9c8A/
         CKp5Jpoc6B9qB5jSlNU1jeVnQLt1FkLXmvfVJzZGqBlujuATCGJzAgsjxKDrJmHmZtAE
         ZjcNDNQygYUdwkl2OPxPdsRZyCe5/nW2QYByf0/QRT0j2JdD/qakTnEHfD+hPTas6OPS
         QdamOrahOoapNfs9XGVDVFYPdhnbDmkpMHXNBZhcSmGU9/tJjjeom+e6ignZ//yLFUrm
         kNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738774016; x=1739378816;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqXBwBRPHN/O69xxywYWHqng9DShzTJelOs40Bbp68A=;
        b=Xc0C+oDTa9k56qNHvtCYGS1ztnPvK5eJL5/8/5Tvjt3PWAvPj6hpzFFzd+6KA5/Rg3
         5OTOmFLgh65y8sZ0b0t47yNdFrPa+rJkIFA1wytdBpldpU7HcfNUTMQYWPz2soIO0jiw
         0sCGMVKI7NMe6isjQSM7zEgH2hIiHbWIpkt68TKoa1CXeYJRiDrs/VyS1noAn1fEfB64
         xzP300uTLq5st3zXXFbS3uPoh9UazMiCze4WUpS6KC7Vwoi6lSphFw/S5GnY+fsPsftJ
         If37gPWBnLJ7vX4TcoU9XiPjKMJHXDS8Q0xg742dpwtX6H3elufswHPoiRLd/1AKiyco
         kH1A==
X-Forwarded-Encrypted: i=1; AJvYcCXJhoflDQuhqBznTuwuqOz7ToGdAqKk9nyUYzcBdTzRBMkAYubExDAvmT68+SgwHIh8sUneeFkt1N9EAc8=@vger.kernel.org, AJvYcCXtOK36x6WG+McFCIx/SV0qlebYmkdGzd4A43nLgLc9RBL/yDCcbeDS4KfaNzewnbHmXmygcCxm+fgCAbuYQs88@vger.kernel.org
X-Gm-Message-State: AOJu0YwrMKlOOH8MuYxTt1D2YXYBNk4rSKSyM5Ug76mOoMW8d5lsIIbf
	lImBgNDgPM69HBr3XXUF6QbeFguSyqWMhCXXdpx0dWa6BupV5KdZOHRIb34y
X-Gm-Gg: ASbGncuO+8BuATD2VmCGUM2qWxKTXOSjbDP9+tyM0WM1EF7qS1PoHn97VRaOjh4kP8k
	NlmQ25OUtNatJwhNbdxNVUDndUzeGpNHJUqP/txFd0oTEESRODiVxrvomKXb5PW45YvFzQ3sbG5
	U+fjvFFwCf7K56e/5ddU9kbTVXzNZBKm6WxFAeb9NHo2SrOz3hTxW/OYMOHcOYAJBTr0bL1y36C
	OI4085LI70vtLcndTf+NDFCOkQdl4OgedFZESDkdqUJDDrw8JG9w+6sZNCQCI6xd7/CjSNuJK5J
	b74Y47y7sDpaylX6stzYOfJ9WXLFs7+n
X-Google-Smtp-Source: AGHT+IFDah+d/asL9718yaWhEboZJgeAehLy+5t3KCxmUZ3TqnEfF2vNBCDxUP0sBXGrIXwCXLq64Q==
X-Received: by 2002:a17:903:22cf:b0:215:a05d:fb05 with SMTP id d9443c01a7336-21f17ebba7emr53432815ad.32.1738774015711;
        Wed, 05 Feb 2025 08:46:55 -0800 (PST)
Received: from vaxr-BM6660-BM6360 ([2001:288:7001:2703:71d4:ba13:76d5:56a7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec04796d6sm12120436a12.55.2025.02.05.08.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 08:46:55 -0800 (PST)
Date: Thu, 6 Feb 2025 00:46:51 +0800
From: I Hsin Cheng <richard120310@gmail.com>
To: Peter Seiderer <ps.report@gmx.net>
Cc: shuah@kernel.org, brauner@kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] selftests: pidfd: Fix compiling errors and warning
Message-ID: <Z6OV-1CTAcK3RS4e@vaxr-BM6660-BM6360>
References: <20250205053926.257732-1-richard120310@gmail.com>
 <20250205130756.7b7b4f7e@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250205130756.7b7b4f7e@gmx.net>

On Wed, Feb 05, 2025 at 01:07:56PM +0100, Peter Seiderer wrote:
> Hello *,
> 
> On Wed,  5 Feb 2025 13:39:26 +0800, I Hsin Cheng <richard120310@gmail.com> wrote:
> 
> > When compiling selftests files under tools/testing/selftests/pidfd/ ,
> > some compiling errors and warnings will pop out as the following.
> > 
> >   CC       pidfd_fdinfo_test
> > pidfd_fdinfo_test.c: In function ‘child_fdinfo_nspid_test’:
> > pidfd_fdinfo_test.c:231:13: warning: implicit declaration of function \
> > ‘mount’ [-Wimplicit-function-declaration]
> >   231 |         r = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
> >       |             ^~~~~
> > pidfd_fdinfo_test.c:231:36: error: ‘MS_REC’ undeclared \
> > (first use in this function)
> >   231 |         r = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
> >       |                                    ^~~~~~
> > pidfd_fdinfo_test.c:231:36: note: each undeclared identifier is \
> > reported only once for each function it appears in
> > pidfd_fdinfo_test.c:231:45: error: ‘MS_PRIVATE’ undeclared \
> > (first use in this function); did you mean ‘MAP_PRIVATE’?
> >   231 |         r = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
> >       |                                             ^~~~~~~~~~
> >       |                                             MAP_PRIVATE
> > pidfd_fdinfo_test.c:237:15: warning: implicit declaration of function \
> > ‘umount2’; did you mean ‘SYS_umount2’? \
> > [-Wimplicit-function-declaration]
> >   237 |         (void)umount2("/proc", MNT_DETACH);
> >       |               ^~~~~~~
> >       |               SYS_umount2
> > pidfd_fdinfo_test.c:237:32: error: ‘MNT_DETACH’ undeclared \
> > (first use in this function)
> >   237 |         (void)umount2("/proc", MNT_DETACH);
> >       |                                ^~~~~~~~~~
> > make: *** [../lib.mk:222: \
> > ~/linux/tools/testing/selftests/pidfd/pidfd_fdinfo_test] Error 1
> > 
> > Solve these errors and warnings by including header file <sys/mount.h>.
> > 
> > Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> > ---
> >  tools/testing/selftests/pidfd/pidfd_fdinfo_test.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
> > index f062a986e..f718aac75 100644
> > --- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
> > +++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
> > @@ -13,6 +13,7 @@
> >  #include <syscall.h>
> >  #include <sys/wait.h>
> >  #include <sys/mman.h>
> > +#include <sys/mount.h>
> >  
> >  #include "pidfd.h"
> >  #include "../kselftest.h"
> 
> Predated patch already available, see
> 
> 	https://lore.kernel.org/linux-kselftest/20250115105211.390370-1-ps.report@gmx.net/
>

Hello Peter,

Thanks for the kindly reminder!

Good to know it's already solved, thanks!

Regards,
I Hsin Cheng.

> Regards,
> Peter
> 

