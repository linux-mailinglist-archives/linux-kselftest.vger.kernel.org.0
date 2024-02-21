Return-Path: <linux-kselftest+bounces-5167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B73CC85DA22
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 14:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9AA41C23329
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 13:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A027EF1F;
	Wed, 21 Feb 2024 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lv4sN0MX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAB076905;
	Wed, 21 Feb 2024 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521951; cv=none; b=f6M0rIco4Tfs7Qwk7UMYmF+e+gnWLkHMkE3QX9qHqZaryeE9pARCuzeE+7Kwo5/2x5uaPB3ACxTF/lxuJ4KGqMIqWyD4KuLWZZNNbOtphHyLRCwSYXUfb/JkiQ+gS4BW2NKz6KsCK98TaByKWKmg43GqZljye92DHJGXzarKBks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521951; c=relaxed/simple;
	bh=Nm1KU7/+mO88+1MStPxwNA0OsfOBVrbQL2XjjeYXgrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHoiBsNKxEBBQddkHOm19v+ABAxhImcQY3XVO4Kjv2gw6WwzBJoFRuxvMzxe+hu22Rva+PSY5W9MrjzaMbk3SVWn4BzfGob+hPaszYxmPR6T0yDZB2GsH3brMqY3nWIy531bMP1bdyFHhI6F6Kw4FiOd3HFiNMFGPKUyGa4wGnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lv4sN0MX; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d7232dcb3eso39217505ad.2;
        Wed, 21 Feb 2024 05:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708521949; x=1709126749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TMD7R8y65kHdSRzvHZ0/j8HTA7EF077bxXH3c7GeV1c=;
        b=lv4sN0MXJWrNu1V4gto7mUvAXXtNnHoxVMcNWbwHRIGXU0A5KYSkYUYNnuJdwgHwhB
         8LjrDBPHMi9YRY29Lj2ONAug47C9uHN/DcgS3JAnLB+3TpWt20+DvJKwnqo3wgmGCSf2
         jJjwZGIBqvA2AyZK/Qf8GjWWfmTbUro6iwNZVwXdEGleLOJXC8Uzq7q+8pJLXi/rxOIt
         qjPvqgnsXoTuLX9ob5X6gEDeuqu0YflSJYloYr7X4B5g9GivcK+Ccd5yMjdE/N613tq3
         AgnmrBw583oewPLfNDE3WI623t3GeXNi49b3pORD8JY4MW3x5XKtZHAxSRlLQphPGAlk
         a8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708521949; x=1709126749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TMD7R8y65kHdSRzvHZ0/j8HTA7EF077bxXH3c7GeV1c=;
        b=Cxu4N+GrhNwVAdyE8/BS19GrNWRqdE2gZCQTU2DhrIrx8kPZbLiNZiyRHTa4zZSBO7
         ffcUiZ1A03hMV5mdL8L1WUqQPOvmR4du0icrxCNX11SSZZMaeGBw0n8qnWQ4xM/TCt5D
         NYa2kZC6Vi9PNQGH3boHIN36dB8ZyUBzE6mxcCZx8Vv8l6eYwqEmMGD2eQMK5mBX2rd+
         0psNsniKldz0FKHLF9RlLwGzkCsGv+ZN0kkQLI7QW7AXPJXH/TMNqaP8at3xwMCeot8L
         sDXOdFPuMb5NCBKkyBkgWNcFPWZ/LuLeR3hQh7tu7BqDVBPPxACr/c1LC8gTcZE14YtE
         xPAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUppyuXK5dRLT03XN1kfsiK0s54dGz6ikH5qrNv/BLv2i4HOBZ3FCuBxFr2Wy/kg6rnrhkOgO5wfe0yz3JXDIAx6VnrMk5i73WxZB+LcUKgnJBCz2I+kZM9ilTOyF9EtTej2zJY8E6B67nLCXi+1wOYUFbCuF9jR7SuSkYqByHaZmZ0crV8ZBJqiBg0iJfIV5AJkV33PH+fANaoV8CcdXwkceBQSpVLc6OwWr2LsXxRwhe9+AxP+AtS8TI/zbXA+md1
