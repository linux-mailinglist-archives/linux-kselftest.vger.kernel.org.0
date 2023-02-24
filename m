Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5E36A2037
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Feb 2023 18:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjBXRDI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 12:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjBXRDG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 12:03:06 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4558A168A8
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Feb 2023 09:03:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZ3MnKClXroXroEQ13jWxEs0wFDsUP3k9wvHEZ1iC8xgkIUmqsyGwxa7Iv2egKXgn8f4Huv17afTCXy09tW7SZJi2c2iKc03QzgRrUnCB6zqUmEVjSK8wJCHYh4x8Dt6vUmjrF9ycs1vDgFV9xetUQZC4HJsPWXBI89+LwKqxUtB4ObdclnHMkX41HY1MyWdscpyi2zZA2MbckHXsY3TvOOdZpLKI54EVRM8o3DGIEg1QQSk9r/FiOrpxd1eTuRjNXpFiqriBngoceiPZR43zhK5Qcw+Mmwby5lNUT7FaKdVhT7xes4eL0fqZ37+WzkYv6y7Rt+BncyDiYuNNZBDyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ex7YlP/hZpP47iYct1QznLxpHh7yKmpuQaIIlzdQAdQ=;
 b=Tf1+E28+drAOUMvAfUP59drczCCRqiCoPKtyEGT8EhQywVpcUiRCS0lVy7HA2wuPuPM8zdrG8pJs0mS+W/hG1/1N+LPi5hZom1SlWaREbIN7tDUJIxVxvDbhc3626DOtaVgxvsFGHbAEZGr/YMmRmeT21+pFxFTaYTK5LZL2duadWY1M86SKWOapmJp+cnLRlISypSlrqj0FqPBZryFtatqDSkX0Pw2SSnlZfoQqMbM7LUcpUjJ6+3HL+4DGPcrDhW4AIObgWfSQiKkkNwb58I/gOaw/otyPPLPB408u2iq/UcsFPgSQwtmXfbmm/ArowaXV0dhnLW2dLKI3OkR2jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ex7YlP/hZpP47iYct1QznLxpHh7yKmpuQaIIlzdQAdQ=;
 b=ClHSx3bj11oVXiGaAAP6P4Eoo1RllSwSW9bG7jDSNLtYV7qvfQ8yZ9XNia9XWruauO3+NdbbgZLZ/lUBzXLcCVtjERjuSG+OgBrsMxop4RIkMXNWKo3886m2aANGlLd+7SzCPbENZIGLecp0/UooEaqRgwW5pUAFEz+NVlqE+mdRsON+UWxzAjwnbOnsvA7Mt7qQFzg8gA+AbvqcYTsjTuyCrNR0xt0Rt2MnL3iQ33Oo/tZUU8Q0+fe7SfV1ZsiIP842PoGoIUuvW5jOWyjQr5JDeijInL/Jv88pcQJ6D/s0hQWuTe764/9SF+aZWprT17Ttavn2T2IKmck9cJoKJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4955.namprd12.prod.outlook.com (2603:10b6:610:68::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Fri, 24 Feb
 2023 17:02:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.021; Fri, 24 Feb 2023
 17:02:59 +0000
Date:   Fri, 24 Feb 2023 13:02:58 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 5/7] iommufd: Make iommufd_hw_pagetable_alloc() do
 iopt_table_add_domain()
