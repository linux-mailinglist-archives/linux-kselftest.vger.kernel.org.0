Return-Path: <linux-kselftest+bounces-30420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F7DA82813
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 16:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18A0B7B9342
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 14:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FA1266F08;
	Wed,  9 Apr 2025 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Yyn47/Mz";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="FzlOcEtt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8F326657D;
	Wed,  9 Apr 2025 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209291; cv=fail; b=TdJ1l46SG7Q9SOu+9qzIBmGSGMknrpwaD+SnC8Q5S8VHgSybTyOn/TMDd0jLuC7V8oAufiKOrTaM6TaXYIzxPfxqD2uZGmhQOrco4x4bMchku9lxi6azcKjVHACF/PVWhT4XZNsJtWj/9HaKYxDh42EbhhtkF5oz5y3BYxPdO88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209291; c=relaxed/simple;
	bh=SWMC6krOjxAI5OCfZoK7B/XTZ0fpcq3biHzW0kV/3os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mLuOd5+4jL+OLL4ZoGV9no9k9iVb98pRJwuT8ISVyf0DRVM9fx/8plxMebtnTtik+WAy1wfClcMLTbtvCvdZ4TYCRoR4+iWYyF31PiipfzHphPITQpD8KZuu/E3GM+qahBZ5XA+T62bIACM/LgCkhW+0dkOsqBYjZHVo2NePXU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Yyn47/Mz; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=FzlOcEtt; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5395t5sX008875;
	Wed, 9 Apr 2025 09:34:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=btEdQB1SHL7orEIt4p8Mdh1HPGDS7IXRMLaMYSw7uME=; b=
	Yyn47/MzSGHs75RnH4zR3g7sA9w6xXTUGa1FkL3pGtLNJOJH/Dke+7Z7csWfHZgA
	IItngeBSrTHZKhPkxwPiplz8zaMJaKaKLIgb6p3wHUAq7NPkUZrAFRnSKN7yUk7d
	NjZNYI4vDQ7Y0AeH8cqJRmB+mJmF3N2GLBEyufKNdq7R9q67c38dYpbGQzyR4s33
	0leAL1GHEXuQiNSE14nsnFgNBojqohr1XkF1f1CmD5EjVdKJzp/H6krZP/Twt3Fb
	3ydFWWTwhK7VMrTCfr+/p95zzyUGhObFAe3+FqyJe1LOMrPTtexN0sULYmGTaot0
	W8DFQP1J7xe2VhCQ2YDjKw==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45wf0grsjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 09:34:33 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wx9FdMmbjwyIV+pA0fERR+1WM1vsAG1C+TW2T4MHN34+1NJcJGDvjgfKLPmcJXQk3mSrXkQXKPtriQ5R6MWiMHbMQDx2vaM3lOFQt+o6NJz2BtjPmnx3hsdB5Knv5WclGHeA9ll4/EmdX/Q79XIqkOBOhlFTpYj9i8yl6WQkwxTE1GvI6UDbyqRYNlNzhClsqUnd268nf37m4Oe3/vjH1FXlxDK3qXlN0D3WLbnaIyKw1wJEft0ttumEGcUSytnpPygkLhf2hdigTyC14fqARMTbjyghCbL72YbABOsaZ6QYI+yKgncw68tAjJNbIJS/6X8ZilGFokgaGWDCUaAt8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btEdQB1SHL7orEIt4p8Mdh1HPGDS7IXRMLaMYSw7uME=;
 b=Hny/7I9u03cuJ0DsdjLDjU7ZL2FzjgTJvtSjWq7jiwyiTZtOb5Y3OaKyzu/2dOSngZdAyfz3+/+P/yy2fTlwjjiau0MyxsdFnNsbbwR5DcwwEQotEo7XA54qgJ5FCa5zQ+8HKGNvEUvoDIytL66GA7MWypRF3AmzqR7lk0aOJeiYZ50qvL2PB3n4dCDPovqIpkAZ29Jnk6DePYcDTFdZIRaom6mbb1Dr4Eix33GE3BnR5A5lh9opKxyq+boIPssPMHHoRcilTaoVdx85a0VmjZwaCpaNB/k92zlDQzakdCCOn941fBnX6azPb+6XWuW4CR7FImK5ujC21YomYuH3Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com smtp.mailfrom=cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btEdQB1SHL7orEIt4p8Mdh1HPGDS7IXRMLaMYSw7uME=;
 b=FzlOcEttdkZIsuxlWF7fumFlsGhkM90lGOErOEHn6q/+hsNIrhjWm1n1BEjbCSmSS6Zh76rvssAoPm1/QBOfVB6mFG0WC2ObNORZEgm/V3a6hUm2aRCH0+1j7dzwTWeZ5swanPdGkHNwfgdhgWgpIGgKembd7259cO4ZXeoudEA=
