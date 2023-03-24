Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C88E6C7ED2
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 14:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjCXNcQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 09:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjCXNcO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 09:32:14 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3520168BF;
        Fri, 24 Mar 2023 06:32:13 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OBowWp022248;
        Fri, 24 Mar 2023 13:32:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : content-transfer-encoding : in-reply-to : references : cc :
 from : to : subject : message-id : date; s=pp1;
 bh=3n1rsXTibXnEfD9qh/gOx5M6CCslQNR9yINjVuayrqM=;
 b=kX8buOadvNZvLmE0rs4EKsKWUXd128kcbE0BzR0J/S1a9RZ6lyDFMnBe4+gJLPzCx7ae
 dqReWpzfb/8zYQ69XvOTejnN+U9ZiDUwnbTrTFoABN6KTRmeCvK083K50GCQK9TrFxcB
 LILBw+DuL6+ieL+LLPQ+Z6IKx7JNxH6S5WMbyVSfeedkgJe9o0/1E4Svz/zIRxoLBM7v
 w3PZJFSe4pQ1x/qAPn9TDcv0yseBw68UpCh34Lb6ewm/Ljrhy3vqiWwgT+OrBT8VzMRx
 KzdsDxHbIl/Nkc75wzSFuzKKDbm7SN0mhyYfb2bsVD9zYkRV6qBRYvs8WO9NbwDwQiyF 4A== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3phbbrafrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 13:32:09 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32NLd6Kn016251;
        Fri, 24 Mar 2023 13:32:08 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3pgxv8gr0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 13:32:07 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ODW4sV13632000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Mar 2023 13:32:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3553C20043;
        Fri, 24 Mar 2023 13:32:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E9D320040;
        Fri, 24 Mar 2023 13:32:04 +0000 (GMT)
Received: from t14-nrb (unknown [9.179.14.197])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 24 Mar 2023 13:32:03 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230323153803.7ab4038d@p-imbrenda>
References: <20230208144827.131300-1-nrb@linux.ibm.com> <20230323153803.7ab4038d@p-imbrenda>
Cc:     borntraeger@linux.ibm.com, frankja@linux.ibm.com, shuah@kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org
From:   Nico Boehr <nrb@linux.ibm.com>
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v1 0/2] KVM: s390: CMMA migration selftest and small bugfix
Message-ID: <167966472370.41638.7744836812709181552@t14-nrb>
User-Agent: alot/0.8.1
Date:   Fri, 24 Mar 2023 14:32:03 +0100
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NmGJJqg16ZIg9Lx6nCGVwuOc18lmMXj5
X-Proofpoint-GUID: NmGJJqg16ZIg9Lx6nCGVwuOc18lmMXj5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_08,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=757 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303240106
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Quoting Claudio Imbrenda (2023-03-23 15:38:03)
> On Wed,  8 Feb 2023 15:48:25 +0100
> Nico Boehr <nrb@linux.ibm.com> wrote:
>=20
> > Add a new selftest for CMMA migration. Also fix a small issue found dur=
ing
> > development of the test.
> >=20
> > Nico Boehr (2):
> >   KVM: s390: selftests: add selftest for CMMA migration
> >   KVM: s390: fix KVM_S390_GET_CMMA_BITS for GFNs in memslot holes
> >=20
> >  arch/s390/kvm/kvm-s390.c                      |   4 +
> >  tools/testing/selftests/kvm/Makefile          |   1 +
> >  tools/testing/selftests/kvm/s390x/cmma_test.c | 679 ++++++++++++++++++
> >  3 files changed, 684 insertions(+)
> >  create mode 100644 tools/testing/selftests/kvm/s390x/cmma_test.c
> >=20
>=20
> the series looks good in general, but I would swap the order and have
> the fix first, and the tests after

Sure can swap the order in v2.
