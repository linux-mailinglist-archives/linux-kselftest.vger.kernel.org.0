Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7842AA0E7A
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2019 02:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbfH2ABq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Aug 2019 20:01:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726825AbfH2ABq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Aug 2019 20:01:46 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7SNvO7j148929
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2019 20:01:45 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2up3nm8723-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2019 20:01:45 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 29 Aug 2019 01:01:43 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 29 Aug 2019 01:01:40 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7T01dRp21168142
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Aug 2019 00:01:39 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D3F342042;
        Thu, 29 Aug 2019 00:01:39 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B61F34207D;
        Thu, 29 Aug 2019 00:01:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.129.156])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 29 Aug 2019 00:01:37 +0000 (GMT)
Subject: Re: [PATCH v1] sefltest/ima: support appended signatures (modsig)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Jessica Yu <jeyu@kernel.org>, Dave Young <dyoung@redhat.com>,
        shuah <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Wed, 28 Aug 2019 20:01:37 -0400
In-Reply-To: <87o908eu7l.fsf@morokweng.localdomain>
References: <1567005240-12912-1-git-send-email-zohar@linux.ibm.com>
         <87o908eu7l.fsf@morokweng.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19082900-0016-0000-0000-000002A41152
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082900-0017-0000-0000-0000330463C3
Message-Id: <1567036897.6115.94.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-28_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=797 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908280221
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2019-08-28 at 20:38 -0300, Thiago Jung Bauermann wrote:
> Hello Mimi,
> 
> Mimi Zohar <zohar@linux.ibm.com> writes:
> 
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
> 
> Thanks for doing this!

You're welcome.  This isn't in lieu of a proper regression test that
verifies the IMA measurement list template modsig and d-modsig data
fields.  That still needs to be written.

thanks,

Mimi

