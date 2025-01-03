Return-Path: <linux-kselftest+bounces-23861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4ABA008E6
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 12:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AA0216163C
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 11:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644921F9F7E;
	Fri,  3 Jan 2025 11:49:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C821F9F5A;
	Fri,  3 Jan 2025 11:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735904945; cv=none; b=bGQ+zbJYNKktP8oirDCHMVgKgorw8TzbEevdUSVeLEz0Zzbx068iaXj2Xfb0gTmxKESlJT3IzF7eOLVp3EeH0+8e5TOLE2ndS+0FHrHYXgPs9hjrHVuycQkdITbaRe/yrsm8GWjEp/D+czkMd12K2tawmtJhzr3fYqmNXCtu2H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735904945; c=relaxed/simple;
	bh=qdKLzzN9ioQ5N2h/vnZ4pwmIKkw2/GRKmEOFzfiMBAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFzj2zMe6ixCyDl8U+llLrpsJRdmja5ttSZX2762TZnLqSMd3hzqW8PQp5FcFMVODyJZcAJKzhVQguO04EMCEEyZiIxwShhzjFSXS80zNyxLpPM0tRJVU0hlEPNzNvOan4rFJnGOsiZw42CGr6BhZQXV3m4B/vYp5aP6cYmUg5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3e8f64d5dso21578229a12.3;
        Fri, 03 Jan 2025 03:49:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735904941; x=1736509741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YaWYvxBpsXsNhIH8IAB9JAPH+eN4WXohxKH5ZEtc0U=;
        b=kku0CCTwcn+HxCZSCs7RIrF5KKAIEUeaLmmt35tm0s0lTCmspl5ynnXOITzhCLmHRa
         to2RBseHvUskHbYSAvwMVdJsWyxvLfupdOV10wD0jbV9JbqaAW68noqz3NgPC7p9GnvV
         pJU+aWTHw+y5tpislSHz9cQz/O++AQq6cH1qDhkS0n0+rJgu4dPjmy1xyey1Xl0WOV5A
         P1rHN5tRopXaQ3+JqMumAUWlsS8+6TzFeZ7p01lTODoGrKPG7qtIknfp4VGzxfgSFK/5
         fHD1ndV6jNf8Ak+obBo3FP9fvduVPZAlQwBwd6cZdBFz4h7PUeg1Tn46uiE4/8fw6PvC
         dCrA==
X-Forwarded-Encrypted: i=1; AJvYcCUK+7/xobaBsglZR9DnYy5N3JwNWkkSxaXEFY4M//HQqIMXysjraEYws3i5+8p+hqBaU3FL2FFh@vger.kernel.org, AJvYcCVS3zXBm7H3qAlPh17kzIv5ZMqCjI8wICmrZQO+Unj/eXmbUptXKE3H3Oq2Oq75dwN9SNqisTNYCNE8ov3izd8b@vger.kernel.org, AJvYcCWiqfYFck95mdDt9DaRMGc4MXVZvPoBYAlYKO0JmSeWxhukBi6JcyQDvub1H2eh8GzxnXqr93iwDt8j05A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8i3892yU/6zfZFQ6yPhSLoWEdRWmfZJfIWSeqcpSFmED10U1Y
	LCNRs4xD2BuhC3BnFHOiGmRAQ+CHu0ANHOVnDJn7CKVuWjxwOlbVkK6UXg==
X-Gm-Gg: ASbGncshF0WHxWnmXclTDmsL/tseau9Ig/xyvICVXSnwVfjW/NIRFGxNVte3zIe0bpX
	IRBfxJ4z0HRok0w14Jgv/qTj4mXS2NSDiLW7lIFZnaQus6Fad+GtdPsHY+jXVAcAYrZ0SqZ9wXd
	1XUDvwGY9yxGPFTQthNLgLNeGB0UMuLA5AHbVwNulhVsOn1HN/tJsK1PUVAvH51Ld94070d6gKx
	7ZYewhxjSNTQPPRNXCRBuaFOqc0BrOuEKp3jVcEgwjyJ7A=
X-Google-Smtp-Source: AGHT+IG8dyh+fMmnd099ZNG8MVYlMrVkV3zDjyjs9qDpBWBxnNaUibtLJ5EieJfUJy/JKSgZW7EMdA==
X-Received: by 2002:a05:6402:254d:b0:5d0:c67e:e263 with SMTP id 4fb4d7f45d1cf-5d81ddf3bcamr41809011a12.8.1735904941111;
        Fri, 03 Jan 2025 03:49:01 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80675a49fsm19263147a12.15.2025.01.03.03.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 03:49:00 -0800 (PST)
Date: Fri, 3 Jan 2025 03:48:58 -0800
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] netconsole: selftest: verify userdata entry
 limit
Message-ID: <20250103-careful-silent-cuckoo-e4fbba@leitao>
References: <20241204-netcons_overflow_test-v1-0-a85a8d0ace21@debian.org>
 <20241204-netcons_overflow_test-v1-4-a85a8d0ace21@debian.org>
 <20241206150918.GU2581@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206150918.GU2581@kernel.org>

Hello Simon,

On Fri, Dec 06, 2024 at 03:09:18PM +0000, Simon Horman wrote:
> On Wed, Dec 04, 2024 at 08:40:45AM -0800, Breno Leitao wrote:
> > Add a new selftest for netconsole that tests the userdata entry limit
> > functionality. The test performs two key verifications:
> > 
> > 1. Create MAX_USERDATA_ITEMS (16) userdata entries successfully
> > 2. Confirm that attempting to create an additional userdata entry fails
> > 
> > The selftest script uses the netcons library and checks the behavior
> > by attempting to create entries beyond the maximum allowed limit.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  MAINTAINERS                                        |  2 +-
> >  .../selftests/drivers/net/netcons_overflow.sh      | 67 ++++++++++++++++++++++
> >  2 files changed, 68 insertions(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8af5c9a28e68c4b6a785e2e6b82db20b3cf59822..62192db4641a4056d1eab911f5c141fb37eaed36 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16092,7 +16092,7 @@ S:	Maintained
> >  F:	Documentation/networking/netconsole.rst
> >  F:	drivers/net/netconsole.c
> >  F:	tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
> > -F:	tools/testing/selftests/drivers/net/netcons_basic.sh
> > +F:	tools/testing/selftests/drivers/net/netcons\*
> >  
> >  NETDEVSIM
> >  M:	Jakub Kicinski <kuba@kernel.org>
> > diff --git a/tools/testing/selftests/drivers/net/netcons_overflow.sh b/tools/testing/selftests/drivers/net/netcons_overflow.sh
> 
> Nit: I think you need to add netcons_overflow.sh to
>      tools/testing/selftests/drivers/net/Makefile

Good catch. I will fix it and send a v2.

Thanks for the review,
--breno

