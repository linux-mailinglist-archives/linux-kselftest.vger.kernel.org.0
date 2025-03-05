Return-Path: <linux-kselftest+bounces-28320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 979C9A50444
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 17:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFF01188CC35
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 16:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989D7250BEC;
	Wed,  5 Mar 2025 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cUPPWPxO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77B41F63C3;
	Wed,  5 Mar 2025 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191148; cv=fail; b=K2cRA5xtmXmn9uU2lqC6TkgyQ1lRrwfO5zlRcjQ7pWZ+n5NfojZhVIU4ouycLuwY57ps99Wlix0MV3jPU7Tzyp/nJjhawzIKLTEk1x5hVcuGFb0jYKx7z/bDE//SOvIkmvYl1x7XIIdA/24fkpRYLcplLZHwcP7WiyIBZaVsaKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191148; c=relaxed/simple;
	bh=Hocjo7xilBp0NWnJPAvpD/oR8hd0FJvOZvuiYZy8yeA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AZjK/zPoyEWZT8cbpqwzXG4sML7ihKVEoMsv/Dt8jV+Bh9KlGhtfh4l25RseYrGSIcEef2k480VNVPRXbUfl8vEj6BQSLPiCJGJPMFuU7w2e7DZ6MKDKtB60z7xUkzdj/KGA3XoDTW7O1JP1p2kDX2BqYB2jugVsG0LkfrUlBDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cUPPWPxO; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJVg5OWWaS9efrPZMrp7jpYvEYVOkIUuilJb/nmtf7zfpDdGqS40XcwzwOAUhKheXEn7Y7725JS/pYOyBNqDFpaODHNqAR4WSdqF3RjgGw84nzLUJYJO3mqrAMbyQlsh3oB5A9A8saMhHhb8JOcD9koR3yuPp3T6bqJsnyS578IxAjDwAnrn/nRA4Jrkv3i5aF0WNBQC45QVP4TAqTQ6a0MSLujLWQNz/QpPvNDOsGD2RUtdFYDLgZc5pdaNUe1S+WWpMIFh+PvcC1U3Wl5+XCvPjLz3/JaX+JPpr69n7DXyGEIKNq0evA0Y6j/HCDUvRN5ODECVWaPYoD2WiStCCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hocjo7xilBp0NWnJPAvpD/oR8hd0FJvOZvuiYZy8yeA=;
 b=p30LDCsC6W5YsaUt9/xVZC6itPg0nx3Bsa98+1FbleBNHqT0o0x0lVpfy7y+eBbzUBWem6674D06jhmk5AQycLjlAyJy6Uy0qzsFgxXPdj78iTnJTnhU8c2zb2oocY7aEif8CCPHUe380Fzc8QhiQFUevLmJC1W/sslkkUfY6WUGlHi/e8qAK2uCZaJYrObJEd92gmoQDmAhcFPhaiH2ck0//pKtHfZ7DBWsDHrilbiuz6pgbCavCrDobL5NYsFfxI4ww2mm4R33QhW80H+1XdwOt1qucD2d0YZAmtIYxl87tmyBd/tCSBkyevhkYwZNktsq4Nd0TRKXzyXj3y1kdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hocjo7xilBp0NWnJPAvpD/oR8hd0FJvOZvuiYZy8yeA=;
 b=cUPPWPxOteAP2vx+uh7pRWyYLSED9B7SRkr+Mqnmo4Y+sJyVNf8ra/HTl9cjN7wjPSW0p8OoVV7x0KrFTVFIuk1Fnn0Fw3y8yiHTHMhi38s8CNqE62YYUnVFmd/7cI2SyxvtX9ylcJJ0ZLbdgyG2lq7637uEIbm/I8DdJwA6zTD2QxfEOnVzTVCRV9uI07eLjodzNW44oMCFitdfGfFzMaK6Fz1Z2EikjtqCRsb2+A9uq9x1+wwGnqIXZ4xo8mrwrSpfULzreqgLSF3vp2pDkj8XG4ptULymo1XdoX3+3NsX9y2wsYAZc0rfdGbMyfSvSAx2sca6V0G7VINXIwqWNQ==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 SN7PR12MB8169.namprd12.prod.outlook.com (2603:10b6:806:32f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.25; Wed, 5 Mar 2025 16:12:18 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%4]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 16:12:18 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "razor@blackwall.org" <razor@blackwall.org>, "liuhangbin@gmail.com"
	<liuhangbin@gmail.com>
