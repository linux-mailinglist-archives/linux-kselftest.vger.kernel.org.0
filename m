Return-Path: <linux-kselftest+bounces-615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C21CF7F9256
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Nov 2023 11:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EBA9B20C7B
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Nov 2023 10:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C3246AD;
	Sun, 26 Nov 2023 10:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="aBeplL6L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0AFF0;
	Sun, 26 Nov 2023 02:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1700995335;
	bh=iRTUO3vfIzyLX0GLcSUGSZRdAVle/RaLLeXGHGJpkC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aBeplL6Lpuuq3AICfV5wIEh9GkhhyNYyIlelnIen7Z3K2zFt77PoP51P4xfUKQGcu
	 xZFEt50E62LaNGbXBF5p7Q6YKSVMe+L1/bp+jM8aUqmgc2AzYXVB5g64Y5MbQwWPTc
	 yeRhW2narcLU9HEbkDR1cbh5/QSaAdhd+a6s6gNM=
Date: Sun, 26 Nov 2023 11:42:15 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/3] tools/nolibc: add support for getrlimit/setrlimit
Message-ID: <63a86460-23a8-4e5a-a34d-d1825c85b5a0@t-8ch.de>
References: <20231123-nolibc-rlimit-v1-0-a428b131de2a@weissschuh.net>
 <20231123-nolibc-rlimit-v1-2-a428b131de2a@weissschuh.net>
 <20231126092828.GB7407@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126092828.GB7407@1wt.eu>

On 2023-11-26 10:28:28+0100, Willy Tarreau wrote:
> Hi Thomas,
> 
> > +int test_rlimit(void)
> > +{
> > +	struct rlimit rlim = {
> > +		.rlim_cur = 1 << 20,
> > +		.rlim_max = 1 << 20,
> > +	};
> > +	int ret;
> > +
> > +	ret = setrlimit(RLIMIT_CORE, &rlim);
> > +	if (ret)
> > +		return -1;
> > +
> > +	rlim.rlim_cur = 0;
> > +	rlim.rlim_max = 0;
> > +
> > +	ret = getrlimit(RLIMIT_CORE, &rlim);
> > +	if (ret)
> > +		return -1;
> > +
> > +	if (rlim.rlim_cur != 1 << 20)
> > +		return -1;
> > +	if (rlim.rlim_max != 1 << 20)
> > +		return -1;
> 
> I think you should used two different values here for cur and max so
> that you can also detect stupid API bugs such as a union being used
> instead of a struct, or copy-pastes in the implementation etc. For
> example using 1<<20 and 1<<21 should do the trick.

Good point, I incorporated the suggestion.

> Otherwise Ack-by me for the whole series, of course.

Thanks!

FYI I retested and pushed the series.


Thomas

