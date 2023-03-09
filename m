Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B686B2927
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 16:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjCIPv0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 10:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjCIPvT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 10:51:19 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4423BF2F89;
        Thu,  9 Mar 2023 07:51:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTw4S1VX/T0sZ1uNDOTf75gXPAqtcy46XmjIvko/YfUkgLwXYcoi03FuFg2x9MCmJLstbWds1J/UUBNJgamOl48Eu4hlY202eV+LggGkG87HdjZqXPe96ZT7CBVep1xUplz4p4J0nuaQGX46zq4crxZSsb2TSXC3vFmzlo94Vb0MLloZM6EOPmCyrjsjkMDHzmxEc/OFrkNDok9v2FJTjYClf6gVxUPuSlmnZg4rhMham18D8tAB0PjTTiSxiFj8XvK9ASd/6o8Xj1zmFFd3Aw3rRm/HKltMFkkeppxg8pxvqHNy2CYnnJlijXaWXem3z4aOcyOheRJL1r9TLUqmeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1aAlz6lI3GgUoo8UqNIqpFZm0oqfy4qOAxq2Y7jQSc=;
 b=ZK6sAMvmWYN6708ECwdF0CEJyC+pAhL3/tCIZlvVzlUb33GyY+DpntbDjNBjV0hozewvyYbv7HIHi48FTTcYUScFnaG7mVdZMwvXwYfEnwfSGmDlSqXxuDMrPy06hVbbxZz6wWiDWEFzWE/3gxxI726Hz+7UW/aRTAoEBzii2GW7ChLvMderZeAnaLh3/ISRLqVGZXVmRiK8ukUFbeSfVQrd4K+cWWdxeBdLamQW0yQ1Bat2Rx0wOzEKbYknvqQdk5RPdpGIxeFQNJCtP7IwbfgwitZgHxvbHcw2ZSit0wdTxTA7/i2j4U8DQU5K8rzS7jwN9X16bNP+YGbZErvZyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1aAlz6lI3GgUoo8UqNIqpFZm0oqfy4qOAxq2Y7jQSc=;
 b=s9sA4ZH8Id+u/wJbuX3kXsFmeLBZaRYvpbX/PvPJu1hwHpJMVSDqmGUfYG/SwpeIUmp/9EwmD7bkQZQ07kqazhk8Gd/HwfSKvMgkz6b+yHWB8pJGvp+LtfaUVtnHUx3gpBSy+shDoAzodrPCumj59PEHTEDc41z72hE/32nJCHMgB6jjo59f06waEtU7urNKGpln6BQIoCikqzpNJEGCSxjsrzwqptVxxqrogiethzssaDUBzGnSbaExvoQNNHq6Z+5vhLn0r9RfUSpnYlQU0MiHphZ86/A1rCFyzzRinw1xp4j0V5JHBU7GZPikTh5nuF/lNQN0p8Q0DhJF62w+FQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Thu, 9 Mar
 2023 15:51:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Thu, 9 Mar 2023
 15:51:14 +0000
Date:   Thu, 9 Mar 2023 11:51:11 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 02/17] iommufd: Add iommufd_group
Message-ID: <ZAoAb8SJwC3EItM5@nvidia.com>
References: <2-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
 <3469063c-7ed4-3fda-0280-2cc6b4e6fd98@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3469063c-7ed4-3fda-0280-2cc6b4e6fd98@linux.intel.com>
