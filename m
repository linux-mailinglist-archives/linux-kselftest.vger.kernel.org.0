Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBA45FDA25
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Oct 2022 15:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJMNQi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Oct 2022 09:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiJMNQh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Oct 2022 09:16:37 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AD218C95E;
        Thu, 13 Oct 2022 06:16:24 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29DCMTsE017581;
        Thu, 13 Oct 2022 13:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : content-transfer-encoding : in-reply-to : references :
 subject : from : cc : to : message-id : date; s=pp1;
 bh=/IoH2O+8HspMLhKR4/nnEiCM6aUa4OOPLI+va0X26xc=;
 b=rKEZJH6Ho/WAkBin6k2XIkWjlf8c+qZYJUy9pykOkvtGKdzU1r5x2/v9KWUHvTQ3wLsX
 cuEyZgbhZofjutKgz68xKCOnVRZrpPJohguGvIZiUBzXSLmosZbIdKbsRWv72AketlIU
 zcJ1WQGAPJwg4CnOpskK8QBIFRwZGR2e3Q7naus6qppQvLIaYYJaHJb3Mv1M27nuwLnt
 4AJ2721iP9n7H1TxH26MQLR4QWxOueyrNzYykf3FKxlzC6aLSo/0u899gVZOS4/E5VE3
 3PbjK7h5hCG1PrexjoXrYJax8R/sr3WhDEIpgRDmRePI0n9/LFD/82J1fdQEsk8TzV6z Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k6dc23qe5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 13:16:20 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29DBF2hc014313;
        Thu, 13 Oct 2022 13:16:20 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k6dc23qcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 13:16:19 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29DD5jgX029171;
        Thu, 13 Oct 2022 13:16:18 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 3k30u95s3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 13:16:18 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29DDGEQu63963460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Oct 2022 13:16:14 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAD9AAE04D;
        Thu, 13 Oct 2022 13:16:14 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B75EAE045;
        Thu, 13 Oct 2022 13:16:14 +0000 (GMT)
Received: from t14-nrb (unknown [9.171.21.117])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Oct 2022 13:16:14 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221012205609.2811294-9-scgl@linux.ibm.com>
References: <20221012205609.2811294-1-scgl@linux.ibm.com> <20221012205609.2811294-9-scgl@linux.ibm.com>
Subject: Re: [PATCH v2 8/9] KVM: s390: selftest: memop: Fix typo
From:   Nico Boehr <nrb@linux.ibm.com>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Message-ID: <166566697441.10648.294380065511135700@t14-nrb>
User-Agent: alot/0.8.1
Date:   Thu, 13 Oct 2022 15:16:14 +0200
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RJRAo3G8ur9wF_qQTS5MLdyGxp2SUXlk
X-Proofpoint-GUID: rNCGmJKpY5mE5dq11QyeS1cJVPVX1Swn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_08,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=729 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210130078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Quoting Janis Schoetterl-Glausch (2022-10-12 22:56:08)
> "acceeded" isn't a word, should be "exceeded".
>=20
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