Received: from PH1PEPF000132E6.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::26)
 by SJ4PPFCDF0C5BAF.namprd19.prod.outlook.com (2603:10b6:a0f:fc02::a52) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Wed, 9 Apr
 2025 14:34:30 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2a01:111:f403:f912::2) by PH1PEPF000132E6.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.20 via Frontend Transport; Wed,
 9 Apr 2025 14:34:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of cirrus.com does not
 designate 84.19.233.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=84.19.233.75; helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.13
 via Frontend Transport; Wed, 9 Apr 2025 14:34:29 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id D8509406542;
	Wed,  9 Apr 2025 14:34:27 +0000 (UTC)
Received: from [198.90.208.23] (ediswws06.ad.cirrus.com [198.90.208.23])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id B5F73820259;
	Wed,  9 Apr 2025 14:34:27 +0000 (UTC)
Message-ID: <5feaca10-f3bc-49bb-8e5b-9d9efa918e16@opensource.cirrus.com>
Date: Wed, 9 Apr 2025 15:34:27 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: cs-amp-lib-test: Don't select SND_SOC_CS_AMP_LIB
To: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org
References: <20250409104544.878475-1-rf@opensource.cirrus.com>
 <a47c2074-2e28-43e6-a7a1-c3ac662723cf@sirena.org.uk>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <a47c2074-2e28-43e6-a7a1-c3ac662723cf@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|SJ4PPFCDF0C5BAF:EE_
X-MS-Office365-Filtering-Correlation-Id: 03f21567-cfbe-4bbb-58fb-08dd7773a2dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|61400799027|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVpuU3FSejdGbWpCTU5UMkROY0tkdWM4QXBvWGVHMWdVRjRjUnF1VnlBYkRy?=
 =?utf-8?B?ZHQ1SWJlTjhjUEJoa3N4OVdaS2RLUHBaQk40N01VanJuTmZsb3NSK1FOdzhY?=
 =?utf-8?B?UThRYXpsbmlZeHNCMU5TZmYveVdtUkRxVHJiN3BUOGhIcHFydFpvOUhlR3ZY?=
 =?utf-8?B?NDVJTmYwMU5Vc09CSmdwTU5xbURFMVE2OUpKcEw5TlhPdURGYitNb2NhdFFM?=
 =?utf-8?B?MzRlVTJ6RVRBS0pNK3BBYWJCU1Z3b3FYL3lSaCtmRUZNNXZadzd6NnlsNzZC?=
 =?utf-8?B?cHJYcWRLeUVvSjlsdjc0bTc1aU41UlFrVE4raVl3Q2VFQ2kzYkVVVEtGc3dk?=
 =?utf-8?B?bk5kOUFJU2hSWldrbno1MUcxQTNwMVd4L01nNk5OMW1mR1pVdDEyUXduOHAz?=
 =?utf-8?B?QjdwQTljNHZjaCtnekl6SzBZQ096dEZlb3BWQlRqeGo4a09NcWNXLzEva2tl?=
 =?utf-8?B?WE1aM1dHTDVjZ1R1RHRrQjMvQWJ4M2hRUmVpTUt1Qk1aTFFaKzZOeEpScE5V?=
 =?utf-8?B?Y241Y0VraUJTM3pONlQ4S0pBS2tESFNLWFZ0bGVmQWdXeUt0ZU5XVGdhTk84?=
 =?utf-8?B?T0t6dVcxb21SNHZFQ3NlUFVYNGp0TStOeGEyTm5RdktGcWtmaHBEbVpEZ2hV?=
 =?utf-8?B?dm9Tc0FIVTlDOGJrOE1zTnV5RE5YKzlPZ2NZcFBMOCtXSEF0emxjY2M4YmJS?=
 =?utf-8?B?RHhpVk9neTduOGRIRWRNeTFEem1WVUpqRjE3bWpUdFdwZ2hhRFpVeWpSMU43?=
 =?utf-8?B?ZXhRQm0waUxXVWdvTExLTGp3YVpyNlBpVTNUMWdwVWhic0J5b0dZV0ZtOEJh?=
 =?utf-8?B?eTN0bTRDdWIxWE90QXByRURPZXNhcndPNHRwTEhRS0thTVREL2JDaE45WEl1?=
 =?utf-8?B?djBJNE44TzlmaUxzZnJGNm9kVS8zajR5WWJvcXF6NG43UGg2U0NjTUQxaGF0?=
 =?utf-8?B?RStvM0xTUlhPbFVDNWN0QWF3cHBUajVSVzdORlZVZ2Nrd0VUY25pdzBUS0pS?=
 =?utf-8?B?eHBWNGFUcDBQMElFOFppK3p3aVJmWnVuSmhhQ0poaFRMdkw1ODAwckplbzM5?=
 =?utf-8?B?VkxvRnVQN01vN1NlNy85WkY2ZWYxdzB1eVQwUHpQbTg0MkRUTW1NRnZETk4x?=
 =?utf-8?B?Q0NMNmpURGUyY2xNK1VyNU1ibHJCL2xSMlN3Tkx2dXF5eWI3bSt6OEJ6emIy?=
 =?utf-8?B?ajZQSFhkeEtYM1E3Z0g0R1FDUW1MT2hRQnFmSDRVbThOaFlmV1VZeldjRTR6?=
 =?utf-8?B?UDVRR0h6b0ZhdGswaGpacFpNK2xCMHdQVU1zaVJzMjZTdEVocjJxVU0zM2Y3?=
 =?utf-8?B?T0xxd1BraVNzd2FvRkRmV2xoaVA5RnFNTmhWdXJHRTA0ckxXUUZXYXJtSkJl?=
 =?utf-8?B?dDBseTBPbFg5eGJxaEtZY0daTVpYWUg0U0NYVGgxMGt1alRSZVFwSlJNNUds?=
 =?utf-8?B?UjJxaUdWeTE4NTVidjZDb1FHTkJJZVc3T082VExNOE9WUy9PTFVMMFBFaTln?=
 =?utf-8?B?eEFIYUJ2THJCcE03WHUyZUlDT1JkL25QZkMzdjdZdzZKYmpTbjdncXNVZHcz?=
 =?utf-8?B?YXhXWGN5WDFUM3l2RzVKb2h0SWNTVC9YVFVGRFF5QlpJaStGMDFxYnJBc1lU?=
 =?utf-8?B?YnI3K0Z0TklYVFQvTzNPTDB5T3VOejhDdkJTZzhhMW5acUtSbXRpK3JQTFlU?=
 =?utf-8?B?S2Q3ZmtsSHlTSXdLV1pNRnZjcllKSzVsYTU1Q3d3Z0M1ck11T3dNNU80enpE?=
 =?utf-8?B?QUYycm9sRnpNeGhLd1ZFUkEyajFrMVNPaVNQdUpubC85cnlTK2o4ZGxXUzVM?=
 =?utf-8?B?bFZHR0ZueVEwTURPbXJaWUZIekxFUTZaNzFtclBBa1dMRkttdEhMU2VRc1RF?=
 =?utf-8?B?RmR0dmJ3eGVhREVTNXlpam85Q2xjUDBMeVJ4RkFQZVp0eHN2WjRNOXhZTys0?=
 =?utf-8?B?RXNqaGRzNEszOWhsdThoNEtCWWE2NnEwL21oRWVPMXc0MkFKMUxiaVh4VWFa?=
 =?utf-8?B?V1BDb3AvMzBRPT0=?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(61400799027)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 14:34:29.0869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f21567-cfbe-4bbb-58fb-08dd7773a2dd
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPFCDF0C5BAF
X-Proofpoint-ORIG-GUID: THg_YVy9gFdm97SM2c8zZQ7XZeVn5UQv
X-Proofpoint-GUID: THg_YVy9gFdm97SM2c8zZQ7XZeVn5UQv
X-Authority-Analysis: v=2.4 cv=A71sP7WG c=1 sm=1 tr=0 ts=67f68579 cx=c_pps a=mEL9+5ifO1KfKUNINL6WGg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10
 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=mX3FmPPBFbbKS_jtFSwA:9 a=QEXdDO2ut3YA:10 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-Spam-Reason: safe

