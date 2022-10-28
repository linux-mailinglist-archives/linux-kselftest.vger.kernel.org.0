Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4056A611A76
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Oct 2022 20:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiJ1SwJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Oct 2022 14:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJ1SwI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Oct 2022 14:52:08 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4B51EEA3F;
        Fri, 28 Oct 2022 11:52:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Thw4T37r9uSPSSHskN1ksxIrqFt89s9tIiKaIqs36lUZ5L/0glEa8qEZOClKmlUWbecPDkVUyIWMVIMl5I1Ft/o/qb2t/bqje4AEW5QpG1shbuvqEUXbx+JHH2HWg3rh2NPpWiJip+DWyzK477rOAkPLQFBjiwwUoNgm7mnl85tC13/is4zdcxZFFP34WxVqYZNOedS5IRLeBfGFnDWMUndof8tpw70PaZZ9CsVCwGhpggcklA0fqFJLVTix32Xg4haX/71pmHhkhsq+OkaPi5iW83rF4Iukxna9ZmAPB3B86FJf+OQzi573cuWmmk5WwTNbgRwGqEsikvUkdmkGDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axyEna9E4CFC2t7xa/FduLAv8Sf9E/WHb8LgcHiSDcM=;
 b=YDqpfhCy+KIDZtEz7iYeFtnCOT/ZdaqSItX3aNff63R7i7mvbpikiMJArmLlopsjaAW83iVCzZeCg6crOzpg2W3a8EIAsVAoIbuwpKGV8cUIvbg8dwME2LLAeVjH+02APDafLk3Eupixp+Awc8bslLcE0tRnrirQfogn9GItbisLAjsWhO9+J25NufSyf5WMyULl6NmlN2jHqx7GTlVVGeNtyGqZAj2zmS4oVMfYkWZfFbhWKw/QMWn7Z3n7tPjs1TZNc9/RBp5w2F5Ukvqjweg85f29NqXNPrj26HLMBTLMAmrXrCkh89vdQ09HAOsr3KKEZfa/XTyh6QEHLkLkMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axyEna9E4CFC2t7xa/FduLAv8Sf9E/WHb8LgcHiSDcM=;
 b=Mv3hlqyhzEnWkDHl1Hc1lJ+gFv6YTrDkFIB7LAATjiVMUNeWSrLwbziDXb8nFVI6PFPgG7/f8JiY5nQO1X0t1ES4A+oJsO07lmbNer9NM74T1vUEgF+ni4tIhWXYpVIc5yxYmBi7Scklk4xIIXJnAuUvj951qP3owrkGRYRpSPwn5PczcnqEW7OGO12cMObKZ5LQ+YInn2/xDWKDIbhS/8LFodMuUjLsQvRnt3Xc5Tlf30tv28CH/GpjoSVHAMwTFYAvtfrpON0kxxXIRfE1cW5GYJFknUqvb+rSVCvZq4x9z4pH91xHpNoJOQmmqnE41Lu3ZD4vYRXFe/HgfGxoIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB8036.namprd12.prod.outlook.com (2603:10b6:a03:4c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 18:52:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 18:52:04 +0000
Date:   Fri, 28 Oct 2022 15:52:02 -0300
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
Subject: Re: [PATCH v3 9/15] iommufd: Data structure to provide IOVA to PFN
 mapping
Message-ID: <Y1wk0ge6QaVDoVbX@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <9-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
X-ClientProxiedBy: DS7PR03CA0197.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: 5776edd0-8ab2-490d-1528-08dab9158138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XYad4a3mlKy7HtbRpbGItpMXASBo9Z8uTQ9IEdbFF905Jobr+a7381XhFt+jZ0F4cEO4C/+7JLxktXDMmSoGKIK5EceGGMmek5/AR03a5jgc1Iaz64P8gZN+4pvsa54AATw08hnOHh3YNcGwDGaCzyOUOORkfC8iZwUc7pZ7sNSYU4eELbaQ3WrvSYtA4Jd9FM0NK4dyGcv19WAoPcfxMhmKXTaWlMQAjvsRHi690cGKOLzbN9eeHWCsim+tOw31D0d2IEoSZCaXFOH4fSRyV5USdxDnKXmRmk0Kqe/WAW8Fq+gpFAVlY96pyTRkBfD6nrwFhz+xkzqDcyvAQO3fvbA0P700mYh94ZmFVNs07UTIDo5omzVyHTR0jsb6R7ZzZpjX2u5czOE8hE7Zr5fx38gzYq0uqqR03M36UvhdeQaTRe3QuT3gXh83jyBTrNFa/17XJCSM20gMclZ2/8nsY6UR8KKB7zGZXBzwM6ysMxMk1rP9ZzJ10bbNBs6vhsCmfp32LvoHTrYxkqy9VJxUAVcM7pr2ALreSFt8zs5IKBAzqycEIgEuHyuQu47PVm9Fwyv7AUgb/28qH9dp6RuC6SMUX7tY5+hv6ANPKS9eqsNjKsa6owiQAebz5XpZDls6nLltFlFVt3Zo+R6jzErFKkkFiQdKPEYg/iaVI7taZ3Dp6qkCzaI98pMLpr83qeqPayyUoqG1FoxHlZxIgjjWM0pM5OVLzNvlM7fiH9NEOILTnZXd5vXE+vQC7n0Bq94H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199015)(41300700001)(5660300002)(2616005)(7406005)(7416002)(66556008)(66476007)(186003)(4326008)(66946007)(2906002)(8676002)(110136005)(8936002)(316002)(83380400001)(54906003)(36756003)(921005)(26005)(478600001)(6506007)(6512007)(38100700002)(6486002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?plFdSgYzFp+EbyJs6gHEr34W6MFV+mMH3yYEABCqJNMkQtlNkxqjfB1oqFp5?=
 =?us-ascii?Q?FG07UgxLWv1VA2glUAqVwSQQbNxYht+oulSF2CrmThyC1gECjiXzGItUnRUe?=
 =?us-ascii?Q?JnHophrfHEZLm2JPCtznou+s+W8WbXBGFjS3B4LN3lSaD7Cc56JRii53m/q4?=
 =?us-ascii?Q?oBZSTVJEULpX4dlQlQ0YmxqVDFI3Vv1FMVa3P/SVp8oZ+Sumyoh65cV8m8fd?=
 =?us-ascii?Q?qppsT3v0KpT8Lm6KSqdPswlxm3B6Z6SV4Ij8QseYI5vBU2MB4vgjXPoEmB5Y?=
 =?us-ascii?Q?hEtoKRCcQ6AszKZ2lW7ii8SHIesEZ5Gg73Ef4Hy38BPs58lizKTwxoYvUmFi?=
 =?us-ascii?Q?gyB8X//Q43fmy0avjEGIbA1zVqe2JQzQij4VSzFvXvv5VdsSpefYfdYf74+n?=
 =?us-ascii?Q?2kURe/791fLK+ddqV8Xh7nebhRMLY4tGnk5UN12Vw99gmdlouQsdkdO9N+ye?=
 =?us-ascii?Q?76QoG1+7f9KT5uMyUFOeivV8sGavg3NqgkviOQ3c2QSncHVIJMvWZuLj3d3V?=
 =?us-ascii?Q?XVqQfDup7EgQODZyRGQzE5waAq5TnEbZF8ECvpHYGN7wL60p4kZ/4GtsLkdf?=
 =?us-ascii?Q?7Bc3Dt1MZLbibPH/lrmm6LeimLvBnFvjCoJS5E9OJVPKmV6V2HnTysJQIy8X?=
 =?us-ascii?Q?ID5FO34Z6NTW0BqBkOuPFsEWGMqdP8nydeDNQ/4TX+H4Q6MJmM2uJ5omZmy4?=
 =?us-ascii?Q?H2QSE5BbwLKjCblbHsQ71kLJ5pB0WMEyv4J2PvLdlbaNu/KBWZ+mtimqTQq2?=
 =?us-ascii?Q?0tE2wVZQxv+11yf9yQ3e0kfg1IG5712cCsTT3+NQpXQ5LiTRU7iwBLOUOAFU?=
 =?us-ascii?Q?fGHT5cqv0HPhSsWUC9c4XC4n0pKY1t0S3Hxpbrce+Ii4WWpGfPVGEXbZfpW1?=
 =?us-ascii?Q?zaZdC729zuWCz/Zf8/r0tEfS+qoYNhbTu7CDNFyh+QouQIlfIyAx0uXK0qGb?=
 =?us-ascii?Q?qBCc284vgd45hEbRKRm7pOa5X38eolPuYUR2YB/yCiDW+a5RmNgP64NapjjK?=
 =?us-ascii?Q?r4NKHE0qSHP+L5O+y54Q9BB5+LFWvQVNo5pST3x7h/+1MD3m5HO8QUGwPzdL?=
 =?us-ascii?Q?c6oX+DHtbOoup3taR4DEMo8UOLrOiOye95U+soMjNnevgFWhF3DNMIfrspjs?=
 =?us-ascii?Q?2B00jeSfjLTIje9ulNqTBV4kb+YgyIUeApFHcWVLSHKB+fKk9XODEQWCTnrH?=
 =?us-ascii?Q?wmcenR9gjUi+6YBTS1kL9eezNlhYNFx+URewO3gP5mRDT1X0cuRBEgILHsjN?=
 =?us-ascii?Q?oR8OPdsBcrkW7pNczEWqxlZrXiFxaiF3sSQGbfQgT+JsKhP8CiTrIGw9DTE4?=
 =?us-ascii?Q?f0CfDEJZFr/3jSKIyiiBdgPZVldJT05mwej+A2BC4JVPG/R3UXZTNdWBEjxc?=
 =?us-ascii?Q?AuI4pBU9qzjLZLnsC2Omhcf4DYREPlsljr/F8KdH0S/mlhwctwA4KFBSfpNl?=
 =?us-ascii?Q?ftQoANnra6Pmw/U9w16gkqA7eUR53Mwf3y7AKA0THazUk2Q5n2a5puEA3Wb7?=
 =?us-ascii?Q?n3rpblxt6dGGW833MWR3SlRhdjGPpC0dEU5ZhW2ftBxn3fPEGNcPjLfXhQmz?=
 =?us-ascii?Q?6idu7UwAg/rJ/GmFd0k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5776edd0-8ab2-490d-1528-08dab9158138
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 18:52:04.1297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9n7XNrymbxtVq7T3mHhDj+KQTUnoBBHjl6cGDHV1NfX3tVaH9AfDOwc27JCZ7mAe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8036
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 25, 2022 at 03:12:18PM -0300, Jason Gunthorpe wrote:
> +struct iopt_area *iopt_area_contig_init(struct iopt_area_contig_iter *iter,
> +					struct io_pagetable *iopt,
> +					unsigned long iova,
> +					unsigned long last_iova)
> +{
> +	lockdep_assert_held(&iopt->iova_rwsem);
> +
> +	iter->cur_iova = iova;
> +	iter->last_iova = last_iova;
> +	iter->area = iopt_area_iter_first(iopt, iova, last_iova);
> +	if (!iter->area)
> +		return NULL;

This one is a bit neat, syzkaller discovered that if a copy range is
requested with a partial area in it then things go wrong. The
contigous iterator is supposed to step over areas that completely
cover a range. The little thinko is that interval_tree_iter_first(),
when given a range, will return the lowest tree node that intersects
the range. Thus a leading partial intersection of the range to the
areas will not result in the iterator failing. Instead we want to find
the area that includes the starting iova, or fail if it is not found:

@@ -35,7 +35,7 @@ struct iopt_area *iopt_area_contig_init(struct iopt_area_contig_iter *iter,

        iter->cur_iova = iova;
        iter->last_iova = last_iova;
-       iter->area = iopt_area_iter_first(iopt, iova, last_iova);
+       iter->area = iopt_area_iter_first(iopt, iova, iova);
        if (!iter->area)
                return NULL;
        if (!iter->area->pages) {

Add a test to cover as well.

Jason
