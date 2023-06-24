Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1CE73C774
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Jun 2023 09:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjFXHr5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 24 Jun 2023 03:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjFXHr4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 24 Jun 2023 03:47:56 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD28019B7;
        Sat, 24 Jun 2023 00:47:52 -0700 (PDT)
X-QQ-mid: bizesmtp69t1687592856t8jmq2cy
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 24 Jun 2023 15:47:35 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: /rrU+puPB7TMQuMP1erzBvP+Z8py1YsIU1LjWUtYGWooMsi5DJqGYdfGam6AA
        dR7PHHd5oj9w4p9f+9Z6v1asuOroiuC9ym61+SNCA9XQ1BOHGCDN9uphY8Xnx5GWe/r09Fc
        b+82BAl6E8YFWyYdSlT1RJHiHeVYXXHyGeYRuT9C6d1LTjpNc1I50iT8l4mLYXLhNFoyI/d
        PG2xqY3pkwrvumV609NDGMgMuLmI0RjM6s5aVq62InxaAXst15Od3RLk0j6TX7+qY804VoL
        +4ZNNNtqpmykOmcRKd1NU4eSt/1gZ47UYDms3sJG7mPWHXZRXlcxR9TGYkAUm3V+lFGVxYY
        FF+AQaN4LzOh0xgRT5oJAI+wD4YfHJ3GMLdvbgh
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3816886055142245368
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     arnd@arndb.de, david.laight@aculab.com, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, w@1wt.eu
Subject: Re: [PATCH v4 10/10] selftests/nolibc: add mmap and munmap test cases
Date:   Sat, 24 Jun 2023 15:47:21 +0800
Message-Id: <20230624074721.587306-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <97fbbe17-b261-475c-8959-71cccaa5a2f5@t-8ch.de>
References: <97fbbe17-b261-475c-8959-71cccaa5a2f5@t-8ch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Thomas

> Hi Zhangjin,
> 
> On 2023-06-23 03:32:49+0800, Zhangjin Wu wrote:
> > > On 2023-06-19 23:55:41+0800, Zhangjin Wu wrote:
> > > > Three mmap/munmap related test cases are added:
> > > > 
(snipped)
> > > >  
> > > > +int test_mmap_munmap(int size)
> > > > +{
> > > > +	char init_files[5][20] = {"/init", "/sbin/init", "/etc/init", "/bin/init", "/bin/sh"};
> > > 
> > > Why not /proc/1/exe or even /proc/self/exe?
> > > 
> > > I know your other series tries to remove the procfs dependency, but
> > > we're not there yet :-).
> > > 
> > 
> > Yeah, '/proc/self/exe' is a choice, if so, the 'has_proc' should be added ;-)
> 
> Currently procfs is a hard requirement. So I would leave 'has_proc' to
> the other series that may change this.
>

Yeah, but to be consistent with the already existing 'proc' condition
check, 'proc' will be used at first ;-)

    $ grep '(proc,' -ur tools/testing/selftests/nolibc/nolibc-test.c 
		CASE_TEST(chmod_net);         EXPECT_SYSZR(proc, chmod("/proc/self/net", 0555)); break;
		CASE_TEST(chmod_self);        EXPECT_SYSER(proc, chmod("/proc/self", 0555), -1, EPERM); break;
		CASE_TEST(chown_self);        EXPECT_SYSER(proc, chown("/proc/self", 0, 0), -1, EPERM); break;
		CASE_TEST(chroot_exe);        EXPECT_SYSER(proc, chroot("/proc/self/exe"), -1, ENOTDIR); break;
		CASE_TEST(link_cross);        EXPECT_SYSER(proc, link("/proc/self/net", "/blah"), -1, EXDEV); break;

Btw, for the /proc/self used in test_stat_timestamps, in the revision of the
'minimal' config support series, instead of using '/', a 'proc' should be added
like above test cases.

> > > Also does it make sense to pass a size parameter?
> > > Why not use either PAGE_SIZE or the real size of the binary from
> > > fstat().
> > > 
> > 
> > Ok, as the manpage of mmap shows:
> > 
> >        For mmap(), offset must be a multiple of the underlying huge page
> >        size.  The system automatically aligns length to be a multiple of
> >        the underlying huge page size.
> > 
> >        For munmap(), addr, and length must both be a multiple of the
> >        underlying huge page size.
> > 
> > perhaps we should do further tests:
> > 
> > * the real size/length
> > * even > the real size
> > * the PAGE_SIZE
> > * not aligned with PAGE_SIZE
> > 
> > If such tests are required, the 'size' and even 'offset' arguments could be
> > provided to cover different combination or we do such tests internally, then,
> > the arguments are not required.
> 
> I think task of nolibc-test is to test the code in nolibc itself.
> The custom mmap implementation is trivial and directly calls the
> syscall. These additionally proposed tests would effectively test the
> core kernels implementation of mmap() and not the code of nolibc.
> 
> Therefore I don't think they are necessary in nolibc-test and the
> functionality is hopefully already be tested in another testsuite.
>

Ok, it is reasonable.
 
> 
> Note:
> 
> Testing mmap is indeed useful to test the implementation of
> my_syscall6() by providing a bogus value in the 'offset' parameter.
> I think we do have such a testcase.
>

Ok, we can pass a valid offset (n*PAGE_SIZE) to mmap() in test_mmap_munmap() or
add a whole new mmap_offset test case with a PAGE_SIZE not aligned offset (such
as 1).

Thanks,
Zhangjin

> <snip>
> 
> Thomas

