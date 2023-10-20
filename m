Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C642C7D10E8
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 15:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377304AbjJTNzI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 09:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377274AbjJTNzH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 09:55:07 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2D293;
        Fri, 20 Oct 2023 06:55:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvkZVyjO7JNd6Onf8/mIxM/rBolIPWC5NMa90Nbm/gqelM4Cz9YelEP84sniYbZrVOxNa1E0eL66C4PqzEMWssqOyZu+w0dF5qgj7zBK54tqzOWM4Il6dEKkNhCF6l0BhRrpvKwS1q8lbt1TKSS7oqPLDlQ6MjpUX81tkAsceVn1ab5oRDN9CueJfmBGNCkaIZJNFZFEev1RTU8Yf2WdsvSLaBQrFxVqzenDekkHzWygqNvdWaQCALj0FKgO8++4ggtHKK1hmBCRO18omrV/yJgqsYd3KqlssIMzHJBo4Jm5dGApl5afu4N98IyYhLvgus2Emt9W15sTlGJJkv5xmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+G9ltDunlJEV+CdkMQrzqQZwqTINUmGvyd4w1hl5E4=;
 b=dgHjTfcvz2is5ap+0D4N3UNBl1eoAEG2iAbyeFBhabfK6VAqKiqobtGDVk0eK4gNe63+RtrwamPKRacojwMqWr6NU2pbPPQzhvDWsYWbIew1b1gidtLNW6pfj6TLVM3ON/teBOJel92My160G1fnQ43vFyONccMSZma8e3vbqIiZC6c8ic/9AanrPd6IrUWQWrRgD5OyfRqPdIHXCgtW5XGzAgIzqFazKVPk7ubYbWJ4CcE2wuZUVzwwjkb5RGrTIYNaRpi63TKmd8//DpxT8oeU22XMjEbe9Ieg+85DerW9tFrKo638iF5iudwOCDloTsk1534PGAsKXkTgNrYs2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+G9ltDunlJEV+CdkMQrzqQZwqTINUmGvyd4w1hl5E4=;
 b=aNsJ0Qf7cxfQO21+IeowhhmZ49C9woxqZkj+AMjJVXdzXiEe+4T2qv9tCJ4cLq1J2qP8LsbNjpc9OMV+yfkXs0bOMOrnixt9mnMBweyVOBx9lWena5GJB7Yx1XjSkxEI4LwYXUh0xKzC8dBKV//ZALBeeTrXcqThmDY8edn0M0/N6RHMCo8v4S4Tsg+PbOcP9Cnnbnj1kedu7QW18JQgU8J8EWdGxSbfJI25Hdo5h9qi0GrVW70F/OOOuPjIbqrgBwCa4F1HcFBw/vmFmbczewRqI2xrb2ZDAOOP929jtIcq03vR5AD4DMppWuFAOtOqNjNG8VlT41joAYMfMWsLvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5071.namprd12.prod.outlook.com (2603:10b6:5:38a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 13:55:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Fri, 20 Oct 2023
 13:55:02 +0000
