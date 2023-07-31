Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C0476975A
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 15:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbjGaNTS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 09:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjGaNTR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 09:19:17 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A3CA0;
        Mon, 31 Jul 2023 06:19:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvtDww6z7RZTVhU16Z8gqv+QQHH6YRcnxWh4VU2UvdfkaHiA/TdAnNupVH924CWzaGvxXwu3T1GVbB8EHiil+8K57UAUzGxeb5rXcWY2LTOfNbNti9ZHdVLvdwqJRrFpNr5EhxuBeH6vlb+k1s9xee9YU+8/WBK9trKNH3z/gPYgvPe/bcLWBTHRLvE2jb+U7i07+AtdBFBkxIEyq7Q7LaX/tsd4pWs2kBgYlyPSSAHGB5K9k3Q2E+p5y/Fo2r41APga2vix+9U9LO6huPCZiqc5ozEr4PFXdn37BdSFzeRvldok2HUOb/cibza5w3JZQBLIzCdHKulEr1GSvzAFbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lj1qsnzPox+fS6WGHhQNgXro+zNhWHfC4yXZMS+lY6s=;
 b=bJh5TVg9iiWpx5QJw7FQ5mzcuv6JUPRHyNjMJoRv5JwmLCrKBHB9IrszKtsMMdyHdcLhj5Sp7uzmdESwzXWAtQpxUesZfvxqRXqSHpBgPXTSfGmeWSOA9Yc16v61FnX2AiQT2AlLmVscDwDkA2mq3PsLvPjdxKYH5YBae2/sfl7DMdqPsLgXArapvwDxXDKwihAh1Pe7JbR3A063fZXNXP/RKHV58HeW3YldcKjUOBdW2Tg8C9cmdEvkrBcZeoZIB1XaT6ET30jQFnCZNP4DeIk9q2tq50e5WqRkj97nZVGO3enRZpBT2hpaOenkttOB9dmYII6fZ56FPUVs4LQZCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lj1qsnzPox+fS6WGHhQNgXro+zNhWHfC4yXZMS+lY6s=;
 b=HFDCus/CINbh1AvWA8abVti3dKoskkbB8BNGq29mi+nyxPC3IT3OPBkZvJwXoboZ2wlWv3Tw8gHyuptPrhrTETpjeM3iD6BZVNc59r2zVRxPA+rfY9gIs3eAWmDohRoanQCdyjRC0mwD7d7L2rCqs+z+wv4vYaFs2U24lhUCTALP+1bDrP/f5PYHrMPdoBD4aXadVIgiSV8pBYhaUsHODzLHAUnCzgGTuKzR8Bk9MqXpCr51XR+giWbn87URo3L0tmgfGnwNtNEwANl4Z0Y0YrenXBUJevArVYnhir7EIQu+4j6x9Ow76WTzDYXWMqoSQ2I3kNyClwx4/kxP+9Qq6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8456.namprd12.prod.outlook.com (2603:10b6:8:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Mon, 31 Jul
 2023 13:19:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 13:19:13 +0000
Date:   Mon, 31 Jul 2023 10:19:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v3 09/17] iommufd: Add IOMMU_HWPT_INVALIDATE
Message-ID: <ZMe0zQ/29/gLGBwZ@nvidia.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-10-yi.l.liu@intel.com>
 <ZMQCw2iiIqa4CXNG@nvidia.com>
 <DS0PR11MB7529696366A4447EF0945E87C305A@DS0PR11MB7529.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB7529696366A4447EF0945E87C305A@DS0PR11MB7529.namprd11.prod.outlook.com>
