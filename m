Return-Path: <linux-kselftest+bounces-16271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB43895F0ED
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 14:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7201C2383B
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 12:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561D5188582;
	Mon, 26 Aug 2024 12:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rUrlgQNB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC32816F262;
	Mon, 26 Aug 2024 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674092; cv=fail; b=VQG1rroYHP7tOgHWDl4rMB6T/WSE+trgBv3uQurGgr1hH4Qo+Wp8KZv3nRtd0rYgvxCHOlIof4XucbQ7VdaZ22mGV52C1qOOqPheLX5h1wj8NevDuK1MFqwRXiotj3yvw28wU9Vy6flieSAArDnWGLXewKk9seUKgQvZoIfc/Ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674092; c=relaxed/simple;
	bh=HQVcmvE0Wbrcp0tFRDM2pOeArS0NsUkNKtaNebC3R9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K/eo2FRUJWpE5msmb+zz2aKKC5ODRALP4vVaUQlnitnzze5g2QWBzfQPy7iRDf86puU33ImjJV75AEL7uhU7hPq/xkwSUdXu9SBfFf8ZVyV7BkJK71ZISD9Ew1v0Rwp3R/LIfUMlfikkdwyBU6mKGAwa6rHDFhNDZmA6OhFcr4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rUrlgQNB; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=peuupziuF7Njtzqf58/fUBoC4AEjnhnQu3Kazz0BG07RuJvas2DFEW5WqCBJtR9aYrSir2lKpWYNUDn4X/dfT843C5XCsjFANLXNO2J+47aTe+c7f/Ckj6XpRbUBHRIwlPlV1fuPLHDX6VQQBToHhpLAc3r7u+1Cru2GKH6rVcGp1jEYjkEBNiKEdUaSMkmz0Rf8PpOLmydlOu8WBClEydXg8w6RmQSjy0U3jANiYN5pzGca5SzcrxF8pvf+j9olr9yDi31tVTd/8eX/rNZD0aZ4VrdA2HQynaluaFSwSJguLIekuhgqd+ll0iqtfmJs8YM5jXPr2jszjOahkR8Bpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0zF8PTK/E+XyeetwMTc3glydyq5vZqc3hzNcKxsgIE=;
 b=ga5cPcOKFD3AyRDS0Gdsj3j2+2bIyimAbcaS0ndu0rlJUUc6d8rvgP+oXMkTeZ6kWUvEwHwI63HO9vZQks7mpFuyO4SnQSMgHva5YD7yR57+PsjIOfDfIxshGUX4uV5ZA6f5e7nl0zWrtKlN69NoBCRrikBBElStBkmOtDWYNN7T2pIqepOzOwD4p3q3+GBQ8XFT1UTHhnTupyOMIXMu94Ykx0dEfOTH8BAUjClfY20bM9TOVX2Fbwf3zbmjhNhPI/78BVtNU5qNvdp5U30X3qoZN9Sl713zhg/JkGMpoinjsldQ8WpGDcznmod7LwvQSHJ0SzrTZVxO5Yl3Cg/Cuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0zF8PTK/E+XyeetwMTc3glydyq5vZqc3hzNcKxsgIE=;
 b=rUrlgQNB71A83JNODPVepQxYvSfEXAAKtHMU0KfMny/PlT0GjQyrW8VyscgksSx8+4UsxdUGU9nRTZXNgxRrERfqbus6gcWQwpN53yfifH0AMXUUK1sZWeq9EPBycschBxIcL79DsYJg2QJ+nuVY+X+YS8TEyvLmGgz0nAQnWegYn1laFDyOZbteT4dTsRl97mT5YfSPEHRoirJoRGtvujbJOhv8b/CAN46o5rhGiDqFdKMBzv8NSAQ/lQcIfOQxNJi/bHdQYIVVaE35JL4T755iqYrzDu86cIFC8FAnEoIVriM4pliEIPYfbZbviIJNfodZhQ/9Wb59xRY65R6yWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18)
 by DS7PR12MB6045.namprd12.prod.outlook.com (2603:10b6:8:86::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 12:08:07 +0000
Received: from SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::f7b1:5c72:6cf:e111]) by SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::f7b1:5c72:6cf:e111%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 12:08:07 +0000
Date: Mon, 26 Aug 2024 15:07:56 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Amit Cohen <amcohen@nvidia.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, mlxsw@nvidia.com
Subject: Re: [RFC PATCH net-next 5/5] selftests: sch_tbf_core: Use defer for
 stopping traffic
