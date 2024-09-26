Return-Path: <linux-kselftest+bounces-18424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F1F9879E5
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 21:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE471F283D8
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 19:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733CC17F4F5;
	Thu, 26 Sep 2024 19:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EYtTLYIS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08083170A3E;
	Thu, 26 Sep 2024 19:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727380719; cv=fail; b=rTxDwYbAuAmOJazWYLE20P7s1a80jpNBQTQGbWi3b1cHU5oH2mgOiBXs/jPdUk4BepFRQT+t4bMF5h974tII1ZMO2PjWy4/ISGVEGmy3dMRtaqIaKRiLpDn0TlwKYQoFgkPUieD409v8jXXWrNdrNYyqS3/fItHFfyoPRWllH2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727380719; c=relaxed/simple;
	bh=e9cdYIVP2zupkeuiBn4vvPPCIwMLVBGSmut+HmW5UA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tyiAr7rC2WikW9d/nQV3F/hJiLP7z2iHZZG7uCjjz/eWh4Q454eUQmB5TX4FRX6fK7wsNRxOcEzUSMDiKzjl1Xq9Lm8prpjhXYHr7+HX56oehfG9UCietwElfHma7+gBCzM+WZ3x7tjzHVyALmjiifNwXY1P2Un7wuw5F3D1p2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EYtTLYIS; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3xTnuySlXp3JJzDMnMLWkvzBiecPgtZaX4UYU1vAsssVCUKUGKCJSfe4m8tuSlIIQbMvur53bnurgAgvHBVDgd2ABOfDRLtYHFrPT9LyOnHMaFYidLznE+2EOX2UQhx4DP4fc82pXaYmucU9MQNv1I8jeQgwlWFPBf+M+OvzFVIGZpBDhoBZak/6JuBS7nT0A/s+FkwvKHanE0dtPs/hVFoOB4DHQusWiY7b96mN7aoK7gb5Uj5b2FIM0P4oa2RV7qdL+id6zzmNL8/bnk3S/ve17/DWjTenHJDmW963w9KSwZoTe/vR1BEeaiKnMtXSbLlkXjuSUIf5b6fK0aIyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9lCXcrvc2LnPTZYx2zZL4QDPZqUkVL6v4xnumH9rxU=;
 b=AdKYm1MG9xyj58Kal+q8v8Y5vIRORXmCIetVh3BBDP2LdphXvrytZ7BC2PQW1L7EQ8dXuF1nU7vmHsiDbA4lYAoJYVKzN7n0DivWNVjQUlFsFN7278BPKzKzbHwVNn9yAY+DYqi8Y/GQHjA3qbx0ikfv+dN+/xUSlgqepfgkrMsTfoxI6NcnfDDdjIB3oOFk7W42uJMMvNuZMaDA9kio3ZCWwQkW8RbdK7blqG4pn5fY7oAy+n2UyCSX6kTWvsa/W1vHVXRqCXC6RMD1eiYnzVkEe9Ua6vmwJc6tNdWEFpDDBOgHMJmEGurlIsUQ43WaAbHPaO3LCdWYnMRME9v9Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9lCXcrvc2LnPTZYx2zZL4QDPZqUkVL6v4xnumH9rxU=;
 b=EYtTLYISBqFUc11+BiShaQ2B/cCJRk/QdXTC/0Eh00reAE0EIhTEuUT+Y+bgpflRR2tqcMasyUAwQjVz65uqNvck9hQbe678BrITqAi8ejq51RuNSQCpr5+mgQ2ZLrJZzFJOd60jLOnviga3JovGwYibObq6iimGCYxCNCZpvgCOS1Mkisjc/dBoD5rpqxQ0nSxSUM7CakEHsked5+98OqFZ6MJEFVlLIeqs5kqvq9rU1rA2mfmiBWLis8PT5QQ370bJjAFnT5ZJVFUws0M2loGyFjQJuYYsby3RC5tIDlXObMGfvN2kH/QdTJoQah1otCekUp1eoj6+gDejj7w6gQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV2PR12MB5967.namprd12.prod.outlook.com (2603:10b6:408:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 19:58:32 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 19:58:31 +0000
Date: Thu, 26 Sep 2024 16:13:43 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, baolu.lu@linux.intel.com,
	alex.williamson@redhat.com, eric.auger@redhat.com,
	nicolinc@nvidia.com, kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
	zhenzhong.duan@intel.com, linux-kselftest@vger.kernel.org,
	vasant.hegde@amd.com
Subject: Re: [PATCH v3 2/4] vfio-iommufd: Support pasid [at|de]tach for
 physical VFIO devices
Message-ID: <20240926191343.GL9417@nvidia.com>
References: <20240912131729.14951-1-yi.l.liu@intel.com>
 <20240912131729.14951-3-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912131729.14951-3-yi.l.liu@intel.com>
X-ClientProxiedBy: LO6P265CA0007.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV2PR12MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b8e39df-0d4c-4455-40b6-08dcde65987c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NEZTWYlxCtOk+hl1osz6qWdjjZPwb4hAmz9iAAtABWDxCb1ZZKWbQ75Lp3hF?=
 =?us-ascii?Q?kdphMkdmdf9/iPGEEHxs5fdTJ8CXnDBmqXIeky9bAmtbbaF8bs+hi6C9hN6U?=
 =?us-ascii?Q?tBOEZ/6NFZbGyY1zoMByFw9vYYXmcefsFaw9rbHkG79ErzRf9HJEFeKsmfz3?=
 =?us-ascii?Q?j+ASSx8GNtOgGJYpM20wHV4nBmONZaHhrvEB684BpH0nEVzXN61iBfXVIk/y?=
 =?us-ascii?Q?VeBhC2CpyqYB8yUAGZzOA84ub9U1zse8u0ncWgSNeH2l0uPUBKpAbrAetB/T?=
 =?us-ascii?Q?CkpXQCaxXCL7Er+pE50uttmpA0n48QTgE9n6KyaDsfaMZAFSngPWkeQ/d0Ck?=
 =?us-ascii?Q?4FT1QXljkODLtAN8/P9ctFwjHhXxcWVoeNCGUrTBis+efZVkHAWgtErZa3Oo?=
 =?us-ascii?Q?p1PF0ouJ5ksCdnNhuEnnTDwz1Qc5hq9rX/4qWxkWC1RuwUcM0rvaVhMGbWoh?=
 =?us-ascii?Q?K4NxuYTPs7a7aVkp1vSFsM9kesp/hTHgTyeLApsEmuPWrTQ2bq2sMAAyZxBn?=
 =?us-ascii?Q?XD5qygp1d2kNUgdsH+v6UR+rloFc0RGVszjYKcY1+l1tDkt19jjrUgSD9PjZ?=
 =?us-ascii?Q?rjGFFH/mqkgDNEOEmh20FpKQnWsvbhUcciO8gRQlVu3pb5I+ORTDhRybvMTD?=
 =?us-ascii?Q?EY/fQ+r+gfMZEb/zXL7LdLPO51Xm89+AB4hwJM/tJrz9ku2wJlrhxllTcrbn?=
 =?us-ascii?Q?yfbkyFUQFfXCG2eCuBFusQyWNWf5zWEmT3ajVdm3O+cyOmV3Jrl0pb/aRejT?=
 =?us-ascii?Q?TImFIIq1bSDHI17oITyer11r7PxgFRTToVXRSk6ZRD590ySJSt43hP5s8QER?=
 =?us-ascii?Q?jaXSItT75O2B3LFMpaEs6KXL4TFCtCrrTTNhvGiA47kC9gE1MfYDS3j+t0aZ?=
 =?us-ascii?Q?H1mxaBf2UKd/P9ZhflMQXZxDhGCj3OBGI7/7chbxAG1hM2JO0yww3Dt0cd+V?=
 =?us-ascii?Q?HhvussxFH7a6qXwtAjh49IdNC/kAW67uiwnS1Hu9uOyl+6R4HWCn/1KoY8Ft?=
 =?us-ascii?Q?5E8SVis6NdXSR3mD6hj09u/86GkcUP3Q3TsgBNU0AY2yVPqn4MBuUpsrjsJT?=
 =?us-ascii?Q?xa1KlttFjcgr0wY2mp4PEBaIDVro/TiJuyqNjIF11kQZ+y2+ImoJZxzjl8Tx?=
 =?us-ascii?Q?BxwgnXhQVrNWpzTtPSXGU5LEoVW/Xi6kjP8UnHSxFfsZspkbZRZYCyyU5bCz?=
 =?us-ascii?Q?CrVXFZVj4Ni3yWRbVzzG2u0QyIlXKpQfewYDHeKvWfW07Z3IYEDft2EG96mA?=
 =?us-ascii?Q?I2brWBpNoHhip0iJeP5iMn4SHRvSM0aW//GxoJNCQw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rTqAsusOYTyyGuukKk+zom4KenTqFXaXu0AA7OUwq0N+yWyinPFttcUtzche?=
 =?us-ascii?Q?7DZekTS8e5535DbjktVkiovyy1GhxaUA/sQGx/faLW+qt0rMncn4tCw2l0En?=
 =?us-ascii?Q?q0OtRAZSLvyCXKP6espnBovNheAIJuo3KkSNPJ0LS2CRFOn+Fu4Gq5OK+8Zw?=
 =?us-ascii?Q?he/ECme++4adzr0FbJmNrojw/A2YBXN9N+k1aM3Ta7/7nE+vXwJSIOYjr9Nb?=
 =?us-ascii?Q?ua0N9hI/jTsXQSDAY+fsXDQqFBNegxmu7EAIJ/q3iNk7GAmY6Sx+sDeuBvZO?=
 =?us-ascii?Q?yFpcfvZh5KFB6gSR67Eo5n5qRDNTVjFOB8y+1hAckyrexltbrlsWqeeZ7V/T?=
 =?us-ascii?Q?qcklSMxpw0OtGM8iFdR7iD4geVLTZb3m1QgNsEPFR0bYtwual/vXxrCo2Rum?=
 =?us-ascii?Q?HbO6y8XVJZN7q9BsRIC2UT8BYmAi3IrPoUrybeILQsAQTuqXj2BrY6hna1rc?=
 =?us-ascii?Q?v4sYnZHx7ey2sEgKNAwHKcSQFQchUQyOtskQ7v1hjQ5z5eRKxj1z0bCXMkOp?=
 =?us-ascii?Q?16OBMt+DdB24gBwTnSd2fRU5jx+BxXe5trPbAczP1W36XKIdXpR3Zq2TyYm7?=
 =?us-ascii?Q?kxDhA19PmsPlXv5erQFJxaEg5Zp+8fyxcprSr/y5IiRqEeLLy+wqWD7icQEJ?=
 =?us-ascii?Q?qT9XKPVid5ZNatUjhGzpzK/H4yPCPdO0t6EDEg1HRg+X1CCJuYoOHs/E356X?=
 =?us-ascii?Q?pUxhalan2vhwP8xCmQTnuLyE259kg+Szekct5LUTY4ARdLNiUMW8rWXpDidh?=
 =?us-ascii?Q?KoIzUWNfcvzaYYeDTgWrPCmaZgg1nsytWXWDXUNOnKMzv1Jzwbgq3jkNzeKw?=
 =?us-ascii?Q?R9RXk4PIGZqiN6pD5x1zJ5lYAPO1NTPkmd04wwCe5iFkfsN718jvoPJoiGMk?=
 =?us-ascii?Q?ZgUKQ0iy5JSGYjJV9FB9DUFjWwm0mpyx1hXmeUlZT3u+rk1rDiZY5hupU/6B?=
 =?us-ascii?Q?XCxk5DyH9DYD85K6ZLa7LC/zC7gZb0vtz/uFDVXW4+BML2OK3+xp8mawaQG5?=
 =?us-ascii?Q?/BsCbrh3kErpt/wI/SlyMcF6Wc6ddtKe+fEwATPaxZhhuiW7EqJ2yCtsjPJG?=
 =?us-ascii?Q?I9G9tA0upBvm/nDi1vYmzC7WVFhJV+tBH81gCkFfYI4EeFmrq92IOa5bbSyX?=
 =?us-ascii?Q?j1NNNLMabBtfybLHhZ6OJhJ3Ay0fw5AYrWfN/Z/E1px6eTGbWml4lg70QsTy?=
 =?us-ascii?Q?pB1jZnUirivYEmZIn5rA8gmnLjh2wkjYDT93FLFJUy2qQA/hyG0rBnqut6J7?=
 =?us-ascii?Q?7V+r7fRpO71v1bMR6r3VpLKNrXiJ/KJQrU8G4UgDQULaD+AEwpCxyAz1DnAS?=
 =?us-ascii?Q?wlsGSh4AMFEaa7qQOY9yEqvp/xA/EiQY/hrqI+/ZZvZ2ra2GeFEoBY90RytY?=
 =?us-ascii?Q?h5FlxEjOWblzuYrnWgiy/5+ykLwWQAXC4rhsSVggB/alz5clzt+6r6lRdn6n?=
 =?us-ascii?Q?Dz96g6tT6uzNGW9kkNqQnS9TJUBWti2s50b4CqEi4N0sdVvWGtUrmk15saFr?=
 =?us-ascii?Q?nzS/qBUEO2h0m8RA2QJZzZovwmGSDjcbJCBtD3G3OUkZNrSb2WonlAMd1KkM?=
 =?us-ascii?Q?K0BPkXJqZ9D0P/r7x9lKcwBPX3APBC3K/gZJZHTL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8e39df-0d4c-4455-40b6-08dcde65987c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 19:58:31.2417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5/b+v2+EpEabO46Qfhlft6aLTzTJa7ixhX9Ywh+uBgAKGhdJeRWE6vEbMBPReVK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5967

On Thu, Sep 12, 2024 at 06:17:27AM -0700, Yi Liu wrote:
> This adds pasid_at|de]tach_ioas ops for attaching hwpt to pasid of a
> device and the helpers for it. For now, only vfio-pci supports pasid
> attach/detach.
> 
> Signed-off-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/vfio/iommufd.c      | 50 +++++++++++++++++++++++++++++++++++++
>  drivers/vfio/pci/vfio_pci.c |  2 ++
>  include/linux/vfio.h        | 11 ++++++++
>  3 files changed, 63 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