X-ClientProxiedBy: BYAPR06CA0071.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::48) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: b10dbe3d-6cb0-4d4c-27e4-08db20b61ccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hy8vpsnW8xmTdZb3lvxwflZoQokIkOyU958Z8yFSWCSBisXLf36nv8v6LEDM1HeQhA57NtsGshFBs3papoLWBDlmrGjcalPSoCWw69dPLEP4TzNyYN5Lrjv7vOjq/Ez0mJeJ+iKq46aQLSLHfGbGJtm2sLE3svr8CgZfs6g0jzKjBLQBWj27WFrXwGQl3cDgT20tN7/E0xgEZ6pqlTcNtQ8uO9PT1Dnjk4IXfSequ5DcUzImEm3grvzBNHkFxz9ZkaupkH5fx+Zpi0XUu0m8adyrP5+ICTo3ZV+zXAQHNrgZlMLELFUaoatQ3oNWg5qHmyZjpI1KHeqfIeG20VCi3dFylhkwZdYZuNr0nEz4QWTyyce+Hq4xjIr04DEo+QwloKdWVf9aS1UjfohkBD6mV82ojbR1OqG4VpnlWzpvOCH+u7Syk80ycIkNBD51ZR0c27iSU8WLnQPOU8nQDFokZo2TUFB7CNGBdwsJemU4vMTpmqbl0zHrLCgISyS0/rbziqRLMRJ/MktKRwP2ZgUEXKtDmgDDO5faN0horOMYziC4HEuE/pickrk7AW3+alV2HJ8SBA3ZgoYffApqdWSQ9YqtM4PU+ANmhvJBtqBlEOKntiNWx7G3/Ayw4wBqRVhPiCOO2ylxfd4BdaIpcyYsrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199018)(478600001)(6666004)(5660300002)(86362001)(186003)(2906002)(6512007)(26005)(6506007)(6486002)(36756003)(2616005)(53546011)(83380400001)(66946007)(66476007)(66556008)(4326008)(6916009)(38100700002)(8676002)(8936002)(41300700001)(316002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zcC54q6MUCrAqb/30IchGgKv8fu+AUvtP19W47cirQ3OEnWLfKv/X6lFZYDi?=
 =?us-ascii?Q?RsnKH36Wb89nW+FqSHBMUBGJQrul20mw12wib9hwmAw3xgsKXy/URpANgSA+?=
 =?us-ascii?Q?NJATR5vTisqyQIeRNC5lSTpn6P6hfSG6HrSITwngKeafEKz3g7KKqo+/UDgw?=
 =?us-ascii?Q?hyBGzCweJ2TRS1+uzPheG71wY0xlN2/R6lLcd8expqOFRkFPXcPAjMDEea/z?=
 =?us-ascii?Q?V1+9cNTP+GSzTNyOQrDzkFVoJ69+MUkRc7Hg1l2jC+aTzanLbNFrnPG2Reqw?=
 =?us-ascii?Q?OYuIyaKYzISmrCzTUO0u5od3Y+r3JlRdmdd3huy0R+oAqHB4m1GrsV2mvhB3?=
 =?us-ascii?Q?7JHyv5PwzcWovbaJPlBezaNt/jwONqAlCGyEX8WGkZXVnlUdaGWbmjrOFczO?=
 =?us-ascii?Q?dZjf09vAkp+cq4Lua5azE8rN00cnliLLVVcHaaSTwr18gIRUJ4ZjIpO/XbAX?=
 =?us-ascii?Q?vbX2ZWsd+GN0SRGEmxD4UsV5tbMU+GgH/zQIZth5LUJa5W+Glw//OJQuilXy?=
 =?us-ascii?Q?yYuVi1a+mPBoUY/tv9YN/5xacHapdZgoUT5MLF7+q3TJxzW8eJOUhl2kpq7f?=
 =?us-ascii?Q?f49WbbQIBKjhUhc10BgthHgzD9IqYT+oTnyznZ3KXPRmlCBTH13VegbF6dhO?=
 =?us-ascii?Q?FZ7GlK9xxjzrezI7Af+U8QyHLLYLqTD6jGLjaGmgai9QeljjP+0u6EYpc2U/?=
 =?us-ascii?Q?LxY7bhhwJX7zWbhK4gOF33I1dweRGTPCCZSthq+Gt8qITHMkS3NyCFyd/3MH?=
 =?us-ascii?Q?RcqyNxVy/Jej1VqMDlajzq+t5HkXVgWoGrjWt2nZLRGyoaw9VSBo7Es4f2ic?=
 =?us-ascii?Q?9/qYCIKNdSbesVjcWFGpQWia7C+a6oVjySzOfrMXqlal/PDa/rpF1Q11CTGD?=
 =?us-ascii?Q?UEP6LMYYMTD+vPZLzDcxmH48uG9LzP78+xL44nqr0sxybr760wmqh2NFUGZe?=
 =?us-ascii?Q?O1wf4SD/vIpfsKXPnwRcfXibJ8WAGYzQx+4o0FutV85TGNP2UuJTVo/nvUFP?=
 =?us-ascii?Q?oqulg7v1NOjOU7Q8jr1dtaa5jZOa8rx30eIphROGDTnyfWGeXJ13aVYchN9k?=
 =?us-ascii?Q?dABPYTaWOBjbmk4rB8LE2MZCfD5yDhS2PkM9tMqrLdm9Sxixns0Omq5GVwo0?=
 =?us-ascii?Q?Ox6fxoH7Gn/tL0H+JB+Vjyth/cnVEQ+VsD5mcOklKgKkk5h5T0btKCYk5VQP?=
 =?us-ascii?Q?iIlhb8VUcaz7M5XOrHQZ2W3LJgDXcOu0BPyeWH/UAZLTZ3JEjxPo5rW1bGpm?=
 =?us-ascii?Q?vdTATsrWhHoJsmKFfJ0/0a9wEUQmBbhXNj3iw5iqJMUtV1Sjra+VOJamXLx/?=
 =?us-ascii?Q?cj29MKNywAHjUmlE618b3/GIZauaj2hcC9xK7KuU0EQtpBJnZtdoX55REbch?=
 =?us-ascii?Q?0C+dqy3ghWsVTXMFADaG1LkHXtpnFdbGHyFU3M8xwW7GNJG2haHX88KFEgEo?=
 =?us-ascii?Q?oe4TLZlDdp3UffE5qLTq/ctXKUv2bu7xFZSEEP+s/kVtAEDeSWYgjQ2YyAWu?=
 =?us-ascii?Q?JoFJ5aTGnlRnkhG+oBIgx/n/cvGSLngDYVIX19ElwGN0ZT7eThUOpBU1Ivqm?=
 =?us-ascii?Q?9oZWePWhOtuKvsq3XMfZT8RsIBR2QtXqfX67ooVB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10dbe3d-6cb0-4d4c-27e4-08db20b61ccd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 15:51:14.3806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhEKvXCvpcm/KE85ITD7mEgvkXUEy5GkntO/vKTMkJn8APJj+3K86HOd0Il8DHvF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 08, 2023 at 11:18:11AM +0800, Baolu Lu wrote:
> On 3/8/23 8:35 AM, Jason Gunthorpe wrote:
> > When the hwpt to device attachment is fairly static we could get
> > away with the simple approach of keeping track of the groups via a
> > device list. But with replace this is infeasible.
> > 
> > Add an automatically managed struct that is 1:1 with the iommu_group
> > per-ictx so we can store the necessary tracking information there.
> > 
> > Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> 
> The iommufd_get_group() helper looks long. I went through it carefully
> and didn't find any problems. However, is it possible to add a mutex in
> ictx to protect the group array? Can it be simpler?

We have a spinlock to protect the array, that is why it is so long
because we don't want to hold the spinlock and also allocate memory.

This is still the "short" version because it doesn't also use RCU :)

It is true though, it would be nice if xarray.c had a helper for this
"return existing w/ ref or allocate and ref" pattern.

Jason
