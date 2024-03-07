Return-Path: <linux-kselftest+bounces-6058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038718755A4
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 18:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 266E31C21538
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 17:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04396130E39;
	Thu,  7 Mar 2024 17:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ilVVfOj6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3232B12FB2B;
	Thu,  7 Mar 2024 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709834244; cv=fail; b=ak2KhAtHFvxEY2EMsI+A4kvMaBL2H4P3jPHxwqiE6lPG4mrsUw40pmI4gu5srBOS4L/0nIPrkC57X73lhBUgvwjCfqQBwcwTzITz4WTIKdzfXOcBKWOT2mbjJ8i4bZ1r8X/NEJgGtZSDf1f4fKf0bBad/9yj/V/Kf9145E+eUzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709834244; c=relaxed/simple;
	bh=6QcyQQj8J+ppOXPo1QP3xr1ZfyaSWHm/lZobsh2Z1kQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kUPMf1GF9/W7FNDds4FI3i6/26ZV4xi/ESvAzLbPCMworlZQr6iJtJ92AFK6cOOlfgzzY+vGvaI+WOCYppvO2bNZYzo3Zd90ZF9blyIEJjXAIccJwGrc/thjvxUG2sJ6EKE7LGPYVgQApnAwtOicO9+egKqb9PiGsRYpwFlMFO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ilVVfOj6; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709834243; x=1741370243;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6QcyQQj8J+ppOXPo1QP3xr1ZfyaSWHm/lZobsh2Z1kQ=;
  b=ilVVfOj6fEn66nQ1qvoKiyiVDhT2s6v33bTXzqGpmppBaUXj5qo6ne2w
   E/Bv+kDQuS5G2RAg788+li7h91J3kcsjauZx5GWFCe3XlwcwV/P3QhebP
   b9GN9Iw9Eoh1Vt8p8xj+r7BiSn1JsUZHYcdPK1c4PyR03SSMxIA4wH4hx
   0NtPifUF+6kG0gKZAx1Qsii7K8Y22s5c9Trpe5Fbj8ZH+nsGj2RIwECnY
   HkmhuOonpxx3oGWEOAGV2B+Pj7ldKQPn8b55WgZj3EfwR/iNnjSM87jc6
   3oUhE7dURgSWqM2DjtvwEXSNvzFO4OEiuvubJzwl1I82CS+63/pjWAtdC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4373938"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="4373938"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 09:57:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="14846524"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2024 09:57:19 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 09:57:18 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 09:57:18 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 09:57:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBE5hKjKSgnMepW/yxJTELPana3uefwRxs7JFEmI5pormIuPB9CQ0Cu+8cvSoAUTsnMRHfw258XeBiclrNtc7mkWLF9PcQWr35E4jVr2jAcMzXBFabOnGcH400BIXECCR36Z3ws/xKNfFKwGL5pXBvWtKRAZjsaSyiEZQyclwKlawiSsp+77rPqyOqnzJatU9H/pmW3mnG5HDoIcD9VokXPO4lpjuHq8mRKQoZxrF66t9UrUNZzx1+AHBfdQi8LyLa/Z1qFqNgeCvNalfFqf4f1u1VhHdup2SjmngPBqzaw414N0bVrsYr1HEtjfY5LNXO+uKhH6cKkKLXot4vN+nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QcyQQj8J+ppOXPo1QP3xr1ZfyaSWHm/lZobsh2Z1kQ=;
 b=YaszTmILa9NjaSTDHtZ8jCA/xg2UGpxGYa7XWXoDGV2amHp4aOGEphFIHKYoHXEAv76btnDVQ2JMJzyn5U6G89xDyKVJxS/I5ncXoxMlpA/bjGo6aDHytdQ6UMxNC0sB+fEhqEK9TywML7dyKZsEJS0QYugyYFCccI911axsWJ6ArwAOetChOnjQfEdo0l563RHZyGzg6I8nHpHq8AXgu9U+eeGQKqFW5TdNypstExuLhits5B74Ppw1EjFZT/Uc84KeY6V3g00KPRFyGGsCQ1OcmnOt2EUQgh1PTMhowM5Zzo8R5pynWniYMW4QiOrEg+7hcnAuEi/XYCfV7DXekw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA1PR11MB7680.namprd11.prod.outlook.com (2603:10b6:208:3fb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.9; Thu, 7 Mar
 2024 17:57:14 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::d5ce:2b6c:458:3ca9]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::d5ce:2b6c:458:3ca9%7]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 17:57:12 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>