On 09/04/2025 3:24 pm, Mark Brown wrote:
> On Wed, Apr 09, 2025 at 11:45:44AM +0100, Richard Fitzgerald wrote:
>> Depend on SND_SOC_CS_AMP_LIB instead of selecting it.
>>
>> KUNIT_ALL_TESTS should only build tests for components that are
>> already being built, it should not cause other stuff to be added
>> to the build.
> 
>>   config SND_SOC_CS_AMP_LIB_TEST
>> -	tristate "KUnit test for Cirrus Logic cs-amp-lib"
>> -	depends on KUNIT
>> +	tristate "KUnit test for Cirrus Logic cs-amp-lib" if !KUNIT_ALL_TESTS
>> +	depends on SND_SOC_CS_AMP_LIB && KUNIT
>>   	default KUNIT_ALL_TESTS
>> -	select SND_SOC_CS_AMP_LIB
>>   	help
>>   	  This builds KUnit tests for the Cirrus Logic common
>>   	  amplifier library.
> 
> This by itself results in the Cirrus tests being removed from a kunit
> --alltests run which is a regression in coverage.  I'd expect to see
> some corresponding updates in the KUnit all_tests.config to keep them
> enabled.

That's the defined behaviour of KUNIT_ALL_TESTS. It shouldn't have been
running as part of an alltests if nothing had selected it. That seems to
make people angry. Probably the same people who would complain if there
was a bug in the code that they didn't want to test.


