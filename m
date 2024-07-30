Return-Path: <linux-kselftest+bounces-14489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB39941FEC
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 20:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482211F24C38
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 18:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A771F1AA3DF;
	Tue, 30 Jul 2024 18:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wy14m+fX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4211AA3C6;
	Tue, 30 Jul 2024 18:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365062; cv=fail; b=LfVmwN0odUec9I9oOuYbo/1SEhlOOmop0rOcmXaFlZQDIG/fiS0WR+wBvsNSdrZ0Rt1TpEHDK7ej2+lRhdfB7gfZA9hkN6sSWsqy9ZuHabjC/dWRpi9+Bp/SYj6ucFGtvwYN9kwpPkUcf6j0VjwGaZQ7vtjUt3QvFmeFgK80Uxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365062; c=relaxed/simple;
	bh=oXRQ4ZPb21CDdSnk8yKZ16xp9H6KGNM6hhCU/ojP/zc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X7ktoe3R9ipDYhKxmGNOitxp3UxZs+hZeOD5CnJXb0DMdURyzPPHsUliP5xgpa+StwRtNc33RjWGrMXsHXwboMNV5AtRdDpdYL8JzpHOY9mNYrqVJR1X7/SKkbF+du3T2Y8qS3PiuawB5Baf3nETGd2+woQIAOP0ATd0k2sFbxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wy14m+fX; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZg94PwDzOedRG58DtOjvUHGpuRbs0AqidZzUTE3KzZBBA9ftVhy6LA3hRUe1RS8yzTKNlqXucSh4R79WxpBq3Z7yDQsreEMLnvwtTbt8WECGySCES0nodVaLNzDCEzm0LkeOwNBQC0TQL5b0zoVEKZwMVa5I7znNCFVL7m6ucH+Sao00hKU6M2QPA4eb7JDZxhXPb+JTIduB/HRaXE7FkkOpSja84oU7VBcbEr71LzWp1JC2EfsIugAgTEQzSgKULVVT+bf2SIG/7zuSVFdfBQkugejcPIUtgwUsnXZtHxnh8sTVIolOgqC8glm/evIdk50kdkqa/BNH2lmg/fnkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQmGBAGQZuPJ4Zw+fdXgaW03KEk9m1vCCGIjQ3trW70=;
 b=CdFTtU6nEXzG1R2c0gTMT6h2C4/M9NRkhTTpPXS2MlDNhxE/R20vAmHq0EKpBUKqOKRChHfuy91q5bMsPb6zOhpyA5i7TcFpYMVMsBM+mNACJVg1IVQdKgA9PcMkpYTXBok4G3PuuijdonIwFCNpvF3fAvSzRMLnnMsJOAZf3BZigzc5J9NzK/ljf5LYDdaGdcZc5bVVbIdjnnxb+92E4Xg+EDfGXMtXqZPZMWyy6vJDoOoMFqaWEXWWbNNRonatQJs07mRvQ0ONwFqNw2nBj/NLnbK8XtdETuPJGhUSr2maS8LZpMZh7aZEVAPP1VaiA0a5u9M3agwjVhDVYtorNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQmGBAGQZuPJ4Zw+fdXgaW03KEk9m1vCCGIjQ3trW70=;
 b=Wy14m+fXnuby0T5ruX0PQZyYyfHgloY929fYdRK3Pqqm9/xoVgUO7rVukN6xv/1OzzQAO+2coqak8L3EQ+vuUhfjaGrdyTa/P9i2A3oRpzuPrlcBpfjIJLZ/56jh03xq+yuCNyRBFiqhTkBnirSoNsPrkTGqvql4J6DMN3rtzNK1fhgjNMThwF43CwUtVJBFs4FncRG07SKyTxyoMcBWOzaAo1ETBD4PAy/xmnuut816MzT/DFtb8wItHn1DqXwC4NtC1STRj4ga0OVVatXoWnPkfTJyjRvnJhlzGgIw+mQ8byDnUyKTFxvhywTMDxlWSOt8uwOxQTLZANL0D+M9eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by CH3PR12MB9077.namprd12.prod.outlook.com (2603:10b6:610:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 18:44:17 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 18:44:15 +0000
Message-ID: <504beb91-f0a3-47f4-8d68-d62577bb17d1@nvidia.com>
Date: Tue, 30 Jul 2024 11:44:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] bitmap: Rename module
To: Shuah Khan <skhan@linuxfoundation.org>, David Gow <davidgow@google.com>,
 Randy Dunlap <rdunlap@infradead.org>, kees@kernel.org,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Yury Norov <yury.norov@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel@collabora.com
