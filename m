Return-Path: <linux-kselftest+bounces-43657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D0BBF660F
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 14:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B6DD734208A
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 12:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A095C1FC0E2;
	Tue, 21 Oct 2025 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Aj8TExO3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010025.outbound.protection.outlook.com [52.101.56.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47D616A956;
	Tue, 21 Oct 2025 12:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761048945; cv=fail; b=alSk88b7yYnj2sf9Vm5PFq+66+UKYjMLOjxx/W7Kt6c4uZ776AVBO0Ss5HewOVS5zsKaMYjffR52aCd3gb0yi/ioSgMBEOI7+h1BDIc9CfRwCxzLV6SkXxTH+Alq6YHCSvMYn8OnfVtlMs+7fwor2BzVALRUtNAMG0YGx0DEZ8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761048945; c=relaxed/simple;
	bh=L2wKlnUJlTV5MtE0aIyFGCBBOqfGvdCxY+UyIqboPoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PCtj4KLxqHZmO8kEY0Bum9yFKkkVwHMgHsFIYqTepcTEovKjyIdNo4WBwoATrOfAhC3e0C12NQXGrRqKKoP4U0MAWlkvRJaXErXFNvQd1e/Rd1usc/ofLddAp0mmK5GWKaM1yqGTO0Z8tTW2yxXTJqR1X0u35LZP/XIQzM7kGNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Aj8TExO3; arc=fail smtp.client-ip=52.101.56.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFnvpGxdD9Wkf+UvzHYLlol+NEEdmYJJBNLd4XgfBC92+6vqv1nYb19hoUgiE4usGfUK/NBVmx0wKINwBNTxEglLU36a4+ItciWYTKzo+cYLE7+3Bz5nuZzbdfhuPldylRcgopmDeF8MBPwP1wnmbQ7Y28mJMEDnpZQjifO1/2dO192jD1OpdGBmVJwkQR/jcqrnlNcXdNMOmtU2CCB8PbGb/ntysQvXE7NlzPJCjEBj/Pl07CtjD1TbOAZGUfwQK5hcPxI0ZQ1Vpvgo2Jaq2Es7cCN4K250Hi+yGxT9vDOfivZ9cC4Pf6oKiC37GNDBdbcKkNt4dYmyGq5+wrJY6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySpXSdFN1hZTIgJVy9DHDcx+St4NjvJ3+Ftkr0D4tms=;
 b=zSEZkP/5TSaprRqGVplA0Oqr44DiSIv/uUtMwYifNLK49c7UW4R8fGWn+a5JlGHS9cJq10oHPB2Dnd1GREmXvNbjPKUNnyM8I4PWvFf5vOP32ejXLTJLLhpr2JKqgcZ8t6uMkOF/0sF8UtjKLezLd2nkVlFgcrONxqv7Fp8P+6xTbA8Pr1a7pRXGODOB2IUCwJgPEprW4mwI+TViHzcTH2ZbGAv5+oj9tJtXokvOP1CAlXIlWb1CSC6SnR3vPO0BNkdo/BSHkqOlQZc870PJdguJ2rfcWoWrBjVaqDkXIKxHLgSocHA60L4tMb5Qp6mo0OS58S493XcgUirAN3F11A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySpXSdFN1hZTIgJVy9DHDcx+St4NjvJ3+Ftkr0D4tms=;
 b=Aj8TExO3CS9MvSaPwFnmBiyaf6HXLAm0MqLlWpMUcQIQBIP0wKTw4JHYrLGN06yVdmWFNnNfiYixFb07rIfq5OCVP9R8o9K4kOz/r9WTCKB6HCpXxrFw2orJe/3BrgVfmdOVCuI16Q7ptMIvR9RfKNJQ6mrOHEVvFXPKMWrzUgfpOSw01C4kbAA4MvH1XRak4UxOc0mTTsUEwL5rlydFh9DlbVLHg7JM+kDbF2CC+YP/41spn6VHNRF/1WhoJWa5zOdZuib0imt0NEsM7+Ge5+NDsHOr5gISe3y7AtWxI/82sE1UaQtZIopONu3CfN33KH9NFHYEbYcTnqTRvgQ67A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3604.namprd12.prod.outlook.com (2603:10b6:408:45::31)
 by SA0PR12MB7463.namprd12.prod.outlook.com (2603:10b6:806:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 12:15:40 +0000
Received: from BN8PR12MB3604.namprd12.prod.outlook.com
 ([fe80::9629:2c9f:f386:841f]) by BN8PR12MB3604.namprd12.prod.outlook.com
 ([fe80::9629:2c9f:f386:841f%5]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 12:15:39 +0000
Date: Tue, 21 Oct 2025 09:15:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 5/7] revocable: Add fops replacement
Message-ID: <20251021121536.GG316284@nvidia.com>
References: <20251016054204.1523139-1-tzungbi@kernel.org>
 <20251016054204.1523139-6-tzungbi@kernel.org>
 <20251016123149.GA88213@nvidia.com>
 <aPGryj-V5PQZRtoI@google.com>
 <20251017134916.GK3901471@nvidia.com>
 <aPJp3hP44n96Rug9@tzungbi-laptop>
 <20251017162116.GA316284@nvidia.com>
 <aPT-7TTgW_Xop99j@tzungbi-laptop>
 <20251020115734.GH316284@nvidia.com>
 <aPcQ99MZse5zmv3o@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPcQ99MZse5zmv3o@google.com>
X-ClientProxiedBy: SA9PR13CA0167.namprd13.prod.outlook.com
 (2603:10b6:806:28::22) To BN8PR12MB3604.namprd12.prod.outlook.com
 (2603:10b6:408:45::31)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3604:EE_|SA0PR12MB7463:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a7ebb3-5284-4d40-683b-08de109b8bdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M/0BfovpQN+1WKQ1YTDcsruddSbUnwxzJCWCvBH5oZMMzQS88GDSFiksJGMA?=
 =?us-ascii?Q?t0f8dwhuu5x0EQkkdcwADXeudY8Gurgti2QUHX0EI60dx0i/cg+0Q1HptFFd?=
 =?us-ascii?Q?m4i4nnGnmS/sj2tcNyRSb2ZgGjN7nl9LW74nHnPBF+/htS6JG+80BTNzD7Ge?=
 =?us-ascii?Q?CoQeN+OKz4niKMOjxTHvRS+F4h/3mL0xWa9rKHE09guNsvxGsd3Ps3vL+CAk?=
 =?us-ascii?Q?9ScmdKydbOUNjbpfZiM8RMae5yHzBcodQfE8ZdpuJXGlJwKRRrU6IlmSSrw2?=
 =?us-ascii?Q?3Pz0njgDDPfq4bzh4U/6HEpWmbZFbfYDB1OA6PNZvODmuCuQGuC23wFMvtwv?=
 =?us-ascii?Q?+E8+0FXrgMGcuCTwWLWiFoAf+jcFD6W44misorl5Edy1qcZbIF7+b71fnqwJ?=
 =?us-ascii?Q?Oc+NvrGKsEhNP1XsnignkkPnbWvlJdVK1VRX2SvO+A+59duRoPvLOKdLW/Pr?=
 =?us-ascii?Q?zA5duq9k3IpzXm/fGNsTsmeTknjmRupI20B4g6qPM5TwSW2GvUk6CVyIt5P1?=
 =?us-ascii?Q?iczdtVzvi91DLEmiCcTjvgGvNDwb6GFX5udLUSUsgwW9qdRuvx4e6L8KYm9P?=
 =?us-ascii?Q?GhYBohpATuZohWeiMVyC0lIowVGUGJJUUUMPMT5aLuP2WNBogrmk8A1CCwD1?=
 =?us-ascii?Q?5C1LvOVp3mnr30lz5u0XpuWqhiwnhEJq1YNNuwR3EL0vM4K5XrixP7XrtGdI?=
 =?us-ascii?Q?s36Kz1Lo23UIZbpjZK9Zqymi8GRYuMgR6WYrYbvsq3c4ylo6e1t89B1vSbRr?=
 =?us-ascii?Q?X0WphwwZEtD8mbJ2CoxLiGRaI6MaDMAzD55XvyZn+5w5rNpEAKVkpUZfBurg?=
 =?us-ascii?Q?7OB+ktrtxXsjzK29EkIwT2U+mC631H5UUPZGVLeFvrs4MojPq3YXgxbtrPlA?=
 =?us-ascii?Q?Jyh8XyCvfJkGBCUPdj7LFLoGAQvtydAWmA6ovjuOu4IPOY3i/nAV7DN9rQqO?=
 =?us-ascii?Q?iTCFfELxun26tZRy9dxtTI2nFdbveEVkajE4Koa4r2mn3FISfS3GiD0AboJ0?=
 =?us-ascii?Q?W5iMMRHLfqovE/BSdFhXX18Jg2X6Kha0rIb+wgFZS97m2ZBVo+HFx6jLQgRE?=
 =?us-ascii?Q?WOK7LW+44Cik0QG7EFJic7muYY3loisfUgTP5pLU6TK2dHZ2uw5hYcNeInQp?=
 =?us-ascii?Q?5sxYgOJsvJIVX9MumQMsP34gzX4C0WNYu9NE9QTpFzYflF4p+Ud5VZoi1Ssv?=
 =?us-ascii?Q?FzMQxNji0z2l6/R+oEbFBaOWVj1GW5opZU5n6odIGqpGx6mZPG5y2qV1YYRj?=
 =?us-ascii?Q?TXVCsFDt6wKNkPbAepTWv37Xc/1+uiTpR5ukZumQlyWmP7DsA3/3kfvgFhFR?=
 =?us-ascii?Q?U3BadsYcqQ9+CwPY7WB0qFGIjy0Db2V2zjo1IjWyXRCbGRMtxHPUZcRPnPRo?=
 =?us-ascii?Q?jJ0/hs4sSfYW9wOH/JcYEwoVm+FzNrEttyRfPBCLlnrxBP65n3i7+dko56UQ?=
 =?us-ascii?Q?srI8zR92TJM+L/f+yNf5M+DQOptVyBYM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3WVmh9hmSPABBnWsH0nRoPOO34CsikIwzpYZdzLbcLyKi/tP6I12egAJGi2X?=
 =?us-ascii?Q?rUshZQjpVpzC5DwZimZnNiPmy1PipFLuKEznwWALTPOf7n3k9H7C659nY2iH?=
 =?us-ascii?Q?mreqUpQKdpk8R5+pwx67G5XfggUn1b7rTJSjilqJC60otU8LibxZe5sWeqFN?=
 =?us-ascii?Q?mhgguAe+i5zakjrQXvGoNRUIuixAK7ny9SGI81zEQ4vieTrwFHoqO9eQmEbp?=
 =?us-ascii?Q?FBFsXzsRUvDx6748Ca51hOTyFhHfpfVYSSv7Z01xcVQwBfVDAiAuNSuFxsJu?=
 =?us-ascii?Q?E5fKBGRirmYqQDhxN+gNjYfRJVH6+s/inzMOWfovnHgJ/vpWcdxsqBo2A9XT?=
 =?us-ascii?Q?cnLKWAbwOEEY5UUxnyda4+lwMLiL7hVo4857mQ4FQSQKIZKBw/KfGZ9ctJfC?=
 =?us-ascii?Q?A/jx/YBs+BiLQbD1aLt/gTbymlbYzoPI3afKP/afPkYPtPP9WHXQoXr3v6PO?=
 =?us-ascii?Q?WpMnX8LnjO8YLR+VInrZNWAZ/at9gBNlJ92nQ76zeGY52w4X8L6sbKJ5A+9y?=
 =?us-ascii?Q?qudgPWCoLJmeVPUfJWDm9CBeiGdGSBCfP7hVe8sBzRBcPPLl8M5spgzcB4NM?=
 =?us-ascii?Q?R2VxC6fm8anxzz4mLFunC/58036hNw+La462E2DF40Vl6ljhWGLX+TArUyqr?=
 =?us-ascii?Q?l+YSD8EUadSFoGb787psH1HBlUSjdMGSJK4dS4qbeMI+sCa/Yv/rRSuAfnKu?=
 =?us-ascii?Q?SckhSjA0fmcUA5Ajt1Sj3UJezr9EXPGEtaB9as2m3dxGJeJWh60kFWtxykJJ?=
 =?us-ascii?Q?XFnq3DQOqSRQdhwMf5wC3p1cfT3lWoZqpMl7NJW1kHbj6EYS8HPMX2GUtDOc?=
 =?us-ascii?Q?qtPaWN5PqwXwaglNSjSWMkI41IKpwjrkopWFe2kcuQ1k+YcjZQGx+rvxnenP?=
 =?us-ascii?Q?4nu6i2d13xryrCAZWPAcBsfvX6kcbSNrMmcqh4HES1P32fEHbNrzUulwVXvN?=
 =?us-ascii?Q?Gr1mS5hJaMPQK6nwH29ISI8P+oCzpwetV8BagSehZUJMd2mJwi7jhKhzvhCs?=
 =?us-ascii?Q?H3v+tOGrBoNlTMAQkx9Oi0CC7+0DRlJvVe9NEqo4N8z0OaFmrvbT06mTzd4i?=
 =?us-ascii?Q?7z9vjmD0UD3kCy9Gdp2pi0XrEoCf0BLLVyivBoDtTvf7TH83iQfO94fwjA8s?=
 =?us-ascii?Q?HjTTE6pjVI2b/Nd4AtwAbI2JWLZ2PdZBTrxMtZksnI4WGBMtufFvF4jE8Z6T?=
 =?us-ascii?Q?6bVeky+1WQd4XOos7g0f3lhNf7UHEENflRYBFOMFQY5nw2FDqZf/gotafDCC?=
 =?us-ascii?Q?zORloLlb5HtrFUeV2fcHh1+6zf//n0hECfkOKEFe3Dg7rMFjzXBRmbvQAq29?=
 =?us-ascii?Q?Olz1BikQxzEAXHTf+oo4Uk8WJFJ/sPNfnwaBRPVk8mzhxsOIrgNa/cy8uxZY?=
 =?us-ascii?Q?b3TAOOQwyqvv+TF/BWqyqX7gAc1rSA5x3tkiTbyArwhNLNPOmvD6FO0kArQ6?=
 =?us-ascii?Q?+eS3EIvck/x/lV3+nVyDbXzuFEvbs0D9mxwH5cS83rTT3BXqLMFdpwcKFe65?=
 =?us-ascii?Q?tXbk4heTK12oVUVVXsck/TwiUoCLTzPDBtDSzAuDejGZXPpmXxErmoDtkhUq?=
 =?us-ascii?Q?OP+MWm6MueTAYL3+5sOd/bDVOcFqyFFXhPYTM/aJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a7ebb3-5284-4d40-683b-08de109b8bdd
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 12:15:39.7254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: evQ1hhOaU6lwXGVo6eZgFGGr9+PnhJFeYfSpvW2plAk/w254nBsJnMUOsuHrMlrV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7463

On Tue, Oct 21, 2025 at 04:49:59AM +0000, Tzung-Bi Shih wrote:

> I didn't get the idea.  With a mutex, how to handle the opening files?
> 
> Are they something like: (?)
> - Maintain a list for opening files in both .open() and .release().
> - In misc_deregister_sync(), traverse the list, do something (what?), and
>   wait for the userspace programs close the files.

You don't need any list, we don't want to close files.

Something like this, it is very simple. You can replace the rwsem with
a srcu. srcu gives faster read locking but much slower sync.

diff --git a/fs/char_dev.c b/fs/char_dev.c
index c2ddb998f3c943..69bbfe9de4f3bb 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -5,6 +5,7 @@
  *  Copyright (C) 1991, 1992  Linus Torvalds
  */
 
+#include <linux/cleanup.h>
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/kdev_t.h>
@@ -343,6 +344,74 @@ void __unregister_chrdev(unsigned int major, unsigned int baseminor,
 	kfree(cd);
 }
 
+struct cdev_sync_data {
+	struct rw_semaphore sem;
+	const struct file_operations *orig_fops;
+	struct file_operations sync_fops;
+	bool revoked;
+};
+
+static int cdev_sync_open(struct inode *inode, struct file *filp)
+{
+	struct cdev *p = inode->i_cdev;
+	struct cdev_sync_data *sync = p->sync;
+	const struct file_operations *fops;
+	int ret;
+
+	scoped_cond_guard(rwsem_read_kill, return -ERESTARTSYS, &sync->sem) {
+		if (sync->revoked)
+			return -ENODEV;
+
+		fops = fops_get(sync->orig_fops);
+		if (fops->open) {
+			ret = filp->f_op->open(inode, filp);
+			if (ret) {
+				fops_put(fops);
+				return ret;
+			}
+		}
+	}
+	return 0;
+}
+
+static void cdev_sync_release(struct inode *inode, struct file *filp)
+{
+	struct cdev *p = inode->i_cdev;
+	struct cdev_sync_data *sync = p->sync;
+
+	/*
+	 * Release can continue to be called after unregister. The driver must
+	 * only clean up memory.
+	 */
+	 if (sync->orig_fops->release)
+		 sync->orig_fops->release(inode, filp);
+	fops_put(sync->orig_fops);
+}
+
+/* Must call before chrdev_open can happen */
+static int cdev_sync_init(struct cdev *p)
+{
+	struct cdev_sync_data *sync;
+
+	sync = kzalloc(sizeof(*sync), GFP_KERNEL);
+	if (!sync)
+		return -ENOMEM;
+	sync->sync_fops.owner = THIS_MODULE;
+	sync->sync_fops.open = cdev_sync_open;
+	sync->sync_fops.release = cdev_sync_release;
+	// ..
+	p->is_sync = true;
+	p->sync = sync;
+}
+
+static int cdev_sync_revoke(struct cdev *p)
+{
+	struct cdev_sync_data *sync = p->sync;
+
+	guard(rwsem_write)(&sync->sem);
+	sync->revoked = true;
+}
+
 static DEFINE_SPINLOCK(cdev_lock);
 
 static struct kobject *cdev_get(struct cdev *p)
@@ -405,7 +474,11 @@ static int chrdev_open(struct inode *inode, struct file *filp)
 		return ret;
 
 	ret = -ENXIO;
-	fops = fops_get(p->ops);
+	if (p->is_sync)
+		fops = fops_get(p->ops);
+	else
+		fops = fops_get(&p->sync->sync_fops);
+
 	if (!fops)
 		goto out_cdev_put;
 
diff --git a/include/linux/cdev.h b/include/linux/cdev.h
index 0e8cd6293debba..28f0445011df20 100644
--- a/include/linux/cdev.h
+++ b/include/linux/cdev.h
@@ -11,13 +11,19 @@ struct file_operations;
 struct inode;
 struct module;
 
+struct cdev_sync_data;
+
 struct cdev {
 	struct kobject kobj;
 	struct module *owner;
-	const struct file_operations *ops;
+	union {
+		const struct file_operations *ops;
+		struct cdev_sync_data *sync;
+	};
 	struct list_head list;
 	dev_t dev;
 	unsigned int count;
+	bool is_sync;
 } __randomize_layout;
 
 void cdev_init(struct cdev *, const struct file_operations *);
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index f1aaf676a874a1..298c7d4d8abb5e 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -253,6 +253,7 @@ extern void up_write(struct rw_semaphore *sem);
 DEFINE_GUARD(rwsem_read, struct rw_semaphore *, down_read(_T), up_read(_T))
 DEFINE_GUARD_COND(rwsem_read, _try, down_read_trylock(_T))
 DEFINE_GUARD_COND(rwsem_read, _intr, down_read_interruptible(_T), _RET == 0)
+DEFINE_GUARD_COND(rwsem_read, _kill, down_read_killable(_T), _RET == 0)
 
 DEFINE_GUARD(rwsem_write, struct rw_semaphore *, down_write(_T), up_write(_T))
 DEFINE_GUARD_COND(rwsem_write, _try, down_write_trylock(_T))

