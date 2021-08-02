Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CC83DDBB8
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Aug 2021 17:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbhHBPBo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Aug 2021 11:01:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11714 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234211AbhHBPBn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Aug 2021 11:01:43 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 172EXhc2112433;
        Mon, 2 Aug 2021 11:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=tU+Dh7yViSX+arhzY6wi+MNmaJDKyBkP/td5MGDEVQA=;
 b=obypbEYMUT0DRZoROC89kxdOeObkAnvcqG63XXOsE5QUelM0USpAWZYourKAk4w8OoCS
 WloHbDE/Q6Fv6BBsoaRbpl4AzDRUyvcaqd9ptQZAUJO91/qWk89FhFyWTmRH8GCB/dfR
 z1Cu/S0Xw0b7uywJa4eqeLoZ/fskGddUWRFVcynQ5pyt0D4zm/OJAem2mAbh/XEG6xPF
 K4uUsG4a9QG7znmL+belUJzAPg3MSoR2jB8QH6ZEOuNWXLrMSYu/9/xcQOZ/69DFnFv+
 2Pkv/KuMezmnQPYQMn7d6usr5gDo81CPDvctHymsqMl4Hn0YEIkYUu+7EcQ1V5HDTECM CA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a5s279fnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Aug 2021 11:01:22 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 172ExBlB007905;
        Mon, 2 Aug 2021 15:01:21 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3a4wshn1q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Aug 2021 15:01:20 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 172EwRLH32113108
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Aug 2021 14:58:27 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 840DFA4072;
        Mon,  2 Aug 2021 15:01:18 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8ABF9A407D;
        Mon,  2 Aug 2021 15:01:16 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.118.203])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 Aug 2021 15:01:16 +0000 (GMT)
Message-ID: <1efee8d7f62fb0e413f6e28d40af62610b8ce450.camel@linux.ibm.com>
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>
Date:   Mon, 02 Aug 2021 11:01:15 -0400
In-Reply-To: <96c7cd3d19254e84a6cb45b2a940e944@huawei.com>
References: <20210726163700.2092768-1-roberto.sassu@huawei.com>
         <20210726163700.2092768-7-roberto.sassu@huawei.com>
         <c9dffd9d29df095660beaa631ff252c4b33629a0.camel@linux.ibm.com>
         <ef7c85dcb096479e95c8c60ccda4d700@huawei.com>
         <1ef95096bee13578b3f906dd9f708c6af9d6ff18.camel@linux.ibm.com>
         <555bf01bee4b4ea7a9bee658366d535a@huawei.com>
         <2c731f07bd08f01f2a3e032814bc65ae9a8494ad.camel@linux.ibm.com>
         <bd0787e0ee4f47baa41abf47976e536c@huawei.com>
         <96c7cd3d19254e84a6cb45b2a940e944@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZQwL0SeAMMVVukqfkoWNXexSkUKdmvJ7
X-Proofpoint-GUID: ZQwL0SeAMMVVukqfkoWNXexSkUKdmvJ7
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-02_05:2021-08-02,2021-08-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108020094
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 2021-08-02 at 08:14 +0000, Roberto Sassu wrote:
> > From: Roberto Sassu [mailto:roberto.sassu@huawei.com]
> > Sent: Friday, July 30, 2021 4:25 PM
> > > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > > Sent: Friday, July 30, 2021 4:03 PM
> > > Hi Roberto,
> > >
> > > On Fri, 2021-07-30 at 13:16 +0000, Roberto Sassu wrote:
> > > > > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > > > > Sent: Friday, July 30, 2021 2:40 PM
> > >
> > > > > "critical data", in this context, should probably be used for verifying
> > > > > the in memory file digests and other state information haven't been
> > > > > compromised.
> > > >
> > > > Actually, this is what we are doing currently. To keep the
> > > > implementation simple, once the file or the buffer are uploaded
> > > > to the kernel, they will not be modified, just accessed through
> > > > the indexes.
> > >
> > > My main concern about digest lists is their integrity, from loading the
> > > digest lists to their being stored in memory.  A while back, there was
> > > some work on defining a write once memory allocator.  I don't recall
> > > whatever happened to it.  This would be a perfect usecase for that
> > > memory allocator.
> > 
> > Adding Igor in CC.
> > 
> > Regarding loading, everything uploaded to the kernel is carefully
> > evaluated. This should not be a concern. Regarding making them
> > read-only, probably if you can subvert digest lists you can also
> > remove the read-only protection (unless you use an hypervisor).
> 
> I briefly talked with Igor. He also agreed with that, and added that
> it could make it more difficult for an attacker to also disable the
> protection. However, he is not planning to submit an update soon,
> so I wouldn't consider this an option for now.

Hi Roberto, Greg,

As long as others understand and agree to the risk, the IMA details can
be worked out.

thanks,

Mimi

