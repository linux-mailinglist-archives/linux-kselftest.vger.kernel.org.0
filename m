Return-Path: <linux-kselftest+bounces-27397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFBCA430FB
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 00:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171C03A86B2
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 23:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AAC204687;
	Mon, 24 Feb 2025 23:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="umuuZ1wC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31EE194AC7;
	Mon, 24 Feb 2025 23:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440115; cv=fail; b=kzFk3gHhdanDy8D9ZOTSuod6Y+8Dcbq8Y46ZZdzhm3GEVWKBIm3tqlslJwVlTm6mVUjN0KmHIyhdD8ZAIu5l0m5Jms6U1F6QrdAq+/2XOqziZIiksQLun0z1mwnVswaEviuOMqess/1R24RC3UMLyFvtl7CzFIWE0zT8x3beQiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440115; c=relaxed/simple;
	bh=aJNEJQreLs49SNjDG4As4xXnuCYktfgTQqsWWKPPZPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e2gM0IVbs4EKHSJ148ycMYoDV/9R+pB4NYxBsAaGBYshE9PnP+oB2GUXW68wITVZFVqMCjB58xwiGnTq95jBUBxpPbwC6UKKAW52/K6mOUn1WxKRO1WAcxONly4NvzFr3aMHDQ0ygSAdcbQJkcw+Cv4Xa++o66xvrkNwqUtuxO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=umuuZ1wC; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdqCNAwWi7arUy+2oQVojRzUTtb81h00jg+uDQ7htpblMXhYxxagHwJnYo0PuNOxgoUnsSLNOBNzzynJ778p1M5VgB5dug1eirZ5hjMHCfGIXx+YoZaAO+KBUXbbZFMtW6xr/caOVhPbUJuSTJ7jTSARCcJ/NReZASIK0LJqngbR5slUQkf6Yh2Qb3MxlteLxD8Xbbz529J0psMt7rUb8ynumpTg23UMdAz0nmsUpmykgBx2oamFlmshGPtDrZADZyY3li/djONlMUEyNQGRWtpmTTtIm3zbz8BNP9W69LAoltra8C71MXVnQRHLhBtiA4bFzQ1vgIZ5eAcPD7gyvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gu9j43OOTQcwct3Jmzmd7WVfClwmVmUuuzlBwEXTvo4=;
 b=DJZPRobw2LRZWwlfYSznl1e+FPL155oyW9gWlVjCY4LPpbGccYNmW7ZQykJwFNAaeLtbNID/We4mn7SMMXjtc4Y6y+NTUMp0F7mXkfk+sSSOduJNDp7zzu9GKviTvbk2vYYKF2aiRd3LLFpzSphXk5a7Wz+nJxaQGQWPHAyCS1sNCGaH7xMOC+Q4HobaIgPRgasBsfSeAweahggG9uXkXBaSqSy0BTgzCEwI250ib9m2t5ZEUzAxkCSKe5PAQBdfuzUmazPPmSw8Ul6zn7ZO8UTi/Qefs1ZSWnxNiT1eIUqBojUn+rxd5baJQuLldaXCUtVEdhZKxFrGlEDzGusVuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gu9j43OOTQcwct3Jmzmd7WVfClwmVmUuuzlBwEXTvo4=;
 b=umuuZ1wCG7AyWq59APhe79OSRY2DxBcVvxS/bpYRTOfNPBTaPSROjak5j/sxYnLIYB2yhst0p+nkNn/TVhZNVrLiAm44B/eudICydUqI4uHT/g6l5Gi/XNs3GT2kQu9mqcB14roZ3JKkbcwj9TP/qvr+TcwZBbNzjKpcyGZyoOzSHMz0kOg5mbQrriYZkklOZZkN5H6QpvcQlbZtUc93HhjjjshjyKo788UikYZlg44097PK0YCmVyl+FdH7mBhL5DjkoRVIP3Hxy2yREBptxBrMSepXcbubXEhKnUR+iks36cqWPt9L6GWTJCU0g0hDSO21P1mPlD20Lfqit4a5Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CYYPR12MB8938.namprd12.prod.outlook.com (2603:10b6:930:c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 23:35:07 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 23:35:07 +0000
Date: Mon, 24 Feb 2025 19:35:05 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>, kevin.tian@intel.com,
	corbet@lwn.net, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v7 13/14] iommu/arm-smmu-v3: Report events that belong to
 devices attached to vIOMMU
Message-ID: <20250224233505.GF520155@nvidia.com>
References: <cover.1740238876.git.nicolinc@nvidia.com>
 <b1930038cf828dc13c080e2b46b3003a8c98ef24.1740238876.git.nicolinc@nvidia.com>
 <Z7zmErar4YvQSSxw@google.com>
 <Z7zrHn3tPBD5chv1@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7zrHn3tPBD5chv1@Asurada-Nvidia>
