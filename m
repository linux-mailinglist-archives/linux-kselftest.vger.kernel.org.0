Return-Path: <linux-kselftest+bounces-11783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFC29059C0
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 19:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020871F21338
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 17:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACE017FAC4;
	Wed, 12 Jun 2024 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A081nWio"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2075.outbound.protection.outlook.com [40.107.96.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92679170835;
	Wed, 12 Jun 2024 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718212772; cv=fail; b=Ssk4nxFc1QxGB3dGwz2i8DfRnSjD2/Ajf0hYmskTzm/6lq2OBMvW7fMgPaoNtCwPIAWQwJBqLs8jNDseB1IWIPjyjrihXobt8bsuKtUsqFvCV/yGw5rm9KC+QmI8wX79hL4Q9onFoQ3NFMvur+yjO909IoqI7P6dv4WRT1Czt38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718212772; c=relaxed/simple;
	bh=9GYc/T6w7gakiMSKfODQ4+6VwQXkPJSFxXPJY+x9+Fk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sy4w5LGCh/vyLRD03KAh6OcIH9Jax+++FjvZFBqrCg+vSH6vnO/+p1AT1nHVAEHAI8Syqf5gxzwLWgRw28xA99NPXBcvzJq2yKsLhRBdD0ZRzGwDHIPwXxaI89ZnP7kq4QqeurFWsNMojJrwWx6ZOukxE7+AzxeJBEC0sQ95TW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A081nWio; arc=fail smtp.client-ip=40.107.96.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFxIZ7juZJpzznj/Xj3tWsZkeEK2kYJjysfsWqY8CLFQ0zirsLc0eJGTrZwaco00X4Lu2VT0Fm+TeMM+TFcrgyWp9DJusiw/lYDcxcXzkyPrmV9dF5uVKItcKpvsEumNlETFAMAirEGo5O75Gov6ra1JJR7nWYOLxOSApUb4eTEN48cvp7uXJqchibkkaIlTyuoiZSDF3qHNj34lvwjo6f1cJ4Kk4L2nUGYyiMp+D42ZzaidJHvp7RaXN/Jr9MAGup2uabVNIqtMDnLy9arXM+52HJ2kFV+YppzwVsCblLHReRPiGN6YZT2DyrQ94Bjz9ihN0iiih3uXGkleOvyd1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GYc/T6w7gakiMSKfODQ4+6VwQXkPJSFxXPJY+x9+Fk=;
 b=ErrL/B7wz/VUZhUZDM+yEesROAtpcSpmH4w8rIU0xQKZ8JbadvWZU8vJ5rdpwXybmnCFOQ7c3rYgCWsOyoa/3NSU9yTJs9DC6OMTn4UYRYVtbWsvyzd1u9bkfDVKvC1cFUSl56tH11FHGgXfH79IWnnZ0ww8sJ2BIx4PGc6tnMh5MRluVAHhReALTTWomM0JdVFfM12PTBuyYOIifXYT2E+s+DIc6JnODuFwlE1wlUQz9vt8UqAwJltuvj3yJySCQ9wFZyJDeONZd6691zab8ZLnWECnt7+dR43UW9wfxU/vzOIkt5FKXmUxNIItFLhh7XmSN8Tfd2KWqeZfo2s+Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GYc/T6w7gakiMSKfODQ4+6VwQXkPJSFxXPJY+x9+Fk=;
 b=A081nWioWQAzzWSpbin3/dQ4foBAkXkeHOqU6TYHdPN3EDGri71MgtAvkgDDbSNV4lDW7UPt5Q8I7axG374LiEh9UooFxd/yRjNt7YDMWaeQoJNnVWyECgeLzwABQOB51taWeQERhjvNH2V1i8x9vaOSWhh707ZkKc2zVv0ycwF80WKIxK2U6PJyEHcqUY3JcWErnxY9LuROWyZQL9oHfHmLTabe7jkHyi0pxEaevw9SjXxDEBqNYPWxeSsZgD3yKkc/jDBOKEZLResUNrWwkkRQ5uJfTPbXRWh/Tboka2hXFhtTTee5oLPsBBfJLuYzNmceiCDIPLvvAWjBXzEPkw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Wed, 12 Jun
 2024 17:19:26 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7677.019; Wed, 12 Jun 2024
 17:19:26 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "davidgow@google.com"
	<davidgow@google.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "venkat88@linux.vnet.ibm.com"
	<venkat88@linux.vnet.ibm.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/2] list: introduce a new cutting helper
