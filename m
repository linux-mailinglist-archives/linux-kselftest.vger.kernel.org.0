Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDD46A2581
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Feb 2023 01:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjBYA2J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 19:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBYA2I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 19:28:08 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2073.outbound.protection.outlook.com [40.107.212.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA1918B17;
        Fri, 24 Feb 2023 16:28:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4tCRjr+aUJ1sOGEEX3wioa0l3nMDXSjxyhdByvxVdAZOqfHkmALna5WYiRjJfw3Ot9g7OehUXCyG7cDNaaH3PT6Do2hwGpKopGqb0ywPwcZl+t48rdpckY70e5XTBH46t4bYx28fZjkWNuIdFv+A/LHhgYzhW+9Bb2TFXV4NsZzPwr4l/yiz4FR0rSIGEvz+JsuLKL8puUslIq8oSeUntO8DuRu0qEmUmOdmJXF0/A9IMtHe1lUIsniG7uQq+JNMN/IAHzKsVUFeJACjKht8SOA+YjLyASXnaaU+cN0SlVvnneYD26dwP9SXQOCwVvezIzp0NnbZnd8bDfdhkltng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfkDS3OHo5KvGeEkDinURCWayrdEg6pubPX6m+SQ2yw=;
 b=ajbmv29AsEktEV9vpk8C0uUcbYRUbXue1Rhhnp5M/n+bS1ORDUj6O33W5aol1le8zFrXjPXl4SHRngPLtvJ7j3sErF0d+KabykdAOFlsnqNYe65oX42VTwCk8P4sswn6WpVSr+fSdJd7VcvpdmNxGuU/VwqvH1Fu1gwTD3YkFezRwwEh0JwPrkGMNZmjQwBymhWYE3hYSp5zPNGMEl9MHNfRgtVTtBNBo3x2SLsxQqu6XW9lUjnc8Y9f+L93z9l/YNYi5xGhI72fy1dMHRL3pVoRKMydTmHCIcsxN2aHWlgtluJw2KJf4tPQvazdubzyPJgEwNRZdr0qy/MH9ZVoig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfkDS3OHo5KvGeEkDinURCWayrdEg6pubPX6m+SQ2yw=;
 b=JsYpXj9HQa5EDtaSrlpW/jiV9t7WcxjLtJyhAIkpVpKGU0xh0+BpuhZNGlDumY294DdUKqavsLH6ZdiI1I+5xtAzr6boAdqFUcdr2s/YCaG8gbmzNkU41OejQrK3dWDwXAplYBkLqmcIprcokMf6Aac4anEIRklkCsXbAznynuEINyndrZsboEUCxki+eu0HYtSHDellNfcF0jyoakqHOQdBa10czggGoQwU/9++FZXQnaG4Qv/nblBN8PXq0bXLnCJzQFagUEaCjrSmBIqE6SDlkkWR+/AEx8Tgxoiobbh7JAv0ko5uZNztHQkKLQd/zNnU3gpJ35OxR9HGkcqRzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB6096.namprd12.prod.outlook.com (2603:10b6:8:9b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.21; Sat, 25 Feb 2023 00:28:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.021; Sat, 25 Feb 2023
 00:28:03 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 10/14] iommufd: Make destroy_rwsem use a lock class per object type
Date:   Fri, 24 Feb 2023 20:27:55 -0400
Message-Id: <10-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0033.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::46) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: 402d8fc5-03b2-48a8-c8d0-08db16c72707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GygNCsJuvlDlWtTBwl9JWVcRAfeOP7dd1jgBbDG/Wm5xJxI7ejxUxi3gqL5HV/g9JK8gvY+iT3QKtUO7eoEbYemv6JLvtz/mFVUXHdxKWRSlEplf6ISlVQWGbNPs0oHNJCZus/uLkrsytGoh5h+tK4W9+urNXgfJN/kjOEsaeif3z2tdH51O+q/lUTJ+fnsNf3L96NdqBhIelz2vJZbfScXV0AheOVdtKQTpLevm7zblICV1AMJB+rGAHZF08Ayg92J3C1eccGKTdggVCXtEWs0qvGNlaTd43nD6STZ+5L0fbET1K0j5YzpPCGMJZ/le2iQRO36Via8DZRnSeG0XOuBlVo+0J8jk/4orsEbael36e4O14C8BRsBNLeQg5/e/FHpDurhMPcNHIaTGKvZ1hPOKXdDu4biGuwjgWppqujB6w8iEnWZ1lWL+PfCxm83eokXDCzAqE/LcIHUqFfeb/1FAuPVotRtbKl+V8aqSWwviW1Y0xiqfPd4LE/2KU3/+sxZ7A2axnyHFewqRWVcMJsMpgGAyfi3wPIELG+OltCXw9hSp9VHMCxerrXsQHrGGIV/pImuOdZjO7DVDtEn3Rf0UNHgrxg4R2/qyPKLmOD1QgvpcdidZitYlUGXSsAJ1ck0wXnG5I2JmIAuOmRhYEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199018)(2616005)(41300700001)(83380400001)(5660300002)(54906003)(478600001)(8936002)(4326008)(38100700002)(26005)(186003)(86362001)(8676002)(66946007)(6506007)(6512007)(66556008)(316002)(66476007)(36756003)(6486002)(2906002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0fTVXTXZAU9UorreBhSw89ZXwm6JLk8yHDKNna32EA4A0SKSarOf3/qRTLAj?=
 =?us-ascii?Q?TH5z/ziCvopLPeKJRkctZwEDM76tV9Gm4SisDhkXzOff8Us9jh1Exz3rUHd8?=
 =?us-ascii?Q?z8Y1kDjDc31JTLOW2k00w6Cg7hOuTOCGUPQkTA7jDu+6xVxHr8CaTqCmm6bN?=
 =?us-ascii?Q?Dv1d5GSCYVKbU5L5/IccfOkWHLd57woXq1VoEByAvjdxfC3nXfzftDpQSkYS?=
 =?us-ascii?Q?jwQJ1JOW0qrlj3yrG099puyXrjuDrT6nuDixIpdOQZpBa1hfxoyZPw7cRm/6?=
 =?us-ascii?Q?eNHU80aDKP3daygnydGkHQ116t4t5VyEspGtgw98t0ej1+gWIXO7dMroIAP0?=
 =?us-ascii?Q?UB0t8NDJB66+bHZAMhjG2A+yEHu2/DEZ5urbo5yrvuY0uM1jRieOuvGeDfw4?=
 =?us-ascii?Q?zmAKK0lj7C2r+z2skskccTP2uV2Q1VVLnNG4rU7EP553h4tYVlcFhVFA9dBm?=
 =?us-ascii?Q?eipuylsHNH9esCMhOseDBlkkOGHodApiY/lVcXU+otuZyJYsP8gWFdoPRmE0?=
 =?us-ascii?Q?S35VwdrlcAHy33qAxRGsZiUd4DBEtOyFlZOhH28Xm2kx5Di5HhmGt4mKtiFu?=
 =?us-ascii?Q?xjV8UQtNTTkb3h0ohVu9R28YtjhFFPEeFngJZfKb9lubhemyayWkRe2pQIBk?=
 =?us-ascii?Q?kWdUAxB+Jf6G4pjmdPI6RpJReiM1cd0qp1/PMJea6ol0lvwbA6KfS86uvsJt?=
 =?us-ascii?Q?EpOcLJJ6uP7cCTmUAjwwRiSq+1JSikS5Zs+WytzwOtAILLSdBAm09NITm101?=
 =?us-ascii?Q?Sie82YunEuaq2/tY715SWqGVxlmsNoGnb4Vj35YKQeqaUZqPYZoSdn/IumPS?=
 =?us-ascii?Q?KD5EAZe/hNLJBxQ9Jq+nulgOsrXOU+NBX9mbCx+x6gQfH/FTtnhF2O9/Xd7c?=
 =?us-ascii?Q?XaghmcsnhflWoH9mG13SFJGbcYXV83DzQtx8KGG0yU0p5tcBZmQrj3TA5hmz?=
 =?us-ascii?Q?JzuS6CcoKNgtxB593l58GLEO1xnn7nBKBM28/d74nGT9K2O4RjtGGH64WdGO?=
 =?us-ascii?Q?7fkQW47cSbKbH4SQj5nHFG2esHgzQ9GdJAzIwQ3CM2/qbRFOSSKp9x7LdsAc?=
 =?us-ascii?Q?xKaS9jqkF91Nlwglm6LK8QcT35SDzvoUiCYTBbav4LlsVgp3lmBTNsWqdla1?=
 =?us-ascii?Q?WJFQSFWjafhREkpqo3iSY8pR7fb/bbQ9iHeSbQgx1d7pRcYjusf5TCyVjFUN?=
 =?us-ascii?Q?wrZnS7ju7wY3jQkXLuSTXExl0zK67btiGkt9qH/vy2PN0GCgNZh/KkVG5s8i?=
 =?us-ascii?Q?dd14dsaf3SGe0Ty17OBytknSobZmoG34TGJUOwfoIgWvUXvUB9QS0spWMtBx?=
 =?us-ascii?Q?Y7kiEs23KI1hFJiQfUDwrypYg+OrZ3Y4HaY21dsUn2Bx7H21pCcC3S/jsgoW?=
 =?us-ascii?Q?JY8piMLPIN+jHJblLIqZOYmGJ/Zj9iYIupWs+isPFVyil74dJfE5dVIh2lPe?=
 =?us-ascii?Q?8ZU4NHg9D6fQIf9khyhNYYB5c2YdsuT+Rfzf6UkRMGwITSLBfylPqc1nzcqL?=
 =?us-ascii?Q?QqbKcp/kM/azm7g2UDPdBkj7+9+x0uEsIVA3xG1EiHAE3pnmP9D+AZv5JVhN?=
 =?us-ascii?Q?qSoydDse4PI1b7nD8WDi6cdLfm/5yz6Ui+WH2xxV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 402d8fc5-03b2-48a8-c8d0-08db16c72707
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 00:28:01.4368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WouUf24WuEOlOpw+w7tXmcjqXv0+kK8LlTnA4gBg0xjBZgRwO7JlvjCxwf23Ut4o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6096
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The selftest invokes things like replace under the object lock of its
idev which protects the idev in a similar way to a real user.
Unfortunately this triggers lockdep. A lock class per type will solve the
problem.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 drivers/iommu/iommufd/main.c            | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 8921761ff98980..cfcda73942b533 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -119,6 +119,7 @@ enum iommufd_object_type {
 #ifdef CONFIG_IOMMUFD_TEST
 	IOMMUFD_OBJ_SELFTEST,
 #endif
+	IOMMUFD_OBJ_MAX,
 };
 
 /* Base struct for all objects with a userspace ID handle. */
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 8597f2fb88da3a..9cba592d0482e7 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -32,6 +32,7 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 					     size_t size,
 					     enum iommufd_object_type type)
 {
+	static struct lock_class_key obj_keys[IOMMUFD_OBJ_MAX];
 	struct iommufd_object *obj;
 	int rc;
 
@@ -39,7 +40,15 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 	if (!obj)
 		return ERR_PTR(-ENOMEM);
 	obj->type = type;
-	init_rwsem(&obj->destroy_rwsem);
+	/*
+	 * In most cases the destroy_rwsem is obtained with try so it doesn't
+	 * interact with lockdep, however on destroy we have to sleep. This
+	 * means if we have to destroy an object while holding a get on another
+	 * object it triggers lockdep. Using one locking class per object type
+	 * is a simple and reasonable way to avoid this.
+	 */
+	__init_rwsem(&obj->destroy_rwsem, "iommufd_object::destroy_rwsem",
+		     &obj_keys[type]);
 	refcount_set(&obj->users, 1);
 
 	/*
-- 
2.39.1

