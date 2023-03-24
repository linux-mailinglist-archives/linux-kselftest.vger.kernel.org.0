Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6577D6C7F30
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 14:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjCXN6P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 09:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjCXN6O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 09:58:14 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B5C1207E;
        Fri, 24 Mar 2023 06:58:14 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OD5wwO022246;
        Fri, 24 Mar 2023 13:58:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=ZUzH0Xuenm6+wu9+G3D3oQAp53GfkIJ67772GXRbYuM=;
 b=Efi/psgYSMTAcX7gQqvj2qbgB5mNgXke6w4JOsIEKn479Rq1BcRGoG92PwjXMqun2LK9
 X/ynW1Xj8wgc7SebS8O8icj2y5REVT3sn7tt/5YzmaiuSojDpQJpx4+USPvH3K+yIxg1
 97H5o2m5T9LR0w4qQkQRGRAbQWYDF4a5vUXTXvK09oCNyU/A9y2OIqRG+SKnUqI4CujE
 7u4LOGweA038RFKWgndHQj6ucCeJgkQhUdb9RiTbOYSXhHxOmriUvaYrWd2qtFervFrH
 ShkpieyqBGdoeO2ki2H5TKLjvaECMesYENEl8h0uWLYgZguhwFEV7WgnT1U9QP1nNgnJ aA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pgxssus5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 13:58:08 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32ODMtU0024778;
        Fri, 24 Mar 2023 13:58:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3pgxkrrwpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 13:58:06 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ODw3k823921322
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Mar 2023 13:58:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 239562005A;
        Fri, 24 Mar 2023 13:58:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95CE02004E;
        Fri, 24 Mar 2023 13:58:02 +0000 (GMT)
Received: from p-imbrenda (unknown [9.179.5.149])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
        Fri, 24 Mar 2023 13:58:02 +0000 (GMT)
Date:   Fri, 24 Mar 2023 14:58:00 +0100
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Nico Boehr <nrb@linux.ibm.com>
Cc:     borntraeger@linux.ibm.com, frankja@linux.ibm.com, shuah@kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 1/2] KVM: s390: selftests: add selftest for CMMA
 migration
Message-ID: <20230324145800.6cf5b6e9@p-imbrenda>
In-Reply-To: <167966467508.41638.7406110796797557962@t14-nrb>
References: <20230208144827.131300-1-nrb@linux.ibm.com>
        <20230208144827.131300-3-nrb@linux.ibm.com>
        <20230323153644.0ece796f@p-imbrenda>
        <167966467508.41638.7406110796797557962@t14-nrb>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NGcMNr5fiz5gUI6d8EFx6g73VlbKPusk
X-Proofpoint-GUID: NGcMNr5fiz5gUI6d8EFx6g73VlbKPusk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_08,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303240109
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 24 Mar 2023 14:31:15 +0100
Nico Boehr <nrb@linux.ibm.com> wrote:

> Quoting Claudio Imbrenda (2023-03-23 15:36:44)
> > > diff --git a/tools/testing/selftests/kvm/s390x/cmma_test.c b/tools/testing/selftests/kvm/s390x/cmma_test.c
> > > new file mode 100644
> > > index 000000000000..76751abf2331
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/kvm/s390x/cmma_test.c  
> [...]
> > > +static void create_main_memslot(struct kvm_vm *vm)
> > > +{
> > > +     int i;
> > > +
> > > +     vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, MAIN_PAGE_COUNT, 0);
> > > +     for (i = 0; i < NR_MEM_REGIONS; i++)
> > > +             vm->memslots[i] = 0;  
> > 
> > can you explain why you are zeroing all memslots?  
> 
> I think it's not all memslots, this array only contains IDs of some memslots.  I think the IDs are set to 0 to indicate "this slot is unused".
> 
> I did this here, because that's what __vm_create does. Since I can't use __vm_create (I want my custom memslots), I have to use ____vm_create and I thought it's good to just do the same thing here.

can you please add a comment to explain this
