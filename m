Return-Path: <linux-kselftest+bounces-8621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C708ACEAA
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 15:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C530DB20D03
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 13:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5246414F9FA;
	Mon, 22 Apr 2024 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QDXBjjql"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B001A14F9FF;
	Mon, 22 Apr 2024 13:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713793748; cv=none; b=WgCIf1UVdeTbPxatxpYnyj1FBMFEql2LkNCvY6caVs3VhXoZrwqMCgL/S9kiXP/xsZohOHdcTL7y/YtBS2OEXtx93cbYXMzEPrmpK/htD2HyQdMs9r2D8MxlBst+B8kzGHCROnfaEkrlsuDC7AL2v+aZYUWxjQLVNvULs+GyO6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713793748; c=relaxed/simple;
	bh=TquHs7URRWUMNqGjefXsApBJcgMXy4dLpEqb8Yor0AE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oW2SWGEyB4T4miVoDTgE9Wep3u/4Nq/NbqxdJOyzHiCgRpOcDCoparTMoPbEr2o1dRSTFhq+w2majLPVBJrPkMPr3OiqHj0AW1fBD28qO+rnVT62HeButkc3qw+gHFo67bVfdQNTgTbBMLi0eb3GRkvi1ySXnPQ0jQstKaFxKvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QDXBjjql; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713793744;
	bh=TquHs7URRWUMNqGjefXsApBJcgMXy4dLpEqb8Yor0AE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=QDXBjjqlWcEdRmYHyX7ArYRnBRD84bIGhiYEgGTkG5yGUyA9nFKMtJ6tZXmgNQpb8
	 d3/nQRbHbjUAdgsyzQavpNbo/DJfNBy45op8+GQVBHqJ5B64IqkknqfPa87uQbfc74
	 0ChWRGVmdT2t99Am2+7crmKDfeeReWvEYCrgdAmNDg8PALspUw5wPYqqe0wQ/SslnS
	 YpsFE7OpDLXJmB2Jhzuu3FxHCdNlD5KhMhujvVkSuxpCkqIRizeYhQBewwOLNbttS8
	 8wO+PGfcUFL6TxweuwmLCuq5bXvpXhQQ+RZxBS4hAVJxeFHdcjtB1MKRyof75Ll8Tu
	 3R1t7jTALkxtg==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3D69237820E2;
	Mon, 22 Apr 2024 13:49:01 +0000 (UTC)
Message-ID: <9cba6633-b1dc-4cde-b326-609855c6418a@collabora.com>
Date: Mon, 22 Apr 2024 18:49:30 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH v2] selftests: filesystems: add missing stddef header
To: Amer Al Shanawany <amer.shanawany@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Miklos Szeredi <mszeredi@redhat.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <df1df586-188e-4290-9986-7b7cd31710e3@collabora.com>
 <20240422131659.30222-1-amer.shanawany@gmail.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240422131659.30222-1-amer.shanawany@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/22/24 6:16 PM, Amer Al Shanawany wrote:
> fix compiler warning and errors when compiling statmount test.
> 
> gcc 12.3 (Ubuntu 12.3.0-1ubuntu1~22.04)
> 
> statmount_test.c:572:24: warning: implicit declaration of function
> ‘offsetof’ [-Wimplicit-function-declaration]
>   572 | #define str_off(memb) (offsetof(struct statmount, memb) /
> sizeof(uint32_t))
>       |                        ^~~~~~~~
> statmount_test.c:598:51: note: in expansion of macro ‘str_off’
>   598 |         test_statmount_string(STATMOUNT_MNT_ROOT,
> str_off(mnt_root), "mount root");
>       |
> ^~~~~~~
> statmount_test.c:18:1: note: ‘offsetof’ is defined in header
> ‘<stddef.h>’; did you forget to ‘#include <stddef.h>’?
>    17 | #include "../../kselftest.h"
>   +++ |+#include <stddef.h>
> 
> Signed-off-by: Amer Al Shanawany <amer.shanawany@gmail.com>
You missed the reviewed-by tag from previous iteration. Putting it here again:

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
> V1 -> V2 added compiler warning in the patch message
> 
>  tools/testing/selftests/filesystems/statmount/statmount_test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test.c b/tools/testing/selftests/filesystems/statmount/statmount_test.c
> index 3eafd7da58e2..e6d7c4f1c85b 100644
> --- a/tools/testing/selftests/filesystems/statmount/statmount_test.c
> +++ b/tools/testing/selftests/filesystems/statmount/statmount_test.c
> @@ -3,6 +3,7 @@
>  #define _GNU_SOURCE
>  
>  #include <assert.h>
> +#include <stddef.h>
>  #include <stdint.h>
>  #include <sched.h>
>  #include <fcntl.h>

-- 
BR,
Muhammad Usama Anjum

