Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD178DA6B
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2019 19:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbfHNRRs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Aug 2019 13:17:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52006 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730902AbfHNRRr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Aug 2019 13:17:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7EGs4T6046794;
        Wed, 14 Aug 2019 17:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2019-08-05;
 bh=v+67tp2xg4CxzjejgnDU4HMesl0ZP9hJ06uNB6nago8=;
 b=IbcJEzM8nLKTbJFdykTbb9vXk+vCG+0PG2TtlObANAeGc+8AfW8bQbeNUNUeUKoL1ExW
 jD5Z9tqzJd9cDsLBSbpCDbTVKN0Uj7tp/1UKawD35/KZp/zZ3X9ALQsZhElQQwO0LfFS
 euUBivJqjzhT6Vxou7w4Xud3HaO0fLTfO5UTpqp5olTqFcKjL6UYxW4juq0x+LxMTFVa
 V0aHxe8jEEUTachDIAWExjk/gWZJoaqogbwNlyzcaxj3RJXp5ZZZFo380CDBuH6ccnrv
 tcp5scqVhcbD3fC37j5SgaIvN8dsXIDmE5aEcTA5MESl9EjfbA4MsVIf6KuqDnlLqjvw /g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2u9pjqp2dr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 17:17:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7EGrCLk048616;
        Wed, 14 Aug 2019 17:17:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2ubwcy9swm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 17:17:18 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7EHHCkZ000361;
        Wed, 14 Aug 2019 17:17:12 GMT
