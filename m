Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4057CE329
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 18:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjJRQvW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Oct 2023 12:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjJRQvV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Oct 2023 12:51:21 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C41F7;
        Wed, 18 Oct 2023 09:51:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7jklWuTV7V81c6Wor1RdAibgmyALzQ+xorGMPV4gMtK00srXKt+Oh3NHmpa0oBxm6jhmuycZz9ak5y+AdNVhdMVUiWyMll/n/SMinQYZVwwsthQEnrFiNwoCVhQgGpVK1/QmIAtbyK3lRiYrj875DYMtkPH5QSNhtRK83IXTZfJ7okgrloj+7Ib5RJc54AcJNw4Pe9m8BMysW0SsHi2DMbBEtsolc/KGQIM3JO3RbDYN+aAWoExneDRUX3foudUb6GH6pK1O1KjxPxReHZxL2GFrYrECte7eTsyDSVaTIyh3Ndn6gHNxqjM54u05p+MPTUIfKa2W2OTgNEa/vDsDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUrkHVJU7TtouBGmVQF6X8Dz4mwgn5vClcw9SYaWAVI=;
 b=j6F1Ehj3f3q2RsnDM5JdqfWt2NCMygNa++j0rFuwGcUUXFouvYVAN8R5MfIvX7PsEFqblSH8hwAMY3MPkw35nxtkytbhk5gW8aznvjd466VHzqGZFrvzvBIcTWA5SV4AepHJB3uHWyLEntghZZYoUzV/2cMqCuyxRRPB93hhYrW3iPbYGckxfoMDKzwpfqKysVVACIm3ApVaAmhUtMaM7l4JZ+Bye/hgSX5rDzK4d7O5Q0vevG+O9q6lNWQgFUNRrKoUz9DBD1srWlygkKHLvOEDTRx4LC36myQJGUobGRgMICKYhLMgPoxtwWQm8ABkZ/s5ulxiotxTSwPwW0k3kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUrkHVJU7TtouBGmVQF6X8Dz4mwgn5vClcw9SYaWAVI=;
 b=WMd0Nc7bGqsook/DiLzr28IqBO6PqTm6s6y/shu5FdZaFFlbvSr5Jxdde/NAx9xJb6egLL2h/TlISalen3pWCfEZq5gZbCz4aZuu2YvgGdA4cknzlrXQy65hk6PO8ZoehKPW8eAAO9dGLD7u1dPUIbqyK2TeIHLWpc8XaEgD9+r1gQzkhfQqK3zf7DjOfYuhp3bLF4V5/5ANC8L7wEFa9ZtiowM/tjRWdtSTFxVUf0/1PoQwuVNv4wDHPiP7FwGA6L2ki5FKWIauj4I5d91KOZW2b9E+nJz0TkLwW7XHUA+mAtK8DgH5QpwBCYAfZ3c3veYlaAqge6fu8ZIeEeZM9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8279.namprd12.prod.outlook.com (2603:10b6:208:40c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Wed, 18 Oct
 2023 16:51:15 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 16:51:15 +0000
Date:   Wed, 18 Oct 2023 13:51:13 -0300
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
Message-ID: <20231018165113.GB3952@nvidia.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-9-yi.l.liu@intel.com>
 <BN9PR11MB527658EAF017FF3576667EEA8CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZSnkiKoCspmG1+/j@Asurada-Nvidia>
 <BN9PR11MB52763227866603ED7795AA068CD7A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231016115736.GP3952@nvidia.com>
 <BN9PR11MB5276FDC375685CE04A7AD93B8CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231017155301.GH3952@nvidia.com>
 <ZS7nb+mKanGFXhZY@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS7nb+mKanGFXhZY@Asurada-Nvidia>
X-ClientProxiedBy: BN0PR03CA0043.namprd03.prod.outlook.com
 (2603:10b6:408:e7::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: 40cf527a-0044-4c01-e97c-08dbcffa711a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ehDaTo3aVfa3BhH9AvYUMqfG/xf1+nU7AgHsgJT3P7qHLpASwEL0RmySMSlBWEG04UFMsWwd8AiqP6oiI2UL9WRAQ/6bP6lc6hX3gQCN+d/XnjN491PoIq2l3Ion/UKTbDU0iXyB+lqv+qkAnVMU2IqrJoHOgJvhx3seYmov5LhE9r4E4byjyLQ0ZF3VgXcjDT0uU5VS0rTGyLlIH3XZmlfujBJawZgtKPHL2QpF3KdSlH1G21SfsntBe5+RY9BO6DQNloczlv898+/bS/vr9jDFHjRVkM5r4oanDHXXLEDS27GmVN1T4T4dB0YphXZm5Hac1fQl+MEtU5Yi6AWJLG10SkJr3NBtiUKxyR31klzE6YCI08rWtdild6OBafdblSG1Gzo26SRmsJWaamx/fPl4YgqKeHf9eUqgPdIEsTzDemXdzQmJLmwvnbbg7y3VhZz/zK/PQgGqWyI9xDCUg3BNgGlJamgqOPIy7FaB3ryK2y6Rys6Uw3XIzusLTvCziB1t9KwfLkz7IyP9cOmiljkJXsZHC2XRkJbptnkMhaFSHwfiGS352bb2yU7miNxnCcl5hlQgk3v1+PpjCZtz485FjL5L6XgcvZQw5grGUQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(366004)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(33656002)(36756003)(54906003)(66556008)(38100700002)(6512007)(66946007)(6636002)(86362001)(37006003)(83380400001)(316002)(8936002)(2616005)(1076003)(6506007)(7416002)(26005)(8676002)(966005)(6486002)(66476007)(41300700001)(2906002)(4326008)(478600001)(6862004)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8fMJ5DchMuVvcN+LjIHX4r+ZUnEzgzxvBDgEOAWT0839Wf1hGFDwCzyBoJed?=
 =?us-ascii?Q?bOAJg7phlK2hvay/b/lk3cAbmHxEinRFpJEK7+s7GDJYyp9ebfwwDApLaRxK?=
 =?us-ascii?Q?FHkGjlhh4oip8Wwbad6rv0HZQSPXvIxaPFaVUrCdVJ2UONYLNnf2FsPHJb/Z?=
 =?us-ascii?Q?TUSLEcsAE2qrZg7Bj9w/Mm3HUzvwqV61R+U0HoAx/O404ZtjJ7+2DJnGtzUM?=
 =?us-ascii?Q?UzmNX9iVUeWj7ZJaBqXlwp7Mi37tEKIcUUSNp0sdl8gv9cmP9Bxi6zz2jtuI?=
 =?us-ascii?Q?6glPFPRY6CoakVcBC278sg5+Woz8lCZWnxK+zASOJMb29+Uhr4jNWE9X6Y2Z?=
 =?us-ascii?Q?jEsox793tM6tubDKjlWj9C6cic8d8dUbX/yZ5/0NeJArKJLoBEF599CZtnj7?=
 =?us-ascii?Q?E2x8Yk4Y3Qt591uq7wFIjUbDu7JAubSBWYBNCTxkP2+V3LkVOj7aqNju41fQ?=
 =?us-ascii?Q?lKKfDD8vaW7zgSNI/D5VhvIu8IFPD4FsNoqSKg+HouO5B1TpYifq2ainLS0+?=
 =?us-ascii?Q?zQsrSrMC7egV1TQasiVi2H5aRaR9MmhayHPr5Uohdt1pGKV3UI0h1Q2dm6ts?=
 =?us-ascii?Q?n9htYiJiC8IMjbIdOdywyVDrUbWLq3yUIFJ5dQiMqcZYE5XHDZtgbDQjUD4b?=
 =?us-ascii?Q?6r32d69RkdZACKm/nyv1kP77lx5GwmNKpRww/EM82X63CdEJ11Nk4IsfbET1?=
 =?us-ascii?Q?29uhBqykU20XzBj8FJSx1U9bam8Gt/FCnO368tczankJkR/JxnQvIamRm80H?=
 =?us-ascii?Q?BYzdO3zbrHrh9kHKs15atNvDXQPCPOVLLBwXbhNn9vHscrfTj4KBdx94701w?=
 =?us-ascii?Q?S90OEJT2hXKRCPrir8TqRXsMDqRPw3otw1SybHoEJFy/kheRt5sl8WmQycME?=
 =?us-ascii?Q?jhGul0MHubYNN2hdxItxfhw9iOeJzy6SDmFDn0d78D6JT0LKIL7vIR0yDj6u?=
 =?us-ascii?Q?ko+6Sa1FZioiON2Z1O2zl+75HG8/Af3P7e9fmYUHqvLLIhs34XueDf8TnWkj?=
 =?us-ascii?Q?IBqrZAutCdrQwA0MejMAqmHkzbwFdfIdCKfmLYFGv24b7khlswcujE51um6g?=
 =?us-ascii?Q?Myt3z7MGJADPgRCaBxUkNlOdADThSIQN/imko1u3Zr0ryNAM8u2fu9yeDY8h?=
 =?us-ascii?Q?m5hojDuQamtxIpo/IJMdKz9EgMC3rD6ph79q+Oi/3Hj/4SIPkIRGQ3Jn7x9A?=
 =?us-ascii?Q?+vhByfYlg97uZUySYG9kCfLksxbBOMBpWff8qmhcvsfsZZrNF/QQ/7sGVW//?=
 =?us-ascii?Q?TCfc78x2vZg0cqS1MuinRXiBRmUz91acVWIDnpCk6vl65vHpuNfnBsoOry1V?=
 =?us-ascii?Q?xyDwyNJW06wGzBg2mZNDkORSoI2yuMBokgtMdbLmTWGZvqdPxI9HmtBcoVZn?=
 =?us-ascii?Q?IBqC6oTCaKyfXSjpuo+tEeLZnnfs68jEM/Ge2E/IdWXQf9FnczT7Ye2GwvgH?=
 =?us-ascii?Q?z6hdokoRWIaEmuuzuAe3s4vHegVAQLsFI7mcy01spSYzjv2EG/u4c87wOJeV?=
 =?us-ascii?Q?bcwOV5uKJxqd0/F0mWc0aEBgqOUclbb9+25fx/ZL9wi2d/QeVwxdTclJpVKr?=
 =?us-ascii?Q?wn6zjxBCYcbwkMAKZeJSNAGnuBIUYx6yo8lxMsfC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40cf527a-0044-4c01-e97c-08dbcffa711a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 16:51:15.1194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rcrhy9+tW3+V3qjwpL4ZJRnELPwFCWNOOLHBY1Ks0pESpdscMiWL2bVbYM8cWLBe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8279
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 17, 2023 at 12:58:39PM -0700, Nicolin Chen wrote:
> On Tue, Oct 17, 2023 at 12:53:01PM -0300, Jason Gunthorpe wrote:
> > On Tue, Oct 17, 2023 at 08:52:49AM +0000, Tian, Kevin wrote:
> > > I prefer to removing enforce_cc in attach fn completely then no parent
> > > trick in this patch. Just keep it in hwpt_alloc and leave to iommu driver to
> > > figure out the attaching compatibility:
> > 
> > You are basically saying to set the cc mode during creation because we
> > know the idev at that moment and can tell if it should be on/off?
> > 
> > It seems reasonable, but I can't remember why it is in the attach path
> > at the moment.
> 
> This was the commit adding it in the alloc path:
> https://lore.kernel.org/linux-iommu/8e897628-61fa-b3fb-b609-44eeda11b45e@arm.com/
> 
> The older code was doing a hwpt "upgrade" from !cc to cc:
> -       /*
> -        * Try to upgrade the domain we have, it is an iommu driver bug to
> -        * report IOMMU_CAP_ENFORCE_CACHE_COHERENCY but fail
> -        * enforce_cache_coherency when there are no devices attached to the
> -        * domain.
> -        */
> -       if (idev->enforce_cache_coherency && !hwpt->enforce_cache_coherency) {
> -               if (hwpt->domain->ops->enforce_cache_coherency)
> -                       hwpt->enforce_cache_coherency =
> -                               hwpt->domain->ops->enforce_cache_coherency(
> -                                       hwpt->domain);
> 
> If we remove the enforce_cc call in the attach path and let the
> driver decide whether to enforce or reject in attach_dev calls,
> there seems to be no point in tracking an enforce_cache_coherency
> flag in the IOMMUFD pathway but only for the VFIO_DMA_CC_IOMMU
> extension check in the vfio-compat pathway?

I think the purpose of this code is to try to minimize the number of
domains.

Otherwise we have a problem where the order devices are attached to
the domain decides how many domains you get. ie the first device
attached does not want CC (but is compatible with it) so we create a
non-CC domain

Then later we attach a device that does want CC and now we are forced
to create a second iommu domain when upgrading the first domain would
have been fine.

Hotplug is another scenario (though Intel driver does not support it,
and it looks broken)

Really, I hate this CC mechanism. It is only for Intel, can we just
punt it to userspace and have an intel 'want cc flag' for the entire
nesting path and forget about it?

Jason