X-Gm-Message-State: AOJu0YwVhExaDTDz9UsuAouj/DkGeuJrtFENUNxktl3iE4j1vo3ppHAj
	XlVlX5Odn2LAcz6cDXxOxWv45vBYOQxx8Ae6e4FeBa08hbao/1L2
X-Google-Smtp-Source: AGHT+IHT+AIwPR32g9+RGmyDYHlQWSCNbDqxpO0hHviSSTJUGOyxwRIiompW2Pi420GKW+V2NVs8tw==
X-Received: by 2002:a17:902:d489:b0:1dc:1e7c:cd3 with SMTP id c9-20020a170902d48900b001dc1e7c0cd3mr4511989plg.47.1708521948937;
        Wed, 21 Feb 2024 05:25:48 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902ebd000b001da2f9d04b0sm8077527plg.15.2024.02.21.05.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 05:25:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 21 Feb 2024 05:25:47 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: David Gow <davidgow@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>, Rae Moar <rmoar@google.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Kees Cook <keescook@chromium.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Florian Westphal <fw@strlen.de>,
	Cassio Neri <cassio.neri@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Arthur Grillo <arthur.grillo@usp.br>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Daniel Latypov <dlatypov@google.com>,
	Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org, linux-rtc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 3/9] lib: memcpy_kunit: Fix an invalid format specifier
 in an assertion msg
Message-ID: <de3abf44-6ce1-4bc1-9480-a977d83aba3b@roeck-us.net>
References: <20240221092728.1281499-1-davidgow@google.com>
 <20240221092728.1281499-4-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221092728.1281499-4-davidgow@google.com>

On Wed, Feb 21, 2024 at 05:27:16PM +0800, David Gow wrote:
> The 'i' passed as an assertion message is a size_t, so should use '%zu',
> not '%d'.
> 
> This was found by annotating the _MSG() variants of KUnit's assertions
> to let gcc validate the format strings.
> 
> Fixes: bb95ebbe89a7 ("lib: Introduce CONFIG_MEMCPY_KUNIT_TEST")
> Signed-off-by: David Gow <davidgow@google.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  lib/memcpy_kunit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
> index 440aee705ccc..30e00ef0bf2e 100644
> --- a/lib/memcpy_kunit.c
> +++ b/lib/memcpy_kunit.c
> @@ -32,7 +32,7 @@ struct some_bytes {
>  	BUILD_BUG_ON(sizeof(instance.data) != 32);	\
>  	for (size_t i = 0; i < sizeof(instance.data); i++) {	\
>  		KUNIT_ASSERT_EQ_MSG(test, instance.data[i], v, \
> -			"line %d: '%s' not initialized to 0x%02x @ %d (saw 0x%02x)\n", \
> +			"line %d: '%s' not initialized to 0x%02x @ %zu (saw 0x%02x)\n", \
>  			__LINE__, #instance, v, i, instance.data[i]);	\
>  	}	\
>  } while (0)
> @@ -41,7 +41,7 @@ struct some_bytes {
>  	BUILD_BUG_ON(sizeof(one) != sizeof(two)); \
>  	for (size_t i = 0; i < sizeof(one); i++) {	\
>  		KUNIT_EXPECT_EQ_MSG(test, one.data[i], two.data[i], \
> -			"line %d: %s.data[%d] (0x%02x) != %s.data[%d] (0x%02x)\n", \
> +			"line %d: %s.data[%zu] (0x%02x) != %s.data[%zu] (0x%02x)\n", \
>  			__LINE__, #one, i, one.data[i], #two, i, two.data[i]); \
>  	}	\
>  	kunit_info(test, "ok: " TEST_OP "() " name "\n");	\
> -- 
> 2.44.0.rc0.258.g7320e95886-goog
> 

