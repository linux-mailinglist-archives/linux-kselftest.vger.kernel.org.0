Return-Path: <linux-kselftest+bounces-41852-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBBBB854FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 16:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90A7D3B810C
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 14:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B48530CB2F;
	Thu, 18 Sep 2025 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="wtH0nwzj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C4E30C0F4
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206718; cv=none; b=EpyfUrG+l5yZv/n+4u1esN+Ycp5eM4cQtyq9u9k43UYQWqx0nWW8t3PK+kTa7BUY5N+v77cXE/6hnNUFg6GRqdZy7syXgrzzPViWBpv+1uEX8UhH86E7MOiQuCJ6aQqw65CsFwXUg+iQUcE1es9TF5Vfs0xumPzdO0bCSZNKvgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206718; c=relaxed/simple;
	bh=HNcr4hj+PWJezpWTMO69zuQ21fTIIsHEyalsjbUArJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3b487qdpvxX1k54AFlc4uFXi0Jmklkg9w63V2Z4Bj4zoAU7wAhuIriukEmtmRFlhOwwud8gFHjgeWNEbndHpZoQT/XqTpexyzwG+HtZLzNVIDAd6nETqY6GmQHjDH4lILRbqmUpwhyvJuB+mMUil+BVzbO47hxXkrvHOK8OJjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=wtH0nwzj; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cSHX84ZLvz3fN;
	Thu, 18 Sep 2025 16:07:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1758204456;
	bh=rSpP2Rhs4Sq+EnZLU66LII2TWUoL0bxMyPUD10kctzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wtH0nwzjhFH9Jb32796bqsIMo9ianSywMgXXfU/95o66PAMWw9Kr2fYNb/znLGeMw
	 0yLPPI9HNk4kwundaR99SoY6DDuuEAailrrQnyFAg/wT+j8RzUic3uaCFCRlkFmlR0
	 xRnG4wXetOdYl1MA4R5tsZxdUnSC+ZghuRI3Sn0s=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4cSHX66JKbzQqr;
	Thu, 18 Sep 2025 16:07:34 +0200 (CEST)
Date: Thu, 18 Sep 2025 16:07:15 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Abhinav Saxena <xandfury@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	llvm@lists.linux.dev, Daniel Verkamp <dverkamp@chromium.org>, 
	Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH RFC 0/4] landlock: add LANDLOCK_SCOPE_MEMFD_EXEC execution
Message-ID: <20250918.io7too8ain7A@digikod.net>
References: <20250719-memfd-exec-v1-0-0ef7feba5821@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250719-memfd-exec-v1-0-0ef7feba5821@gmail.com>
X-Infomaniak-Routing: alpha

Thanks for this patch series Abhinav!  The code looks good overall, but
we should clarify the design.  Sorry for the delayed response, it is on
my radar now.

CCing Jeff and Daniel

On Sat, Jul 19, 2025 at 05:13:10AM -0600, Abhinav Saxena wrote:
> This patch series introduces LANDLOCK_SCOPE_MEMFD_EXEC, a new Landlock
> scoping mechanism that restricts execution of anonymous memory file
> descriptors (memfd) created via memfd_create(2). This addresses security
> gaps where processes can bypass W^X policies and execute arbitrary code
> through anonymous memory objects.
> 
> Fixes: https://github.com/landlock-lsm/linux/issues/37
> 
> SECURITY PROBLEM
> ================
> 
> Current Landlock filesystem restrictions do not cover memfd objects,
> allowing processes to:
> 
> 1. Read-to-execute bypass: Create writable memfd, inject code,
>    then execute via mmap(PROT_EXEC) or direct execve()
> 2. Anonymous execution: Execute code without touching the filesystem via
>    execve("/proc/self/fd/N") where N is a memfd descriptor

> 3. Cross-domain access violations: Pass memfd between processes to
>    bypass domain restrictions

Landlock only restricts access at open time, which is a useful property.
This enables to create more restricted sandboxes but still get access to
outside resources via trusted processes.  If the process passing the FDs
is not trusted, the sandboxed process could just ask to execute
arbitrary code outside the sandbox anyway.

However, the Landlock scopes are designed to block IPC from within a
sandbox to outside the sandbox.  We could have a new scope to forbid a
sandbox process to receive or inherit file descriptors, but that would
be a different and generic feature.  For compatibility reasons, this
might not be easy to implement and I think there are more important
features to implement before that.

Thinking more about it, restricting memfd should not be a "scoped" flag
because the semantic is not the same, but we should have a new ruleset
property instead, something like "ruleset.denied" with a related
LANDLOCK_DENY_EXECUTE_MEMFD flag.  This flag will only have an impact on
newly created memfd from a sandboxed process with this restriction at
creation time. This could be implemented with hook_file_alloc_security()
by checking if the file is indeed a memfd and checking inode->i_mode for
executability bits (which would imply MFD_NOEXEC_SEAL).