Message-ID: <Y/jtwj7CcTOvV+WW@nvidia.com>
References: <0-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
 <5-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
 <BN9PR11MB527686A5ECB8DB6B34E07BAC8CA89@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527686A5ECB8DB6B34E07BAC8CA89@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BLAPR03CA0178.namprd03.prod.outlook.com
 (2603:10b6:208:32f::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4955:EE_
X-MS-Office365-Filtering-Correlation-Id: 360c683b-3f8a-4792-5a28-08db1688fb48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pY7xT8YSnYNBBHvd7a7Lo70Sildg1LvWt2CRtuBeWwj5S96sG2JfYJT2xwcXC2Bpucfcamlenz97bfq4BkFod7u+UFw4KaEA2wXo5cKKQI4A1+ioKnOchiBWVhFVcUbZyQ+FwQbT3j9PHYIvku8NCBV4vIBCQBp9SSBftN7atL8CgB+ZYGu/uvH+3Ua6JYh5Q+pfoL76AIcuVK31rPzlHZbCDlNvYiGom3mZc8sdDBzTzYpYiAcdalelfkHraNoMlfm2wwGIAqpwvRUDld3W+ag/UcPSjhUqRneSkQ218FMh0q1PTfgWFmsShFbvIf3qWOcxEIRsce+pBNb2pXWfseEnZkcxgaFAZNDpW5Q2+hFqrF2EgdYob5c8rkfAq9jb+i+FxVuzieVXVMNJK1zyH/sJPdKxqJ+LE6q+idpgoAbCJU6TKuhMG6k2r5n/YI5SWvME0x3diXw46M0zjlYoHPoc3spdOgOS+/EgMKdalgM7+zyqF3cqhtDvGKNj9ShydK01qYSCmhuWJmFiMHTFKfupABKbui+IQy7u7McTOqCsE5i9dHu71Sw8im8Tc8wGLjdg4P4QZUFKzPvuWh1QLU9PBqkMD3iibUO9HB97bgl8T1Il/HyWOmAdUT3WcOQyeW/lB6mcC+vKONvWJcuuMaab3ffyyUwXOWlVle3Y6qDT8p1wo970N1+NB209pMSf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199018)(26005)(6512007)(6486002)(186003)(36756003)(8676002)(66556008)(6916009)(66946007)(8936002)(83380400001)(66476007)(4326008)(5660300002)(2616005)(6506007)(478600001)(41300700001)(54906003)(316002)(38100700002)(86362001)(2906002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+cMwwXdJGF/9P1pPrAb5BjZv+HtUfP8qzGAA46KI2oWw7XCLCI+PTT/6xyPK?=
 =?us-ascii?Q?oOStdZ1C107C8shDECMsJFStJuHW48Y+pRoHWxAR9jjGNVwJHaqb6sjRZ05R?=
 =?us-ascii?Q?4Rxu324pUyfaDV1z088JsNwrvGyR5KtbcQEfA0F7VEqWSSx2N+A36JmMTNz2?=
 =?us-ascii?Q?GzBF39n4j/rYZvcz+BWPD5HnfdZchZC+Zu3+lbLbXFF/PjpPWTrjtKxOMVPh?=
 =?us-ascii?Q?FziMKM8oM/9h/YFHQmh3ZiHpLzVsoI+dPRsWVOnuHEyCbFP2Z6p/CKYNcbQY?=
 =?us-ascii?Q?C7ZoYtlioKskv0+NuieXklAJQVg+wNLBMR+YAoO2PmNZ/NBDj45pEqC8/nxF?=
 =?us-ascii?Q?xhFJo9QTHc45GnDg8czXbzV3ZCg2FHEak74gSd/FSAsvbp9VUOjjL5/EFLck?=
 =?us-ascii?Q?hT96YHAkeoN4uj4tlphpx2qZ+LBVtiIEplfmlhsUwCooMQF8Rjo5tv7tWHVV?=
 =?us-ascii?Q?lhIAD+s9ahZfMW4LmnZoAylvvsacV74ZcfmjomFDFnkM/fyD+RfUE1HMf/d/?=
 =?us-ascii?Q?JnFW7R66o7jbfy8a1krcg58KMA99GPMMBvvtlfEjYORp7NFO1rKZzpnBMyUD?=
 =?us-ascii?Q?BrrlFSKwvL0pzvoDVMmW7iLH7I0dkquxeTaeu7uc6LyEWyhqYV0X0oKWRZha?=
 =?us-ascii?Q?7ld2QHIFLDDHonBjhdONKPOJ+KYdyeoadDwmAW0O6YIB16vcdsxSbTucJk09?=
 =?us-ascii?Q?cv+HO8sXxl39T7Y3q0D3b+bapOFQcZYI9gmjoR4XwkV5dlS724dxAWgXI/Ey?=
 =?us-ascii?Q?xep3wNw/bm2otiH7nmzZteYJ4JbtX1v/gS23xBHh96VS4N+JLpivUN6Ot33/?=
 =?us-ascii?Q?QUA5lM1Jk6LAqMFWfnhxLLhrTzUe1qNb83MfCPa7+Jt6eTz1RRBCEzpAWwJs?=
 =?us-ascii?Q?lSASQ5lIjMiDy1Q83jmxjiGfInOrxuQDZfZ4hSslgtCgJsAci42SkvOuEAFt?=
 =?us-ascii?Q?iMLsqt5DFQoILuB+05gIio7s8WWntqw1NBwjo2Q9JurqWnDCMmCaeBRXfVkW?=
 =?us-ascii?Q?d38mBeoLs8nujMO4+Lqfpnb4jKt8N8APacEMic7PbawpvrJVj/jfCByHam2Q?=
 =?us-ascii?Q?dYxUJKbzGaP+NtNPZDGi7uJvwlYRlC6K1R4zO91ipomLRLucbIssXBC2KmtA?=
 =?us-ascii?Q?B1hVtzIiGGIH3s3Kr358128I/WkyJjNmRhI7NBrk1bTfDR1bzqpwD3sVqJXe?=
 =?us-ascii?Q?Gqzyy2ZHYRD/yoyu6Bw9MQ1enTYYCflXPFueVt6TcVgsK8JoUJBzAjsfQnc0?=
 =?us-ascii?Q?2pBRaszIvj4xnw5QG1/YWSCRwY/+AZR/iG8C4nNKYcnbrE4g6UmVBeGx4LKm?=
 =?us-ascii?Q?9Yh8vQ8nqS5IPKYG2eTrlPL9nD5vPtFIBtZg30WBmxBw/oq+XNJ0vodaA4tF?=
 =?us-ascii?Q?eLwUbQoyhi5xYC/d3FwML4W+qrv3mEeC3Pssd7PN9kQiRpaAPrWiuPPyHyN/?=
 =?us-ascii?Q?4v2kcRTsYw12RokWV+VKGTZ0dFfkQo+V0qViosu+txtb660jjfL4Ny1gmdyn?=
 =?us-ascii?Q?6+5VXlcywnjTN7Y5FUEJb+wVqkXVxrKmRLbWVuEuL4AnC1kr7Lw1SCykKywR?=
 =?us-ascii?Q?hlFnogacTc7/aW2NMgbmubpB3WEqHIIBNyMy1A/R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 360c683b-3f8a-4792-5a28-08db1688fb48
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 17:02:59.1805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pU8hNVm+Rdoko+XHfFvOguhnidEM5kHy1g7TRIrkUJMJIxkj228wcWGSCk0Z6s1r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4955
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 24, 2023 at 06:35:22AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, February 23, 2023 5:03 AM
> > 
> > +static int iommufd_device_do_attach(struct iommufd_device *idev,
> > +				    struct iommufd_hw_pagetable *hwpt)
> > +{
> > +	int rc;
> > +
> > +	mutex_lock(&hwpt->devices_lock);
> > +	rc = iommufd_hw_pagetable_attach(hwpt, idev);
> > +	if (rc)
> > +		goto out_unlock;
> > 
> >  	idev->hwpt = hwpt;
> >  	refcount_inc(&hwpt->obj.users);
> > +	/* hwpt->devices is all domains that have been attached */
> >  	list_add(&idev->devices_item, &hwpt->devices);
> 
> s/domains/devices/
> 
> but I didn't see what additional info this comment actually
> give in this place. It's there in a function name xxx_attach then
> certainly every device in that list has been attached.
> 
> > +
> > +	rc = iopt_table_add_domain(&hwpt->ioas->iopt, hwpt->domain);
> > +	if (rc)
> > +		goto out_detach;
> > +
> > +	/* ioas->hwpt_list is hwpts after iopt_table_add_domain() */
> > +	list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
> 
> again the comment is meaningless

Okay I just deleted them

Thanks,
Jason
