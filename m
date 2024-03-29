Return-Path: <linux-kselftest+bounces-6875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDB9891F9C
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 16:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32E81C28DF1
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 15:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DD813473B;
	Fri, 29 Mar 2024 13:43:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648E11E491;
	Fri, 29 Mar 2024 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711719781; cv=none; b=rmQuzOfwerE05vSyJE0PuecbscwLrSMoSIBivBQjjaZZIYycGTWUgEQ5IcbtRd9OORsXg+J30yQZJvuHLOQ+64bTS26IdNp1N3qPdID8rqmX6JUhEsCuX3oX9NB6TvYIfraqEg2kNyFUppk6toVe1mfEssdyYcx58qvnHjTXCB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711719781; c=relaxed/simple;
	bh=OOKluR0MmfqAn5kN5oUI2AkWr8E6RnSk9ChfUoJ40MM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=W6USAtuFN11Rkl3DnzLEi5L1gG22HGLR598nk8CPst0dzlitCU4JeF9F91dbGpcHzKz8KfczkdXdZr5WhvUOY2DKerQ/ETAimeszA0HL+x0WpMm1Esf7Q0AtIAAL4jXUa+U/UV2iu6l+Aw2HW+dKncXOhF5vOprasQSgWZVvWj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af607.dynamic.kabel-deutschland.de [95.90.246.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id A7C3661E5FE05;
	Fri, 29 Mar 2024 14:42:45 +0100 (CET)
Message-ID: <b8577dbe-1cbd-4b44-81dc-1142ff359448@molgen.mpg.de>
Date: Fri, 29 Mar 2024 14:42:44 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Language: en-US
Subject: pidfd_setns_test.c:428:nsfd_incremental_setns:Too many users - Failed
 to setns to time namespace of 31577 via nsfd 45
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Linux folks,


Running the selftests in a QEMU q35 VM, they hang.

```
$ make kselftest
[…]
ok 6 selftests: pidfd: pidfd_getfd_test
# timeout set to 45
# selftests: pidfd: pidfd_setns_test
# TAP version 13
# 1..7
# # Starting 7 tests from 2 test cases.
# #  RUN           global.setns_einval ...
# #            OK  global.setns_einval
# ok 1 global.setns_einval
# #  RUN           current_nsset.invalid_flags ...
# # pidfd_setns_test.c:161:invalid_flags:Expected self->child_pid_exited 
(0) > 0 (0)
# #            OK  current_nsset.invalid_flags
# ok 2 current_nsset.invalid_flags
# #  RUN           current_nsset.pidfd_exited_child ...
# # pidfd_setns_test.c:161:pidfd_exited_child:Expected 
self->child_pid_exited (0) > 0 (0)
# #            OK  current_nsset.pidfd_exited_child
# ok 3 current_nsset.pidfd_exited_child
# #  RUN           current_nsset.pidfd_incremental_setns ...
# # pidfd_setns_test.c:161:pidfd_incremental_setns:Expected 
self->child_pid_exited (0) > 0 (0)
# # pidfd_setns_test.c:408:pidfd_incremental_setns:Managed to correctly 
setns to user namespace of 31570 via pidfd 20
# # pidfd_setns_test.c:408:pidfd_incremental_setns:Managed to correctly 
setns to mnt namespace of 31570 via pidfd 20
# # pidfd_setns_test.c:408:pidfd_incremental_setns:Managed to correctly 
setns to pid namespace of 31570 via pidfd 20
# # pidfd_setns_test.c:408:pidfd_incremental_setns:Managed to correctly 
setns to uts namespace of 31570 via pidfd 20
# # pidfd_setns_test.c:408:pidfd_incremental_setns:Managed to correctly 
setns to ipc namespace of 31570 via pidfd 20
# # pidfd_setns_test.c:408:pidfd_incremental_setns:Managed to correctly 
setns to net namespace of 31570 via pidfd 20
# # pidfd_setns_test.c:408:pidfd_incremental_setns:Managed to correctly 
setns to cgroup namespace of 31570 via pidfd 20
# # pidfd_setns_test.c:408:pidfd_incremental_setns:Managed to correctly 
setns to pid_for_children namespace of 31570 via pidfd 20
# # pidfd_setns_test.c:391:pidfd_incremental_setns:Expected 
setns(self->child_pidfd1, info->flag) (-1) == 0 (0)
# # pidfd_setns_test.c:392:pidfd_incremental_setns:Too many users - 
Failed to setns to time namespace of 31570 via pidfd 20
# # pidfd_incremental_setns: Test terminated by timeout
# #          FAIL  current_nsset.pidfd_incremental_setns
# not ok 4 current_nsset.pidfd_incremental_setns
# #  RUN           current_nsset.nsfd_incremental_setns ...
# # pidfd_setns_test.c:161:nsfd_incremental_setns:Expected 
self->child_pid_exited (0) > 0 (0)
# # pidfd_setns_test.c:444:nsfd_incremental_setns:Managed to correctly 
setns to user namespace of 31577 via nsfd 19
# # pidfd_setns_test.c:444:nsfd_incremental_setns:Managed to correctly 
setns to mnt namespace of 31577 via nsfd 24
# # pidfd_setns_test.c:444:nsfd_incremental_setns:Managed to correctly 
setns to pid namespace of 31577 via nsfd 27
# # pidfd_setns_test.c:444:nsfd_incremental_setns:Managed to correctly 
setns to uts namespace of 31577 via nsfd 30
# # pidfd_setns_test.c:444:nsfd_incremental_setns:Managed to correctly 
setns to ipc namespace of 31577 via nsfd 33
# # pidfd_setns_test.c:444:nsfd_incremental_setns:Managed to correctly 
setns to net namespace of 31577 via nsfd 36
# # pidfd_setns_test.c:444:nsfd_incremental_setns:Managed to correctly 
setns to cgroup namespace of 31577 via nsfd 39
# # pidfd_setns_test.c:444:nsfd_incremental_setns:Managed to correctly 
setns to pid_for_children namespace of 31577 via nsfd 42
# # pidfd_setns_test.c:427:nsfd_incremental_setns:Expected 
setns(self->child_nsfds1[i], info->flag) (-1) == 0 (0)
# # pidfd_setns_test.c:428:nsfd_incremental_setns:Too many users - 
Failed to setns to time namespace of 31577 via nsfd 45
```

Ctrl + c gets me back to the shell prompt.

```
$ ps auxf
[…]
build      31574  0.0  0.0   2528  1024 pts/0    D    09:57   0:00 
./pidfd_setns_test
build      31575 99.9  0.0   2528  1024 pts/0    R    09:57  37:37  \_ 
./pidfd_setns_test
build      31576  0.0  0.0      0     0 pts/0    Z    09:57   0:00 
\_ [pidfd_setns_tes] <defunct>
build      31577  0.0  0.0      0     0 pts/0    Z    09:57   0:00 
\_ [pidfd_setns_tes] <defunct>
build      31578  0.0  0.0   2528   512 pts/0    S    09:57   0:00 
\_ ./pidfd_setns_test
```

During shutdown, the system waits for that process:

     [42733.704347] systemd-shutdown[1]: Waiting for process: 31578 
(pidfd_setns_tes)

This is commit 8d025e2092e2 with one patch on top:

     $ git log --no-decorate --oneline -2 a2ce022afcbb
     a2ce022afcbb [PATCH] kbuild: Disable KCSAN for autogenerated 
*.mod.c intermediaries
     8d025e2092e2 Merge tag 'erofs-for-6.9-rc2-fixes' of 
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs

KCSAN is not enabled though.


Kind regards,

Paul