References: <20240726110658.2281070-1-usama.anjum@collabora.com>
 <20240726110658.2281070-3-usama.anjum@collabora.com>
 <ZqUvy_h4YblYkIXU@yury-ThinkPad>
 <85f575b4-4842-4189-9bba-9ee1085a5e80@collabora.com>
 <c0e5978b-7c11-4657-bd07-9962cd04bf9a@infradead.org>
 <CABVgOSnkxgeXXXm9xp5_PvBxtMGbyFN-Jmd6YJ1u6g81MF_fyw@mail.gmail.com>
 <714e7642-6f92-4e41-aa36-c854668e0bb0@linuxfoundation.org>
 <75a2960e-d489-4440-a8e1-487a7f84902e@linuxfoundation.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <75a2960e-d489-4440-a8e1-487a7f84902e@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0055.prod.exchangelabs.com (2603:10b6:a03:94::32)
 To SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|CH3PR12MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca36c1a-7948-497a-98f2-08dcb0c79cf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTRaMm05SDV0VFM2ZHdFM3huVEk2Qmp1ckk3OHFYc2xqWXBXS2F1N2N4cG5t?=
 =?utf-8?B?bEVzL21FZ0ZOTllGa3JsODRReG5SWFJyaFdaWldYN2FKRko4bmt0ZlJaUEpM?=
 =?utf-8?B?Wk81YXIrREMxVU1QQ0Y3d2h6amI5Nnk4WmU4VmU3RXlaNnRuUVhqbm5LOW53?=
 =?utf-8?B?cDFtNUU2cjdCT0E4STJ4d0V4Zm55bWUwS1BITDBOaDlTUk5CTTJvK0ZrQWtV?=
 =?utf-8?B?OER2ZnZYa2UrY2paQzZKWE1iNVF1bmhxcGJCSGVWVm5BclpYR0dVb2VaSHda?=
 =?utf-8?B?VmkrS0dzTHRrb002VFlSbGxLRGJmSGJUcFRMQkVTeTVBWTA5VWlaOGtnS1JU?=
 =?utf-8?B?NkpoWElhYmxRUEljbGhVNXRiRDhndjJCZitsKzFwWkZqanAxZUx3aXQwVWtT?=
 =?utf-8?B?amdzVmlWaE4rVzVPRnlkRFFXalZFL0R5ZC9vczhkcXRTZ3VuWXhpbUtDZkxX?=
 =?utf-8?B?em81NlVaUWdBUFZNNVN5MVFoOWVDUVowbU1RTlhyVkpWalRzU2dwWkg0NkE2?=
 =?utf-8?B?TFNwS2xJSWo5ak9SS0UvbU0rSnd1Mk9jaVZZNzM2bmtWenp4SG8yQXJFL1Bn?=
 =?utf-8?B?TDJob1FVMG1UYzVJWEFEcEVIYmxnL1cxUlVHQ2N3NkJOb3hkUVgrY1dmVlhB?=
 =?utf-8?B?dHlldDRTaldHeGlIMklheG44Nkt5bERWbHFGaGVJdHdOSEVkWjNBdHplYjA2?=
 =?utf-8?B?aGQrbHpvUzNjcFJTVnlOclR4NHcxS2ZXVE0vSWVzRnVLQ1BjTWZ4SjNxenVP?=
 =?utf-8?B?YWFzRThONlRHaGxMVjRiL3d2WjM5S3VsSDZ2MWhlVU9WQzNxMy9FeW9LYUtJ?=
 =?utf-8?B?T0ZYc0RZYUFmQXBvWmR1VVo4L2RyZ1A5bUtyYi9NZVBFMmNla3FHb1d3NTlC?=
 =?utf-8?B?U3FoZElGV0JqTkQxazdSZFBrejVLVTF2aGN4cG5xR2lhRXJORTl5SjI4eWt1?=
 =?utf-8?B?N0Zvc0RCdXVjNWhQa0t2R0pLcE0zZ1R0RmlFZzYvc3lBQ2U0KzdEVC8wWkV4?=
 =?utf-8?B?eEQ3YU44SURaWklhdUk0ZTJiZ1dNNXBucTQ3TnRIbi9kTlhxVFJta0llQys5?=
 =?utf-8?B?b1NXdWFLQXRMREYzU2RlMUZsc0dYQVJTUTMrME1zRmlubkZVU0U5ZTBiWXFh?=
 =?utf-8?B?b2F6amI5Q2pBbVVEY3Q0RUNpbmRPbFNkZ3p5dEJqbythanE1d0ZhTmFaRnF3?=
 =?utf-8?B?elFQSEVNdnlDTFZQUDM3VjhjRW5aTTk1Z0sveXo2NEVXTzlORmVPMkRtSnlE?=
 =?utf-8?B?ZThuYmk3YVlwbEpzTHVMS1FMVVZ4eHd5REN3cVdCWlVZNWJTb3FBS2ZLc0pu?=
 =?utf-8?B?Y1ZwcEhQbERLS1h0NFJYSkt3VmppdU5qWkdQR0dMNzJlNmJwTjB2L1kweWRr?=
 =?utf-8?B?Yno5eW5tRzQ5MUowenRIcGNwVC8ralJPYmMvQWdISWFvYzIrYWFoYlVSTTla?=
 =?utf-8?B?aDJQWDJucDluNkw0RTd5bG1TWENlYy9MMDY5dnpveFB3WXlmYUVnTGRJekdi?=
 =?utf-8?B?ZGtERldhMFd6UUFHTXo0ZkQydDcxTGJXc0pQRkFVeXd1WlRZb1JCUkVZRlNP?=
 =?utf-8?B?cFVwb1k5eVpBMnczQS9rUEluRzVWVTZSMlBzdy9UZzJqTEFVTjBCMmowc2dL?=
 =?utf-8?B?dU5OVGtmMzI3bVFCdE9DNkQ5Rk1nd1hMOVZVb0tDMy94NkdCVDl5d2Qzc0N3?=
 =?utf-8?B?aXJaZXhkRGE4bDN2OFpwVGVFTE5ia2hqUXh0aThINEFpTlRkRTBzT01wOUVE?=
 =?utf-8?B?V3h2Y2lpVGVrWUg3T2ZzN0hLVVByZ0Z0SEkrTDRCVEZGWHA2QURtZThXa2V1?=
 =?utf-8?B?c3RTUjFmR09NVSt0bC9BZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFY5NzIzUGcyS1VOQ2VUdk5tSHgrMzFhVXl0eHVwSERKZjQ2VGovZXJORmFo?=
 =?utf-8?B?WnRvY0hWTFkvR1g1NE02dUdtZzh1WjltTmRzZXhxQVVxMUpQaHgyM0g1cVB5?=
 =?utf-8?B?Sk5jSFVOWnBPaTlhT3BLVlVoQ2dpVjQrV3F1dHo1anZHMjZUNU5lR2QwSU16?=
 =?utf-8?B?TEgrZ2h2ZmhWSWR4bk01cjFDa3kyMW9lZERLbnNBWE9lRkRCSWdabFJReTMx?=
 =?utf-8?B?OEMzMkxwVExqMDRYSncrRHlNYnc0NEJpOXlrU2VoTEhUYzgrcGFvSjdRZnI2?=
 =?utf-8?B?UU8wb1hNRHd5bXZoMzBhdXgxdGNnTi9jT2NOZXphcmFCZFhvZ3hCd0VTUXMw?=
 =?utf-8?B?RDg4ZW9QQ1JtdjdweGUwRzBhck96VVY3UUVSa0lQbzgzT3lUejlSMk5DWjR1?=
 =?utf-8?B?OWhuOHRFREYvWmYyeGIxRFpBaDUvb3JqNkdKS0FHMHFoRmdLVCtZZnBkMjJF?=
 =?utf-8?B?ZXZrWmUwbDczTDVNK1lycFRxM1RxSkl0eXZQbVU2RG1iRFhVQXlOT0hpSzVO?=
 =?utf-8?B?TWxMdjExRTBzWUhDNENmV3BFRWNVUzNJVEhqNitENzR6akRHd0MxNWZLOFhn?=
 =?utf-8?B?QXNMZDQ3QjZqWUs2S2NvZERxcU9zbExZRGFBSDRvQWNGckh3a2V4bGszNngy?=
 =?utf-8?B?WGozUHFkallvQ0Y3RkdrZWw4MW5Jc3ZqNUFIc2doNTRYUHB4dXBhMmwrWklo?=
 =?utf-8?B?dVFUS29lUUw5cHJUMDdTalVEUHc4T1lMcTR2WktSNUhqSXRZMEtlTlNpUnho?=
 =?utf-8?B?MXR4NmNKZ3lTRkNtbWFYYmFBb1c4MnM0bzVvSVpWd0ZRUWdOQVBFa29pZ0VF?=
 =?utf-8?B?TGE1dEorUFpFSkFYT2lydDR3V09EeTVrRzBVOHdUd29id2w1TUR4NU1hcHM1?=
 =?utf-8?B?dzZSZlh5aWxuM0xydUFTY1BtTXk5ckFOWjhiTkhaSnoxUytuSlNjWlFDOEwr?=
 =?utf-8?B?bFZHWHZMRmtPeXNGbTNwN0FQVDRVbUZ4L2RsZUJteldaTkk4N0wxSFlCMFp5?=
 =?utf-8?B?Z1R5VmpZYitaeElwUWtuVGx6K3l1U29pZk05MVFHSjhpS1JBUHpiK001NUdR?=
 =?utf-8?B?S240TmNjMXZDdmMzYTVOay9jNVdhVUU4aVZhTG1FREJqWWJDa1dIWXhrZXd5?=
 =?utf-8?B?UUVza2tvQ2lSZkFzWVdLaXJYNStwb3NtWURtcEd6R3hWU3V3UTlvMjVCeWE0?=
 =?utf-8?B?YjZRY3BJWWlIRzBHWTJUTnVZb2xQSmdCWlhBUDFlcllmVlNDOG95WEdZWHZj?=
 =?utf-8?B?dGdUcGRad3ZTZnFpall5ZkJuOXF3cElYczVQYm1QYW1QRlJna3UvYzhMZ2tM?=
 =?utf-8?B?T2diQXJmRHZrNGhUQy85UU01ZENTay9EMURzdjJKUXlIQ2ZlZHlDR3R5Z2pi?=
 =?utf-8?B?cExtT05wai9VeThaMEprQXlmUnp4N1dEL3gySGZudzFDUFIvNFNKZjh6Qmxr?=
 =?utf-8?B?MFF3cE9xU0wvUVNwV3pVTTE3SnlqTGljcW1Vd1Y2ZGl5aWFpM3JzemJUZ0gr?=
 =?utf-8?B?OE1IcUFmU01mbys5dlIrT29kNFdPZUgvTENSZWk0ZGl0NnJNeUFVQjRzZlo5?=
 =?utf-8?B?YUtqQ2RDakxjYnY0dU43ZFREMGl2SXg1ejJjYXY4N3NLd3pPV2h0TzMrQnY0?=
 =?utf-8?B?NDNMbnI5cVlVamUrRC9SaXdzZ2FCVklUNjc0d1FFbm5PSG5zbEtLUzQrMGI1?=
 =?utf-8?B?bUVhUFFBVjhURUY3S2owVStsMGFTdkRaVmM2bDFVaUNWOVBZeDF4ejEvbXpD?=
 =?utf-8?B?cWFMbFBqSXJhZjlHaVVsOWVtb0JyZUtmenNIcUswKzQwMVppc0xJcnZqUmlP?=
 =?utf-8?B?TURacEIrQnFvOEVOak1aa1oraFphNUhYSkJBY1BNOGNwYzBGRnBWV3hTa09C?=
 =?utf-8?B?ckpWZEtndU5xRTcwR3YzOER6elRyWkx5QUt2aW5EdHZSbXhjUXc3K2xGTyty?=
 =?utf-8?B?a2NqWlQ0WE9XTTlhNjNlNmc2UTJWaEltM1pBTUFoQ0dhdEd1RE55ZytxR0VF?=
 =?utf-8?B?V0lrWk1CeExBUmNySndmTk51MTk4d1BiZmdhekRydlJVdDlwdWFnandNTDVh?=
 =?utf-8?B?NXY5RDY3R1Fwa29kdXZhQTd5OXVJa3NjcnpDTUhIbGxRSG9NdC9lNmljaXhn?=
 =?utf-8?Q?M5SWNeH6Nw8WrC4n1A01fUVyy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca36c1a-7948-497a-98f2-08dcb0c79cf4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 18:44:15.8946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hBnTlVja+5WqZ5o8fk3WJQb9y4u9T/ZbeDV5oPwgqZyS6jMagf1xs4KNC6ndsC3RvlSkTbtCljvwcJlU0w6X3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9077

