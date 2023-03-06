Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC1B6AC3E3
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Mar 2023 15:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjCFOvF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 09:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjCFOuw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 09:50:52 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on20630.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5088A47
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Mar 2023 06:50:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLl1guoHCjGTMlayqW+Un7cblfQGsANPWVhhWtrW6rc+68duQ/cazT2FTepWHnYEHTwcgo5su8ea6ZoSEScLGNBDHulCvaW68nEA4Uy4BNKStAessX1PoW5fc2i4zHi6+ZZ2+ZkMEheItS4exMGcE12gfZGqgWBrdSAHuLLgStu1LeYs9Q16ShIKpu/9UYJR+yg5g1XLGXWIRdeORLk4V+uHKN0GZIte35PoRje+1Ll2HQJ7wuSTAxDfvHLexdcvAzo2hPjnMxm7jAjv3ALUC+6KAkpqDXDVBQIQUJBwiVyLS7U3Wk0+/3Arif3JDYxZD09LtYrJ14ZbPut3A52PFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VH5atoUeM1RuwGe/iokJoSsJCj91TmSA0gg51MC3ZE=;
 b=YxQOUoZOzj/DRSAOlnrfe2OcfJcPzcaWcNYT/0wTpcH89CvXgCwrSz3zn8f//H8KVEws7pRVs1DfGZCLdkbbR1iC5Nr/5aR4ThEq58IgKvyYbdKNoRh9Zx1RBw535CuL8GK5cqdhZGbgIHuiK+MFxDFHfZTLxCEKmdPJsgwZLk4pTO19ditjF297UwL4ZahM7+fxNUaUdYUeu22bxZ/bwWKaetE6rU7Bd6y0+d8iTG89VYm4ENzBv7pAogkHWI4lumU3FhhOiGsisEbUAQni5aYyGhQCQVQAYCWmoiimrfULvNLQHtkNxJB5kFp0nMwUYIjNBPXW+N1/cHTB/jFmvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VH5atoUeM1RuwGe/iokJoSsJCj91TmSA0gg51MC3ZE=;
 b=eLIy7Qe0iO0ExMYZeCQ1/GnQ0pTqmr/GcLC6vItBHJ8LJHfPSVRp58lh0oTtL5UN40ENXVRXloW4vsOu/Bj3O7QIHzhmIDdeaYtK3fwBIk4OSJfJ7A6zCst3x/BGG01aceLGSRsTAm5VwuL4M64F+cgoWHI3kQrpkLR4fkuJwpf6usRzukOp+04637CuvYiyC0LEed3DlHqQQy3wTZgy3JonbeJjcinFLR+eVdODiS//PE9+BVhEEXPHerQTwrxCEID8Ld2ATNtLxEM9lCeLT3UkguVagG5W/c7Rcq/NWZjjPCEM3GZHV47ips8A1h6Y8xc5kdGj3Rn+WyD1LR9pvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB8178.namprd12.prod.outlook.com (2603:10b6:510:2b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Mon, 6 Mar
 2023 14:50:17 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6156.027; Mon, 6 Mar 2023
 14:50:17 +0000
Date:   Mon, 6 Mar 2023 10:50:16 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v3 08/12] iommufd/selftest: Rename domain_id to stdev_id
 for FIXTURE iommufd_ioas
Message-ID: <ZAX9qDZdM5h+TiYH@nvidia.com>
References: <0-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
 <8-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
 <BN9PR11MB52767FE47436B23EA38CFCE68CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52767FE47436B23EA38CFCE68CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0224.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB8178:EE_
