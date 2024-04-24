Return-Path: <linux-kselftest+bounces-8805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848A18B1196
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 19:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427A828BFCC
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 17:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9501916DEBB;
	Wed, 24 Apr 2024 17:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOYxPown"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A7916D9DE;
	Wed, 24 Apr 2024 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713981572; cv=none; b=Boaat6uK44nqI3oHovLyjl+mG8qJQFKKLrTz4WwhdSS1CNM6EbPG6LWuzyAsGmS5qWTRQmfVrBWoO/4eZJsVlKVYNHnlcO8PTV7h/xFBNkxztdIAFvIQTokN6NI4j1TUbBJnqeobL3T2DNNf01GZH9B2so+BlURf2pr2FoM2Y88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713981572; c=relaxed/simple;
	bh=cAkAYiHazk+6ficSxW+gfWAABuq28aURZDIh57H/oqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9qFLER+HF6e6cZjSYN602E+EzSwDMzd2tbk/NFNw4ArBp4YmWTIGZh/kUtOY1CCI5oRs8tQwbblAyxoogWdE+zDHRBOP3SmzJEFklf5ppIztO2BSTgMNhqncLwAP95CI/I8JkUfEHs4TPlB6C+hveuHjAYLcnF3c8lIBka0Ev8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOYxPown; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-69b2f6d31c1so903556d6.0;
        Wed, 24 Apr 2024 10:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713981570; x=1714586370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UviPyNamfMTO0wa9/YHBUwdb+S4+5wLBQZutMKBqdto=;
        b=gOYxPownoOGZMxtVNEI0ftKZVUcCqe02JwKNdb/PKzbJ5pmMhvHe/T+OrRkwokBzAv
         3vhT1Maz6THPTXffruT4JIBeu4u1cs6y7OFgcSavajmv88zHwacQmXZEr56FcZ2Qd4/k
         ObzN6HqxfJvLwqCJyfrtf017wKXtAJpkuNPUZdmqTRJGXE+BNWy5AZ/UVY84EWIXOSYA
         vsQykZUwfkxv8NSeuH5Ile5FVMHK8XVJUdaimUXu2/MGabx6Q2MVRkDSYpYZoBpWn5WS
         RbBNg89RDoEpTikcPXheqGf29Ucq03XJYynFAX6LPY6ZUSIzZZzz8GxYskamnwSvhp20
         WiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713981570; x=1714586370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UviPyNamfMTO0wa9/YHBUwdb+S4+5wLBQZutMKBqdto=;
        b=uKXW9whDFt5wLksf/IsJR/P9NUi1TU/WEiW2UXnvtS/Vzs42BDk/Kul+bZYgjhT361
         z0E342phb9XSdvDYvPrp+mX0KXEWTfxm0NTbMYRCD+9A2YGH4p0rP8VeYIgMtmequqoA
         Xkw8zvu5MEeS7kdfD2uBLGlFiLSmcjp/oxyzPLLDclZUzL2UPkvjy98pR4k0DTJPoWaK
         F7nzUKfiKoTsoWxaQ+ARl9JQG2ynqPI5rZ194MBPHaDbqEMfsP0OsD1Eo6tdiJ1Bi7K0
         9eXvVLRMlD6+38jFRjDTISipKt3K+AROkgDY/bcauTsSh+9eK1l2Cki0hixo5JBKkR0P
         1Rlw==
X-Forwarded-Encrypted: i=1; AJvYcCVEH2kshxN5asav5T95wKjMWMF370ye3X8jBPCTRZ+wgQ84MfiLhISW4cUgWvVbkhrwoanzD+IqIYECMZpOf02p0HuNGR09844lmi8d3NyONHQzGW90foWgRbXUr7oTJ9qNQPp5kE6A
X-Gm-Message-State: AOJu0YzjOSAcYRbW1o08nolOuIwAB0I0gwhrDaTLXJoaovKNNIpPSXNj
	ZhxwUdN/K7RlQPSO3d1Kd+jPvVMbEltyHgnBmSHpNbJHjHxFlWp2xlSZfXZa
X-Google-Smtp-Source: AGHT+IHlkCkzPkV5Rdejgq9/gyOM3k6umMmvXMnEMrQSZsY8zKh/9VlyjWKU1mZ0dZRQgCvKLDnv1A==
X-Received: by 2002:ad4:430f:0:b0:6a0:5fea:9892 with SMTP id c15-20020ad4430f000000b006a05fea9892mr3273972qvs.6.1713981570132;
        Wed, 24 Apr 2024 10:59:30 -0700 (PDT)
Received: from localhost (24-122-67-147.resi.cgocable.ca. [24.122.67.147])
        by smtp.gmail.com with ESMTPSA id i11-20020a0cab4b000000b0069b59897310sm6252616qvb.63.2024.04.24.10.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 10:59:29 -0700 (PDT)
Date: Wed, 24 Apr 2024 13:59:29 -0400
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Aaron Conole <aconole@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	dev@openvswitch.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [ovs-dev] selftests: openvswitch: Questions about possible
 enhancements
Message-ID: <ZilIgbIvB04iUal2@f4>
References: <20240424164405.GN42092@kernel.org>
 <20240424173715.GP42092@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424173715.GP42092@kernel.org>

On 2024-04-24 18:37 +0100, Simon Horman wrote:
> On Wed, Apr 24, 2024 at 05:44:05PM +0100, Simon Horman wrote:
> > Hi Aaron, Jakub, all,
> > 
> > I have recently been exercising the Open vSwitch kernel selftests,
> > using vng, something like this:
> > 
> > 	TESTDIR="tools/testing/selftests/net/openvswitch"
> > 
> >         vng -v --run . --user root --cpus 2 \
> >                 --overlay-rwdir "$PWD" -- \
> >                 "modprobe openvswitch && \
> > 		 echo \"timeout=90\" >> \"${TESTDIR}/settings\" && \
> >                  make -C \"$TESTDIR\" run_tests"
> > 
> > And I have some observations that I'd like to ask about.
> > 
> > 1. Building the kernel using the following command does not
> >    build the openvswitch kernel module.
> > 
> > 	vng -v --build \
> > 		--config tools/testing/selftests/net/config
> > 
> >    All that seems to be missing is CONFIG_OPENVSWITCH=m
> >    and I am wondering what the best way of resolving this is.
> > 
> >    Perhaps I am doing something wrong.
> >    Or perhaps tools/testing/selftests/net/openvswitch/config
> >    should be created? If so, should it include (most of?) what is in
> >    tools/testing/selftests/net/config, or just CONFIG_OPENVSWITCH=m?

I noticed something similar when testing Jiri's virtio_net selftests
patchset [1].

drivers/net/virtio_net/config includes virtio options but the
test also needs at least CONFIG_NET_VRF=y which is part of net/config.

Whatever the answer to your question, all config files should be
coherent on this matter.

[1] https://lore.kernel.org/netdev/20240424104049.3935572-1-jiri@resnulli.us/

[...]
> 
>   5. openvswitch.sh starts with "#!/bin/sh".
>      But substitutions such as "${ns:0:1}0"  fail if /bin/sh is dash.
>      Perhaps we should change openvswitch.sh to use bash?

I think so. A similar change was done in
c2518da8e6b0 selftests: bonding: Change script interpreter (v6.8-rc1)

