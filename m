Return-Path: <linux-kselftest+bounces-6404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C4287F2C1
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 23:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F781C21295
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 22:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FEE59B5E;
	Mon, 18 Mar 2024 22:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jJL11AvC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560D85A0E5;
	Mon, 18 Mar 2024 22:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710799220; cv=fail; b=Yufhe0X1NeyskHvKY20dkRbXXB/3wl9GTB6nyY9nrADhzYW4N9L1REY/Fs4gDWPX+ras4R/2qasAbOZeHPsxospDnzTHQ1pO/nbNGm6yiDa+nIBQvWlwroOxlYIqmlMEkyLoKNG5N31i97u2MApC1DVkMq9sBM/3fkGdCzQqhgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710799220; c=relaxed/simple;
	bh=h3Jx9JOK5Z9hiqXcvQlbhmInU5O2JjiyI3tCGjb2VSk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dg0YNzqShbHyQrnxEmpa/ekMxLvLmFA4RMEa2IKP1okKfK0iFtRQ/vWLAzGx+57f1sfMLBZHo684DoHU7pRltTXWE04lgARn0s/JcWeHahcjtFJTsIDXcLxeu0U98lOwIcQ+LMnkiPyDVf2P/pn2KeZzgxTpaFmtkX1qEBVC52o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jJL11AvC; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710799218; x=1742335218;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h3Jx9JOK5Z9hiqXcvQlbhmInU5O2JjiyI3tCGjb2VSk=;
  b=jJL11AvCFyF55sV7e2wzrL86ZnaVvlXf6yu3PKn/OO9LCZMBhi278pnM
   LrHPlw6y5/RG5s/s1hOm4CuVe0dUuFsywvuXRKQoFbuXpq4tXL59j0jlb
   UWn5Wqi3vDxf2sxcrCGiOQb0IKv7D8boDuwqT7JupBDVizZXH4RSHIB7h
   4zMs1NyY4z6nnGi2fthwxeXdujYNeG1mFAko1a0C2UAn8UTk4Oe45bj3P
   fyKucfTpS1t7wf0fVeSdCaLgdw8BmsGJzvpuCYTOZhy9iKNxURk0e7Hav
   cRlqTFGvadvVW3Cyzu2hOUOEItSxUTEV6uYeR/w1wp8pDD3FXwK+ESqk8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="8583525"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="8583525"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 15:00:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="13580949"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2024 15:00:17 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 15:00:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 15:00:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 15:00:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+Fd9QUdiQwkroIJOaBoppsTrocpmk1xRFcNAYeydXkLRrPHldITkTjv410w5RgjiC9avm7MOoKctQDNIfO3KuqAjRS2gsGMzntYgW5c6+xBvo+URjQ7Oj8cfWk8NWl+FP/4m1Ex/bB2knmc/e2NjowOh5JcaQrv8OvDOD/wD790jhKQ80QLZzPoiAp0THyHGxMi2dnl/17tQqYTbMcYn1BnPuhpc7xWIe7Kt8XoHw0Be56lYg0WqG0XO6TTDbDdHQ/kZ6L1IREtJH19UtdRSDrGMA2O366Pucc7sEEaYhs+MQg+S91Ht0RznWJstUc0WG9OLJfuwEZHDrQx5H7DvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3Jx9JOK5Z9hiqXcvQlbhmInU5O2JjiyI3tCGjb2VSk=;
 b=RsFvXKz7SL4gDjNAhGITELGfZ2KAsy8je7rVXvGyDeRSWogNOE/K7jSKhzKqoIvqHA8cGFe3tr95wTJZAGGWP2yeYz6Be3nIOe3Wbx10i+NFb//KpNF8YQwTDS7mGdSkM2B90cZK7NE30qIqzdU/GgGmRe9LtSrqWmJlg/JE+bcyD3A/Zu/LEq3PEBBs2InKmAuPfgmq5HpmZP/aIO/IBIDd/m5IxlhUQFY6luxBZeo9TP5Tn/z54wPAO0r2YmW6XkoGfe4Az1ovpgdKcI7AV56DgLz3Q38ZAa2px22oA4baM8z8PHrCTud8DCWNRNHxWqL8sY5rNhHtz74mQDWjyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BY1PR11MB8125.namprd11.prod.outlook.com (2603:10b6:a03:528::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Mon, 18 Mar
 2024 22:00:05 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7409.010; Mon, 18 Mar 2024
 22:00:05 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>, James Morse
	<james.morse@arm.com>
