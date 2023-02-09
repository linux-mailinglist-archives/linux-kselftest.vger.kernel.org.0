Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77903690FC2
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 19:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjBISAh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 13:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjBISAg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 13:00:36 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AB4C673;
        Thu,  9 Feb 2023 10:00:36 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319HqhcO028667;
        Thu, 9 Feb 2023 18:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Lmhy+u3RejciIgY5dlsFnZKTfGQ59GI+TbEPRgXUduo=;
 b=gbyB8ZHwDWOAyJOISirMI4aqDc2HttPQgQEl7uYXvVOJw1CPnekFMwaDEgM/0mUhgGPO
 Kl7pxpdny3t/3kuSajqfZu9H012AaIVBOgYMCISvBB4z+cbCq0+qeQEWspW9g5FsSzVI
 mj8qwCrMs0m0djve2NuDzsUZ4JNpkVvQI8+GKTtQxv1cVeQijXj9GRoZq0FmkJR1xwDH
 4poDXQ5zPecJHyS+sd6q08vFOyr/RR+4sPSS0uyW9MkU9Felh+riJC86xL6/FeKOZUJ+
 xwwyIUU1oTEIeU1fb24ImyiDMH2Gk77pgZTo7tgIwTXqxBSKxYJs4kwH5zRA4+8k9izy DA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nn5m9r5bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 18:00:06 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 319HrLQh030488;
        Thu, 9 Feb 2023 18:00:05 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nn5m9r5aq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 18:00:05 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 319GkF6t020070;
        Thu, 9 Feb 2023 18:00:04 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3nhf07kfmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 18:00:04 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 319I02Eg47448480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Feb 2023 18:00:03 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD77058055;
        Thu,  9 Feb 2023 18:00:02 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22C125804B;
        Thu,  9 Feb 2023 17:59:59 +0000 (GMT)
Received: from [9.65.251.35] (unknown [9.65.251.35])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  9 Feb 2023 17:59:58 +0000 (GMT)
Message-ID: <25102c92-1831-be52-677d-60bbf2e11772@linux.ibm.com>
Date:   Thu, 9 Feb 2023 12:59:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 06/17] iommufd/hw_pagetable: Use domain_alloc_user op for
 domain allocation
To:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, jgg@nvidia.com, kevin.tian@intel.com,
        robin.murphy@arm.com
Cc:     cohuck@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
        kvm@vger.kernel.org, chao.p.peng@linux.intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        baolu.lu@linux.intel.com
References: <20230209043153.14964-1-yi.l.liu@intel.com>
 <20230209043153.14964-7-yi.l.liu@intel.com>
Content-Language: en-US
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20230209043153.14964-7-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MshAoLJBHiVQi2gxFXq8KhlzTdxvvaXT
X-Proofpoint-GUID: Amz5GV-sdxrN2XmhGfjMFEdg5gLSMKzb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_13,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1011 phishscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090166
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/8/23 11:31 PM, Yi Liu wrote:
> This converts iommufd to use iommu_domain_alloc_user() for iommu_domain
> creation.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommufd/hw_pagetable.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> index 43d473989a06..08d963ee38c7 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -30,6 +30,7 @@ struct iommufd_hw_pagetable *
>  iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
>  			   struct device *dev)
>  {
> +	const struct iommu_ops *ops;
>  	struct iommufd_hw_pagetable *hwpt;
>  	int rc;
>  
> @@ -37,7 +38,13 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
>  	if (IS_ERR(hwpt))
>  		return hwpt;
>  
> -	hwpt->domain = iommu_domain_alloc(dev->bus);
> +	ops = dev_iommu_ops(dev);
> +	if (!ops || !ops->domain_alloc_user) {
> +		rc = -EOPNOTSUPP;
> +		goto out_abort;
> +	}

Hi Yi,

This seems to break the iommufd vfio container support for any iommu that hasn't implemented domain_alloc_user yet.

I noticed it using vfio-pci on s390 with

CONFIG_IOMMUFD=m
CONFIG_IOMMUFD_VFIO_CONTAINER=y
CONFIG_VFIO_GROUP=y

Not sure if the intent is to make domain_alloc_user a hard requirement for using iommufd (if so then the commit description really should highlight that).  Otherwise, conditionally calling iommu_domain_alloc(dev->bus) when !ops->domain_alloc_user (instead of returning -EOPNOTSUPP) seems to restore the prior functionality for me.

Thanks,
Matt
