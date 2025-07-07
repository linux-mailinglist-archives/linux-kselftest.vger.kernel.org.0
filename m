Return-Path: <linux-kselftest+bounces-36673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929A1AFAD58
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 09:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D92EC3BC6F4
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 07:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51875289829;
	Mon,  7 Jul 2025 07:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vi2wDCXs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533BF279DC0;
	Mon,  7 Jul 2025 07:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751874082; cv=fail; b=UlLI0XLle2IhZD3WuWwGVYPX6jwzHVxFsgNAbplj45Ib+2NHk/t9Qrg/kT78V5Zsowow4E7MWMOE+7sBALhkQf5SIMEp6qaoLazeMKSYXkSo7w9weYVI4R+202cYJ4ZX9ZOR9g5TVFrED7LuwC1vHZkBEMpnafUBarEKL2/TKbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751874082; c=relaxed/simple;
	bh=B4PMfFhB9xbbnUPX5bl6a+NbiaFO0X0UhKTmBrBhhTc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LM4gFhdX2Hk1HkRAB8XHUOlkgKdDIqEv4Ib2eg6foeRnqfEH+5LaxMV83+kDRO6wnzdYjADjVYHsUX4v5tT0+U6WgaY4KYTaqEfU4wRATZ7ru97QIKfLoUFxBu5flce2n67j0P9svLOGK6JVMEIxV2C8HQta2jbpr2s667mGD1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vi2wDCXs; arc=fail smtp.client-ip=40.107.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mImHEGzEJFgAhC6xm222rkjAys9setcfwtAgEAHYckv2+IE21AS4nO7fX25HAAd2CtiFbiajxhvtKo1JqmIIzBnLH4lsFgYYLLSsF4FBRTiKVszBDd5kIiJNDpw2TpTpJNhFRq8xvT58mXEiyYO+tDu5cPRqu/GkzbKmcm4kuOHrTlYhwgi8wHKQT0Y3B04ZtYH+Ox81CXLVf77z3MBrvHBQxDS8Wx/FuB4la2atVcP2GuSJeMK5t7fdbvENf8CHnnVAaZm8SqgHMJx96BRcOw5Kijxn+eeDZmeK/cGstUK0hG7u3CcFbsvTWgmr9xRzptj1DQZtsqrAFH3c6uOy+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwTQe4gD2q8C0CNnXKBBzjOx9f1TZaoez635t+0Ukws=;
 b=cik+U4EaRdc60MICSZN5NC5XRi60OMinryYBgkj4L3jRfeB4j56MbUUYqdAAv1/PID6L9dfFBWisOYagdFeIqLwqUIFxKTpxCEZxgrq0hG1lHDj5bb0J3oe8nopM+t6K3Jir8iH9PXqvpvs1AqOMzF8y26tdTkzc09w52xdTjvt7aDGzpU9t+65YeHMF4I4BFCM+Iyltvuyr0eVoOGoggisTiuDLLOwEirHt7TeK5GFVdpV4/ZrAHUhjjiGEhuLH6JvHYOjKpASyW7DJdIw/2nwZ6GgXXGxvPf+JivUqorPySK8i3yxrCEjZRGNa1yT1ckUWkv4ejmxv2Aqp1qT5gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwTQe4gD2q8C0CNnXKBBzjOx9f1TZaoez635t+0Ukws=;
 b=Vi2wDCXsLvdZEwy9hYPtqeyzS4fNSvSqlXB3Bs0yvthJQ+7pM4cPtfcemgLuvEAqjCHhkZmKom0rHFkj2Lj8KCtDlKIQXC47LjfOsBVFefhCHWGxf9m6Enr3Nbd09vP+PQRVMdiaOCiuh3RZixIYYZELDTtU/SbGSnWgO5qRLSc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.24; Mon, 7 Jul 2025 07:41:14 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8901.018; Mon, 7 Jul 2025
 07:41:14 +0000
Message-ID: <1f18d7a3-b515-4096-aff5-1aea31ce4f7e@amd.com>
Date: Mon, 7 Jul 2025 13:11:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 14/29] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 corbet@lwn.net, will@kernel.org
Cc: bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
 thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
 shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
 peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
 praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kselftest@vger.kernel.org, patches@lists.linux.dev, mochs@nvidia.com,
 alok.a.tiwari@oracle.com, dwmw2@infradead.org, baolu.lu@linux.intel.com
