Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C0A38CCDC
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 May 2021 20:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238396AbhEUSDl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 May 2021 14:03:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:40046 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232931AbhEUSDk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 May 2021 14:03:40 -0400
IronPort-SDR: R0ByvZRLfheaLeWna7/0QPttNWXORE1S3VH/2zHFHFC+Hc7Mp+gfcsb7WCjLsKj+GPpLfrkSFm
 gts++te2VQuQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="188666667"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="188666667"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 11:02:16 -0700
IronPort-SDR: GdOJJuHdKZYV8KOXwXoBviGCaQgd0QE0CTG0F6s2tdtysMY+8ACge9X3HkQWiQXDKD0QWx3PzO
 UNcX5vfTJv1Q==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="544174121"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.131.65]) ([10.212.131.65])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 11:02:15 -0700
Subject: Re: [PATCH v7 0/7] Fork brute force attack mitigation
To:     John Wood <john.wood@gmx.com>, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>
Cc:     valdis.kletnieks@vt.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
References: <20210521172414.69456-1-john.wood@gmx.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <19903478-52e0-3829-0515-3e17669108f7@linux.intel.com>
Date:   Fri, 21 May 2021 11:02:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210521172414.69456-1-john.wood@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


> Moreover, I think this solves another problem pointed out by Andi Kleen
> during the v5 review [2] related to the possibility that a supervisor
> respawns processes killed by the Brute LSM. He suggested adding some way so
> a supervisor can know that a process has been killed by Brute and then
> decide to respawn or not. So, now, the supervisor can read the brute xattr
> of one executable and know if it is blocked by Brute and why (using the
> statistical data).

It looks better now, Thank.

One potential problem is that the supervisor might see the executable 
directly, but run it through some wrapper. In fact I suspect that will 
be fairly common with complex daemons. So it couldn't directly look at 
the xattr. Might be useful to also pass this information through the 
wait* chain, so that the supervisor can directly collect it. That would 
need some extension to these system calls.

-Andi


