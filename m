Return-Path: <linux-kselftest+bounces-37906-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB77B0FF68
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 06:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50AE546028
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 04:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB13A1E25ED;
	Thu, 24 Jul 2025 04:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRD13E7I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440AE1DE3A7;
	Thu, 24 Jul 2025 04:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753329965; cv=none; b=FJRnUngPD+yO/FxxsGFQ6ACvPmF7LGFPPuPP5GR9E3o+jra1gk6jb0ldelXp9S3yaDfE94PMR4XxWlh1Q4Ma5KMuC/wtadJv/2sFVCk9bNoFzjkC+mAdHfK5JliFd57xXNPcG1BXWmnYLIE6bvjmnRFukdwLu6fxQR1xJDohoTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753329965; c=relaxed/simple;
	bh=x5xA0MaaSEbZBKZWPkQkkQTppRQotlsF0D8jHMPijYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+EM6dPlmcgOEk+/vhOwHvAyOdaVen6n7nqK5PtPHgt1pTvTnYiPHxw45O8+VX/2mSEoWGwkT5xOgPvWTiz22HVL4GjDGG2S7XpPwZLnJyUn/FVTdHCXL2iqilSkAHfEG6mlgv4MBmpY15gBntliotVFM+CC9Q5u6Njgy1kpDog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRD13E7I; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-749068b9b63so418428b3a.0;
        Wed, 23 Jul 2025 21:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753329963; x=1753934763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lri8a7tErlQJoQJBKzpLSIDuvETVeSPPT3zs+X9fHo0=;
        b=JRD13E7IUCXNJiw1w7TR07R15ogZXdWui49UpcDVpFC1dyuz6sM+EsNebGts3q/aXC
         FNvxfJ/0G7tPg+3bqrF957K7JU/Avg0ZQVh+DRl3t60+KyQG5LJgpABl7I5Iu09svAg0
         8qrXaHNcwUtThxft5HOdmytSlv8gXS5/nXx7Q8wHRb54nL9qrh66v6nE7oMUOIUHhdoq
         K++NKIJN0qHXdOl+8twEmJ5w4eBMvUd2e32pir8Hk7ZVRy08bXWjhGuaAcY9qz8sh5p1
         7uNMT46nyxSb0PS4IAFVS2zOVyrRsDjjgVzO7TlsnH2NBOa60swK43+z6ZCUOpv+f+7b
         xZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753329963; x=1753934763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lri8a7tErlQJoQJBKzpLSIDuvETVeSPPT3zs+X9fHo0=;
        b=hAnKCQ+6yvpFtOnRykyIQgtENMXBeIZtKP5Ta3zy0Ij85CdeYfvQKbOJ+aI9vknmXt
         OJaC0PNCd4CJtscNtDmvx5p4oeTRsSBBRfeesDqUWvItvSxkMcAHg1CqrWxQkjmByafq
         R+MdCAMVZu/vbY6lwl4ZZ+G3NxyLzoi+ZHAQtyBB2WUHE9Xk9RDW0ZLyP+psYpNJgsjE
         Q+PVy55Z8yAORIlMBgyYTLEq1wRLqBO3vOXXzngJ5s70fYjgxal/Q7G3lHJII3dbrWpk
         zyBF3+RAgJtfPgGLM/LAfFhU5QpewUZ5ZSocGUUDJd9nW7pr2ix9V4VLwFZO27QKLZkO
         jWmg==
X-Forwarded-Encrypted: i=1; AJvYcCUWAUVc8UHOLNI8FCmAkr2+EMlwPyIxa/VusYlZlQFapzwqZLdh/30btb9FhYZRk+G7Y0gzTMm1dWeXZG4=@vger.kernel.org, AJvYcCVijS7i9IMJN632KxenvgoaAYksXJQwl4NQY8P14r08SMwuPGXZheKPGbyTdnevzcina6i7o3IDdb5sAYQlbLFi@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo5g7c2Twj506G8uapUsXVna9YmHnWu/qnj44A2tJLLFc49Tbn
	ethcPU87RSTejiIZ8DNaJH6ikczuFAgbbApAX+lPftqBFXxUGMdiMk82HBqmSgM7
X-Gm-Gg: ASbGnctq24p442k0fwSeJMTCbudOCLH3StJ8Zp7ro0GJ0cL93ebMcYnfG/CcuUrVYp8
	UXAiJZSH9fbX+8pNyS146qQb1zOcMlrKOvht52GbsASFHFqBwjN2BV00nX83E7P6z4msVDDKtDX
	PzytA71u9aMrz75wWvv9aokyH89SMQgLFuUOEwuoVDDUIAEBhgI+pXFHA4Wa9fcWEJFcvHlgqxs
	iC4FZIYECakD5W1psZjHEReCtVU4a++8/xH7Pk2LdE5Rs8dfR9pvRKL3AP5DWL8ePhcwtAIcXLy
	yvF7I+/YQFo5nU3seaVXOPBkUcYvPrtjMnK+aaG36GAlTXNzHsKSfTW9BfAEONVe/H8Qm1nUBPR
	BXVFDoC4ehRIgweBPV+vmMj0LyEU=
X-Google-Smtp-Source: AGHT+IGl1cq5I3JdhHh8f4b8zoHXX9aU84Ekk6Zr/uC5jkDpf6pl1wkcEVH8jH9CLgGszhQR8k67FQ==
X-Received: by 2002:a05:6a00:22d1:b0:742:a334:466a with SMTP id d2e1a72fcca58-760357fa4e9mr6968788b3a.12.1753329963433;
        Wed, 23 Jul 2025 21:06:03 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761b04b36dcsm542731b3a.66.2025.07.23.21.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 21:06:02 -0700 (PDT)
Date: Thu, 24 Jul 2025 04:05:55 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] selftests: bonding: add test for passive LACP
 mode
Message-ID: <aIGxI_ctF5RPEph8@fedora>
References: <20250709090344.88242-1-liuhangbin@gmail.com>
 <20250709090344.88242-3-liuhangbin@gmail.com>
 <6d4bbed3-472f-4002-abb9-47edf7743779@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d4bbed3-472f-4002-abb9-47edf7743779@redhat.com>

On Tue, Jul 15, 2025 at 11:37:54AM +0200, Paolo Abeni wrote:
> > diff --git a/tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh b/tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh
> > new file mode 100755
> > index 000000000000..4cf8a5999aaa
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh
> > @@ -0,0 +1,21 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Testing if bond works with lacp_active = off
> > +
> > +lib_dir=$(dirname "$0")
> > +source ${lib_dir}/bond_topo_lacp.sh
> 
> shellcheck is not super happy about 'source' usage:
> 
> In bond_passive_lacp.sh line 7:
> source ${lib_dir}/bond_topo_lacp.sh
> ^-- SC3046 (warning): In POSIX sh, 'source' in place of '.' is undefined.
> ^-- SC3051 (warning): In POSIX sh, 'source' in place of '.' is undefined.
> 
> either switch to '. ' or use bash instead of 'sh'.

Hi Paolo,

I updated the case and remove the source file bond_topo_lacp.sh.
Instead I source the forwarding lib directly like:

lib_dir=$(dirname "$0")
source "$lib_dir"/../../../net/forwarding/lib.sh

But this cause shell check unable to find the lib.sh as $lib_dir is get
dynamically. This usage is common in selftest. How should we resolves this
problem?

Thanks
Hangbin

