Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97640669ECA
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jan 2023 17:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjAMQzM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Jan 2023 11:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjAMQyq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Jan 2023 11:54:46 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52A952749
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Jan 2023 08:53:05 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DFgfE2030401;
        Fri, 13 Jan 2023 16:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=xQQB27US0hgo/rttTDlgC9L3XLrbBydAW6G4I0paAbQ=;
 b=nWmrmIAo4MSza4o4cEREBqnkhtPhO8nUgyFeV56xzjW59/9xC1ktIOGkuTgtGIDvJQwq
 rWdZkrrK3BoHkEmP7iSkqYktZ8DrIxaD9bjfKKQpfXhCspXqtQuIWLtteFMWfg2NyatY
 +uOMUIL3qIr3LnRJC34u5zOJNJbO4IyJUmAJ4paNtCQOsrdnl4S+Y4v+7puOx4vggtC3
 E4j9+nLp/iy0k2dYjsDUTGYD7CA+736tPbKbgXB8MPhvAHzmsLYcv8UACi2/wFdApbH4
 YbqkqwFfyQ4kMd3YYGfg+vmrT1MCb5+JMBKmbeft1KtOSTaoWj0hwH0Ty9QxptoQWhvR /w== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n3a60hrx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 16:52:45 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30D85Ebb022367;
        Fri, 13 Jan 2023 16:52:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3n1k5ub3kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 16:52:42 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30DGqeIh45810054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 16:52:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86EA920043;
        Fri, 13 Jan 2023 16:52:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A61720040;
        Fri, 13 Jan 2023 16:52:40 +0000 (GMT)
Received: from [9.179.4.158] (unknown [9.179.4.158])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 13 Jan 2023 16:52:39 +0000 (GMT)
Message-ID: <9d824f0b3642d3b3e8e92fe7a34522f334b003f7.camel@linux.ibm.com>
Subject: Re: [PATCH] selftests:dma: Fix compile error in user-space tool
From:   Gerd Bayer <gbayer@linux.ibm.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
        linux-kselftest@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
Date:   Fri, 13 Jan 2023 17:52:38 +0100
In-Reply-To: <a01b5643-3373-d5a0-a3d7-4fa845725dbd@linuxfoundation.org>
References: <20230109180721.187324-1-gbayer@linux.ibm.com>
         <a01b5643-3373-d5a0-a3d7-4fa845725dbd@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.module_f37+15771+ac82e58b) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: O05jySuY1WikAqjoF_StQ6-ronuZuOsy
X-Proofpoint-GUID: O05jySuY1WikAqjoF_StQ6-ronuZuOsy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_07,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130110
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2023-01-12 at 13:36 -0700, Shuah Khan wrote:
> On 1/9/23 11:07, Gerd Bayer wrote:
> > With this change dma_map_benchmark compiles with just the obvious
> > warning
> > about uapi usage on ARCH=3Dx86, arm64, and s390 and runs on
> > ARCH=3Ds390.
>=20
> On Linux 6.2-rc3, dma_map_benchmark compiles just fine. You do
> have to do "make headers_install" first as kselftest depends
> on headers being installed in the repo.
>=20
> Please let me know if you are seeing compile problems even after
> installing headers.
>=20
> thanks,
> -- Shuah

Hi Shuah,

thank you for this clarification. Once I run "make headers_install"
before attempting to build the dma_benchmark_test executable with
  make -C tools/testing/selftests/ TARGETS=3D"dma"
everything works out nicely - even w/o my patch.

I have to apologize for creating this fuzz. I was not aware that one of
the dependencies for "make kselftest" was "make headers_install", since
I was going straight for the interactive "dma_benchmark_test" control
tool of the test that is implemented in kernel/dma/benchmark_test.c.
I didn't intend to run the full "make kselftest" suite, primarily since
I have distinct test and build systems - most often building cross-
arch, even.

So please, disregard the PATCH.

Thank you,
Gerd


