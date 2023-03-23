Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802FD6C6B31
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 15:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjCWOip (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 10:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjCWOio (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 10:38:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408E8F761;
        Thu, 23 Mar 2023 07:38:42 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NDst7Q022802;
        Thu, 23 Mar 2023 14:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=IXIsVyXNsaX8Zhe1xixUD3AAM90mmMiDseUyMwxrIK0=;
 b=G4uAlKO1Zc3gMFT+mbWZ6ubywqeguEUYDa/PsHU4Wzt4ohL5IPWaXwxH98VBH5H4BKyn
 /msvuT5+J39GCU1+uBKaNYjWyxsI7uU7AaLNT2dYV/trBVbhmgUHzSpMzYfOsHnjXMvo
 0VYVB2OfVOeN8uaftkD2PHmIiyxs3vBhho1R40fehh6tFTCsqcOIIQlUsa2dInh0YwEo
 JZuZ6CHN46YE3BIw1C+hCIH1mcCy4PvKTe8lD8C521zqkuhHGSD9O25u5dyYRqw3/ifY
 hpau+/iAnmbvJYolcEOcvtJgApe0gmvl7GjgSZ67QG8PpITpOtpD5MgBTKXxBpJOUiup lA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pge77qvkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 14:38:39 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32N86sTg015074;
        Thu, 23 Mar 2023 14:38:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3pd4jffgre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 14:38:37 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32NEcYYr26215134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 14:38:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00CB52004E;
        Thu, 23 Mar 2023 14:38:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBCD620040;
        Thu, 23 Mar 2023 14:38:33 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.56])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 23 Mar 2023 14:38:33 +0000 (GMT)
Date:   Thu, 23 Mar 2023 15:38:03 +0100
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Nico Boehr <nrb@linux.ibm.com>
Cc:     borntraeger@linux.ibm.com, frankja@linux.ibm.com, shuah@kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 0/2] KVM: s390: CMMA migration selftest and small
 bugfix
Message-ID: <20230323153803.7ab4038d@p-imbrenda>
In-Reply-To: <20230208144827.131300-1-nrb@linux.ibm.com>
References: <20230208144827.131300-1-nrb@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AJ7R5Vo7w8VEQadRiEDXV-7xb8VxTfkq
X-Proofpoint-ORIG-GUID: AJ7R5Vo7w8VEQadRiEDXV-7xb8VxTfkq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 mlxlogscore=808
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230109
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed,  8 Feb 2023 15:48:25 +0100
Nico Boehr <nrb@linux.ibm.com> wrote:

> Add a new selftest for CMMA migration. Also fix a small issue found during
> development of the test.
> 
> Nico Boehr (2):
>   KVM: s390: selftests: add selftest for CMMA migration
>   KVM: s390: fix KVM_S390_GET_CMMA_BITS for GFNs in memslot holes
> 
>  arch/s390/kvm/kvm-s390.c                      |   4 +
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  tools/testing/selftests/kvm/s390x/cmma_test.c | 679 ++++++++++++++++++
>  3 files changed, 684 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/s390x/cmma_test.c
> 

the series looks good in general, but I would swap the order and have
the fix first, and the tests after
