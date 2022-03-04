Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3B34CD60C
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 15:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbiCDONE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 09:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239861AbiCDOMv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 09:12:51 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD211BAF0E;
        Fri,  4 Mar 2022 06:12:03 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 224DQ4vw030810;
        Fri, 4 Mar 2022 14:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=pGmYGwb79apXudBWe4k2mRuaKzUVH0A8Evs3CZ+9Nhs=;
 b=Tj10yMLrKB85pP3n/RGMgzoJaBUhWQMfpVGEnOrgJjrK4iesVHS6Iea2tdMrb7Kqxj9P
 ku07n1fA9kIHfV7srCurdGdbgoTuWMSUn88mlNkf+cUfgBffDFx1yG01W8Mjawd7ARpu
 8x1qYENSa51pNRCD/6G1q3FNptl6OZzueE2YNc2djF+yKXiLO42wU8iDQ/ri+TzrCTjF
 YnXmz8fTcT6Bo3WG+kV5PvJWZIznmvgEowEThmJ1weM2mXeXjlMbE4tHez8wI9V1nc7q
 f57Z3k/PY9ZMtc1MMpcPoidXgosMoUCHdrL8aN705gj1gIAD/nDIzzqx6OZKdxuzIp9P 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ekgwgv73s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 14:12:02 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 224E5YbX012333;
        Fri, 4 Mar 2022 14:12:02 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ekgwgv72k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 14:12:01 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 224E7QO0004051;
        Fri, 4 Mar 2022 14:11:59 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3ek4k81nej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 14:11:59 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 224EBuGs52625702
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Mar 2022 14:11:56 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D01E42042;
        Fri,  4 Mar 2022 14:11:56 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F0BE42041;
        Fri,  4 Mar 2022 14:11:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.114.12.92])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Mar 2022 14:11:53 +0000 (GMT)
From:   Steffen Eiden <seiden@linux.ibm.com>
To:     linux-s390@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 4/4]  selftests: drivers/s390x: Add uvdevice  QUI tests
Date:   Fri,  4 Mar 2022 09:11:41 -0500
Message-Id: <20220304141141.32767-5-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220304141141.32767-1-seiden@linux.ibm.com>
References: <20220304141141.32767-1-seiden@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: s_IpDuoY74pg2aeZrn5jeNC6EYW4Zrdr
X-Proofpoint-ORIG-GUID: pgKV1ARvP8UgVWrTGqVt2G-3-wRewzHR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-04_06,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203040077
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add test variant to also verify that QUI-error paths
are working as intended.

  ./test-uv-device
  TAP version 13
  1..10
  # Starting 10 tests from 4 test cases.
  #  RUN           uvio_fixture.qui.fault_ioctl_arg ...
  #            OK  uvio_fixture.qui.fault_ioctl_arg
  ok 1 uvio_fixture.qui.fault_ioctl_arg
  #  RUN           uvio_fixture.qui.fault_uvio_arg ...
  #            OK  uvio_fixture.qui.fault_uvio_arg
  ok 2 uvio_fixture.qui.fault_uvio_arg
  #  RUN           uvio_fixture.qui.inval_ioctl_cb ...
  #            OK  uvio_fixture.qui.inval_ioctl_cb
  ok 3 uvio_fixture.qui.inval_ioctl_cb
  #  RUN           uvio_fixture.qui.inval_ioctl_cmd ...
  #            OK  uvio_fixture.qui.inval_ioctl_cmd
  ok 4 uvio_fixture.qui.inval_ioctl_cmd
  #  RUN           uvio_fixture.att.fault_ioctl_arg ...
  #            OK  uvio_fixture.att.fault_ioctl_arg
  ok 5 uvio_fixture.att.fault_ioctl_arg
  #  RUN           uvio_fixture.att.fault_uvio_arg ...
  #            OK  uvio_fixture.att.fault_uvio_arg
  ok 6 uvio_fixture.att.fault_uvio_arg
  #  RUN           uvio_fixture.att.inval_ioctl_cb ...
  #            OK  uvio_fixture.att.inval_ioctl_cb
  ok 7 uvio_fixture.att.inval_ioctl_cb
  #  RUN           uvio_fixture.att.inval_ioctl_cmd ...
  #            OK  uvio_fixture.att.inval_ioctl_cmd
  ok 8 uvio_fixture.att.inval_ioctl_cmd
  #  RUN           attest_fixture.att_inval_request ...
  #            OK  attest_fixture.att_inval_request
  ok 9 attest_fixture.att_inval_request
  #  RUN           attest_fixture.att_inval_addr ...
  #            OK  attest_fixture.att_inval_addr
  ok 10 attest_fixture.att_inval_addr
  # PASSED: 10 / 10 tests passed.
  # Totals: pass:10 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
---
 .../testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c b/tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c
index ea0cdc37b44f..44a6fbefc156 100644
--- a/tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c
+++ b/tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c
@@ -30,6 +30,11 @@ FIXTURE_VARIANT(uvio_fixture) {
 	uint32_t arg_size;
 };
 
+FIXTURE_VARIANT_ADD(uvio_fixture, qui) {
+	.ioctl_cmd = UVIO_IOCTL_QUI,
+	.arg_size = BUFFER_SIZE,
+};
+
 FIXTURE_VARIANT_ADD(uvio_fixture, att) {
 	.ioctl_cmd = UVIO_IOCTL_ATT,
 	.arg_size = sizeof(struct uvio_attest),
-- 
2.25.1

