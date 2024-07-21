Return-Path: <linux-kselftest+bounces-13974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448329385C2
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jul 2024 20:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE7A280E53
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jul 2024 18:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1242167DAC;
	Sun, 21 Jul 2024 18:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fVx0voeg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA971DDD6;
	Sun, 21 Jul 2024 18:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721585348; cv=fail; b=eMeWRzHRCP6BLgeShoNnFDpcRE4WKLPFJq8xE5RoBmExASHMOGNxqU04PdNI0AzKlVdnmv+cap3zbCYoGkeJiN0aFfyYYJ61giQD4RBIsP1ajXIvu7efdjJcq5JpfTtpfb39UOSYpQJa43Mv7tCTdUxz8yeEAH/d9H0wBrFCO4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721585348; c=relaxed/simple;
	bh=YVv5MRmaTgNkDhNo2sqXs3oAC8X6H2kBTTTSTTlZkfA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fPis4q6N9dMQ+XTx8quN8kSYiMtN0fDej6zkSsVGONt/XKbLWHlz3RkRcTfZaB7n4AK23d6VwQFSKeX3usZzmGkJpMouJaI2/b+BwY6riBkCTv9xxce+4M2TmeNU5u+G1rNEWjs2SHj86nUKfVO6ySbiEv3jTeHJkbzzL+vnu88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fVx0voeg; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721585347; x=1753121347;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YVv5MRmaTgNkDhNo2sqXs3oAC8X6H2kBTTTSTTlZkfA=;
  b=fVx0voeg1BzNbtPsP65FTK6giQ4plxDN1VnCn/xBqElbTURUYho0pk7M
   GFS4P8MCEunIf2xvVqp9MxfUtIX2jftPKf6f+qV6vMVcGkm0q6TIJg1CL
   we2/AZvuvLiRndKejVAsHkNYok5OxtW7EbK9zu+ctiKQwPHkLDzIv3KmD
   kjVkWdqpHGv46RkdsrC//T6vO5b5nrprejxJZBOEW5BfiPQ0CK0HnFFTV
   8teIc6twQ6BSoi1tN6ubkIKJ5W5+gUafMkg/meXq2SfMavonnhj32HYTm
   WKSb8yRP2Y6hV4oQQW18pyLplv2A/fzHquPF5PpA+OV5hYPJJhbk0OT1U
   A==;
X-CSE-ConnectionGUID: Q0V4mx33Q1iZ7seGqo0ZxQ==
X-CSE-MsgGUID: zybH0RzcThe5pc/TE04eGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="30573662"
X-IronPort-AV: E=Sophos;i="6.09,225,1716274800"; 
   d="scan'208";a="30573662"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2024 11:09:06 -0700
