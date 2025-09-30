Return-Path: <linux-kselftest+bounces-42636-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9C9BAD112
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 15:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084593C79A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 13:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D111F2FABF5;
	Tue, 30 Sep 2025 13:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Er/O0XRG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68A725C81F;
	Tue, 30 Sep 2025 13:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759239130; cv=none; b=avoXRKYvNPmTCkXiQSW7AfCHI1CmDm80klHCBByvQJgg1LSt6Klin3N86kDJbc0kL1h1Nv1AIQXfA0YTAMs6MP78WBIxgQwAvvPuIZfCyp5yWNpICZOzbYJfb+qea0s4BxPhRb1tXPutsJALVw2dQxwMmeK9J/Ofhcvo15N22GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759239130; c=relaxed/simple;
	bh=aAsEFXm3yDjvGirG6TEe/UOXyxUepM59dngJ2xbz/Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BrE5yUwW4VWp7KLZHwYAtrfsFWdo3JDnOlov+ufem+/dDpi8RIiEkILMAd6jVA3M4FHJOqF9tLI+JbcqlRngPRLRyDAF0I6C8olCYVUbsAlkreATSW8aQAQQ9CnWrBUhm49KXdjIq4xK/xiJJVKhcP/rQQ3bkiMxIHU4rEA5z2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Er/O0XRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6C1C4CEF0;
	Tue, 30 Sep 2025 13:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759239130;
	bh=aAsEFXm3yDjvGirG6TEe/UOXyxUepM59dngJ2xbz/Zg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Er/O0XRGQXcG2GUnbkCkqcNIIzGq2JEfzyuUkW1xWfnwW9OBLWiiwPWDV70/RkYiY
	 I7Tf3+CuZZKaWcI+3kHJVrJIGHlf81RvJAFqKlXmNeyz/x7DmBDZEp0+mDHQdUlS19
	 mOY0db6+NmJNDTu/xdKx+DXV+wvsspdiY4hhEitfWmorCoAv/XPwBR2pz/aB9enkuG
	 GG/NiAW12ktFcGtcxhbc6jXMLaFZRS+nVtJCVZqjm2qDLiRifJgI5swkYLooeW7jG3
	 8t9eDYZdW6q4MucjqHUUlNADhF6NekndzAeBUOIAPGImrK7Mt1h2JNToP9a0R2Vl22
	 tVcOsQlCAHqow==
Date: Tue, 30 Sep 2025 06:32:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, petrm@nvidia.com,
 willemb@google.com, shuah@kernel.org, daniel.zahka@gmail.com,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/8] selftests: drv-net: base device access
 API test
Message-ID: <20250930063208.41ae93fe@kernel.org>
In-Reply-To: <9d215979-6c6d-4e9b-9cdd-39cff595866e@redhat.com>
References: <20250927225420.1443468-1-kuba@kernel.org>
	<20250927225420.1443468-3-kuba@kernel.org>
	<9d215979-6c6d-4e9b-9cdd-39cff595866e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Sep 2025 15:16:43 +0200 Paolo Abeni wrote:
> On 9/28/25 12:54 AM, Jakub Kicinski wrote:
> > diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
> > index 1462a339a74b..559c572e296a 100644
> > --- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
> > +++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
> > @@ -13,7 +13,7 @@ KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
> >  
> >      # Import one by one to avoid pylint false positives
> >      from net.lib.py import EthtoolFamily, NetdevFamily, NetshaperFamily, \
> > -        NlError, RtnlFamily, DevlinkFamily
> > +        NlError, RtnlFamily, DevlinkFamily, PSPFamily  
> 
> Side question:
> There is a consistent false positive ruff check about this kind of
> change (with the added import being labeled as unused even in a __init__
> file.
> 
> I'm wondering if is possible to explicitly disable such warnings?

I think it's possible to fix them by using __all__
It seemed to work but I wasn't confident enough that it's "the right
thing" to make it part of the series. I'm planning to follow up.

