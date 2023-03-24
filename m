Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FD36C80A9
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 16:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjCXPDq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 11:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjCXPDp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 11:03:45 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA4CCDFE;
        Fri, 24 Mar 2023 08:03:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEjnVaQnSQ5YqoCLz6QVA75AwdDdwigMFhG6tD8ziInuqaXqI9HCXnYV88Oc+DJ8wGY6oxolLIaMWyOXFS4pczpOY9D+lbCFYOIiJdtj16VAOn7hl7lBUiXiWGbZe/Khg5qjEfGniWNIHgs6nljD7bNnDC1mAieJxQHkMFXYhNzs8vPlRpW0GvvPOZ0c7g3TeygA7PtOu1A+0+tNj7KhIvBwd9Tw2JN2rW7AOYsRJ0xo8LTMPPMAQeE9vaa9DNSFVhbC7s8YJKZGgWlPu6Blb3o0gwCY9dWaN2lCgsWG+OC1Doux9cDE3uy859lLNo9hzOYhmXldC44XvjhkypGr3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiJFlQlpQWPPZE9OI2H23xlr4o8eGiw4V+0q5FINrm8=;
 b=Z3pM1IoEHxUDa/kyJUmltJCVoexDPuCDuMkEnCDLYgk1rbW3u/CnAbDWB3H2hUvIl9NIkxdT3BZUfl9oIj7Rcedn0vA3MrzwZlcpO73NOHgYbWrkZtdqQwnGhny2+79r9Aadms2+Skp96aTD+dXame/fANiIQ5cNCal3N5NFJWBnaENGP1NSsRkU4RBDUJUj7WzJ2kq/iUL/GKtbTygGh3ciQ4qIrSGBId4u0kKAhbtuewKuLjWBEIIaGQtrHJoEMm2DE20Hckcv06UjsIcFR+iDeM87aT/CVI/hEJYKn6Zx+hR2qJjcqjQjj73ruWx7oFErtsTdLiSKfM27CQEAlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiJFlQlpQWPPZE9OI2H23xlr4o8eGiw4V+0q5FINrm8=;
 b=p1GhlFJQlr+d32lOryrdBGP4tQBxjPuxeHlGIJ6fKWRB22Rbho8i7DZTrz26tKNOspOcfqZYClIMKTFWyj8KfBEki4vzVGkitxlcgbxbG6+P6MBHPo4Pm1SP8lEU1qejByou+zpt9KzMB1B0FcHHrEM0Jla4QKN1a6BubkTy8Bos0aXx95DiepOi5EJBQIok/1zZUI7OGNiHi3XQemMxNfZpivb8kWtNgTEJATZ2au2dSTO9F0zd/yEK3BaKxNVrOkZS992xznPWjJzGSjJpVzmGyM57yvFl/q4bhghPabyqj4kf/2oMOGEvtTtsXwMKisOR4Cc3AgwgMPe9Rp9MwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB5008.namprd12.prod.outlook.com (2603:10b6:5:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 15:03:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Fri, 24 Mar 2023
 15:03:42 +0000
Date:   Fri, 24 Mar 2023 12:03:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v3 12/17] iommufd: Add iommufd_device_replace()
Message-ID: <ZB27y2WsrYr9KLFr@nvidia.com>
References: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <12-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB5276B73DF56654BEA4EA51AA8C879@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBxioEDUtPMro+ew@nvidia.com>
 <BN9PR11MB5276B41014B2A28952B626B58C849@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276B41014B2A28952B626B58C849@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: SJ0PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB5008:EE_
