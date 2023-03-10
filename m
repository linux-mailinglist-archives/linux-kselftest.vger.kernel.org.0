Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33F96B43CB
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 15:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjCJOSK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 09:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjCJORt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 09:17:49 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF5B11F6B0;
        Fri, 10 Mar 2023 06:16:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQVnSpCOybX3ZxWxWNLaj7q8Qx7ypQkz7H8w3WxXiAE0jtHE2xuagOz6nOrPidWKdljWjgGnILCnvfGGt3MjScZ/u/GHIsNv4JUISh4qXkFLSwVRMtRX3ei9LMdr3Zce/2rgI4UYpbZk/q9zg437OHXt9FJW04x97cFZ9mQftiH4zhRYtop7neTqZoR3/uUwraLhe4RS7XQ9nKHxtSf12tspat2sV/wii0SDIx2NxMBxnwU0C8o8ijcUQ71P7j2iGfmqMNZgd/0qECDlPFFqqmcwOH8dyf+l9jcYiTlHt2U6A4Gpsu8AGVmAhTyXsbLC8M03uVBRahPA457zS8p8Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cag6QD4KSbEw1InjH+hwdJPhwUylH3hWp0iiwT7nYC8=;
 b=CM+jHsI2bJE+g8DkCBEUqpKW+6DLvFMpBCIDjSzDIwUMiNLa1LT/vpa/1op48j8eXBuOxj9ai7fQ2lfjYBZVp6Hth19JA1EoTC4R366iGDzANrZjGJ7aDXJ6hbvMWnEy9RcVGcNH9mTplOoFvJVrvLJcvhxyh++VEcZq8TXX/q55rC8xXI2mR0J9GpILVi0YBjOjr9LTANMeKmz3jnlTDbzWGgtFmbZutpYeMTxdgsi4bG7hKvqDPzEuLrMrVxhSVEI4zlqbuFZ82rB9aeK1DPlQAUSpMvvbVYeH2bEq1FpoHm9z75lExrD4SLp5rQlJr+DpF+LOxsPY53qBVRdj1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cag6QD4KSbEw1InjH+hwdJPhwUylH3hWp0iiwT7nYC8=;
 b=LrtbC7N7le9DUrk878fFyh8mJd6wSOz8WKimo9J+Mj6JgjB7RvdXZLUyxoaJHJWWCr7ujzCtrRPYgrzoFcEiShgJG5b2l/xPnv22KZqwkgcEmDrQ+SAmulo/+rJLEediY5CJUNJlOEiOpnlB7O/l7wdzXKKvcH9wBKW2gdXUU2ghAnMRgIUBnCpPGuey10bLhptor5zYG+lLmEK1COZoLVRV5Fuoty4pjn2ZP8LI3Vwm4Vb2GPuaeBef2CJyODEZ7WRTPswIAIUJlcLCGNW/mSuCCX8tOtxwqvvw33amgGz3FacvYShXCMlfRJca/Cg1OOj7GmJsC1QylezJAmG8Yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Fri, 10 Mar
 2023 14:16:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 14:16:33 +0000
Date:   Fri, 10 Mar 2023 10:16:30 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 03/17] iommufd: Replace the hwpt->devices list with
 iommufd_group
