Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1C208B236
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 10:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfHMIV4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 04:21:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbfHMIVz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 04:21:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D780A2063F;
        Tue, 13 Aug 2019 08:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565684514;
        bh=9Awm6tVnBeBOk3gkiRRTt+sYYPfHbq98Oz0l4SNxvKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fl8IGEyYwdVaVkq22pRkWfNEsRJaHHQ8SsZMEqF5XZcUQiqHW0XLrXtUJe5OAdjUu
         E1p+ZDq4eVuV/1r7guQM0d3tWlTx34yTnoc5NnW3QHBGPexHWwz8f5lVm+ZgpbvLVk
         0qoQqUDxbJX7dYm3ixFCfNeemaJ56tSCVrAY7920=
Date:   Tue, 13 Aug 2019 10:21:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Knut Omang <knut.omang@oracle.com>
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
        Theodore Ts'o <tytso@mit.edu>, Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC 06/19] ktf: A simple debugfs interface to test results
Message-ID: <20190813082152.GA17627@kroah.com>
References: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
 <ae6c38384e2338aa3cfb8a4e4dd1002833789253.1565676440.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae6c38384e2338aa3cfb8a4e4dd1002833789253.1565676440.git-series.knut.omang@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 13, 2019 at 08:09:21AM +0200, Knut Omang wrote:
> From: Alan Maguire <alan.maguire@oracle.com>
> 
> While test results is available via netlink from user space, sometimes
> it may be useful to be able to access the results from the kernel as well,
> for instance due to a crash. Make that possible via debugfs.
> 
> ktf_debugfs.h:   Support for creating a debugfs representation of test
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> ---
>  tools/testing/selftests/ktf/kernel/ktf_debugfs.c | 356 ++++++++++++++++-
>  tools/testing/selftests/ktf/kernel/ktf_debugfs.h |  34 ++-
>  2 files changed, 390 insertions(+)
>  create mode 100644 tools/testing/selftests/ktf/kernel/ktf_debugfs.c
>  create mode 100644 tools/testing/selftests/ktf/kernel/ktf_debugfs.h
> 
> diff --git a/tools/testing/selftests/ktf/kernel/ktf_debugfs.c b/tools/testing/selftests/ktf/kernel/ktf_debugfs.c
> new file mode 100644
> index 0000000..a20fbd2
> --- /dev/null
> +++ b/tools/testing/selftests/ktf/kernel/ktf_debugfs.c
> @@ -0,0 +1,356 @@
> +/*
> + * Copyright (c) 2009, 2017, Oracle and/or its affiliates. All rights reserved.
> + *    Author: Alan Maguire <alan.maguire@oracle.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0

Has to be the first line of the file, did you run this through
checkpatch?

> +static int ktf_run_test_open(struct inode *inode, struct file *file)
> +{
> +	struct ktf_test *t;
> +
> +	if (!try_module_get(THIS_MODULE))
> +		return -EIO;

This is an anti-pattern, and one guaranteed to not work properly.  NEVER
do this.

> +
> +	t = (struct ktf_test *)inode->i_private;
> +
> +	return single_open(file, ktf_debugfs_run, t);
> +}
> +
> +static int ktf_debugfs_release(struct inode *inode, struct file *file)
> +{
> +	module_put(THIS_MODULE);

Same here, not ok.


> +	return single_release(inode, file);
> +}
> +
> +static const struct file_operations ktf_run_test_fops = {
> +	.open = ktf_run_test_open,
> +	.read = seq_read,
> +	.llseek = seq_lseek,
> +	.release = ktf_debugfs_release,
> +};
> +
> +static int ktf_results_test_open(struct inode *inode, struct file *file)
> +{
> +	struct ktf_test *t;
> +
> +	if (!try_module_get(THIS_MODULE))
> +		return -EIO;

Nope!

And why -EIO?  That is not an io issue.

> +void ktf_debugfs_create_test(struct ktf_test *t)
> +{
> +	struct ktf_case *testset = ktf_case_find(t->tclass);
> +
> +	if (!testset)
> +		return;
> +
> +	memset(&t->debugfs, 0, sizeof(t->debugfs));
> +
> +	t->debugfs.debugfs_results_test =
> +		debugfs_create_file(t->name, S_IFREG | 0444,
> +				    testset->debugfs.debugfs_results_test,
> +				 t, &ktf_results_test_fops);
> +
> +	if (t->debugfs.debugfs_results_test) {

How can that variable ever be NULL (hint, it can not.)

> +		t->debugfs.debugfs_run_test =
> +			debugfs_create_file(t->name, S_IFREG | 0444,
> +					    testset->debugfs.debugfs_run_test,
> +				 t, &ktf_run_test_fops);
> +		if (!t->debugfs.debugfs_run_test) {
> +			_ktf_debugfs_destroy_test(t);
> +		} else {
> +			/* Take reference for test for debugfs */
> +			ktf_test_get(t);
> +		}
> +	}

