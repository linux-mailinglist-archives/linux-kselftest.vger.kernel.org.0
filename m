Return-Path: <linux-kselftest+bounces-19356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 004F3996CDE
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 15:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23557286336
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 13:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A854219995E;
	Wed,  9 Oct 2024 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hplsf10h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA22188722;
	Wed,  9 Oct 2024 13:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482150; cv=none; b=RWavoVqNuZt6GFoIRkSmOUTkKyJSheH59nvrQxZ4PEkNqhXR3XZ5MwaVIbkWkO+Tb9nVVHO0FHjPdB8W1f9uDLdi3YJ9Jeacrylw10p+4zMuyBh0lEkBFp5noSdbjQqqUS1vaV5mb3SFvgpVd0NS2rXW8lqQzO0vDVnMTPlXrSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482150; c=relaxed/simple;
	bh=ZmiVMK6ztxb9hHv41yV8uT13LIdkutdZjhOKK9Mbmuc=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=EdVGXtj/VNPtM1N5YQnVB2bnOR35f6kqx+PXn3o2Ili7rgnpyDibv/d4LKUdEmeIc8SAlzEasBLDrbzYgfFT9trMTeE6zKDUjC1xRq0xR+ZZrtEqbckp7C1N3xuAi4iaxpbB+GHJo1+rdivlt77r3EZPlqIztSB9O+hGykmWfLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hplsf10h; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cbcd8ce5f9so4127056d6.2;
        Wed, 09 Oct 2024 06:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728482148; x=1729086948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXe51mvGhfEwWJHFEltEwZF8MBYYvVcNp5ZwNgaG/kc=;
        b=Hplsf10hNReBNiL9nNMsdSSbu37f2NdveDbR5302vVXhqrZjmXgzTM5OB3qE0agnHm
         N4mQ5mXNTMiSOYEv3O4yYQCqIiApCiPeAVRHDY4SNovOcRBUfZee05bobXPMOBl36+Hu
         FbE4Y0EUMfsXQdtWJnRcadPOW8ldTIv4N5l9pzIHy6x5zif974bkgdN96knsn7NmevV0
         wj1hCKnaT4u/LdSdsAcrZc98D5Cm+NSFyKJVhbjBUcsaA+qa0MIPgEHzvpircJrgi604
         zXMvkOD10l386djhHPm68Ezdrq1c6PuGWC+tkxAs2GQ9Ze6h7rqBzES9h+RrmLXWI3aZ
         2HIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728482148; x=1729086948;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXe51mvGhfEwWJHFEltEwZF8MBYYvVcNp5ZwNgaG/kc=;
        b=cjrv3nLOAUvTJUeZBIgJ75E5DlDPTpz0H7xR7w7FlGj8edR2iL88dhLkSoLiyu6Ji8
         rNR47wS2wgbXp8l2l9ReC/AxH5DNdMJbUkKlU57bVkLAFDitZ3G3p0Fk8Irdn4jxj4Te
         fdVnfga20dQc1+Uqiwq9R45wex9NtzOw3iTkKsWDomED3fFzmgxa+wGt3XnGhrbbKUVD
         NplBqkP+V1rRWu7G1b8YWlY5rMoZbDmc9CdGHAYMUp/3fTVixZ24sjwI7qOfvTqoG/6A
         rqTitA6kUsjNN/g9uG1fyy6y8IG3RtQVQX5P2de306+4Mcg1Z2TkWnmcPvo8XsTlYYFz
         Z5Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUbTdG4FJs8twCuLi0QJZ/bm7k+9DQRl5VaZNxfzOBw7Jg4n8aJf/CkWhQAb9qTld68i2qoNSC4Dme4fLVwKOGP@vger.kernel.org, AJvYcCVAxWwygYNLVLjpVQ4z8yaHts5Ml/uYCSYs+kO88Tb65N/pKZdBsFz+GZeOzpwVyHwQ0wA=@vger.kernel.org, AJvYcCWjQhqI2VfRgPQe6gR2zYzt5xDbDvhpAvGW88SbX/oA775gXrCMq/gCsAEAxHLLCTGRSnGvezdgM15y@vger.kernel.org, AJvYcCWkw8m7iqDIZSJP3xz3FuGevex0YhiiiqDyhbyvLc+0Bybwl75FYkl7y0FDXuAgt/u/r6rrli894Kzu7Dw3@vger.kernel.org, AJvYcCWzZVVd1p6vX05ASLFT6Xv4kmAr5FWFIGVZCSdcbNAwFdnYaAvtt5CG+w5fbaM6utZlVkJGxEAO@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdbq6JQ4945WM9IX4YY08N5HYE1KqOwxogDhILafW5i3U/kXn4
	N0UqgVK4WaJJ9Kopxj6pw6+PbZDjXNPcCrqu/dseq1EjpZdvDJ/q
X-Google-Smtp-Source: AGHT+IHmYx3bfmg/RlYhB/KBBRbGOAep6vvua+Aei8GWXcm7XpACan6FRH/ojiSHoStLQfx//viWDw==
X-Received: by 2002:a05:6214:2b86:b0:6cb:22ea:5e07 with SMTP id 6a1803df08f44-6cbc943269amr41560246d6.30.1728482147816;
        Wed, 09 Oct 2024 06:55:47 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba4760436sm46098496d6.124.2024.10.09.06.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 06:55:47 -0700 (PDT)
Date: Wed, 09 Oct 2024 09:55:47 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, 
 linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 gur.stavi@huawei.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <67068b632d2d2_1cca3129484@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241008-rss-v5-4-f3cf68df005d@daynix.com>
References: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
 <20241008-rss-v5-4-f3cf68df005d@daynix.com>
Subject: Re: [PATCH RFC v5 04/10] tun: Unify vnet implementation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Akihiko Odaki wrote:
> Both tun and tap exposes the same set of virtio-net-related features.
> Unify their implementations to ease future changes.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  MAINTAINERS            |   1 +
>  drivers/net/tap.c      | 172 ++++++----------------------------------
>  drivers/net/tun.c      | 208 ++++++++-----------------------------------------
>  drivers/net/tun_vnet.h | 181 ++++++++++++++++++++++++++++++++++++++++++

Same point: should not be in a header.

Also: I've looked into deduplicating code between the various tun, tap
and packet socket code as well.

In general it's a good idea. The main counter arguments is that such a
break in continuity also breaks backporting fixes to stable. So the
benefit must outweight that cost.

In this case, the benefits in terms of LoC are rather modest. Not sure
it's worth it.

Even more importantly: are the two code paths that you deduplicate
exactly identical? Often in the past the two subtly diverged over
time, e.g., due to new features added only to one of the two.

If so, call out any behavioral changes to either as a result of
deduplicating explicitly.