CC: "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Yu, Fenghua"
	<fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Thread-Topic: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Thread-Index: AQHab7KwshA04b3b7kGAda4tCZ9C1LErPGXQgADHEoCAAIKhUIAAB+aAgAABPhCAACNlgIAAEarAgAAc2ACAAUZZboAK/v/LgATLiICAAAEvkIAAFESAgAADgICAAAPVcIAAB6yAgAAJCrA=
Date: Mon, 18 Mar 2024 22:00:05 +0000
Message-ID: <SJ1PR11MB608309F47C00F964E16205D6FC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <SJ1PR11MB608310C72D7189C139EA6302FC212@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <SJ1PR11MB60830E546B3D575B01D37104FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <159474e6-ef11-4769-a182-86483efcf2a6@intel.com>
 <SJ1PR11MB60832DAD58E864F99A16FCC4FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0393c4ce-7e41-4dcc-940a-a6bea9437970@intel.com>
 <SJ1PR11MB6083AACB10645E41DD3F9639FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <55a55960-8bb1-4ce2-a2c7-68e167da8bcc@intel.com>
 <ZepK4mtoV_J8-UbE@agluck-desk3>
 <eacdc287-24bd-4137-85c8-df055cfd78b1@arm.com>
 <ZetcM9GO2PH6SC0j@agluck-desk3>
 <88430722-67b3-4f7d-8db2-95ee52b6f0b0@arm.com>
 <47c28b3d-3b90-4b33-ba71-1e359d43238e@intel.com>
 <SJ1PR11MB60832422CBDCCDA580010769FC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <6948784d-6a20-435a-8781-30f324bed472@intel.com>
 <SJ1PR11MB608303C5E0BEB42CAC5B02BAFC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <SJ1PR11MB6083FAA69AF7F712B34CA292FC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <176e6031-c95f-4c75-9857-5f8fe6c4e67a@intel.com>
