Return-Path: <linux-kselftest+bounces-22868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 511C59E5589
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 13:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D55FD2817BB
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 12:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CF91D5CFD;
	Thu,  5 Dec 2024 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wB2rR8s/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58900D268;
	Thu,  5 Dec 2024 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401854; cv=fail; b=gC9egBOIBi9qyFGmsp7Nxsfp7hDSkvnlmDUJZAvr471iE1x0s8bUxRFPbIV/O/zM1V3V8KA35U5y2qqAn8WYSNq+WvR/tCLWOQjHePhdKYVhlMLO9aLZT19vw6qME3GHddUjP+steDEYq2ptqjRJ5ZNZC+nwREjGSrM+MOQPC0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401854; c=relaxed/simple;
	bh=F12fcmLq7hqT4hZxrlxu0LBuvaAPN3qD/FQvce+PycI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IVdPeuCUUf1nL+jczIjRgwNE4GMgnTM63fGt7wZHlhEIPUT1DKaBIWBxB0zMeTbsiSGrwU4joNNI+QILBJBha9BOz8XHrwTGdH5MPWDomcW6zFjh1R2D7cgdsvXyDvzmOdvk/8cUw2LvcNOb4w4Owr3Wz8OuvO31tCO6gdvIyjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wB2rR8s/; arc=fail smtp.client-ip=40.107.96.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKwiJyYtNsQZHB8RmDmNjIcHNcMKhRmx2dfF0RW+Wx0lwBUsBVknCqx0DcHUAU/gwddL88HGB3u3Fmn2yQE1WvfJ5du/bKb2Elct0TnJw6NAFMraZEO7Cmy5gVMbKZlPkShqLlT1uUOl11qgsKavJG/hRH6FCGP37elu1kyqsSsHqPn1czHSGlpFcXMvcL7Ng9TgZ5p0GArnh/sRggL6bFJD2OpyVsgmHhePNpLX3DODxHunjFDZeZz1uiYpKuhzYVQfdhnV7xjxqoiYzUL6n1sfX4aHTQHO8Sslp+dcJIE6S+3bq2cSpTYyWaRI59RgHOAjW5k+OVRoj7LGE1GyDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F12fcmLq7hqT4hZxrlxu0LBuvaAPN3qD/FQvce+PycI=;
 b=J6p2xZ4PQhiF3zM6DlTDCRnx4AeZSQuFPNChwYjCWMjpBqB2CGi04J/LkontQG+aSG7tvQDt0KtCKNEpocrZK0R2WCnidlw+hND4Ay8TMvwJiMn6ROvwjCh55vCHHialYwc53cfjWCsmFTvM9jeH9gvshJWUIDUgCGx43YUcAt452TPy/KqKqWZ6+ozLDmKMibaKKbMlYs5HnOJ3pGqSUHrBNTVS3ttCwdvW+qUdxqO+Sv3EepJ5Cck2OPCzbhe22P87EoaoWp39v+Ok7x06xeGv755RpNhZJ/q9wdkBlDKnttxU2LgWXylaN+HHfmGO+HZYEsiAAwFoAnxZdSLF9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F12fcmLq7hqT4hZxrlxu0LBuvaAPN3qD/FQvce+PycI=;
 b=wB2rR8s/F9NsZjnFq3vgpj9pE9yK96BL2ZsHL3lo7ZjRc87VfmdtDHFb9McIw+IBTIrTGnCQrEe14ygwiiQi4e/tHXSlWXk3c62X8lbJB5EQQr2wJpmoqoTArvHk9Ym/iJ39OhzGKdJ8ukii0+tXtKb9Vu2CgSj0vHWSfsHuYl2w7kucBhECdxHht2O0W9iN4NHMbVtqj+2eQ925JVKRtbRQFqxNATrtL9qPiI2Py3unyjSKJ10sKZleCeSKj/PquXBJSov0epELOrgM9tNpc17L/rf5JkllcAdBmEHsjNJHy8KDetlvdpOhbnxf5BxlMa9LUIEnzu5rbvYedxzQew==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by DM6PR11MB4723.namprd11.prod.outlook.com (2603:10b6:5:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 12:30:49 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%3]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 12:30:49 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <sd@queasysnail.net>
