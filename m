Return-Path: <linux-kselftest+bounces-37988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E855B11F23
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 15:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88058586DA4
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 13:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4C523F405;
	Fri, 25 Jul 2025 13:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8EZ5tKd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388462405F9;
	Fri, 25 Jul 2025 13:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753448575; cv=none; b=hTpmSxMT18yI4XBFYIxELHmF4OKrRF+wPcFDEE+qXvbheU5izERlSbCT2uMIqMcypSAEBOhfJKDAxlwOTgiiKHvioPj6Mv+PzwdLLQfMYhuhdYmuSM5VX4TCwePr+oHZrb0yxwGvq7oTzOm8VYQCchBP57t+Lwy1nqIr9S/6XlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753448575; c=relaxed/simple;
	bh=pnQvmNBIWePPKU4vyT0ztIsbhKrl6w5UhNYkRPp35is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/dPT25ugHGTyomKG86+wZ/hhYP4CCNLpH8VC3AKuto6UFYeYRGBpckv0ipEsuJOWfEUiWLX4mN1mvfD9uymI4AJjk9G5sDvnCsk13a2rk6I8Qu1E+r2b4/0J5Fm+FO+2A6wWuCJgAyNDmW26wdGCIID3qirWbTDXAh5CKtJokQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8EZ5tKd; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-236192f8770so14744005ad.0;
        Fri, 25 Jul 2025 06:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753448573; x=1754053373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rvnuCWC++P2rSLplAPzOWf1/FSno9Iwm1i2Ll6MyWVQ=;
        b=Z8EZ5tKd1/UkHx2SzsGlfgZasnGc81ZZxUc/+84O+/AnYcY8kg7P83PeV+LFUf8skg
         uel7l+5p0AJekgkuks4hXegy4pBluMuw+UTQ1tKstuyuTOMZnX4vII+VX+jwwCEzNI4U
         Pt5fyvAEP0dRa+E5MFWYm9f/unM/hvlNKxLFQiiD4exoCgwbvirFjYUKUsqJ5D3gY/aW
         yAvE1wWBU4ZplqDPGa8aXyk+0P37Mdcg22wZIAutPskwB8IcNS08jo6MSq6/JqniKZUw
         WRrFM+e70ACQ8uIS0SggKkeV9HffCaopYitSqncPMFJVXPfZbQHsxOtGVkkXXkA5oi3s
         bh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753448573; x=1754053373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvnuCWC++P2rSLplAPzOWf1/FSno9Iwm1i2Ll6MyWVQ=;
        b=wYXJY7PRoGOdHWAbLQ/7WMoHEepHAdPFh5Ew4n0DXeH8A/hrPsyORhBU+IrfM+FW2p
         X4qb355FbCbQLWvCmFQBRE/iPLExPpwq9xiaRFau/xr9Gi4ATVbaTciEo3d7pduZVwzC
         5C/7bfTYzFR3Gk3tfs34bVIK0dFO92Z6W74Ap6BO3KwyWIN3SfT7NFGxlcgB+7pXo4JB
         O7+cSGZZJquic/+dme4TSw13Sg4sY0RqRkBYRgdRJHtBXw8K09FWtS9u30Ju7JmY8wGR
         9gQilDzbejdDIuZSrnJk9wnxKCmpSMH9Hpcm5DXDN0vzcFqukBjdltXhIzarFjFgQxdy
         M9bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdiJ3a2NzU3h2Y7Mfyeo7zxf5OAHkfIHEiJEAxDS4H4fTBS8PWxqo6bwB6YuwOphK0RX+qR/JwNyU4DBjEwOzm@vger.kernel.org, AJvYcCVzwd4rTPdLUGJonf/oqjW1LmD7TAvGfpaj1iBu6K8C4O8diorquicTvds4blPerE73xHurPZttk+smRjU=@vger.kernel.org, AJvYcCX03X6daJFgs7rWdApAkn2tc+PdCVmAr2/IXvoDEmdzD1mOpU9DyP4rVkmVgsCeQcUQ5K/BFdsL@vger.kernel.org
X-Gm-Message-State: AOJu0YxwvofykOxzJhBZX0K/llQk58x2sVQSGi6dVw9Xcy3A1N87Xu1W
	ceGRIBJuOrfqD0+YW3C9xO/z2Of+TfnhIfABzCJDDxH4KWhPKnw0qGNxPviDn17ahZc=