Date:   Fri, 20 Oct 2023 10:55:01 -0300
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
Message-ID: <20231020135501.GG3952@nvidia.com>
References: <ZSnkiKoCspmG1+/j@Asurada-Nvidia>
 <BN9PR11MB52763227866603ED7795AA068CD7A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231016115736.GP3952@nvidia.com>
 <BN9PR11MB5276FDC375685CE04A7AD93B8CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231017155301.GH3952@nvidia.com>
 <ZS7nb+mKanGFXhZY@Asurada-Nvidia>
 <20231018165113.GB3952@nvidia.com>
 <BN9PR11MB5276B9994AD06E91E07B7EF08CD4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231019235350.GY3952@nvidia.com>
 <BN9PR11MB5276A64DA68586AEFB6561148CDBA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR11MB5276A64DA68586AEFB6561148CDBA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BN9P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5071:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d0c505-381e-4b87-21ae-08dbd1742869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q3ZKUoNvIuYJ/Aup2Nb1eR+qNM6MdwdrYFSWT79IX0aiYuEKuIn+yjOc/T6t/xwsJtap4JVRazM7YR5FhndxHfQvSbu9yJsTRiCB/zfwW6BMkit2JTX9qVOYTycfHozrRcfynm4j/+8Poic2HESNgVwTQQuvZe6KdWMERRvNei1WqCY4bKtH53itO1ttXveD2AuYAohJFt+5RtUCCLGXiJnXUThDjmA4RLB1En1/ksc6/op6u6eZY+zRHZGv3ghlD9AUfIfW4Jpt/aLu9d2jh8me2yVDTs1osQ6VQaN3ES64YBr/Xy57uUm9f5vaV3iiUqeUkWrREXd2L7whdqagYx0dtO/IValRa+WdViaEUBd3JeFR8qEZt63jEtbw7ULOS07gGa5yQyX2oU4QQOd9UzJw7YSqxdHQY+whILHHsR/2TO5gB6ddvaIcjN+t24BBCyt5/RgFSy8QpAnd3QUPI4rZ4bBCybmnSUh6bomClzf2XPYT1J3cr1RBJrEgIX7iJrAyIFudu8MTjQ4147Sa5sQIa/40nz49lKYMWKrlhwzDV1nFGgU4kBTSdYV4Cnq2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(396003)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(66946007)(66476007)(66556008)(54906003)(316002)(478600001)(6916009)(41300700001)(6486002)(5660300002)(8936002)(8676002)(4326008)(33656002)(86362001)(83380400001)(7416002)(36756003)(2906002)(6506007)(6512007)(38100700002)(2616005)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVh1L2J0alBQbnRkZUxSSkRMTXgrMGI4VEpsYVhSNHhTMnJNd2VqN3Vta05F?=
 =?utf-8?B?dExYUDRPVjE1S29zSVZVd3FkMkxrQ0dNQlZ3S0RieWZGeVFRa0JYaXIySzZ1?=
 =?utf-8?B?YmxKeW8wZTNyQzRNbEhzcVgyWmI0b0Ezdjc5QlNnMTMxZlBWN24zQ09ESldU?=
 =?utf-8?B?OXVlYlVRSWpJUUt1VG9VeDR1Y3gwZlNCT2IrZ0hqS3FpcUJlV2JTOWlMQlB5?=
 =?utf-8?B?TnR5c1F2SVZET0F4MFFqTittVXAxNFd2TWJHb0FHUDBsT1pJa3QrZ3RGVFhQ?=
 =?utf-8?B?UzBOVXprMWtRbkFFdy9QOFdhNnpLZjNLVk8yYmNyZ05kaWVYR2dISjMwR1dh?=
 =?utf-8?B?SDYrTk4rR0VpQjN4dzhvZ2NYOUxVbGdVYWozTmZpOUd1TFJnT2wwbXU1QnhF?=
 =?utf-8?B?eFR1QlJqek1qU1VrSWVrREovY041TDJXNEdDS0lwU0VJY3p4VG9FMDdrUWRu?=
 =?utf-8?B?QU52dVBPY01uVEtoclQzMXl1RkdnLzBvV0wyWk44bC94SEo3aGRzdm9VdWJI?=
 =?utf-8?B?UUlzSkgxQ0NFdk5tTGgxem1sNS9pSGVGQWcrbWRFMThVb1dSLzJjQUMyNFNY?=
 =?utf-8?B?emcwZHhqTUMrSkdiVzJUT3pxM3ZyNW93MzVQbERKaXVzTGEvM21wUmR2bUt2?=
 =?utf-8?B?b21DdFhwSXdFMVpPR2QyTnlpUTY0OWJlN0pxSnd4K3ZJNk9LeGl0ZjVCTlZk?=
 =?utf-8?B?aGpOVVV1aDdHckxDL3J1dVdPZjJKVDlUc1ZuWnNuRjhmdkgzZ2NDZFpzS0Ez?=
 =?utf-8?B?cVpzUDA0RDk2QWpod0Zzb09sNVoxVHN6Mi9iWk44cEt5TTlKajBGcFpYeFF2?=
 =?utf-8?B?MjMvSUVTQ1RLUTBkd2xndWdEckJ6VS9DcFQ3NWlJRUtYTC82cEwwbjR6RUNp?=
 =?utf-8?B?Y2tsei9hT2dubStMb0p5N2wvYWc2R3BoZTVFUkhpbWNmQ1FSZ2hGS0FEOGNs?=
 =?utf-8?B?MEk1Zk1jekFybGhPZzJ6N1YzVDc1WFZ2L2ZzdStTSlVndFdZOTFzZVU5RmFZ?=
 =?utf-8?B?UTlhazRqTFV4QlljeVM1U3hoMTNoWlNRWDErN1pFejZLUC9iQnlzN0ZJNzkr?=
 =?utf-8?B?T2oxWFFsa3BvZ0JSekRzQVFBU2RxSUZ6Vko4NElSZXo2OXJaRE5JczVpeGR1?=
 =?utf-8?B?NTVFdk9pU21VTmc0M2NTTkRydkNPQVdtUFN0bElDL1NJTUlNK01kQkdOTkdT?=
 =?utf-8?B?Rm95b0t3NmE1SWRIemRqemo1a0tXdkZPT0haaHU3L3RuNUZSWG0vbm1aRHZU?=
 =?utf-8?B?Ry9hbk16RFFSSGVyVC9COVZxZDl5T0ZwcXM5N3N4OHdSeXY1eXlqTk9rUHdk?=
 =?utf-8?B?SnM1VGpSVnhRSHhBbGpLTVIxTEF3OEpLVTg2c01YdTdCV0NFYm5hMTFvVWxk?=
 =?utf-8?B?VEFXWkMwWE1UT2NKS1pKYjNxOTB3T2FiRVNYRWRTcW9IS3Zsa3RqSnVGK1lD?=
 =?utf-8?B?Wi92OFI1ZnZRWFM4Z2VWK3BWcDBlMjB5dG1tTWxxWCtsLzRCQXV3Mmo4UGV4?=
 =?utf-8?B?QTZNd3NlT3hRaktyTm1rM085ODZRUjN4dHl6NzBkaW9NMFZuOGQrd1JvcGZU?=
 =?utf-8?B?bGlpNmhxa2JmamtoVHZpcE9oL3kyc3RYcnJsc21WU1c1Z2JqQUJiSFV6U3dR?=
 =?utf-8?B?WlVJcWRhY2hSbk9oWVloNTlxdFVsN25TQ2wvKzRqeHJDREZFOURNMDZPUGhG?=
 =?utf-8?B?eFdtUkxtblhWLzZkSEh2Rk9PVURXNFhUbko1enl6a002MmQyeThnc0M0L1pR?=
 =?utf-8?B?TE5HdnpCM2N1bGFIL21wN0tHUXJiSjZvVE82dXQzeDgyeEFsakM0b2FoSXRQ?=
 =?utf-8?B?WkFxRnF6by9aeS9DR1BEWUxYQmtPQUZuaHBJSDZKdk5ROHB6R2RlR2VYMTdu?=
 =?utf-8?B?ckxOMUs0cWJGM25kVXRFWHJZVFIvdFJ5Si9LK1hHY1pNd01WMkoyRHJ1RmJ0?=
 =?utf-8?B?bEhjZVFzM2JLeGIxbFllOHVnamVudlYzZ3FsS3hDS1JFNlVpVWNGcVpSaEs2?=
 =?utf-8?B?dTd6eFZ3MXkrcS8yN05aUTFwa1FOVWtucVRmZDhUZHNVVk5sKzZBUjRTVVFh?=
 =?utf-8?B?blphTVlNaGJNUHQzQTQ5azZsWEhBdWtERUN2RjNRQlJialdFSEFFT1JHVm9R?=
 =?utf-8?Q?lsQyRjNUh8op1UeKVedOg8vnT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d0c505-381e-4b87-21ae-08dbd1742869
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 13:55:02.8593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dyrhWTiOI2K22Z7x9wX56U1ItKhwy0Q9x+XwnJ+oJje5DDGueh+D4hJ7qPmhG03q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5071
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 20, 2023 at 02:43:58AM +0000, Tian, Kevin wrote:

