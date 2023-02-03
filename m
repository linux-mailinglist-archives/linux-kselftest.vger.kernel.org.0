Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39950689C84
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 16:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbjBCPD1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 10:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjBCPD0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 10:03:26 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13192945F4;
        Fri,  3 Feb 2023 07:03:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNzs6v5Sj08afJQrUm2kWnF+L8ENgQ1yFYiYMgP4CcHjeE3W18pnBIiM8S/H8sd3utoPDBrOa1qHX5M8AtVkI8WWQyeR/mK8DHTfVGfRCdqKea9AHUPCOALuLf2figr2GSKfSndMpyGMRuBOdyTMYMjorQ1RSyOIPfnD0WdAsOJY7Ch7gyaSuki+Fr3rChuGuYsOJ5chIQvBKq4vaRBfaah0PtDpgm82QH4lpoEikiODDaORnfuFPsmVbhbmj+/dKF1GAlMs0El04SIAE/fygUTbpbIhkfhWYz8b7hrRBiL6cABhlj2Z2YY12aSQFAJeO3CpoRLMKtc4B9uKPJOkAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIrmDLi9EeEGpm3pug8pD0daCpE8aIfVWJv7sZ7W8Us=;
 b=bGkI6/bZLfzI5CboX8WR2TxSmLuvujbsS29ZTVfnprGoasqUcGeL5dFjoi8SblH+xi/STVrHAvHdoMda5RxTiI66wN99kCmud2s6mfbCvUIXRzab7OSgq8H4PLEMR5m+qCQZY0X5KyvWAVnR0iwnkSI57S7oA3Gc8Qb+elqaw+DJtu4y/dQAGsoiQ5WpVPrmL0A1cciCvIOhah8WrX9H5WH5a9Wx6MpQFAXWOAZCQfwoxU0Pd06sQathQSmzSW2FdWut9YLpUJPFZ2ItGUiq0YFBByMvEv/ytzzZFFcOXENGQpRqn3kjfz72SaZPqc4lUlJ3+YZnegnkE5U2eF47Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIrmDLi9EeEGpm3pug8pD0daCpE8aIfVWJv7sZ7W8Us=;
 b=sVZJbNPVmdz3dPloJNJT/AbEcijlnTaSHyDOG/fGVmvIOsFXZHFO/IBhTWCFhNUTzomD1zB7RC6eAm0XRIusSaZdF+SCEPO9GvfAaqGV3vj9PJaLIF54O5q3mgCc84n4TwV4mHKg7Ck0Js7b77p4D/0uA0bt/BecILMGlR/vYcxTNB4oiHXZXUFvNwGpGjYE3pT/aClyI1sOFGL+NwdUQgX4K14wd5zfn9CjnOmVH9ilLrSYZx2z6k5PQh+lls2+n+rV8Qj3YXZCWChIrEv+XvqfoN/04TnWl0PeC/wZu56Beb0Lk+rkVyQSRyoN+36lfRZMciIDI5QvJMcN/Pn1mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Fri, 3 Feb
 2023 15:03:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6064.031; Fri, 3 Feb 2023
 15:03:22 +0000
Date:   Fri, 3 Feb 2023 11:03:20 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v1 2/8] iommu: Introduce a new
 iommu_group_replace_domain() API