> 
> These scenarios can occur in sandboxed environments where filesystem
> access is restricted but memfd creation remains possible.
> 
> IMPLEMENTATION
> ==============
> 
> The implementation adds hierarchical execution control through domain
> scoping:
> 
> Core Components:
> - is_memfd_file(): Reliable memfd detection via "memfd:" dentry prefix
> - domain_is_scoped(): Cross-domain hierarchy checking (moved to domain.c)
> - LSM hooks: mmap_file, file_mprotect, bprm_creds_for_exec
> - Creation-time restrictions: hook_file_alloc_security
> 
> Security Matrix:
> Execution decisions follow domain hierarchy rules preventing both
> same-domain bypass attempts and cross-domain access violations while
> preserving legitimate hierarchical access patterns.
> 
> Domain Hierarchy with LANDLOCK_SCOPE_MEMFD_EXEC:
> ===============================================
> 
> Root (no domain) - No restrictions
>   |
>   +-- Domain A [SCOPE_MEMFD_EXEC] Layer 1
>   |     +-- memfd_A (tagged with Domain A as creator)
>   |     |
>   |     +-- Domain A1 (child) [NO SCOPE] Layer 2
>   |     |     +-- Inherits Layer 1 restrictions from parent
>   |     |     +-- memfd_A1 (can create, inherits restrictions)
>   |     |     +-- Domain A1a [SCOPE_MEMFD_EXEC] Layer 3
>   |     |           +-- memfd_A1a (tagged with Domain A1a)
>   |     |
>   |     +-- Domain A2 (child) [SCOPE_MEMFD_EXEC] Layer 2
>   |           +-- memfd_A2 (tagged with Domain A2 as creator)
>   |           +-- CANNOT access memfd_A1 (different subtree)
>   |
>   +-- Domain B [SCOPE_MEMFD_EXEC] Layer 1
>         +-- memfd_B (tagged with Domain B as creator)
>         +-- CANNOT access ANY memfd from Domain A subtree
> 
> Execution Decision Matrix:
> ========================
> Executor->  |  A  | A1 | A1a | A2 | B  | Root
> Creator     |     |    |     |    |    |
> ------------|-----|----|-----|----|----|-----
> Domain A    |  X  | X  | X   | X  | X  |  Y
> Domain A1   |  Y  | X  | X   | X  | X  |  Y
> Domain A1a  |  Y  | Y  | X   | X  | X  |  Y
> Domain A2   |  Y  | X  | X   | X  | X  |  Y
> Domain B    |  X  | X  | X   | X  | X  |  Y
> Root        |  Y  | Y  | Y   | Y  | Y  |  Y
> 
> Legend: Y = Execution allowed, X = Execution denied

Because checks should not be related to scopes, this will be much
simpler.

> 
> Scenarios Covered:
> - Direct mmap(PROT_EXEC) on memfd files
> - Two-stage mmap(PROT_READ) + mprotect(PROT_EXEC) bypass attempts
> - execve("/proc/self/fd/N") anonymous execution
> - execveat() and fexecve() file descriptor execution
> - Cross-process memfd inheritance and IPC passing
> 
> TESTING
> =======
> 
> All patches have been validated with:
> - scripts/checkpatch.pl --strict (clean)
> - Selftests covering same-domain restrictions, cross-domain 
>   hierarchy enforcement, and regular file isolation
> - KUnit tests for memfd detection edge cases

Thanks for all these tests!

> 
> DISCLAIMER
> ==========
> 
> My understanding of Landlock scoping semantics may be limited, but this
> implementation reflects my current understanding based on available
> documentation and code analysis. I welcome feedback and corrections
> regarding the scoping logic and domain hierarchy enforcement.
> 
> Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
> ---
> Abhinav Saxena (4):
>       landlock: add LANDLOCK_SCOPE_MEMFD_EXEC scope
>       landlock: implement memfd detection
>       landlock: add memfd exec LSM hooks and scoping
>       selftests/landlock: add memfd execution tests
> 
>  include/uapi/linux/landlock.h                      |   5 +
>  security/landlock/.kunitconfig                     |   1 +
>  security/landlock/audit.c                          |   4 +
>  security/landlock/audit.h                          |   1 +
>  security/landlock/cred.c                           |  14 -
>  security/landlock/domain.c                         |  67 ++++
>  security/landlock/domain.h                         |   4 +
>  security/landlock/fs.c                             | 405 ++++++++++++++++++++-
>  security/landlock/limits.h                         |   2 +-
>  security/landlock/task.c                           |  67 ----
>  .../selftests/landlock/scoped_memfd_exec_test.c    | 325 +++++++++++++++++
>  11 files changed, 812 insertions(+), 83 deletions(-)
> ---
> base-commit: 5b74b2eff1eeefe43584e5b7b348c8cd3b723d38
> change-id: 20250716-memfd-exec-ac0d582018c3
> 
> Best regards,
> -- 
> Abhinav Saxena <xandfury@gmail.com>
> 
> 

