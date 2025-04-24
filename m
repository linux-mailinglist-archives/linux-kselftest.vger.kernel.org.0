Return-Path: <linux-kselftest+bounces-31468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E197A99C83
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 02:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69AE93BAA83
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 00:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC5F80B;
	Thu, 24 Apr 2025 00:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNR6nOza"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8848D632
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 00:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745453308; cv=none; b=f8VLmNpe6JrBjuM5WmCWIKFPQAPkj+YoMBwzMmPySV0eK6TkUnoRofYCpMVMuwQUMhLWWv06WoIehstUAhTTjrp2xmvf9I0MZQJsdRsrxzvomARTQeKYbs2AszDD7/UCUDpyCZet9BZ6tXiAISOSDTC3Mkcw9C8ioX1jP3UCI3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745453308; c=relaxed/simple;
	bh=pntiiw4yG1RuPMTSRoxZvtxa1aWvBAbMHKY3Z9snog4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ec+N0GBmzU+fCIxeN4/YVLFIxsxJ6Y5BeeTN8mJNW+cvZsIjmwM7oDLG9BBLb0NnRZKsJlT4JapEvsAWdF2+XNrnXEGPZtRRcWppJqmlQH0A+gMMHzN1ZBiS+sRT1KpQFy987VSTIZnplKchyU2+FisLEHcarHX0Fa/X+e1l8rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GNR6nOza; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745453305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dOkTAG7rDCrI4h+SXECSRWbl/N8iWgru3VS8SSYRxFA=;
	b=GNR6nOzaYBfP+zqp7kBeX9BrrS15zqMFH0KsqwxdspariDfd8EHHjQk0FwkI8P0hNCswiB
	0vtS/MTbEckkoTAMdmqnkQAAhkPCpyWD9o87izID9rvrH9y/vPugFJvXG/FlM2wsW9/6BA
	2TJISJeHn0NlHl54uFFnZXPucg2SLgw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-QGbGuUtGO0a0ny6jxi4-Qg-1; Wed,
 23 Apr 2025 20:08:21 -0400
X-MC-Unique: QGbGuUtGO0a0ny6jxi4-Qg-1
X-Mimecast-MFC-AGG-ID: QGbGuUtGO0a0ny6jxi4-Qg_1745453300
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99E2519560BB;
	Thu, 24 Apr 2025 00:08:20 +0000 (UTC)
Received: from fedora (unknown [10.72.116.12])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C46DC195608D;
	Thu, 24 Apr 2025 00:08:16 +0000 (UTC)
Date: Thu, 24 Apr 2025 08:08:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests: ublk: kublk: build with -Werror
Message-ID: <aAmA6kjGb8ZVJgTJ@fedora>
References: <20250423-ublk_selftests-v1-0-7d060e260e76@purestorage.com>
 <20250423-ublk_selftests-v1-1-7d060e260e76@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423-ublk_selftests-v1-1-7d060e260e76@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Apr 23, 2025 at 03:29:02PM -0600, Uday Shankar wrote:
> Heeding compiler warnings is generally a good idea, and is easy to do
> for kublk since there is not much source code. Turn warnings into errors
> so that anyone making changes is forced to heed them.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  tools/testing/selftests/ublk/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
> index ec4624a283bce2ebeed80509be6573c1b7a3623d..57e580253a68bc497b4292d07ab94d21f4feafdd 100644
> --- a/tools/testing/selftests/ublk/Makefile
> +++ b/tools/testing/selftests/ublk/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -CFLAGS += -O3 -Wl,-no-as-needed -Wall -I $(top_srcdir)
> +CFLAGS += -O3 -Wl,-no-as-needed -Wall -Werror -I $(top_srcdir)
>  LDLIBS += -lpthread -lm -luring

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