CC: "Yu, Fenghua" <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	"james.morse@arm.com" <james.morse@arm.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Thread-Topic: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Thread-Index: AQHab7KwshA04b3b7kGAda4tCZ9C1LErPGXQgADHEoCAAIKhUIAAB+aAgAABPhA=
Date: Thu, 7 Mar 2024 17:57:12 +0000
Message-ID: <SJ1PR11MB60832DAD58E864F99A16FCC4FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <cover.1709721159.git.maciej.wieczor-retman@intel.com>
 <8a158ada92f06b97a4679721e84e787e94b94647.1709721159.git.maciej.wieczor-retman@intel.com>
 <SJ1PR11MB608310C72D7189C139EA6302FC212@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <o6va7b7rc3q46olsbscav7pla4hxot2g6xhctflhmf64pj5hpx@56vtbg3yyquy>
 <SJ1PR11MB60830E546B3D575B01D37104FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <159474e6-ef11-4769-a182-86483efcf2a6@intel.com>
In-Reply-To: <159474e6-ef11-4769-a182-86483efcf2a6@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA1PR11MB7680:EE_
x-ms-office365-filtering-correlation-id: 32dfaaf7-4403-4e3d-f2cf-08dc3ed00405
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8MBoQAwgPWL6ndmR0Z4wq7QIUyuQ9uxgwPEJPiXB0AtxeTfWOxoYJp/m26qgZI/yfVQTwasJ+CE3QJm7k+/fY4mZJGBMe24l1nBLNzHr7KoDPNZHhkfAZh9GP02jWvpEc2w5MK1E6t6YUpxLqyIH9LqKuKryTstOwtRp8AV4DnEeRdGbSA8cJB1ZOc9lVPUdYF6faT7UWmsXkORni1wP8B18AE7avO4R+qARsKvhSJ21wLcqbRsJpGDf4c9dQIcNL+k2eQq1i2k/evtp0HjjnttTZZ2QwZy+M6J9rEUlBev/xe5FwDWh87UD4X/wwKEavtS8qHXizbEZlPCsEngex87S53QtSIRGa5rBTyulS8Ete4VGMY/Y2+XdTjBWfF7W0W5kkliQ95fUdt8btGegT8jM9X8zqP4P8y9/tZ1YQM73HMYT64jaJ7Jq9pkcthVsTP2JTdqijtQPi+wq+nrtvWiq+Oqs5N2weneiZCNEuK7nbaZ0jyLl4AGfHEFiSedov4WfLRZMZoMLACj4cZ7yxdSYPcEkd1pRbzP8J2R0UFdikUqjEIQEPRSNkVRbKZ4HdDsBep7nk652MwJ3ECH52RE1x3iFlISF5rlyNBiZPOe+VDj9A4HBnk/sqERc/1ghxbg+Yq2pGHUvqBcTA4OqmA8APad3qrAJnsA1X9Be/D2JoIdCHU50H4RY7/mmpi2q4F4e9/u9iz3hEy4Nr20mm2mdCd3gteIWIV2jH9y5fto=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDUwcTRMMENtT0FMZzVLSDVqcENrQmxzOVNFNHl6YUxWRHRRL1EwNVl5dWVH?=
 =?utf-8?B?WGFXckVTUEdld3dDaWNId2ZuaXhSSkJ4bUFLQnVyWXN6NjRVN2UvREJJRlB5?=
 =?utf-8?B?ZDNBd1ZFR05KQ0FIZ2lSKzh2MGhkdWt2OTZNSi9RWFpaWGlLV1AyTExtaEdF?=
 =?utf-8?B?S2VqZXpVQWpMSkw5djliLzJVdzVlY3BtMFU3dzAxMkxwcUlrcHJrd0Zuc3Bn?=
 =?utf-8?B?bTdDTXhybHhSVmFONTRmQUFqRFQwMUE0Tk9OWGtENmF1L2c4b3B4VDdsVG5o?=
 =?utf-8?B?VkZVTzltem4rVlNEZXVQZHJzTFYwRUE1WFVzMy84M0NOM0pNRitCTFpHNk1I?=
 =?utf-8?B?STlPMEJyRUZxUWJGTlEwMXJPR0hmaTAwOVhEYXFNWUdRMi9hOTZORkRaOERJ?=
 =?utf-8?B?cUo3VXFFWExkMVF4WkxZOEJIRGptNVJiUlV2Y0I0TTk3R01DTmUxRDNDN1gv?=
 =?utf-8?B?N0ZUc3IxSmxtektlQVJWOGh1VjZGUlczS0lUWnd3bGNwYVhIaXhIcmlkWlhM?=
 =?utf-8?B?ZnU3Y1hET0pjVTVadGo2S2NaOFQ3ZW12dkNWa0ljdkEzWmQ4MEd0R0IvVGp1?=
 =?utf-8?B?cEFuM1JObkxJYUZZNDA5VXRBNUxKNzFJLzdXOXJGUGRIQTgrTWtFVDcrNlRo?=
 =?utf-8?B?b1dSeEkyVm1KY2pkSE5ZOFpoVStrd21PNFN1Rk1pQ3dRVzM2akNSUXk5VjhW?=
 =?utf-8?B?c1pQOTZhb1NoZUlSc3RxTmU5enp2QitDT2llNXpMaysvaEVmcVFIbnBuQkE4?=
 =?utf-8?B?dU45R0t0MFZab1IzT3dHU3AydDZCV0gzOG9XK25rM3pJUXJJNFUwU1FxdEor?=
 =?utf-8?B?dG14TmRjbERpa2xZSDVPL3U1TCtjVTBvRy9jN2ZFQ3prVUxnNHlxTUo0MzZF?=
 =?utf-8?B?eHVqOU5UY1dCMlV5c2JXQzZ5LzR4N01aQzZvM0RoT2g2bnNCK2ZWQ2xHNWdE?=
 =?utf-8?B?eDVzL1REWXc3enBMSERWaDdrUGk0UWNTdWJhNVFLSXVPbHFGQ0NWUnVKWVNY?=
 =?utf-8?B?alZlekJvSmtQWG1JTWpUVVZlSzVDOC9kcmx1TFhiUjJHZitYdHlFNW43OUo0?=
 =?utf-8?B?WEFoZ1dmQWpjMTFzVlE2aVN2N3poQzhiUThYS3BWRTlCeElPOGpLZzJtcFNJ?=
 =?utf-8?B?bHRiNml4aUs5ck5pemxHMm83SHNPeUV5cFZpdDk2ZnVvbmRNd2pnS29wUC9u?=
 =?utf-8?B?a0owUHdOTlhOUnZtQUJtQi9rbmJvWWtzTStqcDcwNTFJdGUwQXIwNVU4K3pj?=
 =?utf-8?B?eTFOUitHbVRsVEIzNVh2SDhTZHVzZmZXejRQbmhRdk9EU1k1ZG9TZ01jcm1H?=
 =?utf-8?B?b0hwZ1FlYStIVmx1OU44dWxFN0ZDTkZLdzhuTlN4c2hBUTdSdDZwTkZ5Ryta?=
 =?utf-8?B?Slk4dHpRdUwvYUpSR0ZIRTZML2l5Q3ZZcEhXOXdBQW1QZW1IZ3Z3cndHdUpS?=
 =?utf-8?B?SGJOUlZDUDdrUlBOcDllRDR1OHJ0eURtRmJYc3RqMnd3ZElLWlZTdlJnQ1Q5?=
 =?utf-8?B?TUFJTUU3Y2llKzd5c3hQYlZGMDVsTnhDdWRMYytEeWxaRzVITm5sTEFtaEJ6?=
 =?utf-8?B?R2cwZHNreXQ2a1QzTEVscGgwVHdJc3B6RjlqOTYyelhpcnAzWXNYdmJ1bGl0?=
 =?utf-8?B?L3JNNzFmMW83WHdBMUpDWnJRaTFkaVAyL3V1TG13clNLY1pHR25qVnZRc3ZS?=
 =?utf-8?B?UmpyVjdBUXdoNHNyaUdIeVpHTjVkUlFoWlJuUUdkVnp5QzFUWlNCMFgrR1Y4?=
 =?utf-8?B?UWRCdHp5UmwyVTdDSDl3Q0YwNGdVSGFaUThOMWJMS21wL01sWjZIVnBqSkZr?=
 =?utf-8?B?OCtXMlhWeEZmZWtSa3ZCOHZYeTFGUk5ZRWFXWlZLN1NvVmRTY2dHbWpuMzJn?=
 =?utf-8?B?V1VQMDVyYTBKUkhqZFROM3lzNVpFdTBvYW9kWTU3YmM1eGtRVlI2eC9aV3Nj?=
 =?utf-8?B?S25ldURYRExjcmdwY2RQYjZoQ0lBNlBJeFI4YU0rUUVSaEthUUlUNlVTNUpo?=
 =?utf-8?B?L2Zoa0RaQ2JBUzgrYUNDQUE2YXJoUGdEaDYxTzduY0c1STRTNXloelJZYWlz?=
 =?utf-8?B?ZDlGZEQ1THB1RzBXUVc1b2xabWZhamswNzdUeEljUDNyQkc3Qy9GbUV3OW10?=
 =?utf-8?Q?UEB2DC5a2xxLpI5O9LHo7hGpy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32dfaaf7-4403-4e3d-f2cf-08dc3ed00405
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 17:57:12.1154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a1AShrPHHkPhFt8XcFrOAY6VLxD9WBzp22xQz6C/KVWYSjhFkQYoZKQSarlvwk8VdU2xRUnTJgOe7qCFc/WObQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7680
X-OriginatorOrg: intel.com

