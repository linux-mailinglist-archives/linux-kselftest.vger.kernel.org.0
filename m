Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA94E7A67
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2019 21:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfJ1UpX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Oct 2019 16:45:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22088 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725791AbfJ1UpX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Oct 2019 16:45:23 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9SKaY2h070923
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2019 16:45:21 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vx7h4088j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2019 16:45:21 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 28 Oct 2019 20:45:19 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 28 Oct 2019 20:45:16 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9SKjF4125428188
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Oct 2019 20:45:15 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 525B34C040;
        Mon, 28 Oct 2019 20:45:15 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53C814C046;
        Mon, 28 Oct 2019 20:45:14 +0000 (GMT)
Received: from dhcp-9-31-103-196.watson.ibm.com (unknown [9.31.103.196])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 28 Oct 2019 20:45:14 +0000 (GMT)
Subject: Re: [PATCH v1] selftest/trustedkeys: TPM 1.2 trusted keys test
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     David Howells <dhowells@redhat.com>, Petr Vorel <pvorel@suse.cz>,
        shuah <shuah@kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 28 Oct 2019 16:45:13 -0400
In-Reply-To: <20191028203014.GA8279@linux.intel.com>
References: <1571944467-13097-1-git-send-email-zohar@linux.ibm.com>
         <20191028203014.GA8279@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19102820-0028-0000-0000-000003B07F8B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102820-0029-0000-0000-00002472BDE2
Message-Id: <1572295513.4532.270.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910280195
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 2019-10-28 at 22:30 +0200, Jarkko Sakkinen wrote:
> On Thu, Oct 24, 2019 at 03:14:27PM -0400, Mimi Zohar wrote:
> > Create, save and load trusted keys test
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > 
> > Change log v1:
> > - Replace the directions for using Trousers to take ownership of the TPM
> > with directions for using the IBM TSS.
> > - Differentiate between different types of errors.  Recent bug is causing
> > "add_key: Timer expired".
> > ---
> 
> Is not really usable as a selftest because of 3rd party dependencies.

As part of diagnosing trusted keys failure, there is some
hints/directions as to how to take TPM 1.2 ownership, but it does not
take ownership.  The previous version included directions for using
Trousers.  This version provides directions for using the IBM TSS.
 Feel free to include additional hints/directions.

Mimi
   

