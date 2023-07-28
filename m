Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908D6767281
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 18:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbjG1Q4k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 12:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbjG1Q4W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 12:56:22 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFE310E;
        Fri, 28 Jul 2023 09:56:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvooR/N7rdWUHVDFIL+1w2vyJ06JnEwbD8jmnsE88/zhfb67/3hIyPEs8rpoEWPB3kkLsk0T1n2Yq7+u4AMEQYhqdbS9O0IhSDAuNHc9GArKXI9V6mFVLQ3iJWsSPtUHMjCRJWh7fY/AVpKIs523jCCphGJxcYvY7zjopa15Gt1FvvUeACbFhcqIK90EA0VNVyoiYC2Nfufnl9ylagiSOsTMUerL9qn26lABFJnPStwTHxZKlIuJG9gqxUi05mcMRzMhII6Q91m5ELZbaDntThzgup3E7jaGORBT7A069c7URy1l92Q3c+RkaOYh5PAQwAzLt05QlCQp3OBgHlz71A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjV/6iomirVjc5Do5NAIrR7FXiJ27OKexlcGCkZXYGo=;
 b=GhO3bOn1nUtYtu6WRAlWRaetMGWO9igFu5K10geQLf39pZUZoweJjdtMfZP3UCwHYo4Cnwq9GxKw7Z0es07Qk0bROl9q9FocycjwK+wynBtA88rddLc0e4JLYPhp3awhfb2cG+weERyb0FxIQtMjicDOEskYEj+djMTDmtuWfSSrlTcU+oRD1r0r/pjzl9k1kkI/mmAUXXPhtKa6v+/LKqbqAbuWe8wqLFecQwPSHrrwa4DI/dd/4YMwsJdcJhs8dBJlm4racpeBJDKmAKclx/UysyRXJqZSZF4f68FxccIjgK+lLVLf9XLKDtM+DQgWwRMtrdJJVHGTkbW4CYFblA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjV/6iomirVjc5Do5NAIrR7FXiJ27OKexlcGCkZXYGo=;
 b=TTfKd/qajr3BSHvNfZOgXTR96OtlpZcOH7NZKmucsCDRbkcvBrly+pUBiV2EZVHA+QOfSyIm34X94Kko4b6bjMQPxq2vdbCsV+EYUiVncCrKqgwcw0oL3R1Tt41nPejV+ph1rZYvU8VJTWBEnAnookSmY3C4gahDcw+6s6cd1/Lq3v02RK17NJnPTja/E6E0oSF2VdENhZ46aIWm9avNhVP0NCNzeHN+OQd427WiHLFxzLzKl0JwNVS/BvuU0JC5qKMS8WqDIMms86/qFrPUfyE3vpBjAPpLqvp4uoyHhLwzvHmLaaYY0qh18wCLe0sNoRm0TMZiBV/zotJm/7pPVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW5PR12MB5622.namprd12.prod.outlook.com (2603:10b6:303:198::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 16:56:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.034; Fri, 28 Jul 2023
 16:56:07 +0000
Date:   Fri, 28 Jul 2023 13:56:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
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
Subject: Re: [PATCH v3 01/17] iommu: Add new iommu op to create domains owned
 by userspace
Message-ID: <ZMPzJd6iIFk/51Om@nvidia.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-2-yi.l.liu@intel.com>
 <BN9PR11MB52765C4F05F7632829B53BAC8C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52765C4F05F7632829B53BAC8C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: CH2PR18CA0058.namprd18.prod.outlook.com
 (2603:10b6:610:55::38) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW5PR12MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: e1174413-e063-48e3-c67c-08db8f8b8968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IjThefBqzupc7qJklkzU62ZtalAS+iY1sFTo+upMlozIGM9dbSv7nmVCU2z/3ZT467zN2cFtnf5eQXfAjHZ+v28gWHcFZwioT6cAMOrrURWiXy1Y/B+akGaYcT7AMqeubV6c/V3rShOzX7q9Od5ANogSdOFId7X71dydw2s8jlvAXrqw6j9s9oEQe2RpY9nm+f3W7fB5mhJfynP0LCbenXtZUNaw8aR0RvRxZm08c8vHLB/oj6VjRB41pvZw4cxDnKPhtjWCxlhoYw8mAqoYKXLll6sETAHbYyxtQ/chAMEbUbuRi4FswTgDnQjl65fkgChcpNSyh3Ri+QYh6c7EVSuclW5Td5qnnqLfg5M2TVvyzou0AHUOKawUAknLLvfnDsi5e5VrCQV1BSjjR9clP7nA0+SLhpUSMv5FXCWlUtJgylSdoIvge4R5OXvx590b/EAayMKuyPMJ8K7D+j+14IP5YxYxAVSxF5oKVfDpeMLEqpKX86j8Tqqzq256GOlxh28wwIexTqpdtELgHmFXSKj254yXgZwTT/B8e1GAPg9dz8tsv8zvRYO/r/7B3knC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199021)(478600001)(54906003)(6486002)(6512007)(6506007)(66476007)(2616005)(6916009)(26005)(2906002)(66556008)(316002)(8936002)(7416002)(5660300002)(8676002)(41300700001)(66946007)(38100700002)(86362001)(36756003)(83380400001)(4326008)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Nj39GOBwjVhYB4vYEUTY8lWJsGe+X8NWJPcGpygaHNTyyug0eViO+HSQAUK?=
 =?us-ascii?Q?0OvKl+atoxiNqgnEkbFjidNLUTjwQcKAXXAsWHt2Le9CCXoYPW7Cyddpq1KJ?=
 =?us-ascii?Q?DHVZhZSXS5GErvdTq8X82KTdggKrPRxF7ZCp5sMDNvoERkaWTQ5MmEQutiuQ?=
 =?us-ascii?Q?csmUDOx6XDQrvfFmlso4lh0jPtwwPSYyDhItz9O48glm/6eF4w5ydH9pqVFl?=
 =?us-ascii?Q?NmnZHTSRiZw50oJcF+4AIlpncr03bNE0eVu+T56QtVwPQeKqNdDgmfgPu5mk?=
 =?us-ascii?Q?5uq3fwI6vah9SxxqVn4FXbcKdOgvN0fChStSbZO7amIKjKhQCZyn/+/6ABUi?=
 =?us-ascii?Q?jy4KxeF83Zu5SiSyX+uOUB1nQ05HG3lWENobRoXkI2V+N88z7JCFt/muSylW?=
 =?us-ascii?Q?1ctTUEsZsTFESr6m97mqkm74vyEBrrPcdZrnzQYFwpciF6U9KYkc4/qndoSI?=
 =?us-ascii?Q?cKNLE3jW1V0IDz3ZHRjj8iH7flLVEy9sEvZMI1tebfV1SboBiTg8DdWl9KpK?=
 =?us-ascii?Q?hTejn+LYdSrGRTZOsOTJspXO0Q1eP4oc2uSCJVcc1BMxd0bifrlnYQKN3n6B?=
 =?us-ascii?Q?FWXyyfUlk7xMTF5pVPbPMMU7lCNQZiCY2Nii1MLdb25rx1w9rOvpIbDkEUTF?=
 =?us-ascii?Q?dw7ctlatbJ28DSwROwDkPgGsh+foG2X9PDlCWS0F65NquAln/3HBGQn8e5mK?=
 =?us-ascii?Q?4bGnW6TR8qO2YcIRWUtn9WyKFI4+3ImKrLfB6/+/fQeWpOjsuhIz93wBP8hL?=
 =?us-ascii?Q?qI24hP3SbxzQoDTMg98W39+RQRQ2DuXTxz6L5+m0M5SjoTvgV1CbU0xqfAGp?=
 =?us-ascii?Q?D9KTbNpl+ZO6rP9lQoxnH4hRCwzcuxg6swv4UvmhjYSqHMUsYpjKoOXTuvzC?=
 =?us-ascii?Q?IeaN0Q5JVXoYhe0WZ+fme6qYvkFp1x4t93sHZfontTMUxrRWZvbK9jbz2OE9?=
 =?us-ascii?Q?8YQrsCNUCEz/YJ9zMCPfmd197qrrRDF0VqIffQpmwmHsIRGYLW0XqYwBbKdL?=
 =?us-ascii?Q?5+qEHqoKiH/EAGVWIltU7nkegO/fBQj6Y7rLK55UQh4W9XAicbGtPpw8tTsM?=
 =?us-ascii?Q?p2E5kyCEjMvM1w9JUVyrtQoVlw2qppuoWzHVl0YI2DZXN4v1XfKiTLIaVWMu?=
 =?us-ascii?Q?ij/RuQ3MqjY3cFVd03jDFLAJbKkEeSCguEfgeVvPgpwCsszZjPqQFqYiVaVm?=
 =?us-ascii?Q?mikHph95qPVrFdKcWD0KIFSOKLM231TzjPmpDMaB/HGOGLOSx+C1TT2pe1Qg?=
 =?us-ascii?Q?YgT0xnutuwxAvXebWLbZOhgdGQHorSkWhoPlstAog5p882L0GR3cXesi5jXt?=
 =?us-ascii?Q?3CM035UEARs6iS4vVku0HIRf6ktC0Z9OuQaTcprEUXVqxDWc7RJbyhWvGNMu?=
 =?us-ascii?Q?KImay7WGvw9FVkpFpzMrT70Ix1UJdb3fVe2jheUGgYqDKypcMWuie8+zBa5q?=
 =?us-ascii?Q?xSzIheVj+hs3ckVjiBb9QpMOX1+2FYb+dYUDP+Pc2Tkp/6zGg/gPOWF3/hN8?=
 =?us-ascii?Q?YlGOhfA95p6hQ9m7Hq2cLcUKNWi1qWR3FQplxG4CkAEymCHxVEaRweX1wKqV?=
 =?us-ascii?Q?H4b1Tvxw2UoAKi7MrcmJYYHpEYRX/izimYbmGvey?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1174413-e063-48e3-c67c-08db8f8b8968
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 16:56:07.4230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XmPLEXr8/2pst9rMM6IusVDzs7Ti7L4uBZbNvLgV9buU9C4WVfjJ2c930QYBGq3W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5622
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

