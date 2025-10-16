Return-Path: <linux-kselftest+bounces-43322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4EDBE3610
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 14:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 30E4F34E58B
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 12:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA803164C1;
	Thu, 16 Oct 2025 12:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OLf0keBB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013000.outbound.protection.outlook.com [40.93.201.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB0F41AAC;
	Thu, 16 Oct 2025 12:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760617918; cv=fail; b=QICEn6bXtAPgO9dYgwVEaZquE/x6UKOdJiByeFI70W8Tz5LMtBcSE3tcvqKNhhuOZTdU/WQGLURxAJdA31vkckwCEfxiUGrYUIthSN1tNPY/o1ZZ6to+5/uc4liaDtpuWuc/8lVCm77ni/eslApOTmxoiwUK92R/NrZU3Qxb48Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760617918; c=relaxed/simple;
	bh=+XEDEfxjqarVIMHAV9mJnGjhND0IF4K58CXahN+eVLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bRSa7BAcpt6e53BMSf4SNCc/ppPUFmceoGbUtYd4Mmrvyy60QEtb72kOqCffCATjpQij01M+VJ+jnTMWytnaUHzpWSTrpk240Ofehyxl76/X/o3eTdJftC/rIwBGIUu9sBmCibHVdg78ftkkT1RRGwQmCIvJHU0esj2lOQYZzE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OLf0keBB; arc=fail smtp.client-ip=40.93.201.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQBDD0gmUorEIXQFoV4WmHrVdRYMJz7zqOSTsLKF99ZsdhAuiJDsl7pttDOkIMdpK2zTsaOHlHTYaBxuVd4z9YPaUIJgS7qmNU0lVHoKFt4Dz7l13hchvLw9DJLBSGEDRM1gZYIaxuX3ZFGrmWW4QWNkdTFXHvgQUC1L5phwukrslRSgD2gu+jSsPqQl2BeqmmR5Nt+B8C9HmcJo04+MGqSDkacK0wqRtdg1B7r8BvfsnxTg1Q3iJMEmdQL2Tg0JuItRqVk1kkYGkQIaM3fFddkJPEkBdUwKxXBOBxe2pSFLkk8/KQSa3SElT0Hw6d/fpGSh0x7WwfAeABuyQajo1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrBLIXXQB4ggYUExJjwbcIHMP8HTVLQ9eTCCF6KbOKc=;
 b=l0N9UtCThyfYklgMQOilQtXVQdnn7sb/8JDYKUTvNju7TxOffjsOghfRUq7yrO+dsm8/ec4q5WpNWQXIgYns8IE2Cbe3XQntQ2X9ldFUaV6P8/PIZ1Yh5embYhnOiyjERqCmQEaXGXMcGmfnzZ6cwdcZo7cE+pxqTvxX6DTsUHdjpdgMYWgcE3Rnqy4P4XjyzplCsd8471sPGFLuDbiGuUTVVMflxVaoCX140cNPFgVTqofOlSLHnsX+t+dfmlD4aWI28mlB54hSjLNCoiljNHIPEEds6KUxBa04iBHqz+khtIgPaQi+x61Io+Csx99fkEu6Xr4rJdWbvM9UMLSX1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrBLIXXQB4ggYUExJjwbcIHMP8HTVLQ9eTCCF6KbOKc=;
 b=OLf0keBBe5gpBDD2kZp7UmCC5O6eLPzUfAT8QPXavybbwj+IeLLse4s3k1jAscdV0bULBp1EJI1ZZGRYAjJ+UHz3uRPsl5NdH5nB3PzewXK4OLmMK20oY6omdFuKuwija2rMFA5E9cSOPUB0JDEDU/NmweMVyZ65vHhYgJq/nUfB3hIbJD5B+TQLvF9F4iRqJr3+Wy0hrSGlQfTAJMUITzHqAFovbaRXXb/v6gF140gpShnOGNjxdJIrWuFjmpo1yXGsZbJB4YXUTMdH4oET7/cPIqG8vnjrkuN3bw+JXaNyNj3YPwOJYO9x9uekANX16laweDSIeJeygb64OGoJAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SA0PR12MB7480.namprd12.prod.outlook.com (2603:10b6:806:24b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 12:31:52 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 12:31:52 +0000
Date: Thu, 16 Oct 2025 09:31:49 -0300
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
Message-ID: <20251016123149.GA88213@nvidia.com>
References: <20251016054204.1523139-1-tzungbi@kernel.org>
 <20251016054204.1523139-6-tzungbi@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016054204.1523139-6-tzungbi@kernel.org>
X-ClientProxiedBy: DM6PR17CA0007.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::20) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SA0PR12MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: c8c09fb0-1f29-40f7-4c18-08de0caffc51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LhRZGuuvV4ofFuS6hsmcYdHajR6iYyMcSgtcKkQTTur7shXrM03jLs4hhbL9?=
 =?us-ascii?Q?D7LAeJ5uCNFt72++JwJyBHmi37pRoPWeee7v4OSB8j0zlKq8lTDMrVwaqyJi?=
 =?us-ascii?Q?vLs8XQDF/rdQk38a4lLPrPzbprSDFKyLG6q1adpgnnZXweM/OWwF3GvNzT53?=
 =?us-ascii?Q?VVGwlVNgaRGSJ/0L6kf5k6s1hNWkLNCU+ZlTdpa8H1CdTZKxOTG7pPjQtu0s?=
 =?us-ascii?Q?D7U7vR/yTPRTgVgQtCaASbHZCRKdPRWfeeW9UAFegO9tboJIR9ecYh6MRIfN?=
 =?us-ascii?Q?toX5XChVeQG/gxdpr9CGPS1oiWMA7Q9z6lwwLvcB9lXUVKmyp+dh0Ic7b83r?=
 =?us-ascii?Q?TyYbdlOmitOOdriBE+XtulXXnSQdRK47Ep5dfKFO93vJR/sv65fCAZA6XEAB?=
 =?us-ascii?Q?Qq/r709mYpN9d2WjeK+o9cmnWodTDLyuY/qrx3rk/X/zK7IMbgZIDx//cI75?=
 =?us-ascii?Q?VIgNH9/6wubZQC2p7Qe5+W9q8JMzVVu38B2fBwhAA+9Iqx4dmiD3XDLUVmYq?=
 =?us-ascii?Q?2upmYzoN4qHSJS1hsus2Y9hIHmFCW3bmcjcLdnVIptQ55khWWpFipgIjFOoB?=
 =?us-ascii?Q?KYO756HDncYWEB3uoNCVFI3xUpMOkVn3AhEK+xJKqNG8QtyuWDF1Aw3c12/d?=
 =?us-ascii?Q?Sm/NPiOHQNoqHewpf8JVv6l8RSe0feqlRYBcks1uDX4bpF4MV8ERowCmdtKh?=
 =?us-ascii?Q?1/jazV6L3bt7ojt28vEv5Igk7Trg0QoFeLMEmA0jMzkkzH3AuFbeg8N5L7ch?=
 =?us-ascii?Q?YipFH4wFefrMLnJdat5pTv33Kc65LIjBegSTcYgCPXFqjn86CNvfKg75mNxf?=
 =?us-ascii?Q?3ixmQiKieKYDAUXPl0uad35dYtuZE3RdPJQokaoY95svb2rILmjueTWa2zCZ?=
 =?us-ascii?Q?xYoZzc2wfQP/YoQhV2l7b3CV9fWYbv6OB8zK7R45VOsguHP+8Y+sMaCU9CXi?=
 =?us-ascii?Q?9xrKvJyY7a8ZjDtYHGJEH/x6hzUAXwQI0qff0PuviQEQbed3wkBdiImXJ7dD?=
 =?us-ascii?Q?GgExDOSFJNHcex65RZAxXX8un6AqqveKEpDxspLsJ+9w3cIgPWslMGDJgpyS?=
 =?us-ascii?Q?CtyoDmv5SbLUSAX1nENsf51YTthuwk0vtrxcpCE3ABBy6QabRZHZUfrD8oOz?=
 =?us-ascii?Q?8+ksdOJeBnKDQ4uAUzmrVuqdlBSMPvPos3i+rhQ0i3XFgDGER26oYEzdBzUX?=
 =?us-ascii?Q?j6q80bou5T6EoVvkVX+PN1nRFa+dtpYMeUkyGwxcHyqklsDZdK56aS8YN4kQ?=
 =?us-ascii?Q?yFlrjEpn0CSgLJo+egR7n42r3kfSq6OQg5xUgG3Bs2yezP92wlMOl5bm/Yon?=
 =?us-ascii?Q?08KegtlYVzJ1911wGulCfc+CMWWPCqCwbyFezIY6M+Ca2cCyPBbbzwO9NU3k?=
 =?us-ascii?Q?9SmPuN4yaVb7qmw5Dn36jZWBLJGmnQK9t2vk1iIDcBj3H5NhPaxYJQ/X008K?=
 =?us-ascii?Q?1BB0xBe/3BuIcZlEno/FGRxxCbQwlU8N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EVmGzY/kJYayK0223ud1GEhKCB6qPzlTG368zJjQhNiYSeiQZdwdODnKc+5z?=
 =?us-ascii?Q?7hOPuKu0L070moF5dZ/vxTlpXVPIWG9YDNLekzaT7KsuevX/nSxubh3O9YTV?=
 =?us-ascii?Q?QptqOG3j9W5kKKVz1ZTGjKbDF+Dg/qubYxm/DeRgfBvduf2FeYmXA2BSCFr/?=
 =?us-ascii?Q?mXVNzWRu5CUPsfyThxw4Q3JsDk8YXah7v42GCHk6YQ8apETrQw6/O0hUZaC9?=
 =?us-ascii?Q?AISJqRpD5Az7IFhexcbOelgSvHz1DdZJPhm2xVEGQYx4madEJozjN4wdsyV0?=
 =?us-ascii?Q?Y5DQAy/b+9t9fEbuVg5P+RuxzojIecb+Fbt0OtUP43uRwQeEUdVXmLpAwNKx?=
 =?us-ascii?Q?VW8CS6HwfkSB7MuNzcpMr38ZRh3qqBX1keWeY4ibYos/0wkS5xdFrFyNBvI7?=
 =?us-ascii?Q?CbsDUBSTArhK7SbNm/sGU53cFaWXL5L2VaqRQb1/n43L4vI7EmZhHD7HXsUl?=
 =?us-ascii?Q?WYoNiAUaZ6f4XsvsLvN0Nx45mw+8nnvuNoy3Zk+dwscDFLRzvikpeQpzkCgi?=
 =?us-ascii?Q?6p5n6eTn0lmdqydumq+t+C6hqdPtmN/i2yuoJDWwqAokyQ6S91L6V1Q0vj1L?=
 =?us-ascii?Q?iOdQxgSOb4KsR/XFgNpOenXtKqYloM1vsZGgsf2Z9ofvy7IFEt0uR3CTwEig?=
 =?us-ascii?Q?q97uzD2dfNp99xcQ9yw5JFRwRPcohE+FwQGOdqn/VHvBEt5xtuwdrL7gJZvN?=
 =?us-ascii?Q?uDBJrMSYmw5JFqE8LIDU+QhWJWErgK9DTNEKlsO6aM5ZSvt9BoNssBok6xIx?=
 =?us-ascii?Q?gZ+qh8fSH3nxslCOynch9kFAqdvun/mT4gVdAQaZkU3Wdpl0Ix+yGCCcLQai?=
 =?us-ascii?Q?PC8TUsIfrXv0NIikPMxmfate/OlUBKhS0P4IjfGkRVnZwfip7BYR4Ansujb1?=
 =?us-ascii?Q?xOLyUSdfPjIDhnflPttUdSRaOsxVP5XUPar3sP2kY6Ni4RxhiIZ0VyR3jN0N?=
 =?us-ascii?Q?zl2boaj1CZgx69nYCn6zNEvJn3gNEN/GiVe0ivwehjQDuIQLIMRRSoGOPqxW?=
 =?us-ascii?Q?Zp0L47H6OMs+qfCPwM2v+fw+LlhhmafAMp/2H3ychqQW2nP7rcHKqjrIoSGh?=
 =?us-ascii?Q?hnEMgz4D0bDhQp3gFEci+TSmwnUilRIO+w1MASsk0izpKulbSR3Kl1SBTyBt?=
 =?us-ascii?Q?wP5XAP7e/ZoRaB+EceodotKiwI96APPcD4Qirhsu8gITq868YKpWKqit9MEj?=
 =?us-ascii?Q?07pXhdSAhl66smdzDPsiXt/HzwSMUT0h6vCyoPq9JubWntK6xkFjhG51mqJH?=
 =?us-ascii?Q?syWw1ge2DdVSyREDwLYVPJIo0Otb/Aj+gxIH2oqnnIr8yeOUUMX90g08y75F?=
 =?us-ascii?Q?MZGHDWEeRUNvRhDQm2CogSdE1B/X84a6+U3gxHWlqCPiYwNVjN/D9LWGa7fI?=
 =?us-ascii?Q?UXh2u27mb/Pa5w0C4xZgMt47Kg3Ihng7E7r7d31BmzKAAFPyzw/bKOou+gBo?=
 =?us-ascii?Q?jOYmm4Q6hO6WTVutXdIptxPM6wGlZGrcsys4JZjQsalunnA0Jq/97To5LRw/?=
 =?us-ascii?Q?pCpCmxHXLsLwaddC5D50k5MrECXKriWQxTdK8QBE+yOYfBYCVbcXqEG/WSHT?=
 =?us-ascii?Q?yEMLwECmX7qYocVQR4unnEMymTnx66FRbg6OIG6K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c09fb0-1f29-40f7-4c18-08de0caffc51
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 12:31:52.7238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+rDKT9fOjHh6V5/YT4TaKei+EGs4qjmE+aBBpPcOtvBvwNxfuEkltSlbqR+e5RT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7480

On Thu, Oct 16, 2025 at 05:42:02AM +0000, Tzung-Bi Shih wrote:
> Introduce fs_revocable_replace() to simplify the use of the revocable
> API with file_operations.
> 
> The function, should be called from a driver's ->open(), replaces the
> fops with a wrapper that automatically handles the `try_access` and
> `withdraw_access`.
> 
> When the file is closed, the wrapper's ->release() restores the original
> fops and cleanups.  This centralizes the revocable logic, making drivers
> cleaner and easier to maintain.
> 
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
> PoC patch.
> 
> Known issues:
> - All file operations call revocable_try_access() for guaranteeing the
>   resource even if the resource may be unused in the fops.

Why is this so complicated??

You already added a per-flip struct:

> +struct fs_revocable_replacement {
> +	const struct fs_revocable_operations *frops;
> +	const struct file_operations *orig_fops;
> +	struct file_operations fops;
> +	struct revocable **revs;
> +	size_t num_revs;
> +};

Why does it need so much junk in it?

struct fs_revocable_replacement {
   struct srcu_struct srcu;
   bool *alive;
};

That's it. When the caller sets this up it provides a bool * pointer
from it's own private struct that is kept krefcounted to life cycle of
the struct file.

Then the ops wrapers are a simple thing - generate them with a macro:

srcu_read_lock(&f_rr->srcu);
if (*f_rr_>alive) 
   ret = f_rr->orig_fops->XX(...)
else
   ret = -ENODEV;
srcu_read_unlock(&f_rr->srcu);
return ret;

No need for all this revokable maze to do somethinig so simple.

Also, I don't think srcu is a good idea for this use case, maybe as an
option, but the default should be to use rwsem.

Jason

