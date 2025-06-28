Return-Path: <linux-kselftest+bounces-36021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4C9AEC3E7
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 03:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A9537AABA3
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 01:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2918E1E260C;
	Sat, 28 Jun 2025 01:52:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFB71C860F
	for <linux-kselftest@vger.kernel.org>; Sat, 28 Jun 2025 01:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751075564; cv=none; b=VT5RTvSKUa7Xe09pbnLfikKxblJ43TehxOdWaIOBNOB16GQaMz2G5cjRzE4PwA4MrDrJlQNyfxcXGA/eobqxbRrNVo7xYpDHzqM2RScoc8dXDufTc4nyp7yvvawJwG/+xx2j6EhWdX/7VjVKHMjyqXxji3NXrwGekcYKQOsJ+Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751075564; c=relaxed/simple;
	bh=NffUPSkbj1gfeu1piPJZyezUcJfgslp/p6HerefCQtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbEWhN/GbNh6eKoIDsodGpg+F5/JDkHYOiHe77CB908rGiye0papum4t9EE7nyXqUc/WIGtkZMEgrZpmozmiq960PKD1jCoC8YV1Rd+2//k4hGkzEesbT8aZPkFzR10pqG0Qv00g179M80rv3yZzhWI+usFmGiuYHPDed5qVJJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([70.33.172.117])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 55S1q3WA024139
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 21:52:03 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 1736E340663; Fri, 27 Jun 2025 21:52:03 -0400 (EDT)
Date: Fri, 27 Jun 2025 21:52:03 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Abhinav Saxena <xandfury@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        selinux@vger.kernel.org, kees@kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/2] Possible TTY privilege escalation in TIOCSTI ioctl
Message-ID: <20250628015203.GA4253@mit.edu>
References: <20250622-toicsti-bug-v1-0-f374373b04b2@gmail.com>
 <87y0tcu23d.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y0tcu23d.fsf@gmail.com>

On Fri, Jun 27, 2025 at 06:38:42PM -0600, Abhinav Saxena wrote:
> >
> > As noted in previous discussion, while CONFIG_LEGACY_TIOCSTI can restrict
> > TIOCSTI usage, it is enabled by default in most distributions. Even when
> > CONFIG_LEGACY_TIOCSTI=n, processes with CAP_SYS_ADMIN can still use TIOCSTI
> > according to the Kconfig documentation.
> >
> > Additionally, CONFIG_LEGACY_TIOCSTI controls the default value for the
> > dev.tty.legacy_tiocsti sysctl, which remains runtime-configurable. This
> > means the described attack vector could work on systems even with
> > CONFIG_LEGACY_TIOCSTI=n, particularly on Ubuntu 24.04 where it’s “restricted”
> > but still functional.

What is the threat scenario that you are concerned about?  The concern
with TIOSTI is that it is a privilege escalation mechanism.  But you
need to have root (well, CAP_SYS_ADMIN) to either enable the
dev.tty.legacy_tiocsti sysctl, or to use TIOCSTI.  So what's the
privilege escalation that you're concerned about?

I could imagine some fairly esoteric ways that this might be a
problem, but if it's not a common case concern, maybe using some kind
of LSM to more forcibly disable TIOCSTI is sufficient?

Yes, we could imagine ways in which it could be permanently disabled
(perhaps via a boot command line option) such that it can't be
re-enabled without rebooting.  But is the extra complexity worth it,
especially when there is always the LSM solution for the
super-paranoid sysadmins?

							- Ted

