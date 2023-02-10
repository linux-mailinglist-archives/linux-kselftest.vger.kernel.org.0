Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A825E692913
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 22:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbjBJVRl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 16:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbjBJVRk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 16:17:40 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C880B1F5F3;
        Fri, 10 Feb 2023 13:17:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOYZNET15Fyf2yWH4fOA8PO6GedJc3hILNn8n3bxjo6MU8j1w8BpVBnog0Tqt+EESy2+MXF5mnuBtCzZ+6w+2J+BK75Btyk/dYv9IyaPdZY+3glEzVrC7Wkxw4zanynZwMR8oOXDkuT8Bq9htjPdiPv+ouBJ4sqT9LaqPyX9o2UqzZxMgCzgWZCKFp8H4w9ivRIDZXow4wQ7z3RzD8nn8KY3DYq0Sh1HdAF1aK7Ie1odGAxvSbzxBDseSZkJSoAdnzh41h/dvwRPGugRCiqZtyVILhbK953B9RPwmUY0uuyjkZpwQRh9+mICvw8F7XZHMTDVTXBGk2H2wEN1C3fALw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0xXcA3c2CFuBlcoqfw1DhRPDr02PK4DNL8ocKp3B5c=;
 b=c6ZXl5Lz2qIL8fOVV7bUfGxBPqH/IcJIT2kPiIv3ZAIV5AyeefaGRLK98VG5ZFPnNhq9SZbrhlJTUtHvPHCRaZcAyEpENstXMlXOwe8M7yLzEGV8Yu/QAiODJJuRnUQuID3dNXsvNl6EhvuvvSKWz7ryTjFHhf9l2HafmROJtpu1LfkkkinILkmSBV5ji6Oz3reQDqrJ+4WudiFmATw7Lpc7KbgInPVBcir71UlUb6yozbf+9ZHP8kI5+qm6FrfF5Cjj1sfdgtltSFVEQmv5JsRGOtZzKbmU+oZiCReDIYh0v8mDj5ZJohtz4EIl7z+H8GDJwdCBHYQMkonbFhcGIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0xXcA3c2CFuBlcoqfw1DhRPDr02PK4DNL8ocKp3B5c=;
 b=sUUYp3bKq5FcUUGeUZakyUn4cUJyX06fk0al99g9TN6UTe+MQaaRE+uYjgD3fqHvPhK/eQ5vH7uhrSeWF7TOjhp/ff0Ycuq2polvUMzyhmOGWmSTdp4ByNy0uX3wEIq5fNxW+G0A3nilziRXwObCndSI0hbnybVoiK4ozJ0u88TYO7uNg6db0eOjctJz4pQmNb1LWu19VxaBYcqF2N579NSlJnYGnijq52TwWrwekoTMEbs654Qvhbz7OCYX2BgfK/XCZUB/hHDhr3VQ0eGEbNaehLGQSNGrARhTn7/qtFwe3qHAslO+0tOXIS8RyA21tmqcrKnhS0pxkPOaUpOMnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6282.namprd12.prod.outlook.com (2603:10b6:208:3e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 21:17:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 21:17:23 +0000
Date:   Fri, 10 Feb 2023 17:17:21 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 07/10] iommufd/device: Make hwpt_list list_add/del
 symmetric
