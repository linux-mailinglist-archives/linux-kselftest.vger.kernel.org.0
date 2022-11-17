Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A6962D54B
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Nov 2022 09:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239677AbiKQIno (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Nov 2022 03:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239680AbiKQInU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Nov 2022 03:43:20 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBE8748FA;
        Thu, 17 Nov 2022 00:43:00 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AH84Fct015795;
        Thu, 17 Nov 2022 08:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : content-transfer-encoding : in-reply-to : references : to :
 subject : cc : from : message-id : date; s=pp1;
 bh=kVu+7X+SrSJ0orR2t6fwIpIPKWWxtROvgCwe8G7gS+o=;
 b=VFga4VflYY1yBrasKX/8V5gWCqTlUk67f8XIqBMqYOFGZbKyYvmmq7R18N5FzBXJyH8o
 nlZ8UaW1Dpjr8e62+P2BQwgzJb5VZa5dIDsHXcMapxJFWYkcEMDitjQWrM97T42V3077
 EeLHIDAnO/9Yc/jUqDxHZUrvMrqyKeqwpTA/jeP/khw//HivZZwypvntjnEZmqZpwkT7
 DOGKKW44sqtrkosElEWPO5TY8kR7UsY4IE85BkOO9fJ2oO5/2tB3AsR/skyghnNJb4Mx
 3641KxK4mofDk4COjFn51lo2D3uQIzoh19CzmYY5CFxeAgcixi3nGwAtDYJhkikuyJpV 9g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kwh4bs3yp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 08:42:52 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AH84wLd017582;
        Thu, 17 Nov 2022 08:42:51 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kwh4bs3xk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 08:42:51 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AH8Yjpl012734;
        Thu, 17 Nov 2022 08:42:49 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3kt348y925-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 08:42:48 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AH8hP5751970464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 08:43:25 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0C25A405B;
        Thu, 17 Nov 2022 08:42:45 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72CFFA4054;
        Thu, 17 Nov 2022 08:42:45 +0000 (GMT)
Received: from t14-nrb (unknown [9.171.65.30])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Nov 2022 08:42:45 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8708073bdd4c90dbc25ee3711afc59585bc0d740.camel@linux.ibm.com>
References: <20221012205609.2811294-1-scgl@linux.ibm.com> <20221012205609.2811294-2-scgl@linux.ibm.com> <Y2J61LWSV+HolIeT@osiris> <8708073bdd4c90dbc25ee3711afc59585bc0d740.camel@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Subject: Re: [PATCH v2 1/9] s390/uaccess: Add storage key checked cmpxchg access to user space
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
From:   Nico Boehr <nrb@linux.ibm.com>
Message-ID: <166867456298.12564.8456237098002804507@t14-nrb.local>
User-Agent: alot/0.8.1
Date:   Thu, 17 Nov 2022 09:42:43 +0100
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RRV_ZocSW71LnlEzr-UF6SRK2rAVMgre
X-Proofpoint-GUID: tV18gdyHXIQG-md5aQOwiuQ2KbDVylNb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_04,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211170064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Quoting Janis Schoetterl-Glausch (2022-11-16 20:36:46)
> On Wed, 2022-11-02 at 15:12 +0100, Heiko Carstens wrote:
> >=20
> [...]
>=20
> > I also did not limit the number of retries for the one and two byte
> > scenarion. Before doing that we need to have proof that there really is=
 a
> > problem. Maybe Nico or you will give this a try.
>=20
> I wrote a memop selftest testcase where the main thread uses the one byte=
 cmpxchg
> while n vcpus flip adjacent bits. The time the test case runs increases s=
uperlinearly with n.
> With 248 vcpus, 1000 one byte cmpxchgs take 25s.
> I'm not sure how meaningful the test is since the worst case would be if =
the threads hammering
> the word would run on a cpu dedicated to them.
>=20
> In any case, why not err on the side of caution and limit the iterations?
> I'll send an rfc patch.

I agree, limiting sounds like the safe choice.
