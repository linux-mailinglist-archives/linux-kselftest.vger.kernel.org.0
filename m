Return-Path: <linux-kselftest+bounces-24986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD25A1A01B
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 09:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F841885748
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 08:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACF720C46A;
	Thu, 23 Jan 2025 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFC9VKgg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F148120C023
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 08:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737621831; cv=none; b=FVtdgaJwJDcuJkGE3W989TXeB3J/H0JU/8bukc+D76VATYlYaJiBPufe0Tyxrwsnj1oFSZKD6vnv47bUipQP0I47JJEEook8WXyVj9oq59NOTd4njq/J2PDJboqWZlnoA7dH3x2VTJIPL4Lk1AP5pRMTGH4VH+kxjWDJrE3Rafk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737621831; c=relaxed/simple;
	bh=ha6b9ok5quAYeRP2tfX+AMmeuXgHarjxTmNfEbxLHVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cvn7WJAdT14jSNWRgcBjpa9pFLAKbWlHZmI6vJyCd8UWwrkDug13Nga/t7D3yVy5u+ZXBfckPOl8KAyVIEkIhjgdXD27WV5IAvrzEarkuinYN1tAVTfWxn9Du6AHfyjUm7YUTNKjAbd0M6ZwYUQ6rpE0BYzCbhMpmc/tBHyHSgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jFC9VKgg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737621829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IpWDV/ai6Ur+w1Blpv0i6Vc7rkxchZcIx8yap87Tpz8=;
	b=jFC9VKggGxMXJZ/XO5bxgLU5g6tb7xLQ4tAl4oF5qU4ARlEz54lWKdURMTJfUrO+sB/XWu
	+h15Rr0zxR/5rMsnEVN76TSYQp5B3Oa0WjDzxm4VKBO5nZln86PMB3ONcm+TUmGV21fgk0
	a2EZOCN+5Ekcptg01B4KPQ3jbwnIBaE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-wTcTAkDZPNaRqzZveMkQbQ-1; Thu, 23 Jan 2025 03:43:47 -0500
X-MC-Unique: wTcTAkDZPNaRqzZveMkQbQ-1
X-Mimecast-MFC-AGG-ID: wTcTAkDZPNaRqzZveMkQbQ
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-216387ddda8so15552165ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 00:43:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737621826; x=1738226626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpWDV/ai6Ur+w1Blpv0i6Vc7rkxchZcIx8yap87Tpz8=;
        b=PNgxTnIibKc46pGG/l4CXrw09Td+Dpd6pdNSMgBe6GH7+PdMqzJI8SV4bz0H4x//wD
         5eFx/FS3KLupl3y43Kt5nDvSyNTk01c6+hP2svdKS68Wq4joJ/1aNpO9dUNA7Bv5+w4U
         JKfUeGWRFqR6bNhitzSfLiiNPlM9UKkjkzTJi1kp8Tk54BMauD5OjJVz4UgsRa/SS4wJ
         hotH7VJTZfYJORxCbfNN0HtoO3es6aAFlwQsLWug+424GF9HR75FuKslK/V8ucR43Oc5
         AIcZiFiXRXzVOJWsjrnfaF6gFuS+xd5iwmjdngSK3wlsHLbPOy7WfPQ+cK6EDb9++SXI
         Jp4w==
X-Forwarded-Encrypted: i=1; AJvYcCUSTBWVlUUQOSkm8nF9JR/Ouwf96UhkovMNtWmi1eOojrBttJNIH6cgZHDw+b0/HaeTw0vsXWGgNpEPXfEdhgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww7Lfbfwj+4Z+RU9UnKtYcegilCAMBTh6BpnK9m/reQ9gvyeNa
	DGrg+AjiDGOgNKUzmqCASsHepPL1eeK5d1OtbdGGWhf7CvmoNVoaejl6dJO/9q8cC1mHhv3lWtF
	qcV8ssjFQckOl8PFqCnX+KAkip449HfPNBCiDMHbMWeg3abSbPbroBD7J/Ai5xGs7
X-Gm-Gg: ASbGncsvWZ3+ZQwj7tm3Z/ChEFPbY8pJyYyQzWE1ABoSXcLV4df0N9xU3q4OCGz5qOQ
	w9KnmVmLbMS/P18z2EYzwc0oglWvHtZOcFjU/lZCh5ZodR+SRBbAwncLLdqF5R0dO6MeL+Zpiv/
	4sUkbNWxEo5eCopT1xUmmjcj/gCTxURFslJrg7gwFk2inT4/ArT4LG9TKBPDk0bTaKbmTghXOC4
	4GLrgrFjar6L38WWEy4ruhsslIBPt1JG13mtG8QMxBFLzC52CVePwVLPnnY7uFNJnEW
X-Received: by 2002:a17:902:f68e:b0:211:fcad:d6ea with SMTP id d9443c01a7336-21c355f040emr334907765ad.45.1737621826287;
        Thu, 23 Jan 2025 00:43:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoFyp8mUveTmi4te0YtMoaGtmQKXDYru3r0i2y43Wp7szaIptDNAzb2cDV4fRUJni9KmOC+Q==
X-Received: by 2002:a17:902:f68e:b0:211:fcad:d6ea with SMTP id d9443c01a7336-21c355f040emr334907475ad.45.1737621825978;
        Thu, 23 Jan 2025 00:43:45 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ceba9a4sm107223715ad.69.2025.01.23.00.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 00:43:45 -0800 (PST)
Date: Thu, 23 Jan 2025 08:43:40 +0000
From: Hangbin Liu <haliu@redhat.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: matttbe@kernel.org, martineau@kernel.org, eliang@kernel.org,
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: mptcp: extend CFLAGS to keep options from
 environment
Message-ID: <Z5IBPOGvfPozjrl5@fedora>
References: <7abc701da9df39c2d6cd15bc3cf9e6cee445cb96.1737621162.git.jstancek@redhat.com>
 <Z5IAU4X1084EFrEd@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5IAU4X1084EFrEd@fedora>

On Thu, Jan 23, 2025 at 08:39:53AM +0000, Hangbin Liu wrote:
> On Thu, Jan 23, 2025 at 09:35:42AM +0100, Jan Stancek wrote:
> > Package build environments like Fedora rpmbuild introduced hardening
> > options (e.g. -pie -Wl,-z,now) by passing a -spec option to CFLAGS
> > and LDFLAGS.
> > 
> > mptcp Makefile currently overrides CFLAGS but not LDFLAGS, which leads
> > to a mismatch and build failure, for example:
> >   make[1]: *** [../../lib.mk:222: tools/testing/selftests/net/mptcp/mptcp_sockopt] Error 1
> >   /usr/bin/ld: /tmp/ccqyMVdb.o: relocation R_X86_64_32 against `.rodata.str1.8' can not be used when making a PIE object; recompile with -fPIE
> >   /usr/bin/ld: failed to set dynamic section sizes: bad value
> >   collect2: error: ld returned 1 exit status
> > 
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> >  tools/testing/selftests/net/mptcp/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
> > index 8e3fc05a5397..9706bc73809f 100644
> > --- a/tools/testing/selftests/net/mptcp/Makefile
> > +++ b/tools/testing/selftests/net/mptcp/Makefile
> > @@ -2,7 +2,7 @@
> >  
> >  top_srcdir = ../../../../..
> >  
> > -CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
> > +CFLAGS +=  -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
> >  
> >  TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
> >  	      simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
> > -- 
> > 2.43.0
> > 
> 
> Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

Hmm, net-next is closed. Not sure if we can target this to net since it fixes
the build errors.

Thanks
Hangbin