X-CSE-ConnectionGUID: V+fJX+trQ6KMFUxH33FbXA==
X-CSE-MsgGUID: dzJ2VtWHTfihdFn0Yzen2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,225,1716274800"; 
   d="scan'208";a="56757759"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jul 2024 11:09:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 21 Jul 2024 11:09:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 21 Jul 2024 11:09:04 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 21 Jul 2024 11:09:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCv28PC+JKC/sDqawU3pfYARHLB8GtTZzX7Ai6w5P/VpXmwMquZgH7tQpEhT+yumIJHur7+yU61Tf3gtuo4GRTyrVevfXNoFdNmim3UIof1Q4FuunQWFYxFeN3B+5axGJ5jSut188A7QmjyTlR3IHTB6o1Z9W05vdrfuZ2VtPgRtSwQuOaeEUkm5DqiV1ym8lNOtohBJ0LCCG8uamugxhmqHH7zaBQyGCb0fkVdFYdYwYVl1+rAbSsm43ulVP/Olb8jf+5kl8KSl9Df8L+uL5z5lRZArOVND6R2XQjOT4ba7aSaVk2QdaYjpRMWC1lth9qEVj2S+chtdVq0lX6vD6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVv5MRmaTgNkDhNo2sqXs3oAC8X6H2kBTTTSTTlZkfA=;
 b=GtT507yMIWTyWnO2/V9mcf07jNqOAbt8m6/n8OaU7+WUe9YkyPx2M/mTOmrBXKNIJK31J38Yyx20Rjbgv2jegrwqguRyEx24lZOgcFnSQ9chbksNvYGtf9mR0C65FATOX2GGKv8Dw3xcZ3FOMb8zUAX+lNyPElgh60KGykM8d8Wgn+Fg6e/EAGZTM0t7LY6VY9m41h1Iww56vlKpi8XYjo8jZs6wX8QdJKhBpURagnzZG8T1aCs/R2i2/dZeszW0MkvvRxcWplTtTFcxN+NR1PPVUrAGAZotfK2X/TvRshAye6fWMFvEdPdPdXGEa6UT2JfEC6RBotmHpgEvOf7aYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by CY5PR11MB6391.namprd11.prod.outlook.com (2603:10b6:930:38::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Sun, 21 Jul
 2024 18:09:02 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::fcf6:46d6:f050:8a8c]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::fcf6:46d6:f050:8a8c%4]) with mapi id 15.20.7784.016; Sun, 21 Jul 2024
 18:09:01 +0000
From: "Li, Xin3" <xin3.li@intel.com>
To: Sean Christopherson <seanjc@google.com>, "H. Peter Anvin" <hpa@zytor.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "shuah@kernel.org" <shuah@kernel.org>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
	"xin@zytor.com" <xin@zytor.com>
Subject: RE: [PATCH v2 09/25] KVM: VMX: Switch FRED RSP0 between host and
 guest
Thread-Topic: [PATCH v2 09/25] KVM: VMX: Switch FRED RSP0 between host and
 guest
Thread-Index: AQHaWe/p8mDo/Zfb1Ue0O++EkKDe07HFceqAgCsrPICAA4rmgIAJ0EaAgAE88QCAAzp44A==
Date: Sun, 21 Jul 2024 18:09:01 +0000
Message-ID: <SA1PR11MB6734B878A371049E274D6E60A8AF2@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-10-xin3.li@intel.com> <ZmoYvcbFBPJ5ARma@google.com>
 <SA1PR11MB67348BD07CCCF8D52FCAC8FEA8A42@SA1PR11MB6734.namprd11.prod.outlook.com>
 <ZpFH86n_YY5ModwK@google.com>
 <099D0BF1-BDC6-489F-B780-174AFEE8F491@zytor.com>
 <ZpqNREwyn4LzN2tp@google.com>
