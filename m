Return-Path: <linux-kselftest+bounces-31961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DABF4AA3BB2
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 00:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D806C9A31C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 22:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F721FFC5F;
	Tue, 29 Apr 2025 22:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="eEnYViyt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f227.google.com (mail-il1-f227.google.com [209.85.166.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8966C7080E
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 22:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745966779; cv=none; b=Mrhxg08c/a/EHW0pzjQPgzqm8e36DnVML5a/qcr20z+jA3Xx/pdutVpIrJsq2YbhH6T9ecxe6K5yX2zDIlAGW9LoAeOoDH4vsHly7EofWtaGDfgzoLkqZ8EsjOu05ubwS70lvXeAHmtIF3kPLFZbE38BChmM7jmE6XlEPKr7cPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745966779; c=relaxed/simple;
	bh=YQGldYYZN+M+lMKEvXamPZpN40rNMsoWh5qt4/JT0LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYZ/NtidBOfDCt2+fD1DBVJWhgMuu/NFa54/uilZ6g01oSRI59BoAz75cV67CDN3YR2TYiXBnVRQyMgvTKH8AYZYzjseEvDN+LbBP2Qr0ewx9z5A8RkFMso8Rvr6V9+UFXrcLrj4zdkXfEkQDIVezau8PKvU9fkieCBsaR/CN9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=eEnYViyt; arc=none smtp.client-ip=209.85.166.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-il1-f227.google.com with SMTP id e9e14a558f8ab-3cda56e1dffso38271775ab.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 15:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745966776; x=1746571576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCGCCKXBocwMhtCNRTkeUsgiaS7jZ1hs+w86svHkyjs=;
        b=eEnYViytMzkG/tKt//nQPEIKIurRr5yfH+7MFcgmbfjzoaZRjAksLm+vk2PI0yNJ0a
         cpZ+6rWpHJh02LBCjd8HJCDfmIUeipzDmXPar1rLxb0wIgDYFFsltEo8Y1GTFkaZx23n
         /oS0o4vNO1Pf8w2Ouid91DFpI7rE6GO3zLCpUH9YtALvWQeKFYylKLBXpXrAX3w4Z85T
         q8DcY4dx7/N0urlsiQ/MlBXk2oJ94xqa9kiBFTaAtQba7IDfW2N6fU+xMQhlqTdTWwIo
         JedC+UIeBH0944n8c+1f06T2rXdgW8yKQ3LUWOwrZYxXa/nmczxJ5hpNjJ9QW1jIqLa8
         6VaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745966776; x=1746571576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCGCCKXBocwMhtCNRTkeUsgiaS7jZ1hs+w86svHkyjs=;
        b=l2KScQrfCxi+KPRxUQpddZzPctj1cJfVHjf3ZWTbg4qc++/uJKJfydHtvLmegPgJSS
         5k5HvQO9ZXQc18tkOqwo8gjx4AXV+P+r2mnzc73qFqSxhSk9Rt6Bu2mszubDPWFOGW8B
         wuIJd1znXGKWBogZkR18noGKb3Fa4ySgdIY+KTNaSdJ8zsCjnAxakt5yzxIsFqIRCZ5C
         IEkiAinGvXVmpN4H8BI5MNTiHw2WsNb0RRqWWIFKBSWDHBygdED6nnYC8mykneOjdvhI
         Btwb7SYPw8udi8jbuw4TkY6aWWxGBpye1AE5LZMqbnYyRUeVFdzVc9kR/T/D9Ttay+Cb
         Zb2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXj2ZwofkDcjBClQbg1fqkdAWSxg1oUpq7OaDtDLfIfSqVwm5C/Y55/QSxRVy1y+F4Kmhh1cxtjskiAxh+A2yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1lqN/X24fFgYwfBgxxKxI8w7hVkw5M+KXVakVvxZdmcrC4r27
	i/ZNMHRJXj3udPJ8TWzQSoCkzCT2CP8aScxzTWzfqTLdTMT0vmTqWdVFiURKmwBCYzcY0uqkFJj
	QMlKClyD2K5SAUoUr3Ouabx8FCSvRH8B2
