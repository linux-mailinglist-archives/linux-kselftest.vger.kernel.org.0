Return-Path: <linux-kselftest+bounces-28004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A1BA4B8EC
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 09:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 682E7167F71
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 08:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C291E9B3D;
	Mon,  3 Mar 2025 08:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="piPf/mEE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803EB1C8FB5
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 08:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740989726; cv=none; b=qzHfSh08Rg8gwsBxmUvEdsK2tzRCE7V6Ig2THDAsgUFm2cBJarUYaLZZnOFtJIUfnjY+0onrFMpTbQ4eSjeq054EeUKVDWwfwRS6W4vSOiyV3v78rCeMOH369umUEHZtZnxrt49i0FJKvO9AgHCOwCFT00G1YKRRB9eIz+jGvrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740989726; c=relaxed/simple;
	bh=Tsn2rgSYHAbyJc4+5zu1+SV03WOyMVHoG1tQkLFynb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twUfrR9knhPI4SvRYFrNjN3bCQDbLDSkpCDhs9Og89cdQ5WeiXcs/jfVeCH+HfFkpfvIlNmtHeO2FrZHlB1fc92Sk5eFWEX0lKddoGe9ehA6QB0/gDciiUd9b6PR0PXDniWKCnQY5SpQcYqkFtAas6QSivEfTbOSDCubOT/wwmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=piPf/mEE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B47C4CED6;
	Mon,  3 Mar 2025 08:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740989726;
	bh=Tsn2rgSYHAbyJc4+5zu1+SV03WOyMVHoG1tQkLFynb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=piPf/mEEBuqa40iL8feZGjRkctjLjDe11e2GeDSHzG+IxKpzg6pXf53/gua8H76Ew
	 y7DdhouIr2a+72SAHjfuGxgRDOku/Rwfu/c2UtzN5LamMmQ7UmYWowwgopeuvg/RpQ
	 IjD+7QrFiIE4ALAYAj1AQo7lS2vz+GC9WG8jdP3g=
Date: Mon, 3 Mar 2025 09:14:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: John Johansen <john.johansen@canonical.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>, cve@kernel.org,
	apparmor@lists.ubuntu.com, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: Re: CVE-2024-56741: apparmor: test: Fix memory leak for
 aa_unpack_strdup()
Message-ID: <2025030339-playset-august-055b@gregkh>
References: <7286c87d1ad7b705d123f23ad213ec40a9f23351.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7286c87d1ad7b705d123f23ad213ec40a9f23351.camel@decadent.org.uk>

On Sun, Mar 02, 2025 at 06:36:35PM +0100, Ben Hutchings wrote:
> Hi all,
> 
> CVE-2024-56741 is supposed to be fixed by commit 7290f5923191 "apparmor:
> test: Fix memory leak for aa_unpack_strdup()" but I think this
> assignment should be rejected.
> 
> While a user-triggered memory leak may be exploitable for denial-of-
> service, the code that was fixed here is a part of KUnit tests.
> KUnit tests usually run a single time at boot, not under user control,
> and can then later be invoked through debugfs by the root user.
> 
> Firstly, it is intended that the root user can deny service through the
> reboot system call, so I don't think additional ways to do this are
> security flaws.
> 
> Secondly, the KUnit documentation at <https://docs.kernel.org/dev-
> tools/kunit/run_manual.html> says:
> 
>     Note:
> 
>     KUnit is not designed for use in a production system. It is possible
>     that tests may reduce the stability or security of the system.
> 
> so I don't think security issues in KUnit tests generally deserve CVE
> IDs.  (That said, the help text for CONFIG_KUNIT does not have such a
> warning.)

Now rejected.

While I know that kunit says "do not use in production", that flies in
the face of a few hundred million devices out there that does have kunit
running on them, so we need to still track these, sorry.

Also, for systems where "root is locked down" preventing it from running
`reboot`, it can many times do other things, like poke around in
debugfs, so we need to track them as well.  In other words, we don't
know your use case :(

thanks,

greg k-h