Message-ID: <ZsxwHFMY4WMjbDee@shredder.mtl.com>
References: <cover.1724324945.git.petrm@nvidia.com>
 <7dac3bd8f776741a9816efb03c672c4887765ad4.1724324945.git.petrm@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dac3bd8f776741a9816efb03c672c4887765ad4.1724324945.git.petrm@nvidia.com>
X-ClientProxiedBy: LO2P265CA0307.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::31) To SN1PR12MB2558.namprd12.prod.outlook.com
 (2603:10b6:802:2b::18)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2558:EE_|DS7PR12MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: 75e71342-32a2-47e6-9531-08dcc5c7bf24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rkNSr3+O5CU8TkMCrxTsY1KJD+QP5W4wNUunwa3jipIMp6bBF0E6sJ7+yVBP?=
 =?us-ascii?Q?JesES1XQumkcai625nKNRys9RJSBCa/ZNT4pjUUWVABGLrzvxtC3QZ1Pe3Bq?=
 =?us-ascii?Q?EgY2O1D4aHfHykPK2nmMgPrl/iH+fVtBP+Bge9pvLkFMEcX5FpytedPUNmdo?=
 =?us-ascii?Q?A4ZVDPKIlzDqe6yrV8xUJWvWi9UtudgMQr1h9P0zhe7/MkKLkHi6h5AS913l?=
 =?us-ascii?Q?AwurEFWgI4XalnkVqzTKBUiMKJ3ZmW1nNgil8hQ6Xo6PprNppsiU2MHyTpm6?=
 =?us-ascii?Q?ms1KtB3FXNuQJsxg++TxV7w/T2+uf6BnHZ4IAepXBEK7N1ejmrVw0q+RV7VU?=
 =?us-ascii?Q?+J8sQxErq4g77mpjL0mPv7qTF2NKiY+RfvuSU6N2+7thR+KSR0KS5lfQBqot?=
 =?us-ascii?Q?uqS272ip8YoPPhChguox2CTUNGnJTGJwn7Ujqp/xPZA1x3dEEnwqnubLvMfl?=
 =?us-ascii?Q?nw10tN2ES8RadQeQrg7g4ydVZ9YN7AZ3ev+hLNOlMMdUfO5rAQRtHp/hQnKQ?=
 =?us-ascii?Q?61jkAXa3ZOEM1OCyl/ytY9uCKGMMUomWr6DBbQsomGw6NxGlyZ+p3Uq24rop?=
 =?us-ascii?Q?2uULs/XsBNVUF8lyVL1wuwcGBkP0kVw69pvx8dtFu+Gj3zZ5IWGfXNAh38RU?=
 =?us-ascii?Q?YOjqsWG60Wc/YQP68fOb7i/DTYS18+URgsLH9lD62QMc814IoNxaIXsIv1HY?=
 =?us-ascii?Q?9mnhTNoW96zbfwQWjLIh7Jt3VqQwInaHp7gmNuAE8I+wcJ9uHK5d5+QxyDyK?=
 =?us-ascii?Q?NSengHq0W8pAgj3a4/2AsjX/yoTNfWDe2mufjWr2P8gP9NNZQBR9qBFExKtA?=
 =?us-ascii?Q?YzdWR+TRKpOa3uW3G1HOxHG4f1UaopQVQnoTeF4Mx41uC0HKw6bgoVJ2+xkF?=
 =?us-ascii?Q?borJvaHqAWvInsqqhZx7xjZ1FHFt6pcV02r1OJMHj+/WvAitH30KMsr4ztGK?=
 =?us-ascii?Q?MKR5swYPFY7PCaw7SupC5LmnnEsh+G875gxpiY0WHHqpHZdQmLuZMlQgQws9?=
 =?us-ascii?Q?KvTGyX4evRvhNfLY3BzFijef/1vzGxYUifVFmQlHzJXNvibongcS+S9VoYc8?=
 =?us-ascii?Q?Nv2xlHRoWZrkMzFgEDKg620dp/vj2MUbSMMEtBwTG7Kw67bPeOHCDKG1+jrB?=
 =?us-ascii?Q?nJhFhA2YJ9CBuHWfqcZRKr/WEhrEiQt5EY4cqBi20MNOGAU5tmdKz7h/WeFu?=
 =?us-ascii?Q?vW1fWxiJ2H7LObTmH0ZVEMPvd2g4IcaZ9KbeLpS7wHbCgRTHRAucSMz/1/Cm?=
 =?us-ascii?Q?Rb91KdZWmPbnLjZAN6HoL2wE+aqaVpYHfh5gBsMJlxiHNxdmx/B2mlyChiGj?=
 =?us-ascii?Q?LXdBz2mnPG6Tel/6WicqLqtMbLlFoe9jsiOVj1d+J3TIYA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5gEBvQFTUnUXgoUQW8IIFI2wxDvjs/FMUrKF7M70gVs1yTY68INYZlVrbKcG?=
 =?us-ascii?Q?Kl57gUzaMCgYILaoU4FEuwLzsmigker1Tc0ZukEkeHbk3JpE8x0VXUCGMCim?=
 =?us-ascii?Q?LKvWHq4ooxoO7ohfOOE/QnlNoHu6kjtdjZ7mkPfcywGF9TFSiJV4ajGF/LAh?=
 =?us-ascii?Q?hI5b7gcsqlFjqxYPASgfiyFhT4YQfL5XbXRJslY0fIOM7HVO2AgSo/PcuUGS?=
 =?us-ascii?Q?69uWoq78t0qKVs7cckybD6paRFOpytuICGWBdxGB9MaS7/WHROmzMYoFHkbg?=
 =?us-ascii?Q?xrIajiB41982+VnjGRTFK5xcl2y1YL64kVl24+vJ5Ck6QMQtvNGt3lRGWdaF?=
 =?us-ascii?Q?yPsUFwGmfIYrqAarw4dY3XvJgXOFooWukcCG6upJRUuBDbhSgbqhmRISW2OA?=
 =?us-ascii?Q?E81DA4QnVKI2CWUpOpxzg0O8m1qz/j1+hPDaYMoD4GGh49f1B/ot+RNlaXDq?=
 =?us-ascii?Q?aQ3Wyk11pudI+yTjBK14yNI7lNTu8BmsEIbhEESTRjeqsTUkYmGanlSw6oUc?=
 =?us-ascii?Q?AfXGiG1xnD567NYxPtRraXEmE4WvXymJPl6VtoYj7fasvncUY6U4IWDqjV+I?=
 =?us-ascii?Q?NAOfZ8dR8Q19tq8aZDHoX/cjQhytXBRY0gYsB4LYcV0KJlBqsUGDEkvtsl26?=
 =?us-ascii?Q?GWk/uGjsVIYr8uiRdNtH2shVUjTyy2t5v59edbojYUxtNS8EeVHL/pyqziKy?=
 =?us-ascii?Q?y9Ae699bD0E9rzui8/MJqjXbnoHxgytv9xNHAUArkv9ELB3/jv2ZZfB92ID/?=
 =?us-ascii?Q?dBpR35ReaM0l8QEiJ5MElOpLYIIBl2wT80WCY9KTU7SaQX5ssnaSXr0jAslz?=
 =?us-ascii?Q?gTjO7zk74RAIKwc/iiJ4MMbSIJj3EODk7eHlKPgQMv4cu1EiJKYTPLL+8ZQo?=
 =?us-ascii?Q?G6JqIDviMIJOdZOIJi1EAusfLO0HdV4xF0lcnQogm0gofRwv/lWBCGusnvge?=
 =?us-ascii?Q?u/mkG0QSW6DFltezR8cL40sM7ljPU3xWk1+CINpDiIU8XaqlPU6iiTy++yHw?=
 =?us-ascii?Q?eHUqGvww3YoY4oKooFew9g19LTi3F9amGrudVa3fTT2SwP8vQvPxMRcqMP8N?=
 =?us-ascii?Q?q6biBB6anxXtPqkBk8LPJiQhB0PcIIpCWvte3gWcApD9WvZsJsOy807lC1ry?=
 =?us-ascii?Q?DP9j2jKsrNmtgFTisT4t53elPj0y/bQQM6Pfm3R04PJLlfcf9+Ixw72HcJOD?=
 =?us-ascii?Q?Y0gfrNOZUamrMMChQ3ywM6lqVP04/o+sHoIeUG/kg3hE0dokXV/iSVQSxL9v?=
 =?us-ascii?Q?cfa8OZ2cW4iWyQUoH05RxtU+ii2dVMSwZsp6yrwi6PYrTr8mDqvMDEBmHOpy?=
 =?us-ascii?Q?2Gj2QbEBk9AIBCtJHBCbvlIvsgci3TCTijc7bVtefhQDeMQmEk0XsHJvs3ao?=
 =?us-ascii?Q?Ry0fqvXVH19CsJYgZsuccJSoGGw+6NkDEBxiEVR34GLkFBYnwo2296cuTQ+R?=
 =?us-ascii?Q?wNdFVLwJF9c6NKSSQg47eM+DpJy4eB1i70iQKllNcBqE6qPadd1vhsL58UF+?=
 =?us-ascii?Q?Ik61tJwYOV6YPbgYj1w8ndHqsJa7kIVc/HCDXoR/XCwmzQ5wLEN2IR/fbz7y?=
 =?us-ascii?Q?ApOtrcSv8rUCat3A9zhzXv9OQSJhEEHWI8cKiKEe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e71342-32a2-47e6-9531-08dcc5c7bf24
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 12:08:07.6759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FNVXZu6KRDUQZmqKuDM8DlR9y9QfQkwA1RyVWnEgGUWn8VWbp1gwBNQfdo8pYrdXYsGH1qLEIoHVY9/jSmpySQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6045

