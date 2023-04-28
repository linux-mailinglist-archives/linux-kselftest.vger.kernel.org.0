Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4BA6F1BAB
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Apr 2023 17:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346478AbjD1PfL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Apr 2023 11:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346516AbjD1PfD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Apr 2023 11:35:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804C32106;
        Fri, 28 Apr 2023 08:35:01 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SF3uAa001576;
        Fri, 28 Apr 2023 15:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=TqPJawlS8vnHqAAbbtgbBvah7H60ySgm+W383xPXe28=;
 b=hJJAI2pM6HMeh/ykHNTzF3kgcfcNFv1eYCHQxS4EeP49omgsq4EjSuXo2M1tEzC0gGM0
 AnqS4YBqdlg1qz+LYcnl0gymPgUztP6b7J6tAenuVlvPMH+L4azUptO8UjJcSGoFLp9v
 2dkChFKOdTsumJonQISXC9sGSEeZ8CM8QGuHlROxg6ds2tjZDkg0kjwrRFG9Ca3diq7Q
 bnMTsSZMFtidI+IU9JHaUP4bitvvPL+yMU2uwTNZRVkoro8Qg9sBQ9XJJMZ7/6eTbluF
 UCfluQwaECGd7rTCxuapT317GDVJdUuy27zGBw4RNsNCQ9w+rEdxhuwEwPu2/Urcs7cC pw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47md6rcp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 15:34:54 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33SE3UFc028277;
        Fri, 28 Apr 2023 15:34:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q461b4rmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 15:34:53 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33SFYqUA028134;
        Fri, 28 Apr 2023 15:34:52 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-188-60.vpn.oracle.com [10.175.188.60])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q461b4rm0-1;
        Fri, 28 Apr 2023 15:34:52 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     corbet@lwn.net, shuah@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 tracing 0/6] tracing: additional filter predicates
Date:   Fri, 28 Apr 2023 16:34:43 +0100
Message-Id: <1682696089-27937-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304280125
X-Proofpoint-GUID: 8rp1Tm198pK-pEjxQs267h97MnabH-RY
X-Proofpoint-ORIG-GUID: 8rp1Tm198pK-pEjxQs267h97MnabH-RY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For cases like IPv6 addresses, having a means to supply tracing
predicates for fields with more than 8 bytes would be convenient.
This series provides a simple way to support this by allowing
simple ==, != memory comparison with the predicate supplied when
the size of the field exceeds 8 bytes.  For example, to trace
::1, the predicate

        "dst == 0x00000000000000000000000000000001"

..could be used.  Patch 1 implements this.

As a convenience, support for IPv4, IPv6 and MAC addresses are
also included; patches 2-4 cover these and allow simpler
comparisons which do not require getting the exact number of
bytes right; for exmaple

	"dst == ::1"
	"src != 127.0.0.1"
	"mac_addr == ab:cd:ef:01:23:45"

Patch 5 adds tests for existing and new filter predicates, and patch 6
documents the fact that for the various addresses supported and
the >8 byte memory comparison. only == and != are supported.

Changes since v1 [1]:

- added support for IPv4, IPv6 and MAC addresses (patches 2-4)
  (Masami and Steven)
- added selftests for IPv4, IPv6 and MAC addresses and updated
  docs accordingly (patches 5,6)

Changes since RFC [2]:

- originally a fix was intermixed with the new functionality as
  patch 1 in series [2]; the fix landed separately
- small tweaks to how filter predicates are defined via fn_num as
  opposed to via fn directly

[1] https://lore.kernel.org/linux-trace-kernel/1682414197-13173-1-git-send-email-alan.maguire@oracle.com/
[22] https://lore.kernel.org/lkml/1659910883-18223-1-git-send-email-alan.maguire@oracle.com/

Alan Maguire (6):
  tracing: support > 8 byte array filter predicates
  tracing: support IPv4 address filter predicate
  tracing: support IPv6 filter predicates
  tracing: support MAC address filter predicates
  selftests/ftrace: add test coverage for filter predicates
  tracing: document IPv4, IPv6, MAC address and > 8 byte numeric
    filtering support

 Documentation/trace/events.rst                |  21 +++
 kernel/trace/trace_events_filter.c            | 164 +++++++++++++++++-
 .../selftests/ftrace/test.d/event/filter.tc   |  91 ++++++++++
 3 files changed, 275 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/event/filter.tc

-- 
2.31.1