Message-ID: <Y+a0YUwd+MVMZ1dN@nvidia.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <9d0d4f935c4972771f5aed4b4837d8ae35814e06.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB5276F36D2F07209AC7155BAB8CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+Tz/kkZ68e9QWR/@nvidia.com>
 <BN9PR11MB5276CA32940B6886F8238FA38CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276CA32940B6886F8238FA38CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:208:2d::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b9c8370-c277-4a5b-01a0-08db0bac3390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /CE5+ljC5PzX2aDrsYiDmbfHCxgyaot/tXjlVkrVAjq1tlwQEW6CBSZ5QvPRWh/dFtoTdPW2mktV4LoPf6pRunpYByZSQaF1VvqKumuK9tmsBjlrWfQTi0aQhRfuLwukSuHcWGdoAKlsnks82SgR+PVaBQDvEA/LqXv6gJ2Cv1oJ+ABeOKloTuSXx7mrW2jjlKkINBOZESjU09Mn3DVVa3AAulU2kxHGp56Cag0bK9D1VLBNZwRaF64rr6jCsme0cNULA5uB6E2jPlf+QKh1+0Q7msjDyXDC/++7BZGGLrv48u0Eb6jHMpvmO2YVpz8qycYF3VwZNGJEB5F0JG63KTtG/sYMvWMQn1Sa6TrLDUT9XioIfeuOM3fTKfHsb2QwjC6BThlwF3PFB/r8JQmohddX3RR+FqyelcsnPTAcAlxBv7XPGAvremVPLsiuKzIUAID/fdpeEt+lQ3aaturTAtgvAiF86PS/3ijgvlgE2ozQV2Y5K0ZyQ4OyL2KxocA+1VXkYzzooB4OfMXNMgTPzGGkX3ILJ3nMLO7GjFDjLlnyH4BvmQsTiu1EwpeJCKSy/wrEkw9dJyj0nrWj/XCsQundUFyJqkTkyK9ZRBwWRj4vvS6so6sMZeQcCh3JSQtOU/4YHPfCs2WCIiEcdfqhdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199018)(83380400001)(2616005)(478600001)(6486002)(186003)(6506007)(6512007)(86362001)(36756003)(38100700002)(26005)(66556008)(66946007)(4326008)(6916009)(8676002)(41300700001)(66476007)(54906003)(5660300002)(316002)(7416002)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PRGbuljNeDFeU3XFv1wakvI6arNA/OdZ74O5TaX9inN1wM5mnNP0+6VRW1a4?=
 =?us-ascii?Q?TvBKxRWI6sf1pEYPRXdoRGe3bGXZxrem2iou8v7PwSnsxZLlBdM+Zu7v+zxM?=
 =?us-ascii?Q?Mnm/bN2o9qln5lja2T9zzDyjgp39+E+7vK2gSG1SeuvulH1fAZAGxocnmPcM?=
 =?us-ascii?Q?42KxmOSjn/jYGLH3s5DbUpCCI9dd6333lAzB1k0UBTdv0UcjSBfu5Z6HHSkz?=
 =?us-ascii?Q?qmBVd0lD5TFV2aBNqKe+CpXAg6ga5vgcgxLKqFlVmzIiomTL+p/grS/JdSM1?=
 =?us-ascii?Q?VmNsolNM0jpepFuFNTSU1enkxr6PiDmoiQ5w3CBndCguvLGKbi5PCU0Bh4NZ?=
 =?us-ascii?Q?FyYbe//MO9Dd83MjZI7v6j3BffztNYxsZP/Urcgm4gRHBVU7kA8w6boF56YI?=
 =?us-ascii?Q?Z9Do4Jf3AtrJnm14VimDH7luBc3LQW8UhF3vZwJzJJVAnXyaeaU/MpnHNHMg?=
 =?us-ascii?Q?auGE8JpoxjXm11t+iYK7nPi3lMEptQOPW7QFlxneThGcE8NMZFVxcP1gOcO9?=
 =?us-ascii?Q?iiiEHrkFSH0PE13D9zOPu12BpOYfSy6oxug6HtL6rT7PtdWit1xZu0Y8au8+?=
 =?us-ascii?Q?9QfAGAt9dhZXV463wwGg0svBUCxkmrw4VFfsSAujQ0RVdjaXu6z2hQw/wTWx?=
 =?us-ascii?Q?Ako0gzAAQvZ8eB2EZqSUbbse7RqlS2d2Xq+PLoHTUZ/arpNfLy1s5UBmVK/b?=
 =?us-ascii?Q?L1EhvzQ/BzNEMZbtyNORJ8R3MBCqY9aPYgFjij5q4gqxblJCROm/rZkbfWqf?=
 =?us-ascii?Q?exreAWI4u8WEr6hXkYzc2TzkufFopeVqFlJVF+szapjDtKvsFeytRnjS5B4k?=
 =?us-ascii?Q?sgc2L6O95X7myU3CaLI9YJH5olefTW5ts0xCd1fQBm+ucZ7FFsy32qUs2kXE?=
 =?us-ascii?Q?F0l4wr7v9K2vU9E5PscSoDqs7FBnQVEue6HvTqL8AHuMqB1XoP2jECmoRmak?=
 =?us-ascii?Q?/Qgp4ZTKNIiS9GKUBb+2JGPpe+lL95FZ6KbBe1hudIuJp9eGt7+K0mvHD0oc?=
 =?us-ascii?Q?YTx0iFbMlSseYYHn2YnatJloSUjwGRKMVa5h7qUo+ueOhfnHlUin96kT4DPe?=
 =?us-ascii?Q?HzVZB/DY9xshBq7LzA83vZ3gjdnGMSkwvzxzy4nF5qoyyD9QCMFkmx4R3rCd?=
 =?us-ascii?Q?UDS+fHjnZjN1tvjXXYaDP+m+DoTfzri+cOXRfXuimPqcRHmAlDPqCgzaglt1?=
 =?us-ascii?Q?G3imRaLCiWuqtpdz5bdEFiLDTyRQf/zuYq1c/dTh+MczjE5anT7Y6zv/kLbo?=
 =?us-ascii?Q?tyP8y0SpCO5SnjXT7gNDMEe88OvCkNV5kqqLUieS8cI5dA3GNVfVA+7EIYM5?=
 =?us-ascii?Q?ImsSsc3JVsxJWkZv8TRu9i+sQqFNTSzDKd22iRUrYQmlw5RWxDG/57GDi8A7?=
 =?us-ascii?Q?O+PV8HuLKriVhrM3L6Y4SddVur81coblSZIca7ZFzeoKSrIJkX2wH6txVZzT?=
 =?us-ascii?Q?XDLX1URUrEhtEe0jBNFs7Zi0uMNu+3MiDFWRmVQfCtKuu8NnP2bL9G+DIVUU?=
 =?us-ascii?Q?Rmm47/ZKPns6bAM2TRLQKdKtow78rQC5bpbmU2d3uNZFig6w1HKMwhts21r/?=
 =?us-ascii?Q?Rd49oBc3cY8fh6d/pToNGaB5ijkKXXzwFWsenj/F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9c8370-c277-4a5b-01a0-08db0bac3390
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 21:17:23.3707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zUxLpjS96fMGlIt79OVav67I6QiKK0HWHnKnKB1qIfs4ByyVjheLrn0fZGeChCs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6282
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 10, 2023 at 01:46:18AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, February 9, 2023 9:24 PM
> > 
> > On Thu, Feb 09, 2023 at 03:23:47AM +0000, Tian, Kevin wrote:
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Wednesday, February 8, 2023 5:18 AM
> > > >
> > > > Because list_del() is together with iopt_table_remove_domain(), it makes
> > > > sense to have list_add_tail() together with iopt_table_add_domain().
> > > >
> > > > Also place the mutex outside the iommufd_device_do_attach() call,
> > similar
> > > > to what's in the iommufd_device_auto_get_domain() function.
> > > >
> > > > Co-developed-by: Yi Liu <yi.l.liu@intel.com>
> > > > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > > > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > >
> > > shouldn't this be a separate bug fix and backported? double adding a
> > > list item would certainly clobber the list...
> > 
> > AFAIK there is no bug, this is just reorganizing things
> > 
> 
> there is semantics change.
> 
> here is the current code:
> 
> 	case IOMMUFD_OBJ_HW_PAGETABLE: {
> 		struct iommufd_hw_pagetable *hwpt =
> 			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
> 
> 		rc = iommufd_device_do_attach(idev, hwpt);
> 		if (rc)
> 			goto out_put_pt_obj;
> 
> 		mutex_lock(&hwpt->ioas->mutex);
> 		list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
> 		mutex_unlock(&hwpt->ioas->mutex);
> 		break;
> 	}
> 
> Above means every attach to hwpt will try to add the hwpt to the
> list tail. Isn't it a bug?

