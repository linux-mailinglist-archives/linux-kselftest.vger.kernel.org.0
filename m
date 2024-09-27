Return-Path: <linux-kselftest+bounces-18483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 720A39886A0
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 16:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DACCDB225C8
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 14:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE702D045;
	Fri, 27 Sep 2024 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AjjrvdgE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0C1EC5;
	Fri, 27 Sep 2024 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727445710; cv=fail; b=C/+evqdpix0gLPJp+zdDEJuFFbmngVCn5KWI2YA2cHyGf4dEviB0cV446lIZ8BkyTkXVMuO2IxH9aIz+U6HWDdibohkNwMuxg4CdqyoUYxU7i8ZXZ+jrm97XLT9tlLZgjnYIkGTSnXMLcVmnUA5fTXnRFYhdG1loHTaNU1WQuZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727445710; c=relaxed/simple;
	bh=klkwTF5XniuaYiQesBDkJLLOpPyl7PAJgrqjIGz6YDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hRmETerOpeXXSPb351quPxIu0rc2EgxxVfl5E9/JIuAJ5AQU9mLotpOINNUOat/gFFR3FoWrzI2VJf6D/qg1oeMwrXJY0rhyuij+AjmnqV6XSWke66iNrdKx+1Z8kMMvoyGh12bNaj2sNrHKYxmT6GdX/94JA2Q4JRDIl41akdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AjjrvdgE; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZRMHhx2VWj1begIrqVok77J5LH1dXAxMTpcit7vkE0/icMRj+VfS5WwXfcZ2Yl3tJXAVsNcGglmqO37IX3P8Bipq1FRYhhQEXy5QpB8b5pgGImBZpF6YTbDylIOwr3JbQptYpOHJI2CGLjUdHDhyACXwVF8z7r3v9vHHY5D3l8gQzqqnGM8DksMrUKpBhrDBbl1gwk+WfX2nICJWE3rVWVOEpC4Kp49wh3KM055twcQ2+p0OJHIfZBYlYo9Dhgs+ITFMEiCZqpe0INLKubcEn+2Zg4wYZCQzrGlWl7ESqV/aJ1YlqckKJC2qA/mxAkc6qE1KzVyy5r93xqI0SSa0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZUsPhxevvlZrcdPHels7LcO11LWxCAemNkk0NmhM0M=;
 b=htC86s2sVrWTyZfpI3zVREMF3AMvQ15EUWjpwT6PiKqR0lDpjwBRD9fA3VPVUdhRla73t5OwE0CM/a8ecrT80EgA/3j2eaFGUFRUXy/H4rrHQ9dxMb90ZWcWweUf3wiJTfqaWGNZkB+SQKAQnQeOeSF/61mvk3N/wp9Kx4nPDy3JGUlFywOBv6bP7q3NVkBj4+cSHPcd4aovqACssStQ8vP6rksD7rpP6Fp4VgBdxeWm23vBileNbEqWSz7YRk1M0Eli4hJowzHv0ew5K0zlMGFImRImLoS4fDlhZy8MU/tJJgklpcpPap3h43bOjCLnBAa0+PJHhiv3FZn/xBXlMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZUsPhxevvlZrcdPHels7LcO11LWxCAemNkk0NmhM0M=;
 b=AjjrvdgEVtzd0pHsGy3PNSlHDXCqis7cI9U3jo7XC59rQCJRdbhy6zxQw9TozRJSg7A9MR9g1J3SKgjpE23H6e+VLtv7NMqTfq2rtsUXkpK9N7D7CnCr7Fgo233Vazf1vJNb62AN4ZXaSaqLUBBfDGYaNvsaDOPdkYDajNUOBZBFE7ArP3snDHb3a18xsmeEO9fxfXz2bL5RlxZwnQnTQbWcsGGvLDtTTvkK4r2UU2VAwBp+ofz8YiXZMmlqtIYSlSEOS7jone9BnZFWw6mWRC2ARydQBtRT+gn4bAiYL7pRfjP5q5J1Iykw8so/wDrlxWnpRi6WYEHAVIte8DdHGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB8995.namprd12.prod.outlook.com (2603:10b6:610:17e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.32; Fri, 27 Sep
 2024 14:01:43 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 14:01:43 +0000
Date: Fri, 27 Sep 2024 11:01:41 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	will@kernel.org, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, yi.l.liu@intel.com
Subject: Re: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Message-ID: <20240927140141.GA4568@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
 <Zva4PJ3FhpMlWxhF@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zva4PJ3FhpMlWxhF@google.com>
X-ClientProxiedBy: MN0PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:208:52c::7) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB8995:EE_
X-MS-Office365-Filtering-Correlation-Id: d9e65644-764e-4477-4d07-08dcdefcea8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXpxODBjTDVCRytlYWMvOHM1YkliMklIbC9UOW1YK21OUFFBSnBlbkllQVUz?=
 =?utf-8?B?REExdlBPT1h3MGc4V21BTitLUUNvbzJoYyswM0I1NStpT2E1d3ZaY1A4b0xw?=
 =?utf-8?B?RWVXZ01Lbng1QndiOFJJd3RvQVVidDU2ZUNvaXBDRjZZbDhWeFZVVHcxTkFl?=
 =?utf-8?B?d24vejJkazRyekJPK1dVM3JBd3NqM1ZrSlZyRFpGTFBsN0pCQVhlNTVLWFZi?=
 =?utf-8?B?TkczMHhmUVBxSzFnSnF5SHJlMUIvcEV2RmxCVk9iajRnUmd0MjJ3bWQ2ZnJ3?=
 =?utf-8?B?aTg1TExGVTlCcEEzSnh3ZEpVTWpmRHd5WS9SSmNXaU1SYnhBbnlLREtYaUhR?=
 =?utf-8?B?cTNXUWd6ZTRUNjdjdEN4d29Td29SL0F6dzJzL3RNMnFDQmtOckRscnVkaVN5?=
 =?utf-8?B?UkFrNVJ6bEtyd0pZRlNLVjVNUmlmcjZUNjNVQ25TSkJVUGE0T0JmQ1NGdllL?=
 =?utf-8?B?a255ZDBTSUZrcWhMY3g2TWgweFBkRXhJT3dIUGd2a2UxY3RieTMwc0MyS1lI?=
 =?utf-8?B?NEl3S3dlNjNQN1A4MVJiYTZPVDUwNGc1ZXRzdjRuY0E2Q2kxNjZwWWIvNVNH?=
 =?utf-8?B?Yys0am1BVGxPOXdZVWZEN0I1a3VOWHh6Y3plQjlJVWc4UHdnb0FNS2gwMXkv?=
 =?utf-8?B?RXV1K0h4cTNYNkFCUEQ4cmsrZGdPRzJYamlFNjMyMjFuM0cxUjRYUy9IYjR5?=
 =?utf-8?B?WmduYkJ3dExWK2lINEljOWJPSnlZVCt1U1A3V3VjK1NJVzFMS0puTWp6T2FX?=
 =?utf-8?B?M3JBTHcyNkJ6TkdBSmhaU2ljS09hZFRnMWsvRk92Q0JySVg0SWhyY2F2MjM4?=
 =?utf-8?B?dFRGalBWQU94dWE5WFdqTGs1MlhZMmdUSURlNm9jYWNjNGllNzlzMk93YVdN?=
 =?utf-8?B?YTU3bmN0aVJDcXJDdUxacVUzc24yc25hUjI4Q3EvdmtxeW5xVC9SNUUxOFg4?=
 =?utf-8?B?a3Y0OUtSM3dpckZEeUNaalVDY0tWQllqcld2TVN2NzFMQlozcHJMWjZqRmkr?=
 =?utf-8?B?OUZxT055SFp1MXBqTUpsRkJOb2xqS2poRlNxK2NJTkRpb2pGMmhzRFYvWjV0?=
 =?utf-8?B?bmRwSEQ3UUNzekRVMGJaWEhpVksxRGhkQ1JaYUVqTWxkcGttMGwwdmNLMExi?=
 =?utf-8?B?Ri9mUXpCcE54TTFqbnQwWXpCcURrOWtURkd4bXUxLzdPMGNUa3lqaStJbHpT?=
 =?utf-8?B?K2tHU3Z2MW5iSVl1VVN6THpKOWw1c0ZMeWlpc0Q4Nk82elUrdy9YZXd5azF5?=
 =?utf-8?B?bmwzckttL3VDZEEwNm92aG4rblMvUlBidi90TzhkVWMvcEEzQURmRElCdkR6?=
 =?utf-8?B?a0ZlckhlNGZIYlcxNEx2RXJhM1VuRVFtMEZSc01wb3FVMDJ2VHU2TDBxZVZS?=
 =?utf-8?B?UFZhaEhwYXBPa1Z6Y2lLS2JFRnFjbTBnSCtCT1J0M0RmYTBTbFA1TFBVMmdI?=
 =?utf-8?B?VG5maTZqMlpmZ05WMGNZTUdzQWVhaEJrVURpNjhJRXhUSEtEOFQ4NW5ycGlR?=
 =?utf-8?B?ekRTd2cxd3JWbHJwSTJvUlpERXJSMUdvK1dkdCt6TWxmK1R5cFUwNW9VRTFz?=
 =?utf-8?B?YkI0UzAvUE1XNlJLMFdrMDhTekp6RnRUcXlDV0t5azMrbWN6aHZMaUMxeDdK?=
 =?utf-8?B?eWdnUUlkYzA0SmpzYitFUHJuaitlTEI0NEJBVW0rVlFaN2dnMks2OGRNS3BX?=
 =?utf-8?B?bVQyTTNPQ0VTYVlYRFRIZHUvVlZJOTdlSXQ3WjBHamZVdkl5dVcyYTZWM3ll?=
 =?utf-8?B?VlVaZE9NSFFUZTA0Y2hoS0RGQlMvZzlCNXRNSXQxSU1hRmJSaTNpQ2tyWkNY?=
 =?utf-8?B?L05LVkM0SkNBOTdjK2dMZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bStIY1Zxb2pFWitLdnVzSThmYmEzYjNLV2NmODQ2OFIrOENJVVFTZ2tFZ05M?=
 =?utf-8?B?bnozYWlidmxCWlloQU1WQmhXRUVIK2FwQm5UQnZkTXRzQzJ6bjN0Z3FOcWox?=
 =?utf-8?B?UDBmUEgwSHRKK3lIZFNjUkVyRmN1cnVaVnFzNFpaS2pBV2FWd0hHdnN5Vk90?=
 =?utf-8?B?YTlMekR2K2NZb3NjbmkyOGt4Wk9UN0paT29uTnpWWmNlNW9lNXdndkJtTDRr?=
 =?utf-8?B?REJlRHZ0ZkRIdit1M0llbXRUUUROeU01ZVpJTU9SdHA2NjI2MGJFUzJ5UWR4?=
 =?utf-8?B?YTNkcVRRek4xR0FIZVNXVE5ES01IbjdjekphZ0tMVEh6b3lsUEUwUzhjdTZm?=
 =?utf-8?B?TFdMS2FiV0hrRjJrTUY4dVdyb3JMOW54bTRuWGRoM3pjcjcydWdRMHNjTUxx?=
 =?utf-8?B?cEFmUWMvWWpnUkdPT09qR0xmZmJMVEpMQkR3MXcyTHFmY3NRVGsvUjB0RmNG?=
 =?utf-8?B?d0syekZQWlhJMjhDT3JrTER1WjdJRk0xc3BBRUFpRTA4Ymh4MnMzQUdOOEFy?=
 =?utf-8?B?MUIvWkxpT1hvQXlBTlpndmhYVnhoc1hFVElMK2E0Rmh6d2kyS2NBNy95eHRN?=
 =?utf-8?B?VUx3ZkNLTEFobWJnb3RwQjdHMDM2aitoSjRMU0ZKRDdCVkF1VFRWWTI3bXFZ?=
 =?utf-8?B?MitPZjRiRGEwWGNoQnEwdkV1WldYUGVscWlCYXVzbGdmckdsaW5QRThhZjRo?=
 =?utf-8?B?Zjd0N1U5c2JuOW5XeG9DZ3h4RENnS2ptOC9mTlF3WFRJWXJSYlFKTmM3YnpZ?=
 =?utf-8?B?MDI2ME1tL2JSVWFHNk9ZenRYRmVSZ2xhYnhiTGtEc1BJNU5MUTg4a0dwMjli?=
 =?utf-8?B?d3d1b3E4S1MxT2lwTk5LeWpMaFFhUldGODNMTk9jV1VYUWZIZ0IwcFR6QmRX?=
 =?utf-8?B?TWxXN1Q4MU80aEVxUG05cjhscldRN050YkNSMDZnNm0wUFg5UXNuNTc5TndO?=
 =?utf-8?B?SmwzVXdVQmQ0VE5aakFteGppaGxBVFpoU1BaUUU1UHZObVU1MGh3Szd2SUVH?=
 =?utf-8?B?U3duQ0V0dGg3c01vN0ROSXIxd2UzdkFvVzF3ZkppUnQ2enlYeTFvMGhNbEJi?=
 =?utf-8?B?VkV6VTlJempkdmpaeEYvUzhGNTFPeW81VGRscDVnUDRiRE5GbFZjMklwd2dM?=
 =?utf-8?B?TDk0bjQ3cDd6WlR1a0NiNkR1dkZCTkViUTlOZzU4Z3VyNkhRZFdVaEpyR3VM?=
 =?utf-8?B?cXNxb3Y5WXo1MVY3TzJGS2NnVmZXWnloMVF1UGZiUE1YakpjWU5RQWF6MWw0?=
 =?utf-8?B?aFp3R1pJRW5Xd3BTTDFDRUk3bDdjSEZEQWtUcTlvanIxOGNkK1FKZVRyYlNn?=
 =?utf-8?B?RGNMSUlnTDJUVFQvWEN1SXAxWUI0RllrT0NYRXYrT2VaUG1HNzcyWVc4RzJ4?=
 =?utf-8?B?TE14Qkt1bitLUTNiWFdtQnB3NWFFOHdDbnlCZlR6MGFmeHRRZkRyeDUyVGt2?=
 =?utf-8?B?d0lHOU4xeDNaZERUdERqMVFhWUlBU3RpSDFYVTFFYnRRcWVoQ1dMdG91YWtu?=
 =?utf-8?B?THE4WjhJcG9aVHVYL1RVQzZNZnlSTDVmUlNQNVcwZHU4dzhmN3NGQnpxRnBk?=
 =?utf-8?B?T3ZwYlBSb1FCRHNhSFRMVGVaODRIeExRdEJtOXNrOEI3VE1Pa21VRkl3QlJ5?=
 =?utf-8?B?a0JnOW9DVFk0U2MxMmp3cGtlT09zdmc2OWJVK1YrZEkvY1NEOFRCckthTkpB?=
 =?utf-8?B?TTZwaVliSDE5U1J1YWliVEJmMjlsb05CVjlLbTBrazN0UVVsbmxTZmk4SDR4?=
 =?utf-8?B?Z2FEMFgyS2EvdG42Z2g3bklNNGNXQ0pyRnZuYTNYSjVxbjVZNHJSYW1CUk4x?=
 =?utf-8?B?VlRTVU1GaWdRcUFxOTltdE15U2Nydmd5bmhjYXlRczU4L3ZVL1A2TlljVEhi?=
 =?utf-8?B?ckZQQUxRWFpkeWcyUjJZNVhGbjdnQnVWRE5qR0hUWWtmcHdMcDNDNWg4TXBO?=
 =?utf-8?B?VkxUdW8vWi9lRm1ubktjUWFOVXBVTCttOHJRRzhtUDNhcjdyTmR2MFA3Z0Q3?=
 =?utf-8?B?ZTB0TjFoekN0VVRpby93UzBjYXBmd2RTOUpNV2l6c2ZqazNvenI4Vy9vdkxF?=
 =?utf-8?B?U09BaEU0MjNEL3JPOGNNc3ZwTW0yaTZxTEZ2ZHZLUzh3WDRrRFE0RVZQV3dL?=
 =?utf-8?Q?ZtYQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e65644-764e-4477-4d07-08dcdefcea8a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 14:01:42.9360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ngdllXxkBgpawHfep0LQ1nNmKgw9W8iLL3SVyuKko1th+Kp6mPKtt4vbwRfsLM2y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8995

On Fri, Sep 27, 2024 at 01:50:52PM +0000, Mostafa Saleh wrote:

> My understanding of IOMMUFD is very little, but AFAICT, that means that
> it’s assumed that each device can only have one stream ID(RID)?
> 
> As I can see in patch 17 in arm_smmu_convert_viommu_vdev_id(), it
> converts the virtual ID to a physical one using master->streams[0].id.
> 
> Is that correct or am I missing something?
> 
> As I am looking at similar problem for paravirtual IOMMU with pKVM, where
> the UAPI would be something similar to:
> 
> 	GET_NUM_END_POINTS(dev) => nr_sids
> 
> 	SET_END_POINT_VSID(dev, sid_index, vsid)
> 
> Similar to what VFIO does with IRQs.
> 
> As a device can have many SIDs.

We don't support multi SID through this interface, at least in this
version.

To do multi-sid you have to inform the VM of all the different pSIDs
the device has and then setup the vSID/pSID translation to map them
all to the HW invalidation logic.

Which is alot more steps, and we have no use case right now. Multi-sid
is also not something I expect to see in any modern PCI device, and
this is VFIO PCI...

Jason

