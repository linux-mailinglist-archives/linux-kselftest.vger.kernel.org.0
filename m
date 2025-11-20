Return-Path: <linux-kselftest+bounces-46130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9F3C75447
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 17:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 762093439F8
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 16:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8CE35E526;
	Thu, 20 Nov 2025 16:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="FygshPq5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B6C35C186
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654852; cv=none; b=CetZZ4Sy6rxjRxeWeiNoLUuVADs0DF0KidhIsantxiJyzdldpUY4b8BZv7LatelM4XjDikFcZTkjr2i0Wj1MPCuqhJOgn3j7pUOAy//6CYdccbYD9i3iWJAN5Amt80Nl0NeYUXi2uNhvapku2HghzYdy6MYQXvy7Kaaga0zfoiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654852; c=relaxed/simple;
	bh=ikZZTlmcvvgaeRuhpKBwP55qPBNe+u4ZLfVXPYvtcZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfAMLhn4w7TLSH1kjwRDuVuS3ooTe6FnfauWFgl8mPgX6JQoebuz77MIBGNydB8m2J0T5O7qCZKdOP51pZhUuWYQBSgZKkKY1jsFF4bgcTxjIg0feepQI6jA9kUtWZWXawGmNQfxnRFIW7MY/a1IG5MMhnHb/ZxI50T5cdwYJgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=FygshPq5; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dC2fJ0JsMzlg6;
	Thu, 20 Nov 2025 16:42:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1763653335;
	bh=bK5R4FWeryYY7Dzvx1ZNaz58dfr5FQOYKvQc4SGZ4YM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FygshPq5IlSlaXB1OLnU88u1OtCo/xcWUxfMvs71UOoduLLFVoXOeHiyDK+tRMw0l
	 hu+p5NjGJ+xoeATGrs1fPTBCGdZ4sUGKHCE0B7eOrmuKt04DyNFr6rYj+MuoAJEM++
	 c0Ct4rf06JBSY1HTX38a+2Zi8SuATscH9CjsvXO4=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dC2fG24dwzXmx;
	Thu, 20 Nov 2025 16:42:14 +0100 (CET)
Date: Thu, 20 Nov 2025 16:42:13 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Abhinav Saxena <xandfury@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	llvm@lists.linux.dev, Daniel Verkamp <dverkamp@chromium.org>, 
	Jeff Xu <jeffxu@chromium.org>, =?utf-8?B?VGhpw6liYXVk?= Weksteen <tweek@google.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH RFC 0/4] landlock: add LANDLOCK_SCOPE_MEMFD_EXEC execution
Message-ID: <20251120.KuoC9rol6aht@digikod.net>
References: <20250719-memfd-exec-v1-0-0ef7feba5821@gmail.com>
 <20250918.io7too8ain7A@digikod.net>
 <878qhy2lch.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878qhy2lch.fsf@gmail.com>
X-Infomaniak-Routing: alpha

On Sun, Sep 28, 2025 at 05:37:02PM -0600, Abhinav Saxena wrote:
> Thanks for the detailed reply Mickaël!
> 
> Mickaël Salaün <mic@digikod.net> writes:
> 
> > Thanks for this patch series Abhinav!  The code looks good overall, but
> > we should clarify the design.  Sorry for the delayed response, it is on
> > my radar now.

Please feel free to ping me after two weeks without answer, I might miss
some emails.

