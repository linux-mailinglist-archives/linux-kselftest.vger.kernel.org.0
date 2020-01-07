Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C553132853
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2020 15:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgAGOB0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jan 2020 09:01:26 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33790 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbgAGOBZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jan 2020 09:01:25 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 007Di967122841;
        Tue, 7 Jan 2020 14:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=LKUBemU6FsVp0N8ztTeBVUASyvI64fguo+7yxurR9H0=;
 b=BiorenIt8K0fpfJk3aeJZ+xqig61OjKlyShd9klSmmLEupa9IvMM/sW2epjzF6nGn+UJ
 WZqRWXLLg67u0Pqn2a9IyNiAMVWPWzd6fijSs4Q7wBCAdkGzyCf1iZE21RFsmvfVo8/U
 4DF1xqBWgL3qGYuCSYN79lssbvbJtVcUw0H6/eOzCja6hZL7N0ZVjUVB7GuoE2W3QGVg
 siX+2Nlqx5IBpbR+W6hhn2wFM5gBQbquGFqXgKlPLN6efE0SdGtFY8pWecjI64cbLlaE
 1Do+fn01F/UNy0s36bV8CukG9ZqH6fsKXfvFUVlTTPX8zI8sG0Ox7aOOPRwdmWrOQf23 Kw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xajnpwm7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 14:01:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 007Di5Zb114157;
        Tue, 7 Jan 2020 14:01:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2xcpamjyj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 14:01:22 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 007E1LGG014686;
        Tue, 7 Jan 2020 14:01:21 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Jan 2020 06:01:18 -0800
Date:   Tue, 7 Jan 2020 17:01:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kees Cook <keescook@chromium.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     linux-kselftest@vger.kernel.org
Subject: [bug report] selftests/tls: add a test for fragmented messages
Message-ID: <20200107140106.ejj4zgeiu4fauatn@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=993
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001070115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001070115
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello self test developers,

I feel like I reported this years ago but I forget what is going on
here?

The patch 65190f77424d: "selftests/tls: add a test for fragmented
messages" from Nov 27, 2019, leads to the following static checker
warning:

	tools/testing/selftests/net/tls.c:292 tls_sendmsg_fragmented()
	warn: curly braces intended?

tools/testing/selftests/net/tls.c
   299  TEST_F(tls, sendmsg_large)
   300  {
   301          void *mem = malloc(16384);
   302          size_t send_len = 16384;
   303          size_t sends = 128;
   304          struct msghdr msg;
   305          size_t recvs = 0;
   306          size_t sent = 0;
   307  
   308          memset(&msg, 0, sizeof(struct msghdr));
   309          while (sent++ < sends) {
   310                  struct iovec vec = { (void *)mem, send_len };
   311  
   312                  msg.msg_iov = &vec;
   313                  msg.msg_iovlen = 1;
   314                  EXPECT_EQ(sendmsg(self->cfd, &msg, 0), send_len);
   315          }
   316  
   317          while (recvs++ < sends)
   318                  EXPECT_NE(recv(self->fd, mem, send_len, 0), -1);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is a macro (below).

   319  
   320          free(mem);
   321  }

tools/testing/selftests/kselftest_harness.h
   592  /* Support an optional handler after and ASSERT_* or EXPECT_*.  The approach is
   593   * not thread-safe, but it should be fine in most sane test scenarios.
   594   *
   595   * Using __bail(), which optionally abort()s, is the easiest way to early
   596   * return while still providing an optional block to the API consumer.
   597   */
   598  #define OPTIONAL_HANDLER(_assert) \
   599          for (; _metadata->trigger; _metadata->trigger = \
   600                          __bail(_assert, _metadata->no_print, _metadata->step))
   601  
   602  #define __INC_STEP(_metadata) \
   603          if (_metadata->passed && _metadata->step < 255) \
   604                  _metadata->step++;
   605  
   606  #define __EXPECT(_expected, _expected_str, _seen, _seen_str, _t, _assert) do { \
   607          /* Avoid multiple evaluation of the cases */ \
   608          __typeof__(_expected) __exp = (_expected); \
   609          __typeof__(_seen) __seen = (_seen); \
   610          if (_assert) __INC_STEP(_metadata); \
   611          if (!(__exp _t __seen)) { \
   612                  unsigned long long __exp_print = (uintptr_t)__exp; \
   613                  unsigned long long __seen_print = (uintptr_t)__seen; \
   614                  __TH_LOG("Expected %s (%llu) %s %s (%llu)", \
   615                           _expected_str, __exp_print, #_t, \
   616                           _seen_str, __seen_print); \
   617                  _metadata->passed = 0; \
   618                  /* Ensure the optional handler is triggered */ \
   619                  _metadata->trigger = 1; \
   620          } \
   621  } while (0); OPTIONAL_HANDLER(_assert)
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The problem is the OPTIONAL_HANDLER().  Smatch thinks it should be
included inside the do {} while(0) loop.

regards,
dan carpenter
