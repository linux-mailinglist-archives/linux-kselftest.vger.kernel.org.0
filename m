Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9075B57D4
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Sep 2022 12:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiILKGa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Sep 2022 06:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiILKG0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Sep 2022 06:06:26 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4921B1A3B2;
        Mon, 12 Sep 2022 03:06:25 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28C8tDD9030287;
        Mon, 12 Sep 2022 10:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : content-transfer-encoding : mime-version; s=pp1;
 bh=klkeUedZzOD8HNa/htDaTso+jLdfKWnvnnAbZyswICc=;
 b=QC5zDos/X3F+5IkPZt6vDyld6RZFAO6AH+RFCgonk+Z5ZRnWwJDXGlnPniYugn9UYVtc
 nQUIdKjmeH++mBpR9vzaJHtAHmoU1ttXL7drj56BZzKoZ9HDKzolz5OdI0H7HpDzzsHP
 osOKhODCxkMzHySBVOLxnoRGVKBROVp8m8MAtyEDNICclwlgvfNBs5+nEn4UGo3bjkpQ
 Vh+E2V/46kXKMabRkcUybScj0wY1Xqh0Inudy/kdbQ2nHK1bFl/8XrcR3JfbsejqwiGz
 J/b2N6mutl9BW2KBusAZNrdzm4hjTwggFMn7cnU2/EkFFeuXsSAxHnH6NtjIscPBKgZ3 RQ== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jhyv85xed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 10:06:17 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28CA5nGG022219;
        Mon, 12 Sep 2022 10:06:15 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3jgj78smhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 10:06:15 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28CA2W2s16056720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Sep 2022 10:02:32 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E411A4053;
        Mon, 12 Sep 2022 10:06:13 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 751B5A4051;
        Mon, 12 Sep 2022 10:06:11 +0000 (GMT)
Received: from tarunpc (unknown [9.43.18.53])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 12 Sep 2022 10:06:11 +0000 (GMT)
Message-ID: <32851d30c124e1a499edf3d8c7c0cf0cd04735cc.camel@linux.ibm.com>
Subject: Re: [LTP] [RFC PATCH] Hugetlb: Migrating hugetlb tests from
 libhugetlbfs
From:   Tarun Sahu <tsahu@linux.ibm.com>
Reply-To: tsahu@linux.ibm.com
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     ltp@lists.linux.it, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, aneesh.kumar@linux.ibm.com,
        linux-kernel@vger.kernel.org
Date:   Mon, 12 Sep 2022 15:36:10 +0530
In-Reply-To: <Yx7xOGLqy2lVE9tI@yuki>
References: <20220908173947.17956-1-tsahu@linux.ibm.com>
         <YxsCJi8O+HmMpefq@yuki>
         <2412537e2e07ebf62fe95971a3022336cde9833a.camel@linux.ibm.com>
         <Yx7xOGLqy2lVE9tI@yuki>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UfbPtEGr12zhGuYnAJg1hGetJ9yIqOwZ
X-Proofpoint-GUID: UfbPtEGr12zhGuYnAJg1hGetJ9yIqOwZ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_06,2022-09-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209120033
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, 

Thanks for confirming.

There is one more confirmation I required
before I submit a patch series on necessary libhugetlbfs tests, 
Between
LTP and Kselftests, Choosing LTP is right decision? (mentioned details
in patch description)

Thanks

On Mon, 2022-09-12 at 10:43 +0200, Cyril Hrubis wrote:
> Hi!
> > As mentioned in the patch description, there is a conflict in
> > license,
> > That is why, I have avoided to put any of them in the header. Once
> > confirmed within the community, I can add the original license
> > here.
> > (GPL2.1+) as 
> > https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
> > this says only to add code with GPL2.0+.
> 
> As far as I can tell there is no GPL2.1+ the only 2.1 version in
> existence is LGPL.
> 
> GPL2.1+ usually happens to be an error when someone takes library
> header
> with LGPL2.1+ license and removes the "Lesser" part.
> 
> However it looks like the whole libhugetlbfs is under LGPL2.1+ which
> kind of makes sense for a library, but not so much for the tests
> since
> these do not provide a library that can be linked againts at all.
> 

