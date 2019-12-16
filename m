Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E30611FFF7
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2019 09:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfLPIh5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Dec 2019 03:37:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:37312 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726722AbfLPIh5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Dec 2019 03:37:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3D940ADAD;
        Mon, 16 Dec 2019 08:37:55 +0000 (UTC)
Date:   Mon, 16 Dec 2019 09:37:54 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     jpoimboe@redhat.com, jikos@kernel.org, mbenes@suse.cz,
        joe.lawrence@redhat.com, shuah@kernel.org,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: livepatch: Fix it to do root uid check and
 skip
Message-ID: <20191216083754.hsmdd6jt2zzjmksz@pathway.suse.cz>
References: <20191213015617.23110-1-skhan@linuxfoundation.org>
 <20191213083411.delrxditrpcdm7az@pathway.suse.cz>
 <bda9819d-a054-232b-e973-41d41dfffc5a@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bda9819d-a054-232b-e973-41d41dfffc5a@linuxfoundation.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri 2019-12-13 10:52:32, Shuah Khan wrote:
> On 12/13/19 1:34 AM, Petr Mladek wrote:
> > On Thu 2019-12-12 18:56:17, Shuah Khan wrote:
> > > livepatch test configures the system and debug environment to run
> > > tests. Some of these actions fail without root access and test
> > > dumps several permission denied messages before it exits.
> > > 
> > > Fix it to check root uid and exit with skip code instead.
> > 
> > It works when I run the tests directly, e.g.
> > 
> > $> cd tools/testing/selftests/livepatch
> > $> ./test-livepatch.sh
> > 
> > But I still get an error from the selftest framework when running
> > make run_tests:
> > 
> > $> make run_tests
> > TAP version 13
> > 1..5
> > # selftests: livepatch: test-livepatch.sh
> > /mnt/kernel/linux/tools/testing/selftests/kselftest/runner.sh: line 43: /dev/stdout: Permission denied
> > not ok 1 selftests: livepatch: test-livepatch.sh # exit=1
> > # selftests: livepatch: test-callbacks.sh
> > /mnt/kernel/linux/tools/testing/selftests/kselftest/runner.sh: line 43: /dev/stdout: Permission denied
> > not ok 2 selftests: livepatch: test-callbacks.sh # exit=1
> > # selftests: livepatch: test-shadow-vars.sh
> > /mnt/kernel/linux/tools/testing/selftests/kselftest/runner.sh: line 43: /dev/stdout: Permission denied
> > not ok 3 selftests: livepatch: test-shadow-vars.sh # exit=1
> > # selftests: livepatch: test-state.sh
> > /mnt/kernel/linux/tools/testing/selftests/kselftest/runner.sh: line 43: /dev/stdout: Permission denied
> > not ok 4 selftests: livepatch: test-state.sh # exit=1
> > # selftests: livepatch: test-ftrace.sh
> > /mnt/kernel/linux/tools/testing/selftests/kselftest/runner.sh: line 43: /dev/stdout: Permission denied
> > not ok 5 selftests: livepatch: test-ftrace.sh # exit=1
> > 
> > The same problem is also in linux-next. Is this a know problem, please?
> > 
> > 
> 
> This isn't a known issue.
> 
> I am not seeing this problem on 5.5-rc1 and on linux-next with top
> commit 32b8acf85223448973ca0bf0ee8149a01410f3a0 (HEAD -> master, tag:
> next-20191213
> 
> I am curious what could be diffent in your env. that is causing it.

I did the test in kvm. I was connected there via ssh as "root".
I tested the normal user with "su - user".

It seems that in this case /dev/stdout still points to a
pseudo-terminal that is accessible only by root:

#> su - user
$> echo hello >/dev/stdout
-bash: /dev/stdout: Permission denied
$> ls -l /dev/stdout
lrwxrwxrwx 1 root root 15 Dec 13 16:08 /dev/stdout -> /proc/self/fd/1
$> ls -l /proc/self/fd/1
lrwx------. 1 user users 64 Dec 16 09:27 /proc/self/fd/1 -> /dev/pts/1
$> ls -l /dev/pts/1
crw--w---- 1 root tty 136, 1 Dec 16 09:27 /dev/pts/1

I do not see this problem when I ssh to the machine as
the normal "user".


Best Regards,
Petr
