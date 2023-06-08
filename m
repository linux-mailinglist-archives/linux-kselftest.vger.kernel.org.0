Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787637279C1
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 10:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbjFHINs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 04:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbjFHINs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 04:13:48 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F5D2685;
        Thu,  8 Jun 2023 01:13:44 -0700 (PDT)
X-QQ-mid: bizesmtp68t1686212018t65kjsgp
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 08 Jun 2023 16:13:37 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: QityeSR92A134yXfw+UStLlj9XQCqPw9+o3UhyY03NBSW4sifRcigGE2uPSM6
        0exz245pbUQk1OYdJXYgj237dJNxPsy6bWxwdk0V5Z5nRAXehqrQARUUcb9jaN2A4CpPoMi
        2juGiwr6RnsNvH5J5A7rSEdAgN7TrDolZfHiyR908b1ew5TyO673Hr5+lqowlDGDzaEa/md
        roufDqvgjS63ETX+/ZPrVv/hPvW3VhckerbqMmSEIs8tGFMTxP57jvY16AHrAiuXC39wn+n
        J0acJ8quDMxYsyplTIVLRwthCG0mtm4L2KTURgK4brlR5gPy6ci2D2RKNYDP3+m0f+YzLfA
        OO3xWqtJpl6YxfdN6w=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4947339487320252902
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, paulmck@kernel.org,
        thomas@t-8ch.de
Subject: Re: nolibc patches, still possible for 6.5 ?
Date:   Thu,  8 Jun 2023 16:13:37 +0800
Message-Id: <20230608081337.7546-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZID0b+nIcypMjV0y@1wt.eu>
References: <ZID0b+nIcypMjV0y@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> Hello Paul,
> 
> On Sun, Jun 04, 2023 at 03:57:54PM -0700, Paul E. McKenney wrote:
> > On Sun, Jun 04, 2023 at 03:20:11PM +0200, Willy Tarreau wrote:
> > > Hello Paul,
> > > 
> > > Thomas and Zhangjin have provided significant nolibc cleanups, and
> > > fixes, as well as preparation work to later support riscv32.
> > > 
> (...)
> > 
> > Given that the testing converges by the end of this week, I can't see
> > any reason why these cannot make v6.5.  (There were some kernel test
> > robot complaints as well, valid or not I am not sure.)
> 
> After Thomas' and Zhangjin's reviews and checks, I could run a mostly
> complete check:
>   - arm64, i386, x86_64 show 100% success
>   - arm, mips: 100% success, stackprotector skipped
>   - s390x, riscv64: run-user OK, kernel build fails (see below)
>   - loongarch: build OK, just not executed (need to upgrade my qemu
>     and I hate doing it late when some tests results are needed)
> 
> Regarding the build failure affecting s390x and riscv64, it's a regular
> kernel resulting from "make defconfig". For both archs, I'm getting this
> failure:
> 
>   In file included from kernel/rcu/update.c:649:
>   kernel/rcu/tasks.h: In function 'get_rcu_tasks_gp_kthread':
>     CC      fs/kernfs/dir.o
>     CC      security/bpf/hooks.o
>   kernel/rcu/tasks.h:1939:16: error: 'rcu_tasks' undeclared (first use in this function)
>    1939 |         return rcu_tasks.kthread_ptr;
>         |                ^~~~~~~~~
>   kernel/rcu/tasks.h:1939:16: note: each undeclared identifier is reported only once for each function it appears in
>   kernel/rcu/tasks.h:1940:1: error: control reaches end of non-void function [-Werror=return-type]
>    1940 | }
>         | ^
>   cc1: some warnings being treated as errors
> 
> I rebased the branch on top of 6.4-rc5 and got the same. I'm building
> with gcc-11.3.0 from kernel.org. I'm not sure whether this comes from
> my build environment or recent changes to the kernel, but I'm sure I
> haven't seen that error during 6.3-rc cycle. However, given that
> Zhangjin seems to have successfully built it for riscv, there might
> be something odd on my side.
>

Sorry, The reason is that to speed up the kernel build+nolibc tests, a
local small config was customized for the first report, it may not
trigger the above issue, in the later report about the v4 rv32 compile
support [1], I did test 'run' target with the default defconfig and
reported the same failure as bove, this is the note I pasted there:

  ---
  Did compile test for aarch64, rv32 and rv64, include run-user and run.

  Note, this is required with the default config from the
  20230606-nolibc-rv32+stkp7a branch of [5]:

    diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
    index ce02bb09651b..72bd8fe0cad6 100644
    --- a/kernel/rcu/tasks.h
    +++ b/kernel/rcu/tasks.h
    @@ -1934,11 +1934,13 @@ void show_rcu_tasks_gp_kthreads(void)
     }
     #endif /* #ifndef CONFIG_TINY_RCU */

    +#ifdef CONFIG_TASKS_RCU
     struct task_struct *get_rcu_tasks_gp_kthread(void)
     {
            return rcu_tasks.kthread_ptr;
     }
     EXPORT_SYMBOL_GPL(get_rcu_tasks_gp_kthread);
    +#endif

     #ifdef CONFIG_PROVE_RCU
     struct rcu_tasks_test_desc {
  ---

I have seen Paul have known the cause of the above issue in your later
discussion and you found a better solution to avoid such failures,
congrats!

[1]: https://lore.kernel.org/linux-riscv/cover.1686128703.git.falcon@tinylab.org/T/#t

Best regards,
Zhangjin

> Given that this build issue is not dependent on the selftest, I'm fine
> with the branch getting merged as-is, and can provide feedback on this
> build error if needed:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git 20230606-nolibc-rv32+stkp7a
> 
> Just let me know if you prefer that I resend the whole series or need
> more info etc, as usual.
> 
> Thank you!
> Willy