References: <cover.1751677708.git.nicolinc@nvidia.com>
 <49a93d92ce657cf6a0d588d2b31ad3600ace21f7.1751677708.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <49a93d92ce657cf6a0d588d2b31ad3600ace21f7.1751677708.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0102.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ac::7) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM6PR12MB4337:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b0751d8-3441-4dc5-047e-08ddbd29a609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnhNSzJYdXA3eWpxc2Y5S2c1RVJ1UHY0VCtFS0dmby9nUVJLQU1tL1F5U2NC?=
 =?utf-8?B?WkdEUEozNFk4M0V6aFhMTDFRQXo1ck0zWnlSL2pRS202dXFSejRKU2RVSHhv?=
 =?utf-8?B?bGlWWDFtVXl2VG9nZXNGbUVmT0N0RzRRTlFFUW9nZmw1UVJ3bHhzNVNSTE00?=
 =?utf-8?B?M3RLazl2TXM5Zno4TjhURHBXMi91YlRwZ3JiNUFSVHl1KysyekJVRWdMb0Vy?=
 =?utf-8?B?cWpXUng1U2tVYk1ESCtzRWJBY2Z0bUNHUHlSa3dZckgzRzkzYjVtUzFOb3l2?=
 =?utf-8?B?cmFuS0VsUWt1YzBRcGk1ZUQzeC81SktJZXVvcEpqQlFDTFdRWDR5QXM3YUtC?=
 =?utf-8?B?RThzMkxPYmFyNjNNQmgyRElPOTg0UENaUEp2V0E1SytrNHFwZ2pESFJsT2dB?=
 =?utf-8?B?d0hxaGR0LzEvTStGMDhEdG1XYnNacHp3ZklHekxDWDZaTFVxWnB6Z3JDMDAv?=
 =?utf-8?B?MXNwZnhiTll0QzlMU0hnTGY2K3ZzSWVuWWpDeWtJWSszclVQcFNjRGV2QTVa?=
 =?utf-8?B?bHpjZFZKa0dVWXhDUGZjZmN4cjR2YzZOV09JaWxZSUdYZW83Vm5OeXVrSE9q?=
 =?utf-8?B?SnpZaHMxSWhsZjgwYjV2Yk5rd1ZTVWV1enB5QUxpeHo5Q3JZY05BYjdrUEww?=
 =?utf-8?B?MWZMSmQ2RVhEaFVtdUVNYnVoRVU3T3F1WUVUelUrK3NBc0JjbUJLZE96SElR?=
 =?utf-8?B?d0ZpMURVZ015SnUxWmZxMlNjeUNJV1lMdmlOYkpsNVBDeFc2R1BHUk43ajkr?=
 =?utf-8?B?THRHcm95RENSQ3RRQzJ5QjVWTUV6RExKaU56anc2aHFCWmVJc3dLRjFQcjdC?=
 =?utf-8?B?Qk9WNGRkaTYrdndkdkdwbTJJRWhZejFvUkYxbTkxV3pRWTdwTndmREg0VVFN?=
 =?utf-8?B?TUs5bTNvMDlJcTkrMnR0RGFyeU9VTWRNMU40YkJYV0FDaFR5T2hkQ2ZTZTZG?=
 =?utf-8?B?TlJBeW9sL3JDMlJIVHIyeHZmNFQ4a3pvdmpBaFg4Y1N1TmYrQkt1SkpDbi9F?=
 =?utf-8?B?RXg3WklFdmdHNDFoLzZLRlhvVDY0NzVDUVJlNVRzd2lyMU8wNDBjTWpnUG1W?=
 =?utf-8?B?SWNNYmZCeEF5aEJqSTRXN0o3ZkUrNzVCYjJYZ202WVFqZWZzWk5IajNOQXBp?=
 =?utf-8?B?UmFMVWJPbXJhRFdpWjQya0RqaHdHSVpKYkk0K2lKOGdXek9rQlBZbm9ZM09v?=
 =?utf-8?B?c3R6RkdWaGpnekNBS2R1dWZkRXJIQTVINHRTNm52aDdkQlAzRG1kLzBrNU01?=
 =?utf-8?B?SERRR0RML1ZrenVBT0Z0QnhqZFkvMkxTUlNTWXNEMVRBeUk5VS96bndIMHpL?=
 =?utf-8?B?cVZ0a3NQcklTYldMYXBEL0krZmZYSGhiRi84K1E3Y1FMbTQ2SDgxa24rUjhU?=
 =?utf-8?B?Wmw1dWVnbzM2am1MRUtqN3NtQk0xU3NMVnR6UVZvcWNNb2FoZUM2QU5RaWJZ?=
 =?utf-8?B?SGVjb2NhSTJIMGhrS2hJNzlCK2psdmtMd25zZ3NYemVPeG95azhDODVyRjFK?=
 =?utf-8?B?UmdSTjAzSXZiVU96TDdRWDJHbUhmWEhaV3V2cTNMQkR5bGtKeXkwQzY5c28v?=
 =?utf-8?B?MFI5bEFqWkpFUmdwWUNrRlVzUVFycFY2U3AwczlWK1UrSWdhQVZnV2hpZzhO?=
 =?utf-8?B?OGlIMVVUR3ZtUVMvdEhrTHgxMkN4RXBObnhCbUl2dnc2VU95M054dEVvdlB0?=
 =?utf-8?B?YmhNbEVpcE1zZnd2QVZ0U2hRT1FOT2V4MlpGaXhEMzNGMW5SSHpoeHZKWGp1?=
 =?utf-8?B?TDJVc0ZmWjl5bmpONi9DSVozMTlQeGVkSVpzVmo0L0JJWVh4amYwQmhUOXhw?=
 =?utf-8?B?aTUybTBFOUUwK2VJemJsQ0JGdGZtbXFmVmxXbDhvYUJPc25rdGl4NzByNlZO?=
 =?utf-8?B?ODlkZkZTdVNoVHFQZjBLdDVFa1N4bWJEVDZlSUdPSUhjS2psQmVtRGt4YnJw?=
 =?utf-8?Q?Lki01KOK6EA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTBxMTBaZXlpODBCYm5FVTdVYjY3NzhZLzZVOFNwQ3gvQmp3eEJ5OU16MXlm?=
 =?utf-8?B?aEtuT3VpaVcrL1cwYUFacjZTTGlNKzZpbGhaYW9FTm5MaTVUaXFQb01qLzN3?=
 =?utf-8?B?NUIxWFB3Q2U1V0psbjhuSnhUNitZdFdwbmVnMGhLbE0yU2pOTjl1NHM1bE55?=
 =?utf-8?B?UlVnNWlOTVU4bTRNcHJqWHdwWW1NbEhuWkpTQlNQODhNZVZiVk0vZ0FKck5S?=
 =?utf-8?B?OXVhZGRIa3RHUkR0bXFlWk9hQ1g4cGlhRk13RDVBdW4vbGtXWUpobEh0bDRY?=
 =?utf-8?B?amFxMmNsUDJITWVRUllzVzZwZDNFTFVBenZEL0t3ZHliQ3hRTUc4NjZORkVp?=
 =?utf-8?B?MjB3eXdJM0R2NFhkWVJOWVVFcWgxcDZzN2NQL3JTVlhjSXVOK2dvVGZ2alF6?=
 =?utf-8?B?M2lmUnVUOFFpMzBjOUpRenZFZzNsbDd3RnBTZ1pROHU0RllIOEVLVGY5YndH?=
 =?utf-8?B?cGxCSk4xWDdLR0QzOFN1L2F4VXVZMFNvd1c3eGtFa0J2ZFFWMFBSdWk4Vml2?=
 =?utf-8?B?VUgyRzhDQkl5MEpRK3pIM2VnUml3cDNKS3lMTCtsSUVIZ3NkOFRaUEpwc25n?=
 =?utf-8?B?ODNyOXczSVp0MG5sT2VVSFlCMHNFWnRycHNFbHVIS3FzdTVrcHRMRVB5NU1U?=
 =?utf-8?B?eUx1YU85Qmk4RDRaYUhKUlVCdTBwRzhHL3VaY00zVHVISnZPU1NaeUtUdlBQ?=
 =?utf-8?B?SE4rdnZQM0FZS0JLc3MxOFgzdmFNUElqV0V6UkZUNllFTDhxakNkNHczdnRr?=
 =?utf-8?B?TGFwdENjYUN2TGhQYmpEZHdVdnphREFNa3lpWDYzNTEwNzZKMWVrRVFOWFl1?=
 =?utf-8?B?Q0psdWF3dE92ZFBTTlFNcC9qT2VldHdreFpNbFBxMm5Rc1VWd0xzemJyN3px?=
 =?utf-8?B?RGNrblJYTDVQa21Ma1ZDYitXU08rUmNiOHZQTkkyWTlGa0JWOXZJbmtXZmkz?=
 =?utf-8?B?L0I5aWpCT21jOU9GL1BkQVhacCtya2NnMk9LWTVQUlRPUmU3ZWI5N3U0R0tx?=
 =?utf-8?B?UGU3ZmhIeUZ6emRsLzNvQnNoRzJDaTBpQWgwaVdsVGdBMlJwUVl2UXptTG5J?=
 =?utf-8?B?aVFDODg1SSt0N0lGVW9HUHV0OGxjQW5OeUk2VkxxaExxdmd0TFMzalQwWUg3?=
 =?utf-8?B?U0xEVy9RTnRET3hPM0Q2ZUZxZ1hrYm52dHlYVnQ5WUtwUm1Yc2dKOXhobVNw?=
 =?utf-8?B?N3pTeVZyanhQa0FvSkFOTVhSZDgraTFLMTBISWU3bTk4MzVkdnJjUnJveWNx?=
 =?utf-8?B?R1paQmpUdUg0eUgvOUplOFNrVXVaWWY4M1U0bXgyblNzZmdsVnFTenB0K2U2?=
 =?utf-8?B?emFLQVorQWZGVG5LWlhaRWcyN1QvaHVMWmJ5dzAxcUs3T1pETlMrNmdzMFp6?=
 =?utf-8?B?NFVRV3k4Wk5JZkh1b0FRMWlGcll5ejNpYTI1a21ZU000Y1F2K2dhU2FvK0VH?=
 =?utf-8?B?Y1pSaEtnOS9WbVpXbmpZVWN2eEthWHV5ZnBtZG9ENWczVWF2NnN4S0lzOFZ5?=
 =?utf-8?B?amh1MXpFU0RSZjRRZFcrU2RSR0l3NjJZWVZUcHVrUlM3TFNjWkwwcVZWVVNh?=
 =?utf-8?B?R0NpUW4zb0pMb0VITHBtUlkwMWphOE0wM2RvUDVsdFBMZE10eFVjbnp1OTFh?=
 =?utf-8?B?dElzTStPdU1ZSDJ6Mm5nV1l5RG5DZXVIRit3R1pLOEVDY2JCMkR0dzRtaXF0?=
 =?utf-8?B?WEtIWUxzZjRkd00rVDQ4clBsUGhsd0FuUmxjM0g4SkZsRy83RVMra3B3MmZs?=
 =?utf-8?B?cjB2R21BbFowU3ZTR2ZWbzBQT2o4QlR5SEJpMm9Ld1RyV1AvOENjbmlzZzht?=
 =?utf-8?B?OVhYc3d1V3RZOTQrMjc2Ky9UR2hIOUJEWFFoMVVlMkYzQm9JbTZ4eFpEMVNj?=
 =?utf-8?B?YzVNMm5OM2RyREZtOThpQmVGUmJlM2VwaHFsOXFxV1ZxWldqb0JRTkZIeWtG?=
 =?utf-8?B?N3dQRGZqV0tNVkZNcSszYk5mam5oTEdwcUlKaDdjcGJidXZyb1FWaVFNckUy?=
 =?utf-8?B?MjU5eXptN21wUkxhcTltQmt2V3BHSnVQYXlBOW5GNnZVVGVlRjNicFJCa2FW?=
 =?utf-8?B?Y05Ld2pCZ0R2d0ZHRmJDaU1tem1HcHhoQ3dCTkw4QllCS1JLWE1FeHVmaVRu?=
 =?utf-8?Q?3axzj01Eirv/ceJRdZqDBaEeX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0751d8-3441-4dc5-047e-08ddbd29a609
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 07:41:13.9373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZnm960t1b/fOefuH4M35hgTvfoA8W5bYQ+1YDSg0D5NA/TdDiRj70Mz9FDIEOVImvvedstdFbdlqXsCCeruTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337

