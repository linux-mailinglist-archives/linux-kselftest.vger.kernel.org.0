Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A3E6FEF05
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 May 2023 11:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbjEKJmD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 05:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjEKJmC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 05:42:02 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9ED02D57;
        Thu, 11 May 2023 02:42:00 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34B9bYOu017280;
        Thu, 11 May 2023 09:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : content-transfer-encoding : in-reply-to : references : to :
 cc : from : subject : message-id : date; s=pp1;
 bh=zYNF1JsoxhfGG6A2/C8/R1+ymZFuPzeOg247+mvxvPg=;
 b=XON/fDQGWEtePusWKWnOsJ+nh/JaJZiKy9cAOJPjrP9oZR0a6ldyTBv5s4ja76NJd3+t
 KSG6F33CYqk69fZiMo08cfzIVJid8cI4csq90mk8eYLgw3Me9feLgClaKjIhokgwqHKg
 nGrNLcBX0oqDujT6u7rDUWnSixI67nAEYOPi782Vt7ogvRaXMuHl0Fu/R/eLcylMwyFf
 XkIu8Znhh/bQsbpLIyAEn3nBVbAmEfkTSVKq2TelMCMB3AuzqFIkfg6RjLKUdmEL833V
 uplIX4ZLusGkmpoqb49l+AIYlajvjRc5VztXD/G+KfIiqLy9X7rrv1O7Zpv3pyIKR2sQ uQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qgbxn1epe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 09:41:57 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34B5Gf3x025825;
        Thu, 11 May 2023 09:41:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qf896sk3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 09:41:55 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34B9fpF517105376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 May 2023 09:41:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6768620040;
        Thu, 11 May 2023 09:41:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A3C02004B;
        Thu, 11 May 2023 09:41:51 +0000 (GMT)
Received: from t14-nrb (unknown [9.179.31.89])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 11 May 2023 09:41:50 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230324145424.293889-1-nrb@linux.ibm.com>
References: <20230324145424.293889-1-nrb@linux.ibm.com>
To:     borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, shuah@kernel.org
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org
From:   Nico Boehr <nrb@linux.ibm.com>
Subject: Re: [PATCH v2 0/2] KVM: s390: CMMA migration selftest and small bugfix
Message-ID: <168379811019.9368.1588862499018469612@t14-nrb>
User-Agent: alot/0.8.1
Date:   Thu, 11 May 2023 11:41:50 +0200
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _H5XDelMlZe13zcYwmXe22bEYRe1F5lC
X-Proofpoint-GUID: _H5XDelMlZe13zcYwmXe22bEYRe1F5lC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-11_06,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=882 priorityscore=1501 clxscore=1011 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305110081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Quoting Nico Boehr (2023-03-24 15:54:22)
> v2:
> ---
> * swap order of patches (thanks Claudio)
> * add r-b
> * add comment why memslots are zeroed
>=20
> Add a new selftest for CMMA migration. Also fix a small issue found during
> development of the test.
>=20
> Nico Boehr (2):
>   KVM: s390: fix KVM_S390_GET_CMMA_BITS for GFNs in memslot holes
>   KVM: s390: selftests: add selftest for CMMA migration
>=20
>  arch/s390/kvm/kvm-s390.c                      |   4 +
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  tools/testing/selftests/kvm/s390x/cmma_test.c | 680 ++++++++++++++++++
>  3 files changed, 685 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/s390x/cmma_test.c
>=20
> --=20
> 2.39.1
>=20

Polite ping.