X-ClientProxiedBy: YQBPR0101CA0333.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::26) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CYYPR12MB8938:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d7f9295-cd4c-4f0a-6afe-08dd552bdf05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LCLu43u8NqdBzWrDvNw4/yut8Bc8dmvCcvQH1UaxRZ/BBwr9oSJt1iZt6hLQ?=
 =?us-ascii?Q?fuxcDrEMdz71e59JP9DUUR8lybdvZgQ4lMjJnHB8khDzRGWhXucTSA8em0Ec?=
 =?us-ascii?Q?4ywSsdxDJj4egduwrKh9thvu4T5OhTYkHtBpPE4iD+U7JahEbTkxN4vz5Rfq?=
 =?us-ascii?Q?hELskMoz1Vf/FZeC3WqY8ngGhxeUwu4xhajuKdVVq2dkGred727zT4n7M97R?=
 =?us-ascii?Q?V0qaDpDt3NNUkoTnU/K/8b1mK7Mibab1lQOj8hXsf+62DgkoPvY9bx10vB6u?=
 =?us-ascii?Q?avUnCC29NTJlu7YtN3dT+j1lB9iKZas5N7O7unOGtxqqomg3w1GJ+R0L3/HI?=
 =?us-ascii?Q?Hh+/Alotw5S/Uptpo5rYaGWXnNhPjiHSe4dyLcpwYKC/IvGk6Qr26Fd3G/zV?=
 =?us-ascii?Q?5+63WWtvRabBnSVqEmqSGHZ36ExcChTgjorLDuTg7C1t4zlJ6X9ZEtMtzOBW?=
 =?us-ascii?Q?8it7jJb1kQyC7UrjnJ+r0cUTDdVX9lvNSxmE1bmpTbFmpBjXZVyxG4fhZOiH?=
 =?us-ascii?Q?F48DotoEF/iSbm0xAgPfvft7A4fVvzPlaHzDUFWKMIqeAnV8wOZeKYH+gNQ9?=
 =?us-ascii?Q?KJ/D9RPwmRQf+J64L97Drbz/fkbHqs4THSY19cEM4oVoIM38v6H3Kd1WPYVM?=
 =?us-ascii?Q?CQx5sqAQktPmRrKYcm0ua4K0PCNBdrC+eRrTh/1UL+rjm2Hb832meAkl8abW?=
 =?us-ascii?Q?LpCRXahj0qVkD27Lk1+0iJHxEHPNRHRQYZHpXv7D72BqaUPlCXW27153loXn?=
 =?us-ascii?Q?RB2jEaCn5wRg5wH5EMt1625iekvXH26+r8+Gk7B9u612wSBs90+/ramu5vEk?=
 =?us-ascii?Q?hDA1ZEXM63Sm5HFuoW4kDEhXMi+1kmxHeVcvkV7rY80eBPAAotqRFs1B08ua?=
 =?us-ascii?Q?GEN+0teqrwwb5UReWBd3cG3aBmYG37QBw1sxdKU0wIyDJ+gkQY0TOjFadBSQ?=
 =?us-ascii?Q?qB7AMqqt3a4rw54MKTiMQh095KG35GJ4R1ef0pJGdRhbSTqxkmCIejeuCCR1?=
 =?us-ascii?Q?TuFnTtS7mjVbCEBpiO0g2B3Y161OTj0iQsYvNuum92u7Bc5VHeI1yLxkGZNr?=
 =?us-ascii?Q?5Ocd8QVgXtB/EjcbQBe41lvBey12btrKj4uLdiWBeMtFtA6deHfg6CMKuwiY?=
 =?us-ascii?Q?hv6MXiA74CmjW5/hVtTLvYYjIShygM6+DsldwOjvzlCO43Hq4BlhHAnAtshd?=
 =?us-ascii?Q?FxQfEffSzHhLNQmAjnxy8afvchMni4/dByRIpd3xeAlR3p5Oqe4WWfpMI1Bo?=
 =?us-ascii?Q?m7WCTFHmesMJv2TR4QkzRMt+/tCne45RgDBNXCbdINhNnUpnIyI+ETzZLKVf?=
 =?us-ascii?Q?zsE6mUv9Jg8KpgNlPPitWEDqnsVQ+xVErDjNE+Hm+/1Y4LKDzY4QLtcinlMh?=
 =?us-ascii?Q?UAQZCm4Xdk3IKquc3beufhz1Pp8u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rwtzBgKQKHq15yxRcj07N8oWr0foKLf9rT/pC1bEbADVniEf76Du0YCB2zwN?=
 =?us-ascii?Q?mgnVufdoPNZQ0yjjP8IbFRxEfEsTLMBJDOQ5Iz19hHJPDtz1Ohu5zhE4i/ay?=
 =?us-ascii?Q?owd4xGWyoKrhW5idMtw3b+B74YnZBrbyEdDYuxedZTFnvl6PmezYLG9JTSjd?=
 =?us-ascii?Q?/1ygw+BAyHcFkyLGWGcmwSSVtSNpIQZaiQqkdJe99Vs8pYY01AoSHAr6fOhA?=
 =?us-ascii?Q?9cobwdv+BQ+fHCz6NOvRrbUqv2fh2rS3rSF7SXyhbuI2ygqDW+vBm9hYXalz?=
 =?us-ascii?Q?GXd4dY1aod+IFqDKO8f6Siar+h2+pXvLMBDgP3tUlw4NroXrVsPy2s9Db8BB?=
 =?us-ascii?Q?UF0PElVPRA/LiESC6PBaKd2qWJi41v5fc9ILPw3ZpGysr/2BHr5iUlsAK8jV?=
 =?us-ascii?Q?Hj4Le8Bbefv03nzrU69XXedbnEIMtswYuBimmOi/9cVg6F4Q+7QlziJPxnMR?=
 =?us-ascii?Q?7jGBGsD841NnEVMzqeV4T64/KW1zEVGB8ZPGUvzbL1pQHHTQJ28mWMz+J1YF?=
 =?us-ascii?Q?O0ywg8bfCEE3IXxYCFEc5GKhh6y/ylPosA11Evng25ngV8FD1MYXhAHfjjmx?=
 =?us-ascii?Q?HEQQRzEic0Z0GSM53938HtT3YT3fy4FdQ11pMc4/66y8Hnh+C3A3ui5ocBiw?=
 =?us-ascii?Q?6gGOgXq3WxS9hcxqB/uMPxScpmpao8pFxe1gu8PlMctbz8mEBOR1ujBShPEH?=
 =?us-ascii?Q?c7W/3jxFwGOA9oDpjNjHyaJwcD73aPMJ0JudUwzvvrtm9xW/Eok7ke8lRRTM?=
 =?us-ascii?Q?UofmmdRC6LZimS1V4Ph6L6rexmpZ0eWgL3tSS9PGV05T1hi/wc+YdtAqpsEd?=
 =?us-ascii?Q?PbDbfunV3Lr/i/7tWVaZ6bRA1NlbpsC/KZ6c49hC2x0RMvB2JbZJxBqOFJ9u?=
 =?us-ascii?Q?z7OT8gIEvD4z9hWQZosBSu0pkFwwmpoDleyxmR1j7zlJn9nIAg0rvXHbMrQs?=
 =?us-ascii?Q?kNbMICas4Z0hsA2egFIpLxTcEqSqxD8MKiLuZJqGJDvsrdJ7hpz//HzgZKpD?=
 =?us-ascii?Q?yJlXDdo5mZ7CT30Ouofjf99Yujzz0Wo5BzpJUT14dMUyRJskLaMCoHH4yxgl?=
 =?us-ascii?Q?pqnBGb0u4zZJsYqsK8v/kJZHZfpeOIa8QG1T2sdcC7/O1vSIZqgXUHTLTxW/?=
 =?us-ascii?Q?00YKnuCFHXGpWRF5qKCsekTuaKCxWonrwJKorMoQDwTCjMgCx3eJds4WkZo0?=
 =?us-ascii?Q?WwzBJlhJaetITh1E4hNBNH+G85kJgfQCTsMW14J4k4IR+odhO/R26m73iWA3?=
 =?us-ascii?Q?NPlGOTUT9ZPKW0QCaVBpuCDRR0d6AF7kvsMvVtXVkKvH5eFgyc1OffWc7Qxd?=
 =?us-ascii?Q?oIxKbBtbbZBTzSXxmiJcxwnQbJFTg5YJrQLIbFqLJVhlyNVCYD+AHY8GgfGT?=
 =?us-ascii?Q?QoQKV+BLdQtmMMXkugmL3CS1XR8g3QddlBkGBOh9qLXeFQZayvd/XcZorGmk?=
 =?us-ascii?Q?U8uN4XoS/3nydBMC723C0xRDqSZXkht/wgOixXtvNuSnrvubq1zZRw2bN2K+?=
 =?us-ascii?Q?GE6Ajh9RrM4/mlN80oVU1gwkdFG/Z2SGGFfSxPeNkd3OF90HJJyly2AF6tIm?=
 =?us-ascii?Q?GNcLtlaYFBihD5W/2Jwr6rGZqqJOyv4vot5Mt9EC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7f9295-cd4c-4f0a-6afe-08dd552bdf05
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 23:35:07.1821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFLlIGNGiVFfpXjLvOKOMgSzrQO7RlMp2i7+kXVzO1pEYwHoNW+YiZb7+kp5Okhf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8938

On Mon, Feb 24, 2025 at 01:56:46PM -0800, Nicolin Chen wrote:

> > Just thinking out loud here:
> > I understand the goal here is to "emulate" an IOMMU. But I'm just
> > wondering if we could report struct events instead of the raw event?
> > 
> > For example, can't we have something like arm_smmu_event here with the
> > sid changed to vsid? 
> > 
> > Are we taking the raw event since we want to keep the `u64 event_data[]`
> > field within `struct iommufd_vevent` generic to all architectures?
> 
> The ABIs for vSMMU are defined in the HW languange, e.g. cmd, ste.
> Thus, here evt in raw too.

Right, the point is that it gives as a safe uABI that is effectively
being managed by ARM.

If we make our own thing then we have to take the responsiblity to
make it safe and extensible. I don't see a justification to do that..

It is the same discussion we had around the vSTE as input, the raw
invalidation command and the IDRs. Since we've already done 'follow
the SMMU spec' so many times already now we should keep doing it.

Jason

