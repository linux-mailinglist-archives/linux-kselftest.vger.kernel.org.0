Return-Path: <linux-kselftest+bounces-849-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DA57FE43D
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 00:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2A8282469
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 23:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F4347A52;
	Wed, 29 Nov 2023 23:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JszVLUSx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197EB10A
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Nov 2023 15:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701301481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wj14NLUM5uVjUx2vL7JDnyv8GZVAq3JS2Nn/ze66rMg=;
	b=JszVLUSx6w7ahbqVhs7NI+gzMB8NExEUATKIeHMc9SqFGVQnKeVB4LGcrWRaTbJPLUL+5L
	0viC48K6WQbIBGw3HMrRCkJvkjxuxSAFRjJYeM1SykYkAt91rkvGvg6DFen0bKfOqmMHiH
	WqDAT/Giu2D20isXInIzpcDLOtWTZD4=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-6ve1GTqcNual4bFhGnfs-A-1; Wed, 29 Nov 2023 18:44:40 -0500
X-MC-Unique: 6ve1GTqcNual4bFhGnfs-A-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-7c4b17f3c26so122622241.0
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Nov 2023 15:44:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701301479; x=1701906279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wj14NLUM5uVjUx2vL7JDnyv8GZVAq3JS2Nn/ze66rMg=;
        b=blBYeEy1VY3wkfJ+cgEFveWtOtUINDRv7yPcSXCtaSlY4U3K+EWON0sKElKNMS7VUb
         hjoFF8fQlJ5fmlUesjl5GfLUNkBj2sSrvVNwZaxvT6FS951ouLY4aKmhj5Wpf8ssC5gt
         NT/9W0sPVd9t9wYRYTS0QvVg3hFS+RYhGBEAQ0OHMuv9mlEUStsMNQh+sCAAYL0c64Zo
         FfsHQKT7FTUSpOXzcTPtn+tjMFGNOSya3P364IW5jvbDtOIlG5Uv2LzEHSdHIaB6eM5Q
         yV9eFQO0xNIySXr6IBMk6VYTFht0qe47iLZ9ndbBDkcxocWzTF/iIIdedNguk23F1C0e
         FIyg==
X-Gm-Message-State: AOJu0YyqYj6GOwT+oDwiqvRsuSIo/HewZFTZAMODztaYeDm74ACjWgMs
	p1CHcBY4nUKkquG77kdoDWPnnEwMM45Yrv1yjc1ioRxZD/PNvj8u6UFN5uh+ILuaD5FPv9D+Pkd
	2RGqNMv5xV/NGx3d4DF5MCCptQ09vd6fLCTZAFE3CC1WVzV7MDT0r
X-Received: by 2002:a05:6122:caa:b0:4b0:5c0:c006 with SMTP id ba42-20020a0561220caa00b004b005c0c006mr16487597vkb.1.1701301479475;
        Wed, 29 Nov 2023 15:44:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRC4O+v91fwsDKg5BsBJwce57hpPsosPD4pb5IlUJ/m9GK9WnfaytR6VlOSBrHvqIcf2mh7c0vBvyWjokdZ+4=
X-Received: by 2002:a05:6122:caa:b0:4b0:5c0:c006 with SMTP id
 ba42-20020a0561220caa00b004b005c0c006mr16487584vkb.1.1701301479234; Wed, 29
 Nov 2023 15:44:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129221140.614713-1-npache@redhat.com>
In-Reply-To: <20231129221140.614713-1-npache@redhat.com>
From: Joel Savitz <jsavitz@redhat.com>
Date: Wed, 29 Nov 2023 18:44:22 -0500
Message-ID: <CAL1p7m5H7YoQFg6BJ1zhPGyvfoL4BP1Tn1t-NYv=g2cuEQwJfg@mail.gmail.com>
Subject: Re: [PATCH] selftests/mm: dont run ksm_functional_tests twice
To: Nico Pache <npache@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, shuah@kernel.org, akpm@linux-foundation.org, 
	David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 5:11=E2=80=AFPM Nico Pache <npache@redhat.com> wrot=
e:
>
> ksm functional test is already being run.
> Remove the duplicate call to ./ksm_functional_tests.
>
> Fixes: 93fb70aa5904 ("selftests/vm: add KSM unmerge tests")
> Signed-off-by: Nico Pache <npache@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> ---
>  tools/testing/selftests/mm/run_vmtests.sh | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/se=
lftests/mm/run_vmtests.sh
> index 00757445278e..c0212258b852 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -334,8 +334,6 @@ CATEGORY=3D"ksm_numa" run_test ./ksm_tests -N -m 0
>
>  CATEGORY=3D"ksm" run_test ./ksm_functional_tests
>
> -run_test ./ksm_functional_tests
> -
>  # protection_keys tests
>  if [ -x ./protection_keys_32 ]
>  then
> --
> 2.41.0
>

Acked-by: Joel Savitz <jsavitz@redhat.com>