PiA+IFNOQzIgZW5hYmxlZDoNCj4gPg0KPiA+ICQgY2F0IC9zeXMvZnMvcmVzY3RybC9pbmZvL0wz
X21vbi8gc25jX25vZGVzX3Blcl9sM19jYWNoZQ0KPiA+IDINCj4gPg0KPg0KPiBUaGlzIHdvdWxk
IGJlIHVzZWZ1bC4gSSBiZWxpZXZlICJTTkMiIGlzIGFyY2hpdGVjdHVyZSBzcGVjaWZpYz8NCj4g
V2hhdCBpZiB0aGUgZmlsZSBhbHdheXMgZXhpc3RzIGFuZCBpcyBuYW1lZCAibm9kZXNfcGVyX2wz
X2NhY2hlIj8NCj4NCj4gSSBhc3N1bWUgdGhhdCB0aGUgaW50ZXJuYWxzIG9mIGhhbmRsaW5nIG1v
cmUgbm9kZXMgcGVyIEwzIGNhY2hlIHNob3VsZA0KPiBiZSBoaWRkZW4gZnJvbSB1c2VyIHNwYWNl
IGFuZCBpdCBzaG91bGQgbm90IGJlIG5lY2Vzc2FyeSBmb3IgdXNlciBzcGFjZQ0KPiB0byBrbm93
IGlmIHRoaXMgaXMgYmVjYXVzZSBvZiBTTkMgb3IgcG90ZW50aWFsbHkgc29tZSBvdGhlciBtZWNo
YW5pc20gb24NCj4gYW5vdGhlciBwbGF0Zm9ybT8NCj4NCj4gSSB0aGluayB0aGF0IG1heSByZWR1
Y2UgZnJhZ21lbnRhdGlvbiBvZiByZXNjdHJsIC4uLi4gbm90IGhhdmluZw0KPiByZXNjdHJsIGxv
b2sgc28gZGlmZmVyZW50IG9uIGRpZmZlcmVudCBhcmNoaXRlY3R1cmVzIGJ1dCBtYWludGFpbnMN
Cj4gdGhlIHByb21pc2Ugb2YgYSBnZW5lcmljIGludGVyZmFjZS4NCj4NCj4gSSBhbSBub3Qgc3Vy
ZSBpZiB0aGlzIGlzIHNwZWNpZmljIHRvIG1vbml0b3JpbmcgdGhvdWdoLA0KPiB3aHkgbm90IGhv
c3QgZmlsZSBpbiAvc3lzL2ZzL3Jlc2N0cmwvaW5mby9MMyA/DQoNClJlaW5ldHRlLA0KDQpPbiB0
aGUgbmFtZSBjaGFuZ2UgLSBzdXJlLiBJdCBkb2Vzbid0IG5lZWQgdGhlICJzbmNfIiBwcmVmaXgu
DQoNClRoZSBJbnRlbCBpbXBsZW1lbnRhdGlvbiBvZiBTTkMgaGFzIGZhciBtb3JlIGVmZmVjdCBv
biBtb25pdG9yaW5nDQp0aGFuIG9uIGNvbnRyb2wuIFRoZSB1c2VyIGNhbiByZWFkIHNlcGFyYXRl
IGNhY2hlIG9jY3VwYW5jeSBhbmQNCm1lbW9yeSBiYW5kd2lkdGggdmFsdWVzIGZvciBlYWNoIFNO
QyBub2RlLiBCdXQgY2FjaGUgYWxsb2NhdGlvbg0KYml0bWFza3MgYW5kIG1lbW9yeSB0aHJvdHRs
aW5nIHN0aWxsIGhhdmUgYSBzaW5nbGUgY29udHJvbCBwb2ludCBmb3INCmVhY2ggTDMgY2FjaGUg
aW5zdGFuY2UsIG5vdCBmb3IgZWFjaCBub2RlLiBUaGVyZSBhcmUgc3RpbGwgc29tZQ0KaW1wYWN0
cyBvbiBjb250cm9sLCBlLmcuIGVhY2ggYml0IGluIGEgQ0FUIGJpdG1hc2sgcmVwcmVzZW50cw0K
bGVzcyBhY3R1YWwgc3BhY2UgaW4gdGhlIEwzIGNhY2hlLg0KDQpNYXliZSBtb3ZlIGl0IHRvIHRo
ZSB0b3AgbGV2ZWwgb2YgdGhlIGluZm8vIGRpcmVjdG9yeToNCg0KJCBjYXQgL3N5cy9mcy9yZXNj
dHJsL2luZm8vbm9kZXNfcGVyX2wzX2NhY2hlDQozDQoNCi1Ub255DQo=

