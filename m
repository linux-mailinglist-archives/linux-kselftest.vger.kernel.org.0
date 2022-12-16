Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C4764ECF1
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Dec 2022 15:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiLPOgK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Dec 2022 09:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiLPOgJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Dec 2022 09:36:09 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF65B26A88
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Dec 2022 06:36:05 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGENAaC012365;
        Fri, 16 Dec 2022 14:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=OpGeMrx3l8FMfLqoj8wbeRmgdg6YhdniUmTRzGfOvLQ=;
 b=YgVED4emC3DfnvgKgFF/5ionKgTFYZ8z82iyaH2dKDA/yDTTPVO5IDcu48Od/kuRvzrO
 o8GFx7tbtcdrpLR8jLutR/wuetzJk24a+iSgC4/5asjda9JxM0HKCVy0pS6zLnW/w6dT
 cn7/qo9NFhpuXAS++rh4wRtGK064u1tyUQqE/ogGQ753GWqadJxzu+IuSur71xE/0quj
 lbk1PDunWb75VYdf3JZBq/WRFUtpHJjG57jOLtAGPw0ERjjNfLSLohsQGki6RCwX3gRW
 eRZNYuVBF5zCRPaNGpceZS84RKKX94SQaLKEC1TIXdm40yZbtJvsraYVFFyi7S3zPkTn gw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mgtd30afs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 14:35:49 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BG2Z01U026988;
        Fri, 16 Dec 2022 14:35:47 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3meyjbmkf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 14:35:47 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BGEZj6623134496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Dec 2022 14:35:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEBC120040;
        Fri, 16 Dec 2022 14:35:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77F442005A;
        Fri, 16 Dec 2022 14:35:44 +0000 (GMT)
Received: from [9.171.33.197] (unknown [9.171.33.197])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 16 Dec 2022 14:35:44 +0000 (GMT)
Message-ID: <3193d6833feccc5c2fbdef9b1f71f292eddb8f27.camel@linux.ibm.com>
Subject: Re: [PATCH] dma-mapping: benchmark: Fix compile error in user-space
 tool
From:   Gerd Bayer <gbayer@linux.ibm.com>
To:     "chenxiang (M)" <chenxiang66@hisilicon.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
        linux-kselftest@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
Date:   Fri, 16 Dec 2022 15:35:44 +0100
In-Reply-To: <fd189113-deae-d6b7-bb9a-a5a94f7b0815@hisilicon.com>
References: <20221205135022.49708-1-gbayer@linux.ibm.com>
         <fd189113-deae-d6b7-bb9a-a5a94f7b0815@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.1 (3.46.1-1.module_f37+15677+998b8b6b) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3ddMfe128csJBk1qWHOmIFuUp22jiGR4
X-Proofpoint-GUID: 3ddMfe128csJBk1qWHOmIFuUp22jiGR4
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_09,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2212160127
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2022-12-06 at 11:13 +0800, chenxiang (M) wrote:
>=20
> =E5=9C=A8 2022/12/5 21:50, Gerd Bayer =E5=86=99=E9=81=93:
> > Since [1] the user-space program dma_map_benchmark shares the
> > header file
> > linux/map_benchmark.h with the kernel driver in
> > kernel/dma/map_benchmark.c.
> > With latest kernel version this does not compile any more.
> >=20
> > While https://kernelnewbies.org/KernelHeaders=C2=A0suggests otherwise,
> > allow it
> > to use of kernel headers through the uapi/ include direcotry. I
> > assume we can
> > do so safely, since the controlling user-space program is
> > distributed with
> > the kernel.
> >=20
> > With this change dma_map_benchmark compiles with just the obvious
> > warning
> > about uapi usage on ARCH=3Dx86 and s390 and runs on ARCH=3Ds390.
> >=20
> > [1] commit 8ddde07a3d28 ("dma-mapping: benchmark: extract a common
> > header file for map_benchmark definition")
> >=20
> > Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
>=20
> It also solves the compile error on arm64 platform.
> Acked-by:=C2=A0 Xiang Chen <chenxiang66@hisilicon.com>

Hi Xiang Chen, hi Shuah,

so is there any chance to have this compile fix integrated into linux-
next still, or is this too late now?

Thanks,
Gerd

>=20
> > ---
> > =C2=A0 tools/testing/selftests/dma/dma_map_benchmark.c | 2 +-
> > =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c
> > b/tools/testing/selftests/dma/dma_map_benchmark.c
> > index 5c997f17fcbd..d49d7ea6a63e 100644
> > --- a/tools/testing/selftests/dma/dma_map_benchmark.c
> > +++ b/tools/testing/selftests/dma/dma_map_benchmark.c
> > @@ -10,7 +10,7 @@
> > =C2=A0 #include <unistd.h>
> > =C2=A0 #include <sys/ioctl.h>
> > =C2=A0 #include <sys/mman.h>
> > -#include <linux/types.h>
> > +#include <uapi/linux/types.h>
> > =C2=A0 #include <linux/map_benchmark.h>
> > =C2=A0=20
> > =C2=A0 #define NSEC_PER_MSEC=C2=A01000000L
> >=20
> > base-commit: 8abacb3356e68261ccd3a2ad74ed6042363e5d0f
>=20

