Return-Path: <linux-kselftest+bounces-20688-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D529B0BB9
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 19:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E061C2398A
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 17:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6A720D516;
	Fri, 25 Oct 2024 17:35:22 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067A514D718;
	Fri, 25 Oct 2024 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729877722; cv=none; b=J/5pC+eHMU4io0wIkO6BOEhYylQmUTw3nuF/3dy7SHozwrsCuE9VQC7dDGEDo3Qdfxwsof71MdcoqJXUiNpdajeXAai87scFTB54NrLxoZCmRHNUEBzNZfzYrsDVebs7+gkF/dODjQCheol0wmtxDB+IG5e2a7KvqhPYLUWx+ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729877722; c=relaxed/simple;
	bh=cvMkoTD8cXQLBD3BGXtQMYk9yMTwjvOQsqEXdP3Tjog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtZCRq2YY48b+5HE9ErTm+2l7x8tlZsjepCznNH6eAZTpIW2r7LaW/j3CaTLOZ0u1XtqQ91rlqe1etD5t6zWmSr6S0eesQ2kCJZic1va9rcCOpp5bivGJ6G2kkzQsad2Ah+nERIDqFT7+HQH89qb7ffefmsNBBuOmMwhq2SBVQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso275557066b.3;
        Fri, 25 Oct 2024 10:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729877718; x=1730482518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6dZWXC+aHVR5WR816C544Ax/nllzWtB/YhoE1ZA3OM=;
        b=FLH05O95pgMEH5f5IPwjqeszjjbpJVLyG83IdkNZTZ59Zj36RtZZikgBqpEQguzxBu
         qziGEEU7CEsF/2GxKhhsrKs1tTySLlNqfnnXt1xxkH66xIYtKe/M06ylkYVOXmGD/zHI
         LNeeaHdIFEsVo+7cKzj2BKBejqwEEOJIPpZKhPgxmLE4ZwV+d9mOC71VLnENltz55A9Q
         X6foZ6pPzVZNcj7mhIOaGQRxJR4cqpIXXLBxJ/Qg2fmwCSoQSYMUALARjhQ1a/Yx52A0
         U4HIlcj4G+hd4ujQHNtFAVj7cWYspwKrAW51KZWL+FyV2IfJq9nzMMKtpUj+JccWHyvC
         DIww==
X-Forwarded-Encrypted: i=1; AJvYcCV7tjs2bjeiHp0l29jfBRiU7KkvD7bs0tF3ifxI7ocNrPBdL2wJ/SOffePw7qqhQ5ZXrOmwB/e6IqsaF9M=@vger.kernel.org, AJvYcCVVcC8Zg9sHUgepQCO6un6o2yhdHYMwfahj2009osu6nHwdWpw3ntjzEkTWOzSzxYQwB/iYUI9YFisaBXgu8Qk0@vger.kernel.org, AJvYcCWLXF1MPnQQ6EU9A66+v6ze+d1Kwg59yEUJuR3r5caxfO6Nhz9QL/iCM1mYnQ8uhgz+93N9qr/b@vger.kernel.org
X-Gm-Message-State: AOJu0YxFrYPF8cb17pLGgcJREfrB53UpdGijgTvWlLTENvEc7on4cL9O
	qI4pe3GcC90pGp0N3VbqsqG8LV2EOXIPZpCz+wwNIuWaqDXTiAxc
X-Google-Smtp-Source: AGHT+IFWVzqI9r4oRqXptwW5o3H4ULbFC22X/SAmmSV5tCruesmsEBuF8X5vKRI/eLauA/VRdNOuFg==
X-Received: by 2002:a17:907:7e86:b0:a9a:3f9d:62f8 with SMTP id a640c23a62f3a-a9abf867613mr1031180066b.19.1729877718078;
        Fri, 25 Oct 2024 10:35:18 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-114.fbsv.net. [2a03:2880:30ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b3a084ae4sm91730266b.197.2024.10.25.10.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 10:35:17 -0700 (PDT)
Date: Fri, 25 Oct 2024 10:35:13 -0700
From: Breno Leitao <leitao@debian.org>
To: Petr Machata <petrm@nvidia.com>
Cc: kuba@kernel.org, horms@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, matttbe@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	thepacketgeek@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
	vlad.wing@gmail.com, max@kutsevol.com, kernel-team@meta.com,
	aehkn@xenhub.one,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] net: netconsole: selftests: Change the IP
 subnet
Message-ID: <20241025-fiery-caterpillar-of-acceptance-72cf66@leitao>
References: <20241025161415.238215-1-leitao@debian.org>
 <87ed44kt92.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ed44kt92.fsf@nvidia.com>

On Fri, Oct 25, 2024 at 07:01:59PM +0200, Petr Machata wrote:
> 
> Breno Leitao <leitao@debian.org> writes:
> 
> > Use a less populated IP range to run the tests, as suggested by Petr in
> > Link: https://lore.kernel.org/netdev/87ikvukv3s.fsf@nvidia.com/.
> >
> > Suggested-by: Petr Machata <petrm@nvidia.com>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  tools/testing/selftests/drivers/net/netcons_basic.sh | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/drivers/net/netcons_basic.sh b/tools/testing/selftests/drivers/net/netcons_basic.sh
> > index 06021b2059b7..4ad1e216c6b0 100755
> > --- a/tools/testing/selftests/drivers/net/netcons_basic.sh
> > +++ b/tools/testing/selftests/drivers/net/netcons_basic.sh
> > @@ -20,9 +20,9 @@ SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
> >  
> >  # Simple script to test dynamic targets in netconsole
> >  SRCIF="" # to be populated later
> > -SRCIP=192.168.1.1
> > +SRCIP=192.168.2.1
> 
> I mentioned 192.0.2.0/24, which we commonly use in selftests. The range
> is meant for examples and documentation, which is not exactly selftests,
> but feels like it's not bending the rules too far. And we shouldn't see
> the range in the wild.

True, my mistake. I will update it to 192.0.2.1 and 192.0.2.2.

