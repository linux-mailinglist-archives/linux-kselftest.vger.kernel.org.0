Return-Path: <linux-kselftest+bounces-2654-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E133824F42
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 08:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB37E284DED
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 07:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCB21DFEA;
	Fri,  5 Jan 2024 07:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aGcGJB2S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E402B2134A;
	Fri,  5 Jan 2024 07:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5+uU29fV7u31KVw5gBnD/ekDwf4a9WGIuDCNZDBzkbQFyJEcYG5uhcRoEG/rx4IT9g52xHaUMzszvbqWJKFHKjZUpB1ZwZH3yk2w9cSFdWY2PRaHll6NLlW7l0Ajz1nsr+NEwjJtmdxByFUNwDEOimHkPyifIwOOBxAuLbxdH74a4+cVKTiZJE2H9wZYehUJc8VhM5LEzpGyoI/kaDNu7Ur1M3tL3ye53178QR6yGNQClQuBNzA3wv6FlLkejzKGYKLpee5jei5hfLW9G87Z4N0PgU6cLnHFrC7ePZ+Dk0V3H+HhA6keQLGxHqFWZYgsYUUnHnUn509V0cEPcnrOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVxQdUzaGM4z/PADjmgKO1bLWhVm/seNRf3hqiv/Vk8=;
 b=LJBisCz5/yMWQPOKAuaiWtyBNPZ5Gl29NnaMmpafIUUyYB7GfiAIvPvps0YPsh8bBxEFSICX1YxOeKH6rRwjhb+IJvwRx9ZfS40TXk25lNvGlB6eRSEP1MPxfZ5E2kxHj98nCFbo/vXAye/EiGjCY0LE0Ol9GURpMO/Yw+UJzcXUN0BanswngWtz2Wrv6MwvwGXpOvDnAASi4HQlCowr1VhczcPLMcrMaIEuxHhCygHUFlJewee7Cmm7AnQ7ub5yfzI8rpJfdaqq6xkKaqX0Hi0e9HQp5l+1T2G6BsbGsgd1cxfkwhHk1rowCfaOC7yMobJA3S6SactSRhcr7oGFBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVxQdUzaGM4z/PADjmgKO1bLWhVm/seNRf3hqiv/Vk8=;
 b=aGcGJB2SdIWnGNUflkUkL7zhkbsznGElyvGtz/AAt8GTz+UdgDQQQOA5t/ldpVt4URhmtvwkE2LZUS9mw+ubgLH/NKcKlSmRJc19/8IYsrauDFKU3YmGBekfb2t1GUJ79ZpzAJyG7ajQP0+ad+PrdaJBtbXTqNyE6V3P4ucoSuB7+kiRyApxJUD0Z4OMaJ5lfyDPgp9tgUAwKZoFCknIdlrL8WPCNDG8xF/jBve4nkSqlgKxNumqozeHyfVpKPAg50uQM3QwtperX6f2ofMxpX/606m4ZknAIWJ2AwdgQgNKwKi4Ia0XBISEWu0HjL/dJqTjliu4rMVHe63Gb9ecOQ==