Hi ,


On 7/5/2025 6:43 AM, Nicolin Chen wrote:
> Introduce a new IOMMUFD_CMD_HW_QUEUE_ALLOC ioctl for user space to allocate
> a HW QUEUE object for a vIOMMU specific HW-accelerated queue, e.g.:
>  - NVIDIA's Virtual Command Queue
>  - AMD vIOMMU's Command Buffer, Event Log Buffers, and PPR Log Buffers
> 
> Since this is introduced with NVIDIA's VCMDQs that access the guest memory
> in the physical address space, add an iommufd_hw_queue_alloc_phys() helper
> that will create an access object to the queue memory in the IOAS, to avoid
> the mappings of the guest memory from being unmapped, during the life cycle
> of the HW queue object.
> 
> AMD's HW will need an hw_queue_init op that is mutually exclusive with the
> hw_queue_init_phys op, and their case will bypass the access part, i.e. no
> iommufd_hw_queue_alloc_phys() call.

Thanks. We will implement hw_queue_init[_iova] to support AMD driver and fixup
iommufd_hw_queue_alloc_ioctl(). Is that the correct understanding?

-Vasant

> 
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> --->  drivers/iommu/iommufd/iommufd_private.h |   2 +
>  include/linux/iommufd.h                 |   1 +
>  include/uapi/linux/iommufd.h            |  33 +++++
>  drivers/iommu/iommufd/main.c            |   6 +
>  drivers/iommu/iommufd/viommu.c          | 177 ++++++++++++++++++++++++
>  5 files changed, 219 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 06b8c2e2d9e6..dcd609573244 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -652,6 +652,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
>  void iommufd_viommu_destroy(struct iommufd_object *obj);
>  int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
>  void iommufd_vdevice_destroy(struct iommufd_object *obj);
> +int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd);
> +void iommufd_hw_queue_destroy(struct iommufd_object *obj);
>  
>  #ifdef CONFIG_IOMMUFD_TEST
>  int iommufd_test(struct iommufd_ucmd *ucmd);
> diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> index f13f3ca6adb5..ce4011a2fc27 100644
> --- a/include/linux/iommufd.h
> +++ b/include/linux/iommufd.h
> @@ -123,6 +123,7 @@ struct iommufd_vdevice {
>  struct iommufd_hw_queue {
>  	struct iommufd_object obj;
>  	struct iommufd_viommu *viommu;
> +	struct iommufd_access *access;
>  
>  	u64 base_addr; /* in guest physical address space */
>  	size_t length;
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 640a8b5147c2..55459b9eee31 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -56,6 +56,7 @@ enum {
>  	IOMMUFD_CMD_VDEVICE_ALLOC = 0x91,
>  	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
>  	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
> +	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
>  };
>  
>  /**
> @@ -1156,4 +1157,36 @@ enum iommu_hw_queue_type {
>  	IOMMU_HW_QUEUE_TYPE_DEFAULT = 0,
>  };
>  
> +/**
> + * struct iommu_hw_queue_alloc - ioctl(IOMMU_HW_QUEUE_ALLOC)
> + * @size: sizeof(struct iommu_hw_queue_alloc)
> + * @flags: Must be 0
> + * @viommu_id: Virtual IOMMU ID to associate the HW queue with
> + * @type: One of enum iommu_hw_queue_type
> + * @index: The logical index to the HW queue per virtual IOMMU for a multi-queue
> + *         model
> + * @out_hw_queue_id: The ID of the new HW queue
> + * @nesting_parent_iova: Base address of the queue memory in the guest physical
> + *                       address space
> + * @length: Length of the queue memory
> + *
> + * Allocate a HW queue object for a vIOMMU-specific HW-accelerated queue, which
> + * allows HW to access a guest queue memory described using @nesting_parent_iova
> + * and @length.
> + *
> + * A vIOMMU can allocate multiple queues, but it must use a different @index per
> + * type to separate each allocation, e.g.
> + *     Type1 HW queue0, Type1 HW queue1, Type2 HW queue0, ...
> + */
> +struct iommu_hw_queue_alloc {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 viommu_id;
> +	__u32 type;
> +	__u32 index;
> +	__u32 out_hw_queue_id;
> +	__aligned_u64 nesting_parent_iova;
> +	__aligned_u64 length;
> +};
> +#define IOMMU_HW_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HW_QUEUE_ALLOC)
>  #endif
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 778694d7c207..4e8dbbfac890 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -354,6 +354,7 @@ union ucmd_buffer {
>  	struct iommu_destroy destroy;
>  	struct iommu_fault_alloc fault;
>  	struct iommu_hw_info info;
> +	struct iommu_hw_queue_alloc hw_queue;
>  	struct iommu_hwpt_alloc hwpt;
>  	struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap;
>  	struct iommu_hwpt_invalidate cache;
> @@ -396,6 +397,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>  		 struct iommu_fault_alloc, out_fault_fd),
>  	IOCTL_OP(IOMMU_GET_HW_INFO, iommufd_get_hw_info, struct iommu_hw_info,
>  		 __reserved),
> +	IOCTL_OP(IOMMU_HW_QUEUE_ALLOC, iommufd_hw_queue_alloc_ioctl,
> +		 struct iommu_hw_queue_alloc, length),
>  	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
>  		 __reserved),
>  	IOCTL_OP(IOMMU_HWPT_GET_DIRTY_BITMAP, iommufd_hwpt_get_dirty_bitmap,
> @@ -559,6 +562,9 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
>  	[IOMMUFD_OBJ_FAULT] = {
>  		.destroy = iommufd_fault_destroy,
>  	},
> +	[IOMMUFD_OBJ_HW_QUEUE] = {
> +		.destroy = iommufd_hw_queue_destroy,
> +	},
>  	[IOMMUFD_OBJ_HWPT_PAGING] = {
>  		.destroy = iommufd_hwpt_paging_destroy,
>  		.abort = iommufd_hwpt_paging_abort,
> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
> index 081ee6697a11..00641204efb2 100644
> --- a/drivers/iommu/iommufd/viommu.c
> +++ b/drivers/iommu/iommufd/viommu.c
> @@ -201,3 +201,180 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
>  	iommufd_put_object(ucmd->ictx, &viommu->obj);
>  	return rc;
>  }
> +
> +static void iommufd_hw_queue_destroy_access(struct iommufd_ctx *ictx,
> +					    struct iommufd_access *access,
> +					    u64 base_iova, size_t length)
> +{
> +	iommufd_access_unpin_pages(access, base_iova, length);
> +	iommufd_access_detach_internal(access);
> +	iommufd_access_destroy_internal(ictx, access);
> +}
> +
> +void iommufd_hw_queue_destroy(struct iommufd_object *obj)
> +{
> +	struct iommufd_hw_queue *hw_queue =
> +		container_of(obj, struct iommufd_hw_queue, obj);
> +
> +	if (hw_queue->destroy)
> +		hw_queue->destroy(hw_queue);
> +	if (hw_queue->access)
> +		iommufd_hw_queue_destroy_access(hw_queue->viommu->ictx,
> +						hw_queue->access,
> +						hw_queue->base_addr,
> +						hw_queue->length);
> +	if (hw_queue->viommu)
> +		refcount_dec(&hw_queue->viommu->obj.users);
> +}
> +
> +/*
> + * When the HW accesses the guest queue via physical addresses, the underlying
> + * physical pages of the guest queue must be contiguous. Also, for the security
> + * concern that IOMMUFD_CMD_IOAS_UNMAP could potentially remove the mappings of
> + * the guest queue from the nesting parent iopt while the HW is still accessing
> + * the guest queue memory physically, such a HW queue must require an access to
> + * pin the underlying pages and prevent that from happening.
> + */
> +static struct iommufd_access *
> +iommufd_hw_queue_alloc_phys(struct iommu_hw_queue_alloc *cmd,
> +			    struct iommufd_viommu *viommu, phys_addr_t *base_pa)
> +{
> +	struct iommufd_access *access;
> +	struct page **pages;
> +	size_t max_npages;
> +	size_t length;
> +	u64 offset;
> +	size_t i;
> +	int rc;
> +
> +	offset =
> +		cmd->nesting_parent_iova - PAGE_ALIGN(cmd->nesting_parent_iova);
> +	/* DIV_ROUND_UP(offset + cmd->length, PAGE_SIZE) */
> +	if (check_add_overflow(offset, cmd->length, &length))
> +		return ERR_PTR(-ERANGE);
> +	if (check_add_overflow(length, PAGE_SIZE - 1, &length))
> +		return ERR_PTR(-ERANGE);
> +	max_npages = length / PAGE_SIZE;
> +
> +	/*
> +	 * Use kvcalloc() to avoid memory fragmentation for a large page array.
> +	 * Set __GFP_NOWARN to avoid syzkaller blowups
> +	 */
> +	pages = kvcalloc(max_npages, sizeof(*pages), GFP_KERNEL | __GFP_NOWARN);
> +	if (!pages)
> +		return ERR_PTR(-ENOMEM);
> +
> +	access = iommufd_access_create_internal(viommu->ictx);
> +	if (IS_ERR(access)) {
> +		rc = PTR_ERR(access);
> +		goto out_free;
> +	}
> +
> +	rc = iommufd_access_attach_internal(access, viommu->hwpt->ioas);
> +	if (rc)
> +		goto out_destroy;
> +
> +	rc = iommufd_access_pin_pages(access, cmd->nesting_parent_iova,
> +				      cmd->length, pages, 0);
> +	if (rc)
> +		goto out_detach;
> +
> +	/* Validate if the underlying physical pages are contiguous */
> +	for (i = 1; i < max_npages; i++) {
> +		if (page_to_pfn(pages[i]) == page_to_pfn(pages[i - 1]) + 1)
> +			continue;
> +		rc = -EFAULT;
> +		goto out_unpin;
> +	}
> +
> +	*base_pa = page_to_pfn(pages[0]) << PAGE_SHIFT;
> +	kfree(pages);
> +	return access;
> +
> +out_unpin:
> +	iommufd_access_unpin_pages(access, cmd->nesting_parent_iova,
> +				   cmd->length);
> +out_detach:
> +	iommufd_access_detach_internal(access);
> +out_destroy:
> +	iommufd_access_destroy_internal(viommu->ictx, access);
> +out_free:
> +	kfree(pages);
> +	return ERR_PTR(rc);
> +}
> +
> +int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_hw_queue_alloc *cmd = ucmd->cmd;
> +	struct iommufd_hw_queue *hw_queue;
> +	struct iommufd_viommu *viommu;
> +	struct iommufd_access *access;
> +	size_t hw_queue_size;
> +	phys_addr_t base_pa;
> +	u64 last;
> +	int rc;
> +
> +	if (cmd->flags || cmd->type == IOMMU_HW_QUEUE_TYPE_DEFAULT)
> +		return -EOPNOTSUPP;
> +	if (!cmd->length)
> +		return -EINVAL;
> +	if (check_add_overflow(cmd->nesting_parent_iova, cmd->length - 1,
> +			       &last))
> +		return -EOVERFLOW;
> +
> +	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
> +	if (IS_ERR(viommu))
> +		return PTR_ERR(viommu);
> +
> +	if (!viommu->ops || !viommu->ops->get_hw_queue_size ||
> +	    !viommu->ops->hw_queue_init_phys) {
> +		rc = -EOPNOTSUPP;
> +		goto out_put_viommu;
> +	}
> +
> +	hw_queue_size = viommu->ops->get_hw_queue_size(viommu, cmd->type);
> +	if (!hw_queue_size) {
> +		rc = -EOPNOTSUPP;
> +		goto out_put_viommu;
> +	}
> +
> +	/*
> +	 * It is a driver bug for providing a hw_queue_size smaller than the
> +	 * core HW queue structure size
> +	 */
> +	if (WARN_ON_ONCE(hw_queue_size < sizeof(*hw_queue))) {
> +		rc = -EOPNOTSUPP;
> +		goto out_put_viommu;
> +	}
> +
> +	hw_queue = (struct iommufd_hw_queue *)_iommufd_object_alloc_ucmd(
> +		ucmd, hw_queue_size, IOMMUFD_OBJ_HW_QUEUE);
> +	if (IS_ERR(hw_queue)) {
> +		rc = PTR_ERR(hw_queue);
> +		goto out_put_viommu;
> +	}
> +
> +	access = iommufd_hw_queue_alloc_phys(cmd, viommu, &base_pa);
> +	if (IS_ERR(access)) {
> +		rc = PTR_ERR(access);
> +		goto out_put_viommu;
> +	}
> +
> +	hw_queue->viommu = viommu;
> +	refcount_inc(&viommu->obj.users);
> +	hw_queue->access = access;
> +	hw_queue->type = cmd->type;
> +	hw_queue->length = cmd->length;
> +	hw_queue->base_addr = cmd->nesting_parent_iova;
> +
> +	rc = viommu->ops->hw_queue_init_phys(hw_queue, cmd->index, base_pa);
> +	if (rc)
> +		goto out_put_viommu;
> +
> +	cmd->out_hw_queue_id = hw_queue->obj.id;
> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> +
> +out_put_viommu:
> +	iommufd_put_object(ucmd->ictx, &viommu->obj);
> +	return rc;
> +}