In-Reply-To: <176e6031-c95f-4c75-9857-5f8fe6c4e67a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BY1PR11MB8125:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: miXKOa73uEWfjKMFVZWG8/XWZjIb3aQJ7H5JciKgWuF7ZpMJk0MaeOA0tzfAK7StAXpBsXzEsuiI1Y2QsqabfWghYzSNbygFIhmemeY8DakAnZBj1kytjNiIkLxDBP+JLyhbLlr15p7V643+uOuRcrEmzIcumLniA7vZeNksJbtYTpCP/Z6OecDI1nGE0NT71I3TgK2FUuXsjNGRlrtC/W8W1tmRlMqrOeY8TGKpgIRIhKSt8XJWN9vd8g0Q+mPMm+ZteyBMhMB3AuVFoMYHdy9MGfpvP3C6RPD3ittQ4XMhoXdiZflQD6EiGeBGH4UoueFdzbfIG3v1TvuSjqgylcaIMWliM5KSsTMNoxJFv8uqHWa6dlu8Z1p9XMvhsYh6etC5B1INqTK5bzc8VL4WfpnL5iEs4QjsT0wiotF13Ph/FMu9ThHPSTaWU9UppT16469LZYP9hZyQM/2/+w5qxWltfOZ7GnPuNiYvfesAC+UeEZoouawzlgiLZIfFITW5Q1XkiDjbVyRPigzj+bkgmtUbFAgNdGM9gZ5BuwNxnv+IcYj10MieR0lKSGkw6RTEmfSfFstnIPAhcKNCBatCpp0t4p7oSicd9tsEYn1x0Husg6454bmEw9b9ia0Tx634vRWnllM9e23MJ4ffJTBNVs2NiIn4sIj+g2L2caa4wGE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWt1MG82SS9tdGtna0NUYWJuYUVRNStGb1RKWHNub3JKa3lIWDlEcHRtVXhq?=
 =?utf-8?B?ODNFWStWNTkybDB3aDlneERJUER2TCtMdTZBWE9TRzVsT1Z6OXlGMWZvZ05Z?=
 =?utf-8?B?SDlhbHBGdjhwdWlSR2wyRjdKKytJN2FQRTVKZTVDZGQrdlNJb2NRUmxFbFBx?=
 =?utf-8?B?ZDF1bXZwbkFRbCtSRkE3cVRCNk16SUoxNXZiKy81ZkFidFhSTHRkY0t6Mld0?=
 =?utf-8?B?bVJPSkRiWWg5cFkzWWp3aEJpS0lUcTE3ZW5CbVFRNXlJS043UFowcXorQ3F1?=
 =?utf-8?B?aGdoSkJ0K1dPVENHMzh6Zld1ZTd0eFdULytad3pwbWNobWJnc3d4ajUyWTNP?=
 =?utf-8?B?K2NuREU4YnpOeTNQaFZVQXFuaTNwRFlaL2NNaHVCLzVBOVZFckxaK0J1SlRE?=
 =?utf-8?B?UUpDUlJXTFdIaW44MGNBR1ZqQVMvTUxsdzY0MFp0OUcvTTJBTzJyc05Ca3ly?=
 =?utf-8?B?bmdDUEpRRGtrODBGeWZ2UythdE1kQVBKQjRQUXN5TStJNWxFWXN3dm1ZMDJO?=
 =?utf-8?B?TjhRckx0YUVENTdiZGsrSWJ5RGpvdmNkbXZNVFVZL1Byd3ZqY3FQRWpmR0gz?=
 =?utf-8?B?NFZYcjFiRXZZUER5YVhYejNMOGNzYlI5RWptQ0YxZFVqTEFaVUtMWXdHdXBL?=
 =?utf-8?B?TzRsVEowUW1wTXhIQXowaHF0Z1RRZlhpQnE2bUZydGlQV2xMaWZNc2YvVGpz?=
 =?utf-8?B?QmtjMGx3VHgrOTBEZll5OWFLcVFHL2dyZXpWMmdNWUZyeTJ3NFIxSnVGNys5?=
 =?utf-8?B?ZFEzRTZpd2J3VG1jWVd4ZlpuZC9nZnBwekxqMCtTZDcyc2JnUDNHRUE3eDJl?=
 =?utf-8?B?SFY1T0hRNlNHQ2R1cnkvb0hEVFBtYlFraXkycktCdUV4MXp0SmxkRXpibHBn?=
 =?utf-8?B?bEZJUTYxdk5BSkNFTCtyem5QTGJENXoxdFNtWmFzWHNUQmRIWHJLRkozUllX?=
 =?utf-8?B?WDhrUlA2NlpUTVAxZTdRZXBlQ3o2eEt4SEVRa3hQVUIrczZsaVp2dy9EekZY?=
 =?utf-8?B?VW9KVDZnMnRHZWtmQnZCaTNScCtFMnRJN2RUem1oV0lXTnNFaWhtaFVYbUh6?=
 =?utf-8?B?V3VXeUxNd0xpRGxkc09wSTlpUDRmZjUrVThKbG1UVGVtd1pUeE9lV3IwZk1H?=
 =?utf-8?B?a0FzQldyOGVGWTVYNFZab3JSNXBiMjFKKzgwRlpFeitPcTFZbDBJMWJ6eHhX?=
 =?utf-8?B?SFZBQnhVYytQcWI1aFhpTWFmL2c3V2hWK2FKSll0c0x3dEFnZjYyTnByY0dT?=
 =?utf-8?B?V0xlSlZoeTZkeG5UV2ZMVUJqbVloSllwaDlWL3Q2akVCcy94QVpZdnBRYUhU?=
 =?utf-8?B?SDNpYVNtRXMrT2h4OWM0cVJBdHlEUUpqbUJTajJ6ZS9rQWo3S1ZMSDV3NEt5?=
 =?utf-8?B?cnhTVU82VmU5ZG9SdUZCZ3FtOGJSV25IUmo0VFRZVnZQUFQxS1lyNU9kZVhi?=
 =?utf-8?B?MjZob0pBbTgrQTU2M2FlMHJPak5mS3dwWkpFc2ozekh5QkV4N2xUNkg5MjFh?=
 =?utf-8?B?akN2ZnNUanJmWVdxcnoyUFZwTXZwRnhUSHNMS1A1Y1lhS0wwWSt1QTJpaFc1?=
 =?utf-8?B?UzVJaXNQZHc2YmkzaU9hWFR2RGtCK3ZOanExc0J1Z3BVVlBOV1c0MFMvd0Jh?=
 =?utf-8?B?Z3hHUWxYbTZrRFFQZ1hZNFRxOEt4OUpJVjVJUEdOd3kvait3ZTVFYzhGeTBC?=
 =?utf-8?B?WGMzelVFNm1OVDlRMDM5WFB4RExGYU1CWmFWNUZSK1ZTa0N5TnRDYXBqSkQ4?=
 =?utf-8?B?N24yYTM3ck41TE1BdmNrSThIeDViYlBwdUwzUVYyMHQ4ZnNzZDYweXh6Q0dU?=
 =?utf-8?B?ajNUa25DN3A1ZXhXMTc2VzZxdVNNclU2b2tBTko1WU1LMXF3MnlBUjIvcUc0?=
 =?utf-8?B?cjQ2RXA3UlJoNWpmZTI0c1lOQ2JhV2dEdXd3NklhUGRxb21nWDlSQStKc1Fq?=
 =?utf-8?B?RTBIOUc1dUZENlRENGF4ckZaSzc3aVZ4dG93N2s2Zk1yTjVzVk1mamVuMVNw?=
 =?utf-8?B?ZkEraGFXVjR2YUVuN3RJTThidXcyL2lCcTJvODQ0cCtKUzZUVjBxc21ROXov?=
 =?utf-8?B?b2xyMytJSW40V2xTNk9TQ3d2K3doNCtkWDFyRktvckhYUzJnNjh2YWVVM0F2?=
 =?utf-8?Q?MCVFktdJjkc5nvlO+Qq8Q3if6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e41f91a-caf4-44c8-b204-08dc4796c506
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 22:00:05.5369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 11pfvVZ6KWTY4Gsb5fmmSC9wDfJkxfO6xsapVMTEyVlEhDNhCrA1eXZxwQGoW9dU+fA4M0WMZH0IAOgu19JRkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8125
X-OriginatorOrg: intel.com

