Return-Path: <linux-kselftest+bounces-17358-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0575096EB04
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 08:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866101F21E40
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 06:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF8C13D243;
	Fri,  6 Sep 2024 06:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fkCLr5ez"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F3D3B1A2;
	Fri,  6 Sep 2024 06:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725605551; cv=fail; b=AOZSD+pddHiGZesh2fTHBOh+C9PIypns3ZCFWnEUPXe340qkXaPTcXS+H0OyS2osupU328+7dXmHxOlj8yBCGz8NWSjDgWEOto34b+b4KsxQh7VM1DA2lpSMn50o9yzoOWGFq//eAfVMC5Q3pbYU67F6gqYwLW7S7Ggl/0a1jiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725605551; c=relaxed/simple;
	bh=Xf1eZMcl8OiaihX/iIPM5Je3TCEp8hBW1AKqnVwagy4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ak9aDAGpSzzZTBZecWx5DyMCEPKh+OpfiZkbh63p24Q2QKmPL4kpMRKowhjXaXfpzSRtVNjuTvBOfAPXda049+aC9Q90CKcraF+hXMJuKzvcBKwslYv5M8iiMvFwXiincmwrTkDYKRUaYZZXfPzhUb8zr5vJXnmHTorkN8h5U/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fkCLr5ez; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXsNB+6WP8qSkjVXsCQX2WP9H/YGZC+daw2zbcF+1wGf+5rba2UYzxAdKew2wbd75gqcX23+CAG0LtsHP/IgWHZKwZfpgDkTjWGgYA+yZER4QoUZEekfODZ3caP3LBytrxMzmnrHdtSZLjJZrsWlpUyO95vjpvsPTF6jPKO6Nn/XVfwfMFkylaMf+BzbqNVIf7bKNvAIF7Qu70evzV/uLixiJH7/8rawC6kgUxi4DDEgw/OajmMnyeSkSOQUccDKJ9+mxI2DVUQpV8BG4VqK+qqp992U1SGeOSJAQ1BaXJfulHAZimPECM5UEKY3wb9s0XgkoseXHs9uir1OGg6h4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xf1eZMcl8OiaihX/iIPM5Je3TCEp8hBW1AKqnVwagy4=;
 b=LrDIp1suLv7XXChQAssaA5KC8BCSUdQ6xEX6OVKhX3X3EEsS5Lo2Neu7uQbp0LkQFLCneyTFrkwR9L4By8jk8/HYSxhjEnHJfKDF5dfGG10wKK0iCNSHlq1OQY6lahvv8ofxqvmaGso46or05V4PcGkVaUzOhILsO+z/lid8q/kw33NRTuUxtb7lhD0iDwW6fdxf1ek43OiUpfHh2eCNZIPzx00zMrrwSgi8R43yOqxH6B09OdFvJwMeGX0yI40stuze9fQseA+IbLtgV2UZBQZk6nRKimHjX92O5cJauIluBx0943mP+5UGOu8am6zw57NLagypvUjt172yEomfHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xf1eZMcl8OiaihX/iIPM5Je3TCEp8hBW1AKqnVwagy4=;
 b=fkCLr5ezgzeOZRh7X1yM3zQ2r3xf4AQ90Ds8UfJ9WkzHMI5mIjoJWerAjQqzhdcdYreG9OodU+I9nKza3NcYpSe7lwwi4M0ZKIZESo/AtOe8lI1DSrgccu0VaFBD6pkgkDpkkHIeul0POOe+lEOzp/f+8wK8Vn95L2kFmeGgZYi+lByUcA8cn+KpAeeEdzDWB59vwKR4k5S8ov1+5zORokXzcEKcF+np8d3pAWkClUyAScByilYB8xwc0d170kGb6eLxX7UyTKqNkXpJCGbc5nmW1tWxdMG0Jtm+5HRmumx88MJJEkQG94sOIEYeK8TDtI+tcoQcGmUHQa6dZ5WyBQ==