CC: Petr Machata <petrm@nvidia.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "jv@jvosburgh.net" <jv@jvosburgh.net>,
	"jarod@redhat.com" <jarod@redhat.com>, Jianbo Liu <jianbol@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "steffen.klassert@secunet.com"
	<steffen.klassert@secunet.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCHv4 net 1/3] bonding: move IPsec deletion to
 bond_ipsec_free_sa
Thread-Topic: [PATCHv4 net 1/3] bonding: move IPsec deletion to
 bond_ipsec_free_sa
Thread-Index: AQHbjQb6WbrTtavr5Eegza7cWS6SJ7NkOeoAgABdn4CAACEiAA==
Date: Wed, 5 Mar 2025 16:12:18 +0000
Message-ID: <f9bf79aff80eae232bc16863aa7a3ea56c80069a.camel@nvidia.com>
References: <20250304131120.31135-1-liuhangbin@gmail.com>
	 <20250304131120.31135-2-liuhangbin@gmail.com>
	 <4108bfd8-b19f-46ea-8820-47dd8fb9ee7c@blackwall.org>
	 <Z8hcFSElK7iF8u9o@fedora>
In-Reply-To: <Z8hcFSElK7iF8u9o@fedora>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|SN7PR12MB8169:EE_
x-ms-office365-filtering-correlation-id: 560d39ac-7b62-4791-85d5-08dd5c008097
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?K1A2UzVabWJXOVNoUjV0RE52NzZ4V0I4NWdaQmwxOFptekVkLzdsL2pIcDhv?=
 =?utf-8?B?Z2k0bzk2c2dWWFR4dUZLN3pIZmJiNEllRHRrREZMOFcrMFdzRmRLZWVsS2JW?=
 =?utf-8?B?U1hQV3ZzY2VPc3lqWnlKaEZoNmloZzJDSXdMdWFNdTFYc3VpVFRBNDdiTUZk?=
 =?utf-8?B?T0syQUpnZjJSbXZiTFBCbk9CbE84TG9hdGtQMi9IeE5iMzZvT0h0OTRva2Jh?=
 =?utf-8?B?cmltaGlnWVJyZFN0UGdyNC9jOEF2MzBCeVllTEk1STlwVnBlQVJFTzZuaW9C?=
 =?utf-8?B?ZjJpSlFlWjVNSlJGYU9YMzdrUHhFOUc1bXN3c1VJcytHdTNnSDlTUWpWbDlL?=
 =?utf-8?B?UHZkL0FTTjZBZkFza1dlTURxUlljZmordHRBbWtWUW8wLzdHN2tPQllka3pU?=
 =?utf-8?B?TXhEN2lNSG8xZmVTV2NrSXg3a1J5RE5xelJRMXpnV2R0eHdBZGxneVY2Mmgx?=
 =?utf-8?B?THVvMDJxclVud1B5WUNabUZVaHRDMTJNZXZ0cnZRS0c1OUVuMThWNXRIeGtl?=
 =?utf-8?B?c1BTNmhBVWoveFkyQ0dOQzh5MGhoT0g1UHRNcmhLaVU5ckJXaGI0ZVVGdHow?=
 =?utf-8?B?YVlLaTJkUkRYTStKdVNHdWU3dlhaL0d6T2dKM2Z2N3ZMSmNVdjNnSGNyWHpS?=
 =?utf-8?B?bFl3UENPcEVTZDdndlQzcFYvaTRNRndOKzFBOE11QVVkOERnd3NWdTJPQWZG?=
 =?utf-8?B?RlQ4QWpod29pMEZlVnJobGx3UFFYQlhiV0RUcElMWnhKNVo4Q1pJREpzZHFH?=
 =?utf-8?B?UEYzd1kxT0NlR0sva0Z5YWhDNVM5eHFiWklRcG5BelM3OVJscHJtaWdPMWNU?=
 =?utf-8?B?bmhxRlVlNzdQdUhubDZuOHhQdHhrNkdORFpkcE5WcTZLWmIyTmdJSTc3b25W?=
 =?utf-8?B?ald2UnA3QlMzeXRSUTNZV0RkNW9jb1pxWkNlTEY3TG5Wa3dFRHhjU2Z4M3NR?=
 =?utf-8?B?MEpobjBWK2I1WTF6Q2h6UzN5eUZXZkxwbU45V284NG1Jb0RlZkhOUVlKdktz?=
 =?utf-8?B?MUVtT0srQXl3Qjc1cWIyQi9OOXZFVEJIeTM0TFc1MFdDdk51WEdVVUZ5Q3pY?=
 =?utf-8?B?ZUlPZFVFSFUwazF1blJnMUpPeHg5R1IvY3p0enpCeDJqc3pTTUJ0RTd1OFlu?=
 =?utf-8?B?Vmcram9kQXhUc0xHMGtJNXM1Y3lHeXlCcHUvUGZCVHNSM0lTekFWQ0MxQ1dE?=
 =?utf-8?B?N09RdURud0pHK0s3Y1J5a0o1THdXa0pia3R0ak5hWEE2NHRYUDNBUkJrNUd2?=
 =?utf-8?B?Ty9lNVRZSFFpdWV2WDZBdUdYT3Y3T2hkMytyN3pIRDJGM3AvVHRabHBmRmx2?=
 =?utf-8?B?S0p0dkFiK1FLYzJuWStHb3REUXRCOXltc1QvOWM2TmM3Rm5PemZseTl4ajFr?=
 =?utf-8?B?a1U5UHd5KytMZ0dDNUVMVnpEUDBwNWhvcC9JV2ljdE9sTkQ3YUs4c1VtUktz?=
 =?utf-8?B?OGNYblYxWTg1L2Y0TWQ5ZUZzUHBLdjhzQVNhYmlneVVFTUJVZlJhUVAvcFNl?=
 =?utf-8?B?N2dsMFZuL2dZc3FqcEhaSE9BK0lkUVVvSjV1SnhUUjFoQlJzQUZ6V1lQZ0dI?=
 =?utf-8?B?UURhN3g4dVJ1ZEU2bU40Zmo4WHl5dlgzcU1FWXAzcDFWWDJvM0F6SE1weG1F?=
 =?utf-8?B?UUpDUlJ3cmZQRDJMS25aaE9vOEVmK3VqQVFRZTdZb3U3UklpdWhKRG1pTndj?=
 =?utf-8?B?MytuZXNOUmlYa3ZSOHdTMFF3SU5mOHpaS0JWTXlEbERkeGxjWEZXSVQreFBs?=
 =?utf-8?B?QnVBK2MzbU1Fc3FzS3J6TTNSaXVkNkZNS1V3SE1nSS9WSGlpajA4eXBJSmE2?=
 =?utf-8?B?Z0prT3o5MjhrTmZxenczMHZKUFByay9tSG5pUnIwVUhrMWQ1TTVkWURUYUpj?=
 =?utf-8?B?MDdtQ3pscXhSanZTeUs1SXZITXhnUUJmY25pV1orVFpad2JUT0dHR2ZrV2dq?=
 =?utf-8?Q?8tJVlrZJZMOjbOewzUtH8+IxtyZVaTtS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dG40NCtYOHdWckNGMmdlSUxlMi9OcXVGOE1DbW5pb2ZUVnBCQkczS2FlblN6?=
 =?utf-8?B?a0d6ZVk1YlVkR1kybllpeWJEQnk2Z1FIN1RUSTJuWjdrNnNEQy9oUjkwYU40?=
 =?utf-8?B?SDVsNUk5dVBrM293V0hUeloxMFd2bWtDNHBMSGxMRE9NV1lBT1B5Z3lQYWxF?=
 =?utf-8?B?T2RFaFBTck5OTmtneW9Cd1dVUDRSY2Z6cnVIZEJaQmlXRmt4L1duZ045ZlFN?=
 =?utf-8?B?aEVTT1BQK20xd0lwc1hQMnJSNTlrenZFdTF5RGpnQ293dHdFN3FYZjB3ZTZ6?=
 =?utf-8?B?VWptZDZSMVNhTjZwWEFETkFDbXRqMkZPWm5lWUxJOWFUci9kQTZjMk5mSTk1?=
 =?utf-8?B?UUI3VEJSNnBwRmpSa1pPZjBRNlEzZnR5T0tHUmhVaC9vd3h2dlFNUnFlRXh1?=
 =?utf-8?B?OFIvcEpQVXRTN2t1RTJPeldTTzN3T0JMaVFlek4rd3BNb2tkTC9jUEthR0pB?=
 =?utf-8?B?YTdtaE5MVFdhZHQvWldMTm5Mb2tSZTRSRzR5ZGdsWC9rcUdYK2YzcUhzVm9R?=
 =?utf-8?B?MkQ5VjY3enpWS3JTMXBlZS9sVVkrUEhjTEVaZ1BDaEJaM0VkNjhRZzRzeGZX?=
 =?utf-8?B?NTZteGpxSkFJQ2IrYWphVDRDWWJSQzY0Sm9DN2pMRmlXT2VjR3RWM2tad2lW?=
 =?utf-8?B?UEhmemkvdmFVbGFWMFhWMHRUbWM2ZkxIaCtwT0JiOTNnS1k0cWlPQzE5NExV?=
 =?utf-8?B?dWE0ZDVZNmI4NGxoODFTN1dtSzMzUXVOeHBhR0cweHA4Z2ZUZzdVZUo3djdW?=
 =?utf-8?B?K3JYMDFOa2dZayt1N3pDOHYyWlVvWjZqY2dabjJxVlp0WUgrZ1FNZ1QwQ0F3?=
 =?utf-8?B?TVkzMXR4ajhJNTZpMmk5YkMvR0ZFeC9GaTRwaDRrcThwcmZ6aGpMclRYYVBD?=
 =?utf-8?B?UFlBSDdwUVZNOG91KzlzeDg0UWVIVmwyL0NENFhONlM4WFFEUWkwOEZMaERq?=
 =?utf-8?B?c2JyWVJvUVp3Wk5vdUd4VFpPMXVGYkNuZVgyVERNR0RycVhRQlB4ZmU1RWox?=
 =?utf-8?B?QUxtM1piSXp3cnZmblpNamhmc2JUS2prNld5Q1FIV0w3Y3J4SlZRNm84K1J3?=
 =?utf-8?B?UmN0d2NJRnV1bHNFWXBsYndFUzJsV3VlZllnSDNPWDJuWVVraEJZd05Jci9T?=
 =?utf-8?B?aG5iVjhjM3JxeElRM3I0TEh5KzY0ZitEMHM5VGF6SnVIbjZyTjg0bkpDK2gz?=
 =?utf-8?B?MDhWUUtDWGtPbFZYdFIyKzNiLysraWZ6TDdTK3djWFZJWlB2Tlo0akNRT3NQ?=
 =?utf-8?B?MFJCWjVERlR0SjVnZ3BqSEp0V3hIL05nOHh3V3VTQ3RUeEdlV0tMMnVjZm80?=
 =?utf-8?B?allFejY2akpoRXVtNjRYT2t0N0Q2Z25yQnFDWElSSjZhV2hvVE1PTElubTlO?=
 =?utf-8?B?WFNLUXZPUTkxSW1tVkdHbW9OOVBMVVRtZC9pNGtRcWpUalJEQ3lsenVDY2N0?=
 =?utf-8?B?RmlxTDJsY0hLWW9MUnRSV0twbXNvNHgwWDlLU1JJUy9SLzFvVmhUUUIzcHhY?=
 =?utf-8?B?WGdYZDlmU25TNjdtMG51RFptWUJ4QjgrNi9WQ0RTY2pIOXFPTkdtK0t3dG1k?=
 =?utf-8?B?N3Vud3VRL1dhK00rZWxqK0p3TEJYbENQem83UEtmZEt0K2hqd2tQUUxlbjIw?=
 =?utf-8?B?WWZiV1Q5WUlja0ZTenpRNHFOTDNSVG5MbDdraGIwdE1ZdWlnT2dXRlhKc3FN?=
 =?utf-8?B?dkxTcG9lZmg5cFdLUzY2ZWpWWnRxOUJkTjA3V21uKzRtL0tJTEc3cFNtRGJ0?=
 =?utf-8?B?ckVKMXBabi9icW1qWENhaUVRdFlZeHJ3R3ZMM004bGVETTJUdXBOWEpRRXVk?=
 =?utf-8?B?NEV1MGx3V2xuUXJpZXZUVk55UzNEZHlzUFo3UndwSkRlb0tJNW9QSHJnU3lU?=
 =?utf-8?B?dDVIZitxaEtLcDFPRXRkYlNlMXRMd0YwOHUwSWJ4RHZ3OHQzVFczTGdUN2N3?=
 =?utf-8?B?SC9Ldll3dENBamp0bzRsdzkxVGpFM0E0U2xOSmhvZlVJL2pCVjNCcTVscE9i?=
 =?utf-8?B?c3BjL0cvdkZ2Z3RoL2dHQlVuVmxFVXV1YXppUzYrRTBvWTQ5dU5BNE8rNEdn?=
 =?utf-8?B?NTZkMWlUYVRSMlhkZms2VkxBdHpYSUVYamorcnRBbVdRNnJDTG5qVFd1emFX?=
 =?utf-8?Q?wTrcjVnFRTqHLor7Yq+QU/2RX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A6EA72C279E444AA9C63B221935D48E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 560d39ac-7b62-4791-85d5-08dd5c008097
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 16:12:18.3079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lwXQsGmWXgMaJqeHoJHnGzVsTrVfCtAtu692SV6J1nk9dRLW+lAtPzp2J312nXht88XRPmTMfz4SSVdF2pG4BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8169