Received: from CY5PR19CA0083.namprd19.prod.outlook.com (2603:10b6:930:69::21)
 by DS7PR12MB8291.namprd12.prod.outlook.com (2603:10b6:8:e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Fri, 5 Jan
 2024 07:38:56 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:69:cafe::e4) by CY5PR19CA0083.outlook.office365.com
 (2603:10b6:930:69::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16 via Frontend
 Transport; Fri, 5 Jan 2024 07:38:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Fri, 5 Jan 2024 07:38:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 4 Jan 2024
 23:38:43 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 4 Jan 2024
 23:38:43 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Thu, 4 Jan 2024 23:38:41 -0800
Date: Thu, 4 Jan 2024 23:38:40 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mjrosato@linux.ibm.com"
	<mjrosato@linux.ibm.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "yi.y.sun@linux.intel.com"
	<yi.y.sun@linux.intel.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
Subject: Re: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Message-ID: <ZZeyAC3c8LJz7nsQ@Asurada-Nvidia>
References: <7c398efc-8a2f-479d-bcff-ded8cc1ef3d0@intel.com>
 <20240102233849.GK50406@nvidia.com>
 <c59a780d-4030-4815-a34b-fb2e2f902ab3@intel.com>
 <20240103160108.GP50406@nvidia.com>
 <ZZWP7iBqUtbTRb3s@Asurada-Nvidia>
 <20240103165848.GR50406@nvidia.com>
 <ZZWUD+lCw3mRc/15@Asurada-Nvidia>
 <20240103175202.GT50406@nvidia.com>
 <ZZXBGw9dJyvb/5r5@Asurada-Nvidia>
 <20240104000204.GV50406@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240104000204.GV50406@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|DS7PR12MB8291:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e9e5cd-2b57-4662-2d25-08dc0dc15f83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QE+A390BRBr76HFRwrNSbDJqQlOS0Wgbih5aE0ZjSwuuuHOuC/Mbh0S9tBoYM7EE7v6E0A6rFpHHV8AJ0/FM1V43Kzz2ycVNB46VtrSnz2+bt+5cvHONsNkc2Qr/k5pTERSsXRexFxwRQ/1wQdh+oJYXIjxsxL/V78g8zk9UGVXRajT+Pav5cvY5YVzF7eeHAbSqibsm65R8g5g2vygGsDS++6iTGf7wjSMRreZorKQisxpr4eKlJ87FVh5FUFOtu/k4ZEESu7RgqERPx2R+ZlSuyxjT23Icscxu8We56TyV5Ok9ieZp38S35+iV4ajmQZUxXP3oMOPU2q0GgFnIXlBwhA/nWpt/05U0tmkPvVTrHbfms9XAFYfw4SwxQOLPERaSi+3AiC5qJj16rm3kmsOjVBM3OSbYr50CAoang2kZHYtDss92bPr84qdrQt9j9GqujxENCaEZQMgWYqcs3MQ7a3I+K2PTRehx+2hnUvu2AXMlCEwhBX6qsH0aM8UK648NcRVQqO5YuUoOhQwDFY8Qq2H6KokYEeVEo2auFzHffBdNtWqNhiq7+TzcBI7lP/fsBwjKWRBs3VpEFCcZpilLHGe4hA3On57LWIvFgeqmSIhzRoTw9BFy1VcefsmWzeyrYaVzlMKH7ui6TRVWHjitzEWa4S3TID19tuGZ/9IlOKcxUeEji2HiXD7mHZbgwXDUWqm9CW2qxfyEkYSfkv16w4/QdvkBzh7CY+CsAdR5SsH9K+X1yEN+OKmdHHCJ
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(46966006)(40470700004)(36840700001)(83380400001)(9686003)(336012)(426003)(26005)(82740400003)(316002)(47076005)(36860700001)(5660300002)(8676002)(8936002)(6862004)(4326008)(7416002)(2906002)(478600001)(33716001)(6636002)(54906003)(70206006)(70586007)(41300700001)(356005)(7636003)(86362001)(40480700001)(55016003)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 07:38:56.0955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e9e5cd-2b57-4662-2d25-08dc0dc15f83
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8291

On Wed, Jan 03, 2024 at 08:02:04PM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 03, 2024 at 12:18:35PM -0800, Nicolin Chen wrote:
> > > The driver would have to create it and there would be some driver
> > > specific enclosing struct to go with it
> > > 
> > > Perhaps device_ids goes in the driver specific struct, I don't know.
> > 
> > +struct iommufd_viommu {
> > +	struct iommufd_object obj;
> > +	struct iommufd_ctx *ictx;
> > +	struct iommu_device *iommu_dev;
> > +	struct iommufd_hwpt_paging *hwpt;	/* maybe unneeded */
> > +
> > +	int vmid;
> > +
> > +	union iommu_driver_user_data {
> > +		struct iommu_driver_user_vtd;
> > +		struct iommu_driver_user_arm_smmuv3;
> > +		struct iommu_driver_user_amd_viommu;
> > +	};
> 
> Not like that, in the usual container_of way

How about this:

// iommu.h
@@ -490,6 +490,16 @@ struct iommu_ops {
+       /* User space instance allocation and freeing by the iommu driver */
+       struct iommu_device_user *(*iommu_alloc_user)(struct iommu_device *iommu);
+       void (*iommu_free_user)(struct iommu_device_user *iommu_user);
+       int (*iommu_user_set_dev_id)(struct iommu_device_user *iommu_user,
+                                    struct device *dev, u64 dev_id);
+       int (*iommu_user_unset_dev_id)(struct iommu_device_user *iommu_user,
+                                      struct device *dev);
+       int (*iommu_cache_invalidate_usewr)(struct iommu_device_user *iommu_user,
+                                           struct iommu_user_data_array *array);
...
+/**
+ * struct iommu_device_user - IOMMU core representation of one IOMMU virtual
+ *                            instance
+ * @iommu_dev: Underlying IOMMU hardware instance
+ * @id: Virtual instance ID, e.g. a vmid
+ */
+struct iommu_device_user {
+       struct iommu_device *iommu_dev;
+       struct xarray virtual_ids;
+       u32 id;
+};

// iommufd_private.h
+struct iommufd_viommu {
+       struct iommufd_object obj;
+       struct iommufd_ctx *ictx;
+       struct iommu_device *iommu_dev;
+       struct iommu_device_user *iommu_user;
+       struct iommufd_hwpt_paging *hwpt;
+};
+
+int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
+void iommufd_viommu_destroy(struct iommufd_object *obj);

So iommu_alloc_user op allocates a driver private structure that
contains an iommu_device_user and returns &priv->iommu_user.

The set/unset_dev_id ops probably need a type argument if there
can be a multi-xarray case, then the virtual_ids xarray should
be moved to the driver private structure too?

Also, a 64-bit virtual id in the uAPI was suggested previously.
But xarray is limited to a 32-bit index? Should we compromise
the uAPI to 32-bit or is there an alternative for a 64-bit id
lookup?

Thanks
Nicolin

