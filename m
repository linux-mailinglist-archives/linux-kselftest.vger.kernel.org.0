Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAD96237B8
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Nov 2022 00:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbiKIXwE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Nov 2022 18:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiKIXwE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Nov 2022 18:52:04 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B91DEDF;
        Wed,  9 Nov 2022 15:52:03 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9M6Wmk026925;
        Wed, 9 Nov 2022 23:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=r2y6FqBtbLq2FplQA0MEJ5QEQdgEf4YRwMBtghSYQ50=;
 b=NUoO9/P5o4yJwUu1TaYaJ9GIivUKJRvnKaAnO5G1f7SmkqRWmDAw6fRFpXdBrmV6gLDl
 RZ2IaQ3wTzFFDsPScmvNYA7xZ+e2oROB9i4sY9Xx9nyp/xkEkzGEWP1sZj2NH0AM4tBh
 HKoFOCUZ4RF+RHAAsjajGCfbP+YZM7eIIZfExWmWEyzVIG5Y4PRRsDpqM7ey7IM5Q6Dx
 wsRycAa3Xb4mcxO2RdnbHPADWgvwg8pqILqwkj1DbyyfsjSkB7yvfH5Pgil7Wy9OZ1DV
 fwGWwbaXMAHXMvCtcBWOJyobmX4qPysC6d/MWz1z3QG1uapdjgQCBvCXICS+SaASF1CE 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3krkgubm6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 23:51:12 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A9NhXNd004196;
        Wed, 9 Nov 2022 23:51:11 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3krkgubm66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 23:51:11 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A9No9Gq008858;
        Wed, 9 Nov 2022 23:51:10 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01dal.us.ibm.com with ESMTP id 3kngsyh2p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 23:51:10 +0000
Received: from smtpav03.dal12v.mail.ibm.com ([9.208.128.129])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A9NpAlG47644974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Nov 2022 23:51:10 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F6CD5805A;
        Wed,  9 Nov 2022 23:51:08 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9CCB58068;
        Wed,  9 Nov 2022 23:51:05 +0000 (GMT)
Received: from [9.160.191.98] (unknown [9.160.191.98])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  9 Nov 2022 23:51:05 +0000 (GMT)
Message-ID: <6ddf657f-9ec7-6de5-62f4-508d61a467fe@linux.ibm.com>
Date:   Wed, 9 Nov 2022 18:51:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4 15/17] iommufd: Add a selftest
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>, bpf@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
References: <15-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <15-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NVWUBpQHwQeub4Vtor_WE-ljRzrQR9IE
X-Proofpoint-GUID: ZRDWBG7lTzZ5mzkpMVZQghrekqNfJFmA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211090177
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/7/22 7:49 PM, Jason Gunthorpe wrote:
> Cover the essential functionality of the iommufd with a directed
> test. This aims to achieve reasonable functional coverage using the
> in-kernel self test framework.
> 
> It provides a mock kernel module for the iommu_domain that allows it to
> run without any HW and the mocking provides a way to directly validate
> that the PFNs loaded into the iommu_domain are correct.
> 
> The mock also simulates the rare case of PAGE_SIZE > iommu page size as
> the mock will operate at a 2K iommu page size. This allows exercising all
> of the calculations to support this mismatch.
> 
> This allows achieving high coverage of the corner cases in the iopt_pages.
> 
> However, it is an unusually invasive config option to enable all of
> this. The config option should not be enabled in a production kernel.
> 
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Ran the selftests on s390 in both LPAR (z16) and a QEMU kvm guest using 1M hugepages, all tests are passing.

Tested-by: Matthew Rosato <mjrosato@linux.ibm.com> # s390