Received: from asu (/92.220.18.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Aug 2019 10:17:12 -0700
Message-ID: <a63bea757e02656a38463cc794da7da15273dd16.camel@oracle.com>
Subject: Re: [RFC 06/19] ktf: A simple debugfs interface to test results
From:   Knut Omang <knut.omang@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Shreyans Devendra Doshi <0xinfosect0r@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Hidenori Yamaji <hidenori.yamaji@sony.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Timothy Bird <Tim.Bird@sony.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Wed, 14 Aug 2019 19:17:07 +0200
In-Reply-To: <20190813082152.GA17627@kroah.com>
References: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
         <ae6c38384e2338aa3cfb8a4e4dd1002833789253.1565676440.git-series.knut.omang@oracle.com>
         <20190813082152.GA17627@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908140158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908140158
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2019-08-13 at 10:21 +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 13, 2019 at 08:09:21AM +0200, Knut Omang wrote:
> > From: Alan Maguire <alan.maguire@oracle.com>
> > 
> > While test results is available via netlink from user space, sometimes
> > it may be useful to be able to access the results from the kernel as well,
> > for instance due to a crash. Make that possible via debugfs.
> > 
> > ktf_debugfs.h:   Support for creating a debugfs representation of test
> > 
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > Signed-off-by: Knut Omang <knut.omang@oracle.com>
> > ---
> >  tools/testing/selftests/ktf/kernel/ktf_debugfs.c | 356 ++++++++++++++++-
> >  tools/testing/selftests/ktf/kernel/ktf_debugfs.h |  34 ++-
> >  2 files changed, 390 insertions(+)
> >  create mode 100644 tools/testing/selftests/ktf/kernel/ktf_debugfs.c
> >  create mode 100644 tools/testing/selftests/ktf/kernel/ktf_debugfs.h
> > 
> > diff --git a/tools/testing/selftests/ktf/kernel/ktf_debugfs.c b/tools/testing/selftests/ktf/kernel/ktf_debugfs.c
> > new file mode 100644
> > index 0000000..a20fbd2
> > --- /dev/null
> > +++ b/tools/testing/selftests/ktf/kernel/ktf_debugfs.c
> > @@ -0,0 +1,356 @@
> > +/*
> > + * Copyright (c) 2009, 2017, Oracle and/or its affiliates. All rights reserved.
> > + *    Author: Alan Maguire <alan.maguire@oracle.com>
> > + *
> > + * SPDX-License-Identifier: GPL-2.0
> 
> Has to be the first line of the file, did you run this through
> checkpatch?

Yes, the code has been subject to continuous integration which uses 
a version of my runchecks tool (https://lkml.org/lkml/2018/1/19/157)
to ensure that it is not possible to "forget" to run checkpatch 
(or sparse, smatch doc.check for that sake)

Ironically though I fell victim to my own tooling here,
as I postponed fixing the SPDX_LICENSE_TAG class of issues 
once that test appeared, while working on something else, 
and just forgot to re-enable it again..

> > +static int ktf_run_test_open(struct inode *inode, struct file *file)
> > +{
> > +	struct ktf_test *t;
> > +
> > +	if (!try_module_get(THIS_MODULE))
> > +		return -EIO;
> 
> This is an anti-pattern, and one guaranteed to not work properly.  NEVER
> do this.

Sorry, I didn't know this, and the origin is probably my responsibility.

I know the feeling of never being able to get rid of bad examples 
because they keep getting copied..

The pattern seemed to be widely used the first time I saw it, and although 
somewhat awkward, it seemed to be the standard way then, but as you know, 
my Infiniband driver (
https://github.com/oracle/linux-uek/blob/uek4/qu7/drivers/infiniband/hw/sif/sif_debug.c)
unfortunately never made it to the scrutiny of LKML, since the hardware project 
got cancelled.
The -EIO return value was also copied from merged kernel code back then.

I notice the discussion and your response here: 
http://linux-kernel.2935.n7.nabble.com/debugfs-and-module-unloading-td865175.html
I assume that means that protection against module unload while a debugfs file
is open is now safe.

On older kernels, having this code in place is far better than an unprotected 
debugfs entry/exit - I have tested it extensively in the past :-)

Back when I first used it, I had this cool set of polymorphic 
debugfs file code to list the set of active MRs, CQs, QPs, AHs etc 
that the whole infiniband driver, database and hardware teams loved 
so much that multiple users ended up using it in multiple windows 
from within watch for live observations of state changes, 
and often also running driver load/unloads for testing purposes.

I perfectly agree with you that reducing the hole for a race condition 
is generally a bad idea, but from the above mail thread 
it seems that's the only available choice for older kernels?

(I am asking because I still want to be able to support rather 
old kernels with the github version of KTF)

Anyway, great to know that a better solution now exists!

We'll fix the rest of the issues below as well for the next version..

Thanks!
Knut

> > +
> > +	t = (struct ktf_test *)inode->i_private;
> > +
> > +	return single_open(file, ktf_debugfs_run, t);
> > +}
> > +
> > +static int ktf_debugfs_release(struct inode *inode, struct file *file)
> > +{
> > +	module_put(THIS_MODULE);
> 
> Same here, not ok.
> 
> 
> > +	return single_release(inode, file);
> > +}
> > +
> > +static const struct file_operations ktf_run_test_fops = {
> > +	.open = ktf_run_test_open,
> > +	.read = seq_read,
> > +	.llseek = seq_lseek,
> > +	.release = ktf_debugfs_release,
> > +};
> > +
> > +static int ktf_results_test_open(struct inode *inode, struct file *file)
> > +{
> > +	struct ktf_test *t;
> > +
> > +	if (!try_module_get(THIS_MODULE))
> > +		return -EIO;
> 
> Nope!
> 
> And why -EIO?  That is not an io issue.

Agreed
> 
> > +void ktf_debugfs_create_test(struct ktf_test *t)
> > +{
> > +	struct ktf_case *testset = ktf_case_find(t->tclass);
> > +
> > +	if (!testset)
> > +		return;
> > +
> > +	memset(&t->debugfs, 0, sizeof(t->debugfs));
> > +
> > +	t->debugfs.debugfs_results_test =
> > +		debugfs_create_file(t->name, S_IFREG | 0444,
> > +				    testset->debugfs.debugfs_results_test,
> > +				 t, &ktf_results_test_fops);
> > +
> > +	if (t->debugfs.debugfs_results_test) {
> 
> How can that variable ever be NULL (hint, it can not.)
> 
> > +		t->debugfs.debugfs_run_test =
> > +			debugfs_create_file(t->name, S_IFREG | 0444,
> > +					    testset->debugfs.debugfs_run_test,
> > +				 t, &ktf_run_test_fops);
> > +		if (!t->debugfs.debugfs_run_test) {
> > +			_ktf_debugfs_destroy_test(t);
> > +		} else {
> > +			/* Take reference for test for debugfs */
> > +			ktf_test_get(t);
> > +		}
> > +	}
> 
> Never test the result of any debugfs call, you do not need to.  Just
> call it and move on, your code flow should NEVER be different with, or
> without, a successful debugfs call.
> 
> 
> > +static int ktf_run_testset_open(struct inode *inode, struct file *file)
> > +{
> > +	struct ktf_case *testset;
> > +
> > +	if (!try_module_get(THIS_MODULE))
> > +		return -EIO;
> 
> Again no.  I hate to know what code you copied this all from, as that
> code is very wrong.  Do you have a pointer to that code anywhere so we
> can fix that up?
> 
> > +
> > +	testset = (struct ktf_case *)inode->i_private;
> > +
> > +	return single_open(file, ktf_debugfs_run_all, testset);
> > +}
> > +
> > +static const struct file_operations ktf_run_testset_fops = {
> > +	.open = ktf_run_testset_open,
> > +	.read = seq_read,
> > +	.llseek = seq_lseek,
> > +	.release = ktf_debugfs_release,
> 
> If you really care about module references you should be setting the
> owner of the module here.
> 
> > +};
> > +
> > +static void _ktf_debugfs_destroy_testset(struct ktf_case *testset)
> > +{
> > +	debugfs_remove(testset->debugfs.debugfs_run_testset);
> > +	debugfs_remove(testset->debugfs.debugfs_run_test);
> > +	debugfs_remove(testset->debugfs.debugfs_results_testset);
> > +	debugfs_remove(testset->debugfs.debugfs_results_test);
> 
> Why not just recursivly remove the directory?  That way you do not have
> to keep track of any individual files.
> 
> 
> > +}
> > +
> > +void ktf_debugfs_create_testset(struct ktf_case *testset)
> > +{
> > +	char tests_subdir[KTF_DEBUGFS_NAMESZ];
> > +	const char *name = ktf_case_name(testset);
> > +
> > +	memset(&testset->debugfs, 0, sizeof(testset->debugfs));
> > +
> > +	/* First add /sys/kernel/debug/ktf/[results|run]/<testset> */
> > +	testset->debugfs.debugfs_results_testset =
> > +		debugfs_create_file(name, S_IFREG | 0444,
> > +				    ktf_debugfs_resultsdir,
> > +				 testset, &ktf_results_testset_fops);
> > +	if (!testset->debugfs.debugfs_results_testset)
> > +		goto err;
> 
> Again, can never happen, and again, do not do different things depending
> on the result of a debugfs call.
> 
> > +
> > +	testset->debugfs.debugfs_run_testset =
> > +		debugfs_create_file(name, S_IFREG | 0444,
> > +				    ktf_debugfs_rundir,
> > +				    testset, &ktf_run_testset_fops);
> > +	if (!testset->debugfs.debugfs_run_testset)
> > +		goto err;
> 
> Again, nope.
> 
> > +
> > +	/* Now add parent directories for individual test result/run tests
> > +	 * which live in
> > +	 * /sys/kernel/debug/ktf/[results|run]/<testset>-tests/<testname>
> > +	 */
> > +	(void)snprintf(tests_subdir, sizeof(tests_subdir), "%s%s",
> > +			name, KTF_DEBUGFS_TESTS_SUFFIX);
> 
> why (void)?
> 
> 
> > +
> > +	testset->debugfs.debugfs_results_test =
> > +		debugfs_create_dir(tests_subdir, ktf_debugfs_resultsdir);
> > +	if (!testset->debugfs.debugfs_results_test)
> > +		goto err;
> 
> nope :)
> 
> > +
> > +	testset->debugfs.debugfs_run_test =
> > +		debugfs_create_dir(tests_subdir, ktf_debugfs_rundir);
> > +	if (!testset->debugfs.debugfs_run_test)
> > +		goto err;
> 
> Nope :)
> 
> > +
> > +	/* Take reference count for testset.  One will do as we will always
> > +	 * free testset debugfs resources together.
> > +	 */
> > +	ktf_case_get(testset);
> > +	return;
> > +err:
> > +	_ktf_debugfs_destroy_testset(testset);
> > +}
> > +
> > +void ktf_debugfs_destroy_testset(struct ktf_case *testset)
> > +{
> > +	tlog(T_DEBUG, "Destroying debugfs testset %s", ktf_case_name(testset));
> > +	_ktf_debugfs_destroy_testset(testset);
> > +	/* Remove our debugfs reference cout to testset */
> > +	ktf_case_put(testset);
> > +}
> > +
> > +/* /sys/kernel/debug/ktf/coverage shows coverage statistics. */
> > +static int ktf_debugfs_cov(struct seq_file *seq, void *v)
> > +{
> > +	ktf_cov_seq_print(seq);
> > +
> > +	return 0;
> > +}
> > +
> > +static int ktf_cov_open(struct inode *inode, struct file *file)
> > +{
> > +	if (!try_module_get(THIS_MODULE))
> > +		return -EIO;
> 
> {sigh}  I'll stop reviewing now :)


> 
> thanks,
> 
> greg k-h