X-ClientProxiedBy: SJ0PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c37df66-ed19-48e0-7bcf-08db91c8bb63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yd164vJTAlkAMt084hZlCUANzNgkk5pbNFRLBvGDt5ixRBdZDQX8e0idvOuY5AASLuxFWgFkTtMu6fb2AZIPgIJXNJL+bDhqkhxP7nEVNWWOlBjf14YlW1WvO0TVMfLOLsYgZcwuOp/sypT+2yk/K6ZNgbWAfcVbDdcwoK8DrvQUPKFoJk3fvh8n4F2s7b3w5IjIsb+VzWEe7AlGUU8fyaiCoYJOL9ItTMM7wymJ9vjlkCRCjqi1yTcukCLK7ZMn50Kzrl4PE6KjfQTbglod0zhOVAgY/eO4x4i4rbAB897VKS+PucOUuMXREqjJXHKC7yhOKiAncrP8+ThC3PKGyFedvRaRmNh0cUVDxnG7J4xErdZExMMRc06kUajjfTk/KL5KN01aRycNyjSwCiNNr05a2ZgdQ30gjIPMAkEcTvgzFo9KQMUY4dlW8FNoJPdM/q/fYl8L+SwsyOyvRxmwng+7Z2ZsTBLUTM2L3Vr/H+2ylXy4YGFgQSq9RuwuOdg5IagcvMeYAP3zYtS1H481ZxsA2j45nfWETJSlQUC1+iSzph/2ONUI4AHAuJh1fBqX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(6486002)(6666004)(6512007)(86362001)(36756003)(186003)(2616005)(83380400001)(26005)(6506007)(38100700002)(6916009)(4326008)(66556008)(66476007)(2906002)(66946007)(316002)(5660300002)(7416002)(41300700001)(8936002)(8676002)(478600001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Tq89mmSxnAMT/wTCaf/oEZhkqQKtVR9ECBO0tEDKkTLsdMmZhPJtjYaMYZ/?=
 =?us-ascii?Q?sk/H2qBvY7zUzBy/ehOPCZt4nHZCfDEOgcCvcBjVO7xONv56C6xqQz12U3T9?=
 =?us-ascii?Q?81OKYbzUuW2t7kbdCFrP6n15VJILQenX1EexJQdMaB0yngAHujCbI4h3vtOv?=
 =?us-ascii?Q?K/hmeAtXfT4ZhoqySYilO8v5LGg8vVt+uZjrkR2M4NBQuxzNy+9FxtsUMqOM?=
 =?us-ascii?Q?trE8hvLTtfW9U9WHLeqLlCdmZcJZ4BoXdEWy7V/0eUY8bnJkdvoMG3xCx06Q?=
 =?us-ascii?Q?e1u2Dmk8xZ5qj4gIeFYXsvQWUgKZo6VM/ooP9NYlscmb+FruU+Ukuxu8QE8f?=
 =?us-ascii?Q?eF/fTNDmFxXYZwA45qXX96rQk/8F8xvczp+0jhrC5Ncs+MlxgKy8hKYIum1v?=
 =?us-ascii?Q?Iqg4mzNxmIxVGiHFcX6gROISfMq++YDcBjoodIo4C9pXEGneitorf+u8WLBY?=
 =?us-ascii?Q?lZukDs8X3wrog03CvEHvSGaxMDmTEbH4FZilYGgFhZOO35SgsleTgRFsR2L6?=
 =?us-ascii?Q?OVsjT37uPBhG3MaB1YQ9Vk84adieWa1nnE70VhMIRtarDASzF4ivaPQQkqGY?=
 =?us-ascii?Q?offZohbT6RDF7TTBM/gbCvBPSNNWyvdlA2FMpjD2+5Z5b7vRbxV9a0MkQbha?=
 =?us-ascii?Q?Ntc75FnAKZvV+39GWk41loY77nA9sSOLuXQu0WQoPYJdwzgqzdJhwwkuO5nH?=
 =?us-ascii?Q?99KMqZdGaQy6yExwR0rDKzhIO+mUxwTSKESTf0IWCFzSZur94P7gGevYHcR3?=
 =?us-ascii?Q?t+4pOjV+FFSe+4v0BLn9/qiuh6l3RSId5S83hh9BiBQ/HzfwklZQ2guDu0+3?=
 =?us-ascii?Q?dQD2INez9mvfH34nSbpcAvO4qvuuQ2HDY6bb+JGCc6JJm4iKET3/V9mD8ThZ?=
 =?us-ascii?Q?56oSLIFJYLiu6rWh8mzix1UP7niMEJIRAYnjpmmHDzgw+u6k5RHCC3G28dn6?=
 =?us-ascii?Q?a9W8BCpG1kRLhbFpFxdFrLWgezgdq4NRoF+DLXJI9AD8QDFeJelLWb4hlsDi?=
 =?us-ascii?Q?2YRmejaHUOMlFtWUXCjYNNCvm4l7nJF6izkcGCnNeuT+pUvb7sB61EYSILnQ?=
 =?us-ascii?Q?MCXmyqkIETcMGLKx4M6V+6SGoYg2CFH4gR1tKFJIv0Y4Tr+azqe/hHt/xMfF?=
 =?us-ascii?Q?jC4lCaOaLRxUAWUmUkQXRs5qAuOax1fkzutklEN2NDN1+0i1QMzzPM0JzvR0?=
 =?us-ascii?Q?z5/hGrnFvChDhsjw7zRgw8DbCUJckSTl2nTWAULgiMarHm7r8tgzvL6GUcvm?=
 =?us-ascii?Q?dr6GcrT0sgonHZYmgGaQkRcOJg0sEfS0gPFnUgqkwgsjFQwZlrYLpq4H22YP?=
 =?us-ascii?Q?oeCJqRrLDNu9HnQwFRJkJyc7tZaQ5TtLwsHr4IxeZXnQDcqDdz4weSnwKiEM?=
 =?us-ascii?Q?32QQ+YSU/Ey53DeZccSgzppyUZfL/ttZhIZBrZPQACDY++OAGBCti0gqXYp3?=
 =?us-ascii?Q?j0b5jqJ6zjCi38X6YFox6BqnJJbQVzHiYSvM8VtIbqFmau0WyTzpxHiyTcwC?=
 =?us-ascii?Q?SUf/LD1toNOTYZsP05+lSrZlbwt53hNJbDqxLBp14yFy474g2f+UHZdy87b9?=
 =?us-ascii?Q?bqxZMp99fuDEGcSq3q70wXti46lR6S/bxKWpO0nP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c37df66-ed19-48e0-7bcf-08db91c8bb63
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 13:19:12.9266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gY/r78Zxa36A+MT4PHWwPpVlRFbvZ/RAq/MXKoSpEimAqq5v2QbUTZ9cqBwnE55m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8456
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 31, 2023 at 10:07:32AM +0000, Liu, Yi L wrote:
> > > +		goto out_put_hwpt;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Copy the needed fields before reusing the ucmd buffer, this
> > > +	 * avoids memory allocation in this path.
> > > +	 */
> > > +	user_ptr = cmd->data_uptr;
> > > +	user_data_len = cmd->data_len;
> > 
> > Uhh, who checks that klen < the temporary stack struct?
> 
> Take vtd as an example. The invalidate structure is struct iommu_hwpt_vtd_s1_invalidate[1].
> The klen is sizeof(struct iommu_hwpt_vtd_s1_invalidate)[2]. iommu_hwpt_vtd_s1_invalidate
> is also placed in the temporary stack struct (actually it is a union)[1]. So the klen should
> be <= temporary stack.

Ohh, I think I would add a few comments noting that the invalidate
structs need to be added to that union. Easy to miss.

> It's not so explicit though. Perhaps worth to have a check like below in this patch?
> 
> if (unlikely(klen > sizeof(union ucmd_buffer)))
> 	return -EINVAL;

Yes, stick this in the domain allocate path with a WARN_ON. The driver
is broken to allocate a domain with an invalid size.

Jason
