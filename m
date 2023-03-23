Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD34D6C6AE5
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 15:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjCWO00 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 10:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjCWO0U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 10:26:20 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2C331BDD;
        Thu, 23 Mar 2023 07:26:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGwPMAQlTcMWC2xKcBboenId3s4EA1grxX2N/Dlap066Fx7ebum8NRrCdNnCbNY9IJxc1TUP+BFgyXdp7LVSxhdEvDIN7x0SLAQfClQk2wiyZAoqt17LTiPef9v2gfEpCyvb7SuWI3CbdKJPmcD7r03O3K6/klHbES70rAr8cQbPJ+zIRNekqojtMH9d06eVSq8A5oP1af9lyDxT/hNsUwexAVXmy8o62jhBEz9324KEFhebv7byn6km8KhVJrzIBvtYGRaeUe5ggvbwXJm0g1yhz+t0SnvSV/bou4FysK7pMf7Li0RJ1F2TxxR1U/rKdi1M79M8iSzuq2AKV9DtOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABoSfR1pwrs9zAJbWlaVAn7X37Bd0yNAPKULYiJhnY0=;
 b=cLxO/AdRaRs+krDlEV4CzI/rkiUDprdoHmao8rCOeEK0q5LWUgDTQK+WgaRfU4fFbEY4Sga6rzbc/FUQxsbTWd3nXPG6wP8BhVRciHJQG4lMljBzahhKJ7hnNzS/w/5CNZm08yscWFVcU++oMJyXKPmQ4JoN3Z1SRDfJVagEx3QcbfRDPjv4jx4raWCyWFPsTmwDVEIbPUusugQW/F7h4kc/eRJkG6ma1oSMtlJd3z0ZCcXaD1eKWN4h0wkytId5ae73uPrNUYhUDGo0oqS0PHZYyfWkYXaHhnI1e6vuGdRx9IZyxQBpTs0PHEmrWg2z+37pDUaODn3UtWj8SjDPnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABoSfR1pwrs9zAJbWlaVAn7X37Bd0yNAPKULYiJhnY0=;
 b=VGDtDhZ9tJ05uTnTH3BKA780Pcr2GnY9q8L7oQatvmp/hmzQZC2K6dms4KnOQhNmNy4mwxFz7QhJZFDZQ6qpSIKpntXMi7rdjdrcf/szcaP4U/8wsn9oEDUuXuRJM/ICKNW78XmYaAYrHDbaguW0dkVwPVzIPTWmNjFoN/voyoccEJYMEuRqkJXuOyuU0pLR6tqsOWQytpEhj1jGxUf2UgdjELx3zYb8tmFeI1ovdiAvyY+Wlygp9x9gauLHUWlPrKgIYEV7YJrd3XaTJ64os0M7xxJ0C+t94ZY1ov4wo2umNusUWlH337rC0O+ehWXUvBiFgBBQWLaVMeGJTS5pVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6787.namprd12.prod.outlook.com (2603:10b6:510:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 14:26:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 14:26:10 +0000
Date:   Thu, 23 Mar 2023 11:26:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v3 10/17] iommufd: Reorganize iommufd_device_attach into
 iommufd_device_change_pt