In-Reply-To: <ZpqNREwyn4LzN2tp@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|CY5PR11MB6391:EE_
x-ms-office365-filtering-correlation-id: 5628728f-2c34-4c4f-b69d-08dca9b03348
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?L1Rha1llbUlYSTdUNldiUkRjYkZnTnU0V3VQU0NKRzU2ME1RK2ZpSHJTK0ZH?=
 =?utf-8?B?Y3h3NGlCaEpNYlQzeWpiOVdPMjI3TTY5OTdwZDZZenVvTEh1cXF6MXhmQjhs?=
 =?utf-8?B?Um5CZzBuRGNzT1h4VG1MdkJZMTg1ZUw5a0h1N2pGdVY3MHp3alpmWG9Mbnk0?=
 =?utf-8?B?aEs5bVp3NlEya1luRnZ0RU5KOU02TDBnRHBmd1VWWUxncTZRbG9reStOY2Jn?=
 =?utf-8?B?aWFIZER2NVM5a0NUSUZwNVlqR3NNN0FwMFU5MTdsOWhxVUhvL1NOR1hqTGxl?=
 =?utf-8?B?ZkFEU3JtaEZMSEtDTzVPZ09lbENZMVg1NWNKcmVPbEFSWUdGalhuTlBMdWI3?=
 =?utf-8?B?enlJbitjMzZLK1JEOHJVYnlSSS9BOHFORGtsWU81eDJUUzJYc3FWZ0JycXZv?=
 =?utf-8?B?M0VQWThhZXNDMDVUMEJuV2w2RFlFWDFFdGNTRk9VejVVVTB5RWkrZ2FUdldG?=
 =?utf-8?B?OE9zR01RTFhoc3JCbXQ4UmxOVWFiSVZhdS9iaVVwbXdnSE9qeE44bXpaWmZZ?=
 =?utf-8?B?VVcrb3AxL1ZQTGJYbXJFTTRMdkpIUHJLVWdkVUUrWmRzSEJuTzhZK0gwUjgz?=
 =?utf-8?B?Uk15bjZpVUJnbGlhZk51QzRzTkd0SDdYTVNocDA0b3JlbENZRVNhdmdROHkr?=
 =?utf-8?B?WWhiVHAweEhqVDZKbGYxZUU3cVRkUHp4TGx1amFqWDZ5RmdKeUFQVXFMdCsz?=
 =?utf-8?B?WXRIMFdOZmFrUjdRS1dhbGttNzVJbG9FZzJNeXhUa1ZyU0NKanp6MnQ5OFlh?=
 =?utf-8?B?L3BkdGYzNE5veEpOUGQvMm14RkJZWFhKQXNYRVFUVG8zRnRXWHdYbDB5blFx?=
 =?utf-8?B?bXlob3RuUmQzQ05FaHdwU2Q3M29RcnpvOTkrcllybE1qZzI4Q3NKV3VoVnRC?=
 =?utf-8?B?Q2NtSnVvZURoclBXMWo3T1k0ZnVkVXpwQjhLTXhaeTA4VWpUY2hlS0VBSktI?=
 =?utf-8?B?K2RMYXA4SnNGYnZnNCtGTmRnMkFhS3FnSkJoOGJPMFhaOG5MNDBFYm5EWVRM?=
 =?utf-8?B?SzZVMm5WZVJteUx1R3ZkVTRwR2FySWtNejQwdVNsZVV4YUdqYmtOYUFpaVRh?=
 =?utf-8?B?SUUvWkM5T3BmaVExNk9NcWxjVUhlTGhkS0VRK2tqTExjeDNWV1EwbmtCOUJt?=
 =?utf-8?B?emh0Tmg2WG9ZZTRnVWREZ3I2c1pYWjhUdWNFekNxQjgwS2NMT0Z1T1o3dnRK?=
 =?utf-8?B?dkptUnVRdFB0NHM1ZTk0Q1h1ZGxKRldybmlWVGtYTTNtM0JBdEwrRC9JU3k4?=
 =?utf-8?B?YTlIM0xpL01CcXRiTHk0aFpwTnZIVExmNklmOGtwaDUybE0yNWRtQnNPNW40?=
 =?utf-8?B?cm9mRHFWTGREdTYrSHBxaHROcVdhd0llR09SemlLOGUrbXhMai9vMm10UGZv?=
 =?utf-8?B?eCtWdHNrZW4zYW0zNHVleUQ4SE9jd2lsMEFYQkphMk9aYi8wMDBLZUNwMHpx?=
 =?utf-8?B?QkVoZWVaOGM0YkFsNDNVWlQ0ZG5LWngxTWdDWEttcVhxakwvUVY0eGZMZi90?=
 =?utf-8?B?Zit1WU5MUW5Kdi9kOENRc1hHVW1oVUp3VHZ3TFFFMEU2TVRjKzh1OXAvblJW?=
 =?utf-8?B?RmhOYzNnSzlHM3RXblZraWJKYkNXUW04WmMwL0FERm1zQksxcmNCdjJVWllk?=
 =?utf-8?B?SjRWbXZzT0ZsbDJad3c2N1JpbkNieHA5aDhTK0dnTHV2WG0wSTJoWnB1QzVy?=
 =?utf-8?B?MFk3MXdOcEczYkErSUxGb3ZCbXNVVXhGdFZMVkI4M3pxZGRWTksyUndnb0RE?=
 =?utf-8?B?LzlFbmh3SmJRU0RITUlCcW1tUFk5b01PclFtRVJwMks4WW1uUG5WTHNjNjhr?=
 =?utf-8?B?ZXl2ZEtVeTVzOXoyWEhIVnY1VG9HUHh4eTMxNnIrcTFSakxmQ3Myd1l5b21U?=
 =?utf-8?B?T21rS0xYenBWVUs0cktMQXRsSmNyb0hIbk9aNnpkZ082NVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEdyeEZhZFRmN3pPZ2FsNzl1NUdXWjVadTBxVWtsUTZHajJUbEZLSXZWcGtB?=
 =?utf-8?B?YmNiOGNnQkovZDdLTGFoc0JzUi9wQWN0MlpmallvU0sxb3pJc2c2bzE2WFdi?=
 =?utf-8?B?aC9RVkQ3Vm9IQ3BERzQ3VldxdzZGWm90VE1hMmlERGRZeXhzOUZ3L3FiMlM2?=
 =?utf-8?B?RHQrK1FUVzF4SVV5NS9lSEJkUlo3MENxTXhQTk4xSjJHdjlCdUdwOHZUNkZS?=
 =?utf-8?B?ejArSmlSblBUaldNemVoVEFpd2pJY0FkbnVNR2EzbEFDaG11eXpjQ0dsL2Nt?=
 =?utf-8?B?TFdwdXU0c1ZQQkZTMzNIMlJMWThPclVaeUFsb2pVWWVGMkI3ZWpzRVc4b3p5?=
 =?utf-8?B?blY3TGNOM2x0d2NiYlMzQkxBd2MvWFZ5YjliM3JheFVhZmFtZVNNY0RFUGNU?=
 =?utf-8?B?RTBCdnRGZnlXZERNMHd6aVJVTHUrcGpYSTVnMEhjNVQ3ci84Zzh1YWJGSEY5?=
 =?utf-8?B?SC9CWTZidTc5YlhSZjZ3bzA5c0N2YjY0ZnI3Wi9MYTJ1THhLdVBLSFdpRkRB?=
 =?utf-8?B?OE8wRThzZERadUtyZ3ErcmlEMTVZRFJlalpFQlYvTEtqMjF2MVVzQSs5enNX?=
 =?utf-8?B?VmMrWFBLM0tjUW0xWndETVpkdnQzSk1EVVRWekowcmRHSnpLMDc0dGRoa3A2?=
 =?utf-8?B?TzIwZlMrR0pjb05DeWtIMTVYdmFvQmJCM0huSThVTk1KU04xQXVwb1dDMDA4?=
 =?utf-8?B?WGFsYUY3eWErTFpJUmZnZHJvQ0IwMC82RU5iaE5IQVkzeUNLSEEwT3lTZjk0?=
 =?utf-8?B?ZnlzbHZEa0ZhMHcyemdoZHBSUTYrVWN0cTQ5aGl0bGVwc3pzQTl3UStkK21k?=
 =?utf-8?B?ZGZnV1JxV2xNQ1pGU0JibTZEdlJ5K1VPWEtLMW5lQ3E1cW9RVElldGJGRzAw?=
 =?utf-8?B?RVlYQU9lOGYzZFVudmVpcFJZZ0pjVmZpNkoyTHF4ZkNSemUzK2dNQm8vcm1l?=
 =?utf-8?B?S1FvNXZJb2VzQk0xTURCRlNxNTZOR1hWRTBVeXROMUFWYUFNVzI1OElFbW5t?=
 =?utf-8?B?K0lGVnZ0RnlUbThpOVdXVjIySWtBZXJYeUVRZjZRVllsOEMyZUQxTkdGS3FH?=
 =?utf-8?B?YWphdjZKOGhtQ2ZUclBUb1VtNTZDRklUTkxJK0I0TDRsRjVFV0ZQVERzQi9j?=
 =?utf-8?B?ZVpOUU1hdTZCcW4zMXZHbmVRU3ZhTVBJdFpEdXFMODd2VkZVRk1OOEdIZnM2?=
 =?utf-8?B?akNLRnQrK2JMUVhTL0thYXZCRitiVEo0b252UUFhTEliOFNWditSbGFXNEoz?=
 =?utf-8?B?RDhwZGVoY2ZCZS9acXkyejQ1VUR0djQ4VlAvQXRZQ3lLMjcySzQ3MGREc2o3?=
 =?utf-8?B?MHlWOGFDN1VYRWRBT3hQN0l3TmNQdmFLL0ZmcDVKcVEyMWlVT29LcUN5VlBF?=
 =?utf-8?B?eHB1YVFadHFDZm0yaEdkWnk5QlBFV1FJOHlyTmFTQmpDS1V4YVkrY2xqeHdO?=
 =?utf-8?B?V2xWZUdGTWtWNms3NmlDd1BkVCsxQzZ3U2dsL3dIWnZEOTBPYmdGa3pQVzFD?=
 =?utf-8?B?bVoya1RnNVlCUDNBQUZTckYvaFljSGFSSVlxMEJjVzBKQ1pNcVVCRDhZR1JH?=
 =?utf-8?B?eGNJTUJQZk5iMnI2TytPOVI4SDNybGQ0bTR4UTRrL2d3aEtTcldwT1lGRDJR?=
 =?utf-8?B?OHowVVpXRzdwQm14cXhsYkFYUWRGSEJKYi9XUFVwSWMzNytsWFVXT3ZoaDBY?=
 =?utf-8?B?MUZXUEgzY0pPRm9CUFY4L2gxSGJSdFJtQkJrVEdkWVQ2cDF6Rmk4dGl4ekpO?=
 =?utf-8?B?c0dpRjNJRTR6YVNuVmFwMTdUaHI5TjNFNG0xTmR4UDR4aTE5U2xkUUtRa09U?=
 =?utf-8?B?SW8zWVJVRStrVGJUZmNqYS92YnhpOTJOT1AxSWkyRTFWNFVlQ2pQRFoyYWpQ?=
 =?utf-8?B?MHBGU0R3emRUVlpQQWxOWEZKQjh1RU1DOUM2VGszWEkxWDErMitxbWxSdUpR?=
 =?utf-8?B?QzBVV09ucTExeTV3Um4yTFkveFFOS0UzT2hWRDErS0dMRm5HSDhTM0drVlFp?=
 =?utf-8?B?cG5qckdvWGNpcVhvMS9XMTZRVXhoQlJxbTl4bSs5c0dPdTlGUm1rRDRRWVFn?=
 =?utf-8?B?MnFScVdwcU9QUzIxQXpqY1VPSnNsczFFbXhySERaRjdlRXRCbG16VitVTkJQ?=
 =?utf-8?Q?yGWE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5628728f-2c34-4c4f-b69d-08dca9b03348
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2024 18:09:01.8988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NapsaEXDXhqOEcbl6s5fle25n1nVyuwd+4Hy5qz97rLMROdrVuLbvqTyRR2GyiY+VAyyWpc9tuMsUgz1RzyHHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6391
X-OriginatorOrg: intel.com