> What we want to prevent is attaching a non-CC device to a CC domain
> or upgrade a non-CC domain to CC since in both case the non-CC
> device will be broken due to incompatible page table format.

[..]

> Who cares about such consistency? sure the result is different due to order:
> 
> 1) creating hwpt for dev1 (non-CC) then later attaching hwpt to
>     dev2 (CC) will succeed;
> 
> 2) creating hwpt for dev2 (CC) then later attaching hwpt to
>     dev1 (non-CC) will fail then the user should create a new hwpt
>     for dev1;

AH... So really what the Intel driver wants is not upgrade to CC but
*downgrade* from CC.

non-CC is the type that is universally applicable, so if we come
across a non-CC capable device the proper/optimal thing is to degrade
the HWPT and re-use it, not allocate a new HWPT.

So the whole thing is upside down.

As changing the IOPTEs in flight seems hard, and I don't want to see
the Intel driver get slowed down to accomodate this, I think you are
right to say this should be a creation time property only.

I still think userspace should be able to select it so it can minimize
the number of HWPTs required.

> But the user shouldn't assume such explicit consistency since it's not
> defined in our uAPI. All we defined is that the attaching may
> fail due to incompatibility for whatever reason then the user can
> always try creating a new hwpt for the to-be-attached device. From
> this regard I don't see providing consistency of result is
> necessary. 😊

Anyhow, OK, lets add a comment summarizing your points and remove the
cc upgrade at attach time (sorry Nicolin/Yi!)

It is easy to add a HWPT flag for this later if someone wants to
optimize it.

Jason