On Fri, Jul 28, 2023 at 09:37:21AM +0000, Tian, Kevin wrote:
> > From: Yi Liu <yi.l.liu@intel.com>
> > Sent: Monday, July 24, 2023 7:04 PM
> >
> > + * @domain_alloc_user: allocate a user iommu domain corresponding to
> > the input
> > + *                     @hwpt_type that is defined as enum iommu_hwpt_type in the
> > + *                     include/uapi/linux/iommufd.h. A returning domain will be
> > + *                     set to an IOMMU_DOMAIN_NESTED type, upon valid
> > @user_data
> > + *                     and @parent that is a kernel-managed domain. Otherwise,
> > + *                     it will be set to an IOMMU_DOMAIN_UNMANAGED type.
> > Return
> > + *                     ERR_PTR on allocation failure.
> 
> "If @user_data is valid and @parent points to a kernel-managed domain,
> the returning domain is set to IOMMU_DOMAIN_NESTED type. Otherwise
> it is set to IOMMU_DOMAIN_UNMANAGED type."

 "If @user_data is valid and @parent points to a kernel-managed domain,
 then the returned domain must be the IOMMU_DOMAIN_NESTED type. Otherwise
 the returned domain is IOMMU_DOMAIN_UNMANAGED."

Notice the detail that this API expects the driver to set the type and
fully initialize the domain, including the generic iommu_domain
struct, which is different than alloc_domain.

When we implement this in drivers we should tidy this so all the alloc
flows fully initialize the domain internally.

Jason