X-Gm-Gg: ASbGnctabFB0tGhZyHOk2qhAFHK5McHsU3vK18okt0pVrf/Mk8o4DJR/3xCNhCXUfOJ
	RomVGbHWLi+6haW5ujD+r2jCAgUSxvMZZortnG1/AplRw1HXKgX4kzGWg2ZtNlWX9DSaYg01/Rp
	mZWqGNjbZrEVp7BQ0JW6aodIjqUFZJUXSMYZXwbcrVPH8PqQ0awjnYhnR+w/CQcciesXw4Pk67v
	fa/FfQnPz455V7E4Fe+dbrlToyOgdTldHEfy/oFxILv/0MoAECHKTyrPR4hGxi2rerWblK4ay0q
	J6NPxICGZDHacBGzL640AcQBvhNkta2FRZZ1dYHgt7GaeA==
X-Google-Smtp-Source: AGHT+IE+G/JgBSc4QPhJO/JMssnCs47xAcdzkMDhhI6dkdMavoR9/32QK0KRcpc8my2GqlxfzQ2mMpfpLE2Y
X-Received: by 2002:a05:6e02:b42:b0:3d9:644c:e3b7 with SMTP id e9e14a558f8ab-3d967ffec1dmr3337395ab.15.1745966776636;
        Tue, 29 Apr 2025 15:46:16 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d967d2b553sm155645ab.25.2025.04.29.15.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 15:46:16 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 0BCFD3400C9;
	Tue, 29 Apr 2025 16:46:15 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id A4D78E404E6; Tue, 29 Apr 2025 16:46:14 -0600 (MDT)
Date: Tue, 29 Apr 2025 16:46:14 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests: ublk: kublk: build with -Werror iff
 CONFIG_WERROR=y
Message-ID: <aBFWtvHv84aPTMvi@dev-ushankar.dev.purestorage.com>
References: <20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com>
 <20250428-ublk_selftests-v1-1-5795f7b00cda@purestorage.com>
 <aBAnKZCUZWyEJhfS@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBAnKZCUZWyEJhfS@fedora>

On Tue, Apr 29, 2025 at 09:11:05AM +0800, Ming Lei wrote:
> On Mon, Apr 28, 2025 at 05:10:20PM -0600, Uday Shankar wrote:
> > Compiler warnings can catch bugs at compile time. They can also produce
> > annoying false positives. Due to this duality, the kernel provides
> > CONFIG_WERROR so that the developer can choose whether or not they want
> > compiler warnings to fail the build. Use this same config options to
> > control whether or not warnings in building kublk fail its build.
> > 
> > Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> > ---
> >  tools/testing/selftests/ublk/Makefile | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
> > index ec4624a283bce2ebeed80509be6573c1b7a3623d..86474cfe8d03b2df3f8c9bc1a5902701a0f72f58 100644
> > --- a/tools/testing/selftests/ublk/Makefile
> > +++ b/tools/testing/selftests/ublk/Makefile
> > @@ -1,6 +1,8 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  
> > -CFLAGS += -O3 -Wl,-no-as-needed -Wall -I $(top_srcdir)
> > +CONFIG = $(top_srcdir)/include/config/auto.conf
> > +WERROR = $(if $(shell grep CONFIG_WERROR=y ${CONFIG}),-Werror,)
> > +CFLAGS += -O3 -Wl,-no-as-needed -Wall ${WERROR} -I $(top_srcdir)
> >  LDLIBS += -lpthread -lm -luring
> 
> I think it isn't good to reuse kernel CONFIG_WERROR for test code.
> 
> But it can be done in the following way by passing 'WERROR=1' to make
> command line:
> 
> +ifneq ($(WERROR),0)
> +       CFLAGS += -Werror
> +endif

I've taken this approach in [1]. It actually passes -Werror by default,
but it gives the developer a way to disable it with

make WERROR=0 TARGETS=ublk kselftest

[1] https://lore.kernel.org/linux-block/20250429-ublk_selftests-v2-1-e970b6d9e4f4@purestorage.com/


