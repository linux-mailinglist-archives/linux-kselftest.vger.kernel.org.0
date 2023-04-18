Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CB46E5E16
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 11:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjDRJ56 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 05:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDRJ5t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 05:57:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FDC6A4E;
        Tue, 18 Apr 2023 02:57:15 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I9IdI4013108;
        Tue, 18 Apr 2023 09:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=J+p+gfyJJ6nBJWE8WFIjO7GLXingCOBL/XNRh1TDLiM=;
 b=YfLEphrlrYnCsndIAGwBGrjg0NSns+Lt20CtPiH6xnolP6LHsQYEffq9kUH9oiw6DASG
 RTF6kBKJBkFmeJds8zKSk903fEG9eMieTq34TbiBFE0fKFXNlrOrjHd9a3qZkYHdY8yE
 QKp73s/po/9gfWP2PRfZ39RYZrcAY2K5cO5QqI9PITe1d88nI/qOyeZL3mJO7M3xLxNv
 FlapPeOcGnJSX6uaxBi2zNYuCXDm+TqaTUmuI0t1oiZZLpmlYdLjh7IMlPNmYowPmOd/
 Eot62+4NzEtJUEiafK7BDqkvEADQvDTLrHXZ2gRi5Nzn7xs28Oqcr0X8mDhCkduyRAoJ qQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q1pkw4mfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:56:11 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33GJaDJp018133;
        Tue, 18 Apr 2023 09:56:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3pykj6hk51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:56:08 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33I9u4x28651434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 09:56:04 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8D2320040;
        Tue, 18 Apr 2023 09:56:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35B0B20043;
        Tue, 18 Apr 2023 09:56:03 +0000 (GMT)
Received: from li-ed75614c-32e0-11b2-a85c-ba2953069b43.in.ibm.com (unknown [9.109.209.37])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 18 Apr 2023 09:56:03 +0000 (GMT)
From:   Akanksha J N <akanksha@linux.ibm.com>
To:     linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, shuah@kernel.org,
        naveen.n.rao@linux.ibm.com, akanksha@linux.ibm.com
Subject: [PATCH v2 0/2] selftests/ftrace: Add tests for kprobes and optimized probes 
Date:   Tue, 18 Apr 2023 15:25:55 +0530
Message-Id: <20230418095557.19061-1-akanksha@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2pHQchKEUpiOx0TtXCxwwv9iAlaOSlrB
X-Proofpoint-ORIG-GUID: 2pHQchKEUpiOx0TtXCxwwv9iAlaOSlrB
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_05,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=563 bulkscore=0 mlxscore=0 spamscore=0
 impostorscore=0 malwarescore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180082
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patchset adds a stress test for kprobes and a test for checking
optimized probes.
The two tests are being added based on the below discussion:
https://lore.kernel.org/all/20230128101622.ce6f8e64d929e29d36b08b73@kernel.org/

Changelog:


* Add an explicit fork after enabling the events ( echo "forked" )
* Remove the extended test from multiple_kprobe_types.tc which adds 
  multiple consecutive probes in a function and add it as a 
  separate test case. 
* Add new test case which checks for optimized probes.

Akanksha J N (2):
  selftests/ftrace: Add new test case which adds multiple consecutive
    probes in a function
  selftests/ftrace: Add new test case which checks for optimized probes

 .../test.d/kprobe/kprobe_insn_boundary.tc     | 19 +++++++++++
 .../ftrace/test.d/kprobe/kprobe_opt_types.tc  | 34 +++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_insn_boundary.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc

-- 
2.31.1