CC: <vfedorenko@novek.ru>, <fkrenzel@redhat.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <apoorvko@amazon.com>, <borisp@nvidia.com>,
	<john.fastabend@gmail.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <gal@nvidia.com>, <marcel@holtmann.org>,
	<horms@kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v4 1/6] tls: block decryption when a rekey is
 pending
Thread-Topic: [PATCH net-next v4 1/6] tls: block decryption when a rekey is
 pending
Thread-Index: AQHbNrKXaeCB1x3kJUewXHrXMOK67rLXtaCA
Date: Thu, 5 Dec 2024 12:30:49 +0000
Message-ID: <fd808dab-1fbe-4530-970a-2b02fb27fc1e@microchip.com>
References: <cover.1731597571.git.sd@queasysnail.net>
 <327cb575d15fa5c5379f9c38a5132d78953fb648.1731597571.git.sd@queasysnail.net>
In-Reply-To:
 <327cb575d15fa5c5379f9c38a5132d78953fb648.1731597571.git.sd@queasysnail.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|DM6PR11MB4723:EE_
x-ms-office365-filtering-correlation-id: 47ea45e2-edde-4a4e-9713-08dd1528a66a
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cjl4aXpxemlBbEppL3ExVlBJL3dtNWUzMWdUbk9seWdaSDBQcmJNd2Q5dEpy?=
 =?utf-8?B?UFFuZEZZRGlvYUtrWmF5RG00WmY0TUFkV0Z0TWovRVQrV2I3N0tmTTJyS0Jp?=
 =?utf-8?B?b0lNOUFDUEpQZ2tFTzhKanJ4SkxTN1AwaHYzZGNNSWp6YlpUVHgySlk1ZHRa?=
 =?utf-8?B?WWR3aC8zdWhkamgvK2RRM3ZNS1F0Ukt4anBBUEUvS0sxQVJ3OHNEWm1WL3Nu?=
 =?utf-8?B?aW96MEVTR2phaG8rdkVGODhjWllscGVTdnZWN25ZdVlJTUdzQW1POFZkUW9W?=
 =?utf-8?B?ajhVbnpBVlRGZ2dGSHJNemQyMkxmc1pwUE5jbjQvTGQ4UjIzZzR5dS9kMlRi?=
 =?utf-8?B?SkF2K0tOb0IyL0lmeWtmaU5YaFZsVmVUbTZjZ1hPU2NhODcyRXFjdXdYdU1M?=
 =?utf-8?B?dzdKRmQ0QTZwV0JzVVZEbngrc2pibnQyeDc5cXJyMXNPN01lZTRLelp6WEdx?=
 =?utf-8?B?L2dINVZ5Skl6UWFUYnlrb0VmNmNiWEhtS0w3UnpoaUFnVE11N1doTFRmUTRN?=
 =?utf-8?B?RTZmNFZCT1VsTlEwZjdVZFNGWC8zai9ndU1Gc3MvRWtpaG9IaWRvSERvcjV3?=
 =?utf-8?B?eElYc1pMakhPQ2FITVEvbDZPZjZ2VmpjOG0vZlpjUGxQRzR5OE04VTBjM0Jl?=
 =?utf-8?B?bWZzNXEwUkhhY08rdTI2eUlHa2JIak96eS9FTFlWc0JaS2dtQVI5Yng1Vm9U?=
 =?utf-8?B?ZGVoQ1F5MksxQ1ZVZWNlNzM0bFZnbkxGSXNOYmpMcW1lOE5wODRnRUcrZHhw?=
 =?utf-8?B?V0ZNZDdlL2tnQ2E2Rk92ZC9vWjNuT01HK1VwMWVGU2huczZHR1BFVnNISEJX?=
 =?utf-8?B?NW1iS0gyNnJNdVJaTTdVbG80ekZXZGwrY0lNRGoyRkthVTJua0NHNVN6dHg4?=
 =?utf-8?B?MlV4Mkh0amF2Wldja0ltc05sYXRjdHZ0LzFKYUhhb0tqRmJ6RXF5cUVHQlk0?=
 =?utf-8?B?d2Q0UFJRQjdxQkNyck5MWDZRVGpGVm5ycGI2L004Q21SZmNHRkRYbW5IL2JX?=
 =?utf-8?B?Mk5pYUQ3Q0g3NTEzYnAreTBTWnB2Qmt2MEIrUisraWxjUi9aaGl1ZHlNdG5y?=
 =?utf-8?B?L1V1YWE0VUljMDR2ejJPeDdBY2ZsdlN4cGlaNnlXY0xHaU9MMDF2U0hWV0NQ?=
 =?utf-8?B?bm5HOHVjS0R2UlFqMHVzVEw5Q1ZFdzFFYVlUbFhQdzYrbVBkY2o0dVpGbW9N?=
 =?utf-8?B?dnRWTG1RalU1WFZtRDlQZWd0bTZEc2Y0dkhpTjlDeDY1TXJIYTlleWw2eHdS?=
 =?utf-8?B?NTh5V3Rlbjg1MXpZNVJ1Z3ljemNvREhNNkM1cDV3dnR2MEdZTnF1THBWcGRM?=
 =?utf-8?B?NGI1NkVqSVQ0bHJrRlN6TDJTSmp6ei9kajVMMTBYaC9kcTU3clBxM2k2MWFy?=
 =?utf-8?B?b2lrTTNUTXdDakpZVTA2ZWhGWS9VeGtYNmJQSkc5TGJIZDJOWjQ4SnkyREpq?=
 =?utf-8?B?ZlJxY256cUUrU2VEN1lyQk5acEJxSnl4YkwzbkxqU1NISXRPMjdwVkpSaTZh?=
 =?utf-8?B?dEJpQmRYSkVHZTlhRWd5dWp3U3A0WUZtRHdNVFR1SUR6Q1NWZE1qOHFwWDlL?=
 =?utf-8?B?b2J1WGtTQ1I2RVBSSGJ2SUhBLzg3dmFaeVN0TEdTMjY5UVdUWWQ5WDJSUWtO?=
 =?utf-8?B?dm1tbkFsN2wrT2ZjazY4d1RtYnF1dWNGdDJXV0R1ZVhjb21Pd0oxMzc1a2JO?=
 =?utf-8?B?OFVhTzNwcFRxUUpaTkNtbW9wNEkvbytNQ0IvR3NpNWpWd2xzcVVBSUFPSTlQ?=
 =?utf-8?B?a24wVGI3cFZGU3hVS0YrUHF4V3V3MElTNzVwWHVEZGtEMnJ0V0V3L0UvdnVq?=
 =?utf-8?B?WlBaYmwwdzE4SHFYdUJXQ0FQbkdtbkR5SmtjMUJxdklXTWZsTWU0bGpoaEl5?=
 =?utf-8?B?RCtFUlgzaWQzcHdCQm9qL2dNa2RwclNOSzlMbUdjU0JFNkE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MFJWR1ZKRmVYVk5IM1ZlcWtETmRPeWM5akduOEdhak5HNS94SVo4blI0TEhH?=
 =?utf-8?B?c1REYWs1TTRsL3FuK1M4TjdoNXVEcEdEcnRoMlhQeUI0K3BCeStQSUUwYkdi?=
 =?utf-8?B?WWMzRUlDTkN6VE9sYmxUQVJJcWFZNXV5UVN4TWVhMTZXRTkwRytNczZjUkVI?=
 =?utf-8?B?YzB0VG5GajRtbi9uMGVXVXBYU1FYemszci9ZaFdXY2RMZ082ZHJaeEp2SUY2?=
 =?utf-8?B?NzRXd05wdzQybG8rTVhwUDBKak56TFF5cTFaWDZvVEFiTlBEV3ZMNUhEUVRT?=
 =?utf-8?B?bVFJUlMyQUsyU01PWStCbmdWRGNGVWpsWHI3UHhrVFdsQzZVWHNZN3gvdVJr?=
 =?utf-8?B?K3A4R0E2TGxBN1NYS0VoQUdxREtwZzNLT1pjNDMxZmxIdFVRaHBtbTg1VCtj?=
 =?utf-8?B?Q2pNQXMzcUdXZlFweHFJL3R6aGNZOFlTU2dXUFh5SHhtTFhYNWtLNUFGR09S?=
 =?utf-8?B?SzZzbmtrY1l6SzdUQUdHVHZ1WjRRN1R0RzZJVk91dFdYa2RQR3FJeGhpR2dr?=
 =?utf-8?B?RFRZOEkwSDJwdkxWZll6YTcySmFlUzZ4UmdaTmFncmVzR2RPamZneVVhR2Er?=
 =?utf-8?B?UlBzcjUyRS9SVU1rRFJQVm5KbUVYQVd1Rnc0ZTAyaEdKWFBwc0VNZHhnQUhq?=
 =?utf-8?B?bGFQcW4zdEJCK09tWWdpTmsxSWdvVVFoOFNjWHlvOUltbWNkaGhORzZpUVVh?=
 =?utf-8?B?SUIvRWlHZlYzUGtWZmhMQVVWMytLUGwzcEpMVUlRbDY5QlNVdDgrNTF1UTRG?=
 =?utf-8?B?ZFBXcFhGYlhQVTFHd1RFL1dzSUJVUXFQRGJ6YjVxQ1E1QmprRktEaDQxVnlZ?=
 =?utf-8?B?NUxnbUs5UTB1WmVkSXRNSDRMMitOV0liQWtZcXBrWFY5VWNQTVVlWkxSSmJW?=
 =?utf-8?B?dmV4QjdEbEh4MjlZd1JHRjlQZXFkeXRsNFFMOWRpek9aUTlDTWp6RTlwOHVR?=
 =?utf-8?B?Z1VTcGNYNFhwSEpTRmZFaEZmMkNFN0N2dFRUV1k2aDRYVVFpNkhjWmxuc1ZD?=
 =?utf-8?B?NGtIZEtpTVE2Smtia09ZRjc5SXpCaUo2VDVHcVZhRDZKVE93SHVtKzJXODda?=
 =?utf-8?B?MlZ1SGlRWWJxbGtHMmgxK0o5dDhMc21tV3BlNk9zWForV2Yzb1VLK2J2WnMx?=
 =?utf-8?B?UCtGWTFTRUtNUFFtYnVoSGw2NlBUb3V1Y3hJSGhEc1B6QStsQm9SWDNjdmVK?=
 =?utf-8?B?d0RHUWNRbzAwMWdMWkpiOWNwRXdDTDU2SjNHMUJBWjZKQVhBN3E3WXFsY0M1?=
 =?utf-8?B?aitXN3R0VkZIUEpWYkFjc1dwTnJwM0ZKYllCT2FtcEJjNy9zZndyQnhPbkdu?=
 =?utf-8?B?YnNlRVRmbnhTZkFIUy9hYXBvRkdTa1pJaUM1c1RZVVJ2eWVrTmNQMWdOM09H?=
 =?utf-8?B?ZllxT3lYU3lramVwckNmVXhEQVFEcVJqeUwzLzFIY3NkbEUybHFYMis1U1Az?=
 =?utf-8?B?UGpPYTRFN2VId00veCsvc2d3RVNjalVmRlBRRjI2WmxYRG1Ed3pVVE5nZjlC?=
 =?utf-8?B?NFFkNXU4QmFmNHQ0Y0xWY0NzN2gyaGp3SFlaWnRzZnUvbnhLaytQQUlpR2Uz?=
 =?utf-8?B?NTE5aEkvWEJUNndMT0swNllzVzh6cnJ4NU1JSTdwNERvOE4vTTA1R2hxSTll?=
 =?utf-8?B?WUFuR3JmMlFta1lOcFIvZWNGdjdaNzhvZjJGcGJrZ3NWem9xTjh3dDg0ZlUr?=
 =?utf-8?B?dFM1SmlYKzhEcmRGRm9FMklOUEk3RDR1Nm5hTG83NXRKRW5oSHFib09sdVJ4?=
 =?utf-8?B?Mk0zSnFFMEgxcnRMT1hteFVETEdBNkE4c3c5NXFIdVpsZllhZjcxSGE5SDRG?=
 =?utf-8?B?V3FxT0J2bUYrZTNMZVcvQjlsd3lTZWZQQjBucnpQNDVKVzdrcDVSL2JKSmV3?=
 =?utf-8?B?dlh2c3IwdXNUZnpwOGJmbkwzQVU2a2pHek9rWEp4ZndwRjhjNjl2WEJna09R?=
 =?utf-8?B?U1BDUzJBYmtINWk1Z1VXbW92NXhWL2lieGlmUStzS1NvUC9MMCtVenE3bHNm?=
 =?utf-8?B?Mjd5NFp2R0JVV3FFcmdEZENVem9oSlFLWDl0bVVTcU1pUUFZYWsvd2c1S1Bk?=
 =?utf-8?B?aVpLU2tieCtZaktNS1I4Vmx1dGwraERXQnFYK3dBWms1eGpqS25rOVlqQWs0?=
 =?utf-8?B?OHExWWR3ZVRmVFVINWtSZE1Pa3kzekkzNlFaTzBtSzhiVHg0Unk0UGp0N1dk?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A458828C70A5D42A525A6D78753AFFD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ea45e2-edde-4a4e-9713-08dd1528a66a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 12:30:49.0771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 806oTsIFxMZwcY4prmJXB8YP/UtoYdM35BS271kowmiC/T3gFxr04FYsL4XLi2yQx9vS/DKQ8klvsbdd5jPe8uKKtsLlGSOGpgxgDoHSJpMd3V0dHcxj/kNirDfVQgxI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4723

