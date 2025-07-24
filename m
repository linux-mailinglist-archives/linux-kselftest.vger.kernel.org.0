Return-Path: <linux-kselftest+bounces-37907-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A82BB0FF77
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 06:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60473583727
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 04:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F7D1EF09D;
	Thu, 24 Jul 2025 04:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ik3yM+nT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A045B1E9B35;
	Thu, 24 Jul 2025 04:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753330332; cv=none; b=DxoMqOKFPYBqybPZtT2+IhBuJ5twMi2GlAf0J5dfZ+rhmtDzx+fvzw+uqaEG8euw8o46Exq0IAQVUo2TcZM9tc1+iFV5sPe50SxTwdZCxb0a7WsweMBzMol4lQqDf9tMlET62aSMalx7NqzDUBk+Ab9FNQYZROQzAnOXw6M9Lrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753330332; c=relaxed/simple;
	bh=6VKMCH1Us1nM0K8CvkNqJ0TvwrTEUGLCkVM0LrzAHjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZv+L1jI5IuAfqklz3KpEUIN0wpGToWKBD6zCfQFGW10kCChE7lHCf0BUec30bJRfZoZnewRgf91p2UdIFy96ME7mTV0S6eHPfeuafx3yBoYQXPXONWwXVBpOpovg3fOp0DIad792jBuDTzjyzwfbIISmUEagCc+42pCin9Qhjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ik3yM+nT; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3134c67a173so528432a91.1;
        Wed, 23 Jul 2025 21:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753330330; x=1753935130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oWtqDkyX9ikR9LR827V7SFbtjO4Wh2UCgplUtKgRB6E=;
        b=Ik3yM+nTTxyJPFgIcYo80PXEPzA1aPLRha0Y3mfRQz+tRFLtIvjUWvH72rEPdUebkV
         Q7GCECiy3EBjp00c125XrM0sdh9UZMBNp70vHvJAbjAeXjRCbI6TFtfj1nTpwM0OheOm
         WBffF7LKHw86xYPQ57ncIONLL585BkPxxIpAOkgOaOF5up38mg0EVgFk3TwaHClGOlUk
         1VMD8DODWUvypxWcFlZgGJYGd+8j1aPMy+WpKEg9qGbdAf8/cjWeaLyKgjhn5VZokxgH
         HrrzeKm68+fMjdq21Wdwv4sGSj8y0mfPBOOQ7+xfjMVq0iQ+B/CQoYJ++h96xQ+b7FpX
         pthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753330330; x=1753935130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWtqDkyX9ikR9LR827V7SFbtjO4Wh2UCgplUtKgRB6E=;
        b=vBY2oU0EqMh7m+SXHAIL6fl4iE9VfRs5z1UClIHDGxbMPlNEXzdnYzKQ+05VYJ7vZO
         VDUr5EaIwc39gI4yTcs6p2Y46/ygAdMMW3KIM1+mPRBsV2NZULtf0XmRxOiLhX5xknRx
         J4SGsVIwsEpQ5WSXY58lRzCVDQxR3QXP1nspVF8BcNkZkKMQceo8QoRqi88mNSIhvKHZ
         T5QG9xm5j+cN5Vieicilfe2zp/V2EtUUO4EbDZGc8MzxauL3iQ4nrpmvI96TavwG6a5L
         eKPP9VwH7p26QvBYW8yraSvnWi+PBVACRgeqL57zEeuz/F6EpupMAznpzIL5bak/BEg1
         XcMw==
X-Forwarded-Encrypted: i=1; AJvYcCUeQkBx0EOuiCWvTVUuRjhSAP313OZ/jDHlbbw4+dP+bAhE82Kch2THQVE8/Pw994oYissJ7YfHsXo8jFkmqv6s@vger.kernel.org, AJvYcCXphLPY9KEoGE9KWer9Sf+uH3A9IzFT8q6phUSooDY7rC9QLuq0lhuqSAvCzx4qKKZhjbpULbjcpBI0rbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWL8OfWnYQPFe99b5E3M6Ls/3c6OlmbEexM/po2PjY/sv2BvIu
	dRy8iysQIKHc6Un5zGAAFg+3+49T3I4uOVZBY65k4djrUzYHHEF4OqyP
