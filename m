Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AB76EDEE9
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Apr 2023 11:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbjDYJQu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Apr 2023 05:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjDYJQu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Apr 2023 05:16:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE7D1990;
        Tue, 25 Apr 2023 02:16:48 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33P0hubY031057;
        Tue, 25 Apr 2023 09:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=Iwmnk6jemfDA0DsukXRfx0JJvZc9lihQgqmhxRnNZys=;
 b=M0PTmqi877pQHTATqTSa56VT01zFtPJeom+dJ23/l13uM971UE+tTumhtzOnYscu+f6K
 BfttEa4eTx9oTQUks1jT8sMDRHESQgmMyjqL7A1qql8/oAxnQO5XiyXqmn/rXIlfeZZD
 bsQI6OwS66Wyizem5ZpHNNow5J+PVwmLYtwajFRgDdXB0ZxIX9JF/JTfmT7v76c1lhji
 wlSmfCWfiRAIisN+mjp/8ZZBLt4bY9oz2wXsgT1REfHbzZegkP+VzYF+chWl+6JodIRz
 JWZKFPi2BKvk6Oz3us9qNuK5E2TFCy6Vy9TuNRC0Z85+59WIsu0molkBWz4jVOKCE3t8 jg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47mcvw50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 09:16:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33P812Bx024915;
        Tue, 25 Apr 2023 09:16:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q461cdwbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 09:16:41 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33P93LCP024482;
        Tue, 25 Apr 2023 09:16:41 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-181-126.vpn.oracle.com [10.175.181.126])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3q461cdwa1-1;
        Tue, 25 Apr 2023 09:16:40 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     corbet@lwn.net, shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH tracing 0/3] tracing: support > 8 byte filter predicates
Date:   Tue, 25 Apr 2023 10:16:34 +0100
Message-Id: <1682414197-13173-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_03,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250082
X-Proofpoint-GUID: H9pAMddPxafTDDtF7HRUPqL9esPPsQqF
X-Proofpoint-ORIG-GUID: H9pAMddPxafTDDtF7HRUPqL9esPPsQqF
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

..could be used.

Patch 1 provides the support for > 8 byte fields via a memcmp()-style
predicate.  Patch 2 adds tests for filter predicates, and patch 3
documents the fact that for > 8 bytes. only == and != are supported.

Changes since RFC [1]:

- originally a fix was intermixed with the new functionality as
  patch 1 in series [1]; the fix landed separately
- small tweaks to how filter predicates are defined via fn_num as
  opposed to via fn directly

[1] https://lore.kernel.org/lkml/1659910883-18223-1-git-send-email-alan.maguire@oracle.com/

Alan Maguire (3):
  tracing: support > 8 byte array filter predicates
  selftests/ftrace: add test coverage for filter predicates
  tracing: document > 8 byte numeric filtering support

 Documentation/trace/events.rst                |  9 +++
 kernel/trace/trace_events_filter.c            | 55 +++++++++++++++-
 .../selftests/ftrace/test.d/event/filter.tc   | 62 +++++++++++++++++++
 3 files changed, 125 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/event/filter.tc

-- 
2.31.1