SGksDQoNCk9uIDE0LzExLzI0IDk6MjAgcG0sIFNhYnJpbmEgRHVicm9jYSB3cm90ZToNCj4gRVhU
RVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVz
cyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBXaGVuIGEgVExTIGhhbmRzaGFr
ZSByZWNvcmQgY2FycnlpbmcgYSBLZXlVcGRhdGUgbWVzc2FnZSBpcyByZWNlaXZlZCwNCj4gYWxs
IHN1YnNlcXVlbnQgcmVjb3JkcyB3aWxsIGJlIGVuY3J5cHRlZCB3aXRoIGEgbmV3IGtleS4gV2Ug
bmVlZCB0bw0KPiBzdG9wIGRlY3J5cHRpbmcgaW5jb21pbmcgcmVjb3JkcyB3aXRoIHRoZSBvbGQg
a2V5LCBhbmQgd2FpdCB1bnRpbA0KPiB1c2Vyc3BhY2UgcHJvdmlkZXMgYSBuZXcga2V5Lg0KPiAN
Cj4gTWFrZSBhIG5vdGUgb2YgdGhpcyBpbiB0aGUgUlggY29udGV4dCBqdXN0IGFmdGVyIGRlY3J5
cHRpbmcgdGhhdA0KPiByZWNvcmQsIGFuZCBzdG9wIHJlY3Ztc2cvc3BsaWNlIGNhbGxzIHdpdGgg
RUtFWUVYUElSRUQgdW50aWwgdGhlIG5ldw0KPiBrZXkgaXMgYXZhaWxhYmxlLg0KPiANCj4ga2V5
X3VwZGF0ZV9wZW5kaW5nIGNhbid0IGJlIGNvbWJpbmVkIHdpdGggdGhlIGV4aXN0aW5nIGJpdGZp
ZWxkLA0KPiBiZWNhdXNlIHdlIHdpbGwgcmVhZCBpdCBsb2NrbGVzc2x5IGluIC0+cG9sbC4NCj4g
DQo+IHYzOg0KPiAgIC0gbW92ZSBrZXlfdXBkYXRlX3BlbmRpbmcgY2hlY2sgaW50byB0bHNfcnhf
cmVjX3dhaXQgKEpha3ViKQ0KPiAgIC0gVExTX1JFQ09SRF9UWVBFX0hBTkRTSEFLRSB3YXMgYWRk
ZWQgdG8gaW5jbHVkZS9uZXQvdGxzX3Byb3QuaCBieQ0KPiAgICAgdGhlIHRscyBoYW5kc2hha2Ug
c2VyaWVzLCBkcm9wIHRoYXQgZnJvbSB0aGlzIHBhdGNoDQo+ICAgLSBtb3ZlIGtleV91cGRhdGVf
cGVuZGluZyBpbnRvIGFuIGV4aXN0aW5nIGhvbGUNCj4gDQo+IHY0Og0KPiAgIC0gZmxpcCBUTFNf
UkVDT1JEX1RZUEVfSEFORFNIQUtFIHRlc3QgYW5kIHVzZSBsaWtlbHkoKSAoSmFrdWIpDQo+ICAg
LSBwYXNzIGN0eCByYXRoZXIgdGhhbiBzayB0byB0bHNfY2hlY2tfcGVuZGluZ19yZWtleSAoSmFr
dWIpDQo+ICAgLSB1c2UgV1JJVEVfT05DRSB0byBzZXQga2V5X3VwZGF0ZV9wZW5kaW5nIHRvIHBh
aXIgd2l0aCAtPnBvbGwncw0KPiAgICAgbG9ja2xlc3MgcmVhZA0KPiANCj4gU2lnbmVkLW9mZi1i
eTogU2FicmluYSBEdWJyb2NhIDxzZEBxdWVhc3lzbmFpbC5uZXQ+DQo+IC0tLQ0KPiAgIGluY2x1
ZGUvbmV0L3Rscy5oIHwgIDMgKysrDQo+ICAgbmV0L3Rscy90bHNfc3cuYyAgfCAzNSArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMzggaW5z
ZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0L3Rscy5oIGIvaW5jbHVk
ZS9uZXQvdGxzLmgNCj4gaW5kZXggM2EzMzkyNGRiMmJjLi44NzBlNDQyMWM1OTkgMTAwNjQ0DQo+
IC0tLSBhL2luY2x1ZGUvbmV0L3Rscy5oDQo+ICsrKyBiL2luY2x1ZGUvbmV0L3Rscy5oDQo+IEBA
IC01OSw2ICs1OSw4IEBAIHN0cnVjdCB0bHNfcmVjOw0KPiANCj4gICAjZGVmaW5lIFRMU19DUllQ
VE9fSU5GT19SRUFEWShpbmZvKSAgICAoKGluZm8pLT5jaXBoZXJfdHlwZSkNCj4gDQo+ICsjZGVm
aW5lIFRMU19IQU5EU0hBS0VfS0VZVVBEQVRFICAgICAgICAgICAgICAgIDI0ICAgICAgLyogcmZj
ODQ0NiBCLjM6IEtleSB1cGRhdGUgKi8NCj4gKw0KPiAgICNkZWZpbmUgVExTX0FBRF9TUEFDRV9T
SVpFICAgICAgICAgICAgIDEzDQo+IA0KPiAgICNkZWZpbmUgVExTX01BWF9JVl9TSVpFICAgICAg
ICAgICAgICAgICAgICAgICAgMTYNCj4gQEAgLTEzMCw2ICsxMzIsNyBAQCBzdHJ1Y3QgdGxzX3N3
X2NvbnRleHRfcnggew0KPiAgICAgICAgICB1OCBhc3luY19jYXBhYmxlOjE7DQo+ICAgICAgICAg
IHU4IHpjX2NhcGFibGU6MTsNCj4gICAgICAgICAgdTggcmVhZGVyX2NvbnRlbmRlZDoxOw0KPiAr
ICAgICAgIGJvb2wga2V5X3VwZGF0ZV9wZW5kaW5nOw0KPiANCj4gICAgICAgICAgc3RydWN0IHRs
c19zdHJwYXJzZXIgc3RycDsNCj4gDQo+IGRpZmYgLS1naXQgYS9uZXQvdGxzL3Rsc19zdy5jIGIv
bmV0L3Rscy90bHNfc3cuYw0KPiBpbmRleCBiYmYyNmNjNGY2ZWUuLmRiOTg3MTBjNDgxMCAxMDA2
NDQNCj4gLS0tIGEvbmV0L3Rscy90bHNfc3cuYw0KPiArKysgYi9uZXQvdGxzL3Rsc19zdy5jDQo+
IEBAIC0xMzE0LDYgKzEzMTQsMTAgQEAgdGxzX3J4X3JlY193YWl0KHN0cnVjdCBzb2NrICpzaywg
c3RydWN0IHNrX3Bzb2NrICpwc29jaywgYm9vbCBub25ibG9jaywNCj4gICAgICAgICAgaW50IHJl
dCA9IDA7DQo+ICAgICAgICAgIGxvbmcgdGltZW87DQo+IA0KPiArICAgICAgIC8qIGEgcmVrZXkg
aXMgcGVuZGluZywgbGV0IHVzZXJzcGFjZSBkZWFsIHdpdGggaXQgKi8NCj4gKyAgICAgICBpZiAo
dW5saWtlbHkoY3R4LT5rZXlfdXBkYXRlX3BlbmRpbmcpKQ0KPiArICAgICAgICAgICAgICAgcmV0
dXJuIC1FS0VZRVhQSVJFRDsNCj4gKw0KPiAgICAgICAgICB0aW1lbyA9IHNvY2tfcmN2dGltZW8o
c2ssIG5vbmJsb2NrKTsNCj4gDQo+ICAgICAgICAgIHdoaWxlICghdGxzX3N0cnBfbXNnX3JlYWR5
KGN0eCkpIHsNCj4gQEAgLTE3MjAsNiArMTcyNCwzMiBAQCB0bHNfZGVjcnlwdF9kZXZpY2Uoc3Ry
dWN0IHNvY2sgKnNrLCBzdHJ1Y3QgbXNnaGRyICptc2csDQo+ICAgICAgICAgIHJldHVybiAxOw0K
PiAgIH0NCj4gDQo+ICtzdGF0aWMgaW50IHRsc19jaGVja19wZW5kaW5nX3Jla2V5KHN0cnVjdCB0
bHNfY29udGV4dCAqY3R4LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KPiArew0KPiArICAgICAgIGNv
bnN0IHN0cnVjdCB0bHNfbXNnICp0bG0gPSB0bHNfbXNnKHNrYik7DQo+ICsgICAgICAgY29uc3Qg
c3RydWN0IHN0cnBfbXNnICpyeG0gPSBzdHJwX21zZyhza2IpOw0KTWlzc2luZyByZXZlcnNlIHht
YXMgdHJlZSBmb3JtYXQuDQo+ICsgICAgICAgY2hhciBoc190eXBlOw0KPiArICAgICAgIGludCBl
cnI7DQo+ICsNCj4gKyAgICAgICBpZiAobGlrZWx5KHRsbS0+Y29udHJvbCAhPSBUTFNfUkVDT1JE
X1RZUEVfSEFORFNIQUtFKSkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiArDQo+ICsg
ICAgICAgaWYgKHJ4bS0+ZnVsbF9sZW4gPCAxKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIC1F
SU5WQUw7DQo+ICsNCj4gKyAgICAgICBlcnIgPSBza2JfY29weV9iaXRzKHNrYiwgcnhtLT5vZmZz
ZXQsICZoc190eXBlLCAxKTsNCj4gKyAgICAgICBpZiAoZXJyIDwgMCkNCj4gKyAgICAgICAgICAg
ICAgIHJldHVybiBlcnI7DQo+ICsNCj4gKyAgICAgICBpZiAoaHNfdHlwZSA9PSBUTFNfSEFORFNI
QUtFX0tFWVVQREFURSkgew0KPiArICAgICAgICAgICAgICAgc3RydWN0IHRsc19zd19jb250ZXh0
X3J4ICpyeF9jdHggPSBjdHgtPnByaXZfY3R4X3J4Ow0KPiArDQo+ICsgICAgICAgICAgICAgICBX
UklURV9PTkNFKHJ4X2N0eC0+a2V5X3VwZGF0ZV9wZW5kaW5nLCB0cnVlKTsNCj4gKyAgICAgICB9
DQo+ICsNCj4gKyAgICAgICByZXR1cm4gMDsNCj4gK30NCj4gKw0KPiAgIHN0YXRpYyBpbnQgdGxz
X3J4X29uZV9yZWNvcmQoc3RydWN0IHNvY2sgKnNrLCBzdHJ1Y3QgbXNnaGRyICptc2csDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB0bHNfZGVjcnlwdF9hcmcgKmRhcmcp
DQo+ICAgew0KPiBAQCAtMTczOSw2ICsxNzY5LDEwIEBAIHN0YXRpYyBpbnQgdGxzX3J4X29uZV9y
ZWNvcmQoc3RydWN0IHNvY2sgKnNrLCBzdHJ1Y3QgbXNnaGRyICptc2csDQo+ICAgICAgICAgIHJ4
bS0+ZnVsbF9sZW4gLT0gcHJvdC0+b3ZlcmhlYWRfc2l6ZTsNCj4gICAgICAgICAgdGxzX2FkdmFu
Y2VfcmVjb3JkX3NuKHNrLCBwcm90LCAmdGxzX2N0eC0+cngpOw0KPiANCj4gKyAgICAgICBlcnIg
PSB0bHNfY2hlY2tfcGVuZGluZ19yZWtleSh0bHNfY3R4LCBkYXJnLT5za2IpOw0KSSB0aGluayB5
b3UgY2FuIGRpcmVjdGx5IHJldHVybiBmcm9tIGhlcmUuDQoNCkJlc3QgcmVnYXJkcywNClBhcnRo
aWJhbiBWDQo+ICsgICAgICAgaWYgKGVyciA8IDApDQo+ICsgICAgICAgICAgICAgICByZXR1cm4g
ZXJyOw0KPiArDQo+ICAgICAgICAgIHJldHVybiAwOw0KPiAgIH0NCj4gDQo+IEBAIC0yNzE5LDYg
KzI3NTMsNyBAQCBpbnQgdGxzX3NldF9zd19vZmZsb2FkKHN0cnVjdCBzb2NrICpzaywgaW50IHR4
KQ0KPiAgICAgICAgICAgICAgICAgIGNyeXB0b19pbmZvID0gJmN0eC0+Y3J5cHRvX3JlY3YuaW5m
bzsNCj4gICAgICAgICAgICAgICAgICBjY3R4ID0gJmN0eC0+cng7DQo+ICAgICAgICAgICAgICAg
ICAgYWVhZCA9ICZzd19jdHhfcngtPmFlYWRfcmVjdjsNCj4gKyAgICAgICAgICAgICAgIHN3X2N0
eF9yeC0+a2V5X3VwZGF0ZV9wZW5kaW5nID0gZmFsc2U7DQo+ICAgICAgICAgIH0NCj4gDQo+ICAg
ICAgICAgIGNpcGhlcl9kZXNjID0gZ2V0X2NpcGhlcl9kZXNjKGNyeXB0b19pbmZvLT5jaXBoZXJf
dHlwZSk7DQo+IC0tDQo+IDIuNDcuMA0KPiANCj4gDQoNCg==

