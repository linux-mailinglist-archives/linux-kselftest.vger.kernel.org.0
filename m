Return-Path: <linux-kselftest+bounces-8694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D14C78AE60E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 14:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6627F1F2316C
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 12:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC875433CA;
	Tue, 23 Apr 2024 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XM47jVkA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBAE290F;
	Tue, 23 Apr 2024 12:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875517; cv=none; b=HGYnH+nLAGg0KYr/6oCHG6WaJ+nO13BIO8A0swN8IV8CXu6tBYwiGguQjP5lUr++u/+NlWwJ8QmPughNypTLSLPR6xXjF5ZrdiheLIl/u851KKw7CM7shmMO1+c6kfbIGLV3s99afcUSwK4QzHQZrN4s655x6ovg1M0QPM+y7ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875517; c=relaxed/simple;
	bh=IDSCxxhdHhRXxBfpnXFDM6TyH8ueBoD8Bd6aos4gGNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTZVutYgeNz0a4cNu000lRMH9ESEghLAi5W6/czi8K++lLPpoPqPoE9abh1f9AhMYLe7l1Dfvt3z/Frudk8g0whHv6kHyJBQ7cUB/sDXJ498vIvp5xY4XfJz5UcPLOAYhuyzw0jW3YwJhUhFVcoU8N1IC4c2jEBzvyNgT6zZh7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XM47jVkA; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e5b6e8f662so43407625ad.0;
        Tue, 23 Apr 2024 05:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713875515; x=1714480315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pbEmdGmNFi4qs7xTEBqGa2VybiATWfCq+qh8djizPWg=;
        b=XM47jVkALRZMER8uQzYuzhgD7krNX3hi0x1wDdkjP+QjrzNcq7wyZS6Uoz8///R2/9
         YY4AaHdx5+nP1Da426yWVuq8Mv4C+rwmkmsPEB9EfoLq2sypznY+A8pPkW6DKmOzLa0s
         gCpNbCWgvba8OoO1Y8Tk573WpnYSBZX47c5M5jh2sg44k7QD/5lrteI3iL2EBqAWIdKm
         qjjChAyOVYFqHiOVXYAwJV51KSjMLwN9bgiHOXtYaVxIFDSkCs8HyafFyN9dWH1TGdEB
         MB1fAsojYEDfeFlF/5SdrIFKwuWqAB9C6x1PWu9uVTCZbUA95QV+shtDyMmdfqbuDMSD
         Q69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713875515; x=1714480315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbEmdGmNFi4qs7xTEBqGa2VybiATWfCq+qh8djizPWg=;
        b=GNYAnTnQOgs6zhbS+RJ9fCzz8zxotLYZBWvVcMk+SipmrBpw7VmIlCbIjR6tBTHvtJ
         VDB9TiP1L+APxhltoLr1gRfuhJJw2h0t13V8DSMh/HPgnbn2FbIp/6esntMfUhjjErUw
         Q24RYzfAsF0Ans02XS8mHv98OTaG0DBkmkPJrQhIpuPZGqwJugoCvWoIIByqjgzz70k1
         VdRsa+FX/541P++8DwCGVxH0S8t2xAEW42SP+8HoAVJrIhmbgm/DLWYfGps91c45eNT1
         CK3wODvtXaUKJd67lZ0UYBT0lvHOwRSWRR6PqQswKebStiAMCIYbAkAVhM/Q0R6WsqFT
         0j3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWV2UBFqZfdiL8AB1aORp0+Buse4a9Tf4INhuOaHgzcXGR9ED+CV1lpWVX25naPYNVHAuSkzqRB70gql/Ka71aP8/kZGkRErTP2obF4rLCWg+lQxTx4ELH6UrXUcMwNAuJnV22lY4GX0dTPKhGn
X-Gm-Message-State: AOJu0YyJus3VgQtW5jftanSUIKjkhBoqWduB6H6mTnJRP4Y1b11hJ+F5
	FBRl6kPEe04V4CqhG04Y6pmcjuBB6jfIuz2sLJjSj5WpzVseohe2
X-Google-Smtp-Source: AGHT+IHPqhkgXsE00QCP8fDrWe4AgTg9xwy/VaEcMJBcFzueaQFqOca25Aex9q7bJqJiyIVcc3o63g==
X-Received: by 2002:a17:903:120a:b0:1e4:70d0:9337 with SMTP id l10-20020a170903120a00b001e470d09337mr15948574plh.45.1713875515324;
        Tue, 23 Apr 2024 05:31:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id az3-20020a170902a58300b001e0af9928casm9914042plb.55.2024.04.23.05.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 05:31:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 23 Apr 2024 05:31:53 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Shuah Khan <skhan@linuxfoundation.org>, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit: test: Move fault tests behind KUNIT_FAULT_TEST
 Kconfig option
Message-ID: <47536716-3216-43c2-8cac-3d2b2bcb6a7d@roeck-us.net>
References: <20240423090808.242389-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423090808.242389-1-davidgow@google.com>

On Tue, Apr 23, 2024 at 05:08:06PM +0800, David Gow wrote:
> The NULL dereference tests in kunit_fault deliberately trigger a kernel
> BUG(), and therefore print the associated stack trace, even when the
> test passes. This is both annoying (as it bloats the test output), and
> can confuse some test harnesses, which assume any BUG() is a failure.
> 
> Allow these tests to be specifically disabled (without disabling all
> of KUnit's other tests), by placing them behind the
> CONFIG_KUNIT_FAULT_TEST Kconfig option. This is enabled by default, but
> can be set to 'n' to disable the test. An empty 'kunit_fault' suite is
> left behind, which will automatically be marked 'skipped'.
> 
> As the fault tests already were disabled under UML (as they weren't
> compatible with its fault handling), we can simply adapt those
> conditions, and add a dependency on !UML for our new option.
> 
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Link: https://lore.kernel.org/all/928249cc-e027-4f7f-b43f-502f99a1ea63@roeck-us.net/
> Fixes: 82b0beff3497 ("kunit: Add tests for fault")
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-and-tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks!
Guenter

