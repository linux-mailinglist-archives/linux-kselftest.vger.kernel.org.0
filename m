Return-Path: <linux-kselftest+bounces-31960-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE90AA3BAD
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 00:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BEAF1BA48D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 22:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1A0277013;
	Tue, 29 Apr 2025 22:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="B+FClEFX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B16D2749D8
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 22:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745966639; cv=none; b=kL3XrrMPPSg8DQ0kPitBTYalLsM39S5xiKrx7Dqq5Q9Etfl6abouPU//bNwLWP9xwq8TFU0VFfk8m/DHhsKWTCbcbwNWPmYpsshER4HNFcsMmeGP0oOYD1eo1YgNnSxGEKik0bmcMLBpqpCDHiy6DjImLHhCD+p1/6BHD0u7YwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745966639; c=relaxed/simple;
	bh=8krmq6gGLWICnf0RDzJsoQ7XVrbV+7ACHvk9dokG9rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocEMN8/tCHY8WsFcQgNnoOvAH8+mke39JXFqisC2zpn1Hg7Csz5ldlNBU1/H7HC29tNd+yVd72ekf6LrUw0+UrOBcIeHdcvOfv5vz9IoCgx29eaI5u23T7buuF8ffjKB7jGz+MipIw/5Aw1xxXL44GmLtlp9xGuN3kOVeTLI7s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=B+FClEFX; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-70565ccf3bcso69934047b3.0
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 15:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745966637; x=1746571437; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=heVSgyVKUb+FAm8sFJ+MihlxtPVid7pXn+732rMtMEE=;
        b=B+FClEFXj13MZ/uaJ/1kesJVtP2DjvqxSY3YJdVL6sZsj8H60S6lE5WbfdjmSPBrKK
         G+F0uNhYMuruOa8WgFsV6nx8BuIZSHlhndfukzY7NbRYTMEmThMaq7uoePKPcsYqzNTU
         3WTaMaoJZ5A06LoItiViTWxli0ClUyzfQYSm4+c4HZh/tWBNCz6kWWS81J6wbURM2Fsx
         FgfXK91s/t5mo8/MBOHkHLOnhhDNBDJF8InSw3m3luc6KwvoHmT/p/5s7ZM5MMrH6rcl
         R2uIVSW5na7mzOytugz28DVQp7qiLA89n66J1O/hDQ4DbsoCouyN/0pW+2RFRmtjj9GM
         NXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745966637; x=1746571437;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=heVSgyVKUb+FAm8sFJ+MihlxtPVid7pXn+732rMtMEE=;
        b=k91fQaW01UW1WFas5faxmGkpL8HJct00h54bfxgORdTpNZMARM2uFfDY8YKgirUevQ
         RHaWJYU/XCGeZ781hFlepR+rQMuj53dm/zzvAUHK9MDT5aWE+V80ZuhV7GaEjgmoDV0g
         +ALUK6zc9/KCs93ANLi4lQY0sggIMoU5V6zhxMYDrNkDvTFXQZFH/flBiXpP/u0bkCqZ
         WZ9sAA57iq5XMwJBUigH5q/X7RN4bBmqxGz1OQmm1bMvQ8jkxsiEuMfniwJ7DyfTkCCY
         BicglOYsYelx9heZrRBK6KyH4kfAhVi2dmylEClgLSWItY6R6Lt8K5a6R0JMIcxwtoPq
         molg==
X-Forwarded-Encrypted: i=1; AJvYcCWJyplZScV/7XPRUVjV93/D82IoNGHAU7evwO8sdpAbcut55/hQPN7aj9vbNMxCl32CzsH2pi+RGi1rqOpWwGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypac3E9b0rq4lmnAFGtiwsY9WiordsmpPChFF4zgyQkuOjuUmA
	4lP9cTUZfU594oC6Izkn5qDKH+9STXtSApUgSJsu1+TpKYEAuk24r5MFZY5B9jI5kot6+Me9JMY
	UsVTH07FJSaMS6qVcSWT4Ofrcn5xmb96+ACqx7M3OQ0fP4uFr