IA0KPiBPbiBUaHUsIEp1bCAxOCwgMjAyNCwgSC4gUGV0ZXIgQW52aW4gd3JvdGU6DQo+ID4gT24g
SnVseSAxMiwgMjAyNCA4OjEyOjUxIEFNIFBEVCwgU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2Vhbmpj
QGdvb2dsZS5jb20+DQo+IHdyb3RlOg0KPiA+ID5PbiBXZWQsIEp1bCAxMCwgMjAyNCwgWGluMyBM
aSB3cm90ZToNCj4gPiA+PiA+IE9uIFdlZCwgRmViIDA3LCAyMDI0LCBYaW4gTGkgd3JvdGU6DQo+
ID4gPj4gPiA+IFN3aXRjaCBNU1JfSUEzMl9GUkVEX1JTUDAgYmV0d2VlbiBob3N0IGFuZCBndWVz
dCBpbg0KPiA+ID4+ID4gPiB2bXhfcHJlcGFyZV9zd2l0Y2hfdG9fe2hvc3QsZ3Vlc3R9KCkuDQo+
ID4gPj4gPiA+DQo+ID4gPj4gPiA+IE1TUl9JQTMyX0ZSRURfUlNQMCBpcyB1c2VkIGR1cmluZyBy
aW5nIDMgZXZlbnQgZGVsaXZlcnkgb25seSwNCj4gPiA+PiA+ID4gdGh1cyBLVk0sIHJ1bm5pbmcg
b24gcmluZyAwLCBjYW4gcnVuIHNhZmVseSB3aXRoIGd1ZXN0IEZSRUQNCj4gPiA+PiA+ID4gUlNQ
MCwgaS5lLiwgbm8gbmVlZCB0byBzd2l0Y2ggYmV0d2VlbiBob3N0L2d1ZXN0IEZSRUQgUlNQMCBk
dXJpbmcgVk0NCj4gZW50cnkgYW5kIGV4aXQuDQo+ID4gPj4gPiA+DQo+ID4gPj4gPiA+IEtWTSBz
aG91bGQgc3dpdGNoIHRvIGhvc3QgRlJFRCBSU1AwIGJlZm9yZSByZXR1cm5pbmcgdG8gdXNlcg0K
PiA+ID4+ID4gPiBsZXZlbCwgYW5kIHN3aXRjaCB0byBndWVzdCBGUkVEIFJTUDAgYmVmb3JlIGVu
dGVyaW5nIGd1ZXN0IG1vZGUuDQo+ID4gPj4gPg0KPiA+ID4+ID4gSGVoLCBpZiBvbmx5IEtWTSBo
YWQgYSBmcmFtZXdvcmsgdGhhdCB3YXMgc3BlY2lmaWNhbGx5IGRlc2lnbmVkDQo+ID4gPj4gPiBm
b3IgY29udGV4dCBzd2l0Y2hpbmcgTVNScyBvbiByZXR1cm4gdG8gdXNlcnNwYWNlLiAgVHJhbnNs
YXRpb246DQo+ID4gPj4gPiBwbGVhc2UgdXNlIHRoZQ0KPiA+ID4+ID4gdXNlcl9yZXR1cm5fbXNy
KCkgQVBJcy4NCj4gPiA+Pg0KPiA+ID4+IElJVUMgdGhlIHVzZXIgcmV0dXJuIE1TUiBmcmFtZXdv
cmsgd29ya3MgZm9yIE1TUnMgdGhhdCBhcmUgcGVyIENQVQ0KPiA+ID4+IGNvbnN0YW50cywgYnV0
IGxpa2UgTVNSX0tFUk5FTF9HU19CQVNFLCBNU1JfSUEzMl9GUkVEX1JTUDAgaXMgYSBwZXINCj4g
PiA+PiAqdGFzayogY29uc3RhbnQsIHRodXMgd2UgY2FuJ3QgdXNlIGl0Lg0KPiA+ID4NCj4gPiA+
QWgsIGluIHRoYXQgY2FzZSwgdGhlIGNoYW5nZWxvZyBpcyB2ZXJ5IG1pc2xlYWRpbmcgYW5kIG5l
ZWRzIHRvIGJlIGZpeGVkLg0KPiA+ID5BbHRlcm5hdGl2ZWx5LCBpcyB0aGUgZGVzaXJlZCBSU1Aw
IHZhbHVlIHRyYWNrZWQgYW55d2hlcmUgb3RoZXIgdGhhbiB0aGUgTVNSPw0KPiA+ID5FLmcuIGlm
IGl0J3Mgc29tZXdoZXJlIGluIHRhc2tfc3RydWN0LCB0aGVuIGt2bV9vbl91c2VyX3JldHVybigp
DQo+ID4gPndvdWxkIHJlc3RvcmUgdGhlIGN1cnJlbnQgdGFzaydzIGRlc2lyZWQgUlNQMC4gIEV2
ZW4gaWYgd2UgZG9uJ3QgZ2V0DQo+ID4gPmZhbmN5LCBhdm9pZGluZyB0aGUgUkRNU1IgdG8gZ2V0
IHRoZSBjdXJyZW50IHRhc2sncyB2YWx1ZSB3b3VsZCBiZSBuaWNlLg0KPiA+DQo+ID4gSG0sIHBl
cmhhcHMgdGhlIHJpZ2h0IHRoaW5nIHRvIGRvIGlzIHRvIGFsd2F5cyBpbnZva2UgdGhpcyBmdW5j
dGlvbg0KPiA+IGJlZm9yZSBhIGNvbnRleHQgc3dpdGNoIGhhcHBlbnMgaWYgdGhhdCBoYXBwZW5z
IGJlZm9yZSByZXR1cm4gdG8gdXNlciBzcGFjZT8NCj4gDQo+IEFjdHVhbGx5LCBpZiB0aGUgX1RJ
Rl9ORUVEX1JTUDBfTE9BRCBkb2Vzbid0IHByb3ZpZGUgYSBtZWFuaW5nZnVsIGJlbmVmaXQgKG9y
DQo+IHknYWxsIGp1c3QgZG9uJ3Qgd2FudCBpdCA6LSkgKSwgDQoNCldlIHdhbnQgaXQg8J+Yii4N
Cg0KTXkgY29uY2VybiB3YXMgYWRkaW5nIGFuIGV4dHJhIGNoZWNrIG9mICh0aV93b3JrICYgX1RJ
Rl9ORUVEX1JTUDBfTE9BRCkNCmludG8gYSBob3QgZnVuY3Rpb24gYXJjaF9leGl0X3RvX3VzZXJf
bW9kZV9wcmVwYXJlKCkuICBIUEEgY2hlY2tlZCB0aGUNCmZ1bmN0aW9uIGFuZCBzdWdnZXN0ZWQg
dG8gdGVzdCB0aV93b3JrIGZvciB6ZXJvIGFuZCB0aGVuIHByb2Nlc3MNCmluZGl2aWR1YWwgYml0
cyBpbiBpdDoNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2VudHJ5LWNvbW1v
bi5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vZW50cnktY29tbW9uLmgNCmluZGV4IGZiMjgwOWIy
MGIwYS4uNGM3OGI5OTA2MGI1IDEwMDY0NA0KLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vZW50
cnktY29tbW9uLmgNCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2VudHJ5LWNvbW1vbi5oDQpA
QCAtNDcsMTUgKzQ3LDE3IEBAIHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdm9pZCBhcmNoX2VudGVy
X2Zyb21fdXNlcl9tb2RlKHN0cnVjdCBwdF9yZWdzICpyZWdzKQ0KIHN0YXRpYyBpbmxpbmUgdm9p
ZCBhcmNoX2V4aXRfdG9fdXNlcl9tb2RlX3ByZXBhcmUoc3RydWN0IHB0X3JlZ3MgKnJlZ3MsDQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVk
IGxvbmcgdGlfd29yaykNCiB7DQotICAgICAgIGlmICh0aV93b3JrICYgX1RJRl9VU0VSX1JFVFVS
Tl9OT1RJRlkpDQotICAgICAgICAgICAgICAgZmlyZV91c2VyX3JldHVybl9ub3RpZmllcnMoKTsN
CisgICAgICAgaWYgKHRpX3dvcmspIHsNCisgICAgICAgICAgICAgICBpZiAodGlfd29yayAmIF9U
SUZfVVNFUl9SRVRVUk5fTk9USUZZKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgZmlyZV91c2Vy
X3JldHVybl9ub3RpZmllcnMoKTsNCg0KLSAgICAgICBpZiAodW5saWtlbHkodGlfd29yayAmIF9U
SUZfSU9fQklUTUFQKSkNCi0gICAgICAgICAgICAgICB0c3NfdXBkYXRlX2lvX2JpdG1hcCgpOw0K
KyAgICAgICAgICAgICAgIGlmICh1bmxpa2VseSh0aV93b3JrICYgX1RJRl9JT19CSVRNQVApKQ0K
KyAgICAgICAgICAgICAgICAgICAgICAgdHNzX3VwZGF0ZV9pb19iaXRtYXAoKTsNCg0KLSAgICAg
ICBmcHJlZ3NfYXNzZXJ0X3N0YXRlX2NvbnNpc3RlbnQoKTsNCi0gICAgICAgaWYgKHVubGlrZWx5
KHRpX3dvcmsgJiBfVElGX05FRURfRlBVX0xPQUQpKQ0KLSAgICAgICAgICAgICAgIHN3aXRjaF9m
cHVfcmV0dXJuKCk7DQorICAgICAgICAgICAgICAgZnByZWdzX2Fzc2VydF9zdGF0ZV9jb25zaXN0
ZW50KCk7DQorICAgICAgICAgICAgICAgaWYgKHVubGlrZWx5KHRpX3dvcmsgJiBfVElGX05FRURf
RlBVX0xPQUQpKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgc3dpdGNoX2ZwdV9yZXR1cm4oKTsN
CisgICAgICAgfQ0KDQogI2lmZGVmIENPTkZJR19DT01QQVQNCiAgICAgICAgLyoNCg0KQmFzZWQg
b24gaXQsIEkgbWVhc3VyZWQgaG93IG1hbnkgMHMgYXJlIG91dCBvZiBldmVyeSBvbmUgbWlsbGlv
biB0aV93b3JrDQp2YWx1ZXMgaW4ga2VybmVsIGJ1aWxkIHRlc3RzLCBpdCdzIG92ZXIgOTklLCBp
LmUuLCB1bmxpa2VseSh0aV93b3JrKS4NCg0KV2hlbiBib290aW5nIGEgS1ZNIGd1ZXN0LCBpdCBi
ZWNvbWVzIDc1JSwgd2hpY2ggaXMgZXhwZWN0ZWQuICBBZnRlciB0aGUNCmd1ZXN0IGlzIHVwIHJ1
bm5pbmcga2VybmVsIGJ1aWxkIGluIGl0LCBpdCdzIDk5JSBhZ2Fpbi4NCg0KU28gYXQgbGVhc3Qg
dGhpcyBwYXRjaCBzZWVtcyBhIGxvdy1oYW5naW5nIGZydWl0LCBhbmQgSSBoYXZlIHNlbnQgaXQg
dG8NCkludGVsIDBkYXkgZm9yIGJyb2FkZXIgcGVyZiB0ZXN0cy4NCg0KQXMgY29udGV4dCBzd2l0
Y2hlcyBhcmUgd2F5IGxlc3MgZnJlcXVlbnQgdGhhbiBleGl0IHRvIHVzZXIgbW9kZSwgSSBkbw0K
Tk9UIGV4cGVjdCBpdCBtYWtlcyBhIGRpZmZlcmVuY2UgdG8gd3JpdGUgTVNSX0lBMzJfRlJFRF9S
U1AwIG9uIGV4aXQgdG8NCnVzZXIgbW9kZSBpbnN0ZWFkIG9mIG9uIGNvbnRleHQgc3dpdGNoIGVz
cGVjaWFsbHkgd2hlbiB3ZSBkbyBpdCBvbiB0b3ANCm9mIHRoZSBhYm92ZSBwYXRjaC4NCg==

