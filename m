Return-Path: <linux-kselftest+bounces-42076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB979B92799
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 19:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 867407A29E5
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 17:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E406231578E;
	Mon, 22 Sep 2025 17:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JWT1oMyD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013005.outbound.protection.outlook.com [40.93.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75299310777;
	Mon, 22 Sep 2025 17:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758563341; cv=fail; b=k4V+Mk9lZT9s9JQZxRtZ7pDOX6Z74Ef5pNhwqc4Wv9dyHZixAsN/WiW2KlEWtJgDe/sXYM2Co6ZjqHdJMzz5Tp+M0O3mzJ4iUS8+8ywG3X5ycQPLJy93JbrXyeoszsmT9Bsfkei0TYL82qn+3vX0csumsEUWzZrh/gSYLiDU2aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758563341; c=relaxed/simple;
	bh=tZF9Bh5hYnH02u7GlZVYLIIASDgxmCRlo6mQAaQ2A9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i7wFAGj/ZHpurIQ2uFBLdIOVSwBACDjL91EJhNd1yKsHZjIMepzwThWj8Zv1yLx0EGRQNel1Mk03W8TjHdhlZQpkGStDBHva6C9VUi0kuePpBihfEKMh3zzmftfpaB1HjbJT5xoKje0lxkhlFpztLFFdBt5Yhg18wA+FsGaRmz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JWT1oMyD; arc=fail smtp.client-ip=40.93.201.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNKBWy3u8nLO0izvHaL/9XeVLPNGxmBvzLwxNlCLHqosOL8Sb15FEZhFOgCqhIuCp11yeiusNMy7h7DpdOKiBwaWKV5IsZdBXPwVAE5ZlkEymvTFyRAbtyl9XlpqaMYh8ggZAgkT1/MOroql+s10iUyU1Ffo98GxkmNvAZ7M9Vm9O/HH+N/gtMO1rk3o/cpSpgK/DwEdqYTQJCfL0xNHNqmzxwdclW+e2updlaDhlXKYNy4u19BXCKSyHr7LKWQ8eTPpqhBgR9GMmpumxyNhOck4Sa4Ic1+LJOLwb8pRNWAnLuXtS+s4GuoQMeM+WOcQbn+DiFNVVNUGtR3buuLrbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncXDWwRyDLCUsZoI4irnSjJn9rmFrlW9jCFdhUA8oFg=;
 b=SMaKuN36idiq8hEMcCrKMSLaQw+oGwceRI51/8Ex+zwvJVrg7pTSndW+8hC2a485vAHyb1rhGhkKIDicvJbXr394g2zvPcDZfDjM74ptcdMaXAVBE7UPhwjINE7xk6AqPJy+AYYVEhnWSryBDB39+5WDcPqRNkL2Fe5aQJ8ZZbLesT0OrYqBd/+9OG6Esw+o29TctTDrsXRIDeGr1gLf+irn2sDMG1HIEiVsZBZUa4L2o8px6O8f3HhNDJ2THI+dJp2yYCefsMXwFFmRmOtuDmZjMhbtu/UEJnMKC9Hggb6JFLCwRL4CGltTxd5J73/pgqXT0qSX1nzLbRPvNs9uUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncXDWwRyDLCUsZoI4irnSjJn9rmFrlW9jCFdhUA8oFg=;
 b=JWT1oMyDaWrOuGEJoq1ovoSZZIqP7yCcRZPMD5gkkWrzvDwJQVAcDBZ/GY28csDfDQxeBel/FvA9wHsf7iBcUpPCJhKIiIlu5PP1iNKDMKi1jUVPx4HUiIBhYpl4QZLF0OeBuZEU1jNpfNqSrCUluiALLNyKv8UtAnyMnb7+yUenPDuESnv70iBNhux/a7heoSJl4xldUDPVHX5EsS+Q39QObRWz0BQNrzOmfix4z9luSPE3TntQR1OWryRKzVPm99TuzHv8E8VA+wQHrKaU1a6ncTOrL3lBc4Weo87I+1kfb5EmtI+1viSx5A7eLEeIcS6dbCsMBa7rm19aS2vjtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by DS7PR12MB9552.namprd12.prod.outlook.com (2603:10b6:8:24f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 17:48:58 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 17:48:58 +0000
Date: Mon, 22 Sep 2025 14:05:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
Subject: Re: [External] : [PATCH v5 01/15] genpt: Generic Page Table base API
Message-ID: <20250922170553.GI2132010@nvidia.com>
References: <1-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <11743f88-7cc0-416f-acb5-807c9b9aa1db@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11743f88-7cc0-416f-acb5-807c9b9aa1db@oracle.com>
X-ClientProxiedBy: SA1P222CA0112.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::25) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|DS7PR12MB9552:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e24e00-7fe1-4444-2b37-08ddfa004e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ief9zGC9zw6HkdyM+z5RYszCVDO4S2ARNU2+FLtmeIYoEzgPqOVvPdZMUTt/?=
 =?us-ascii?Q?Ycum8YXQQ8Ey3TycH8L/V/1wrMkQ5zcsnjihgGtWk3QNJhEJgNs7SAcRn/Ks?=
 =?us-ascii?Q?6VhFkfZq2leCRcrMfbATQh4DOWO/VM1xkECqTBNWUQsl7zMIL7UVIKkx9WGh?=
 =?us-ascii?Q?PR+vi3lUbZ5P9+W1nOSkHJz0JZcKS1ogXIgsmc7gFZaSXsa/9XihvwruTMaU?=
 =?us-ascii?Q?LsrfWpDWvpEplWkVZ/Y92nfVFPWlFrUGdsnWcZUflixEUrlWe6JVOrAjKwNZ?=
 =?us-ascii?Q?exq0mH2WX+F42HoCdqBiE9mfaaswBX4brInvEGUAH8twsRvfr4ssY42AhLzC?=
 =?us-ascii?Q?dMTweLR9bNvGuJ2DQPDHHFXZbF39If4PsD1akfwOJ3wP6rh4ouU17RUmSYqR?=
 =?us-ascii?Q?s9t139Qr/JeRCqL2Cmr1aCByYbTsuuzKJl0p1r8a/30bvZRpO3HQ7X3W+KDY?=
 =?us-ascii?Q?iE3qXVjrLpQslsh+XBQNEP1NUdZFtCzRci4cDPv6xFk43tIAYc+wwntg4MgI?=
 =?us-ascii?Q?2Qo5sODXjUDqKtThqn9VLrXYq7C1jhsg5afhZLWGGUX5Jq9H4S13RnumGLls?=
 =?us-ascii?Q?hZ7mSDYLjyvxKGodI1hWRWRGO3pNutdDodtCjgCsWl+dvYkjNoC5qbDfbU+q?=
 =?us-ascii?Q?FhiVniEGEcKXL2chb9aP2miZ/oBrHA+w9eLkUb97MKiqnEbPR3i8YsdIZ0dx?=
 =?us-ascii?Q?+qR3v6qo6Wp4+5vfhZoZR4DmaO0Q4Lk/kA8NSdnbST5vBPBWXZsYYluBpIsu?=
 =?us-ascii?Q?HcfNDTl2oKNUXV4C5UGWTGVgWj3hMj/hSdSxLQdbYFFPWbHa/SZaJKA1RU8e?=
 =?us-ascii?Q?YqT3IUCc6RzALwveFY15mDyyl952I7JHGA/ug+abBlkuFgSoWx73uNRzZLH8?=
 =?us-ascii?Q?TIPspphLEYxvd3J98gDmLZvxa5ugqDdXaAxFdgkHnLW0H+fx5ZF+5E2wqNTk?=
 =?us-ascii?Q?UnfQLr2aCH/ws0Ji1hmcd19wXE6y/i83T2aOZJSsHpJERp7ngzrtTeE58jIl?=
 =?us-ascii?Q?JA747ZYUNqIkgU1iv4QHD7YEU+wHszAYotFrNCm83S7mEiuna1u/ukQB1ghz?=
 =?us-ascii?Q?kJicdWltm90e6lK5dSGFgTvUA0CCOXiBvPrGkSHYEO1RBRCpsYw7zQYY5V6g?=
 =?us-ascii?Q?jWo8evAcDA/vI8gZyODtDQOHdgG8oDR6Kew7mrT3xqFGRY8t3N2tVoH12V5e?=
 =?us-ascii?Q?frYNzZymtOBBqX1V0m2xEeFSSSE+R1YTW67HaFDIRefs9KzqQYPdg8ggX9+h?=
 =?us-ascii?Q?SSJXKQBYx8LDQyDTYNgI8ofOKJ6gqXJ+sIoAnirGqd2EbKJu2UHd68fH8lx3?=
 =?us-ascii?Q?hpqQ1NapLEhagP6KhaKiBaJ7FFTjUqS7Ml1uB7jNgmZyt8IQYtUd6PVCM0Fi?=
 =?us-ascii?Q?2E1XwcqJpQ3KjqF3rZYULKKomgVQ1VUiKjgeV2x6K7qtvDgAMXTzEaONVcQZ?=
 =?us-ascii?Q?dL8Px07Dr6I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NTmepQJYIh0oNYZUVus+0w4ZV5KvU03Uf94E6BJagd5zEz7q4KZY5AwP7y/P?=
 =?us-ascii?Q?Xg3Jkv9UVH3c9ezygg82ZAReIn6CNYw3H2ef9SDPr63kdqvbaYCQ1WPq0DBY?=
 =?us-ascii?Q?QY1EuGetOUfIOiX+6okDqPaNI2MK88icx4ZoBFcwxCSjSDpCs0Uee+AjCYV6?=
 =?us-ascii?Q?yWfLshPfwuPwASK8POAvBgArHlN53qz7suIEYyV+7LWhjXShasrGngu25oRs?=
 =?us-ascii?Q?9z5II+pYpTn4TuJZG+P4LtqtYYXC5YwrkYAbAvk0eLa0V09NxNNXByAyKLmj?=
 =?us-ascii?Q?aARyDD2mjjNX9YkUe90GRs/19+2wBX7za/PgsHZF/HqucMcCuNPH4Nl9JFlW?=
 =?us-ascii?Q?wrJAmm+galXRIj7qKpIcEkeJg7O+xA+x0VO6Qj3GbG40fYGdCz3xlVxQ7D0/?=
 =?us-ascii?Q?L5zh7Uqh6rYI9O19ePr+EZ94GY/YIQdLibCPrPg6vmT8DzLSNoeH8gfI3jZB?=
 =?us-ascii?Q?2pPFo0nahnqWaXRWwpRGTgJzfsxK+70g+gfWEt5Sk4De4mdtu5sEZgyR7IXv?=
 =?us-ascii?Q?0iODoNKPrLmLzDLhR/vKpCwUQ8nKIUCWuKe7heBfGe5E2rdNjFE1+9TSeUVq?=
 =?us-ascii?Q?gRtro/SEpy1ZCMmxSsZP8EAOuk4yQacoabtH/rjyPSQLAt+ZfW+LCyW1ovZj?=
 =?us-ascii?Q?DoeOXDqSH65II5ptVT/8sJRiroXwQl3P3MJanF5wHlEW7c0TL4HOK1kZBuX+?=
 =?us-ascii?Q?wr9V+tkoO0ndmo2U0aUKKgJVgzHVSG7afP+DuxrMe0mDfmbqejDpWRKZPlu1?=
 =?us-ascii?Q?9T1dY3U6FRpismo6FHylmUM9Wcyl+UyGb0Lkn4qrImuwPrPsXEAd7FmBfgA7?=
 =?us-ascii?Q?Rk1K/THYtIUcW1jxeL8TL7Cr24GV2ChZY+dFk2XSybXF053o8oEAGVeTCSkT?=
 =?us-ascii?Q?bGU0Tgwir+SufBIgOdaMcskK+5R88dc8YFGXhOD2dxEpwGi6eo3fvAG2tosg?=
 =?us-ascii?Q?X7UXGEV3eONCwAh5VmBVqeTsEHklLukcGxJyuZS17z7l9sAUKf0G2Nb1g5jC?=
 =?us-ascii?Q?IfCSwIELTQqFyAQOv+NzrwwrXTJVjtXqMdLjWDNKGBr0OTaFG8vK4ExTf5Dg?=
 =?us-ascii?Q?LV1stHO/ZKYBEsz0fBLdwgvbq45MgNwM+R0sy8SbTJsT0vv4zJswsORZakpg?=
 =?us-ascii?Q?80tjTyOAYMzlXlx+j9a7HmEoJb1H62fgHqSYFIfXXY4DyIozSQZsr1Gog5ZQ?=
 =?us-ascii?Q?yMvLK+2+clpIFhYZcwCcihJkH55QR/+GSJV5k0PBsQgIJGRkIk0Zd0EfyiCA?=
 =?us-ascii?Q?0PKB0E1F8P2qHl/KQM7Wc2c5RVzx9Np9UurNdeWo548kOna74PHbFm+ONv4U?=
 =?us-ascii?Q?EN5DGlQ5tuwze28WRvTesTcRoB1ybmGkUccOwSSVOo2u9zqH/oo9fRlE1jc7?=
 =?us-ascii?Q?NYtE4rq1v+S2sdpdeRhkE58JqoY3EcSqBp3+TK1rOnTAKkrbqhIHO4Y8OKPI?=
 =?us-ascii?Q?qtA50ie5uclydik1tZqT3/K2VwAG83UCOSgLFPc8rWK8Ue1iJSYWHG79XtRy?=
 =?us-ascii?Q?IVlCR7B0jPvobIO0brhmDDHoR+vuCeztQazf0NE9U2ehqbFwab8F+U3geTFZ?=
 =?us-ascii?Q?03340Ww4qRPxslr2PqLNBAijJtmLlYu2m+eCIhGs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e24e00-7fe1-4444-2b37-08ddfa004e79
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 17:48:58.1378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TE8jwJSbNrhCvUdyErak5gIWTk68ckdooAtwZBpv6bV2Hqp23M0SZOsgzNpS/qFK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9552

On Mon, Sep 22, 2025 at 08:15:45PM +0530, ALOK TIWARI wrote:
> > +	/* Choose the higest bit <= best_pgsz_lg2 */
> 
> higest -> highest


Got all of these, thanks

Jason