X-Gm-Gg: ASbGncuExrfAIK46cLXu5o1SAaGIW9Rzea8kTD9EkbpFlFgDpC5AhKTCsE1aIslEYLr
	d2PWVPp0yGKotR9L3ttbrgOcII3mJiO7xyAZ887T5SSuIlhqOSPZQ8tHX/4PyMboKM3Guqif9GH
	Ta1iWyJQvms3rKMxh9qDKec6VN/9VcaEXBXD2ysgudrrlJQTSg+3BNpvqB5tnuleZhjqqj0iadP
	zM76jW3fpJKUiYSOQ1XBo6bksaQEXLjYqt8R1qpJJv/xOwu55AFZ3jSdDfH7Z/40jO929JKSxd8
	erI5k9QvBoRzPUstY4pVTm3jKc/9m+whnm9NCeXkRD0MGGX0/Aqbd3UtvmGrp6phZ6skiEucpvE
	1Su97S2QDX2VFpCloWMOZXT01FY8=
X-Google-Smtp-Source: AGHT+IEeF2772Sf/TgusqVHhnfW6E7OxIs/UqdSMx7ltEelfqZKV9ssEHVr5i/X1kofub69Yr6nabA==
X-Received: by 2002:a17:90b:4e90:b0:30e:3718:e9d with SMTP id 98e67ed59e1d1-31e507e84f0mr8587105a91.35.1753330329756;
        Wed, 23 Jul 2025 21:12:09 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e6631a358sm264644a91.22.2025.07.23.21.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 21:12:09 -0700 (PDT)
Date: Thu, 24 Jul 2025 04:12:02 +0000
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
Message-ID: <aIGykkgqktjgLvVI@fedora>
References: <20250709090344.88242-1-liuhangbin@gmail.com>
 <20250709090344.88242-3-liuhangbin@gmail.com>
 <6d4bbed3-472f-4002-abb9-47edf7743779@redhat.com>
 <aIGxI_ctF5RPEph8@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIGxI_ctF5RPEph8@fedora>

On Thu, Jul 24, 2025 at 04:06:03AM +0000, Hangbin Liu wrote:
> On Tue, Jul 15, 2025 at 11:37:54AM +0200, Paolo Abeni wrote:
> > > diff --git a/tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh b/tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh
> > > new file mode 100755
> > > index 000000000000..4cf8a5999aaa
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh
> > > @@ -0,0 +1,21 @@
> > > +#!/bin/sh
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +#
> > > +# Testing if bond works with lacp_active = off
> > > +
> > > +lib_dir=$(dirname "$0")
> > > +source ${lib_dir}/bond_topo_lacp.sh
> > 
> > shellcheck is not super happy about 'source' usage:
> > 
> > In bond_passive_lacp.sh line 7:
> > source ${lib_dir}/bond_topo_lacp.sh
> > ^-- SC3046 (warning): In POSIX sh, 'source' in place of '.' is undefined.
> > ^-- SC3051 (warning): In POSIX sh, 'source' in place of '.' is undefined.
> > 
> > either switch to '. ' or use bash instead of 'sh'.
> 
> Hi Paolo,
> 
> I updated the case and remove the source file bond_topo_lacp.sh.
> Instead I source the forwarding lib directly like:
> 
> lib_dir=$(dirname "$0")
> source "$lib_dir"/../../../net/forwarding/lib.sh
> 
> But this cause shell check unable to find the lib.sh as $lib_dir is get
> dynamically. This usage is common in selftest. How should we resolves this
> problem?

OK, I just disabled this warning.

# shellcheck disable=SC1091

Hangbin

