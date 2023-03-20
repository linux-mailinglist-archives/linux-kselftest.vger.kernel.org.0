Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BE56C123A
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Mar 2023 13:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjCTMrg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Mar 2023 08:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjCTMrY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Mar 2023 08:47:24 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5380035A8;
        Mon, 20 Mar 2023 05:47:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1zfTnOJEBJlJBPNvmhqQZ+30/8LJStOoXGJ+jYAK0cD+MWqGDKlAYv5L1pn2ir+L/tkGdDkoBUwsfE975ZHKnyeTIOuxEoXAd2KJlXNO+faZ74c/3qnHL1i6eUqcLkoB5E6xuNaS+PzIKOS3smMmzCXYH82yGrClLGcX6nOfuaXKHBdEHttw1AuMOqxUhIXGu0WJznYzi5wnnGIXuN11pYHzEIRyfnszMPSswtAPkaxD2AvAVY4Q+/VQ3k7ZoLr0XtDDeCLGbZucbx90t87pHQbIsI2Zmw06i65w/enDSTX7dpW/HERA1zvYnFt/h3VzDub1X6fI5wkSpZ47M6ujA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adpwqKhgHfQV2VjmstLGM6aYyKtitLuoqCoMdj1KJvM=;
 b=l8n/Bz9Qw0YmD9rbTm79cLDsEppecapMzwX8z5XiB7ODTlyCgF9nXtjGG8jVfXCB8JHJSJNQNm4sfuLFNPPqGiZFeDBEn5Ueuheu4Un/Sm7EnPHrZZf8FLmhrBQCaSKzjFDJCR8yXCYAgC/Y8doiu2JU0j09BdzGM7DHlRZvdp+V2uJDHrRw8SITjnSirVeJKABcqKGMSkXMznkIG5l1uLAtR0Wr+jmawlZr03tAdps7BfoJYfqj0edzR/Ce9+6vuKTkuPK9bD8xtPG4VCEWhCsklCILH5lZh5dMnbvr1SBzrn/eY07HCOfMdYLEpiCtNQF4mW5cvvcNIxktmmXnjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adpwqKhgHfQV2VjmstLGM6aYyKtitLuoqCoMdj1KJvM=;
 b=tw2oWcwIcyKROl0plBwCmtAfRgy2fqivtnrqn+o2T6Q997D9s0pD7FJALuX/bLbZWTlwyh8MULCyefbWLF5cg9ognO4g2KcXfFRglyvjlVQ2tYQyVZ24FcxAMowmV/2HXEmyFAewNNSGHIVlqS4HZ+U4gWoeeiuUVk0AGEfTsMdgxJudbspaAskwQMKlY48oPAcLSMAnluMtDMG2Qydd1qeHS5IryFkvN6UWlV471kayvTJ8qSbkC6AdCBP4/rNwiPxH6xCmKBm/ypdVsm3h7beWK54CFYk2dTkAYcJFOxVKW5tsvXq6Sqn6bqaP8dS6cqAEMpTs7fv4cq0lrRVlzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7584.namprd12.prod.outlook.com (2603:10b6:8:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 12:47:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 12:47:07 +0000
Date:   Mon, 20 Mar 2023 09:47:06 -0300
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
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 04/12] iommufd: Pass parent hwpt and user_data to
 iommufd_hw_pagetable_alloc()
