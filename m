Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758401AF2DA
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Apr 2020 19:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgDRR0I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 18 Apr 2020 13:26:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46494 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgDRR0G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 18 Apr 2020 13:26:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03IHPocp016214;
        Sat, 18 Apr 2020 17:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=8KrJ/JRh4q1VXJvhPAIpwPjIhjwroyl2FF43PveML6I=;
 b=AOmyP6C8oWDNi5l/CoyTfkazqoakk5toheHi6EoXt7Z1/lOHPDliNJz6O6Y7UftMvuHg
 LB1O+I04Z5Gp+xiGHjJwYHftFt/+FQ43iWeZewL1MbEdRUGyoVXW02c4x8tY91YAyX4U
 fcairSM6SODbk+Nkx+lg59B6jt7B1/FRFul5rN+9yEkYINLqb6O5+jiuRpyCMkmNbZpO
 35n4T/T65sOSJar7E2xMu91beP+nTzaMOCthE8V5o96xjeKX3WOQuYG8BkJ2glYMB9td
 ELRgm5W0PvVN68E/3FflwPmer6a9diz8lb/iAOQaPrShjxP5Qqk3b4F9I5J2+4XQg6rq lg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 30fxkjrrwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Apr 2020 17:26:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03IHLMsG077591;
        Sat, 18 Apr 2020 17:26:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 30fqka2fdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Apr 2020 17:26:01 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03IHQ0mI015260;
        Sat, 18 Apr 2020 17:26:00 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 18 Apr 2020 10:26:00 -0700
Date:   Sat, 18 Apr 2020 20:25:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     brendanhiggins@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: [bug report] kunit: test: add support for test abort
Message-ID: <20200418172554.GA802865@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9595 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=705 adultscore=0
 spamscore=0 mlxscore=0 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=3 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004180146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9595 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 suspectscore=3 mlxlogscore=773 impostorscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004180146
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Brendan Higgins,

The patch 5f3e06208920: "kunit: test: add support for test abort"
from Sep 23, 2019, leads to the following static checker warning:

	lib/kunit/try-catch.c:93 kunit_try_catch_run()
	misplaced newline? '    # %s: Unknown error: %d

lib/kunit/try-catch.c
    58  void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
    59  {
    60          DECLARE_COMPLETION_ONSTACK(try_completion);
    61          struct kunit *test = try_catch->test;
    62          struct task_struct *task_struct;
    63          int exit_code, time_remaining;
    64  
    65          try_catch->context = context;
    66          try_catch->try_completion = &try_completion;
    67          try_catch->try_result = 0;
    68          task_struct = kthread_run(kunit_generic_run_threadfn_adapter,
    69                                    try_catch,
    70                                    "kunit_try_catch_thread");
    71          if (IS_ERR(task_struct)) {
    72                  try_catch->catch(try_catch->context);
    73                  return;
    74          }
    75  
    76          time_remaining = wait_for_completion_timeout(&try_completion,
    77                                                       kunit_test_timeout());
    78          if (time_remaining == 0) {
    79                  kunit_err(test, "try timed out\n");
                                                      ^^
The kunit_log() macro adds its own newline.  Most of the callers add
a newline.  It should be the callers add a newline because that's how
everything else works in the kernel.

The dev_printk() stuff will sometimes add a newline, but never a
duplicate newline.  In other words, it's slightly complicated.  But
basically the caller should add a newline.

    80                  try_catch->try_result = -ETIMEDOUT;
    81          }
    82  
    83          exit_code = try_catch->try_result;
    84  
    85          if (!exit_code)
    86                  return;
    87  
    88          if (exit_code == -EFAULT)
    89                  try_catch->try_result = 0;
    90          else if (exit_code == -EINTR)
    91                  kunit_err(test, "wake_up_process() was never called\n");
                                                                           ^^

    92          else if (exit_code)
    93                  kunit_err(test, "Unknown error: %d\n", exit_code);
                                                          ^^

    94  
    95          try_catch->catch(try_catch->context);
    96  }

regards,
dan carpenter
