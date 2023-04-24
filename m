Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138046ECB11
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Apr 2023 13:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjDXLKf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Apr 2023 07:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjDXLKY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Apr 2023 07:10:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B19D358C;
        Mon, 24 Apr 2023 04:10:13 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OAR9Oo001016;
        Mon, 24 Apr 2023 11:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=8hPFfdVQwoiFN6Qn44U3psCF9HoNZt/Gws7mwbEAWJU=;
 b=l+MDyEmFIGNWikjCT1J2wuSlMyQcr0iCtsOIabI2jr9BhMd5IcPz5Sp6xYOCJXV49ZjV
 AY9zKeekZLkCJUKUo6jaRmleKmvLOQpIMFQrx8jTPKixXegNcxogZO5VHH8Dn1N1dWet
 zW5Jm9ykubXsCf1li7g7YeZLpHOzrUgNC8r/UqX5IvHxcDFCtnirjkn97Tt+9kQgW//3
 sTut7LEgsTB5H5fmN7Ae3vNQ8zmvu8d5Y9OA8gxHnEpAQEb0mBNriA3tBE7PissDv6eg
 gEWrgv84plnHrNOA31l6QTwVg66Pt3wyHLo+NLxeTs0sRVMKKK3cG4Uvo9vCx7fO1lTi Nw== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q48jkqvua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 11:10:03 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33O4vmVX007076;
        Mon, 24 Apr 2023 11:10:00 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3q47770vu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 11:10:00 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33OB9wEc8127156
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Apr 2023 11:09:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F90220043;
        Mon, 24 Apr 2023 11:09:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC4FC2004D;
        Mon, 24 Apr 2023 11:09:57 +0000 (GMT)
Received: from localhost (unknown [9.43.54.88])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 24 Apr 2023 11:09:57 +0000 (GMT)
Date:   Mon, 24 Apr 2023 16:39:56 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH v2 0/2] selftests/ftrace: Add tests for kprobes and
 optimized probes
To:     Akanksha J N <akanksha@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, shuah@kernel.org
References: <20230418095557.19061-1-akanksha@linux.ibm.com>
In-Reply-To: <20230418095557.19061-1-akanksha@linux.ibm.com>
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1682334408.u49nhd1gk9.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dJXrY_vZ2fqyep9r8yIEL06CgfzaDFhj
X-Proofpoint-GUID: dJXrY_vZ2fqyep9r8yIEL06CgfzaDFhj
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_07,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=594
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304240100
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Akanksha J N wrote:
> This patchset adds a stress test for kprobes and a test for checking
> optimized probes.
> The two tests are being added based on the below discussion:
> https://lore.kernel.org/all/20230128101622.ce6f8e64d929e29d36b08b73@kerne=
l.org/
>=20
> Changelog:
>=20
>=20
> * Add an explicit fork after enabling the events ( echo "forked" )
> * Remove the extended test from multiple_kprobe_types.tc which adds=20
>   multiple consecutive probes in a function and add it as a=20
>   separate test case.=20
> * Add new test case which checks for optimized probes.
>=20
> Akanksha J N (2):
>   selftests/ftrace: Add new test case which adds multiple consecutive
>     probes in a function
>   selftests/ftrace: Add new test case which checks for optimized probes
>=20
>  .../test.d/kprobe/kprobe_insn_boundary.tc     | 19 +++++++++++
>  .../ftrace/test.d/kprobe/kprobe_opt_types.tc  | 34 +++++++++++++++++++
>  2 files changed, 53 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_i=
nsn_boundary.tc
>  create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_o=
pt_types.tc

This series looks good to me.
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>



- Naveen

