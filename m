Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D40564216B
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2019 11:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437698AbfFLJwf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jun 2019 05:52:35 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45746 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437415AbfFLJwf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jun 2019 05:52:35 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5C9moqK019223;
        Wed, 12 Jun 2019 09:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=STg2Q8ZuP7oBqkte3BSzEJpgTKkKhODjX0seniz7kug=;
 b=0P+QvAkabB6QwtJcg4f71T41CGmDnrVHZDvmmTvR/Ud2Xe/jgwqcSXD182ot7Y9b2Pxf
 dnbSA+i0FKNGxrgLmzwYBTilBiInzBEyGfOmmv8DMmNpz4XzDSYkJ3HB+2zXMaKjpAKN
 SuPSTzyewRaG7RuhzQ9fY3AnpstTrqkmlH4WPvUYu/yKaq3nJ0CI0LfulTfAsXU7O+i0
 OcomSS4pNB08AURqm2TsPraY7By96a8xlV5e1ySCxb/a3X+BQxxEBP2xVNZ23ISWuwjR
 SDfRSNVsvsrsMhyrul8qLmZjTS179nNu2ej4QLmyhqwjG24aBHQSsKVBlGh4vkMm1Dqk xw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2t02hetgfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 09:52:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5C9ot7r080153;
        Wed, 12 Jun 2019 09:52:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2t04hyue4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 09:52:32 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5C9qVZY009746;
        Wed, 12 Jun 2019 09:52:31 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Jun 2019 02:52:31 -0700
Date:   Wed, 12 Jun 2019 12:52:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     joel@joelfernandes.org
Cc:     linux-kselftest@vger.kernel.org
Subject: [bug report] pidfd: add polling selftests
Message-ID: <20190612095225.GA14303@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=885
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906120067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=926 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906120068
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Joel Fernandes (Google),

The patch 233ad92edbea: "pidfd: add polling selftests" from Apr 30,
2019, leads to the following static checker warning:

	./tools/testing/selftests/pidfd/pidfd_test.c:522 test_pidfd_poll_leader_exit()
	error: uninitialized symbol 'ret'.

./tools/testing/selftests/pidfd/pidfd_test.c
   485  static void test_pidfd_poll_leader_exit(int use_waitpid)
   486  {
   487          int pid, pidfd = 0;
   488          int status, ret;
   489          time_t prog_start = time(NULL);
   490          const char *test_name = "pidfd_poll check for premature notification on non-empty"
   491                                  "group leader exit";
   492  
   493          child_exit_secs = mmap(NULL, sizeof *child_exit_secs, PROT_READ | PROT_WRITE,
   494                          MAP_SHARED | MAP_ANONYMOUS, -1, 0);
   495  
   496          if (child_exit_secs == MAP_FAILED)
   497                  ksft_exit_fail_msg("%s test: mmap failed (errno %d)\n",
   498                                     test_name, errno);
   499  
   500          ksft_print_msg("Parent: pid: %d\n", getpid());
   501          pid = pidfd_clone(CLONE_PIDFD, &pidfd, child_poll_leader_exit_test);
   502          if (pid < 0)
   503                  ksft_exit_fail_msg("%s test: pidfd_clone failed (ret %d, errno %d)\n",
   504                                     test_name, pid, errno);
   505  
   506          ksft_print_msg("Parent: Waiting for Child (%d) to complete.\n", pid);
   507  
   508          if (use_waitpid) {
   509                  ret = waitpid(pid, &status, 0);
   510                  if (ret == -1)
   511                          ksft_print_msg("Parent: error\n");
   512          } else {
   513                  /*
   514                   * This sleep tests for the case where if the child exits, and is in
   515                   * EXIT_ZOMBIE, but the thread group leader is non-empty, then the poll
   516                   * doesn't prematurely return even though there are active threads
   517                   */
   518                  sleep(1);
   519                  poll_pidfd(test_name, pidfd);

"ret" is not initialized on this path.

   520          }
   521  
   522          if (ret == pid)
                    ^^^
   523                  ksft_print_msg("Parent: Child process waited for.\n");
   524  
   525          time_t since_child_exit = time(NULL) - *child_exit_secs;
   526  
   527          ksft_print_msg("Time since child exit: %lu\n", since_child_exit);

regards,
dan carpenter