X-Gm-Gg: ASbGncu7c0oGycCNpP358+NxsLnCjF59T+ftqnk/7nyFaofQLCEL7RNOsGN+4oEsSfh
	l+AOLymHLhPToCpkt+nGoLgo+OJ8910a8erT6NYYY+XsHd7vHOjdodOAMC6LKNsX4mYkOmwOk5b
	X6Ytxb0jmA2Y21m+axtvrCtpQWfEyAqPWWWX0hoMYSM2RZm0SMiljSt8+aF4oQseKMpmVzfvQFP
	0z6IY7bySCTiJoFhjJMslRJjmTESwUysuG2SmhYFRJr68nti4a+KfGESlTZ/iU25OHpUjgKMq+W
	JJKoDclDRmqu0kkBg6hztuCtIlbQs9abdZhL3E2RcD1Gnvc3zYX2/xXepEUeIAwkP4anQL9x5b3
	3YuQ36ZPuwwQLjuZ3mSwIMp7EpxA=
X-Google-Smtp-Source: AGHT+IEwVtEPJ4Wk23wiO0WMIjQ0EiztpjidWUR6uUpP9DUtmExgj76cb72uWpB+tJ+lclx10mlBKg==
X-Received: by 2002:a17:903:2b0f:b0:235:e94b:62dd with SMTP id d9443c01a7336-23fa5d7420emr90326485ad.12.1753448573239;
        Fri, 25 Jul 2025 06:02:53 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa476ea42sm36966305ad.67.2025.07.25.06.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 06:02:52 -0700 (PDT)
Date: Fri, 25 Jul 2025 12:53:10 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Petr Machata <petrm@nvidia.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] selftests: bonding: add test for passive LACP
 mode
Message-ID: <aIN-Nv_w0N6jdSsD@fedora>
References: <20250709090344.88242-1-liuhangbin@gmail.com>
 <20250709090344.88242-3-liuhangbin@gmail.com>
 <6d4bbed3-472f-4002-abb9-47edf7743779@redhat.com>
 <aIGxI_ctF5RPEph8@fedora>
 <aIGykkgqktjgLvVI@fedora>
 <87ikjgd5yq.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ikjgd5yq.fsf@nvidia.com>

On Fri, Jul 25, 2025 at 10:27:48AM +0200, Petr Machata wrote:
> 
> Hangbin Liu <liuhangbin@gmail.com> writes:
> 
> > On Thu, Jul 24, 2025 at 04:06:03AM +0000, Hangbin Liu wrote:
> >> On Tue, Jul 15, 2025 at 11:37:54AM +0200, Paolo Abeni wrote:
> >> > > diff --git a/tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh
> >> > > b/tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh
> >> > > new file mode 100755
> >> > > index 000000000000..4cf8a5999aaa
> >> > > --- /dev/null
> >> > > +++ b/tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh
> >> > > @@ -0,0 +1,21 @@
> >> > > +#!/bin/sh
> >> > > +# SPDX-License-Identifier: GPL-2.0
> >> > > +#
> >> > > +# Testing if bond works with lacp_active = off
> >> > > +
> >> > > +lib_dir=$(dirname "$0")
> >> > > +source ${lib_dir}/bond_topo_lacp.sh
> >> > 
> >> > shellcheck is not super happy about 'source' usage:
> >> > 
> >> > In bond_passive_lacp.sh line 7:
> >> > source ${lib_dir}/bond_topo_lacp.sh
> >> > ^-- SC3046 (warning): In POSIX sh, 'source' in place of '.' is undefined.
> >> > ^-- SC3051 (warning): In POSIX sh, 'source' in place of '.' is undefined.
> >> > 
> >> > either switch to '. ' or use bash instead of 'sh'.
> >> 
> >> Hi Paolo,
> >> 
> >> I updated the case and remove the source file bond_topo_lacp.sh.
> >> Instead I source the forwarding lib directly like:
> >> 
> >> lib_dir=$(dirname "$0")
> >> source "$lib_dir"/../../../net/forwarding/lib.sh
> >> 
> >> But this cause shell check unable to find the lib.sh as $lib_dir is get
> >> dynamically. This usage is common in selftest. How should we resolves this
> >> problem?
> >
> > OK, I just disabled this warning.
> >
> > # shellcheck disable=SC1091
> 
> I believe the point was only about using "." instead of "source". The
> following should have fixed it:
> 
> . ${lib_dir}/bond_topo_lacp.sh
> 
> ... or just use bash as the interpreter, I suspect lib.sh is not
> actually POSIX clean.

Thanks Petr, I know Paolo means to use "." to fix this. The issue is that
I changed the script to source forwarding lib. And shell check could only
analyse static path. Unless use -x to supply the real source path. But I guess
the CI can't do this. So I disabled the SC1091 checking as a workaround.

Regards
Hangbin