Never test the result of any debugfs call, you do not need to.  Just
call it and move on, your code flow should NEVER be different with, or
without, a successful debugfs call.


> +static int ktf_run_testset_open(struct inode *inode, struct file *file)
> +{
> +	struct ktf_case *testset;
> +
> +	if (!try_module_get(THIS_MODULE))
> +		return -EIO;

Again no.  I hate to know what code you copied this all from, as that
code is very wrong.  Do you have a pointer to that code anywhere so we
can fix that up?

> +
> +	testset = (struct ktf_case *)inode->i_private;
> +
> +	return single_open(file, ktf_debugfs_run_all, testset);
> +}
> +
> +static const struct file_operations ktf_run_testset_fops = {
> +	.open = ktf_run_testset_open,
> +	.read = seq_read,
> +	.llseek = seq_lseek,
> +	.release = ktf_debugfs_release,

If you really care about module references you should be setting the
owner of the module here.

> +};
> +
> +static void _ktf_debugfs_destroy_testset(struct ktf_case *testset)
> +{
> +	debugfs_remove(testset->debugfs.debugfs_run_testset);
> +	debugfs_remove(testset->debugfs.debugfs_run_test);
> +	debugfs_remove(testset->debugfs.debugfs_results_testset);
> +	debugfs_remove(testset->debugfs.debugfs_results_test);

Why not just recursivly remove the directory?  That way you do not have
to keep track of any individual files.


> +}
> +
> +void ktf_debugfs_create_testset(struct ktf_case *testset)
> +{
> +	char tests_subdir[KTF_DEBUGFS_NAMESZ];
> +	const char *name = ktf_case_name(testset);
> +
> +	memset(&testset->debugfs, 0, sizeof(testset->debugfs));
> +
> +	/* First add /sys/kernel/debug/ktf/[results|run]/<testset> */
> +	testset->debugfs.debugfs_results_testset =
> +		debugfs_create_file(name, S_IFREG | 0444,
> +				    ktf_debugfs_resultsdir,
> +				 testset, &ktf_results_testset_fops);
> +	if (!testset->debugfs.debugfs_results_testset)
> +		goto err;

Again, can never happen, and again, do not do different things depending
on the result of a debugfs call.

> +
> +	testset->debugfs.debugfs_run_testset =
> +		debugfs_create_file(name, S_IFREG | 0444,
> +				    ktf_debugfs_rundir,
> +				    testset, &ktf_run_testset_fops);
> +	if (!testset->debugfs.debugfs_run_testset)
> +		goto err;

Again, nope.

> +
> +	/* Now add parent directories for individual test result/run tests
> +	 * which live in
> +	 * /sys/kernel/debug/ktf/[results|run]/<testset>-tests/<testname>
> +	 */
> +	(void)snprintf(tests_subdir, sizeof(tests_subdir), "%s%s",
> +			name, KTF_DEBUGFS_TESTS_SUFFIX);

why (void)?


> +
> +	testset->debugfs.debugfs_results_test =
> +		debugfs_create_dir(tests_subdir, ktf_debugfs_resultsdir);
> +	if (!testset->debugfs.debugfs_results_test)
> +		goto err;

nope :)

> +
> +	testset->debugfs.debugfs_run_test =
> +		debugfs_create_dir(tests_subdir, ktf_debugfs_rundir);
> +	if (!testset->debugfs.debugfs_run_test)
> +		goto err;

Nope :)

> +
> +	/* Take reference count for testset.  One will do as we will always
> +	 * free testset debugfs resources together.
> +	 */
> +	ktf_case_get(testset);
> +	return;
> +err:
> +	_ktf_debugfs_destroy_testset(testset);
> +}
> +
> +void ktf_debugfs_destroy_testset(struct ktf_case *testset)
> +{
> +	tlog(T_DEBUG, "Destroying debugfs testset %s", ktf_case_name(testset));
> +	_ktf_debugfs_destroy_testset(testset);
> +	/* Remove our debugfs reference cout to testset */
> +	ktf_case_put(testset);
> +}
> +
> +/* /sys/kernel/debug/ktf/coverage shows coverage statistics. */
> +static int ktf_debugfs_cov(struct seq_file *seq, void *v)
> +{
> +	ktf_cov_seq_print(seq);
> +
> +	return 0;
> +}
> +
> +static int ktf_cov_open(struct inode *inode, struct file *file)
> +{
> +	if (!try_module_get(THIS_MODULE))
> +		return -EIO;

{sigh}  I'll stop reviewing now :)

thanks,

greg k-h
