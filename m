Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52AD662B9A
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jan 2023 17:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjAIQrQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Jan 2023 11:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236528AbjAIQqw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Jan 2023 11:46:52 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA023C72F
        for <linux-kselftest@vger.kernel.org>; Mon,  9 Jan 2023 08:46:03 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309FdspQ016333;
        Mon, 9 Jan 2023 16:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=r/c+/V8fPl7liKWfOzIezG4cPmu1VXMZ6/z7UfvLYsM=;
 b=bNHjKAdqtLysGj2NJSy4wq0BsfiPDkZOKC+vuSB3ec1h2ZEBT7oa8BX4shGOLRwWAHVe
 eeBSZcc06evWJnuQc1Y7NOX3V3XwWGJYVQQ7tWyjAXz6H6JY2EJGyk3dxfsgrTh/zxtd
 Kq0lRJrx5lPQhT391psKwJzCXP0A92oLiRJ9paShf3e2GmDpt6YHxCYGT7PX7Rqa9bCs
 Cb7UbAfZBogUFP9BiZ3Mos7eQkwvt/l1MlSpQc644OAPdgRfRmqeqZgs2s09AJyLXURz
 tOVbRcMEqadNoDOO5itUAgwk396cIs60DQgCY4SOubJ+rIT7YVE5jeDIYTDUHfEh0lo2 OA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3myj6jkrup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 16:45:41 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3098dIkR012461;
        Mon, 9 Jan 2023 16:45:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3my00fk8h5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 16:45:39 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 309Gjb7t37683464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Jan 2023 16:45:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AD1220040;
        Mon,  9 Jan 2023 16:45:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9452B20049;
        Mon,  9 Jan 2023 16:45:36 +0000 (GMT)
Received: from [9.171.48.140] (unknown [9.171.48.140])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  9 Jan 2023 16:45:36 +0000 (GMT)
Message-ID: <8315d3374f6129d99c07eb965f7f7bb2bd0bbd25.camel@linux.ibm.com>
Subject: Re: [PATCH] dma-mapping: benchmark: Fix compile error in user-space
 tool
From:   Gerd Bayer <gbayer@linux.ibm.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
        linux-kselftest@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Date:   Mon, 09 Jan 2023 17:45:36 +0100
In-Reply-To: <cdfc618a-5091-8989-7ca2-5d8d467b4adb@linuxfoundation.org>
References: <20221205135022.49708-1-gbayer@linux.ibm.com>
         <fd189113-deae-d6b7-bb9a-a5a94f7b0815@hisilicon.com>
         <3193d6833feccc5c2fbdef9b1f71f292eddb8f27.camel@linux.ibm.com>
         <4d8454c5-35d9-13f7-9571-4d38006061e2@linuxfoundation.org>
         <cdfc618a-5091-8989-7ca2-5d8d467b4adb@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.module_f37+15771+ac82e58b) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: o6fOt9DhG2fB8U5eoaPFVn24w76LwAQc
X-Proofpoint-GUID: o6fOt9DhG2fB8U5eoaPFVn24w76LwAQc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_09,2023-01-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 adultscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090119
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2022-12-21 at 09:44 -0700, Shuah Khan wrote:
> On 12/21/22 09:39, Shuah Khan wrote:
> > On 12/16/22 07:35, Gerd Bayer wrote:
> > > On Tue, 2022-12-06 at 11:13 +0800, chenxiang (M) wrote:
> > > >=20
> > > > =E5=9C=A8 2022/12/5 21:50, Gerd Bayer =E5=86=99=E9=81=93:
> > > > > Since [1] the user-space program dma_map_benchmark shares the
> > > > > header file
> > > > > linux/map_benchmark.h with the kernel driver in
> > > > > kernel/dma/map_benchmark.c.
> > > > > With latest kernel version this does not compile any more.
 [...]
> > > >=20
> > > > It also solves the compile error on arm64 platform.
> > > > Acked-by:=C2=A0 Xiang Chen <chenxiang66@hisilicon.com>
> > >=20
> > > Hi Xiang Chen, hi Shuah,
> > >=20
> > > so is there any chance to have this compile fix integrated into
> > > linux-
> > > next still, or is this too late now?
> > Plan to apply this after the merge window closes
> >=20
>=20
> The reason for the delay is this patch doesn't have the right commit
> header. This should have been "selftests:dma -----"
>=20
> It makes it easier for maintainers to parse and pay attention to the
> patches if they indicate the area they fall under. Something to
> keep in mind for your future patches.
>=20
> Please resend the patch with the Acks you received and a correct
> commit header.
>=20
> thanks,
> -- Shuah

Shuah,

thank you for your explanation. I'm working on resending the patch.

Thanks,
Gerd