On 7/30/24 11:17 AM, Shuah Khan wrote:
> On 7/30/24 09:55, Shuah Khan wrote:
>> On 7/30/24 04:10, David Gow wrote:
>>> On Mon, 29 Jul 2024 at 22:09, Randy Dunlap <rdunlap@infradead.org> 
...
>>> I can see the point that renaming the config option is just churn, but
>>> is there a reason people would run the bitmap selftest but be unable
>>> or unwilling to use KUnit?
>>>
>>> Beyond a brief period of adjustment (which could probably be made
>>> quite minimal with a wrapper script or something), there shouldn't
>>> really be any fundamental difference: KUnit tests can already run at
>>> boot, be configured with a config option, and write output to the
>>> kernel log. There's nothing really being taken away here, and the
>>> bonus of having easier access to run the tests with KUnit's tooling
>>> (or have them automatically run by systems which run KUnit tests)
>>> would seem worthwhile to me, especially since it's optional. And
>>> CONFIG_KUNIT shouldn't be heavy enough to cause problems.
>>>
> 
> Shouldn't be is the operative word? This doesn't help people who
> want run a run bitmap test on a running system. This is a wrong
> direction to go to say all testing has to be done under kunit.
> 
> What happened to the effort to run selftests as is under KUnit? What
> is the motivation to convert all tests to kunit instead of trying to
> provide support to run kselftest under kunit environment?
> 
> We discussed this a few years ago as I recall. Let's work on that
> instead of removing existing selftests and regressing current use-cases?
> 
> Can we look into providing:
> 
> 1. running kselftest under kunit environment without changes
>     as user space applications?

Yes. I suggested this earlier: if something fits neatly into
a KUnit test, then with some additional work, it can also be
run from kselftest. Just supporting both would be very nice,
because people don't have to change anything about their testing
flow.


> 2. Leave kselftests alone so we don't weaken kernel testing

Or augment them as above, so that we don't weaken kernel testing,
yes.


thanks,

-- 
John Hubbard
NVIDIA

