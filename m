Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CE6614EDA
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 17:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiKAQKF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 12:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKAQKE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 12:10:04 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20610.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::610])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18B81C407;
        Tue,  1 Nov 2022 09:10:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYm/Yhe6dN+DvUgZ4pthiyEDLLDwze76WgKqUZppBg1vAm8LBEfsWDyefFxUCSpeh2GyovotjFXfgN3hfsisOKCf2e+Yre87Pz4jYHPSU7/bBcQxDy6SgfWOuFRYCzzLqxBm+ClbrDE26I4LW1c8JbMP1scBY1jg/VajpyQJ2j1PpBIVfDasGY5BF4uPBCXl5z/do55JnE58hxapf7pdB8PdSb7yKhkTybtoRPKlb5KusCPSRk0FKPWzEI1aKi774Fmlo5wBxKdOjW/yenrAoHuudsJIwi8jkKUneabJrUniiLySDAzm6fWFlueW7/vkLxxLv6CJ4rqciHL6C/iq4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SzfOpI5uYz6HWW4FanyA++TUz1RczsQ1gB8Rsv/uA0=;
 b=UTdmEtLkUyUjbsUF+fFzmxs3pPsuRl+azvrw3ue02vLTGewEp1mFiR4/z2NbtspVXv915XYMhC6/ye54c4GOBTx0PXkuQwJElGhDnY47BT96Asc+rIMND3AY/3+44TPiRGP3JfKWWMQd6XwoSlr5kz5HFZuRilx5xTE7ORzZYHyKwQpW+JWf51O1V5inlMOLTgntZnI+YYK6pZfqQy2xocmnWewllVyuuFW2xMzoNnTbQIeBI8nzF3tk/+Zv7Zn1p7merjFO10jTVijaLnF6EPtW/0iXhnZa5MSSBLCiI1qC72OTeonpsplzHeRekvk8bIeVi9kao6z5ZgRYk18GmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SzfOpI5uYz6HWW4FanyA++TUz1RczsQ1gB8Rsv/uA0=;
 b=lYAMQNoUIIdUegZkPQohMG5VGZzfYZi5BpuFqSZjRWH2l6mcl1/iS3Rlx23p0QZLSWT2du0sOWIWFPqsOhxOg3vTF+wOURxizGYS6kclFcsrKe0/FgzEpNEBiOty/1zs1fj9+4fgfAxdZuhTH7DLBisgzRrQywSZ2lzaHEhd26H2azK47zN1RgYxYBgRgFERnQsEIP5QQGOoFjuhwDTCHB+bm+R+2pdqy5SjgIl+3F5/RsZOXviBzULuOxo4RE3msKgTrfgo/DcOP3EKHwZrS91Nk3daVbH8wBwXNrctOiS9amrQqoqVUWP+UXFbDk9exHi73WHJudbVOmFIfjUU9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB5440.namprd12.prod.outlook.com (2603:10b6:a03:3ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 16:09:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Tue, 1 Nov 2022
 16:09:58 +0000
Date:   Tue, 1 Nov 2022 13:09:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, bpf@vger.kernel.org,
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
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v3 8/15] iommufd: Algorithms for PFN storage
Message-ID: <Y2FE1YKpxCFNTJJr@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <8-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
X-ClientProxiedBy: MN2PR19CA0040.namprd19.prod.outlook.com
 (2603:10b6:208:19b::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB5440:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ce3e92-7692-439c-dffd-08dabc2385ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jIfzs70SmW34/TuxdUX69RdLAGowTrmxlRKLRq9KRDyLtjTvRqhYyUF+nKGoOTPzU1sL3duA2W1pSkMmBxkbEYjoxSkgilzQpz8G6RA8Yq6rcN7mut2V16QX72ZHlOMU2nHFALL70LQftm70J5LNBQpBbbAQN7QIJRgUhQ2Lhdplu8qPRbgGFaB78zoe+Nu7tj1gBG/EOL67k6jcnFPHejsthb55suKD8piMbr5/MSAcLfr46iFK0F9XFmhZWPmNQJsUVoFxv7GrgnwZzzG6vtU3ovsDRdiHpVFY8AgGsoDbj6PIxvNzKvETVy20m3wX2NwoCwefs/yiV1GCKoIip/+nfBF8JrMFrK2Yq9CLiIygnP64MeiK8WHjTeNOrBxS9dH0X95Df+3yOVuuM8+d/srLDZdtB6tYeD4k+sBQmJow99xiUT8G61nTGwZTk6F8MnzMNRZIRvrs2ai+n+jMXR5SuCWP/YHc0P+7QRnTbWrNwls3RmegAwc0L7sPzJ9UoyvTsEz70E7+j32SwKpbUkm7PAt/OAAQcjRRDhsLgwEHEuUQXdQ30XD2BnNt2BrAVG56EdLthopXdK8vABOt7EmV8PBzcH+bP0IYx9q4QjgCEl5iSTjqy89v7YWc4dt2sfegL77vYSR57Fj9ARBBBRQSLobqyHdzPH2ZpK50JDb6X8PpX+wMxA/oy2oLy/0u2rJhLx0MuNuZ9t7zTZLlZoEeUT5gFTePfgyI194GcyPD1TStcQ3PXOMYrbeAcWgX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199015)(6486002)(478600001)(6506007)(66946007)(66556008)(66476007)(8676002)(4326008)(2906002)(41300700001)(186003)(6512007)(26005)(2616005)(8936002)(7406005)(5660300002)(7416002)(83380400001)(921005)(38100700002)(110136005)(54906003)(316002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g0/zwJpcdrFReqp6Y6jobm/wqz0ef83xbRhShoqJEWel6L3ETA86V1XxrdlR?=
 =?us-ascii?Q?evb9axffBLRKTWm7zA58TUcctzJyKw3jFlA1lew60lLDnCCWYXqUT2sud4SP?=
 =?us-ascii?Q?Anjgr3BgDETaQk1xgfDccQceG/3/WCTxrNAvbdpFMZwUGdN41xGkfennP9P9?=
 =?us-ascii?Q?ZU/JpWQVAWEefUl9ik/SmWQkSGJrOogYGmUXBc9yPcy4rs0sh+8D8KAmxBY6?=
 =?us-ascii?Q?WF2/5itTsMy2iupRtF9RIjPGlHFUoNZY9S2hqsuxcJl6o9z1JXefKr8qS0fZ?=
 =?us-ascii?Q?9OQgCe+9Jh8ggoOQ8GgEZefWw8X7da+Sp+cqMufo77jspA2te4QrxDwnRoLH?=
 =?us-ascii?Q?HVGle/A5vNp9Asv8UME/EFsemvfAM6s/8ha2OalByt9tb2baUUS4hMpCZ1J6?=
 =?us-ascii?Q?X6hIXGuitBhwCvAPwW5W33xBvFZ2Ijc7YuJTm/aB6iMuQECSzDBroKdS47RF?=
 =?us-ascii?Q?TT6UqU+8qEXBN4tDL3BkbqrugO/xySKtGwxX8N5FtjNW3hXwJEg0/GGbgcFc?=
 =?us-ascii?Q?b/wDkSAtQ+nHdBtql/6h66+U3B/q/QbHA0fxJVOVwiKaNHJuNUVpEhi3/QNc?=
 =?us-ascii?Q?MNWt1uqEObP+2ztWHdqYxDbMEYnuZisLHnkcwJAzZhdF+Hx1IN//E/Dlok2q?=
 =?us-ascii?Q?8/J/1pbFkQS2W6jNQwpzXevc6YOtwBfToNLqdpsI4eGqp/dxniX4V5Meo6xR?=
 =?us-ascii?Q?C9tzJitVlNjFQeQxesoPYjRvJxPi4fh2r3eYdg6tFhKMvAkRCDRcSOj79lyQ?=
 =?us-ascii?Q?+rl9I9qb+1l95BhW7K7RIdXIAA0jZyqWSyp/37+1txiKyIA180R6aSJkSq3C?=
 =?us-ascii?Q?pWCx6SAoRjprQ1fUplKueQoR+SFyz8M5KpzRrHPXSPYUk1KzTVkqP1e8fstf?=
 =?us-ascii?Q?fc5ouqW/TcwiKCKrxU7QmENvbHt7ioEgkYJ4m6aFXD9XtWP1EWG/VUYJbevc?=
 =?us-ascii?Q?TykPAy30ARS4q95SRONZhpoOKgjFESrHfUhRFUDRdJdzBOSGpMwY7plqFamv?=
 =?us-ascii?Q?24tszDtREHhwG/fDg/P/vvSIgtvRclmsoJt32q+GiaQJB0qbVp9Rz63xazoW?=
 =?us-ascii?Q?1uotTaHCeVevKGLdOSG4D3xsDmn6xYl7BH7MHeoT7+WPtKCt1mpVvJ9dn02l?=
 =?us-ascii?Q?muSxftIxRcrde3vN3HezCeBkq66Iv/Z/w1zpCpkpOYPzdRetHCQgjsiFMeNt?=
 =?us-ascii?Q?TgumomeuQiTou5RSr+1CnZ86I93uGm+qzoMPJQt2j2z7s9FM3xgiY0bzQ36i?=
 =?us-ascii?Q?TklCE/gdMho5+iBWijFoeuQ9vTN4l7sMDNAxzxpBUxzl/L7H1ALvAAMnxJIM?=
 =?us-ascii?Q?mcbjLmPZH6I+dptAnYPKoxNWol457mBmlm1j8ljOZ90ya34d5zaa3+2QCP2h?=
 =?us-ascii?Q?jf04i0H/59AeVfSUPy9R5Z95E40TZ0p3HRarGSBib7aK8Q0z60L3sz9APv96?=
 =?us-ascii?Q?yGVXxlE7zluC5kWP9naiSSD3irENx6np1oYr/DpH/0887EnuPVyFA31JQjMo?=
 =?us-ascii?Q?3bndspUU9/33Uw8v9yzIZbCCazr3eoAZM3tc/Z4yDAzAzpPEzmvzfmEEvvfH?=
 =?us-ascii?Q?LhKKh/IY+WD1Oyv8WV8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ce3e92-7692-439c-dffd-08dabc2385ef
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 16:09:58.5188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZ4RyWozP+rxVOXlHoDjEPQJZ1rR9oW/iSCI6k8Va5VsRSnfm0TVhVNbU8X5EpYA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5440
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 25, 2022 at 03:12:17PM -0300, Jason Gunthorpe wrote:

> +/**
> + * iopt_unmap_domain() - Unmap without unpinning PFNs in a domain
> + * @iopt: The iopt the domain is part of
> + * @domain: The domain to unmap
> + *
> + * The caller must know that unpinning is not required, usually because there
> + * are other domains in the iopt.
> + */
> +void iopt_unmap_domain(struct io_pagetable *iopt, struct iommu_domain *domain)
> +{
> +	struct interval_tree_span_iter span;
> +
> +	interval_tree_for_each_span(&span, &iopt->area_itree, 0, ULONG_MAX)
> +		if (!span.is_hole)
> +			iommu_unmap_nofail(domain, span.start_used,
> +					   span.last_used - span.start_used +
> +						   1);
> +}

Syzkaller found a splat here.

The area_itree maintains "tombstones" of areas that are allocated, and
IOVA reserved, but not yet populated in the domain. This scheme
reduces the scope of the area_itree lock to only around allocation,
and not the much slower population step. It is the basis for parallel
mapping operation.

However, when a area is tombstoned with a area->pages == NULL it also
hasn't been mapped to a domain and thus cannot be unmapped

The above span iterator is actually iterating over all the allocated
IOVAs, not the IOVAs that have been populated to a domain. To get that
we need to check area->pages before allowing the area to become a
'used'. Thus if we race domain destruction with map and hit the
tombstone we can trigger a WARN_ON in the selftest that the IOVA being
unmapped is not mapped.

A case of incorrect optimization. The fix is simple enough, just
remove the span iterator (and audit that no other uses of area_itree
are mis-using the span iterator)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 5d4d48c80d3ad8..d1ba31491babb0 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -709,15 +709,14 @@ static void iopt_unfill_domain(struct io_pagetable *iopt,
 				continue;
 
 			mutex_lock(&pages->mutex);
-			if (area->storage_domain != domain) {
-				mutex_unlock(&pages->mutex);
-				continue;
-			}
-			area->storage_domain = storage_domain;
+			if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
+				WARN_ON(!area->storage_domain);
+			if (area->storage_domain == domain)
+				area->storage_domain = storage_domain;
 			mutex_unlock(&pages->mutex);
-		}
 
-		iopt_unmap_domain(iopt, domain);
+			iopt_area_unmap_domain(area, domain);
+		}
 		return;
 	}
 
diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 0bd645da97809a..3b85fa344f6be3 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -65,7 +65,8 @@ void iopt_area_unfill_domains(struct iopt_area *area, struct iopt_pages *pages);
 int iopt_area_fill_domain(struct iopt_area *area, struct iommu_domain *domain);
 void iopt_area_unfill_domain(struct iopt_area *area, struct iopt_pages *pages,
 			     struct iommu_domain *domain);
-void iopt_unmap_domain(struct io_pagetable *iopt, struct iommu_domain *domain);
+void iopt_area_unmap_domain(struct iopt_area *area,
+			    struct iommu_domain *domain);
 
 static inline unsigned long iopt_area_index(struct iopt_area *area)
 {
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index b15967d87ffa86..dcc4620cd5d5e6 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1186,22 +1186,17 @@ static void iopt_area_unfill_partial_domain(struct iopt_area *area,
 }
 
 /**
- * iopt_unmap_domain() - Unmap without unpinning PFNs in a domain
- * @iopt: The iopt the domain is part of
+ * iopt_area_unmap_domain() - Unmap without unpinning PFNs in a domain
+ * @area: The IOVA range to unmap
  * @domain: The domain to unmap
  *
  * The caller must know that unpinning is not required, usually because there
  * are other domains in the iopt.
  */
-void iopt_unmap_domain(struct io_pagetable *iopt, struct iommu_domain *domain)
+void iopt_area_unmap_domain(struct iopt_area *area, struct iommu_domain *domain)
 {
-	struct interval_tree_span_iter span;
-
-	interval_tree_for_each_span(&span, &iopt->area_itree, 0, ULONG_MAX)
-		if (!span.is_hole)
-			iommu_unmap_nofail(domain, span.start_used,
-					   span.last_used - span.start_used +
-						   1);
+	iommu_unmap_nofail(domain, iopt_area_iova(area),
+			   iopt_area_length(area));
 }
 
 /**

