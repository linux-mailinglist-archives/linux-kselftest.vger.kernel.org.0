Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B676CAD39
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 20:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjC0SjJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 14:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjC0SjI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 14:39:08 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7B32736;
        Mon, 27 Mar 2023 11:38:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyvbWSVbWs3j/mi2V1zsJFyip7GJrBxrNRHGFtbW4ANFF5jFhRCddMBEHdNd04WPjo+AJThZralT8J6P5XmW/qUfKO4cgJYV7zmtx1vTkT/WBxFed/E3wfR9AvtQE1HPuQ6U2S35hiCNtDPSZY4cgWHhhujHAwKgD39mlfgbBELw5v3Fncamz/kA8yyz3LbMdoYCc//IeAMz3VOxkHKLxShr65qpxgAoD/lnCAjH6Vm107oL+LRLNvp63Pmxel4Iq1VAuUOZUJigSo137lFYuc2k61JKSwzac8IANoCQVof7IwCi8dSkEj7UqyDz9pNicbGPYQsVgXEi8fqyjxDV3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CNS2HSmgh3e1COJZn4Kj1NyOKZJ52hw9Q0p1GlmnsY=;
 b=hc/GXSqeI/mhp2o/1hDvlTIsveiGrRuFfEAVbUVQ43Sf0t6JflQk+gvz8PcwC/PBYD0JVjCFbyPb5qeZclMZPXnx2ws9GbX8m9fho8KsVyDjqdWoZU4pn8E9DI27uOgzGUtTqN9u8sTLZY8R3hXm2EVJo0/4ajbgyB+8b7Lp/kJLDccazagsko0tWyPl8FnYNGfR/Bmi9CNkCZtbHN/kiKVRzevc8GlV63L6qSXmQPMLwwDi61LdvuEtHSeYGsDL6173Nsna4j/Vf0YlcwQ/fS4+kndQkc1yOIY+GM1eeENnPA7j4lGdhY2ipGkzSiVhUnq9xir5iFFbiUQUg3b5mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CNS2HSmgh3e1COJZn4Kj1NyOKZJ52hw9Q0p1GlmnsY=;
 b=lI1O1itLs6aPbicecKaeGzp+oeGoXqIp3NUpvGFWENYrJcaKM0ADe5db/IylYjvSEIO0UCwyYhtO5phJcHTxzs+4Mj9Z4qlA+WS79p0tl3OHEZr4QSvh7fN6yVv+xQEYcNNSiKn2MAC03Kjl78Z4tgSSs7MRUF37am5kRstkJ1/ney6ACoMdKWax5EnsbSWQyKTkhy2H1SMIzxY4FXfB5SZPvwyuyLYEWzbBmETzouj2922+2tvOITXSjZ8jbS36l7KLlTyP9fwU4Z7onOYgZNaI3eslrTUgRrRNGVPCfNr/vvONW4VEj5XxQBplO5WXo3sMdsLUYjty4PgyKyLmnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 18:38:16 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 27 Mar 2023
 18:38:16 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v4 13/17] iommufd: Make destroy_rwsem use a lock class per object type
