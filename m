Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7143715CDA
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 13:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjE3LSH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 07:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjE3LSG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 07:18:06 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D45B0;
        Tue, 30 May 2023 04:18:03 -0700 (PDT)
X-QQ-mid: bizesmtp69t1685445474t3vd91jk
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 May 2023 19:17:53 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: rZJGTgY0+YO42EliYbWrQYWGNgKZOfXEKsGvnSlMHd2cAkAzcp4YFeJPsIZBU
        71DWcf1qi8lHwUTiAzzmiaNRz90Js9jdIUW2B36Eoq42HFPUGr061h7dPSa+Jl7S56WJdAH
        +z4B/uI2ZzRfOD16kuuVqj0hsqe82IGm+RrDlxmqkxMqUtRAZ2Cbp/IgyzkvrG4n2aw/Le3
        F/zy85a1qsGhtmxmqSCkR5aWR2nXWH4DRT88MmhT3Pwe/VF2JhpUn/j0g7GEbggdo5ufWbo
        FwPrxKcuWH1rBNaxmX2viRu9MHD4VmpLcXj+KoSXXr/qbcy8fOopse8ujCD1ZwHAXE2QIhe
        DHVkHCdyiGc3EwBTeV3H+8BAaIoCsjGYcaqBvlxYjP2WxvTnBnSIBL00YHNrJ6KjLEJSytk
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1363702751823665213
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        w@1wt.eu
Subject: Re: [PATCH 2/2] selftests/nolibc: add sizeof test for the new 64bit data types
Date:   Tue, 30 May 2023 19:17:53 +0800
Message-Id: <20230530111753.403722-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <c68a6f60-0906-408a-9454-419085df695e@t-8ch.de>
References: <c68a6f60-0906-408a-9454-419085df695e@t-8ch.de>
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

> On 2023-05-30 14:42:56+0800, Zhangjin Wu wrote:
> > These test cases are required to make sure the new added data types are
> > really 64bit based.
> > 
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/testing/selftests/nolibc/nolibc-test.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > index 20d184da9a2b..43ce4d34b596 100644
> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > @@ -721,6 +721,14 @@ int run_stdlib(int min, int max)
> >  #else
> >  # warning "__SIZEOF_LONG__ is undefined"
> >  #endif /* __SIZEOF_LONG__ */
> > +		CASE_TEST(sizeof_time_t);           EXPECT_EQ(1, 8,                sizeof(time_t)); break;
> > +		CASE_TEST(sizeof_timespec);         EXPECT_EQ(1, 16,               sizeof(struct timespec)); break;
> > +#ifdef NOLIBC
> > +		CASE_TEST(sizeof_itimerspec);       EXPECT_EQ(1, 32,               sizeof(struct itimerspec)); break;
> > +#endif
> > +		CASE_TEST(sizeof_timeval);          EXPECT_EQ(1, 16,               sizeof(struct timeval)); break;
> > +		CASE_TEST(sizeof_itimerval);        EXPECT_EQ(1, 32,               sizeof(struct itimerval)); break;
> > +		CASE_TEST(sizeof_off_t);            EXPECT_EQ(1, 8,                sizeof(off_t)); break;
> 
> These will break on 32bit glibc configurations.
> (At least on x86)

Yes, I added a big #ifdef at first, but narrowed it down after a default
x86_64 gcc+glibc test, 32bit has been ignored from my mind ;-(

Will add the big #ifdef back.

Thanks,
Zhangjin

> 
> >  		case __LINE__:
> >  			return ret; /* must be last */
> >  		/* note: do not set any defaults so as to permit holes above */
> > -- 
