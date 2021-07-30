Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C8D3DB9F1
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jul 2021 16:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239089AbhG3ODa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Jul 2021 10:03:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62022 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239044AbhG3ODa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Jul 2021 10:03:30 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16UDlDuT007928;
        Fri, 30 Jul 2021 10:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Vp0U8yxVJgFQ41zGrYD8eUzgmT5mkO9NlAdJeTljdrw=;
 b=QegEPTH0bAHHFrBL85fsAkXTEAWqnkVLqaIyVsC80+ZcAZy1ernC7owkLvSl+FKe0Bo+
 pTkVfxHaWkOBVzLCAulfYfCRIcVvR0iMeOyvfvO+L3NdlISQQZj5URyBH6n4n6nmH42J
 ZZUhScWGTzcXMPKD7A4xmYGMmfyn0eVjrmwrxbjMtDLK3ghfg8A1tb+nhHhyP7DAI23G
 P704v2geHUSNHWrk/Js6XaH7e5somWXbT2DwWYo6sZNxpuYpkfd1yEMjefn+HfItGRMw
 TpRSBfxmGfWc7V8SMQwFuEsA0+KgGJ+ERYySTgYXuIIvh2pJEarVzKBDeVRIn4hQ+1e0 QA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a4jm7gf2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jul 2021 10:03:21 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16UE3BOs017783;
        Fri, 30 Jul 2021 14:03:18 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3a235m4346-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jul 2021 14:03:18 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16UE3GP430933376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jul 2021 14:03:16 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28CA4A4069;
        Fri, 30 Jul 2021 14:03:16 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 207FCA4059;
        Fri, 30 Jul 2021 14:03:14 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.54.226])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 30 Jul 2021 14:03:13 +0000 (GMT)
Message-ID: <2c731f07bd08f01f2a3e032814bc65ae9a8494ad.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH v2 06/12] diglim: Interfaces - digest_list_add,
 digest_list_del
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 30 Jul 2021 10:03:13 -0400
In-Reply-To: <555bf01bee4b4ea7a9bee658366d535a@huawei.com>
References: <20210726163700.2092768-1-roberto.sassu@huawei.com>
         <20210726163700.2092768-7-roberto.sassu@huawei.com>
         <c9dffd9d29df095660beaa631ff252c4b33629a0.camel@linux.ibm.com>
         <ef7c85dcb096479e95c8c60ccda4d700@huawei.com>
         <1ef95096bee13578b3f906dd9f708c6af9d6ff18.camel@linux.ibm.com>
         <555bf01bee4b4ea7a9bee658366d535a@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wNsyaJ4RvqTcomgd160mG9KIFib2kW1P
X-Proofpoint-ORIG-GUID: wNsyaJ4RvqTcomgd160mG9KIFib2kW1P
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-30_05:2021-07-30,2021-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107300087
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Roberto,

On Fri, 2021-07-30 at 13:16 +0000, Roberto Sassu wrote:
> > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > Sent: Friday, July 30, 2021 2:40 PM

> > "critical data", in this context, should probably be used for verifying
> > the in memory file digests and other state information haven't been
> > compromised.
> 
> Actually, this is what we are doing currently. To keep the
> implementation simple, once the file or the buffer are uploaded
> to the kernel, they will not be modified, just accessed through
> the indexes.

My main concern about digest lists is their integrity, from loading the
digest lists to their being stored in memory.  A while back, there was
some work on defining a write once memory allocator.  I don't recall
whatever happened to it.  This would be a perfect usecase for that
memory allocator.

thanks,

Mimi

