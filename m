Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF997D1E4D
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Oct 2023 18:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjJUQiS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 Oct 2023 12:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJUQiR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 Oct 2023 12:38:17 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FD5CF;
        Sat, 21 Oct 2023 09:38:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WC7Obd8cdd3k54CzSJI0uUys2rxNSaSp2NmqpA8mePkzGuBvh3Ny3w+oflm1rnBGnULenIp1yjSOzaR1cUuCW3R21Nq1Jlf2Rc7W+zpNxZDTVX6oe44YJ4TEGqeu6I358KH0oGtGbt7ycfXkh4z+PteAssbIZHGynjyPLkvHCItoyaZS9ZZUxY7UzIPunJVTe0uzss0UiUSaurebvB39CJk/RYy/k1kIwyKMbsLEhonB6gv9DzU+EpZc0l5TYdEvtFXwqT5fcP/b/Yt+E0DXlQ0WGUkZ9ijjtbw9fBoOmC/nTIMTdUYsWrkfgPf7vKtco9AwhZrNUBsyGrgBqAMOtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXFsKfoIPwjFzVx6M7AD6bIeFijyQTJGc5KJ+5ZFgdA=;
 b=GLwmx7ds3Z5Q40TspZuBzDpEeCcA/FJ/rdxKC4OYiaEPXHlF8dQWHfCPI6m1EqpNXvyK7ToQ4whmIYyxs9xaE9dqe4jvowhnoRAYL/MBfLqijZYjPg3IC33fnYMjn+u5UIe+BKVXgrEAYUAsOu5z9rJjiDo0KtPlcPVOjUP+645F6G6TOG9ESl1eOfsGT9HrmpVD2599knNF1j1RmVLqJOys8qLWs592XuA04UhzOb6lfinXfT7EoVyJwQTXVvTKk5yCQCFnZ9/oGzsRFk/hdfNGnUPDDRLbqyO9AiibsBiT3wQnpMhrrgoFOJdofxfPEjmx1ghk5kI2+7iPT3A3lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXFsKfoIPwjFzVx6M7AD6bIeFijyQTJGc5KJ+5ZFgdA=;
 b=frGObs/2RuWIzBZsqPRrGOMnM4qh5jimw4M89SRWH2FGbaklzKxSWI3ZcPCjYVEREJwhqFUXQdM5wnn4H/cdhYvI6km6smic5bWp4hogOIduVyZ0nOX17Em2KBSlcZ2c+rQmeuLUUJ8tEyp9ZbGYYV8zmJQnMQB7Dv3Doh1CW3Shf1+AiW7a6Ny5sStskAUh9XMFmOFV5g+XhIK2wA21USW7DAqYapHFrE/pyPZjE31Tyhc9b36qq4+20c+fI43Y319ejmOGsll6lDVjJBUyod8Fbo/fLWCzmW+EGxgwe8IQgpfQp+Mfxnpx1MzJJ/E1J3n5RSHfJ8O6lUl/tC1lyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Sat, 21 Oct
 2023 16:38:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Sat, 21 Oct 2023
 16:38:08 +0000
Date:   Sat, 21 Oct 2023 13:38:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
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
Message-ID: <20231021163804.GL3952@nvidia.com>
References: <20231016115736.GP3952@nvidia.com>
 <BN9PR11MB5276FDC375685CE04A7AD93B8CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231017155301.GH3952@nvidia.com>
 <ZS7nb+mKanGFXhZY@Asurada-Nvidia>
 <20231018165113.GB3952@nvidia.com>
 <BN9PR11MB5276B9994AD06E91E07B7EF08CD4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231019235350.GY3952@nvidia.com>
 <BN9PR11MB5276A64DA68586AEFB6561148CDBA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231020135501.GG3952@nvidia.com>
 <ZTLOAQK/KcjAJb3y@Asurada-Nvidia>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTLOAQK/KcjAJb3y@Asurada-Nvidia>
