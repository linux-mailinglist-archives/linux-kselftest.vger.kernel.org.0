Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C083DA42E
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 15:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbhG2N24 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 09:28:56 -0400
Received: from mail-eopbgr00075.outbound.protection.outlook.com ([40.107.0.75]:9696
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237731AbhG2N2w (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 09:28:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVVwO/IjfB90wleLYJvhU/6nrO6LoJoetVrYHngfPXc=;
 b=Ug1CHRDQITfSiUO73nrVcSg8N4fdUNiYsTKliwE6LX1VZZLUHSd1sAvqwybVhJLgUtJvVKk7RppPiDa6dvPeg/wvh1IGUUqSbX0FiaA/gIxrQis/YKHHGb1+XfGbyUFkneKnTXsQ9Ily8Is4fmfSEJipzmSnU/oTkyYsgRRlXYI=
Received: from DB6PR07CA0093.eurprd07.prod.outlook.com (2603:10a6:6:2b::31) by
 PA4PR08MB6269.eurprd08.prod.outlook.com (2603:10a6:102:ed::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18; Thu, 29 Jul 2021 13:28:41 +0000
Received: from DB5EUR03FT049.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:2b:cafe::e9) by DB6PR07CA0093.outlook.office365.com
 (2603:10a6:6:2b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.10 via Frontend
 Transport; Thu, 29 Jul 2021 13:28:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT049.mail.protection.outlook.com (10.152.20.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 13:28:41 +0000
Received: ("Tessian outbound 1e4fcc40c873:v100"); Thu, 29 Jul 2021 13:28:41 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e6cea61069271c06
X-CR-MTA-TID: 64aa7808
Received: from a79335b2d7fd.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id EA292E38-E88D-4201-A25B-4B7FBBD86A0B.1;
        Thu, 29 Jul 2021 13:28:29 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a79335b2d7fd.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 29 Jul 2021 13:28:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICLar/wmsclaiXdHaSYqjl/BMVPFTlRVaxEdA4Seuye2n5gPE9nuwcp4N3s26rJQlf1+QZGT9o0U2FWY6QvOGjl0eRJB4IzLLyoY8S+hM4suUCL2ARCKUB7Qy9SvLe4Eq5Dxt+XkwvvgWe81Cdanv7Ih9WGz+31BuI/wQMi+q0IwV0e74E5SekAvrli2Monx1UU+DdPvMCU1WkqVLkUX+zxJTQAhvW4PwBwTeScHJ8wU2hTsCkQJWP35MUwWl+VId5jVhvlTAaPOyZbeix+c00YWgKVgBtPd1/LUwn0xa6JQexpu3AElUUIUaxMXHuAQTsToE6R+NIEx5tHBLEGIYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVVwO/IjfB90wleLYJvhU/6nrO6LoJoetVrYHngfPXc=;
 b=mSUupdnfd0PYUMKOPEZuFDC9vZ8CsTlg0iPw2XXnl9pkJewRqI/IqjwBUov/dAvEozHwvLDblJg0chD3PGvCL7krfxO5Fvkty4gP6qxuO+/F8QHIoIk6IkbmYuHZGBoRGO5qccfhskr4YhGjaTr8VdXus0wPJ/A6OxCS+SQbcCaLp6AQAKPS6eq9xPwx6bsmqWI+1MHBw7yOGCck0YtLAoVCmncQPZM/w9ZHrMq/qC0BXuCLSzqKWSg3EvHVotSCYFNmLIhs0G2/WLrWvWaUlgFvI0yUvFtSbwpDpQtxd2Ne3KzXOr6fdacnl3JmzXNo823mCbj9z0oDpLN4SuGbPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVVwO/IjfB90wleLYJvhU/6nrO6LoJoetVrYHngfPXc=;
 b=Ug1CHRDQITfSiUO73nrVcSg8N4fdUNiYsTKliwE6LX1VZZLUHSd1sAvqwybVhJLgUtJvVKk7RppPiDa6dvPeg/wvh1IGUUqSbX0FiaA/gIxrQis/YKHHGb1+XfGbyUFkneKnTXsQ9Ily8Is4fmfSEJipzmSnU/oTkyYsgRRlXYI=
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
Received: from DB8PR08MB3945.eurprd08.prod.outlook.com (2603:10a6:10:a3::26)
 by DB9PR08MB6347.eurprd08.prod.outlook.com (2603:10a6:10:253::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Thu, 29 Jul
 2021 13:28:27 +0000
Received: from DB8PR08MB3945.eurprd08.prod.outlook.com
 ([fe80::7c18:62b2:e53b:c336]) by DB8PR08MB3945.eurprd08.prod.outlook.com
 ([fe80::7c18:62b2:e53b:c336%3]) with mapi id 15.20.4373.022; Thu, 29 Jul 2021
 13:28:25 +0000
Date:   Thu, 29 Jul 2021 14:27:04 +0100
From:   Dave P Martin <Dave.Martin@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/4] kselftest/arm64: Provide a helper binary and
 "library" for SVE RDVL
Message-ID: <20210729132701.GH20179@e103592.cambridge.arm.com>
References: <20210728163318.51492-1-broonie@kernel.org>
 <20210728163318.51492-2-broonie@kernel.org>
 <20210729095222.GH1724@arm.com>
 <20210729112217.GK4670@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729112217.GK4670@sirena.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-ClientProxiedBy: LO4P123CA0404.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::13) To DB8PR08MB3945.eurprd08.prod.outlook.com
 (2603:10a6:10:a3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from e103592.cambridge.arm.com (217.140.106.54) by LO4P123CA0404.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:189::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 13:28:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e830e526-e50d-42a8-ee60-08d95294c829
X-MS-TrafficTypeDiagnostic: DB9PR08MB6347:|PA4PR08MB6269:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PA4PR08MB62692EBE1EF97D6622A0D12EFEEB9@PA4PR08MB6269.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: W44ITK1VwBYOtDTjSWhUaFQeDvROQTpMqgHdzq4mBHgD3VpsKn9gPQbuPaKTxVDy3db9/jm670UE7efHwb54B512wAG20wss14m39D2Op8q+/CC14798pJ4LzZtB4CbcEICLF9DucCXRtrsp0BLYcF4oO/j7IkPTv8AplB3lPy1vAiP+9K8lHluyYW27E35YSL8UHj70yEnuGm8S1GTrkv04LDj4az1H33zvygBPU8EPVI/1NJgCj7YUt91FpXSjfDb5elJJ2trnzko5B526GXSIQEmkn6mrMlzcPKQP/6YaA2JDUGwNc0bA9QlXFDHmPLWUex7vtJ9ZNcf/voIOJuXz+LESWM4cVayxkUjCQF2LUK2G856sFQt/xCR2ab6eTYNXTorxuHJWMRKWv3Piz7r6ip5Qk85KyINk+XGCEdLjYWXX1SmTYn5s3LEqFNr2E1TmknMzGCCli0RBi3+s7/BV31eKy0HaI0m32rGzkPtob4zmlhRqHBeJ5T8znHaUgi2c/a4A11ELmDtijtvic7Rm7ItzwlDDdaQsa9UHwCHq+RQmGyWavhKwVgyY0qKRLwvotDc+QOJ9LmwRQLaLOZqxlEpiNCY3w6ObvNIYu6WNUORR9lSneOCAoBUodXM/8rzpLFz7rIPyLaR/gmEbuhAxYLcVSPUjgxmVtwIEW15seSCRBMAtoOSqJn+WlsDKvlJZWzP7s8Mck2bUYUos+A==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB3945.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(66556008)(38350700002)(66476007)(26005)(956004)(186003)(55016002)(54906003)(6916009)(52116002)(6666004)(4326008)(83380400001)(316002)(86362001)(66946007)(7696005)(8936002)(33656002)(1076003)(478600001)(8676002)(5660300002)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZkJIFHdUqMTwykzyJspPbfS2z4UTutQg/dgJ5s7mPp6XRCfTueKISXxlh05y?=
 =?us-ascii?Q?COfgLNAM4Bu7euCo6N1R+XtdpC4GfX49S8rA7Ubm4ZoWtEbrzHguNAVRuaJj?=
 =?us-ascii?Q?TlbBoTYrriwGqZkVEFZ1wvb4BaLrEIuAltMgXEvZ9kZs1A1BSwSha9b2bXrJ?=
 =?us-ascii?Q?FfWns602FZY9CGoCqExbsPQgcwu9cTCWd8aSTzTMGgSrQUIGs4FPYgrOmeTw?=
 =?us-ascii?Q?d2WseW2gB51y+HdfklYw+iVSxE3ooB2G43jJQJ5IGk+pemLZbwvavEBpymFP?=
 =?us-ascii?Q?HuEqTLAA02XztHQ/y0TSBSCOBhiKXUx9h5Eir+meu2SOziPrEgBUEBwMXZ9w?=
 =?us-ascii?Q?7PnTgVW824YsUgMja+/4K+PWkjv0KTzB26V6gzAj4HZEdwmaIFCI7ikFl2Rn?=
 =?us-ascii?Q?XgWfbpdsGmFSG6m/k9Wt8oIK1ZhGhunJowjkXc0wOhHtLmIYVMJBK42+GnAQ?=
 =?us-ascii?Q?IIYV2QVCXNHlIK4ejnoSoRREFpOmSmEWJ2AsW3B9b7vQu8B5WN8/H7NWzbWB?=
 =?us-ascii?Q?6/2kOyUHT7F5qaXIwicQJXt6FIMcw6ZH7foFHOfHaog4sdJ5WQZ9AOXlUcfX?=
 =?us-ascii?Q?RPfTNIS96JesGCiA6YIdon6VffDZ7COtHNxrpS+r45WcJ6LiOBkDVtCw8LBh?=
 =?us-ascii?Q?0bjjuqDvdpNKFxWEhAfgk4bumIw8ov8pxa/+q55FoL23rWS06lZCrSVz7o5J?=
 =?us-ascii?Q?PunKx8fZkzxIqU8BoJUF5i28J9b9ZnHTQtpkjruEcDUgPYwcj/5+15x+lhZG?=
 =?us-ascii?Q?z0ZHudkAY1FtLtdyr7pMn5ETvynRlYpnWqUb4K4yaGPnKgh+d3yR2GXYRCEQ?=
 =?us-ascii?Q?ymaiYuO7vgWRPbmdQiYpSFd/ezDVvCcRwfPHLlTtNY8gGeKZiqw/7xz4n2WL?=
 =?us-ascii?Q?K2apOiQTi+vHekPxA8lF2XtDQxxWAy4+/L/KodR26+SGdEkX/fyHFuAH0sCw?=
 =?us-ascii?Q?KosrbxCWo6XrdSvyOufhYOXs68hUQBjvS9nAqioqHFnBglW2kACJEyOYShMu?=
 =?us-ascii?Q?8W7MZS0tPfj5hfDEHbzGaDPQYHhOT3zrMhUW84hFLhWH5ZPSshUCW03uUVMD?=
 =?us-ascii?Q?RV/X8EdHe9PRiQg8N7zzBCixMPe+tskYPeASnXIYnjv+w0VC8T7YY1bpThTH?=
 =?us-ascii?Q?cNDLzg8hdI6MRncR5eanGED+opbSe5hgGh+3KhD8JbGjPYSSzNxS4zXfy7kK?=
 =?us-ascii?Q?odIs33Vh44VEjacylNQ6Ed3Tpz+0IZ1FIyVH+sm54JWZEz5HgvJfun9E9Tvy?=
 =?us-ascii?Q?ziDjsOVDP/YTjxppxK6KpwMzX4BvxXAJOulM9aRa7YKjrZx5BgQZ0W8ziS9M?=
 =?us-ascii?Q?kTwudPKZaxQw1Wh+3Uuei/7X?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6347
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT049.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1fcb2ef4-b9e1-4432-d732-08d95294be4b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vqIdmqT7VCXZGw7cNEg4PJtqjFMi1FDDRC9X4+qG2kFWnr6dINxzoXR/fH6PUs7JSi3Ol4N9iMbOZAyz5znt+iPMtbJkSUZjxbYB6adbGUzf+lrEupzVIyGAGwezKo5PnNNZl3wBl11DWggkQag+x3iMbvdVf+0qOq0KPFv8zdwNwhRo9hDkDV+Um/CyTVbeI2L+e+ix/CAt/dj+7HJTobd9H7bZL8oujvdylPhTgbXNsKVCZjOBahqQkIdHJ+cdLgDHriGOtenYy61pSswhNF6vOT6OEOhN813VS+B+gqB3zvfOUEN25mt7UFJ0zcNTMFThrflJ+IyV1s8dYat5fTqqNM8Ls8jLwO93pa2LhTOa8cacPVTeGAxItO/0hAik4lWQEpiFqSp4WIW8LxCFmYM4Qvod6zn7h7xOpuiJ/Df3QCSkBU/dGLaH9tqRRQBKIw7FRoX/PR++F1We2k89dJ+Pj0u4Tr60J/jS/27pexAixqFJTwR1ewPIsVyi4zRnx0IQ/inZL4OprqYPSfWwdULjZuKMUYklr9Q4fPqXmP1E4yqTHNnlY+yNmPFMAhMjY7XZf6qWaZv0ofNL8c8lFSmRIRi/gLJwIk+UuYo4SXbVDS3HZe5D5naeVGylSbeAvJLqKfTqcnrNOfrcbPJGdG9rZPKTj4vC3xBQyRyQCl+jzeOfXPPreCO6VAgyJTnMUPgro+hzI8okfwY3bGnMgw==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(54906003)(5660300002)(316002)(70586007)(8936002)(6666004)(70206006)(508600001)(2906002)(7696005)(6862004)(356005)(26005)(186003)(83380400001)(956004)(47076005)(82310400003)(86362001)(55016002)(1076003)(81166007)(8676002)(336012)(36860700001)(33656002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 13:28:41.6384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e830e526-e50d-42a8-ee60-08d95294c829
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT049.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6269
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 29, 2021 at 12:22:17PM +0100, Mark Brown wrote:
> On Thu, Jul 29, 2021 at 10:52:24AM +0100, Dave Martin wrote:
> > On Wed, Jul 28, 2021 at 05:33:15PM +0100, Mark Brown wrote:
> 
> > > +	return 0;
> 
> > For consistency with the changes in vec-syscfg, we could use
> > EXIT_SUCCESS here.
> 
> 0 and EXIT_SUCCESS are defined as equivalent (though they need not be
> equal!) and 0 is much more idiomatic.

Well, it's a moot point, I guess.  It just seems a little inconsistent
now, but it's no big deal.

I would probably be equally happy if you called the child failure status
in vec-syscfg "1".

> 
> > Although it's hard to see what could go wrong I/O-wise that doesn't
> > involve vec-syscfg itself having gone wrong, it's probably good
> > practice to do the final error check:
> 
> > 	if (ferror(stdout) || fclose(stdout))
> > 		return EXIT_FAILURE;
> 
> > 	return EXIT_SUCCESS;
> 
> > (In reality, people rarely seem to bother with this, so I'm not going
> > to lose sleep if we don't do it...)
> 
> Yeah, I think this is one of those raising more questions than it
> answers kind of things.

Fair enough.  This is the kind of thing it may be better to do in the
library or framework, since even if people remember to do it, they are
unlikely to do consistent things...

> > > +.globl rdvl_sve
> 
> > Should we stick a
> 
> > 	.type rdvl_sve, @function
> 
> > here?  This may avoid surprises with future toolchain behaviours.
> > Probably doesn't matter, but I have bad memories of Thumb-2...
> 
> > Lacking this annotation is widespread though, as well as being de facto
> > standard before awkward architectures came along.
> 
> Yeah, it doesn't seem to be in the slightest bit idiomatic for the arm64
> asm code the kernel has.  I don't know if you think it's worth adding
> that to SYM_FUNC_START now we have it though?

Actually, I think the core definition of SYM_FUNC_END() in
<linux/linkage.h> does this.

It would be good to pick up the common linkage macros; if we have to
sprinkle .type manually all over the tests people will likely make
mistakes, to that's probably not worth it.

If picking up the macros isn't trivial to do, I guess it's not that
important at this stage.

> 
> > If the selftests have access to the ENTRY() macro we could use that, but
> > I'm guessing that isn't exported for userspace.
> 
> We don't use that any more anyway, it's SYM_FUNC_START() and friends not

Yes, I was forgetting about the macros that replaced ENTRY().  It's a
while since I wrote much asm code in the kernel...

> that those are outside the kernel either.  We will have to do something
> like that if anyone starts building userspace with BTI though (or I
> might just shove a BTI C in there unconditionally, I'm sure we'll cope
> with the overhead on older systems).

I thought about that, but that .S file isn't annotated as supporting
BTI, so I guess there's no problem for now(?)

It would be harmless to add it, of course.

Cheers
---Dave
