Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999E178823F
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 10:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240951AbjHYIhw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 04:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243785AbjHYIhh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 04:37:37 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Aug 2023 01:37:30 PDT
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002551FF9
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Aug 2023 01:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1692952651; x=1724488651;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yM3Y3XnkoB1Ur/qbUGfNGOn1Az9b7OEd+uoFz42mw1k=;
  b=Zrr1Mjh+KR1XXr3FU3o6mpDNuGyDlGkApF8N9szUNqEXSLNPKj1N7Tpv
   uZIShR9GZz9p+yfqiXVfahaYBL4EZJDhqCjikZELFNKM+NGIGWuEZKE0W
   Y4phnkHbEDCWPISjkjqs/1NOIBbo8xV4fkRV+i4nPqwG1Rc2xRY6si+17
   ghpPa+dWRwe3u1QHSVFgGzxHLEaShWbsIWIJ3tSkWayOJ1y7Px5fbsJPi
   JjW9gFmhkWFX/Jie2OvskD1TCFrDlGZA5FPP1ZxNkkQvDbgSYyg1U2jEQ
   1gWVjamAP4Kv2Uh4BlZvfHKibx2cJti/mvowNCPqW3aHjWOUcCcfZ3BRB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="92712441"
X-IronPort-AV: E=Sophos;i="6.02,195,1688396400"; 
   d="scan'208";a="92712441"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 17:36:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJx1g+QxusAj8hF71soUwqLgA3P5OOwxgK9Ce9mocDnQdxwjLU7n3poUYteANakNwmFEvjimtc/cDvk4/kWUQo6O+45B/TN7i1EMk9YJqcIBY0Gmc/6tKBepPUyxI03yg56zuM1IHLZoCayJoD0QKBkECfL29PU2jqswOG9TW1xpXgu5zSGQcsGwpw73LhsuKt1ul0CVEJnrZ58IByCYInL3CU9nVlq9+5nTJ0GonJ53b+NCg0hw8PY2CqgQoSrAq/U89ocLshakvkeKLoAyHkqkSNmcxexuKjh7+SEl0J6+EBUwknlm4iyDSBMseEyX0XKb/Oo2ZzSOoEUvM/UEpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yM3Y3XnkoB1Ur/qbUGfNGOn1Az9b7OEd+uoFz42mw1k=;
 b=kUhgU2QkSn8lRe0hZ/scx72yOetaKaIeXbSToBeaeSe0za5NJZCQOccCOjj8C9mLfTRjfXYiua2teQ675GAXFTJAf1JsO52kp4tt45i6f1FmoKliqWyBuAhSxnhXulphLNUc9AbgLxcnMT2k7AZxYKY8LQGJ1YKQ6H8TafKQWRx2QSRtlq1LDyxiqiBl0/rbh4ZE4CzXmsyCgg6dHeD9BsaZy8h3Hwk7/VvkMO+dGWJcnedzMeVB+7MaIZUUrmmah7IeXyuPg0VGCSi3wXFKdzyNOYrXNqrxIlbwGIhtkS7YC2jWyyr1I8mFHwIayEe3OA1t1VCAFoKpsWRxLYIIyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYVPR01MB10780.jpnprd01.prod.outlook.com (2603:1096:400:2ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 08:36:19 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::59bd:366a:131b:3f26]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::59bd:366a:131b:3f26%3]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 08:36:19 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     =?utf-8?B?J0lscG8gSsOkcnZpbmVuJw==?= 
        <ilpo.jarvinen@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/7] selftests/resctrl: Rework benchmark command
 handling
Thread-Topic: [PATCH v3 0/7] selftests/resctrl: Rework benchmark command
 handling