X-MS-Office365-Filtering-Correlation-Id: 77621569-e996-4b28-dd4a-08db1e5219b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yBRtGO4mb/IAFFfRpu+/sRz5a/LH8Qg8Fc+EoJPRKp9NdoysZuA5AAP0mDCM5EmgzbjTakMdwWd2J6NMhUZTLX7M2Fp3LNWlrt/pTrKGAE4S7bcoSjLzjIHDZTBYBWVVaWUiMFdoYyd6HAh168VkEwnNs2qB5rVkb8RVzodRru7C123HNd9GMlwPNgRbs2Kw2b/wAdz0NSKj0T7exj98XkuPHEfHNUYDfxEPr6GfYQeyLGaZ26pQ+7Y0UlK+VDEuOn86coiW8YJ3itj4S4tA0zrBEwrYFhOxo4cki1Ji/C6j6V/HUHMubIxRSe1DLPUBZPtFly71RWB0bRIdWyneF0FLmFnuIeG5wFSc8J2FPMzWytCziZaHr9jl8DMJBOjr3Srbvv6bN9QOQ/WYfp7i2gOuHuvdYteaYQq84BlG6UdY3utt++1QAgi77qcCw1yuB5WHwH++w1E6DpSAULs42B/ptKyerz7U3VP6R+auHwXQsuSzTxVeCVRFi8Cp8DX6q0VE0YNzOqvExUjMZxpus4Wb7cbnXfdhcN+bRElP/QVf8xt79hu56ZuUAY8S50gmyiLWQT8rzCNMUUTwFyj0YFRvZohdJmzn3dq3aGUD2qNheiw6tDpXZVmxZuCHKDArbVpHPR2R4/R523+SUKV9k2nd3LjqZGToDbEYhnSGrA8B8ogBjKqBnBj4hzyLd/rz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199018)(4744005)(8936002)(5660300002)(66476007)(41300700001)(66946007)(66556008)(2906002)(4326008)(6916009)(8676002)(54906003)(316002)(478600001)(36756003)(6486002)(26005)(6506007)(6512007)(186003)(2616005)(86362001)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AkCttqScycH9Pt0O97F9x+CI5hZLy5/xvlGNwU8i62qHs3UMwuvpT7Fyce/p?=
 =?us-ascii?Q?XeKw9BqvNwDwFvxC7alJaI30AAk7UlzYZvC6/llSSp9Vqfs+KmuqtMVJi9tX?=
 =?us-ascii?Q?RnNAAAvOJi0nRqS5eoOTI2vISgPhmeGTYwmo+6aBAS/6AqSBuC79zJVXby8G?=
 =?us-ascii?Q?S5JhVhh3aJvMxGvpH/Xhg64al6NoM+fqyXNadZ/ehOXYTw9Zd0e11USr8SMf?=
 =?us-ascii?Q?f4wfX001CVybjtJ/KtjYwWgI3QVvb2eUmVpLWOL2TOFHzWa4VwETPrgAjs+B?=
 =?us-ascii?Q?uYOidgMdnsvuWXWSEyMGNcVThHwsNqjt9nqIN7k0VgO2tYPVFr9slJ89TZ16?=
 =?us-ascii?Q?6CdyvEiXkuZUZ1RSOT7zpkFXxdDZSLLE3dhW1fsuOLDWgS1FGIu9IH/vsq8F?=
 =?us-ascii?Q?f3NYjeaFtQMGvbWjGdGSjvDnjVYsOb8JCC31xDpKIuuVmUhgrHkejMNI6RfX?=
 =?us-ascii?Q?LHCcqie7qJFvQGqPf5uLScbuZwgtPsagWwDMIlYW+yA63bo5rL2oVdFT7VwA?=
 =?us-ascii?Q?Jd2pgUYTpXnzASFbCBJX3aB9CKh9Lvl55YJtGLuEaMLKnnmSomHHbLhEZdvR?=
 =?us-ascii?Q?3Q9qkR7DaoI4BHSDIijOkmF75KRAB+2i8LwzqkiL6oEF8wItCegzcPaS3CuM?=
 =?us-ascii?Q?RA66LWPu4ecTxxQg0/+yx6UDXPoCMjEzCtL7GqYyiDHGHaLxhCG+P6LLJQW8?=
 =?us-ascii?Q?9KnKm50pIwJ33hLOMtdlsuV/uMkR4uXPMEkGduLSZxKMb4P7Vcw304H5jD8k?=
 =?us-ascii?Q?eQq1acNCF4glLJnrmYCoWUY9mBQKY/69upYAcZWVwAjDYHVtr2TDvBkuYaiP?=
 =?us-ascii?Q?B7ypXYyPWQbyZ831wb5YNci+WhcXI7NCghZGEU6PFiCNXky8fE6WqPYdPHde?=
 =?us-ascii?Q?TRvhJVv2US7T+pYsEDbgoZ8fqZ6b+LQJLW1NrWr2dZs/HZNC6OiP8yfLpm4j?=
 =?us-ascii?Q?gnqVsft/x5co8wiNDx9GWJazGHrlta5ZOMNhHppT/o19UQBK4XD0pGcovfnO?=
 =?us-ascii?Q?kGTnO3UgqOUnFv+ycf8fs44e3quLTjMpT8SUd6/KHffUaUe8ljaotU1Tj9zb?=
 =?us-ascii?Q?p9tRTIozN1lZu7k/5nOs+eJubsnCvMsvnbFcD1IyephKYIot7Wf2PvO8nZRX?=
 =?us-ascii?Q?4z4R1+axdAqM1KkbAZsYvJUBrzfaWUWb1xZOLEiVrgTy/jC7msYVLKhm5NDO?=
 =?us-ascii?Q?NKb9+ilMnh4fEEXcF0vs18cyrugi5TI1BXgRMd1jWtz3CxAdSKWhTtWg5vKM?=
 =?us-ascii?Q?2Uf77GthBl6t1ZdFvyfYP1N8BeH3DoOalgCnIPVZI757OuxVGEx3G7/YhCVg?=
 =?us-ascii?Q?rrnOAsuabMnoEIvhfs7BbQX+GwZAsJFqmoNBkATDljUkoJ/2wJly/xKJHAJ1?=
 =?us-ascii?Q?z07dXvUDmZ8LN6fFINdNPZZScnDOMsHMOvar9CWrc3vzG9nMg8iXYr1V6r9T?=
 =?us-ascii?Q?flYwl4oOeKBE9MN5mtS4FEndxlYlESPDwsvFmlRxFTA7ORmG+JuekrdYUylP?=
 =?us-ascii?Q?4pmDm5g4opdBId6wlmxoWLsPNd0lqxA8lmVxJwzXtm3jK/LqVhrObaWZoLOZ?=
 =?us-ascii?Q?KJaNurgx2SmjW16Y8NuE5Vj6dyxdlAu8fkT8AyfK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77621569-e996-4b28-dd4a-08db1e5219b3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 14:50:17.2770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqTYQTexbP1kEaK4RPLRRDsMr2JvhmuCiO+KAvoLsupQPoLj1OvfF2qKgWHJPCEj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8178
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 02, 2023 at 01:23:48AM +0000, Tian, Kevin wrote:

> >  {
> > -	if (self->domain_id) {
> > +	if (self->stdev_id) {
> >  		/* IOAS cannot be freed while a domain is on it */
> >  		EXPECT_ERRNO(EBUSY,
> >  			     _test_ioctl_destroy(self->fd, self->ioas_id));
> 
> it's easier to understand this comment.

I changed this comment to use the right language:

	if (self->stdev_id) {
		/* IOAS cannot be freed while a device has a HWPT using it */
		EXPECT_ERRNO(EBUSY,
			     _test_ioctl_destroy(self->fd, self->ioas_id));

Thanks,
Jason 