Message-ID: <ZAs7vtC6WFdQnbPo@nvidia.com>
References: <0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
 <3-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB527621AEB6AB1E3E9252547A8CBA9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527621AEB6AB1E3E9252547A8CBA9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BY3PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:254::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: a7d7ca81-d92f-4960-7055-08db21720ccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w3drKIq0Dv44B1kIkJw8/iie/yyU1jErMSkUTWhd+cCopaqjMqPlLtOmhvASgGHxW9woKY4biGj2LVghTyVWoTsfgVDdBauUVi+A3hpmyuY8Ht2eR1JsZ3es92pLEROyWxvKENdewEFZBEoNv8y37xcQZLCfKe6F+674CLI1SfDjxKlKZg1U11lKIJ1b1fZYtVtGWIXBQHgYEAOYXkwjTfy0DuMK9bBPVMKgjs4LkympvvIp2JosqqfJm6wDsOaSeEMhQ3I4venW+sqLPnXA6MnA18v4tTOCgPrjATyZtXofWsK8QNmEX7UdCqSXxgL9cRYif7UFmowNSQBKluY9Psq22cmNFHx2hUSCibWIDyhX/3zuGy1kyqWTvl2DyNApvyb1AqoucsMNKFU0/VbxivNeTfoeBruaxfR+GN0z9Bok+9AdnozhxNL5VGNrT3ykUXXc7nwrrRb898BcQQ5mFxswwDH2iX8H+l7D02nTj0VsQrLyPeprebHr6owA6VvmgVsMY/70sah9lHr7p+Bbqra4sYW7UsJPvnaIXx4MbyUAcBdDhKLHFi6JOr1IEUrzeVo21dDaB+CdH06XHc5Fwqiih+hR68i564ikQwojVccPTM2R5IRREGPlMr5ks48utJM4JkKN7i/ISWZlRdDwsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199018)(36756003)(38100700002)(6486002)(26005)(4744005)(8936002)(66556008)(6506007)(186003)(41300700001)(83380400001)(66946007)(2906002)(6916009)(4326008)(66476007)(2616005)(8676002)(5660300002)(54906003)(316002)(478600001)(6512007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hMbx86so/z4S7CSmOFhknG3tOhyXbKjlaAJxEg9z1HQ3uwv9ggadj/FDH66q?=
 =?us-ascii?Q?Goc/hRsKR9OB0Y7EzHmmIwYRKw0/Nmqbmk/gNqC6Z8P0ojG87cpzfRzN4OF9?=
 =?us-ascii?Q?p/CwjknRK+agqcMEVbyAl4ylIpA/RCFk5/b8JL7rZOh1CXQ4e+8d4pR2E9c5?=
 =?us-ascii?Q?Mm2wVRccqip17O4i8uugx1qEtl+bTDF5sw3USgjhaWSX8KEQqHlftLQvPeSy?=
 =?us-ascii?Q?IdY+4uqzaMac2UFhNcneq5jSKUUTS1FtNS1OuooHcjFvVRJ7m+BbFoFeBmTc?=
 =?us-ascii?Q?cXE0Lg+jkEuI80yLanO5cgiTwpeiWvod63ZEkJMjbmQd2QD+WHr21H+ZDKEM?=
 =?us-ascii?Q?6l7GVivGKP9A18DLLcLIlH7UbQsq/Uae2jPug+5jOyTKJfKW54bxrz7qutSF?=
 =?us-ascii?Q?0ILvNUOnRfZm2EPH0NZeNyZG0oVkwY6jrRM5nYvnctfsMq3tJPbIYqzcrowt?=
 =?us-ascii?Q?chaEnmpbOtqMfkZk8bJujZY2hczDu8QwgWgDUIcmNlqyLjmM84AddusX1SXu?=
 =?us-ascii?Q?44vvnJ5sc2kzavPOYQJZkxtexdwQWOP9DaC3Hc/IRGAVzztuLWZCp43etg98?=
 =?us-ascii?Q?gF7ncig/ZKx0dRwASQP+M2HLsbCkdcsOP+bD+l13vt9Ok9fYy+UaVRE5UbCo?=
 =?us-ascii?Q?F9gIDZNpg9yqJKZjUvIJcpLR7DpAjO20Rfpxh7FG9gd57e5yw7MYcTzO683a?=
 =?us-ascii?Q?+cWsGVUpCwLxF/9M5uEy/GkZDEj5zCFhd8hTOJ24YdD5aeiu8/zED3B4tP7U?=
 =?us-ascii?Q?rjx1RJy07IB1lFik4HeHiORXISYASENL5+GJZ433B4iin7Jjq7bCbP8ENFZi?=
 =?us-ascii?Q?bdvKlLwdnb0EFeBe1zr2HEpXbHHIO9qJmAYgqAAUxAykhc/dWdKzsO1k3Orj?=
 =?us-ascii?Q?ZjYI1hxasW2BQvRcghCHkuR1zV/Rih27arBeitqj06YijO3HiVzBH4bs8UhD?=
 =?us-ascii?Q?EMKmZ+fS9dJQMIOm4IbPvqliFo8LGMigX6F60E5WwsPdLZiDYLokEneq5dXE?=
 =?us-ascii?Q?U/rhGFtNHkuwXnOrmg/zEYOxBqJf7ICn0Q3FzQTdHREz4X7hKyatxPkDyfkN?=
 =?us-ascii?Q?MtTMtxEhXNzGMQRgjhukhi9Ea0hpJogAf1X8ARKlpOIYVUqld524gdPyQ2xB?=
 =?us-ascii?Q?vDwJQ2hXMS5Ti2RI6v0bkFei/xnDVRQZDr9Xc5tgJ7TmY3WHdfKZ7IWPJ4r8?=
 =?us-ascii?Q?hTd4PqqcWvMijAbFP/BSxaE/Zf9Wu/NjDyedJx8rHpT5FogfwghNKy/E/keQ?=
 =?us-ascii?Q?iZyph5m7Dddq08CrdKIF9TQCIEeyeDneVUlTrWl0M+7w3GHnE8gevuX9Sdnz?=
 =?us-ascii?Q?4OSMXoZqjvrXCvc2RDokSq8Td3oaFMyGXEy4wBUxp/LXRqiJkWBWydtVONFn?=
 =?us-ascii?Q?hJmrcSrmDjrQwhHzUNkG3Z2ZsAocrqJnfepl/CTw0T065VbcmGc/AR8Q9Wt7?=
 =?us-ascii?Q?DO5WIJffYjFr486D2Ttm7295F6Xj81RhlaTY7P5t9xEivkF02ZiYAV3NxFiH?=
 =?us-ascii?Q?nfVp8VDNIjN/eitAJ90+R+AInZHgLpXryYUaNng7+ycFNfh99+MZlmd/N99l?=
 =?us-ascii?Q?k1XCt1YLxYzZ+6vvdJtyuhmOfd6o7lATMcZlJmJz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d7ca81-d92f-4960-7055-08db21720ccd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 14:16:33.0817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b7g7z7/62Zy11sZ25de9HA0Ie+aOLrZaRj1TUUdgls6PdRyykw4xsTs0nPd+1tp1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8348
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 10, 2023 at 10:36:44AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, March 8, 2023 8:36 AM
> > 
> >  	/*
> > -	 * FIXME: Hack around missing a device-centric iommu api, only
> > attach to
> > -	 * the group once for the first device that is in the group.
> > +	 * Only attach to the group once for the first device that is in the
> > +	 * group. All the other devices will follow this attachment.
> > +	 * The user can attach every device individually as well.
> >  	 */
> 
> the last sentence is confusing. 'as well' sounds like there is another
> option but we don't have a group version of hwpt attach.

	/*
	 * Only attach to the group once for the first device that is in the
	 * group. All the other devices will follow this attachment. The user
	 * should attach every device individually to as the per-device reserved
	 * regions are only updated during individual device attachment.
	 */

Thanks,
Jason
