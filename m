Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF2C73A93A
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 21:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjFVT4Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Jun 2023 15:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjFVT4Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Jun 2023 15:56:24 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDB2F1;
        Thu, 22 Jun 2023 12:56:22 -0700 (PDT)
Date:   Thu, 22 Jun 2023 21:56:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1687463780; bh=sjhMAnWC+WRXas1AobjF7bEqN7SCFpSlpfEgghDu3ZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lg4BaVBZWGV5eFXgYBMM7duPkZ4vK9SZ9Kd2MWai1NvPvpBmP4Akvz4cYcbP9gAkC
         f0ePQyBJPmsU1uy7aW8D9ivtVgAcbx0PvfqBqNS8rMSFcRao+HKEkc9mHi8xlwWPbk
         wFvNiz5HFpPmVzN12e749DBZHpK55liL57uZZZEQ=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, w@1wt.eu
Subject: Re: [PATCH v4 10/10] selftests/nolibc: add mmap and munmap test cases
Message-ID: <97fbbe17-b261-475c-8959-71cccaa5a2f5@t-8ch.de>
References: <bff82ea6-610b-4471-a28b-6c76c28604a6@t-8ch.de>
 <20230622193249.1190336-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622193249.1190336-1-falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On 2023-06-23 03:32:49+0800, Zhangjin Wu wrote:
> > On 2023-06-19 23:55:41+0800, Zhangjin Wu wrote:
> > > Three mmap/munmap related test cases are added:
> > > 
> > > - mmap(NULL, 0, PROT_READ, MAP_PRIVATE, 0, 0), MAP_FAILED, EINVAL)
> > > 
> > >   The length argument must be greater than 0, otherwise, fail with -EINVAL.
> > > 
> > > - munmap((void *)-1, 4*1024), -1, EINVAL)
> > > 
> > >   Invalid (void *)-1 address fail with -EINVAL.
> > > 
> > > - test_mmap_munmap(4*1024)
> > > 
> > >   It finds a init file, mmap() it and then munmap().
> > > 
> > > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > > ---
> > >  tools/testing/selftests/nolibc/nolibc-test.c | 31 ++++++++++++++++++++
> > >  1 file changed, 31 insertions(+)
> > > 
> > > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > > index 80ab29e2887c..f7c0ca72cb28 100644
> > > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > > @@ -592,6 +592,34 @@ static int test_stat_timestamps(void)
> > >  	return 0;
> > >  }
> > >  
> > > +int test_mmap_munmap(int size)
> > > +{
> > > +	char init_files[5][20] = {"/init", "/sbin/init", "/etc/init", "/bin/init", "/bin/sh"};
> > 
> > Why not /proc/1/exe or even /proc/self/exe?
> > 
> > I know your other series tries to remove the procfs dependency, but
> > we're not there yet :-).
> > 
> 
> Yeah, '/proc/self/exe' is a choice, if so, the 'has_proc' should be added ;-)

Currently procfs is a hard requirement. So I would leave 'has_proc' to
the other series that may change this.

> > Also does it make sense to pass a size parameter?
> > Why not use either PAGE_SIZE or the real size of the binary from
> > fstat().
> > 
> 
> Ok, as the manpage of mmap shows:
> 
>        For mmap(), offset must be a multiple of the underlying huge page
>        size.  The system automatically aligns length to be a multiple of
>        the underlying huge page size.
> 
>        For munmap(), addr, and length must both be a multiple of the
>        underlying huge page size.
> 
> perhaps we should do further tests:
> 
> * the real size/length
> * even > the real size
> * the PAGE_SIZE
> * not aligned with PAGE_SIZE
> 
> If such tests are required, the 'size' and even 'offset' arguments could be
> provided to cover different combination or we do such tests internally, then,
> the arguments are not required.

I think task of nolibc-test is to test the code in nolibc itself.
The custom mmap implementation is trivial and directly calls the
syscall. These additionally proposed tests would effectively test the
core kernels implementation of mmap() and not the code of nolibc.

Therefore I don't think they are necessary in nolibc-test and the
functionality is hopefully already be tested in another testsuite.


Note:

Testing mmap is indeed useful to test the implementation of
my_syscall6() by providing a bogus value in the 'offset' parameter.
I think we do have such a testcase.

<snip>

Thomas