> >
> > CCing Jeff and Daniel
> >
> > On Sat, Jul 19, 2025 at 05:13:10AM -0600, Abhinav Saxena wrote:
> >> This patch series introduces LANDLOCK_SCOPE_MEMFD_EXEC, a new Landlock
> >> scoping mechanism that restricts execution of anonymous memory file
> >> descriptors (memfd) created via memfd_create(2). This addresses security
> >> gaps where processes can bypass W^X policies and execute arbitrary code
> >> through anonymous memory objects.
> >> 
> >> Fixes: <https://github.com/landlock-lsm/linux/issues/37>
> >> 
> >> SECURITY PROBLEM
> >> `=============='
> >> 
> >> Current Landlock filesystem restrictions do not cover memfd objects,
> >> allowing processes to:
> >> 
> >> 1. Read-to-execute bypass: Create writable memfd, inject code,
> >>    then execute via mmap(PROT_EXEC) or direct execve()
> >> 2. Anonymous execution: Execute code without touching the filesystem via
> >>    execve(“/proc/self/fd/N”) where N is a memfd descriptor
> >
> >> 3. Cross-domain access violations: Pass memfd between processes to
> >>    bypass domain restrictions
> >
> > Landlock only restricts access at open time, which is a useful property.
> > This enables to create more restricted sandboxes but still get access to
> > outside resources via trusted processes.  If the process passing the FDs
> > is not trusted, the sandboxed process could just ask to execute
> > arbitrary code outside the sandbox anyway.
> >
> > However, the Landlock scopes are designed to block IPC from within a
> > sandbox to outside the sandbox.  We could have a new scope to forbid a
> > sandbox process to receive or inherit file descriptors, but that would
> > be a different and generic feature.  For compatibility reasons, this
> > might not be easy to implement and I think there are more important
> > features to implement before that.
> >
> > Thinking more about it, restricting memfd should not be a “scoped” flag
> > because the semantic is not the same, but we should have a new ruleset
> > property instead, something like “ruleset.denied” with a related
> > LANDLOCK_DENY_EXECUTE_MEMFD flag.  This flag will only have an impact on
> > newly created memfd from a sandboxed process with this restriction at
> > creation time. This could be implemented with hook_file_alloc_security()
> > by checking if the file is indeed a memfd and checking inode->i_mode for
> > executability bits (which would imply MFD_NOEXEC_SEAL).
> >
> 
> Thanks for the clarification! So if I understood correctly we are
> proposing adding a `denied` field to the `landlock_ruleset_attr` struct
> 
> struct landlock_ruleset_attr {
>     __u64 handled_access_fs;
>     __u64 handled_access_net;
>     __u64 scoped;
>     __u64 denied;              /* New field */
> };
> 
> which allows memfd_create() to be allowed by default unless
> LANDLOCK_DENY_EXECUTE_MEMFD bit is set.

Yes

> Also it seems Thiébaud
> Weksteen’s patch[1] will land, and maybe we can use
> security_inode_init_security_anon instead? What do you think?

Definitely, and this patch is now merged in -next.

> 
> Apologies for my ignorance, do we have to wait till his patch has
> landed into Linus’s tree?

As long as you explain this dependency in the commit message and point
to the patch (as a comment, after a "---" line), we're good.

> 
> >> 
> >> These scenarios can occur in sandboxed environments where filesystem
> >> access is restricted but memfd creation remains possible.
> >> 
> >> IMPLEMENTATION
> >> `============'
> >> 
> >> The implementation adds hierarchical execution control through domain
> >> scoping:
> >> 
> >> Core Components:
> >> - is_memfd_file(): Reliable memfd detection via “memfd:” dentry prefix
> >> - domain_is_scoped(): Cross-domain hierarchy checking (moved to domain.c)
> >> - LSM hooks: mmap_file, file_mprotect, bprm_creds_for_exec
> >> - Creation-time restrictions: hook_file_alloc_security
> >> 
> >> Security Matrix:
> >> Execution decisions follow domain hierarchy rules preventing both
> >> same-domain bypass attempts and cross-domain access violations while
> >> preserving legitimate hierarchical access patterns.
> >> 
> >> Domain Hierarchy with LANDLOCK_SCOPE_MEMFD_EXEC:
> >> `============================================='
> >> 
> >> Root (no domain) - No restrictions
> >>   |
> >>   +– Domain A [SCOPE_MEMFD_EXEC] Layer 1
> >>   |     +– memfd_A (tagged with Domain A as creator)
> >>   |     |
> >>   |     +– Domain A1 (child) [NO SCOPE] Layer 2
> >>   |     |     +– Inherits Layer 1 restrictions from parent
> >>   |     |     +– memfd_A1 (can create, inherits restrictions)
> >>   |     |     +– Domain A1a [SCOPE_MEMFD_EXEC] Layer 3
> >>   |     |           +– memfd_A1a (tagged with Domain A1a)
> >>   |     |
> >>   |     +– Domain A2 (child) [SCOPE_MEMFD_EXEC] Layer 2
> >>   |           +– memfd_A2 (tagged with Domain A2 as creator)
> >>   |           +– CANNOT access memfd_A1 (different subtree)
> >>   |
> >>   +– Domain B [SCOPE_MEMFD_EXEC] Layer 1
> >>         +– memfd_B (tagged with Domain B as creator)
> >>         +– CANNOT access ANY memfd from Domain A subtree
> >> 
> >> Execution Decision Matrix:
> >> `======================'
> >> Executor->  |  A  | A1 | A1a | A2 | B  | Root
> >> Creator     |     |    |     |    |    |
> >> ————|—–|—-|—–|—-|—-|—–
> >> Domain A    |  X  | X  | X   | X  | X  |  Y
> >> Domain A1   |  Y  | X  | X   | X  | X  |  Y
> >> Domain A1a  |  Y  | Y  | X   | X  | X  |  Y
> >> Domain A2   |  Y  | X  | X   | X  | X  |  Y
> >> Domain B    |  X  | X  | X   | X  | X  |  Y
> >> Root        |  Y  | Y  | Y   | Y  | Y  |  Y
> >> 
> >> Legend: Y = Execution allowed, X = Execution denied
> >
> > Because checks should not be related to scopes, this will be much
> > simpler.
> >
> >> 
> >> Scenarios Covered:
> >> - Direct mmap(PROT_EXEC) on memfd files
> >> - Two-stage mmap(PROT_READ) + mprotect(PROT_EXEC) bypass attempts
> >> - execve("/proc/self/fd/N") anonymous execution
> >> - execveat() and fexecve() file descriptor execution
> >> - Cross-process memfd inheritance and IPC passing
> >> 
> >> TESTING
> >> `====='
> >> 
> >> All patches have been validated with:
> >> - scripts/checkpatch.pl –strict (clean)
> >> - Selftests covering same-domain restrictions, cross-domain 
> >>   hierarchy enforcement, and regular file isolation
> >> - KUnit tests for memfd detection edge cases
> >
> > Thanks for all these tests!
> >
> >> 
> >> DISCLAIMER
> >> `========'
> >> 
> >> My understanding of Landlock scoping semantics may be limited, but this
> >> implementation reflects my current understanding based on available
> >> documentation and code analysis. I welcome feedback and corrections
> >> regarding the scoping logic and domain hierarchy enforcement.
> >> 
> >> Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
> >> —
> >> Abhinav Saxena (4):
> >>       landlock: add LANDLOCK_SCOPE_MEMFD_EXEC scope
> >>       landlock: implement memfd detection
> >>       landlock: add memfd exec LSM hooks and scoping
> >>       selftests/landlock: add memfd execution tests
> >> 
> >>  include/uapi/linux/landlock.h                      |   5 +
> >>  security/landlock/.kunitconfig                     |   1 +
> >>  security/landlock/audit.c                          |   4 +
> >>  security/landlock/audit.h                          |   1 +
> >>  security/landlock/cred.c                           |  14 -
> >>  security/landlock/domain.c                         |  67 ++++
> >>  security/landlock/domain.h                         |   4 +
> >>  security/landlock/fs.c                             | 405 ++++++++++++++++++++-
> >>  security/landlock/limits.h                         |   2 +-
> >>  security/landlock/task.c                           |  67 —-
> >>  …/selftests/landlock/scoped_memfd_exec_test.c    | 325 +++++++++++++++++
> >>  11 files changed, 812 insertions(+), 83 deletions(-)
> >> —
> >> base-commit: 5b74b2eff1eeefe43584e5b7b348c8cd3b723d38
> >> change-id: 20250716-memfd-exec-ac0d582018c3
> >> 
> >> Best regards,
> >> – 
> >> Abhinav Saxena <xandfury@gmail.com>
> >> 
> >> 
> 
> Best,
> Abhinav
> 
> [1] - <https://lore.kernel.org/all/20250918020434.1612137-1-tweek@google.com/>