X-MS-Office365-Filtering-Correlation-Id: df2fa76e-f77e-485a-b0f3-08db2c78f4e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dW/iPWUR70lJgW+b2yUtRFr20CtNEjy6/eZv8ZDghasULmx0o8/L1XA0PdY1Z/hBlbLFyz4xBRf4EeOsGGqVb7B8ISG3tHeROK3kaP5giIDiM7JJjGZz/351NUqV1zGQpqHCLSkD+09ENhvrx1RL/cf+uzmq1BHlxt0vb5ibObPJ1CHSWHDGxZW7XN+ct9iURNWQRuDkaWslhhoo0ytsh4n0UwOkuYNyOUJiHLTMfwoI9GwMcXn3lu407x1iBkfB7of2jJ91MQeXoYPFkQTkW7toJOGsWGFG63WVRgMjT++cwW+S8dgMZdO1WCACPL0fLjJP6y2DQB+JxEfW2+OKlQuwCNPzX8H/E4a37cJsnk9J9vFp8uhAyT1pT0RAP6mUTbYG4LDuB7wj0OCmnw44bXK2PWVZ/GprwTAeCXaefl+mQbRatDb2iyvDJ2AUwtX7JkSYTxOV2samBDDQ2gYOl8B6jCraEnI3VH7Ma739PASF479x8tDgJoHn13hiMw96PVxqvPf2uKATZ6Dz0HfAOu2ckKQU7lU5lLQiZQqwvo8BLLzb1wm2br88ltpiu6w5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199018)(36756003)(8936002)(6916009)(4326008)(8676002)(86362001)(66476007)(41300700001)(66946007)(66556008)(6486002)(54906003)(316002)(478600001)(2906002)(5660300002)(4744005)(6666004)(6512007)(38100700002)(6506007)(26005)(186003)(2616005)(66899018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yeSAaSenr+9874yKCPJP6YYPWM/1orlmjyd6rxnLkJ1RHb50DQKm/Ihqw7Mr?=
 =?us-ascii?Q?oaAPqIRJkedcoWp0gatRR+nB4VWonNQvpw2hNrPH1j0zDSaG0rhDkHa4fWIu?=
 =?us-ascii?Q?+jOtA4JaGYo6AUefguqh7++uALkTIlr3LSNtrW1sjFg1yhRw50mkJ3GUbOIG?=
 =?us-ascii?Q?qVFtUXcTHURWKExpIleT2d4HzeB03MejNIW1W4VT7AzbiJ41kSZZ1LaLWyff?=
 =?us-ascii?Q?vftAzPUFguOwdGV9+PGufaaNTe3NQEK3NM9al4tfYf6CSzde4stJGD8/3n+r?=
 =?us-ascii?Q?u89PZHERvZPRHUb3gOUmasRgCa2Vks/byGiRf4h8MlbXVovyY+sW+Kq3H3Z7?=
 =?us-ascii?Q?cbinseuIUHAr1yA+dFojIj8BGmhC6Fy3UEPsPuU3X34psx33oOIWAoHJl88h?=
 =?us-ascii?Q?2/R2HqqKDInJkSF6bvYfmmxD0W8g06ChYfcrXqP2FgJsDI3XVPESz5nW1HcT?=
 =?us-ascii?Q?6/VLz4f/uMuGYEu04jWAkuk6Wcnkphh1mrTefg6fu5BSytN4p3AEEOuVTttF?=
 =?us-ascii?Q?zPIENhARxvACjQUD8SxVcoGRuxmhn43xrl+4lBSbt0thXtapYI6M7zv6/QK1?=
 =?us-ascii?Q?cwYQAVmib8BnGBXQfdOCEvzeOwvLPyeuO4dLuwZqOOcoB2+9tEn8UeYzRaah?=
 =?us-ascii?Q?eFfeU3KsUrUJ1k6mCqbxUYVI8zGOtpjQX8CM3QmsrwHLAzjrSsUzpoLqrAE/?=
 =?us-ascii?Q?FvNUFR7/bkO1zSAwoeGqjVci0GijLk/nWHOyTXgRP1Ag123DPRbPTtMsrVDw?=
 =?us-ascii?Q?cXe7ymwPXA0nbB6iAieI50fjbPv75QYn4RLsgS4Lym+B7UJJwh7YCFMhPAQq?=
 =?us-ascii?Q?Yt0eQIk2IcyuVQn1ZVVkeYPqlMfrtbAOFbRh9DgPEBKpFIVT9x2hV3lALaek?=
 =?us-ascii?Q?mq2lA07JCcwYGIuc1LSY83k82fpVFK2QU4cVnY5ivghlTnMHnwEx29Lu9xVI?=
 =?us-ascii?Q?4Eqh190hh47OzVgslC7d2LOkkxBHFSDetEJs9BxZIdjRlogr4szTusQ79G4G?=
 =?us-ascii?Q?2iT4sSjE+HgLS5US5uqIiizNl0eF03NWNr3fD1HcirFazPUhEc2MSxEpMuUs?=
 =?us-ascii?Q?CmNLNTE4d4baPPFxm2vke1aeOcr4NZgfP5hkOIX+QpUmusz0ytJY5rMgQl6l?=
 =?us-ascii?Q?5EaX72m8y7pDRdzNAhVFJ3t60glsZ3+qAu/+UPCPaN2UX8S4WQNK0k6HQ/IJ?=
 =?us-ascii?Q?6eDtHeyrIVA7YVQUUiWNfQbYO4cpgt+NSdIGto6N5w9igmHO3zrZ629fcSkE?=
 =?us-ascii?Q?h1r85fqTMNL01XE68vcTJblyILdKBRgjF8hk9ETr2esTugBF38ofJ0CckD4C?=
 =?us-ascii?Q?PmHLpTqjAbCMROFVMf9va6pQlAZzmN0IDbClQVFI8iarc/xP/1Yeg274pJOT?=
 =?us-ascii?Q?FzA3qZ+dZdJFIRRe7joGJT2ztIBVmKS6DnyTU39jn7NnXa3aIk+Qa681nUN2?=
 =?us-ascii?Q?JsgubQRJSg7G8TtYdnFwEWTrx8/GSbAwpPgPUN+X8URkHt2Pr9lEtGReYypI?=
 =?us-ascii?Q?YqfPeDdzYgakfmjOJf+Yf47eXlMLKtyJ3JC3DRkKUjorf14u2PpnDDC26vtZ?=
 =?us-ascii?Q?+E78S1Az4dx+vH9Xm6tqB+rFA3oZ29Jp0enQZD0J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df2fa76e-f77e-485a-b0f3-08db2c78f4e1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 15:03:42.1217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1r7iGd9v5vpYj16DMkrm+x62JCV9z/9W0sjRGjqKnDsyfhY1T04k/nYZlzV0Sk8b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5008
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 24, 2023 at 01:42:58AM +0000, Tian, Kevin wrote:

> > > > +	/* Move the refcounts held by the device_list to the new hwpt */
> > > > +	refcount_add(num_devices, &hwpt->obj.users);
> > > > +	if (num_devices > 1)
> > > > +		WARN_ON(refcount_sub_and_test(num_devices - 1,
> > > > +					      &old_hwpt->obj.users));
> > >
> > > A comment is welcomed to match "caller must destroy old_hwpt".
> > 
> > ??
> > 
> 
> It's not intuitive when moving the refcnt why we subtract num_devices
> from the old_hwpt only when it's greater than 1. It's really about
> the destroy must be done by the caller.


	/*
	 * Move the refcounts held by the device_list to the new hwpt. Retain a
	 * refcount for this thread as the caller will free it.
	 */


Jason
