Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36326C4EC4
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Mar 2023 16:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjCVPAz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Mar 2023 11:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCVPAy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Mar 2023 11:00:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E444C2D;
        Wed, 22 Mar 2023 08:00:53 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ME7X9Q010935;
        Wed, 22 Mar 2023 15:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : content-transfer-encoding : in-reply-to : references : to :
 from : cc : subject : message-id : date; s=pp1;
 bh=hF3NAluAnMQZ2oeyZtISB4lnrTI0CdR1mvn1OQxdUvg=;
 b=Fvh+61dXOXzEpV5Zx/zWBw+sQd9HyAiN1TF0e53seo3Thk/ci8V0Jtaoius3kl7lzkL4
 vTdPJg5WYVHHex/ha4jMMzxuC20VX+XN9vGYkWLg25FJUc7A5tatM+sq+a9QEL2Y0HO9
 /tCowZ3Yu//xfC7dU3D+GIkW0qyEYZVl1q6xw/2fwsnComFjxNxINVeBg1kPR2eyZ+dL
 I0FWFl4SKYaT4aMzjLib7j0J8dssx8V23KqEE6REGTcywpiSXUANwpU01ZAItrgT/Rm/
 loEuzjnlYD7BveQhISEUvragJdWgcM2xRuQOEIYY30Bl4VTAC41CTHwPA4SwZXATnk3l jw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pg17dwarq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 15:00:50 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32M2C11I015419;
        Wed, 22 Mar 2023 15:00:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3pd4x6d278-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 15:00:47 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32MF0cPt64946556
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 15:00:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E450120043;
        Wed, 22 Mar 2023 15:00:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB40C20040;
        Wed, 22 Mar 2023 15:00:38 +0000 (GMT)
Received: from t14-nrb (unknown [9.152.224.93])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Mar 2023 15:00:38 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230208144827.131300-1-nrb@linux.ibm.com>
References: <20230208144827.131300-1-nrb@linux.ibm.com>
To:     borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, shuah@kernel.org
From:   Nico Boehr <nrb@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 0/2] KVM: s390: CMMA migration selftest and small bugfix
Message-ID: <167949723863.87786.17316594054151666220@t14-nrb>
User-Agent: alot/0.8.1
Date:   Wed, 22 Mar 2023 16:00:38 +0100
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ClnQXDn_P6v6oyOZxlw_CsDbL0-V0NSp
X-Proofpoint-GUID: ClnQXDn_P6v6oyOZxlw_CsDbL0-V0NSp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_11,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=727 phishscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 clxscore=1011 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303220106
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Quoting Nico Boehr (2023-02-08 15:48:25)
> Add a new selftest for CMMA migration. Also fix a small issue found during
> development of the test.
>=20
> Nico Boehr (2):
>   KVM: s390: selftests: add selftest for CMMA migration
>   KVM: s390: fix KVM_S390_GET_CMMA_BITS for GFNs in memslot holes
>=20
>  arch/s390/kvm/kvm-s390.c                      |   4 +
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  tools/testing/selftests/kvm/s390x/cmma_test.c | 679 ++++++++++++++++++
>  3 files changed, 684 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/s390x/cmma_test.c

Polite ping.
