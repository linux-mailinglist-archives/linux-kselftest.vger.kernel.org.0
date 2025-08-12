Return-Path: <linux-kselftest+bounces-38779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD03B22A09
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 16:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBF2E7AAEC1
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 14:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB96930AAC5;
	Tue, 12 Aug 2025 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4Ih3y8o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBF830AAB7;
	Tue, 12 Aug 2025 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755008162; cv=none; b=ArRwK8r2Q51TNyXCWps5URU9zPEiigzj+2SN5gfPekOem9MePY+ZnXKIM3x7KSxddBOl+ZMnWaV6vuPA1t7pp+MTtaDrFBCgooQ1QdAQd6WDMIFdbsSwA409TzOhIW3XySPHFvKkcWnBgPMkJkFpT4sLXyXnlDjLQQKEyTHpGYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755008162; c=relaxed/simple;
	bh=rDn9n3CLVSdguZsLMCEzQfYlxMxUiaR7wgP67lAJaSY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C+eD2VWHCbmCuIvEWT6U3IPj4VOpghHrF+N2spFL26maHXSOLPs9K56+Y9q+a85xITBz6syiPIhjX2LJO2CHaA/R+97xYcq32PQ5CVeEO7Ym+y4nr+e3ZEx3n9m1IMBW9dYsbdeF2GwP2NfL69zG9J1H/4r2iNbPJ+Rm+FPoxxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4Ih3y8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF9EC4CEF0;
	Tue, 12 Aug 2025 14:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755008162;
	bh=rDn9n3CLVSdguZsLMCEzQfYlxMxUiaR7wgP67lAJaSY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W4Ih3y8oXKa+XLzjZke0DghE2q8GeAlaJq2xPzU6Unly7sysAkJn85pN45mZtHLLT
	 UX26lv5DUgWmwwuY7mfdUNmUAhLFb38lE9c1UOQ1ThNZj0UpkrN13rB3ClIDeld/+v
	 CyttlHBtzXAR7Ij3wrXvOw6hNnfYutuJsvqY5yNmRt896ylPIc2Lzisam+UwFPQmew
	 Dwt2/bC5di2fvDrQah+VElCziTKq1TLkbcK0NyjQtdq3RDRNeCzXpcOaJrNl0QEuUf
	 Y5QvCeVTeKj6CKY0hllTosRLSsrWqEKprJKYUou86A9JgKYuOgB/GWfaBWtQG+uoi5
	 GqyjQIVnTReLw==
Date: Tue, 12 Aug 2025 07:16:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 willemb@google.com, petrm@nvidia.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: drv-net: wait for carrier
Message-ID: <20250812071600.6714433d@kernel.org>
In-Reply-To: <7c011a2f-cdd8-4aed-95b9-d8edb31478a7@redhat.com>
References: <20250808225741.1095702-1-kuba@kernel.org>
	<7c011a2f-cdd8-4aed-95b9-d8edb31478a7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 13:12:47 +0200 Paolo Abeni wrote:
> On 8/9/25 12:57 AM, Jakub Kicinski wrote:
> > @@ -48,6 +51,19 @@ from .remote import Remote
> >                  env[pair[0]] = pair[1]
> >          return ksft_setup(env)
> >  
> > +    def __enter__(self):
> > +        ip(f"link set dev {self.dev['ifname']} up")
> > +        wait_file(f"/sys/class/net/{self.dev['ifname']}/carrier",
> > +                  lambda x: x.strip() == "1")
> > +
> > +        return self
> > +
> > +    def __exit__(self, ex_type, ex_value, ex_tb):
> > +        """
> > +        __exit__ gets called at the end of a "with" block.
> > +        """
> > +        self.__del__()
> > +  
> 
> pylint is doing what looks like a reasonable complain to me:
> 
> tools/testing/selftests/drivers/net/lib/py/env.py:65:8: E1101: Instance
> of 'NetDrvEnvBase' has no '__del__' member (no-member)

I know, it's an abstract class. The point of having an empty method is
lost on me. But okay, let me obey the static analyzer overlord.

