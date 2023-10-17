Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5837CC812
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 17:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344172AbjJQPxH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 11:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344171AbjJQPxG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 11:53:06 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCEFF5;
        Tue, 17 Oct 2023 08:53:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZ3Zdt/APRYREVcyH7/lmtVJvyUKDiSF62Zn6Xk33fjteHkZeDWtfdUZKJyMlzhezlPneUeVUqW5MhYTXKyDWZhjjl7sP0OGa6+C/ynmuNgm6Fe3Ma9snd0gKfd/stUp4KGPys53gtjK+pRcsGpCua58ZADKi73m+tPp+S1z++IM9QOAU8Bl8Hwqbm2s0O+tJpm/hcM1Q79uqGMLh4eL7pwE9oWbgf6rmaHQj6kUStsjtwQy5jG2Pc829DCDTwFrZIt+LquN5wdpCr8PVXSQ4RvJ8VxmrAZCWGmAT2vrFUX6RPwlOnGl4EgAuob/NazZIRlqwid9JlWJDssKaCj+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFbof52cYaJtnSkZPn1krL6DHcFuRtm3ejnCquI4kQw=;
 b=nys53Oidx5g8FmMKbxYHgr50oPTwHDc8fkP3x6h3hQxkorOpXHypDah1VJSZzBYa8dAfzyKVQZKE6Oj5XSeZ1vUM5923+Cjq2KsHzUBiVPPM2zbUh0H6OXwWCfZaUdbJhmn7JPieGYyRC6sOGmx6XUfCjnfThvvc73YxRGSwmAKOJTVt4yVzoWFTmqT/pJ64rfQAUaq1mF8J5XgTW23j224LGEyy25C+OjdjnU9tqdXStjZVuTADyJ/ZODA6xX3IvAf2NDUd57xD0Ey2HrH3J4BJKgCZNXp+4Ha49B9WaQuTLc6FCRqWlJeCbba79HDHWrpR5mYA1ovTO+pOegXrIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFbof52cYaJtnSkZPn1krL6DHcFuRtm3ejnCquI4kQw=;
 b=lf2F9rt2gBwiyJiwIdJaTFG+h7/RNlrquTix9blF0ELcuRrpV84AZ7WOmewu3o/LZ4SdN6YUB2YQWppZPxxWpOTI/QesEygmVdRnzctFFCiH7GM4xWsFjx5oBasoOjUUULjaNFeDpyCeL3UCstSMj6eHbItIrvfwFW406hwWk2YuwehuOfSF1mfhpIhWE8docIKBqH05U3c7T0cJQOtgKTVPyrcfAhpfznPTQnlR8Zi6W8yaj8l7MuVf2mU0/+mr77lavlw3hmUXVBwL9N5X2ceqJ4pqOAUovNkHQt7ME/1ReqczuAFrmESTZcvEnl3NjaBbzv8QqVZ9pn07phlAvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7875.namprd12.prod.outlook.com (2603:10b6:8:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 15:53:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 15:53:02 +0000
Date:   Tue, 17 Oct 2023 12:53:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: Re: [PATCH v4 08/17] iommufd: Always setup MSI and anforce cc on
 kernel-managed domains
Message-ID: <20231017155301.GH3952@nvidia.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-9-yi.l.liu@intel.com>
 <BN9PR11MB527658EAF017FF3576667EEA8CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZSnkiKoCspmG1+/j@Asurada-Nvidia>
 <BN9PR11MB52763227866603ED7795AA068CD7A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231016115736.GP3952@nvidia.com>
 <BN9PR11MB5276FDC375685CE04A7AD93B8CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276FDC375685CE04A7AD93B8CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0078.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: f3feea3a-a31e-4451-8cc2-08dbcf2924e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 02QCFSPTTeR3m7YFe56CV6JJXGtFeDTejiT9g/cBEYz1H8WeSSqPxJ/x1fX+7dN3RKRlxSkZp8MQcGCXpkGNipOQbFLWcgPLgF+sQLJEwwoDjZ7V+nqtg7MHzvu9jTWQL/ZY0Yz/zuoZPnjK/AcQNOkgvLJDm1IvDboWduEWhvUXHK++heAsEkDH86WN43hqqFC5JJ9yW51Vhw44g1dnsA12k0GfYYBn3s6Yi40AXauCeJGWBYTQpXw4xX2K9zItbDxDk0YzjdpMANSbCoTSZJZI8yrW3XNKqML8ixHOd4CJhODCeytyvAWJZD7LlH+CrUtyZoidP6kTwrwXM8HyHKxdwUZyCZOWIDKSHLrDqS0sk8laJQXRFVqsU7WwqSAB1P8TYLUmc2Rx6kblhMRoyH8YM0T6s6h+aw6w2Td2AO1F0jmJ2e8BjyVfIyGSB+ymCeK9xkDJhuWfIu2zw895MQPuG9v+S7IhG8aUFUIy3Y7FZGLAxDQviHxoNxaFyMReIXTrPekx8+RU7mw1Ae7qHOb6YPJwaKccTiLja1tXrvjnfQdS3C/Y8bvFlyafDkWW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(346002)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6916009)(66476007)(1076003)(26005)(2616005)(7416002)(83380400001)(6512007)(54906003)(66556008)(66946007)(8936002)(4326008)(8676002)(316002)(6506007)(41300700001)(5660300002)(6486002)(2906002)(478600001)(38100700002)(33656002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jmpsXSMzZHs0BmAYSlaaSF6PBPRrTVQDLZkOxkH15XIWhzPOsWmrDyQwpwTK?=
 =?us-ascii?Q?eQSeslHE5Jx3Fdcmw+B7Dwcr5hx1mdmlG3f8fGShQHXl7unK4LFFTIkrXSj3?=
 =?us-ascii?Q?XX1mvBAKGZGC4iMh+hIzyhxMTkGukcjsQI5dv5qC9dccJVGQgsjdIjBvb8vm?=
 =?us-ascii?Q?p2aQ7iobo5YzeJO2wJ6CU2o/1Liz/NPjM4W61Qoz1F5bR6E5/TuqKK/wqmR3?=
 =?us-ascii?Q?D19mss2g02wTf0a+8DY+qCftL6NEkp0BAQiB0E1wTVaeHL02w5aOeWqhTxEs?=
 =?us-ascii?Q?WJCezL4/2n54GuG4g9iEFCEKIFVW3zk8m1uNd1E836Ts13pWzMuJNQyCprqO?=
 =?us-ascii?Q?kimN8OhD0WlITpTvAIAZZZmWQtvazZgu5QaNJT1XgUZDgPFx80C4H4XWNkZB?=
 =?us-ascii?Q?LUYPeQyGdWY9IEszoc2zo3HaAQNZTe2YWbqkNjUyPH86vYm7sJ3KRcgwOxVX?=
 =?us-ascii?Q?1uKvIJTm9ZKw+sju3wv2jdJE2jWFalj62pd8iYIhh+2za4Gtqtx7ORyVpbJU?=
 =?us-ascii?Q?TjqQdFi4EUbemrkTPoqci0fgMzAx1Xr9Ll6oEYUiOX+Vy3tQTAJewkBDrmV1?=
 =?us-ascii?Q?/CVAv2X/4z7gnR6p4IIFTeYQyopGCOG+jl0gWh8de9v48hcqPYjkHyLqkhZQ?=
 =?us-ascii?Q?LBPpl9hD1iwLPxQbQmR1Mf8SjIUBqSTHpT4pbh5nGNic2Ip64F5GvLgfl6Xm?=
 =?us-ascii?Q?tWRQyuZGOkg1vBuNhfyqTnvXDrjqISqLKHRdlM5kRsFkCiIWdvBYwblZ42lu?=
 =?us-ascii?Q?ZfDB3umqMRcSwUpWBTLI8ZoknYDbJuZ9gv8Au7fXQU+EL/b68gL+IrYEMpUE?=
 =?us-ascii?Q?cIrpSvYjC2+40vqRXwYANycINhCyI2sk+trb2/eR6IkhJym/gbyHMsA8ZAUO?=
 =?us-ascii?Q?gSt8859+Y8LNWbUR3sJjN7HHi8GtbL3gjEleU0xmzN4z55cmh/o3McLmOCQA?=
 =?us-ascii?Q?8LFXFmMv3kLVOhlYwE/pLmATsG3Any6LtZ34eqzFsnDLmHcCkuSW2OkOwPX7?=
 =?us-ascii?Q?P5C+a8U/78h/Ysd5xhmfP9j1SFN/vrY0pu8Kh3pdb50ZdhYiru8ccA6PRMEU?=
 =?us-ascii?Q?uhju0HVrmPjFmEWb16rw+98mM1KnjiZyRxjWdWOEzAr0C7AOoORBv0zzBI+A?=
 =?us-ascii?Q?/liCZsHgraO/MuibQtpS8kZ95gy2fmwlA/DFZezAxcgqdXAbcGAEDRP0gjMp?=
 =?us-ascii?Q?mHyyEkKPgR0EzX1LDss9hVFmlnoTTrZiCBCrtVVSfzWQQZNx4V5Al5FQf+4m?=
 =?us-ascii?Q?dKgxl+EVlojbx9+HR0NNRag5Spnvdw+zUhynlPfAIbLrv7vw5i5CxBb107oT?=
 =?us-ascii?Q?ke0CC9gEYxSG7fgc/ldTTxg9uIN9wKM2CDrwDiOMYpuQz6lCgHLcWI0sdt0C?=
 =?us-ascii?Q?+XQTzvvn0hK/ka/tD+J7dJqGlMDq1gdRa4uZ3xTbu/qftlQaNTMCDvHDitpi?=
 =?us-ascii?Q?E5plCsIE9uA9a4xfu8ArJC14g9zE1rxDjXinhNpEKMFz4U/WNCliMHlO+MsX?=
 =?us-ascii?Q?YlG4K0mk0EN2wku+CD21D7bkQexAncXpW2MCpC2Az83rASCy5rBgTZchNown?=
 =?us-ascii?Q?dDfGRbMsCoHTcjSzD3ygapur09PeHi2EIl+V6ja4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3feea3a-a31e-4451-8cc2-08dbcf2924e0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 15:53:02.3858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FsqY8J8neSPSEQaVShxGFdR+hIgCPnN2Bl2QRXZzSIzRWaW94u8VbrWwEdJ0YI1Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7875
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 17, 2023 at 08:52:49AM +0000, Tian, Kevin wrote:

> > This is why I wanted to get rid of this bad mechanism going forward.
> > 
> > Manually created hwpt should have a manual specification of cc and
> > then we don't have so many problems.
> > 
> > It means userspace needs to compute if they want to use CC or not, but
> > userspace already needs to figure this out since without autodomains
> > it must create two hwpts manually anyhow.
> > 
> 
> Now there is no interface reporting enforce_cc to userspace.

Yes..

> Actually the user doesn't need to know enforce_cc. As long as there is
> an attach incompatibility error the user has to create a 2nd hwpt for
> the to-be-attached device then enforce_cc will be handled automatically
> in hwpt_alloc.

Uh, OK we can do that.. It is a bit hacky because we don't know the
order do
 
> I prefer to removing enforce_cc in attach fn completely then no parent
> trick in this patch. Just keep it in hwpt_alloc and leave to iommu driver to
> figure out the attaching compatibility:

You are basically saying to set the cc mode during creation because we
know the idev at that moment and can tell if it should be on/off?

It seems reasonable, but I can't remember why it is in the attach path
at the moment.

Jason
