Return-Path: <linux-kselftest+bounces-29108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44864A61FFF
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 23:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5211891981
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 22:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3480A2040A8;
	Fri, 14 Mar 2025 22:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="aQfli72h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8C01EEA33;
	Fri, 14 Mar 2025 22:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741990433; cv=none; b=QaXHCb+JKgXHXGWRt43sY0XJDb+YN7LIs6WBLp1FiD2JFt7PI9h4ULWVtu9HJv/x2fhe5b9MYK/DONXGyQyA2Qfp5lhxayeDpp8kcCSvvQ12zPtY+AJblSOXWnBqkpk6LvYBmn32R6fGXTGhhjm3zOTF+8TyoimgcYacuaQ6loY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741990433; c=relaxed/simple;
	bh=PBu9kAsuFjPg5gh3ZG1A0j9rBrzy+ElTCMUQl40ZZ4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pIPerhFdZ+ELIn2QonoKE9+lTdSMxa9z5wJT4ooATTA1Gmx69c5bzNduMr9HTrFyLW/DL9/RjhT4pD/UVXh7oq4CPo7PmTTVVI7lmiZ0rPxq6zb+NfMXbmCSxXsJHLtpt5B1wun292cP+T7sAFKg2rYXMVoSQvWjvv7lgn+OaT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=aQfli72h; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YtO3ydFF2YS4VBgQeiivrPABYB+WJMUv+n9ic38OOtk=; b=aQfli72hShZVf4mextJV1fGZb0
	E2j0g2q1X8vEhp5HvhdBtLFHQ+wIBl6XgOISchW5RWvXjhSmMbExGt6UT326xHeuzABMxuhA0CSyw
	yPJUfT7fe5tb5RRJASWNpKS67NX980K2f/8JUUFO/h3DzsYw/Mb7WLXObOVT0ayCuer/uk0TZrXUo
	SzkI3N2iw17UXCZYKRYCP5vP61+iZOs+jNEZNp/3aOtgzOey1l1I9JLL4sq3fOzB6tcy1I5enumIg
	R93/Vp4L4hzZzmWY+yn+OBkEPpCRn4fqKrnSqe0TVFYQYzmzM6b+Obo2OZUGX63YyvKfmDPupCXQq
	FacMgxxA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1ttDGb-00EMsh-2e;
	Fri, 14 Mar 2025 17:12:34 -0500
From: Elizabeth Figura <zfigura@codeweavers.com>
To: shuah@kernel.org, Su Hui <suhui@nfschina.com>
Cc: Su Hui <suhui@nfschina.com>, wine-devel@winehq.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject:
 Re: [PATCH 1/4] selftests: ntsync: fix the wrong condition in wake_all
Date: Fri, 14 Mar 2025 17:12:34 -0500
Message-ID: <3661803.LM0AJKV5NW@camazotz>
In-Reply-To: <20250314071454.201697-2-suhui@nfschina.com>
References: <20250314071454.201697-2-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 14 March 2025 02:14:51 CDT Su Hui wrote:
> When  'manual=false' and  'signaled=true', then expected value when using
> NTSYNC_IOC_CREATE_EVENT should be greater than zero. Fix this typo error.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  tools/testing/selftests/drivers/ntsync/ntsync.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
> index 3aad311574c4..bfb6fad653d0 100644
> --- a/tools/testing/selftests/drivers/ntsync/ntsync.c
> +++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
> @@ -968,7 +968,7 @@ TEST(wake_all)
>  	auto_event_args.manual = false;
>  	auto_event_args.signaled = true;
>  	objs[3] = ioctl(fd, NTSYNC_IOC_CREATE_EVENT, &auto_event_args);
> -	EXPECT_EQ(0, objs[3]);
> +	EXPECT_LE(0, objs[3]);
>  
>  	wait_args.timeout = get_abs_timeout(1000);
>  	wait_args.objs = (uintptr_t)objs;
> 

Reviewed-by: Elizabeth Figura <zfigura@codeweavers.com>