Thread-Index: AQHZ1cQCNwslrA8IOkaCtYhsBIOTlq/6r3Fw
Date:   Fri, 25 Aug 2023 08:36:19 +0000
Message-ID: <TYAPR01MB633016A1769EEF44D79351BD8BE3A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20230823131556.27617-1-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20230823131556.27617-1-ilpo.jarvinen@linux.intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9ODBkNjdhOGEtMTY2YS00ZDNiLThjMzQtYTc0ZmYwYjc1?=
 =?utf-8?B?M2Q1O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMy0wOC0yNVQwODoyMzo1NVo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 6fb79273c2484446a322a14be1722901
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TYVPR01MB10780:EE_
x-ms-office365-filtering-correlation-id: 64810dbd-cc29-4e61-e873-08dba5465b14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5FCfgqE/LE8tjhYHp1esem11zCcrpFY705duyxPUIyNU41BzKkPZpJsyeRaHPWOzUaCjtvclCLYaN8NDeWbdIMO+PPEn2HlEbn+RqreLhxQcMmXyb1trP0l1mYPZFu1FEHVN02n672B59OQ5/pq2QHBTSpEI4MnBfep9+WHNzLr+ZmAjq2lNRUUjbfVcUsD5uXlwx7a1tl3Npkk8xB7cQ4hh5j27F3djm/mQ2RsBqOGxWThrjyKQFaI4Vc65az9U+SHGp0CDllrAo3HAfhWIRM7NRKSJKxmXMEp/xC81sMnHyMhIzrAjLebxY/bXzGuBvF3uLglXvIS8wzpCDmXOfxZ8imfFGf67GxwDXPIhwJ23Zneq68fA/QKo/oKeJH/l6dS9XgC0n4LD1uQW8ZkPl3H/qWRJPHBAcUxOHYQXEGIDaVG5p59EzcuHroB1ZL07GwvlEbsxesKaa07WjW+EhD7xIgFgBTPPinXDgObIapeyKbMj8rVBspOxQqA39ajm7RorjvGm7sOlJ0OBNN0y6JgGudbX+PStY4Gv87JenjDO/MxoxVOZDdP1Z48krkvc1fCznnxnZgQ8Gke4qT0dw9S30BrK6F37arhX3VkTABdO/aIZHM/qX/d4ANeV1ItijsSkV2j4abzUIVDG1YklMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(1800799009)(451199024)(1590799021)(186009)(9686003)(26005)(478600001)(55016003)(5660300002)(52536014)(2906002)(8676002)(8936002)(4326008)(1580799018)(82960400001)(38070700005)(38100700002)(122000001)(66476007)(66556008)(110136005)(66946007)(76116006)(86362001)(71200400001)(41300700001)(85182001)(64756008)(54906003)(6506007)(558084003)(7696005)(66446008)(33656002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjkrVlNocGhMNVUwUGxBNlREQ0Vvb1kvVGxVRHFBQmhaKzdxZnNkdDZVMVdO?=
 =?utf-8?B?aUE0N09oYWp6RDNwd2ZZNkJwK1BtYk90RjByZ3YwV2VMOVpuQUowQ0RPekQz?=
 =?utf-8?B?TW9GNXRCd2NQV3dzQ0NTWFdHcWZkUW82eXVEckJxWHNRaC9VdWljd0lTdVda?=
 =?utf-8?B?OGtGcFVMQjhoV1NMNXdvNVU0M2x6cGxUR2M5YVhDY2llYnh0L2hldDR1Skd3?=
 =?utf-8?B?aTF4VkQ3U1k3cXJmTFNDUWNFMkFNUXZnY3Z3ZmVCbTU0ckFoeGR3WU15ZjBR?=
 =?utf-8?B?Y3luajBIZmFjSUwwMjZUQ1BPTE1OVzZ5VzYrZlBtUmNCVDlYRU8zakxtNG03?=
 =?utf-8?B?eUJsb3hWWVR5V2Zmd2tiMVpmZWk2Z2loUVR0cVZWZ3VCdlhldUg3am03R2dT?=
 =?utf-8?B?Qlc0YXg0eG42ZU9QdHkwVkE3ZEVLdWthek9Wb1l2UlhQTUVTS0FrNFJhc1lO?=
 =?utf-8?B?dldlN09ITWkza1AyaW1iWTNBbWZrSGRzeFV1MzBNaTBqdEZRSCswZkN2V2da?=
 =?utf-8?B?dWVucGp3SDRmbTBla0wrV285WmY5TWR6T2dwVEZsbVg5ektNSHBYZHFKcUxw?=
 =?utf-8?B?RCtZenRXSnpma2xmS3Y4U1V2SC95SVpCZVFEVnMveWxVOUZBVzN5RU9ab0FQ?=
 =?utf-8?B?NTNGVFRnRkc5VmhEajFQNzRrdHV5aFdMZXF5SDhtbTQyZTBVTTNrUmZBRWJh?=
 =?utf-8?B?VnIycjh2b29IZHp5a0loRy9ScmtwdDBKckxSTHVNZ2w1clFmZkZhVGx6NlZ0?=
 =?utf-8?B?WlFNRGE1SmdFRnFCMTgyOVNSUHZURXV5ZGNnSzV4eDRuak1xc3BqMHl4Mi8z?=
 =?utf-8?B?UmlpRnBhUmZ6Vm5xbkFuZFBFNWY0cVVDdXAwOVlmNXRwTW5TU0J6d1BmYVN5?=
 =?utf-8?B?Ykp1TUgxUlFGZisxWW1RK2E4amhJU2Robi9LZUtpbEFVMUVYRXRrZFlCRE5k?=
 =?utf-8?B?b1FaNStnSHVPUXBZZ0Qvakgrck5OSjFLaDMyZXdIS0x0Zk92cXRtVXBubzZ4?=
 =?utf-8?B?bTh4L3RLWGc1c2hhek5HMXYycWJaaUEwYTVFcWNtOWdWQjN0dGVJN1k0SU4v?=
 =?utf-8?B?ckR4YWxaaGJXTzI4emNZRDhhdW9oYkhNRXlsZHg2Ni94SnQ2T1ZSQXNhWWN6?=
 =?utf-8?B?akdqK0dibFJZNTh3N01JRlpGbjV0L3B3L21EbE5kRlM5NWlFbXZsdzhva2Q5?=
 =?utf-8?B?MWVBVHcxVFBSbGRkRWtTQXZrUms2QmgrVWRaV2lGNmpKUkUrOVZId2RURkFG?=
 =?utf-8?B?dEZiNlR6NFE5MW9peHZFNFFOWGRLK0VvUWZSd0V6c3FYTUtOa2o3Z0N4RnY5?=
 =?utf-8?B?TUg4NEJzbUVqdjF5S1lNaVdRSnJodUdWZklmS3JqWGpMN0E2UzF5YVg3VGRx?=
 =?utf-8?B?WFlnVWtiUlpibmJaNk1uSWJra2grTjBmRHQ0bWhTNit6dGxVMUxFbFFmclo3?=
 =?utf-8?B?ZjVXZE5xZHZyUGYxdk00VkxiVVM0ZEFKZXdYWGYzbDJHT2FZcTdNMHpRVFZv?=
 =?utf-8?B?RWUwVHo0QVFQZzFNZ3M0RzgxMWV4V0E5N1ZiVFVrczdlNEdIT0kxNHNkKzJU?=
 =?utf-8?B?QmdleGdGS3FQYTA4RldETkZteTVvWTl5VEpDSVp6OERZVHlnZ0dqdlA4VFRU?=
 =?utf-8?B?SndFd21nVHV4cUFhV01SWDZiVnlSaWcvOS9XSXBMM0R4WXRXSDlKUVVTdGZz?=
 =?utf-8?B?MGtLTVlQZ0tIM3haaTNhRks4cUVXOWZVY05CKzdUQTBVZm9pazd0RnArZWJt?=
 =?utf-8?B?WDRnTHlQaCtVcGxudnRSbFYreENKekdRQ3NIUVBzdVNIbjRYaGZ6RE5mZ0wz?=
 =?utf-8?B?bU5oV0g3Z3VyMGNiYzZ2VHEzMjJvR0kxQlhVbUdEZ3ZFZ0ZxRERFbVVyZHFN?=
 =?utf-8?B?WG53ZTVMWU9NYzVadGovMHl3aHFzMWw4dFArYjRNSnlETkNnc0xJZWhVVWNB?=
 =?utf-8?B?S2lscjZLKzJROW1kNW9RemluQVpLNkR2Mi9uNEpKMitIOUF4U1FDd0RiNUxD?=
 =?utf-8?B?Y0JrNUJ5eGkxeUhic2VLd1RUb1lNenZHdk9jSGFCUzNvaWZsL24wZEg2ektZ?=
 =?utf-8?B?bFRxUE15bEYzc1M5MUJmaE80TDZJZVgycXZHZzI0blBzSWNzcHViMjAxOUcr?=
 =?utf-8?B?aHhDZXFGb1haRWl5TENCdUphMG45Vjk4YVBvanRUOWo0UEZtVlQzTUxLT3cr?=
 =?utf-8?B?d3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SWFGcXZabXdDb3ZsWmN5cmxqblpKMURrajg2a0FNK2pIZkpJZ1ZGL2Vzdjc4?=
 =?utf-8?B?YVlJaTRuZFJyNXNMNDBjUHZMb0FwcmpET0pFOS9xakc1MGJ3UEUxK3JEYkNl?=
 =?utf-8?B?NHFzbzZLMXIraE1hckFpTHBIa01LT1haeHZpVE1YcDVMMHF1aWlzQzJsVEhJ?=
 =?utf-8?B?eDlKd241WURienNjamRzakZaUTVhcGZNS0x3STZCTWZxQnN3RzNPbkFPb3Mv?=
 =?utf-8?B?OXlEV2FVRmJ3ajlzekFBbjl2eDFIRENBcWVWRi8xUW96VmZYMTc4UkJqUEVU?=
 =?utf-8?B?b2xHbHJXUjlZRzh3Nk1FUCtUQmpEZEx2cURmU3ZpaFh4U3E4UmlQcGRlaG9D?=
 =?utf-8?B?WGFBYVcyNUlPNGMycWdPSk9kNGxhSnFFMmprZkNDT250NEVJL3grVDV0d1hS?=
 =?utf-8?B?NEhDQmx4TnRtMmMxc3RmRW83bDJLSHpWb3hacXRQVTB6REhpU3ZqcWdqbkRE?=
 =?utf-8?B?RnMvOHdCb3BtUnpjNDJkSy9mQ3NZM2JCNG1sREZMUk53dS9LREw5dkFBaWE0?=
 =?utf-8?B?OHZocytCOWxwdHZ4b3RnNTRqYzlFVUtaWm02Ky9VY0t2YkQxaUZHZHhkWUpw?=
 =?utf-8?B?SGgvYXQvNC9BSVc1MzNUUnMvQysyZ29ZWU5Mcm84NFZycmVod04xVHZVWGVa?=
 =?utf-8?B?NUdDeHdlWklJOXRnYms0MlNuQWhKbTZqZ1RrZ0hzWUF5U2VpT25hYnpHTktR?=
 =?utf-8?B?TWlPK0RTTHF5RHlGbWRKZEtjcGlydFc3S0o0QUVOZDVnS1E2ZVJvTW8vZXo5?=
 =?utf-8?B?TkUvSVhzTVRDb1QrZzJtaWdnUXFnZFNhMEM1NkU4K2RmdFBnU3JjMWM3R1RK?=
 =?utf-8?B?c2lRbWU3cTdCSzNsY3FIcnpleVRhNHp0d2RySUZ6Y3RpV2JsakhyWldyM2l3?=
 =?utf-8?B?N05uZ2VZaGVPN1dNQUdiLytuSDZEcHBHZlpPbXg0THQwY3hJRUs0N0dwRHEy?=
 =?utf-8?B?VFZGQ0w4by82bWswTHBBdHdSb3NlQ3NOQlFReHBpdDFpQURuMEZWcEIvUE1C?=
 =?utf-8?B?T2phRHZHUWNHaDVlSUVudG9aeWNaZm5aMFV4UmFtaDdlMEdtc2NsUVFxeEM5?=
 =?utf-8?B?b3Y3N3JXSlUwakxaOXN1a3I5bUxuNS93NHc0RWJnMjB2c0t5NEpsdlQ1Rm00?=
 =?utf-8?B?UFFaYXdVVzRlYWl3d3lzcUJLVVkzOXhQNmxVM0dlWjV0SHRFWHV5dGxMa3Z6?=
 =?utf-8?B?bmFRbDZ0ZE1RUFJWTEQ2cTB6VEh2RzNiWExMT0c4QWVLeVcybUZaSjA2endV?=
 =?utf-8?Q?FDZs2eAO237lhS3?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64810dbd-cc29-4e61-e873-08dba5465b14
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 08:36:19.6938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K/1eLRrJ1AVYTt/aAqf3fPOuV8vSXVpsYGyJ3k9YgJcIF0pm1visyMNXj8iF/aY5/XnwN7F1uopghAi7b2jSH2VqEdoBp3K2f2+RkaqGgAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10780
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGVsbG8gSWxwbywNCg0KSSByZXZpZXdlZCBhbmQgdGVzdGVkIHRoaXMgcGF0Y2ggc2VyaWVzLCBp
dCBsb29rcyBmaW5lLg0KDQo8UmV2aWV3ZWQtYnk6dGFuLnNoYW9wZW5nQGpwLmZ1aml0c3UuY29t
Pg0KPFRlc3RlZC1ieTp0YW4uc2hhb3BlbmdAanAuZnVqaXRzdS5jb20+DQoNCkJlc3QgcmVnYXJk
cywNClNoYW9wZW5nIFRBTg0K