X-ClientProxiedBy: DM6PR06CA0070.namprd06.prod.outlook.com
 (2603:10b6:5:54::47) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: eb6d2e2b-3375-43ec-c6a4-08dbd2541a7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 35xWPfUXA+h7VuUg86fwUGNVZ4INFEu3p46QUXhIdC1oLf432jJQKH2GcmAK/MutYdS5jXJ4nw0x9VYUpYFA/25nyAolLGMlgXXlfe6pvW9LsppgH3pSB2f/kJWTeDeZlchIL1DgQaAnSaXBp1VtdbUii6kreXFqP2b96fxgTfb5CXCy54J2lSsUv0jrWqhoANZ2G94Yh1ij98N0r5jrRjG/Fl1K867TcYg4QweiklAG0vjVEPEZB3zW9SJjh3eF8mVBiK9rYL/Ln/C73zHzEOSNnlDQHfeBzRtG41SlYc3FMX5vvFII0xIujwtmyfMPoHQqi33OhWe9qTc2rpYUC/PY9Q5NsYeaSIxCboMO6JKL5YPYSCNwoaYF5yI+EUwd4zyYcdfo7g5f5K3CuX4cSWT+UnUR+0hRL2zjOkabHbYaxWCx/E/BTP1Sy3SQf2WSnDqObLs1puMYXRNN62XuDFn0gdIYLbDwP7rQSW9HDlE2V+nOYmvQgqhgrAHiFdcWQHyOamORBfaBCZ2+kRw7E9bSuw5H9An1Pd40y+FetCZF8PZYEVSe1VeWenumkd8s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(396003)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66946007)(66556008)(66476007)(54906003)(37006003)(41300700001)(86362001)(5660300002)(6636002)(316002)(6666004)(6506007)(6512007)(6486002)(478600001)(33656002)(36756003)(8936002)(4326008)(8676002)(6862004)(2906002)(7416002)(38100700002)(2616005)(26005)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGhZQXVXVjJIYlZCYzFCWFNNM3B4RTljZklzVFJtSmd1eHZOenFUNkpVYjg5?=
 =?utf-8?B?Q3lxYXY4anVDZUhETm5XVVVJRUdNeDdhWUJGOFZjZ1dmT1FEOUlzRmxHQkY3?=
 =?utf-8?B?TG5UaGNybGtjSzNwWlpkUTNiZXVqWFVwZ0JtVjRaQVJDUld1Q1gxbWJZc0xk?=
 =?utf-8?B?SzllcmhSYTU3VHhPMkltMFhvbk9YWmpJMEhTRnplZFA3NmpsOTFXdUphN05x?=
 =?utf-8?B?WkFYTm8vZ0o1V3JxQU1XblA1dHpGUFhIVEpvTDlaRE1ka0tlNyt4WXV5Rks0?=
 =?utf-8?B?aFI0d3F2OVZNVnZrcGJRdEhya2RMbjlnK0d6RTFvQkExbGZEdUgzYk1GUEkx?=
 =?utf-8?B?WWd6Sm0xWis4T0NRUUxlV2FjUjF4d0FjNmtLUjcrNUVCSlhQcllUUmR3WTcy?=
 =?utf-8?B?eXdwNldnM2RKeUVlampNUURlR2JzeXIyelIvN2pNc1NTM1ErcG5ReDVxUFFP?=
 =?utf-8?B?LzRvWVpRQ2UvWnIwbUI5V2IvNkt4djdUVVNPenpwRVJUVGZsUXJCeHdiU01B?=
 =?utf-8?B?UGl3d2ZjQ2hKb3liVmFUTENIQUdkK21UYTQraEZxN0gra3ZXdDBLT1ZRakNx?=
 =?utf-8?B?Slo1cGpycGxNdERVbW1CQVBzZEhpdndhSzB5R1VrN1NKTVVuWVlHUzA5bjdR?=
 =?utf-8?B?Smc0MmJxd1cxVko5UENRRnpka0VnS202cVRBdmZWV3ozZ3RET3l3dEhkRWdH?=
 =?utf-8?B?WDBvcmdXalNjTG9yVjBwOVVreERpNHI0bGFycElVcHM0NURyb2o5alNNUDVW?=
 =?utf-8?B?YnkyeU04SEM3ZGF6R25JMEFncmljdjFXZm9FN2Y1cEFjY1VtKzZJdEplUm9E?=
 =?utf-8?B?NDRlb0JhYjllaWtqa0dIVzJpUnZuU1JxNjJZWWVZQnM0ZzNET2c4YVBnaWFu?=
 =?utf-8?B?bk1Dbkh3ak9pZnBBbWl2V1UzWFMyN1UrSlplOFpFZi95NnE1VGFhRlRRYlhy?=
 =?utf-8?B?NkJBbURidHRjNThzTWtQK1pZSk4veU5VSmRIV2VkZmg2bWE5bklBb1pCV1hw?=
 =?utf-8?B?Wm42czJTSTJmelhQRUdhTW8vS2ZzcHdlZThqcWFzc050QWxHZEdhT1A1clY4?=
 =?utf-8?B?WklpVEhoNDlsMW9EcEtwTmY2dkhCNTVrR1dNZENUWGcvZ3VxbVVZdHpKNjA5?=
 =?utf-8?B?dmRhdTlIQld4VHRLTGwra1l1SG5EMmdiaDVlS1BadUtSSUIyRVhNeDBTZXZ5?=
 =?utf-8?B?UUhROGxTaXdSbVhtcmExYlc1RFp5WEpYNVFrZGlUdEJFTkNhUUE3aDI4cDZN?=
 =?utf-8?B?NVdBVDRWaHU1WiszVWZYUzN3cmVGVU15a1RJRVZieUtsclpoOEJtYjRaMWJx?=
 =?utf-8?B?QkpoaE96RWpaTjZoaHRQUXJZT1liSERUZWpMRGQ2c3NDR2hHcWJRenMwcFI5?=
 =?utf-8?B?VmtJdmpxQTcwS3d1VHlwb1dIcFNpT0JpbEpOWmNINjVPOVo1ODRKOHhyVVZJ?=
 =?utf-8?B?aTc5ZlIrdnBIL0hxY2xLNnFFdnpFK3hxdndPdzM0ZlgyUWQrYmpQN0ZuUVpF?=
 =?utf-8?B?TVpFZE1wOXVlNVlFSVVXV3dhVTVXK1VCc3pMQ1hGUXBFNTlPL2EwMEY3VmN3?=
 =?utf-8?B?aCtZRkpheEZxblJ2bDlESi83UkFEc296dEdBODNKTytmV0taNTRiZ1BNSWkz?=
 =?utf-8?B?Skh1MlBUK3U3YkZTd0x4UXhDNGprdnZIKzJxZDA0VlZRaGRhQ09QNExLS3hO?=
 =?utf-8?B?VXQxTWZ1N0xDdk9rT3VnUXhiZlptZ0JhT2NNUUwwenRMNGJLYmpScDZ4TS85?=
 =?utf-8?B?b2tuWFFIQm1wWXdtM0c1eXVaWDZaM3FNSGV3WkgyNWI0M1phaEc1K1BmMkxo?=
 =?utf-8?B?MjNEdWhvSDh2czdTbTJvZXBXL09ZYlAzbVY2MWJMN1RNYnVVd1lya2ExeGNw?=
 =?utf-8?B?MWY5WE9BZ3h4NHBZU0cvKzlyNUFBcTM1YmI5aUE5ZWRrUWY1cFBGbnRJM0lR?=
 =?utf-8?B?QXVYUnl6VmpBcnJZNlZPMWtLc1BWSVZhcnJ6WU1XdmdrNWVxS29XSzVZY2Er?=
 =?utf-8?B?VHE2a0tsb3lnUGtUZkQzd0VTVWJOWjJxaTh4RG1YUWN3eG9oL01NWEpqbzdU?=
 =?utf-8?B?Z3hHcHN5YjM1bTRhZlovTVN5dlNYd1FOVTBTTWIrOWZCM1dod2haQ1JFa2ZL?=
 =?utf-8?Q?gfig=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6d2e2b-3375-43ec-c6a4-08dbd2541a7d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2023 16:38:06.8300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CtDAtWajKoTWBXdrmhopWlS8b1dyuM2I2gS+Pc9RXtbMnoQkxYMWDfda5ElxxZ6j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8800
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 20, 2023 at 11:59:13AM -0700, Nicolin Chen wrote:
> On Fri, Oct 20, 2023 at 10:55:01AM -0300, Jason Gunthorpe wrote:
> > On Fri, Oct 20, 2023 at 02:43:58AM +0000, Tian, Kevin wrote:
> > 
> > > What we want to prevent is attaching a non-CC device to a CC domain
> > > or upgrade a non-CC domain to CC since in both case the non-CC
> > > device will be broken due to incompatible page table format.
> > 
> > [..]
> > 
> > > Who cares about such consistency? sure the result is different due to order:
> > > 
> > > 1) creating hwpt for dev1 (non-CC) then later attaching hwpt to
> > >     dev2 (CC) will succeed;
> > > 
> > > 2) creating hwpt for dev2 (CC) then later attaching hwpt to
> > >     dev1 (non-CC) will fail then the user should create a new hwpt
> > >     for dev1;
> > 
> > AH... So really what the Intel driver wants is not upgrade to CC but
> > *downgrade* from CC.
> > 
> > non-CC is the type that is universally applicable, so if we come
> > across a non-CC capable device the proper/optimal thing is to degrade
> > the HWPT and re-use it, not allocate a new HWPT.
> > 
> > So the whole thing is upside down.
> > 
> > As changing the IOPTEs in flight seems hard, and I don't want to see
> > the Intel driver get slowed down to accomodate this, I think you are
> > right to say this should be a creation time property only.
> > 
> > I still think userspace should be able to select it so it can minimize
> > the number of HWPTs required.
> > 
> > > But the user shouldn't assume such explicit consistency since it's not
> > > defined in our uAPI. All we defined is that the attaching may
> > > fail due to incompatibility for whatever reason then the user can
> > > always try creating a new hwpt for the to-be-attached device. From
> > > this regard I don't see providing consistency of result is
> > > necessary. 😊
> > 
> > Anyhow, OK, lets add a comment summarizing your points and remove the
> > cc upgrade at attach time (sorry Nicolin/Yi!)
> 
> Ack. I will send a small removal series. I assume it should CC
> stable tree also? 

No, it seems more like tidying that fixing a functional issue, do I
misunderstand?

> And where should we add this comment? Kdoc of
> the alloc uAPI?

Maybe right in front of the only enforce_cc op callback?

Jason
