Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAD7A06E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2019 18:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfH1QF1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Aug 2019 12:05:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44534 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726560AbfH1QF1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Aug 2019 12:05:27 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7SG2bbU021478
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2019 12:05:26 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2unvsng4pe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2019 12:05:26 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 28 Aug 2019 16:55:21 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 28 Aug 2019 16:55:19 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7SFsuJp38339040
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 15:54:56 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19B194C040;
        Wed, 28 Aug 2019 15:55:18 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB5384C04E;
        Wed, 28 Aug 2019 15:55:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.129.156])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Aug 2019 15:55:16 +0000 (GMT)
Subject: Re: [PATCH v1] sefltest/ima: support appended signatures (modsig)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     shuah <shuah@kernel.org>, linux-integrity@vger.kernel.org
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Petr Vorel <pvorel@suse.cz>, Jessica Yu <jeyu@kernel.org>,
        Dave Young <dyoung@redhat.com>,
        linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 28 Aug 2019 11:55:16 -0400
In-Reply-To: <4a9f9cd3-c550-98e4-1513-14ef161c34c2@kernel.org>
References: <1567005240-12912-1-git-send-email-zohar@linux.ibm.com>
         <4a9f9cd3-c550-98e4-1513-14ef161c34c2@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19082815-0008-0000-0000-0000030E4D8A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082815-0009-0000-0000-00004A2C8E74
Message-Id: <1567007716.6115.59.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-28_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=933 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908280163
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2019-08-28 at 09:53 -0600, shuah wrote:
> On 8/28/19 9:14 AM, Mimi Zohar wrote:
> > In addition to the PE/COFF and IMA xattr signatures, the kexec kernel
> > image can be signed with an appended signature, using the same
> > scripts/sign-file tool that is used to sign kernel modules.
> > 
> > This patch adds support for detecting a kernel image signed with an
> > appended signature and updates the existing test messages
> > appropriately.
> > 
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> 
> Thanks Mimi. This commit log looks good. My Ack for the patch
> to go through the IMA tree.
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Thanks!

Mimi

