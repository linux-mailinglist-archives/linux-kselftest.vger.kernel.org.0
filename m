Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F301F6FC0FD
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 May 2023 09:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbjEIHz1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 May 2023 03:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbjEIHzF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 May 2023 03:55:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78049E73F;
        Tue,  9 May 2023 00:54:22 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3497nn7l011032;
        Tue, 9 May 2023 07:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=21jTc8EXdIgaMQA0GKQNXnqo0ZOJ/DL4CkaLETzPvOs=;
 b=Zws004RkSOv50uu79xH0GPxhhof2RILfEHezzEuxdBB3mkbUDlyiunHIKqxJ0nXjcBma
 nYV5Wd+TRzCRLtCN+9qqOQHbefc2iq/dsY2bQAzRUSiQy8SUIpKR04WSiv4T8i0oD8IZ
 TxGVE9UzQxDg188yzfTOCIx3iGme0RiFdoADg8lHAtVML222fjMPCWJvdyBO9WklYfdG
 4tXBaUZlP972Yo1lRA7NAWPH+IS8hcwpdfrZQHQBpni2nHKjBp+JN4psfVe5xscpy/dM
 jvu30FNw5q5CIg3WbodSJB49gK1YphbGUjx3gBKvvUF9eg+17NEVdmKTX66OnbarDzAg Gg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qfgpxuc76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 07:53:51 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3492j2jL021669;
        Tue, 9 May 2023 07:53:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qf7nh08wx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 07:53:49 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3497rlqm43647646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 May 2023 07:53:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 014E220043;
        Tue,  9 May 2023 07:53:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D75CD20040;
        Tue,  9 May 2023 07:53:46 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  9 May 2023 07:53:46 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] tools/nolibc: s390: provide custom implementation
 for sys_fork
References: <20230415-nolibc-fork-v1-0-9747c73651c5@weissschuh.net>
        <20230415-nolibc-fork-v1-1-9747c73651c5@weissschuh.net>
Date:   Tue, 09 May 2023 09:53:46 +0200
In-Reply-To: <20230415-nolibc-fork-v1-1-9747c73651c5@weissschuh.net>
 ("Thomas
        =?utf-8?Q?Wei=C3=9Fschuh=22's?= message of "Sat, 15 Apr 2023 23:28:47
 +0200")
Message-ID: <yt9do7mudjp1.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FAF2NT-sDNc5FCT5KZKfbDNtm_EzrTcr
X-Proofpoint-ORIG-GUID: FAF2NT-sDNc5FCT5KZKfbDNtm_EzrTcr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 impostorscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=549
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305090059
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thomas Wei=C3=9Fschuh <linux@weissschuh.net> writes:

> On s390 the first two arguments to the clone() syscall are swapped,
> as documented in clone(2).
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>  tools/include/nolibc/arch-s390.h | 8 ++++++++
>  tools/include/nolibc/sys.h       | 2 ++
>  2 files changed, 10 insertions(+)

Acked-by: Sven Schnelle <svens@linux.ibm.com>