>
> [2] https://lore.kernel.org/kernel-hardening/878s78dnrm.fsf@linux.intel.com/
>
> Knowing all this information I will explain now the different patches:
>
> The 1/7 patch defines a new LSM hook to get the fatal signal of a task.
> This will be useful during the attack detection phase.
>
> The 2/7 patch defines a new LSM and the necessary sysctl attributes to fine
> tuning the attack detection.
>
> The 3/7 patch detects a fork/exec brute force attack and narrows the
> possible cases taken into account the privilege boundary crossing.
>
> The 4/7 patch mitigates a brute force attack.
>
> The 5/7 patch adds self-tests to validate the Brute LSM expectations.
>
> The 6/7 patch adds the documentation to explain this implementation.
>
> The 7/7 patch updates the maintainers file.
>
> This patch serie is a task of the KSPP [3] and can also be accessed from my
> github tree [4] in the "brute_v7" branch.
>
> [3] https://github.com/KSPP/linux/issues/39
> [4] https://github.com/johwood/linux/
>
> When I ran the "checkpatch" script I got the following errors, but I think
> they are false positives as I follow the same coding style for the others
> extended attributes suffixes.
>
> ----------------------------------------------------------------------------
> ../patches/brute_v7/v7-0003-security-brute-Detect-a-brute-force-attack.patch
> ----------------------------------------------------------------------------
> ERROR: Macros with complex values should be enclosed in parentheses
> 89: FILE: include/uapi/linux/xattr.h:80:
> +#define XATTR_NAME_BRUTE XATTR_SECURITY_PREFIX XATTR_BRUTE_SUFFIX
>
> -----------------------------------------------------------------------------
> ../patches/brute_v7/v7-0005-selftests-brute-Add-tests-for-the-Brute-LSM.patch
> -----------------------------------------------------------------------------
> ERROR: Macros with complex values should be enclosed in parentheses
> 100: FILE: tools/testing/selftests/brute/rmxattr.c:18:
> +#define XATTR_NAME_BRUTE XATTR_SECURITY_PREFIX XATTR_BRUTE_SUFFIX
>
> When I ran the "kernel-doc" script with the following parameters:
>
> ./scripts/kernel-doc --none -v security/brute/brute.c
>
> I got the following warning:
>
> security/brute/brute.c:65: warning: contents before sections
>
> But I don't understand why it is complaining. Could it be a false positive?
>
> The previous versions can be found in:
>
> RFC
> https://lore.kernel.org/kernel-hardening/20200910202107.3799376-1-keescook@chromium.org/
>
> Version 2
> https://lore.kernel.org/kernel-hardening/20201025134540.3770-1-john.wood@gmx.com/
>
> Version 3
> https://lore.kernel.org/lkml/20210221154919.68050-1-john.wood@gmx.com/
>
> Version 4
> https://lore.kernel.org/lkml/20210227150956.6022-1-john.wood@gmx.com/
>
> Version 5
> https://lore.kernel.org/kernel-hardening/20210227153013.6747-1-john.wood@gmx.com/
>
> Version 6
> https://lore.kernel.org/kernel-hardening/20210307113031.11671-1-john.wood@gmx.com/
>
> Changelog RFC -> v2
> -------------------
> - Rename this feature with a more suitable name (Jann Horn, Kees Cook).
> - Convert the code to an LSM (Kees Cook).
> - Add locking  to avoid data races (Jann Horn).
> - Add a new LSM hook to get the fatal signal of a task (Jann Horn, Kees
>    Cook).
> - Add the last crashes timestamps list to avoid false positives in the
>    attack detection (Jann Horn).
> - Use "period" instead of "rate" (Jann Horn).
> - Other minor changes suggested (Jann Horn, Kees Cook).
>
> Changelog v2 -> v3
> ------------------
> - Compute the application crash period on an on-going basis (Kees Cook).
> - Detect a brute force attack through the execve system call (Kees Cook).
> - Detect an slow brute force attack (Randy Dunlap).
> - Fine tuning the detection taken into account privilege boundary crossing
>    (Kees Cook).
> - Taken into account only fatal signals delivered by the kernel (Kees
>    Cook).
> - Remove the sysctl attributes to fine tuning the detection (Kees Cook).
> - Remove the prctls to allow per process enabling/disabling (Kees Cook).
> - Improve the documentation (Kees Cook).
> - Fix some typos in the documentation (Randy Dunlap).
> - Add self-test to validate the expectations (Kees Cook).
>
> Changelog v3 -> v4
> ------------------
> - Fix all the warnings shown by the tool "scripts/kernel-doc" (Randy
>    Dunlap).
>
> Changelog v4 -> v5
> ------------------
> - Fix some typos (Randy Dunlap).
>
> Changelog v5 -> v6
> ------------------
> - Fix a reported deadlock (kernel test robot).
> - Add high level details to the documentation (Andi Kleen).
>
> Changelog v6 -> v7
> ------------------
>
> - Add the "Reviewed-by:" tag to the first patch.
> - Rearrange the brute LSM between lockdown and yama (Kees Cook).
> - Split subdir and obj in security/Makefile (Kees Cook).
> - Reduce the number of header files included (Kees Cook).
> - Print the pid when an attack is detected (Kees Cook).
> - Use the socket_accept LSM hook instead of socket_sock_rcv_skb hook to
>    avoid running a hook on every incoming network packet (Kees Cook).
> - Update the documentation and fix it to render it properly (Jonathan
>    Corbet).
> - Manage correctly an exec brute force attack avoiding the bypass (Valdis
>    Kletnieks).
> - Other minor changes and cleanups.
>
> Any constructive comments are welcome.
> Thanks in advance.
>
> John Wood (7):
>    security: Add LSM hook at the point where a task gets a fatal signal
>    security/brute: Define a LSM and add sysctl attributes
>    security/brute: Detect a brute force attack
>    security/brute: Mitigate a brute force attack
>    selftests/brute: Add tests for the Brute LSM
>    Documentation: Add documentation for the Brute LSM
>    MAINTAINERS: Add a new entry for the Brute LSM
>
>   Documentation/admin-guide/LSM/Brute.rst  | 334 +++++++++++
>   Documentation/admin-guide/LSM/index.rst  |   1 +
>   MAINTAINERS                              |   7 +
>   include/linux/lsm_hook_defs.h            |   1 +
>   include/linux/lsm_hooks.h                |   4 +
>   include/linux/security.h                 |   4 +
>   include/uapi/linux/xattr.h               |   3 +
>   kernel/signal.c                          |   1 +
>   security/Kconfig                         |  11 +-
>   security/Makefile                        |   2 +
>   security/brute/Kconfig                   |  15 +
>   security/brute/Makefile                  |   2 +
>   security/brute/brute.c                   | 716 +++++++++++++++++++++++
>   security/security.c                      |   5 +
>   tools/testing/selftests/Makefile         |   1 +
>   tools/testing/selftests/brute/.gitignore |   2 +
>   tools/testing/selftests/brute/Makefile   |   5 +
>   tools/testing/selftests/brute/config     |   1 +
>   tools/testing/selftests/brute/rmxattr.c  |  34 ++
>   tools/testing/selftests/brute/test.c     | 507 ++++++++++++++++
>   tools/testing/selftests/brute/test.sh    | 256 ++++++++
>   21 files changed, 1907 insertions(+), 5 deletions(-)
>   create mode 100644 Documentation/admin-guide/LSM/Brute.rst
>   create mode 100644 security/brute/Kconfig
>   create mode 100644 security/brute/Makefile
>   create mode 100644 security/brute/brute.c
>   create mode 100644 tools/testing/selftests/brute/.gitignore
>   create mode 100644 tools/testing/selftests/brute/Makefile
>   create mode 100644 tools/testing/selftests/brute/config
>   create mode 100644 tools/testing/selftests/brute/rmxattr.c
>   create mode 100644 tools/testing/selftests/brute/test.c
>   create mode 100755 tools/testing/selftests/brute/test.sh
>
> --
> 2.25.1
>