Received: from DM6PR11MB4236.namprd11.prod.outlook.com (2603:10b6:5:1d9::20)
 by SA2PR11MB4780.namprd11.prod.outlook.com (2603:10b6:806:11d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 06:52:25 +0000
Received: from DM6PR11MB4236.namprd11.prod.outlook.com
 ([fe80::ea6a:8f25:ead5:8dfb]) by DM6PR11MB4236.namprd11.prod.outlook.com
 ([fe80::ea6a:8f25:ead5:8dfb%5]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 06:52:25 +0000
From: <Mohan.Prasad@microchip.com>
To: <bcreeley@amd.com>, <netdev@vger.kernel.org>, <davem@davemloft.net>,
	<kuba@kernel.org>
CC: <shuah@kernel.org>, <Bryan.Whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<horms@kernel.org>, <brett.creeley@amd.com>, <rosenp@gmail.com>
Subject: RE: [PATCH net-next 2/3] selftests: lan743x: Add testcase to check
 speed and duplex state of lan743x
Thread-Topic: [PATCH net-next 2/3] selftests: lan743x: Add testcase to check
 speed and duplex state of lan743x
Thread-Index: AQHa/oli3AbnW2Dxgk2PvHLNz0RDr7JHy4GAgAKITRA=
Date: Fri, 6 Sep 2024 06:52:25 +0000
Message-ID:
 <DM6PR11MB42366329CE76F1C90ABD9265839E2@DM6PR11MB4236.namprd11.prod.outlook.com>
References: <20240903221549.1215842-1-mohan.prasad@microchip.com>
 <20240903221549.1215842-3-mohan.prasad@microchip.com>
 <61428e08-8b88-41cf-83b6-123a857920c2@amd.com>
In-Reply-To: <61428e08-8b88-41cf-83b6-123a857920c2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4236:EE_|SA2PR11MB4780:EE_
x-ms-office365-filtering-correlation-id: ea89816b-268a-4d77-9ff7-08dcce40776a
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MTBMSURkMnZDMjlraTVSajRRVHRpd0poTFFvUUF2NnROYmZvbDZObktOM05Z?=
 =?utf-8?B?WFNsU1paWW14dGpsREt1Mm14SHJWY1Yzc0tObGJwN3hoUTluMnJhOTNaOXRJ?=
 =?utf-8?B?QVpiSERoTnVLLzNmUUpEZXp6ZzVQckVkd0pMT3o0VjU1SVBCdGZGQW8rM3Rz?=
 =?utf-8?B?Z0llY3N2VXZYTTR6K3F6SS9QVEpEVlFHRWtHVFROZGxCd0d5bDB6bXdTRDcr?=
 =?utf-8?B?cGJCK0k3b3N4UnVid3FzelhHWFVlbmtGbTRnbTZnbUN2eFNCZ1JlUVRhNk56?=
 =?utf-8?B?VmhYN09KRDRtNEIrRkpscUNSVTN4bzVweTVheFdwUlJhVkMrMnV3U0JrMUNs?=
 =?utf-8?B?VG1OajhwUEFnb29hQ3VQUi85R1ZPWnErUDZ6WDdxOCsyakdqbFZaeUZkTmlQ?=
 =?utf-8?B?MFBpMEdQcitKRU02L05yVThVbmhiMVdkMHd1bmUxRDVsUHRJQm9MVWVsZFk3?=
 =?utf-8?B?Z0h5MjIwTldrZkhTMUtVem1DZE1ZTEtHcUxvT3hnUk9McklZQjcydjc2d2VT?=
 =?utf-8?B?WjF3aG82eURqNUFxK1o4eGNQbitlQjB3VkN2OEtBSkpuTUxNWVlrQW1mVU9O?=
 =?utf-8?B?MzlxWXZ2RWZLVmFhS3dXdWNGTnNiZ1VYNm5tdnZpeGVrY3kxUXdEK3M5N2l2?=
 =?utf-8?B?TXZwR0hsMmxBUzhzbU5NNUxuVTVLY3dzN01UWWdHcEZXM1ZHUVlxMXpsNXBX?=
 =?utf-8?B?cG51b25iU0JiZWVMQUN4VitnRm9maklHdmJXWStPNTFDaDJQQmRQbnZRYkZT?=
 =?utf-8?B?eW1RdDlsNmlJcEsxQmxUWm9IaTdxWnc3Z3RlU0dKTytESm4xRjkySkc1R3c3?=
 =?utf-8?B?U2l1bHhpL2N1UytYL3RxNFBpcjFOOTlLeWpSYkdoRERxeURZYlA1LzZidHl2?=
 =?utf-8?B?RUtZN1B1M3I1NTZ3SzNyY0tKRG91c0w2UXV4VVdCQ1hjcjJtdVdrbExISGpy?=
 =?utf-8?B?VDlScWorMEwyOTZwdEU1ajhBVFYwT3pYNHVXMERxYjZGVS9Ob2YxVE5MSHBa?=
 =?utf-8?B?WXlsM01yVnNWTWxBYzRmaktEUjdldVZXenRJMzI5eUNXMDRaMzl5WVhjY1Bz?=
 =?utf-8?B?WC9ZOXIvT1QzQm84UGQwMlIvK3NiZng4VHFyclZMNE0vTGRMRG56VmdsNlpZ?=
 =?utf-8?B?cFVhdXJ2bE5xWnJUUjRJVTRVNjRLZkszWVc0QlpIdk5EZE5iVTU2dGI3aWUz?=
 =?utf-8?B?UFBRbDVOdGwrNDZCUHd4STB0Ky81SDJsblhpZGc1SG9wTTl4aE1kOVkxRkFV?=
 =?utf-8?B?b3M1cm9uV0pWdmcydXAxeGEvM29rTTMyaTZWalhJanE3VTcwOTVwVmhPRHF1?=
 =?utf-8?B?bzdXS3N3OEZNdjdiNUs2THMzYTBsZ0FaaitEaXlCbVNwL1NrdEVWUkJwUjlr?=
 =?utf-8?B?K1dZVzlIbFV2b0NwSWthdzJKZ243U3VxUnZzUUFsbFlkdGwycFFBSUZUSVFv?=
 =?utf-8?B?WkhEdjZqaVlhckVPaFRQaldkcTl1d1dTN1hwU05WR0FUc0hXaHhESk9Ib1A1?=
 =?utf-8?B?YytnZ0NvV2VzSXJ6S3BqMEdvbmpUc1pieEcxQ1QzeVRDMU8rYVBnUnFrTW1Y?=
 =?utf-8?B?Y01mZnRLeVZlWkhHY2hFMUt1RUVRWWtiRmNnVEtwbXJ0Ky8xc2oxd05hRGFX?=
 =?utf-8?B?Vjd6MjRWZE9oaHVDMDE1TGszL0JtbVZkU0Y4Ym16SlNuSWpFeldrczRBbmNE?=
 =?utf-8?B?eEpaNFVCbFVEYkp6U2NoSG5UcHRZSnRWM0lqUG94YzFJVnZvbDRtcjVZWmRH?=
 =?utf-8?B?WjNlUmszdVhINnB5QWhuNFBtYmx6TkFFaDhGY0ZwVUlJMU9vTlEvbEVxMmRl?=
 =?utf-8?B?MGpRVXpxRDk0anRWeFVzMjJSNkxyaE5uVnNIYmdraGNnbkVrenR5d1JlQVdF?=
 =?utf-8?B?TERsUDR0c0IxcXloK2RmY1lBUlhmdkJBeGtEN1BlQmpxbXc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VE5icEJPWUVQUi8vL0VKUHR0U1o4dXAxRGt3ZDN2MlZPU3lublBONHp4SGtS?=
 =?utf-8?B?dzQwbmMyZGFFMlkvdk8yUDA5cGxwMHN5aXpoMnl4ZnZsZXdZU3FhdFUyZ2xQ?=
 =?utf-8?B?NkZRVHFFZmdnbkh4WlRCU0EzMis3UmswMG5maSs4dG9nMWt1TWpILzB5Vitj?=
 =?utf-8?B?OWpMWXppSk85cWI3NHBJR0drc2xLWEdxalJjQkhScHNtK1d4cEg3VUYxY1l5?=
 =?utf-8?B?TDNQMjNmNk5xZzlnWU00aWJMOFcvVHgvL2JwWlFwQXdnTkh2QzhjNWdDMDZR?=
 =?utf-8?B?czdlNkE2dDBRNysrdlgyckJSZzNheXNzaG9veFUxSFBUTEd0ejd5a0RURENH?=
 =?utf-8?B?NHhBRXVjaHNWcUlpMk54REh4Rk9XZjM3RmFKc1FIbWZQYjZMY0cxa1dPMnYr?=
 =?utf-8?B?a2tGMVhVak92L1pUNi9EQTVPNXhtUEdHa3dMcTlrQW16Z3FlUkIwMERQNEtB?=
 =?utf-8?B?eGFxdHBad1pKdlovMnpHNERVdExwQUNwdXcxQzNLekt0MXNDY1pCbUJHd0xD?=
 =?utf-8?B?bGttZjFTenkyYUZrVnRiSTZqTDB2U3llREEyZmhBWWtpd3djSnlwTFZORjVD?=
 =?utf-8?B?Tk52Vk1kNm9WclNnNEpvTFZRakVtTDdaZkpLMG5zRWlxVWxpQndWY0RIaklD?=
 =?utf-8?B?RVVtM2NleHNocEtUZTYwdHRkRWlCNnRCa0Jyc0E4OG9mS09mRlY1MDRHVlNX?=
 =?utf-8?B?cGdXcW9adzlXd0dpL0ZrMVVEclVoVE05Sk13elNpM05PZy9PaVFxNFhyeGxW?=
 =?utf-8?B?UDhsc1F2aXVMRTVNbTI2S1JablZudlErTStHMkhwcE9Nc01OaURpL1pZclp0?=
 =?utf-8?B?S3IwbXc5WkhmN0kxakVBSU9KbUhzcVZabDI4VndCN2tvdXE0cVJyTUxjMTg1?=
 =?utf-8?B?TW9sYjROQi9kdkc5TWhFdE9qRzhKeXQwLzZiMk43blBIT2NTQWlPUGdJNkdK?=
 =?utf-8?B?K3BVZWMybzRXZ1ZrdDdXYklHbW5tdC90TWNYdUtJR2QxZ1VhbS9CaGhtbENZ?=
 =?utf-8?B?UWw4Vm11SzJKbTJBNUtESHdGMjE5dXlRZTJmSTF0Y0d4Y1MxWFNPWDZCaEZ6?=
 =?utf-8?B?dENNSTRVRmlOcnk3T29pL2RyVlN0aWR6ZERZc2VHaC9jaWlvRmpsVll0My8r?=
 =?utf-8?B?ME1WUnRzbGtQb3VQZlpMVVZmbEx3V1R3RHNjNkk0NjB2WXh0TkRVYytwZ3g3?=
 =?utf-8?B?dDhhajRDTW9oblZaK2tGd3g2VnJRMEJ2ZldEeGNLK3E4THo5M2xvK1lRZjZN?=
 =?utf-8?B?eXczUHBOMEU4ZFFKT3B1NC83T2srZFQyZUVEeTV2RmpEaEdFUE91eGNJODM0?=
 =?utf-8?B?dXFnYTY5TUljUStNdEZyYW5IR094WUpoQ2preUJZZTI0UkxBdk5OMkZhZ3dS?=
 =?utf-8?B?cVAweFVZS1NxQW90YWtleE50c1BvM0s4OHJ3ZXVVTDh2WGExUDFDRzQxcERt?=
 =?utf-8?B?SlJyWTRqQzVEcklXMjJSWVpmM0JOVE10b1VvTFgya25ROEdrTXlHWTljNExQ?=
 =?utf-8?B?UmhBRXRJMG9iUjREdWpoekdPTXdENXk2alJoTVBHeDh4N2trYVl4cm91YUJn?=
 =?utf-8?B?NE1INDZoc1BCbDYrb1VXeFQzbk9YNGZZZDBkNXQwdEt2RnhwUmZXTlBwRWl6?=
 =?utf-8?B?N0t2cHFvZmxyZnNMbXM5amppeUFSTk80QnZvVGZTVE52b1ViM21kZk1heUxL?=
 =?utf-8?B?dU5xQUdGNSt0U29ESC96dHFBRlBvNjErMTdaUk1adnVLUDFRSHhiWVpPYU15?=
 =?utf-8?B?SFVNaFNjWDFod2dxbFpVb3A5Y1dpeHBETmk1dm9kRFp3dnVydUp0TmExS21Y?=
 =?utf-8?B?TnNleDBiMjBvajBhckVUKzVVckQvS1VXWXpXNTRGWEpMaTNtYWp2TlhWWEpq?=
 =?utf-8?B?bGN2eHYxYWNkaUdOelh3dXpUVkVHQzZ4ZUUrbWdBU3VBSUorVjY4Ui9FOFhM?=
 =?utf-8?B?bTlydUxBRVFWYjFYVzEvQ0xtMW5vUDNHYXZzaDdGVGhSc0VqR0NKVURMV3dy?=
 =?utf-8?B?OHVDWU1OVVFGNytvR2wrSWVQWlhkZTNFL2tCQUVlaGc0alVXYU1namRuMDJ3?=
 =?utf-8?B?NHJIVUJWTTZWQXh5OTlORDhVTVUrWGY5ZjR2WkpDRmRrTFBDc1YyWnIySDd0?=
 =?utf-8?B?bEpXVlZmcFdCK0ZhSUl4YnZWcXIxUDYwbVpCK3J0WDJ5bkdzRGxsVSs4Vytq?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea89816b-268a-4d77-9ff7-08dcce40776a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 06:52:25.6282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9tUVBRyit9jdEHuUpCFKCCJPRHrcVF3/HjK7A2GN44VUR15zvNOuFQ3ESZpCYKpz56vEvy9eF/nw3emKiSHJmsoyvoXIyR/gTYgKjJU8oSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4780

SGkgQnJldHQsDQoNClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldyBjb21tZW50cy4NCg0KPiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSBrbm93IHRoZQ0KPiBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDkvMy8yMDI0IDM6MTUg
UE0sIE1vaGFuIFByYXNhZCBKIHdyb3RlOg0KPiA+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmln
aW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyDQo+IGNhdXRpb24gd2hl
biBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4g
Pg0KPiA+DQo+ID4gQWRkIHRlc3RjYXNlIGZvciBjaGVja2luZyBzcGVlZCBhbmQgZHVwbGV4IHN0
YXRlcyBmb3IgbGFuNzQzeCBuZXR3b3JrDQo+ID4gZHJpdmVyLg0KPiA+IFRlc3RjYXNlIGNvbXBy
aXNlcyBvZiB2YXJ5aW5nIHRoZSBuZXR3b3JrIHNwZWVkIGFuZCBkdXBsZXggc3RhdGUgdG8NCj4g
PiAxMC8xMDAvMTAwME1icHMgYW5kIGhhbGYvZnVsbCB2aWEgZXRodG9vbC4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IE1vaGFuIFByYXNhZCBKIDxtb2hhbi5wcmFzYWRAbWljcm9jaGlwLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgIC4uLi9uZXQvaHcvbWljcm9jaGlwL2xhbjc0M3gvbGFuNzQzeC5weSAg
ICAgICB8IDMzICsrKysrKysrKysrKysrKysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzMyBp
bnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9kcml2ZXJzL25ldC9ody9taWNyb2NoaXAvbGFuNzQzeC9sYW43NDN4LnB5DQo+ID4g
Yi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9kcml2ZXJzL25ldC9ody9taWNyb2NoaXAvbGFuNzQz
eC9sYW43NDN4LnB5DQo+ID4gaW5kZXggZjFhZDk3ZGMyLi41OWYwYmUyYTcgMTAwNzU1DQo+ID4g
LS0tDQo+ID4gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9kcml2ZXJzL25ldC9ody9taWNyb2No
aXAvbGFuNzQzeC9sYW43NDN4LnB5DQo+ID4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
ZHJpdmVycy9uZXQvaHcvbWljcm9jaGlwL2xhbjc0M3gvbGFuNzQzeA0KPiA+ICsrKyAucHkNCj4g
PiBAQCAtMzYsMTIgKzM2LDQ1IEBAIGRlZiB2ZXJpZnlfYXV0b25lZ290aWF0aW9uKGlmbmFtZTog
c3RyLA0KPiBleHBlY3RlZF9zdGF0ZTogc3RyKSAtPiBOb25lOg0KPiA+ICAgICAgIGFjdHVhbF9z
dGF0ZSA9IGF1dG9uZWdfbWF0Y2guZ3JvdXAoMSkNCj4gPiAgICAgICBrc2Z0X2VxKGFjdHVhbF9z
dGF0ZSwgZXhwZWN0ZWRfc3RhdGUpDQo+ID4NCj4gPiArZGVmIHNldF9zcGVlZF9hbmRfZHVwbGV4
KGlmbmFtZTogc3RyLCBzcGVlZDogc3RyLCBkdXBsZXg6IHN0cikgLT4gTm9uZToNCj4gPiArICAg
ICIiIlNldCB0aGUgc3BlZWQgYW5kIGR1cGxleCBzdGF0ZSBmb3IgdGhlIGludGVyZmFjZSIiIg0K
PiA+ICsgICAgcHJvY2VzcyA9IGV0aHRvb2woZiItLWNoYW5nZSB7aWZuYW1lfSBzcGVlZCB7c3Bl
ZWR9IGR1cGxleA0KPiA+ICt7ZHVwbGV4fSBhdXRvbmVnIG9uIikNCj4gPiArDQo+ID4gKyAgICBp
ZiBwcm9jZXNzLnJldCAhPSAwOg0KPiA+ICsgICAgICAgIHJhaXNlIEtzZnRGYWlsRXgoZiJOb3Qg
YWJsZSB0byBzZXQgc3BlZWVkIGFuZCBkdXBsZXggcGFyYW1ldGVycyBmb3INCj4ge2lmbmFtZX0i
KQ0KPiA+ICsgICAga3NmdF9wcihmIlNwZWVkOiB7c3BlZWR9IE1icHMsIER1cGxleDoge2R1cGxl
eH0gc2V0IGZvcg0KPiA+ICsgSW50ZXJmYWNlOiB7aWZuYW1lfSIpDQo+ID4gKw0KPiA+ICtkZWYg
dmVyaWZ5X3NwZWVkX2FuZF9kdXBsZXgoaWZuYW1lOiBzdHIsIGV4cGVjdGVkX3NwZWVkOiBzdHIs
DQo+IGV4cGVjdGVkX2R1cGxleDogc3RyKSAtPiBOb25lOg0KPiA+ICsgICAgdmVyaWZ5X2xpbmtf
dXAoaWZuYW1lKQ0KPiA+ICsgICAgIiIiVmVyaWZ5aW5nIHRoZSBzcGVlZCBhbmQgZHVwbGV4IHN0
YXRlIGZvciB0aGUgaW50ZXJmYWNlIiIiDQo+ID4gKyAgICBvdXRwdXQgPSBldGh0b29sKGYie2lm
bmFtZX0iKQ0KPiANCj4gSG93IGRvZXMgIm91dHB1dCIgZ2V0IHVzZWQgaGVyZT8NCg0KIm91dHB1
dCIgaXMgbm90IHVzZWQgYW55d2hlcmUsIEkgd2lsbCByZW1vdmUgdGhpcyBpbiB0aGUgbmV4dCB2
ZXJzaW9uLg0KDQo+IA0KPiA+ICsgICAgd2l0aCBvcGVuKGYiL3N5cy9jbGFzcy9uZXQve2lmbmFt
ZX0vc3BlZWQiLCAiciIpIGFzIGZwOg0KPiA+ICsgICAgICAgIGFjdHVhbF9zcGVlZCA9IGZwLnJl
YWQoKS5zdHJpcCgpDQo+ID4gKyAgICB3aXRoIG9wZW4oZiIvc3lzL2NsYXNzL25ldC97aWZuYW1l
fS9kdXBsZXgiLCAiciIpIGFzIGZwOg0KPiA+ICsgICAgICAgIGFjdHVhbF9kdXBsZXggPSBmcC5y
ZWFkKCkuc3RyaXAoKQ0KPiANCj4gU2hvdWxkIHlvdSBjaGVjayBzcGVlZC9kdXBsZXggZnJvbSBi
b3RoIHN5c2ZzIGFuZCBldGh0b29sPyBNYXliZSB0aGF0J3MNCj4gb3ZlcmtpbGwuDQoNCkkgd2ls
bCByZW1vdmUgdGhlIGV0aHRvb2wgZGVwZW5kZW5jeSBoZXJlIGluIHRoZSBuZXh0IHZlcnNpb24u
DQoNCj4gDQo+IFRoYW5rcywNCj4gDQo+IEJyZXR0DQo+IA0KPiA+ICsNCj4gPiArICAgIGtzZnRf
ZXEoYWN0dWFsX3NwZWVkLCBleHBlY3RlZF9zcGVlZCkNCj4gPiArICAgIGtzZnRfZXEoYWN0dWFs
X2R1cGxleCwgZXhwZWN0ZWRfZHVwbGV4KQ0KPiA+ICsNCj4gPiAgIGRlZiB0ZXN0X2F1dG9uZWdv
dGlhdGlvbihjZmcpIC0+IE5vbmU6DQo+ID4gICAgICAgZm9yIHN0YXRlIGluIFsib2ZmIiwgIm9u
Il06DQo+ID4gICAgICAgICAgIHNldF9hdXRvbmVnb3RpYXRpb25fc3RhdGUoY2ZnLmlmbmFtZSwg
c3RhdGUpDQo+ID4gICAgICAgICAgIHRpbWUuc2xlZXAoNSkNCj4gPiAgICAgICAgICAgdmVyaWZ5
X2F1dG9uZWdvdGlhdGlvbihjZmcuaWZuYW1lLCBzdGF0ZSkNCj4gPg0KPiA+ICtkZWYgdGVzdF9u
ZXR3b3JrX3NwZWVkKGNmZykgLT4gTm9uZToNCj4gPiArICAgIHNwZWVkcyA9IFsiMTAiLCAiMTAw
IiwgIjEwMDAiXQ0KPiA+ICsgICAgZHVwbGV4X21vZGVzID0gWyJoYWxmIiwgImZ1bGwiXQ0KPiA+
ICsNCj4gPiArICAgIGZvciBzcGVlZCBpbiBzcGVlZHM6DQo+ID4gKyAgICAgICAgZm9yIGR1cGxl
eCBpbiBkdXBsZXhfbW9kZXM6DQo+ID4gKyAgICAgICAgICAgICMgU2tpcCBmb3Igc3BlZWQgPSAx
MDAwTWJwcywgZHVwbGV4ID0gSGFsZg0KPiA+ICsgICAgICAgICAgICBpZiBzcGVlZCA9PSAiMTAw
MCIgYW5kIGR1cGxleCA9PSAiaGFsZiI6DQo+ID4gKyAgICAgICAgICAgICAgICBjb250aW51ZQ0K
PiA+ICsgICAgICAgICAgICBzZXRfc3BlZWRfYW5kX2R1cGxleChjZmcuaWZuYW1lLCBzcGVlZCwg
ZHVwbGV4KQ0KPiA+ICsgICAgICAgICAgICB0aW1lLnNsZWVwKDUpDQo+ID4gKyAgICAgICAgICAg
IHZlcmlmeV9zcGVlZF9hbmRfZHVwbGV4KGNmZy5pZm5hbWUsIHNwZWVkLCBkdXBsZXgpDQo+ID4g
KyA+ICAgZGVmIG1haW4oKSAtPiBOb25lOg0KPiA+ICAgICAgIHdpdGggTmV0RHJ2RXBFbnYoX19m
aWxlX18pIGFzIGNmZzoNCj4gPiAgICAgICAgICAga3NmdF9ydW4oZ2xvYnM9Z2xvYmFscygpLCBj
YXNlX3BmeD17InRlc3RfIn0sIGFyZ3M9KGNmZywpKQ0KPiA+IC0tDQo+ID4gMi40My4wDQo+ID4N
Cg==

