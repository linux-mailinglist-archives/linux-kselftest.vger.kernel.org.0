Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF7F67C59C
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jan 2023 09:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbjAZITz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Jan 2023 03:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbjAZITw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Jan 2023 03:19:52 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830D067796;
        Thu, 26 Jan 2023 00:19:51 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30Q7UoDZ027942;
        Thu, 26 Jan 2023 08:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=w1SKFIv5r6+TuNq7lmTQSD7DtViWx/NFlXNfIRbezzo=;
 b=RxX3QlNPoS5I7JhEsvY3heKqGgwG5H4gL0BlYM53ZiXqpczx6PWIcP97ROD9kH7qGRLM
 P7hWL/jJD8UdzrnW0ZEsKbzutUNBauCWBL6UPwJ6nSxoZstrKXz3/jv1t9gYkNvkVDN/
 B3LxxCXuRIWFZOMnXx8fVdUf3jWTL5V4ZcKHQtEDzq3CBvbo5TknZg+n4dh+ys4KrL2H
 27+Nz9n6zOdloj/0PZn5dGkbhFnkZHE4dzSoMrRMQuAW3Fvk9QG1yxKh8Yda6kX/YOCp
 6S7pOxj9wfryWsBt0AdKHbafj1wqjYUJ/cjtkrZ5NVTrilxQFbSfe5NeMYhlEAO6ZETE qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nbhkad9k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 08:19:42 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30Q807HM007694;
        Thu, 26 Jan 2023 08:19:41 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nbhkad9j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 08:19:41 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PMixBj004576;
        Thu, 26 Jan 2023 08:19:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3n87afcerc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 08:19:38 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30Q8JZ9749938688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 08:19:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2127120040;
        Thu, 26 Jan 2023 08:19:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BC232004B;
        Thu, 26 Jan 2023 08:19:34 +0000 (GMT)
Received: from osiris (unknown [9.152.212.250])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 26 Jan 2023 08:19:34 +0000 (GMT)
Date:   Thu, 26 Jan 2023 09:19:34 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>
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
Subject: Re: [PATCH v6 12/14] KVM: s390: Extend MEM_OP ioctl by storage key
 checked cmpxchg
Message-ID: <Y9I3liGZJhNtt1N5@osiris>
References: <20230125212608.1860251-1-scgl@linux.ibm.com>
 <20230125212608.1860251-13-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125212608.1860251-13-scgl@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VgjH7YKl424iAO4clPGJBQUw0OfmbI4s
X-Proofpoint-ORIG-GUID: mlOscjtaWAVu1lk_0oQDdr1ahSrT9QAw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_02,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=511
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260076
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 25, 2023 at 10:26:06PM +0100, Janis Schoetterl-Glausch wrote:
> User space can use the MEM_OP ioctl to make storage key checked reads
> and writes to the guest, however, it has no way of performing atomic,
> key checked, accesses to the guest.
> Extend the MEM_OP ioctl in order to allow for this, by adding a cmpxchg
> op. For now, support this op for absolute accesses only.
> 
> This op can be use, for example, to set the device-state-change
> indicator and the adapter-local-summary indicator atomically.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>  include/uapi/linux/kvm.h |   8 +++
>  arch/s390/kvm/gaccess.h  |   3 ++
>  arch/s390/kvm/gaccess.c  | 103 +++++++++++++++++++++++++++++++++++++++
>  arch/s390/kvm/kvm-s390.c |  56 ++++++++++++++++++++-
>  4 files changed, 169 insertions(+), 1 deletion(-)
...
> +		ret = cmpxchg_user_key((u8 *)hva, &old, *old_addr, new, access_key);

FWIW, this and the three others need a __user annotation:

		ret = cmpxchg_user_key((u8 __user *)hva, &old, *old_addr, new, access_key);

Otherwise you end up with sparse warnings (compile with C=1).