Message-ID: <ZBhVyqEeAbnJJqNW@nvidia.com>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-5-yi.l.liu@intel.com>
 <BN9PR11MB5276815B943E2232F158C0128CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276815B943E2232F158C0128CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: b530ec7e-be6b-4e9e-2945-08db294136a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qPb2Gwk6OZaeAznB0o1EbuT/6eplbwiu4/GTgl70eLgz+TU9C03xuZf29NoQRZJ57ozpnupv6M8svWnU05DSv9jHlV9RmWjQ4uBe9rQHmrt+dAtgW/x07sBI1zb23MPzfZx1A1YynVOvU9zW21JDYFXTFV7dz1gdPFv4PsYlXTU6HYX/oZ/jUakFKLLrOB6i5rU09lpYmrLY09LfWJcduUGQOfuFKMORrtG0HCXfuw0XEW3wOV5X+Npyqy2k3mKGax5xMibZfzVxuc9a8mcxBmYmd287rWpLcduOpAjqwon3oFQBMCZMXQd4aiWcr4QL3kE1xQb2UHM0cwzzEqQzar61DJEQo6v0AX1WaOF9cyTpT/zJyf+6Isb+7slFRSwkfP/a3lG6NIkTxx0514S4WapSqJeXHGe3AqO5opxv88WRhFjVw0whF5CyVL7Avn3bLzUb57HWUh5Dhp4VLxvxhIBewizihsXv1P+Zui98pXe02mOFLEnN8n8EAvIFj3x0kyztfaxf2onlO2f8oaZFDEwS+x6Jd2IeWZGgkaIcBjeW7eQVXCNccpXxbhLrNERsVFARz/RrqgJewpI61b+OBN5VCRX/UFGhwFRRd1fkBFtEzJLrWF6cgPonOdlIzTm0ARMRdnI40LPul5c+g9AVrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199018)(2616005)(478600001)(86362001)(38100700002)(4326008)(66476007)(66556008)(8676002)(41300700001)(36756003)(66946007)(8936002)(2906002)(5660300002)(6916009)(4744005)(186003)(6506007)(26005)(7416002)(316002)(6512007)(6486002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?isAP+HDZ1A20a0yX/ePyWv0oEXM0YRgTqppR/1Zkwd7BwSn6nhv+26az2N9V?=
 =?us-ascii?Q?bo6bOWVew4mWShq4cs4taazku9QrqEAqaX2ECopc4wAwbXiMAWg+mm3SWHx5?=
 =?us-ascii?Q?gQNmlZGl21ZrCPJBOjX8pxJxft1+MmBz4BqKAhfZXXn6alfdeWKQEBM4xu7K?=
 =?us-ascii?Q?rHihEpqA3h9GLsVmsvYg4hPzq2EI6nb1MaO7wdMCstFS3xaH9wujGNl5RMhd?=
 =?us-ascii?Q?raUtuVaWTMhzi3KdnFd+TNlMcDrn2Y+5MfI+iz+e662Vs+gkvYbYF6YxAS/2?=
 =?us-ascii?Q?HQBK6uCATpZnChn9vzfF7gOPspFXnxJrn/HOrBc76eJ1Wq/gY7vEkC8f+ysm?=
 =?us-ascii?Q?9e6E8TRnTZSlLfiHPyq3QObFxDhbPvuJFLqvXpwfVI0NmaZZHysG6eYof7Om?=
 =?us-ascii?Q?TXXg9prOgjeKVwaKb/QoAIkeVewFCxsje6IqmjMUuqP1vmc1e0ByAj+iAwYS?=
 =?us-ascii?Q?yU5tGmqXLwyG14JN4NN1Rihh9TjVu43GL8mP/nMTTbm/xORfgXcSJQgrOrP5?=
 =?us-ascii?Q?6GtFpk2wS32mUjzFfkT6XAxb4xUFKl4YLJrF1q6AJsWtAijuVmN4sHBQR7Si?=
 =?us-ascii?Q?AwRCFW/1N6mSbmbDm57MQAm5gE9F5a9aM0ngWVyA8xJOSlFt4IXHF6QxYclI?=
 =?us-ascii?Q?bH7XTZPqYwam3U7r2ZdCKl8/mOqrxBi2oKeEy7PPrvJmORilxaKn3d8wPFtm?=
 =?us-ascii?Q?6yPdX3wzS376GoolC3r/L1SrBM4PCspjJirmK7MFBHJ0czJIjnlYeJ6SVzwZ?=
 =?us-ascii?Q?uWZVX1yXmRqtpYRRlAbVKxOzsWp7Kzq6xf5/XB6e+dcRmtpUyOBRkRaTOa6l?=
 =?us-ascii?Q?NVMixr784k6RtfIBAlf9aWZ9MzTgcLph8OSlRbjVQDE6r0ZQWGoZUXUaIdC2?=
 =?us-ascii?Q?NiDmma3qxVqCHaNu7d+jC4wHeKtMlYwUa8gQcSgCzCHTrHJxRDqKzDlh8hOS?=
 =?us-ascii?Q?z+r4hf2YDps6X8EevxoEgNfK4mjtLH9h1uvT8yHFxJHsOspkeisI+6HpmvYs?=
 =?us-ascii?Q?nEjfZC/hmbX523WkLlu5AKaH9bQ0xbxQmVOWFLkq3iesoZS1DWYnqYm/7QzN?=
 =?us-ascii?Q?zQI6vwTis8mwu8IRG11YZlwG32k+0K7j2oZiLP1dMqPwRAmcOjFG7YlEVcJ6?=
 =?us-ascii?Q?phv5WMhPnIj3tLmyTq6LOUrfg5hEAxupk9OMWKxahMXjimFCo6aC4k/EPlcg?=
 =?us-ascii?Q?wZ1xygzrG0vGKJLpvWTZKvMher12wE78F4A/j+f1PpvyIdMdvnq00g2wLG5P?=
 =?us-ascii?Q?xpymdHYrddt3jSX4MORFiATPuNIa9/zh/idiQxNWjNWoseTYvoLNhO5bNXIZ?=
 =?us-ascii?Q?iczM/1hNVcSzFApQHzTDscSYJ7q1xJHaE8/dACMVAgu+01npfEg9SFeEoRiA?=
 =?us-ascii?Q?ygMHgEYByQqbCYmwMT8JW9oBohY94MRtg8HYJHUg79tEOpdNNFxDgZmu1nP8?=
 =?us-ascii?Q?bsRWldxm9YjNGAB6viLmV4jnrtkr2XZ3mWN8b3x+iCmlauIalRERpuj6FiPt?=
 =?us-ascii?Q?vFOHTgLWhZyAxjt69gtdvJGwFcqD/0thaSRlxQqs6plJKwkzGET9mFJaN3PC?=
 =?us-ascii?Q?1oYFodvQ1IkVA2PtXF0E1PMQxApZWbi20lWHCgza?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b530ec7e-be6b-4e9e-2945-08db294136a7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 12:47:07.0844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5U1HQx4eCyGeVW1AbYEWgWApPL18ZansoxrxYk1Hb7H11Ue+JF/AF8gnq4WNsw1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7584
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 17, 2023 at 10:23:54AM +0000, Tian, Kevin wrote:
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Thursday, March 9, 2023 4:09 PM
> > 
> > +	/* It must be either NESTED or UNMANAGED, depending on
> > parent_domain */
> > +	if ((parent_domain && hwpt->domain->type !=
> > IOMMU_DOMAIN_NESTED) ||
> > +	    (!parent_domain && hwpt->domain->type !=
> > IOMMU_DOMAIN_UNMANAGED))
> > +		goto out_abort;
> > +
> 
> WARN_ON()

Wouldn't that be userspace triggerable? It gets to pick the hwpt used.

Jason