T24gV2VkLCAyMDI1LTAzLTA1IGF0IDE0OjEzICswMDAwLCBIYW5nYmluIExpdSB3cm90ZToNCj4g
T24gV2VkLCBNYXIgMDUsIDIwMjUgYXQgMTA6Mzg6MzZBTSArMDIwMCwgTmlrb2xheSBBbGVrc2Fu
ZHJvdiB3cm90ZToNCj4gPiA+IEBAIC02MTcsOCArNjE0LDE4IEBAIHN0YXRpYyB2b2lkIGJvbmRf
aXBzZWNfZGVsX3NhX2FsbChzdHJ1Y3QNCj4gPiA+IGJvbmRpbmcgKmJvbmQpDQo+ID4gPiDCoA0K
PiA+ID4gwqAJbXV0ZXhfbG9jaygmYm9uZC0+aXBzZWNfbG9jayk7DQo+ID4gPiDCoAlsaXN0X2Zv
cl9lYWNoX2VudHJ5KGlwc2VjLCAmYm9uZC0+aXBzZWNfbGlzdCwgbGlzdCkgew0KPiA+IA0KPiA+
IFNlY29uZCB0aW1lIC0geW91IHNob3VsZCB1c2UgbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlIGlm
IHlvdSdyZQ0KPiA+IHdhbGtpbmcgYW5kIGRlbGV0aW5nDQo+ID4gZWxlbWVudHMgZnJvbSB0aGUg
bGlzdC4NCj4gDQo+IFNvcnJ5LCBJIG1pc3NlZCB0aGlzIGNvbW1lbnQuIEkgd2lsbCB1cGRhdGUg
aW4gbmV4dCB2ZXJzaW9uLg0KPiANCj4gPiANCj4gPiA+ICsJCXNwaW5fbG9ja19iaCgmaXBzZWMt
PnhzLT5sb2NrKTsNCj4gPiA+IMKgCQlpZiAoIWlwc2VjLT54cy0+eHNvLnJlYWxfZGV2KQ0KPiA+
ID4gLQkJCWNvbnRpbnVlOw0KPiA+ID4gKwkJCWdvdG8gbmV4dDsNCj4gPiA+ICsNCj4gPiA+ICsJ
CWlmIChpcHNlYy0+eHMtPmttLnN0YXRlID09IFhGUk1fU1RBVEVfREVBRCkgew0KPiA+ID4gKwkJ
CS8qIGFscmVhZHkgZGVhZCBubyBuZWVkIHRvIGRlbGV0ZSBhZ2Fpbg0KPiA+ID4gKi8NCj4gPiA+
ICsJCQlpZiAocmVhbF9kZXYtPnhmcm1kZXZfb3BzLQ0KPiA+ID4gPnhkb19kZXZfc3RhdGVfZnJl
ZSkNCj4gPiA+ICsJCQkJcmVhbF9kZXYtPnhmcm1kZXZfb3BzLQ0KPiA+ID4gPnhkb19kZXZfc3Rh
dGVfZnJlZShpcHNlYy0+eHMpOw0KPiA+IA0KPiA+IEhhdmUgeW91IGNoZWNrZWQgaWYgLnhkb19k
ZXZfc3RhdGVfZnJlZSBjYW4gc2xlZXA/DQo+ID4gSSBzZWUgYXQgbGVhc3Qgb25lIHRoYXQgY2Fu
OiBtbHg1ZV94ZnJtX2ZyZWVfc3RhdGUoKS4NCj4gDQo+IEhtbSwgVGhpcyBicmluZ3MgdXMgYmFj
ayB0byB0aGUgaW5pdGlhbCBwcm9ibGVtLiBXZSB0cmllZCB0byBhdm9pZA0KPiBjYWxsaW5nDQo+
IGEgc3BpbiBsb2NrIGluIGEgc2xlZXAgY29udGV4dCAoYm9uZF9pcHNlY19kZWxfc2EpLCBidXQg
bm93IHRoZSBuZXcNCj4gY29kZQ0KPiBlbmNvdW50ZXJzIHRoaXMgaXNzdWUgYWdhaW4uDQoNClRo
ZSByZWFzb24gdGhlIG11dGV4IHdhcyBhZGRlZCAoaW5zdGVhZCBvZiB0aGUgc3BpbmxvY2sgdXNl
ZCBiZWZvcmUpDQp3YXMgZXhhY3RseSBiZWNhdXNlIHRoZSBhZGQgYW5kIGZyZWUgb2ZmbG9hZCBv
cGVyYXRpb25zIGNvdWxkIHNsZWVwLg0KDQo+IFdpdGggeW91ciByZXBseSwgSSBhbHNvIGNoZWNr
ZWQgdGhlIHhkb19kZXZfc3RhdGVfYWRkKCkgaW4NCj4gYm9uZF9pcHNlY19hZGRfc2FfYWxsKCks
IHdoaWNoIG1heSBhbHNvIHNsZWVwLCBlLmcuDQo+IG1seDVlX3hmcm1fYWRkX3N0YXRlKCksDQo+
IA0KPiBJZiB3ZSB1bmxvY2sgdGhlIHNwaW4gbG9jaywgdGhlbiB0aGUgcmFjZSBjYW1lIGJhY2sg
YWdhaW4uDQo+IA0KPiBBbnkgaWRlYSBhYm91dCB0aGlzPw0KDQpUaGUgcmFjZSBpcyBiZXR3ZWVu
IGJvbmRfaXBzZWNfZGVsX3NhX2FsbCBhbmQgYm9uZF9pcHNlY19kZWxfc2EgKHBsdXMNCmJvbmRf
aXBzZWNfZnJlZV9zYSkuIFRoZSBpc3N1ZSBpcyB0aGF0IHdoZW4gYm9uZF9pcHNlY19kZWxfc2Ff
YWxsDQpyZWxlYXNlcyB4LT5sb2NrLCBib25kX2lwc2VjX2RlbF9zYSBjYW4gaW1tZWRpYXRlbHkg
YmUgY2FsbGVkLCBmb2xsb3dlZA0KYnkgYm9uZF9pcHNlY19mcmVlX3NhLg0KTWF5YmUgZHJvcHBp
bmcgeC0+bG9jayBhZnRlciBzZXR0aW5nIHJlYWxfZGV2IHRvIE5VTEw/IEkgY2hlY2tlZCwNCnJl
YWxfZGV2IGlzIG5vdCB1c2VkIGFueXdoZXJlIG9uIHRoZSBmcmVlIGNhbGxzLCBJIHRoaW5rLiBJ
IGhhdmUNCmFub3RoZXIgc2VyaWVzIHJlZmFjdG9yaW5nIHRoaW5ncyBhcm91bmQgcmVhbF9kZXYs
IEkgaG9wZSB0byBiZSBhYmxlIHRvDQpzZW5kIGl0IHNvb24uDQoNCkhlcmUncyBhIHNrZXRjaCBv
ZiB0aGlzIGlkZWE6DQoNCi0tLSBhL2RyaXZlcnMvbmV0L2JvbmRpbmcvYm9uZF9tYWluLmMNCisr
KyBiL2RyaXZlcnMvbmV0L2JvbmRpbmcvYm9uZF9tYWluLmMNCkBAIC02MTMsOCArNjEzLDExIEBA
IHN0YXRpYyB2b2lkIGJvbmRfaXBzZWNfZGVsX3NhX2FsbChzdHJ1Y3QgYm9uZGluZw0KKmJvbmQp
DQogDQogICAgICAgIG11dGV4X2xvY2soJmJvbmQtPmlwc2VjX2xvY2spOw0KICAgICAgICBsaXN0
X2Zvcl9lYWNoX2VudHJ5KGlwc2VjLCAmYm9uZC0+aXBzZWNfbGlzdCwgbGlzdCkgew0KLSAgICAg
ICAgICAgICAgIGlmICghaXBzZWMtPnhzLT54c28ucmVhbF9kZXYpDQorICAgICAgICAgICAgICAg
c3Bpbl9sb2NrKCZpcHNlYy0+eC0+bG9jayk7DQorICAgICAgICAgICAgICAgaWYgKCFpcHNlYy0+
eHMtPnhzby5yZWFsX2Rldikgew0KKyAgICAgICAgICAgICAgICAgICAgICAgc3Bpbl91bmxvY2so
Jmlwc2VjLT54LT5sb2NrKTsNCiAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KKyAg
ICAgICAgICAgICAgIH0NCiANCiAgICAgICAgICAgICAgICBpZiAoIXJlYWxfZGV2LT54ZnJtZGV2
X29wcyB8fA0KICAgICAgICAgICAgICAgICAgICAhcmVhbF9kZXYtPnhmcm1kZXZfb3BzLT54ZG9f
ZGV2X3N0YXRlX2RlbGV0ZSB8fA0KQEAgLTYyMiwxMiArNjI1LDE2IEBAIHN0YXRpYyB2b2lkIGJv
bmRfaXBzZWNfZGVsX3NhX2FsbChzdHJ1Y3QgYm9uZGluZw0KKmJvbmQpDQogICAgICAgICAgICAg
ICAgICAgICAgICBzbGF2ZV93YXJuKGJvbmRfZGV2LCByZWFsX2RldiwNCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIiVzOiBubyBzbGF2ZQ0KeGRvX2Rldl9zdGF0ZV9kZWxldGVc
biIsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fKTsNCi0gICAg
ICAgICAgICAgICB9IGVsc2Ugew0KLSAgICAgICAgICAgICAgICAgICAgICAgcmVhbF9kZXYtPnhm
cm1kZXZfb3BzLQ0KPnhkb19kZXZfc3RhdGVfZGVsZXRlKHJlYWxfZGV2LCBpcHNlYy0+eHMpOw0K
LSAgICAgICAgICAgICAgICAgICAgICAgaWYgKHJlYWxfZGV2LT54ZnJtZGV2X29wcy0+eGRvX2Rl
dl9zdGF0ZV9mcmVlKQ0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWFsX2Rldi0+
eGZybWRldl9vcHMtDQo+eGRvX2Rldl9zdGF0ZV9mcmVlKGlwc2VjLT54cyk7DQotICAgICAgICAg
ICAgICAgICAgICAgICBpcHNlYy0+eHMtPnhzby5yZWFsX2RldiA9IE5VTEw7DQorICAgICAgICAg
ICAgICAgICAgICAgICBzcGluX3VubG9jaygmaXBzZWMtPngtPmxvY2spOw0KKyAgICAgICAgICAg
ICAgICAgICAgICAgY29udGludWU7DQogICAgICAgICAgICAgICAgfQ0KKw0KKyAgICAgICAgICAg
ICAgIHJlYWxfZGV2LT54ZnJtZGV2X29wcy0+eGRvX2Rldl9zdGF0ZV9kZWxldGUocmVhbF9kZXYs
DQppcHNlYy0+eHMpOw0KKyAgICAgICAgICAgICAgIGlwc2VjLT54cy0+eHNvLnJlYWxfZGV2ID0g
TlVMTDsNCisgICAgICAgICAgICAgICAvKiBVbmxvY2sgYmVmb3JlIGZyZWVpbmcgZGV2aWNlIHN0
YXRlLCBpdCBjb3VsZCBzbGVlcC4NCiovDQorICAgICAgICAgICAgICAgc3Bpbl91bmxvY2soJmlw
c2VjLT54LT5sb2NrKTsNCisgICAgICAgICAgICAgICBpZiAocmVhbF9kZXYtPnhmcm1kZXZfb3Bz
LT54ZG9fZGV2X3N0YXRlX2ZyZWUpDQorICAgICAgICAgICAgICAgICAgICAgICByZWFsX2Rldi0+
eGZybWRldl9vcHMtDQo+eGRvX2Rldl9zdGF0ZV9mcmVlKGlwc2VjLT54cyk7DQoNCkNvc21pbi4N
Cg==