Date:   Mon, 27 Mar 2023 15:38:07 -0300
Message-Id: <13-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0181.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e5c59b-871c-4fe1-5b6f-08db2ef26bb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SJEbcgCf/dIDZiuukmENVAma75XuxcA3sNiM8ffp0LD57/TDxQtQwnqODDyGwR5j7eLp1upWwRbGwfRsY0rbtq4WXXOSnVs3rxg3eoItBviVJ0T28712RWSzChHDSrZwiDjNzfaP8JQ2nSCLEDp7BwxLWb3DaftqIaFLQbFUn6qKdY0j1FnpEjNitNF1Y/zOhbpastt6+OpDnE/fk5TKcDDNGrfqiOvcX2rs6TjyNyXhXSgdPjxqxVDdhztn3iPikCP1dE2eKb1OfqYRiWuJzQ8gjpiYZ6eA3Kgog/4+2HFLVgSjAiRE/WGczv4JWowTW548XxnosWi6b1klWtAZcg3W/LDwVCEyo6Ji85Wo4eCq72WWd+tTq5bPUdCgoHzYaVc1hqG1rapYF1NizHQnqhJGwd7j+w6/dCZ8gmB9duWpns/dHs2SfNBdhNitO2CweA6KKARWcbpaweI5RYBcszTTYaAy59gGIggImgyPxyhsHfCzP+m4L350yFUAfh2GXXg5SP+loSc6ZMgDxrGMDTSZuOUBQw/X6m6Fgp+pbjcmdFBlhOIiIC6ADB4YVNFJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199021)(6512007)(6506007)(26005)(54906003)(6486002)(316002)(6666004)(4326008)(186003)(66476007)(66556008)(66946007)(8676002)(478600001)(41300700001)(86362001)(5660300002)(38100700002)(2906002)(83380400001)(36756003)(2616005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fioGnzBRuomCqWA6u6Q4vDXtbVzsKsnk5rl/nM680/wQz2sMu+OM8e+hGOfI?=
 =?us-ascii?Q?0B5gqd9Jc+iT/MS8z2yr9f8KKcc/PQ4GbQD0C1VN2OHJbd6caFQkgEnKzH3I?=
 =?us-ascii?Q?uczrLmb0W7oRx3BqfE2Vo0uTE0Af2wV5KnLoaLuAI3CtExKjU9V/eOOIlgk0?=
 =?us-ascii?Q?zx46HSobfEWhwELc9K9deHyLVzoQxxMCLRbX5kC+07HCOqwpZxxy1YGsQ9Pu?=
 =?us-ascii?Q?NHR7djdmKv90eVw15568zBpD88bn0ih17UyKZso1iioVuftgipFesRl69E7Z?=
 =?us-ascii?Q?ZzkUTFxqI3tAITeYSFFthOk3Z+xDzIxpP1YvDKpQ4CTeZ+WplEGjUZ+KCy7L?=
 =?us-ascii?Q?jKP44+VCkPnceeVcFkHGQMVw34z76i9zYj8TbYLwBu9n6wmzT8kz1fAkXnog?=
 =?us-ascii?Q?OHgCtHUiJz33tKT1FMVOfwp0x/GR5JpJQ6XEU0dCCSqQqwskRm5c0jDc/XJE?=
 =?us-ascii?Q?Qu1I4DZT2kvp269FaDqO82vs9Q/rNV4mdzGkZOHjYFkgZ7li05leRN19PRTX?=
 =?us-ascii?Q?3rPGecHgrDcC7WFbuo0ateTecbnfPaHtU3oriWtr24Kq3Qm73taM+8Zp+Pri?=
 =?us-ascii?Q?NM39+qpKASCAIwiZ3e6YyR4enimLDWfI0cRZduP2dgZpVHwp3GIoUNFUcZ6q?=
 =?us-ascii?Q?AvXMns6oTMYgZJbXfbEWqgrSqdRW7X6315GfD553X0z0/vf+8BavIks5FK9X?=
 =?us-ascii?Q?UKN0RE5m2u+npeYIwTrtQTBNMcg/oJO9vVlLin7eDmItq8mxwtT/UugiXH16?=
 =?us-ascii?Q?lgBx/MPS37WNg1QPnG9mBr3fTh9bZlK5oCA/6YG+/ELSC9TYyUxJK3qpWfkD?=
 =?us-ascii?Q?0g28C/bUojFjbvVlq3B/HLoXcbfOs6JiYSwB+iOAfTANRnij+Ou4CclaAVZa?=
 =?us-ascii?Q?33BGx5gMAw62GSkE5H3SzVWLFxR0DIUquAwn2Cer2amioT06tn6RPuccIckS?=
 =?us-ascii?Q?skVX6wz8q765bz6Ld1TzhBUvQ1mDFs2pq0XDXiuNHuWd0cKaAPh0IHgptZDv?=
 =?us-ascii?Q?2yEaW9+XNWBTFln/Uh6V0O6fGGmV6pxRQ4Zk1dzNi5XGgTRHLiZ9xp0+NaYC?=
 =?us-ascii?Q?2+oxdT4lgI733RXnD4Y7IzFj4u2t22Vc1Tgf2jBvpUYkBuKYqfi93E8X3lPz?=
 =?us-ascii?Q?8+hTmjX4V8ycog6ObBv+wYYjvx+P153SQqDPHz/r8Xbwe6eUqPbG7cJmuz8p?=
 =?us-ascii?Q?nFW4llPcP7wL128wAt6PJAAxNcB8yaUdFas6zhlQ4BnHoscuJoiy1liudYTH?=
 =?us-ascii?Q?cmIyK9kV4rebcjeHuQQQ4b3E2TuQf2qqTN2bqpkRrvpg5tJWxZFGN0PIzz40?=
 =?us-ascii?Q?1GqpDmtLQftDG2NC8Zh4L6taCvC1dCyHHsuzP3vlexRqfm7GucIRB5Iw+AX0?=
 =?us-ascii?Q?eWzoFR0S/wWZMBsikyHdyA1Ci8tBQu9iEy+svEAEAEtBLrU302+OJOUla+Qj?=
 =?us-ascii?Q?uIPsmWW8Rc2o/JE0sXf4+4qtpESwuBgIaK9X23/Nt2GxkIpZQhkArOL09RjY?=
 =?us-ascii?Q?G3uEUx5qhwWDIhOIEa+PwT9RdxB3a2BYzeUyiWVjZQPGOLHED996SO9SRPl/?=
 =?us-ascii?Q?Zp4q5q+77LzAvyWtKRuDziWvV3B+1DtueI6K0GZd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e5c59b-871c-4fe1-5b6f-08db2ef26bb5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 18:38:12.9255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYVCJ4sLVeRQkiMBP5gi/67csLViHZs7gKjSrepBAteGqMInUYlQX6DgNVRavVpJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The selftest invokes things like replace under the object lock of its
idev which protects the idev in a similar way to a real user.
Unfortunately this triggers lockdep. A lock class per type will solve the
problem.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 drivers/iommu/iommufd/main.c            | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 471a3fdff1e0b6..f80b012e1bc200 100644
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
2.40.0