Thread-Topic: [PATCH 1/2] list: introduce a new cutting helper
Thread-Index: AQHavOCMHD0XaVRJeU6ugErEvbQ0wbHEX5eA
Date: Wed, 12 Jun 2024 17:19:25 +0000
Message-ID: <8c0ce60e-769f-4afe-a45a-de48019e3c6b@nvidia.com>
References: <20240612155135.3060667-1-kbusch@meta.com>
In-Reply-To: <20240612155135.3060667-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA0PR12MB4382:EE_
x-ms-office365-filtering-correlation-id: 074cabaf-414f-4421-42c2-08dc8b03cf5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230034|376008|1800799018|366010|7416008|38070700012;
x-microsoft-antispam-message-info:
 =?utf-8?B?eWN2c0lMcVlRMU5ZRTd2QVFUaVRKZVFDV2c5dEhlQVZGZk1ZUWFRa2k2SXcz?=
 =?utf-8?B?S2g0VzhZWE1WWExOS3VVbUpLZ2V2T0ZEeFZmaWxsSUxoUE1lSGpXMW5OWDJ3?=
 =?utf-8?B?aGJQdk9rbk9KTmZXbW9pNUIyNzg1TVJsYUlCMks4Rjh6eWdId1hvam1GVVI0?=
 =?utf-8?B?emduWk5KSnBGTUxnZW9TV1I5WVdpU29HWWxpNXdtdWMwVUN3cC96OHhNaUt6?=
 =?utf-8?B?WkJnMU1lSjYwZ1RYU000a21jOHN6a2s1bVZwTkMxQ0tDV2JiRUVvcUZaOUZh?=
 =?utf-8?B?VTAvYnIrdnNUQUR2UmFwQVhGeHBJTUJoOUs4WVpzTFowbzZtcXhncURDa0lz?=
 =?utf-8?B?OE5wc1FkVi9NN05CNVNHeEc3N0U5a2xYVTdqQVNvOUlPaFBjUmpGcTVKR0Vj?=
 =?utf-8?B?S2J2dUFZRWlaR29TTXJRYW1wbFpnbGc5S0ZqOXpIcis4U0VzSXd1SDVKUk5P?=
 =?utf-8?B?UXBlbk5FdU44UmZaUGN3bTVuN1AvekpSbjRkaHZhdzMyVHZGWjN6SXVNM3lO?=
 =?utf-8?B?bFBEZEoyMGRVVHhaeGZ5Zm5RdHE3L3hoSU1IK2Yyait6U0RmYW85dE04NmJa?=
 =?utf-8?B?VjRZdjB6UlFqbEdhc2NWbzFvUlBlYjM5NklXNnA0WUgyN2QwNEVuU09YYlFr?=
 =?utf-8?B?RnNaVXJhZTFQM3I0T29FYnZKdmd6Q2M3LzJhK0hZUlE5bTUrUEVFMVFHQ2Zy?=
 =?utf-8?B?bTZ0T3hBdDUxOHVKUkV1cEtzZ2JTV3g1TEpyaDdya0ltL0w4dklKaTZENm1M?=
 =?utf-8?B?TkYvUnhBTFd2eHRIV291SjBhbFA2QmwwZ2Uxbm1IQkdmS1o5NGRLKzdXdThO?=
 =?utf-8?B?SjJaNHpnRVZSM1hoZVNZdEluUXpUWUkwaXlpQ3JsNndUY1JjcnQvcEw2YkEw?=
 =?utf-8?B?R0lHUlp3cmJYS1Jnd0JNZzNhMnBPUWxyYk9rZXZsRitqbUN5aVZua2gzUHE4?=
 =?utf-8?B?d2hXb2dudmtyNi9rcTM4enU5NDJYanhwMDAycmlhUzJFeXh2UVRwZ3AzYlor?=
 =?utf-8?B?aEU3V0s5c1duUHJTSHpObzJTc3NIRmIwQXJNdkN2bEZ1bzJCMnNSSzFTencw?=
 =?utf-8?B?dHVzWXh0OTFhSkNOVVZDc3phbElKelMxSlRqRzB1MXA3NjdZNGNTb041WkVa?=
 =?utf-8?B?dGNPQUd4aXdIZlo4YnNsQWkwUUVLUjRpYWpmTW9TRTg3R3dvb09ncWdjTDBR?=
 =?utf-8?B?aVE5eUhTSWhmbGE5RXpPV0JJSUNMT1RXQi9EUEVrWWlNWEZmU2NEVUhCamVz?=
 =?utf-8?B?ZysyOFp0UUFlbC9PcHdBc1hMbjVOdjZTanBoSnlYTGMvRm9HLy9CV3RCMGx6?=
 =?utf-8?B?VllWT0JwNUJCUm96Rno5Q1JDZ0QvUUo4TUdhWmExbjNjeEZHdHE5Mk1VODNJ?=
 =?utf-8?B?YlRobE5waDYxWjBQRm1MaGdrOXpPNVV6YXhhRDEyc1l1LzZ2eURKaG1Rdkcx?=
 =?utf-8?B?elhCL1NuVTFyOTNSN0JkQ0xPVjNKVFY0VWJ2aFZudFd1M1VvSDFDNVB4T1Bj?=
 =?utf-8?B?ZkN0WmhodlpVZGdyekhmNUw2b2szZEI4SGVBK2VmcVdPM2thSEJKemo2ZVhV?=
 =?utf-8?B?ajZKRnJsQUh2L0x6OVUwNVYwcGpiSDJIejBPWDdJKyt1UWlxOEN0ZC8wZ05C?=
 =?utf-8?B?clRhV3crT2dZWWFncXBXUUlaUUFwK3RGcHJNOEFJU2dmR21BZFFqUHlLUW1h?=
 =?utf-8?B?OWJrS3lOSmxrKy9JNGlMZEl5ZnY0SXNpWU1IdTMzR00rZWpRa3BLeGdHc3Rw?=
 =?utf-8?B?a3hpQ0RYVnY4bmNDWDlsRUgxVWVyTWlrTVllVjRobUxWdWpES0xud3lFUzBW?=
 =?utf-8?Q?Dd+XhT/dO2SuyP2DmgUT4TSGZLEjNfoAT4+TI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(7416008)(38070700012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QTJQRlZHRVRtMHV0NWduSDZ4US8xcEpTS1JtNk9sRDlHK3FZMnhTTWRjTXl4?=
 =?utf-8?B?c21IZS9ZQ3ZpVGxnaldaZEVEc3pwVGI3WWg5MmRvWWs5N0NSWExadmxOUEFI?=
 =?utf-8?B?N0wxT202OVBVODVZamwzVENQMll3ZExoMng0YkRwUDhvVzMxNndkTTdEZ05h?=
 =?utf-8?B?M1c1VjdIY1NNQUpKL3ZJVVArZEt0N2JucWpnQVVMVCtTWGtTYlRHajB0THJY?=
 =?utf-8?B?K3RESDFjNXR2Q3hIdDNJY0JOTTJFN0lJS0ptR0lkY3dVcFhJYlorOVYrZmlP?=
 =?utf-8?B?Q2hVdEJBaHQ3TUV3aTRBREd5dS9kY0xMd2RPMGpHdEhpTkY2TDlsRE5STWpS?=
 =?utf-8?B?cnlwUDc2aFBwT1oxaVZZQWNncStoeitzb3lpbm5aYVYremp3WFQ4QVA3dGF1?=
 =?utf-8?B?MEFrRC9tRDhYTXhaNHhPTnNUbFNpNS8vZ1kvL1VrWS9IMUlkb0I5KzRmWkxS?=
 =?utf-8?B?SUd0US9rbWsxS0V3NWpLNWVRWVpkdHdWQ1NXZ2ZzM0FscW1nUVJNVEJIMXNX?=
 =?utf-8?B?cm5IOUxWakdlNHhicjRTV0JrUHV3T3BBbktpalJyeHNRYWJFbkIxNzB2Y0g0?=
 =?utf-8?B?RHg4SmZhejFlTWhIbFRodzZhMk1hNUZjdGRaaVFaelZvYUNUOWNybHhPbHJF?=
 =?utf-8?B?RnZiamhOTGh3dkkwblNlbWtISlJQaytyMmtYZGNYYSt0Mm1pMnRBQVBkZHJX?=
 =?utf-8?B?VkxGVWRqU1hOZjkrOGZ1S3hVWHArc21WWXNlbE1acjdDVU9VMXVudEN1bXRX?=
 =?utf-8?B?aEdTZnlZQ2poaWVRWUFVUEY2RUxDa0E2aVFzS2c3aWl1R1VVd3hERzBncUNp?=
 =?utf-8?B?SHN5MHM2MU9PRUhDRUtmaFdlV1N3RStMK2RrNFBuWGJzSzB4RWl3Y294U0lC?=
 =?utf-8?B?Rnh2bFRJalpTdVhRY24vQWQ4WlhYdHYwTTJhbDVTQUhsODN6WkQ5aHhWYmxO?=
 =?utf-8?B?K2t4N3lOM2hUNGcwcHNQQWUvTi95SDA1eDJnQmhHOW1tWnVYREpiN0RCTWd5?=
 =?utf-8?B?YnczbFlxVVlDM2Jid1NHU25UejBuSWdtY3pkYlc2bEN1eVljVzIwQmExaTBa?=
 =?utf-8?B?VTZsUUFDZjUxTGdLaWovL3hlOCt5WlZNK08raG9zbmZKbGdSS05acE1zc1ly?=
 =?utf-8?B?RHpGZ3hhK2k3eDAxZHo3SldrNU9pNUVrN2ZHcm05Qlg2RVFtV1VYSnJZOGRk?=
 =?utf-8?B?TXp5NW10dGVPL2F1Q3BEc2h4NUQ4U1EvR2RCRWdyRFJ0c2IrcjhCU2thczZG?=
 =?utf-8?B?NXJuT3NHd3cxQ04ycHN6TmdXeHJQYUNRWXVyUXZIU0ZsRmFrZ29QRjFrVHB3?=
 =?utf-8?B?Y2ZVRk41QlhYNGllaHpnQUNLd0t0VTZ5Q3kwUHNSRTFkSTdCQkV1STdVME5M?=
 =?utf-8?B?clhDT1ByRkZjckZBa2F4WDhCRFVNZDhVTTRiOGgzME9xQ1VMUEsxTnVYK1lY?=
 =?utf-8?B?eUNrTUN1V1R2SWpJZWhlcjNMYzFmNFdpcmV2cmFOUmdLbHpSTDF3Q3VSaG5i?=
 =?utf-8?B?ZVBjWVpQYXhNKzJTTlFwMWZHR3VYUWtUaEY1K1BEdG44ZzhXdThXd1EvTDV3?=
 =?utf-8?B?Z1l5YnZZNzV2TzAzaEx5VHRzYkZJajQyQ2NPZzZ5RGo2R29QVFFKQVRlanhy?=
 =?utf-8?B?b3JZQXAwMmhrTjVQa1hIc2NaODZjckp5VmtGODNucnk0ZEZKZ25POVZGWWR5?=
 =?utf-8?B?aGtscnFPZVVzaTRMTHRBbGRkSzRDN21yYTZZSUJveDhobkxhT1JncHdLK2Ni?=
 =?utf-8?B?c2FZRVlOTklkcE1pMlg5NkdabUtLdWpFMVVtWXc5Z3pjSVVZdEd1OVNGQUUv?=
 =?utf-8?B?bWJTYi9aVGlObThFL3pOcUxyRnVmaDBuM2RFZm8yNk51VEpRVEU2WldheGMr?=
 =?utf-8?B?VlExcXp6N2dLckNwMW12emlDdjNYZEZZS3o4N1hxUWdYRmRqQXZOMVhRNjM1?=
 =?utf-8?B?TmFBNDYyeUhhWk4vTGFnRnVydmc3Q0VZai9IejluSWMyY0w5d0FHWnh4QWhV?=
 =?utf-8?B?QXM4OGUrcVlrQytYMnI3b3ZuNDBMMzBIY25tWDYzSVFrRHVaQ0xINmlYZlBr?=
 =?utf-8?B?Q09SdWFhOVlhMUZoQWQ2bmZFM2ZWS2lhV0tqSXpISkhqRkZmVFNReTMyN1ZU?=
 =?utf-8?B?bFlyTkpOTTlLcC9FdXZyaU85VktZY2pJdEt5ZUJzUUsxY3NhR3loZC9HdHNU?=
 =?utf-8?Q?cm1Ix38sf7Krgi9DjDlrveVf/Z9brs12FXKu9iueTP7K?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D3DBDF546C24D48961B7E9D1153E8BA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 074cabaf-414f-4421-42c2-08dc8b03cf5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2024 17:19:25.9626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: INuUt0K6Qi8xDHh8qWd/jRDqT/ZmGzL1JxpGczwMT8llNbkAblumKRNzpI3CjzKh9HbcU3LMaAASeQR64tGxaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382

T24gNi8xMi8yNCAwODo1MSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
IDxrYnVzY2hAa2VybmVsLm9yZz4NCj4NCj4gUHJvdmlkZSBhIGhlbHBlciB0byByZW1vdmUgZWxl
bWVudHMgZnJvbSBhIGxpc3QgdG8gdGhlIGVuZCwgYW5kIHBsYWNlDQo+IHRob3NlIGVsZW1lbnRz
IGluIGEgbmV3IGxpc3QuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEtlaXRoIEJ1c2NoIDxrYnVzY2hA
a2VybmVsLm9yZz4NCj4gLS0tDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFu
eWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KSSBkaWQgcXVpY2sgcnVuIGJl
Zm9yZSB0aGUgcmV2aWV3IGlmIGFueWJvZHkgY2FyZXMgOi0NCg0KIMKgwqDCoMKgwqDCoMKgwqDC
oCBoZWFkwqDCoMKgwqAgZW50cnnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgbGlzdA0KDQpub2RlIFszIHwgfCAyXcKgwqDCoCBbMSB8IHwgM13CoMKgwqDCoCBbMiB8
IHwgMV3CoMKgwqAgW1ggfCB8IFhdDQphZGRyIDHCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgM8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgNA0KDQorICAgIGxp
c3QtPm5leHQgPSBlbnRyeTsNCisgICAgbGlzdC0+cHJldiA9IGhlYWQtPnByZXY7DQpub2RlwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgWzMgfCB8IDJdIA0KYWRkcsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIDQNCg0KKyBoZWFkLT5wcmV2ID0gZW50cnktPnByZXY7DQpub2RlwqAgWzEgfCB8IDJdDQph
ZGRywqAgMQ0KKyBlbnRyeS0+cHJldi0+bmV4dCA9IGhlYWQ7IG5vZGUgWzEgfCB8IDFdDQphZGRy
IDENCg0KKyBlbnRyeS0+cHJldiA9IGxpc3Q7IG5vZGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIFs0IHwgfCAzXQ0KYWRkcsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAyDQoNCisg
ICAgbGlzdC0+cHJldi0+bmV4dCA9IGxpc3Q7DQpub2RlIMKgIMKgIMKgIMKgIMKgIMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgWzIgfCB8IDRdIGFkZHLCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIMKgwqDCoMKgwqDCoMKgwqDCoMKgIDMNCg0KcmVvcmRlcmluZyB3aXRoIGxpc3QgYXQg
ZnJvbnQgd2l0aCBoZWFkwqAgOi0NCiDCoMKgwqDCoCBoZWFkDQpub2RlIFsxIHwgfCAxXQ0KYWRk
cg0KIMKgwqDCoMKgIGxpc3QNCm5vZGUgWzMgfCB8IDJdIFs0IHwgfCAzXSBbMiB8IHwgNF0NCmFk
ZHLCoCA0wqDCoMKgwqDCoMKgwqDCoCAywqDCoMKgwqDCoMKgwqDCoCAzDQoNCg0K

