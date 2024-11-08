Return-Path: <linux-kselftest+bounces-21708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA8B9C247E
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 19:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B9E1C27617
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 18:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570881AA1EF;
	Fri,  8 Nov 2024 17:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="jnRzSjqs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B3E1AA1DF
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Nov 2024 17:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731088544; cv=none; b=OXYySBbdjn7/uYnYl8dYdTbHM4HwwWU4Ku9r+eFXZWJtEAYaxtr3MY5YX74SorLXHC0bAD5DK6zY0gn+JfViBZ55CrSRgtE0vArkB4Ve7H7AkxY4hbkhzT9/cGl3/ErD496r8Z1gMvfu3dXnHITnv7v5MlEd2PSzlEMWuXH6dvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731088544; c=relaxed/simple;
	bh=3XEEjpzoyVVjrFa8qZSsaTMnvXE7mOW7qLd0g684tUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dur8kaWsnqrDYujHBdHuu7anQZ69bCvxbIj74nSJ3oUv0qFXxBRpFY06X2sC9VfNLPzSp31YYDqzU06V4XdnuWwNYDAkpPMtvlTy2HlwUdwLKpaigiV2DlQPGpqf+fLab1HKXgltQdT+G397n+QEkssZzA+H9Ve4cxE33fkv9f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=jnRzSjqs; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7240fa50694so1514666b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Nov 2024 09:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731088541; x=1731693341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FiPDLfL5JTBKeeqjpJ5u/XBxPNvTKsH7Pcb34HC2tGE=;
        b=jnRzSjqsfNVaVUDH5de4Ef18Vt94xLUiXdS/G53lVmdsJS4cWE6uBbVzkeU57hav/N
         z+bKKDi4SIKhuj5geSc9ApUMRjgwGvbuy78q8fFfP2nFDk8LX+zOpddLExhxu+uMVEV6
         1RwNdRfVWrgVhZ7e1VW8EKsVQgqdiwZ1Mk59g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731088541; x=1731693341;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FiPDLfL5JTBKeeqjpJ5u/XBxPNvTKsH7Pcb34HC2tGE=;
        b=VRRYtnugRyRbvLYcgGkuOF1kQy/fj41mQpXNa9LOBRw83qWBYdC7224479VjA1xahl
         4CygfGXWh/JBkt+l+HXAtIUmJaUGNWqR1Bz07gLO2zykhVFcLXOFmTsJguzdYBlONi8S
         57vZr6uYl75aFAsS7LpOeK2tfs2Nh3Hw/1zp0kKm3Eds4oSRrKpj8Om11VSWCgz25A/Y
         PmhzUvNZoJBwneWBt3EeI+bGfny22LaARpBxyJlKyTos1pqQovrMOa7p41QimJh5IA6S
         kwxDn0A0SAYSCLOxcY7DzNgbfQ8yF6VMuOigtA96cBrhjqO/4sPzhjNSEC0VCmRIAWAL
         3n7g==
X-Forwarded-Encrypted: i=1; AJvYcCUXhblMk3ai/tc+0xv3Le5fMA156Ib36z8FJ/P84Iisy0rnLSZo5hZkiFSDFyVe7wDXTeyjwgq7SAVxeZorfHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsZTIG2LHF5UWSucvkT0/nxbUe/PmxbpZyxEkM2hq0oRJmBnhy
	gppNxJ0s+ojH8z6Yls+HY49y0U0cUo/1LEttsws5SuyqD0JQwgTIipXj/Q9HboM=
X-Google-Smtp-Source: AGHT+IERbFI+o+2LyayD4punr25StjJoWA4Jj2wzw5p0JjcDTHDRzT1/x7uQhWNXVNPsCLPYIGwlKQ==
X-Received: by 2002:a05:6a20:158c:b0:1db:da5e:361f with SMTP id adf61e73a8af0-1dc22a1b4d3mr5454374637.25.1731088540720;
        Fri, 08 Nov 2024 09:55:40 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7ef5sm4141017b3a.63.2024.11.08.09.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 09:55:40 -0800 (PST)
Date: Fri, 8 Nov 2024 09:55:36 -0800
From: Joe Damato <jdamato@fastly.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, corbet@lwn.net, hdanton@sina.com,
	bagasdotme@gmail.com, pabeni@redhat.com, namangulati@google.com,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
	m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, skhawaja@google.com, kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v8 5/6] selftests: net: Add busy_poll_test
Message-ID: <Zy5QmNT5XqZUJ3f8@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org, corbet@lwn.net, hdanton@sina.com,
	bagasdotme@gmail.com, pabeni@redhat.com, namangulati@google.com,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
	m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, skhawaja@google.com, kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20241108045337.292905-1-jdamato@fastly.com>
 <20241108045337.292905-6-jdamato@fastly.com>
 <672e26ec429be_2a4cd22944c@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <672e26ec429be_2a4cd22944c@willemb.c.googlers.com.notmuch>

On Fri, Nov 08, 2024 at 09:57:48AM -0500, Willem de Bruijn wrote:
> Joe Damato wrote:

[...]

> > diff --git a/tools/testing/selftests/net/busy_poller.c b/tools/testing/selftests/net/busy_poller.c
> > new file mode 100644
> > index 000000000000..8d8aa9e5939a
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/busy_poller.c
> > @@ -0,0 +1,328 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <assert.h>
> > +#include <errno.h>
> > +#include <error.h>
> > +#include <fcntl.h>
> > +#include <inttypes.h>
> > +#include <limits.h>
> > +#include <stdlib.h>
> > +#include <stdio.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +
> > +#include <arpa/inet.h>
> > +#include <netinet/in.h>
> > +
> > +#include <sys/ioctl.h>
> > +#include <sys/epoll.h>
> > +#include <sys/socket.h>
> > +#include <sys/types.h>
> > +
> > +#include <linux/netlink.h>
> > +#include <linux/genetlink.h>
> > +#include "netdev-user.h"
> > +#include <ynl.h>
> > +
> > +/* if the headers haven't been updated, we need to define some things */
> 
> This should not be needed, as headers are taken from $KERNELSRC/usr after
> make headers_install.
> 
> Generally discouraged for tests (else every new feature test for a new
> features is forced to adds such checks).

I get that, but the reason this is required is complex:

- sys/epoll.h defines epoll_data, which is needed by the program to
  access stuff like epoll_event.data.fd and linux/eventpoll.h does
  not. At the same time, older glibcs do not have the ioctl yet
  (I've sent a change to glibc to add it; I don't know which release
  it'll be in or when CI will be updated to a distro with that
  glibc).

- linux/eventpoll.h does not define epoll_event's data field, it's
  simply an opaque "__u64 data", but does include the ioctl
  definitions.

So, it'd seem I'd need parts of both headers... but of course you
can't include both, because they redefine types found in the other.

Maybe there's a solution I'm missing (please let me know), but it
seems that the only workable solution is to include the #ifdef blob
below, but perhaps with a comment explaining the above.

> > +#if !defined(EPOLL_IOC_TYPE)
> > +struct epoll_params {
> > +	uint32_t busy_poll_usecs;
> > +	uint16_t busy_poll_budget;
> > +	uint8_t prefer_busy_poll;
> > +
> > +	/* pad the struct to a multiple of 64bits */
> > +	uint8_t __pad;
> > +};
> > +
> > +#define EPOLL_IOC_TYPE 0x8A
> > +#define EPIOCSPARAMS _IOW(EPOLL_IOC_TYPE, 0x01, struct epoll_params)
> > +#define EPIOCGPARAMS _IOR(EPOLL_IOC_TYPE, 0x02, struct epoll_params)
> > +#endif


