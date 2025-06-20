Return-Path: <linux-kselftest+bounces-35439-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE6FAE1DB8
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 16:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCDB27B2997
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 14:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6F0294A19;
	Fri, 20 Jun 2025 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="MaQju9Ir"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8AE28E578;
	Fri, 20 Jun 2025 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750430615; cv=pass; b=Co6a9QBOgyH+mLSdnYGKVLixqPKvTYMjCSAkEXJP+RRatyXvfJQPofOiUiOnaTdGCcEb+iKtAhOUlKKYw340FWPznYfRxbHnGDGca+aVZqEHJ+2gSlNiMunhj4XVnGsY+Oc/tYEep80q+60nq802RM/xQuBk9lXfq/MS+BbaLuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750430615; c=relaxed/simple;
	bh=c1pQrfxRWl1sOJ7finPJ/sCOfQAT52YeHpOHp0CnBZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPlhx/XIuHpUApsXX0urozEDC6WyVUBOcWNGiVmFA5+rFCN/vaKrvVrqYwNEIgl3O1kWFNMVY5UypEFdxDEG4KTsrNC8IFqVAbTGXdrZZE5CWKsVv0ey5hVtFuZjfwMnAYfSFZgJ8EiuDFJl3l7nwDDx9Tiw1IHtJPu3qQwZyJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=MaQju9Ir; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750430597; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MlcLMPwLYCnCayBemjE3JzoLWC/+ehh5d05eVftaMTbkqcXXXXsrcJsMjYqiJpJ3IVxPzZf950eYS0F7IHWeGf64XRsneNy0af77IXvxUHqngWHkDYDj9Gs3jq835b84K5xdZvrEuC0HYF3Qn0Yyz2v3y2AkUDW+RKdaazCjY4I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750430597; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4qg3MTUKad/Z2UUWW8kglBmCBRpkv46dj3THwNv8XQ8=; 
	b=e5tu8708jnzRAN9Gb9jlgovHohiOqv/qkjyLtNGUDcasND7AvlHIMVpffCmcn2u0Gt28+ufYouvGViHAbydinWxEXhm6/HJpTgW+SXDaX1amlOnqOrJAQjM6r23EQcUVxNGBrnavnDCl1Bg1EgNxsRMfQHEBCjy4RQ5gmCRuYoc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750430597;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=4qg3MTUKad/Z2UUWW8kglBmCBRpkv46dj3THwNv8XQ8=;
	b=MaQju9IroJM1sNMmpr1aULgN1nJwXn0ZdUBE/xJP1lfCjY5IqvEN6yativpAYuBj
	2hOpvUifB1IbLn/QMkYsBSy/IDG+XyiIlCkJQFgxZh7YRJIigWCHTMVdNX6t4fJeKWI
	j8GfDBl21KvyzXw/M86K0+IA5b2JvM99p5J6YR7o=
Received: by mx.zohomail.com with SMTPS id 1750430595807654.5823008524;
	Fri, 20 Jun 2025 07:43:15 -0700 (PDT)
Message-ID: <41776b27-eedd-4fc4-8480-0831d64c7327@collabora.com>
Date: Fri, 20 Jun 2025 19:43:12 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/filesystems/mount-notify: remove
 __kernel_fsid_t
To: Chen Linxuan <chenlinxuan@uniontech.com>, Shuah Khan <shuah@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
 Miklos Szeredi <mszeredi@redhat.com>
Cc: zhanjun@uniontech.com, niecheng1@uniontech.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 usama.anjum@collabora.com
References: <20250620034403.2932627-2-chenlinxuan@uniontech.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20250620034403.2932627-2-chenlinxuan@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 6/20/25 8:43 AM, Chen Linxuan wrote:
> When build kernel selftests on Ubuntu 24.04, I got a compiler error:
> 
> mount-notify_test.c:22:3: error: conflicting types for ‘__kernel_fsid_t’; have ‘struct <anonymous>’
>    22 | } __kernel_fsid_t;
>       |   ^~~~~~~~~~~~~~~
> In file included from .../linux/usr/include/asm/posix_types_64.h:18,
>                  from .../linux/usr/include/asm/posix_types.h:7,
>                  from .../linux/usr/include/linux/posix_types.h:36,
>                  from .../linux/usr/include/linux/types.h:9,
>                  from .../linux/usr/include/linux/stat.h:5,
>                  from /usr/include/x86_64-linux-gnu/bits/statx.h:31,
>                  from /usr/include/x86_64-linux-gnu/sys/stat.h:465,
>                  from mount-notify_test.c:9:
> .../linux/usr/include/asm-generic/posix_types.h:81:3: note: previous declaration of ‘__kernel_fsid_t’ with type ‘__kernel_fsid_t’
>    81 | } __kernel_fsid_t;
>       |   ^~~~~~~~~~~~~~~
> 
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  .../selftests/filesystems/mount-notify/mount-notify_test.c | 7 -------
>  .../filesystems/mount-notify/mount-notify_test_ns.c        | 7 -------
>  2 files changed, 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
> index b4cb494206e5d..2d197ad8cb75a 100644
> --- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
> +++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
> @@ -15,13 +15,6 @@
>  #include "../statmount/statmount.h"
>  #include "../utils.h"
>  
> -// Needed for linux/fanotify.h
> -#ifndef __kernel_fsid_t
> -typedef struct {
> -	int	val[2];
> -} __kernel_fsid_t;
> -#endif
> -
>  #include <sys/fanotify.h>
>  
>  static const char root_mntpoint_templ[] = "/tmp/mount-notify_test_root.XXXXXX";
> diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
> index 1bd090e9c8dd5..d6a6a7ee87028 100644
> --- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
> +++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
> @@ -16,13 +16,6 @@
>  #include "../statmount/statmount.h"
>  #include "../utils.h"
>  
> -// Needed for linux/fanotify.h
> -#ifndef __kernel_fsid_t
> -typedef struct {
> -	int	val[2];
> -} __kernel_fsid_t;
> -#endif
> -
>  #include <sys/fanotify.h>
>  
>  static const char root_mntpoint_templ[] = "/tmp/mount-notify_test_root.XXXXXX";


