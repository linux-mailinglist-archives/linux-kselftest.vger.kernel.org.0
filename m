Return-Path: <linux-kselftest+bounces-31836-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA44A9FECE
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 03:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED70464493
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 01:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB30C153836;
	Tue, 29 Apr 2025 01:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GqMyRMX9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FFA3A8F7
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 01:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745889079; cv=none; b=N8s9mO9uRNWDd8UnaJY+l3oHVNVPrF65GJJmWASEw0B8UNT2CU7oCE/izZzOIProAJG/AOPtUxS0CAvnBqQCSAKbO8IPnBWP4wxzlHnCWCdvEQv9Fd4c4BlGwozWpQkkizj/qOT17dY8KmfulscmsA5McquWyI/fjwyiPVc40cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745889079; c=relaxed/simple;
	bh=zAyh2qq0uxBmwFuyzqMD049uxJkQYcWiqqaLHv5GLyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twu1wEzJKD7gQMSDfnfeSOgvzNwE2wY7WbdMRGoi64Fwd2vh0p73nluta/mqe5fM4iJhoH9u/MqPy43MC0JPYXRZm+dj1ssblqIqLdn9HMoolaHhNdULgDRDoE9NjNkLzFQYWfImWQB8Vzl3UPkcEiWE3cz4NDIghF41+OHyB+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GqMyRMX9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745889077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O+atCu7iB8J4TiSO6knhqI/0GhpG1KCpn/KK3Mg/GIg=;
	b=GqMyRMX9W1dHvx1tEiMLuf+Tp/BbkDXGUOuXjWIK4UIoscBhwPn8hkzYF33ef0AhMr506Z
	X7ped2d7CuEBL7LsjCdzNnXaD5E3zqOZ1MvUIeMZtkChOPLgzfCMoD49k4Bl2i6SjyON+B
	hSeaWLc2NOOhsU6pgZG6A+JEREvg8pE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-STQ1jI0iPKWlWPGJGu08Qg-1; Mon,
 28 Apr 2025 21:11:15 -0400
X-MC-Unique: STQ1jI0iPKWlWPGJGu08Qg-1
X-Mimecast-MFC-AGG-ID: STQ1jI0iPKWlWPGJGu08Qg_1745889074
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3CE231800570;
	Tue, 29 Apr 2025 01:11:14 +0000 (UTC)
Received: from fedora (unknown [10.72.116.57])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E99D1180047F;
	Tue, 29 Apr 2025 01:11:10 +0000 (UTC)
Date: Tue, 29 Apr 2025 09:11:05 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests: ublk: kublk: build with -Werror iff
 CONFIG_WERROR=y
Message-ID: <aBAnKZCUZWyEJhfS@fedora>
References: <20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com>
 <20250428-ublk_selftests-v1-1-5795f7b00cda@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428-ublk_selftests-v1-1-5795f7b00cda@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Apr 28, 2025 at 05:10:20PM -0600, Uday Shankar wrote:
> Compiler warnings can catch bugs at compile time. They can also produce
> annoying false positives. Due to this duality, the kernel provides
> CONFIG_WERROR so that the developer can choose whether or not they want
> compiler warnings to fail the build. Use this same config options to
> control whether or not warnings in building kublk fail its build.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  tools/testing/selftests/ublk/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
> index ec4624a283bce2ebeed80509be6573c1b7a3623d..86474cfe8d03b2df3f8c9bc1a5902701a0f72f58 100644
> --- a/tools/testing/selftests/ublk/Makefile
> +++ b/tools/testing/selftests/ublk/Makefile
> @@ -1,6 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -CFLAGS += -O3 -Wl,-no-as-needed -Wall -I $(top_srcdir)
> +CONFIG = $(top_srcdir)/include/config/auto.conf
> +WERROR = $(if $(shell grep CONFIG_WERROR=y ${CONFIG}),-Werror,)
> +CFLAGS += -O3 -Wl,-no-as-needed -Wall ${WERROR} -I $(top_srcdir)
>  LDLIBS += -lpthread -lm -luring

I think it isn't good to reuse kernel CONFIG_WERROR for test code.

But it can be done in the following way by passing 'WERROR=1' to make
command line:

+ifneq ($(WERROR),0)
+       CFLAGS += -Werror
+endif



Thanks,
Ming