Message-ID: <ZBxhgP6xzI9bbjXq@nvidia.com>
References: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <10-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB52765C5992F59307F24635058C879@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52765C5992F59307F24635058C879@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: CH2PR18CA0047.namprd18.prod.outlook.com
 (2603:10b6:610:55::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ace775b-73b4-45ad-32d5-08db2baa8c18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /T740DmbjjDmTjpvok02GcQIcHKM/TSKQe2v00/DxHGM1XfzgnNyMl81Ok9jbQHafDJMT5ZNY2DimxaBD6pRYKlmyT71tNw+dvpn3gdiI0S1xGFZk8CPIwoTpU4090ZBoMhG1ZW1xXHhhPxp/WAbOphRcMPFWsm3QJQyXdCrLW0J8QM1zQSBSwJYd3j4saJj7CnPxS3Le0OjUbYldtxzxo/oDzR3C89GSubaMJrZc4d04btu2nnDLXcsYV3vJ5D/iTYgzg5geRT5mpugegk+tt78imLZ9lAkErleotUXtkTEY8+5llAS1iXlQFumVTQ42xqNrwBtR65O9bBgcgCVJNYTrlGuazjf+GQANHKcE3p4hz/o6k1DTHSqzOELvH/yATXZcFSUQtwozNRU+2MdjS2+LxX3TIrAh0jNggdVegdDFEbrpytKEMsovqUmmlscoCja4o4qfGo5oU7PPlBDUIAzCBb1Bkdy55lGrtv96VEwbYLuYb3zY996WbUy6Y+AwfCthsYrLKG4ZncFc8goUTqDGbV/tAvbhH/C4HRwjFhGgCXTjnRpgDCtP9O4IIN8OPBt0+ZMCiN3SNftg0Sz7uAtXR098tFZdW6l8883ETYXEAzQggCyP8bjwd8WebTRwgahRrJHMUS904pAhaxk8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199018)(6916009)(4326008)(66556008)(66946007)(66476007)(8676002)(316002)(54906003)(4744005)(5660300002)(41300700001)(8936002)(26005)(6512007)(6506007)(2616005)(186003)(478600001)(6486002)(86362001)(36756003)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I7c5t6ofWGgyvP7hAbUsh7Hwkg7aYcPgCA4u2xssiHZFrtDjIhgsJyAQ6Kyx?=
 =?us-ascii?Q?XZq/LVk2b7ysQXqqWhzv56CNwl+m+7RBc+XRVPUcfOy7UdbYKnHtr5TnC2XY?=
 =?us-ascii?Q?X1lGl4Yj+0nGAGoBE+bkF4zDAojdvtuO60tydh20x6ggLPMpNqnGHt4Su5bD?=
 =?us-ascii?Q?fFEDdqH8M0tL/C18GuNislOP/gwsQFGy4/O/KRVe1qrje6XrH7WhamabupMN?=
 =?us-ascii?Q?OALUL+jbggIs4dyIBA57w4UduDo4QOLiW35razILfhAFiVhkS6h9+Liq7saW?=
 =?us-ascii?Q?mBvyIwiVa+0G8MwQEF+IFqFOF8UZtrRRTLTgiFE49xnzfNjqUlz0tFC91FHE?=
 =?us-ascii?Q?tFSHA5rPZuWRGLOgtiZCIR7rVX/dk2H9Ntnx0TcxZV28Unx3nuDMSn9kbVbM?=
 =?us-ascii?Q?eV8sn7LKeP0VptsCt1uNmJ2LS5+DjWF/G02TcluEL1WJIfvpeJVRnGL4lpAg?=
 =?us-ascii?Q?pWBAm/exjkGcA807aqRcQ97gdppcrvYNhwVWgBuGHSG6vKCnUjt2lOItxmUr?=
 =?us-ascii?Q?jLhdNYlTsa0F8pwAo2OB20nIg2c93hRcJp5nBtjFbol+VRKt1Ly2jsXfp8qo?=
 =?us-ascii?Q?j7ehPaScBmCB48olHnFU4bJDqOzwDlI2XdFysl/1jucglSord9aLQDiGvuyz?=
 =?us-ascii?Q?2zpgvcNi7YROqK4+dgGbXRTfnFpPwzA5/6zMb4LzNumzjqAFYgPIq6CN7ZU2?=
 =?us-ascii?Q?q3iqKArecedcfAOm7uKYYxELBc/pfL6j7s+gDqAwdiEY2FNnz9OlBNvylCol?=
 =?us-ascii?Q?7fX9dHHHey/MXe/TEZhFKR8uu1e4vX0s18TN7mbSoskrae3d84YuOAaBcYfa?=
 =?us-ascii?Q?usE7Xx7nw4u00JfaMYET5fmVczxcTg+OzE14K1dFvU87rRIM6ojiJNeYe2ut?=
 =?us-ascii?Q?VG+G+vgN4BqYCUlibie/b2fdhm2qm5ihSaK4gEReIdxhuProjDYaF/M08Qv7?=
 =?us-ascii?Q?1wI+gRZw5ebfwqArXSHmUbiVvwTY8MrIEGba4UBzSYlddtSu2Ycelck16Wv8?=
 =?us-ascii?Q?KUMbt412FfRtQV126N+2nM5kS2wf6l+OII9i9wrPjb3IhOQUXNwdjpnC5ZyP?=
 =?us-ascii?Q?7rEDn9Vri9rkpqDXjzUOItkKZTBeWurHESlYzu1QTGY/9Z0i7IYcpsTTs9LA?=
 =?us-ascii?Q?Y/kCsNB70qcNr4PfvWmq76fsQpnBlueFY5gfNlEjfkmX9y+o7U6nXiq1MNxE?=
 =?us-ascii?Q?I39iFzwbAuitGGc0xlSHUh7QYOfEbXXLqScjxEvAEIyNXjH9g6/AwxHnoULt?=
 =?us-ascii?Q?o/5VPLwidRJ+aXs1OY6kwWTVYaKgAx+5LgHhrq6h/KFlfRC2MtbTZIp4paXn?=
 =?us-ascii?Q?rkmnOIf1SG6H1FvFp+FQYfuUClKKIbnJ/znduMqlPYSw9ZJMoR5+ODCXHNN9?=
 =?us-ascii?Q?jn31jxxUGsdjViySL/vlkCMjX3sBVKYhJ3U+cGPRMMGlTXaQ9EbsfHlqPk3s?=
 =?us-ascii?Q?njAjAW/Bty+RcOuTSvdxc7/ewal/uzT4wHBmWlUfN9dvBi6ICCVRcwgIvypN?=
 =?us-ascii?Q?ySj+TvnUdP3cJLphIYLL0msTzGSyU7J91GZShfKY153P6/UbaHSsZLoaGEdF?=
 =?us-ascii?Q?2OuYFa7d45QxZpscqdc2nkbd+dkyqiZLFJ8NP8v9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ace775b-73b4-45ad-32d5-08db2baa8c18
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 14:26:09.9606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mjmQJnLZxlEnErGH2t+NZLcsSsYkPsBUxaTb7kpH0xkHiEVW7xh5kp5OpKg/UhEL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 23, 2023 at 07:25:55AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, March 22, 2023 3:15 AM
> > +int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
> > +{
> > +	int rc;
> > +
> > +	rc = iommufd_device_change_pt(idev, pt_id,
> > &iommufd_device_do_attach);
> > +	if (rc)
> > +		return rc;
> > +
> > +	/*
> > +	 * Pairs with iommufd_device_detach() - catches caller bugs
> > attempting
> > +	 * to destroy a device with an attachment.
> > +	 */
> > +	refcount_inc(&idev->obj.users);
> > +	return 0;
> 
> While it's the right thing to do I'm not sure what "catch caller bugs"
> mean here. There is no WARN_ON to catch.

The WARN_ON is on the destroy path of the device

	was_destroyed = iommufd_object_destroy_user(idev->ictx, &idev->obj);
	WARN_ON(!was_destroyed);

It is the idev we are incr'ing

Jason