Yes, that looks like a bug..

But this patch isn't the right way to fix that.

The HWPT should be permanently linked to the IOAS as long as it
exists, and the linkage should happen when it is first created.

So attaching a HWPT to another device should never re-link it to the
ioas, thus delete these lines here.

However it looks like iommufd_device_detach() is technically wrong
too, it should only detach the IOAS and HWPT if it is going to destroy
the HWPT. We can't hit those kinds of bugs ATM because we cannot
create naked HWPTs that are not autodomains.

Maybe something like this.. I'll look closer next week

Jason

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index d81f93a321afcb..4e87a44533048a 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -279,7 +279,7 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	 */
 	mutex_lock(&ioas->mutex);
 	list_for_each_entry(hwpt, &ioas->hwpt_list, hwpt_item) {
-		if (!hwpt->auto_domain)
+		if (!hwpt->auto_domain || iommufd_object_alive(&hwpt->obj))
 			continue;
 
 		rc = iommufd_device_do_attach(idev, hwpt);
@@ -304,6 +304,7 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	rc = iommufd_device_do_attach(idev, hwpt);
 	if (rc)
 		goto out_abort;
+
 	list_add_tail(&hwpt->hwpt_item, &ioas->hwpt_list);
 
 	mutex_unlock(&ioas->mutex);
@@ -346,10 +347,6 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 		rc = iommufd_device_do_attach(idev, hwpt);
 		if (rc)
 			goto out_put_pt_obj;
-
-		mutex_lock(&hwpt->ioas->mutex);
-		list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
-		mutex_unlock(&hwpt->ioas->mutex);
 		break;
 	}
 	case IOMMUFD_OBJ_IOAS: {
@@ -390,14 +387,8 @@ void iommufd_device_detach(struct iommufd_device *idev)
 	mutex_lock(&hwpt->ioas->mutex);
 	mutex_lock(&hwpt->devices_lock);
 	list_del(&idev->devices_item);
-	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
-		if (list_empty(&hwpt->devices)) {
-			iopt_table_remove_domain(&hwpt->ioas->iopt,
-						 hwpt->domain);
-			list_del(&hwpt->hwpt_item);
-		}
+	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group))
 		iommu_detach_group(hwpt->domain, idev->group);
-	}
 	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
 	mutex_unlock(&hwpt->devices_lock);
 	mutex_unlock(&hwpt->ioas->mutex);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 43d473989a0667..b11738bbdff7ec 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -13,6 +13,11 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 
 	WARN_ON(!list_empty(&hwpt->devices));
 
+	mutex_lock(&hwpt->ioas->mutex);
+	iopt_table_remove_domain(&hwpt->ioas->iopt, hwpt->domain);
+	list_del(&hwpt->hwpt_item);
+	mutex_unlock(&hwpt->ioas->mutex);
+
 	iommu_domain_free(hwpt->domain);
 	refcount_dec(&hwpt->ioas->obj.users);
 	mutex_destroy(&hwpt->devices_lock);
