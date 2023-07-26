Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2A5763920
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 16:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjGZOa0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 10:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjGZOaZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 10:30:25 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C1ACE;
        Wed, 26 Jul 2023 07:30:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8XAnjCmbsbMmStvqN3MzVClCKyYey9yz+Ra9weNCq+FNq7oFRVxfrTbnkuFDoj5sRIXwRpLpyhnFaIDjLpswGslV7O8D/CGb7dPmoH2ErHbc9bnFCe2P37T0Wx4jsOuNiFh199DEBo+XLjPhumh+DX7u/RNkX6bfqUzl+aZf2D/4j9noh5cKTkPY6KckmDHoa9i76QeMJMT3T1UhcRyB0qIc779aOWWt+dglBk5wKAUp8/8Y8PnW/luG8+m4slBUYewmJONflfSUGKatE2gbHkdOAvvPiEGsfDvsb9IWgu6hXuEMD07Wsasfnh1q3G8SU0CGdw4CYz/RRPKTTjjIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUjTTUDISvu+u1W/IE/Ih52BmG5MSSZi78OTqFaaDN0=;
 b=jdOfyOkBwgsDjcev2RCFFiwrVVa4uR9QiJJrryamzWKQ7+yy9WfZ/7IrsuwopQPwJFq3iOHj660hoVtwCUjcX+/6qJXhcCjP0wryzfueoDdsajwShBvuswG+ps6f5oP4Nt88cBxeA86+Djpl7fBrHv/ezlwy6tzZ5pQwhX9g2wJwpu/MCRr56x2IjtKrSlMuUWjAsni4gr7m09UKmPznWHoBPrQtTzMeq/X90Dr0CFeqskuoUzW/jYLlnGXCXnyMzXg/5ebGFAHcNQU+/0AoNR0WAeKAX5sAO8ecoJfawUFZ85UBzgfx/Hh19HRf3P7iGFJsivKVw12Aoabyt6AheA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUjTTUDISvu+u1W/IE/Ih52BmG5MSSZi78OTqFaaDN0=;
 b=GMA1aJUkxvq27yySyV7IUZpTxz3UgGVCHdSt/IqqI9qCs3ZKlUuTfclSe+mIW9PD0S3twq87pEZFdPsmUlRJiQORW0t19O2/+IElgdYcHNNO1m58tFIVsxB0uw2SeGmfY8JmjlfQ0BbAv7rzqv6yG7VYx2seSjxqh3St90kOp3jcFMIzM+011w8xEhWjLT8mvyjOn7AIQQZ5LytxlFGUwqDeGIycbNCtFGIfDuThFPBA8qzEcZtJoX81kFi8zx6wRgvRXn0eO5Bw+b/uWYI4brcPk8cdBrCIFgen5OPYJZPbYU+jdrKgBWA5YFb3G5ZEeHAyc8/1IDwsRCHK08DEeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB7696.namprd12.prod.outlook.com (2603:10b6:8:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Wed, 26 Jul
 2023 14:30:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 14:30:18 +0000
Date:   Wed, 26 Jul 2023 11:30:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kevin.tian@intel.com, alex.williamson@redhat.com,
        yi.l.liu@intel.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        mjrosato@linux.ibm.com, farman@linux.ibm.com
Subject: Re: [PATCH v8 2/4] iommufd: Add iommufd_access_replace() API
Message-ID: <ZMEt+SMFBMKT3AoT@nvidia.com>
References: <cover.1690226015.git.nicolinc@nvidia.com>
 <5dfe3e9a9d511919cb105459ca9d96f013daadb4.1690226015.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dfe3e9a9d511919cb105459ca9d96f013daadb4.1690226015.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BLAP220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: b27f0b79-8fd3-4318-1601-08db8de4d599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZIcQYAnNuTjSCu775Tdwdg+hBsSw0Tp0ef/HvQf93NZGNtupxxSZH3JxTLTAqaAYaO4nfVmmsAMIxqFNf7931AgQ5LlzN7cneA936T062qlAZpFsUzLlczDk0lMHKJvqgpzVJ/8GUnH3O5ZoP+RZRxGXYW9ZDKW3RcTRchVl4GiLj5QmGYRI/k+Zc4Ctsu6eH20V8cekKPn3nK/6/vJ0q64iyJ/eq8MUNri21EMPxPaYTtsSRG+tZu8dcDJ8Vw+KbBb43zE4oHuGsH+bLNW/xpTrf8GOZ812y6RAlZXvF47IBIvFEjjOx2AarW0tiXUkzCQxq2B6v4xb97vFMOX0jYjSGWqkyG+jAv0qWnJsIYBFKsiCxUIWnIKRjw7YqtVbrF57M1P0eyHgQd1Yms5BlOwc8KkdTtFSubX50wNX7eEHJQF6KeuHuZA4/QPB3pV0PjjnGFpWtTLsdxRR2enxkQYKMnS01bx5NylUlhLL4KUAbBl+9DCKtUNzm3rBQZzovxlr6BQGGMXPvw3MpNhu9yoTwpmOL5cyL8CjKIDcuftb55j4cj+X+zeId2Lvknh3p2ZO5vxbe2Wd9qe+A7f663OcoYQpcXxCHyrC7ZhLhU8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199021)(6512007)(66476007)(83380400001)(38100700002)(2616005)(186003)(26005)(6506007)(41300700001)(5660300002)(6862004)(7416002)(8936002)(8676002)(2906002)(36756003)(6486002)(316002)(6636002)(4326008)(66556008)(86362001)(37006003)(478600001)(66946007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cGszn+P4u1ZfY4RH058CfRoIEmj4t98QJD8Zr0504AEzhefIvNx34bcy/iCe?=
 =?us-ascii?Q?13cDtpbxvhszEupQMFyd16ZmlYW6CL01P7m61M5s+geE7jdXUgONbesvoVb6?=
 =?us-ascii?Q?rpFjlRNVUglBfAJaNt9z0TnJjsWNbJ2m6xY8w29PYj0NoF+EoACcC5Br2+h2?=
 =?us-ascii?Q?/Y/2OHa5CrZyyjUe3I0Eb44IRYC7hytkoxGS8bb2dusK3Xj6mBkR1yTprA+H?=
 =?us-ascii?Q?ro36/vCj7FsWsY3q/gNCxSpVeUNEdYd0BuQJV41x7CpybY/LCZmZXElMG86h?=
 =?us-ascii?Q?zX221zfEYnKygNxYieOl2aRW4deMILmKeWkdW3R+oSgI5XBNWXc/y1L9ksPj?=
 =?us-ascii?Q?D0vrOQwmOAXkXL25dc9sEMYaQ1EHlups6M8eIAoRWHCnYdTCY0iL3zZAAPuc?=
 =?us-ascii?Q?JgsdBXLHLgj88TjvErawmqPMP0Z7yaWZnNyN8U2x5t8NpNf6HCqso8f/3bZw?=
 =?us-ascii?Q?30SKv7kdtmOOIsIPLtb2rFOWHph3f3hCj8VWnVS79bVMIHCon/m2yc5IM/19?=
 =?us-ascii?Q?IEyVyEEcF2bMVECjOetzUfNNnBbsE4SjLcSGNfQ3jU4peupDPG9oIVxJqDQW?=
 =?us-ascii?Q?pD81sapeaFXdToEghp6Nzk3A/qRjD9zvcMwlOhSd5oqrpRpYjtPycTZiOgv4?=
 =?us-ascii?Q?3ozenNbu2Wouu59uWDtPAdmvkAN+O3i0MgzZO6gwppxdfHI79y/lYTTTvALO?=
 =?us-ascii?Q?5JEJah4/HYR/YpjICg4ZZDlY37anh/gAnOc3c+ymS8ZJGlXTKytFIWcaGRDc?=
 =?us-ascii?Q?iGOl7pieIni0tkgRgWzKFSQs7N2WINMojXKlvK5GRq7WyvptC0NFMHBim+jx?=
 =?us-ascii?Q?BszMKvboBGijroq/tK611STDyK4GmVt17Rgd0bNotHNbgvss9Ez+XqAOu80M?=
 =?us-ascii?Q?3bxJglMEejBHpYEq6448nGfKI7TOOf1HFxJLMm6Xji2VrkIgHezek94U+vbd?=
 =?us-ascii?Q?Zn1MJbudR8onIAyzcU3xDQmHHjFSR7PHUgMHXt8AkrpkK/25waXaBojIII8u?=
 =?us-ascii?Q?beiKmztsDi42hvMAxRv16QMLB5QvpcWOAZMpotesal4RBnQ+Mpl5jqiArU4A?=
 =?us-ascii?Q?RHjwUL4JlVu0NIoutgt/uR+uTg/wbY9b6XQMg4O0i+uZGVLYQ1IGTmM8Q2qD?=
 =?us-ascii?Q?YY8Niij+rdlwHgn04kksTDikYYAnpgOL1wOWa9MoMZBWoxNJP+PlvFQyx6Ka?=
 =?us-ascii?Q?rpCZU8SZ2VZ6xa79av3nkR+xXQloQVrnqLi+tTvvDHlg4XIteRYYdKAOeGM6?=
 =?us-ascii?Q?3DseOPW+/Yu/Y3DhGDJHQFjLeaMi8z81dA9C25sHuVTP5+feQFORzWL51lVH?=
 =?us-ascii?Q?xK26A3pUHf0RRKRr/igTBpBHJnzX6EfQipjQ5qPewSFekARZsXcb5xH0P4bl?=
 =?us-ascii?Q?cNeidR7xnN487BHy7yY3HkMqY2PHS0c1SGyO2TErpLsILrnEoC6QQm3dtADX?=
 =?us-ascii?Q?jRCufpmk0IZyUXbQ28HW4StJrTcnQIbb7KmVTngXFoMsLE4/ZdcIsEV1WYMn?=
 =?us-ascii?Q?HHB2fLalvMahetqfO2UnsHmjUZH9ClObE5Ld9jnVXt7nXk03wYXL0IYKZ4+l?=
 =?us-ascii?Q?cu/+WDxCE0vo1Kvxkhn9UjklTh4Rav2fojdop7ZG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b27f0b79-8fd3-4318-1601-08db8de4d599
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 14:30:18.1177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ooxq699v5SdoAYRngnNTGnhv1yiIvTBQfUltBb+p6kgxJPAKWHMKZsmTsz+JpwpV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7696
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 24, 2023 at 12:47:05PM -0700, Nicolin Chen wrote:
> -int iommufd_access_attach(struct iommufd_access *access, u32 ioas_id)
> +static int iommufd_access_change_pt(struct iommufd_access *access, u32 ioas_id)
>  {
> +	struct iommufd_ioas *cur_ioas = access->ioas;
>  	struct iommufd_ioas *new_ioas;
> -	int rc = 0;
> +	int rc;
>  
> -	mutex_lock(&access->ioas_lock);
> -	if (WARN_ON(access->ioas || access->ioas_unpin)) {
> -		mutex_unlock(&access->ioas_lock);
> -		return -EINVAL;
> -	}
> +	lockdep_assert_held(&access->ioas_lock);
>  
>  	new_ioas = iommufd_get_ioas(access->ictx, ioas_id);
> -	if (IS_ERR(new_ioas)) {
> -		mutex_unlock(&access->ioas_lock);
> +	if (IS_ERR(new_ioas))
>  		return PTR_ERR(new_ioas);
> -	}
> +
> +	if (cur_ioas)
> +		__iommufd_access_detach(access);

The drop of the mutex while this function runs is racey with the rest
of this, we can mitigate it by blocking concurrent change while
detaching which is if access->ioas_unpin is set
  
>  	rc = iopt_add_access(&new_ioas->iopt, access);
>  	if (rc) {
> -		mutex_unlock(&access->ioas_lock);
>  		iommufd_put_object(&new_ioas->obj);
> +		if (cur_ioas)
> +			WARN_ON(iommufd_access_change_pt(access,
> +							 cur_ioas->obj.id));

We've already dropped our ref to cur_ioas, so this is also racy with
destroy.

This is what I came up with:

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 57c0e81f5073b2..e55d6e902edb98 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -758,64 +758,101 @@ void iommufd_access_destroy(struct iommufd_access *access)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_destroy, IOMMUFD);
 
-void iommufd_access_detach(struct iommufd_access *access)
+static int iommufd_access_change_ioas(struct iommufd_access *access,
+				      struct iommufd_ioas *new_ioas)
 {
 	struct iommufd_ioas *cur_ioas = access->ioas;
+	int rc;
+
+	lockdep_assert_held(&access->ioas_lock);
+
+	/* We are racing with a concurrent detach, bail */
+	if (access->ioas_unpin)
+		return -EBUSY;
+
+	if (IS_ERR(new_ioas))
+		return PTR_ERR(new_ioas);
+
+	if (cur_ioas == new_ioas)
+		return 0;
 
-	mutex_lock(&access->ioas_lock);
-	if (WARN_ON(!access->ioas))
-		goto out;
 	/*
 	 * Set ioas to NULL to block any further iommufd_access_pin_pages().
 	 * iommufd_access_unpin_pages() can continue using access->ioas_unpin.
 	 */
 	access->ioas = NULL;
-
-	if (access->ops->unmap) {
+	if (cur_ioas && access->ops->unmap) {
 		mutex_unlock(&access->ioas_lock);
 		access->ops->unmap(access->data, 0, ULONG_MAX);
 		mutex_lock(&access->ioas_lock);
 	}
+
+	if (new_ioas) {
+		rc = iopt_add_access(&new_ioas->iopt, access);
+		if (rc) {
+			iommufd_put_object(&new_ioas->obj);
+			access->ioas = cur_ioas;
+			return rc;
+		}
+		iommufd_ref_to_users(&new_ioas->obj);
+	}
+
+	access->ioas = new_ioas;
+	access->ioas_unpin = new_ioas;
 	iopt_remove_access(&cur_ioas->iopt, access);
 	refcount_dec(&cur_ioas->obj.users);
-out:
-	access->ioas_unpin = NULL;
+
+	return 0;
+}
+
+void iommufd_access_detach(struct iommufd_access *access)
+{
+	int rc;
+
+	mutex_lock(&access->ioas_lock);
+	if (WARN_ON(!access->ioas)) {
+		mutex_unlock(&access->ioas_lock);
+		return;
+	}
+	rc = iommufd_access_change_ioas(access, NULL);
+	WARN_ON(rc);
 	mutex_unlock(&access->ioas_lock);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_detach, IOMMUFD);
 
 int iommufd_access_attach(struct iommufd_access *access, u32 ioas_id)
 {
-	struct iommufd_ioas *new_ioas;
-	int rc = 0;
+	int rc;
 
 	mutex_lock(&access->ioas_lock);
-	if (WARN_ON(access->ioas || access->ioas_unpin)) {
+	if (WARN_ON(access->ioas)) {
 		mutex_unlock(&access->ioas_lock);
 		return -EINVAL;
 	}
 
-	new_ioas = iommufd_get_ioas(access->ictx, ioas_id);
-	if (IS_ERR(new_ioas)) {
-		mutex_unlock(&access->ioas_lock);
-		return PTR_ERR(new_ioas);
-	}
-
-	rc = iopt_add_access(&new_ioas->iopt, access);
-	if (rc) {
-		mutex_unlock(&access->ioas_lock);
-		iommufd_put_object(&new_ioas->obj);
-		return rc;
-	}
-	iommufd_ref_to_users(&new_ioas->obj);
-
-	access->ioas = new_ioas;
-	access->ioas_unpin = new_ioas;
+	rc = iommufd_access_change_ioas(access,
+				      iommufd_get_ioas(access->ictx, ioas_id));
 	mutex_unlock(&access->ioas_lock);
-	return 0;
+	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_attach, IOMMUFD);
 
+int iommufd_access_replace(struct iommufd_access *access, u32 ioas_id)
+{
+	int rc;
+
+	mutex_lock(&access->ioas_lock);
+	if (!access->ioas) {
+		mutex_unlock(&access->ioas_lock);
+		return -ENOENT;
+	}
+	rc = iommufd_access_change_ioas(access,
+				      iommufd_get_ioas(access->ictx, ioas_id));
+	mutex_unlock(&access->ioas_lock);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_access_replace, IOMMUFD);
+
 /**
  * iommufd_access_notify_unmap - Notify users of an iopt to stop using it
  * @iopt: iopt to work on
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 0ac60256b65929..ffc3a949f8374f 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -49,6 +49,7 @@ iommufd_access_create(struct iommufd_ctx *ictx,
 		      const struct iommufd_access_ops *ops, void *data, u32 *id);
 void iommufd_access_destroy(struct iommufd_access *access);
 int iommufd_access_attach(struct iommufd_access *access, u32 ioas_id);
+int iommufd_access_replace(struct iommufd_access *access, u32 ioas_id);
 void iommufd_access_detach(struct iommufd_access *access);
 
 void iommufd_ctx_get(struct iommufd_ctx *ictx);


Jason