PiBQZXJoYXBzIC4uLiBpbiB0aGlzIGNhc2UgaXQgbWF5IG1ha2UgdGhpbmdzIGVhc2llciB0byB1
bmRlcnN0YW5kIGlmDQo+IHRob3NlICJtb25fTk9ERV8qIiBkaXJlY3RvcmllcyBhcmUgc3ViLWRp
cmVjdG9yaWVzIG9mIHRoZSBhcHByb3ByaWF0ZQ0KPiAibW9uX0wzXyoiIGRpcmVjdG9yaWVzLiAN
Cg0KUmVpbmV0dGUsDQoNCkxpa2UgdGhpcz8NCg0KJCB0cmVlIG1vbl9kYXRhLw0KbW9uX2RhdGEv
DQrilJzilIDilIAgbW9uX0wzXzAwDQrilILCoMKgIOKUnOKUgOKUgCBsbGNfb2NjdXBhbmN5DQri
lILCoMKgIOKUnOKUgOKUgCBtYm1fbG9jYWxfYnl0ZXMNCuKUgsKgwqAg4pSc4pSA4pSAIG1ibV90
b3RhbF9ieXRlcw0K4pSCwqDCoCDilJzilIDilIAgbW9uX05PREVfMDANCuKUgsKgwqAg4pSCwqDC
oCDilJzilIDilIAgbGxjX29jY3VwYW5jeQ0K4pSCwqDCoCDilILCoMKgIOKUnOKUgOKUgCBtYm1f
bG9jYWxfYnl0ZXMNCuKUgsKgwqAg4pSCwqDCoCDilJTilIDilIAgbWJtX3RvdGFsX2J5dGVzDQri
lILCoMKgIOKUlOKUgOKUgCBtb25fTk9ERV8wMQ0K4pSCwqDCoCAgICAg4pSc4pSA4pSAIGxsY19v
Y2N1cGFuY3kNCuKUgsKgwqAgICAgIOKUnOKUgOKUgCBtYm1fbG9jYWxfYnl0ZXMNCuKUgsKgwqAg
ICAgIOKUlOKUgOKUgCBtYm1fdG90YWxfYnl0ZXMNCuKUlOKUgOKUgCBtb25fTDNfMDENCiAgICDi
lJzilIDilIAgbGxjX29jY3VwYW5jeQ0KICAgIOKUnOKUgOKUgCBtYm1fbG9jYWxfYnl0ZXMNCiAg
ICDilJzilIDilIAgbWJtX3RvdGFsX2J5dGVzDQogICAg4pSc4pSA4pSAIG1vbl9OT0RFXzAyDQog
ICAg4pSCwqDCoCDilJzilIDilIAgbGxjX29jY3VwYW5jeQ0KICAgIOKUgsKgwqAg4pSc4pSA4pSA
IG1ibV9sb2NhbF9ieXRlcw0KICAgIOKUgsKgwqAg4pSU4pSA4pSAIG1ibV90b3RhbF9ieXRlcw0K
ICAgIOKUlOKUgOKUgCBtb25fTk9ERV8wMw0KICAgICAgICDilJzilIDilIAgbGxjX29jY3VwYW5j
eQ0KICAgICAgICDilJzilIDilIAgbWJtX2xvY2FsX2J5dGVzDQogICAgICAgIOKUlOKUgOKUgCBt
Ym1fdG90YWxfYnl0ZXMNCg0KLVRvbnkNCg0KDQo=