On Thu, Aug 22, 2024 at 03:49:44PM +0200, Petr Machata wrote:
> Tests interrupted part-way through leave behind a running mausezahn. Use
> defer to schedule a traffic stop after traffic is started.

Any reason not to convert the setup part to the defer mechanism as well?

> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  tools/testing/selftests/net/forwarding/sch_tbf_core.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/sch_tbf_core.sh b/tools/testing/selftests/net/forwarding/sch_tbf_core.sh
> index 9cd884d4a5de..5d58c04e055c 100644
> --- a/tools/testing/selftests/net/forwarding/sch_tbf_core.sh
> +++ b/tools/testing/selftests/net/forwarding/sch_tbf_core.sh
> @@ -213,12 +213,12 @@ do_tbf_test()
>  	local mbit=$1; shift
>  
>  	start_traffic $h1.$vlan $(ipaddr 1 $vlan) $(ipaddr 2 $vlan) $h2_mac
> +	defer stop_traffic
>  	sleep 5 # Wait for the burst to dwindle
>  
>  	local t2=$(busywait_for_counter 1000 +1 tbf_get_counter $vlan)
>  	sleep 10
>  	local t3=$(tbf_get_counter $vlan)
> -	stop_traffic
>  
>  	RET=0
>  
> @@ -231,3 +231,4 @@ do_tbf_test()
>  
>  	log_test "TC $((vlan - 10)): TBF rate ${mbit}Mbit"
>  }
> +defer_scoped_fn do_tbf_test
> -- 
> 2.45.0
> 