Message-ID: <Y90iOAmnBtqQtmiA@ziepe.ca>
References: <cover.1675320212.git.nicolinc@nvidia.com>
 <a98e622f41d76b64f5a7d0c758d8bda5e8043013.1675320212.git.nicolinc@nvidia.com>
 <BN9PR11MB5276BB497D32073A1F4CBE238CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276BB497D32073A1F4CBE238CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR19CA0001.namprd19.prod.outlook.com
 (2603:10b6:208:178::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: e8da482b-9c66-4a72-1526-08db05f7caea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a/bOSvKWt3v0Th5a3NeqeSXCAnhF2tSHw7Uq2LjnsZWf/F8UyN09vU4InEdJLAOKzKIiFZuP5C0BWFgYcZtzHVHepbS7E/cENJhl2Dlkb8F5IDxV2VVzMg/EqeORWqWvO4wp26fzIWuy1KGgNqyRKpt2fJtpsrEdaIiyhdFN6VSUmWMn1wuI0d9axbccXve9e7zz4kBKQR70Me+liF8W3TO52R2Md8A2dI3M9r0xZbfSJJdqwq69D9ZmBrQmIbEK9JhP2YBKMVPU9kVpTaGjxB1kVzGIi7ImMCSrX3nuEc+QYSnFxmkimi96wjvCHoyxLff83PDWcIKziY/EeuSVUY0s/TMELXx6JJJu50GaEfQQGqPIB7iGrkNwTdeR8Q8pWEUH4fzFtpmi8KxR5iNry7NgI8nAUWX5mH4PCJoobQ7ZuslSOlsgWCIVtlE3Ww/UedMZo5mEfVTqVb0kKh+pMOvC+Dwykq3CGo7s3BY2LiAJZTY0by5RvF7dKDoj2gQdVYpIa6Kk0oAJPwdDhgwrrB6nkTSvHiryGpbVjh1cfSqo2aHGRupXgDlVxNDJIw3RtdQzusKdi981pDFqe4kYnunb6OtPTrqKRcMUWIodoo/zjPrKCL1HgnpdSRRzujyqJUXH+uC5jG4tAJgksoLIUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199018)(36756003)(86362001)(6506007)(186003)(26005)(54906003)(9686003)(6512007)(478600001)(6486002)(2906002)(41300700001)(8936002)(5660300002)(7416002)(316002)(66946007)(66476007)(8676002)(6916009)(38100700002)(66556008)(4326008)(83380400001)(66899018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?63w/5JgSuB16dzA0wYocIYc3Vh1jj2drVztLJZVnmD47eVMop6XxPBVX/fa5?=
 =?us-ascii?Q?YXZZC0A6bZa+TfpJt9tns2HVGtsQKwaD73miX1/iiy8NIy4+eF6gYeyFiyP0?=
 =?us-ascii?Q?HPIGnPNXoSceGzpNfu3k27r7CaUAa3cVdpt1y9FsjoTfDfDKvCloZ1tZLjDI?=
 =?us-ascii?Q?R5xeBI7Wm8/d03wKvtUab6OupNnK3D6OpeD6SHTMMAiEsj0teCGnF/nRjljB?=
 =?us-ascii?Q?P3lGP2tkmGD1y46O9wf3H2m6HRZZOCpzISaPhaeC4cajymc4ZqHlXS+KF1u+?=
 =?us-ascii?Q?lr+OyX8W3xTAojqoydacsS4ZeC8LekDTmEm53vMCgm5b5+YbwIFew4YuGZgs?=
 =?us-ascii?Q?rUbIzkvpKvQKQ0rAUnPtCRvUluKIhURwXZzqmq1HNAWUq0fsuxuzo5TneoB5?=
 =?us-ascii?Q?rmiGeJRao/a5qBfa7y73HVzziTPCGBUJLEKkpvsW3asuAyCDog2FmCs22ez/?=
 =?us-ascii?Q?WQGtUaeemq6cb7W6nkLGleug2S27WWOLdomn5iHXEUVdya4rpE5AKO7ca1lp?=
 =?us-ascii?Q?HZJJjruuo8qr47n/G2YB4qhKcRxe+Q7hDysTwk3gspNRW+h/i0FgMrl19pFN?=
 =?us-ascii?Q?BMzvFo4U9bP5oyPg5OftkUw0j0rSo5orpqqTbJ9v+5UCyeXce3yFilmBQAXF?=
 =?us-ascii?Q?mUwXP6/LZOV3mEjhRdcxMyj2sHQHhWSQ2NkcuJDtI1r6HQgu/jNLSxkcL2pM?=
 =?us-ascii?Q?LwpMFcejQ80wHH1uhRyuZKvKplft33AGyAo41jN2kz2Nn4gaCvUBWOJpBnMy?=
 =?us-ascii?Q?jSDMkgXCQl0BlmIUT4c38CPrh+KY/5NF0ieh9YQyfBTyLZVpCHf3X8KDG3xA?=
 =?us-ascii?Q?LW3PvDsRAV9JEwMH3cKbSKJRQrU8Lk48dfw7jXnwjQy+wvOcH64cZnU+7OA6?=
 =?us-ascii?Q?1hLGspj6E2Bp7dCSSVD+nLrQMsPNPpCA5gZpQ/aOpt2JSsNwjRzx4zc0N3vo?=
 =?us-ascii?Q?sxkkxbqy096+pRreoBSbPcI5cxcsmBNf8DAFTEN1TD9JvMl952iLWFhSZSwn?=
 =?us-ascii?Q?bDB44igg7L8rP25qpBP63Drzsh0/RNtSlL49nDhakksRxvn72+W35so07n4W?=
 =?us-ascii?Q?LczVuZ73x5eRdRqoxM6WUWSf9KJJqCOKLlO2KFjaF+6Jrn+DDnEzBwX1iN12?=
 =?us-ascii?Q?bpvvNkxM3CCIFNszfuFLJEp8Uuz8p8uUkkU8BL5bhhQ+UB2wpDJPPCCz01wC?=
 =?us-ascii?Q?A293cQj/xXZDoopReHpW9A86Nrhvr5DB61MaoBMz7idhHchCzDtUuEmZCAec?=
 =?us-ascii?Q?7OP/GjbBCl4jTTA2H/6vBFmjdJAzlBvmtKbwxfCkOKo03XoYcLJb4mg/1drk?=
 =?us-ascii?Q?IrkJlNBOzvuaKGfNsNywKXsWkJ5jqaZanhGamyGp0uTEppjImlB20QXCH4Vo?=
 =?us-ascii?Q?LS6saVYL9uvi4KT/0nOdQTA89G8APRYA+x/MhMt9tOCSmzBm5kryFK2wWSzJ?=
 =?us-ascii?Q?qsLrreoOMMbk1QirfTPy+Db++1DuPxqQfpzSLl9oDVgPSLsVmRtnxZm7C6cu?=
 =?us-ascii?Q?EyvI5vz0MWmHh2PIJpnf+zrC58CBIt8b6WH9S1NjjftvBKfk+fLpa5d28jzB?=
 =?us-ascii?Q?pABE+74CvDR+AJy0hyJ5szU0AZnaiBdtXbgEgY7t?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8da482b-9c66-4a72-1526-08db05f7caea
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 15:03:22.4331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApdcZhSWoFSoOpWCwNgZWhAgDdQzZ4ag8AEz3OVnFlWzhoI9h2GCHxh8E+68MSc7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 03, 2023 at 08:26:44AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Thursday, February 2, 2023 3:05 PM
> > 
> > All drivers are already required to support changing between active
> > UNMANAGED domains when using their attach_dev ops.
> 
> All drivers which don't have *broken* UNMANAGED domain?

No, all drivers.. It has always been used by VFIO.

> > + */
> > +int iommu_group_replace_domain(struct iommu_group *group,
> > +			       struct iommu_domain *new_domain)
> 
> what actual value does 'replace' give us? It's just a wrapper of
> __iommu_group_set_domain() then calling it set_domain is
> probably clearer. You can clarify the 'replace' behavior in the
> comment.

As the APIs are setup:

attach demands that no domain is currently set (eg the domain must be blocking)

replace permits the domain to be currently set

'set' vs 'attach' is really unclear what the intended difference is.

We could also address this by simply removing the protection from
attach, but it is not so clear if that is safe for the few users.

> > +{
> > +	int ret;
> > +
> > +	if (!new_domain)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&group->mutex);
> > +	ret = __iommu_group_set_domain(group, new_domain);
> > +	if (ret) {
> > +		if (__iommu_group_set_domain(group, group->domain))
> > +			__iommu_group_set_core_domain(group);
> > +	}
> 
> Can you elaborate the error handling here? Ideally if
> __iommu_group_set_domain() fails then group->domain shouldn't
> be changed. 

That isn't what it implements though. The internal helper leaves
things in a mess, it is for the caller to fix it, and it depends on
the caller what that means.

In this case the API cannot retain a hidden reference to the new
domain, so it must be purged, one way or another.

Jason