X-Gm-Gg: ASbGncsMsTbEmKZztKME8ftMHur65EM6W7PfZUzSqIIWKZSNKdvia9wOcpCWb7s+TAB
	NcAa7E7aVy9+H1YZZTQsiRLtxU7iEXMc0k5UTiDKHtTaUuvAPSOyI/6GAqNvMsx//2ZMRmdHz1K
	zsWV+krckPQAtSakeSMMUs+PbNsUdb/XAtrS3ZBDRTBzkyN6+2nH9xwee3B8UFJyKpIPpmNHxqV
	E6FJYbkYnJwIt9cpMqnwDTV+N792ORFC+qMI3QaiUUx3LQr80v5khoBFByMqbWdg66jZvrewy5S
	+1+W+8MhPt5lH/HjeSQWLik4Ga4lVfw=
X-Google-Smtp-Source: AGHT+IEz4rx1/5caK68tQaO9b1jaWJL9Vugr0d/32zWvxjD52I6FEeimg97KRMlrDUksPPYZMyAW7+pUA3Es
X-Received: by 2002:a05:690c:6210:b0:6fb:9495:1650 with SMTP id 00721157ae682-708abd7d841mr21149987b3.11.1745966636991;
        Tue, 29 Apr 2025 15:43:56 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-708ae00cce9sm75537b3.17.2025.04.29.15.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 15:43:56 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 650BE3400C9;
	Tue, 29 Apr 2025 16:43:56 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 59D8AE404E6; Tue, 29 Apr 2025 16:43:56 -0600 (MDT)
Date: Tue, 29 Apr 2025 16:43:56 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests: ublk: kublk: fix include path
Message-ID: <aBFWLGhuRO+Rlzon@dev-ushankar.dev.purestorage.com>
References: <20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com>
 <20250428-ublk_selftests-v1-3-5795f7b00cda@purestorage.com>
 <CADUfDZoKictpMvAgu9FPbHRLVns4HvBgwddsCBgHsH9nhiK4AQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZoKictpMvAgu9FPbHRLVns4HvBgwddsCBgHsH9nhiK4AQ@mail.gmail.com>

On Mon, Apr 28, 2025 at 06:14:18PM -0700, Caleb Sander Mateos wrote:
> On Mon, Apr 28, 2025 at 4:11 PM Uday Shankar <ushankar@purestorage.com> wrote:
> >
> > Building kublk currently fails (with a "could not find linux/ublk_cmd.h"
> > error message) if kernel headers are not installed in a system-global
> > location (i.e. somewhere in the compiler's default include search path).
> > This failure is unnecessary, as make kselftest installs kernel headers
> > in the build tree - kublk's build just isn't looking for them properly.
> > There is an include path in kublk's CFLAGS which is probably intended to
> > find the kernel headers installed in the build tree; fix it so that it
> > can actually find them.
> >
> > This introduces some macro redefinition issues between glibc-provided
> > headers and kernel headers; fix those by eliminating one include in
> > kublk.
> 
> I'm curious what symbol was redefined. struct iovec? Anyways,

The RWF_* flags. Here's an example error:

In file included from /root/linux/tools/testing/selftests/../../../usr/include/linux/io_uring.h:11,
                 from kublk.h:25,
                 from kublk.c:6:
/root/linux/tools/testing/selftests/../../../usr/include/linux/fs.h:318: error: "RWF_HIPRI" redefined [-Werror]
  318 | #define RWF_HIPRI       ((__kernel_rwf_t)0x00000001)
      |
In file included from /usr/include/sys/uio.h:179,
                 from kublk.h:22,
                 from kublk.c:6:
/usr/include/bits/uio-ext.h:45: note: this is the location of the previous definition
   45 | #define RWF_HIPRI       0x00000001 /* High priority request.  */
      |

