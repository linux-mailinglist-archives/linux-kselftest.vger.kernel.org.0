Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B235471763E
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 May 2023 07:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjEaFee (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 May 2023 01:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjEaFee (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 May 2023 01:34:34 -0400
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 30 May 2023 22:34:32 PDT
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2BFD9
        for <linux-kselftest@vger.kernel.org>; Tue, 30 May 2023 22:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1685511272; x=1717047272;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ZtDgTgKLXYYsTYSJJ70N4gzGGQ2SgZM71XMdidd02Ak=;
  b=kCT4mr+YZp4jk34ngWwXL4+1bOPQRziR/YpJLOI3V2dDTkhADE3/ow64
   3WOTO66el5stn+zIMGqsux9cSRAJs6bnvK2++wyF7Ni7UCZa13Orhuzbw
   /I7F5YevFQFqcEPEIZWk/mEhAneU4rUlYvwNQI8VqDosQkYukgiWeQe6G
   4MHns2p7If+OesMhTNzLgzAFv/ow2wscvKg9n3o5b+rAhdz7D+k6Dbl/i
   26GGj+UF2UIswTlRKcTx4QoQ7JlmvHMSgVSRNCG9+xCyzwbkD5DYUGU3J
   NZkr6HXRHf/sU9NgLUqFy1b4zoATHA2TzkAYqkZ6Vm6I3PGuHRYKWe0xl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="85961481"
X-IronPort-AV: E=Sophos;i="6.00,205,1681138800"; 
   d="scan'208";a="85961481"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 14:33:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhIAsD6J39ljHBHeqTb8e/pjhsEQ+p25MekWHTzNI2XxZQJt1B9gT2/ttUjnb3r1kSt9+nLT3oViyFNl+G5pBnYQkDBAC8LAgp5+SMsXLgo86w7a9dcMgfys5qoNdj9XGTT5ArAkOS3b02zavtJIeyBb1ASJcGIbV10LIdSII4wQ6RnJv4SO5gSiKfnWJT5YppUwIineHppt0uMwRkOMQsGXRfhLZ8s/7NGr+7hi1gcUUY3ZYU9dG1Mvcqhz/2CGiOj0h3S7wgFJdzIUGpI7TGV52A4RqC25BmWLNCgZJtmO+oLfxbZ8tbwyuKmh7NFg6x1OuwEaNJXz1vgFD/d0xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtDgTgKLXYYsTYSJJ70N4gzGGQ2SgZM71XMdidd02Ak=;
 b=PJBKLigrZ1IiD3aQGOhdEVSAlxpScn2akXDmU/A5cEm9SqBZlkXjcQbi8bzBDNjr4PVBLasZNdmUneMukRNxdaRmydHIpVPGaKnVzvKYBbU2ol9jb7wkrpErghPfWjs6mXV079ax2Ae0facZLyZpijVII47fNmNCEMQozgswJFVAF/xuLcAzC/8e+dmC/a9WGH9jMRYti3E7dmqqR8yxV0r/POcyl7Lp+sqRSBmGdP24kigRH5nOCZtxeFCiuO5XcT8Eyww8GZYNJaH2UcA+zytn+vZHI5li5I/LMgvAQdq7IfnLIhd3Xy5rAz6ArU8cYyPQE7vyftyH3azIZje0aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6328.jpnprd01.prod.outlook.com (2603:1096:604:e8::8)
 by TYCPR01MB8376.jpnprd01.prod.outlook.com (2603:1096:400:150::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 05:33:19 +0000
Received: from OSZPR01MB6328.jpnprd01.prod.outlook.com
 ([fe80::cc8b:a287:185b:3ea9]) by OSZPR01MB6328.jpnprd01.prod.outlook.com
 ([fe80::cc8b:a287:185b:3ea9%4]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 05:33:19 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     =?utf-8?B?J0lscG8gSsOkcnZpbmVuJw==?= 
        <ilpo.jarvinen@linux.intel.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 21/24] selftests/resctrl: Read in less obvious order to
 defeat prefetch optimizations
Thread-Topic: [PATCH v2 21/24] selftests/resctrl: Read in less obvious order
 to defeat prefetch optimizations
Thread-Index: AQHZcet39cAuWUDzBE6QdI939640H690HFtg
Date:   Wed, 31 May 2023 05:33:18 +0000
Message-ID: <OSZPR01MB6328F2713E40CC7D383035A48B489@OSZPR01MB6328.jpnprd01.prod.outlook.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
 <20230418114506.46788-22-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20230418114506.46788-22-ilpo.jarvinen@linux.intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjMtMDUtMzFUMDU6MjM6?=
 =?utf-8?B?NTdaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD1mNzYzNzg2Yy1lZTc3LTQ3NDQt?=
 =?utf-8?B?OGQxZS01MDg2ZjEzODMzNGI7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: b56ecb4cdfab46dc9903af2c7e59663f
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6328:EE_|TYCPR01MB8376:EE_
x-ms-office365-filtering-correlation-id: 5b4d596b-41e9-48be-0639-08db61988a6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uEW6REHloBh8D3PSSxvNWMQHsZPKZ0rXm10WWmlB4oaRrm5AWzF6u87NsrEXhtbxN2ebjiDfbqrE/qlJwtbmQyB3MfoYqRFuAM9vSt5Y5ypEJNWScwpDhTCj4TqAKexxnG3ShXEJgJMIvFPbFBwo1YpUoHEZjWyiPkz6pDbAst4j7IsxLa1OU5DV2/2Yee4hfiWF/V3Zc0tgEpuqR4XN8x+eX0Xk4LgA2TfXBngqFw84JnEvA/Vyl/qzCz14m14HiWPhn0dfvW6K/jvZKHymiwgwpiUSLwGo57p3zRWN5Xp2gsyVn/Z9P2SY7QchdSXhWJP7ZdOUNEeDPmkbguRooRNsP1c6I246qqMRJdtJDT0S7QLSq+748RVd5J4aS3ExM/haT9acr0U3zBbucElA4JPBfDmtgVM4WFoC1SvH6Se+Oj7pCKbMm39XvIZp13TIlEaoy7Ug8oHoHzvOwjeneGRX8Q0EXP0dO3z1EWkP+Qzh0Q4eAuYEU5ymuDHIx2diPQJM4ZlR/r13yzUmXGjK6EEdmr7DaylxUanffQlA72x4q80MABDTsbGaO4dpiffXkY1EAeK+p3PO171N8RqEHXcghoilnMb04GtWfLalFNMnepzpR1cQrw8P6OaimeRB5dgM762vdu7JhnT6QEI6hw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6328.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(1590799018)(451199021)(1580799015)(71200400001)(478600001)(110136005)(8936002)(52536014)(8676002)(5660300002)(85182001)(33656002)(38070700005)(2906002)(86362001)(66556008)(64756008)(76116006)(66946007)(122000001)(66476007)(66446008)(82960400001)(316002)(55016003)(38100700002)(41300700001)(186003)(6506007)(9686003)(26005)(66574015)(7696005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWxYanNCYytvMTN5aGd4RUMvTXp6TmFtcFlWT2FyV08zRlB3RlVYdllaOEdi?=
 =?utf-8?B?RWVnQjRDUjZUOUlGUElNUTZVVElmMllyNEl4V1ZzN3dSaXY0anE3aFBUZ1lO?=
 =?utf-8?B?VEpGa3ZIbmp5b2Y0d2tIVTNaZ2tkVFBQaERMaXZ4TDR4QkF1L2Z5bmQ4cjZY?=
 =?utf-8?B?dmx6d090RlN1WjB1S1I4RVZkc21XRFdXa1ExdWFhTkRmV01PTStjTm9YUW05?=
 =?utf-8?B?M29CZE5HbXljTUhhd2xWZTh3L1NWRWoyVU1WVitJakhWQTZtNXpwOGY2STlC?=
 =?utf-8?B?ODZGcy9UTzBSNEphUThySG5WLzhEVXNaZ3dMUzNBb2dTN0FMYXRlR0xaMFpF?=
 =?utf-8?B?RE8wVXZJSm1UcFZwdjNpNzZpaDdxdVd3TnlMbE9nOHh6eVY4aDhTelZFaVJ2?=
 =?utf-8?B?S1pQd1N1VUdhZHpLV2hKOVNld3p5QWU4bTArc2ZxejR5QXZyYnF3YmhJNUdo?=
 =?utf-8?B?bVEwVC9HbjVzYjJiZUlQRHNGOUs3MUlSbUd1VDBPOVlMK2RqcG1nZmNaQ0Fm?=
 =?utf-8?B?TFZqSU0xY0RweTl1aEF0aUYwT2wvOWdkbjQ2YmFqUGQySytneW0rL2RhcTRu?=
 =?utf-8?B?Z2FJWkp2a05hOGtOZU5BZ3BWRnh3ZGdXRGFiSFg2dHROaHQxbGFmZEg3Yyth?=
 =?utf-8?B?UlZ4cWlOY2tiekN0eFZPa0JLYjhCVlFYM3NRbWMxdnNFYzFuNzRhcFZJUXkx?=
 =?utf-8?B?bWM0Y3p2eDN5T09EdVJLUEFJazcxU3l6QnM5aGxZVC9jWFFyYkhYeHJRaWVT?=
 =?utf-8?B?QUhpZm5EMHdKZHlHQzV2ZHBqMGZ3emEvY3RmQUhSV0RYVFV1QlNQRk5UZ0RY?=
 =?utf-8?B?Qnl6b3VTcUVpMUtaS0E4Tm5iREVtZ2F2U0tRSXlxU3NWSm11NHYzN3NFby9i?=
 =?utf-8?B?ZEhjc2hqazBSNDZLdTZkdXpuSXRHTlZXOTI5a01XU1MrWWhlREs3OEFXbEhU?=
 =?utf-8?B?UzU0YzhDTXBLKzRpNVRQbHVsVjNlVFpFTFVrYkltS3hwVk42UStORnR6S3A4?=
 =?utf-8?B?UWVhWmw3S3hUd2N5Q3VIWVo1WGNXY1ZFM2VqYS9CcGpjTFg5MTBHTTc4WnBM?=
 =?utf-8?B?K01Rc1hyZzRHL3JER3ZUY1ZMWGhFcjFNY0FFNGc4QTRpMmFvNEpHY1krZEVx?=
 =?utf-8?B?TkU4OTVLZHhnWFQxd2hJQ3V5cXBIMzRVZytSeHZTbFAwQ2Z6Z3JmcTN6VUJD?=
 =?utf-8?B?U1JveW1rWFIreEh1ZEptRXVNdnN2YlFtMU1xRVlYcEMzZ3FyVUc0TE50QVhE?=
 =?utf-8?B?Y3VHQ1UzMks4QVNBQ3IxakhpT2Jsek5PZksxVWtvTzh3MHdKcTd0NEZhWWE2?=
 =?utf-8?B?YnZMZlZBbVlrZ2xnVWdWSCtWbFk1M0wrc0I4NVRSRTAwMUhjQlNRc2R6YmtR?=
 =?utf-8?B?YlVTUkYvYUFzMnlkMXErUFR4NjI4elk2anRSUWFpQ1lqQUJlUU1zU2xRVGVK?=
 =?utf-8?B?TVIxeWMvRmlFTlJoYjR4ZHMvQTVVWHFqL3BObGpaOGprSGY1TkJkaFpDR21S?=
 =?utf-8?B?SHBVMWQ3akpsazhVckJjNzZRTUJVcXRYQmtIeHArZTF2Y3VEQUhRQVFidDFE?=
 =?utf-8?B?N2NMZUFobDZHcW1SR3RyWkxwUldsMjFLNTlIS0thSHNhT0xBQnBKT2RuUDNH?=
 =?utf-8?B?NlAxL1dJZ2ZBdmNINkRnV0o4WVZ5RzV1RjFPZXJrZm5rSWFUYkd1SXQ2TnYz?=
 =?utf-8?B?cnlraHBHWVo0YXBBU2Rpck9WcTJCc3hGUGFZbEI1K2FId245R2pDREJuN3VI?=
 =?utf-8?B?WW9ITmZUWDk4eXNHZlFWbk1CME45N3I2bkF4YmxSa0UwR1V4YlRtSm9vUG5h?=
 =?utf-8?B?ejR3N1VOQThHdnFJVUF1NlJ0TE5Iek1MSzRyRUJOUTNoUnZrcS94R3M2ZDJp?=
 =?utf-8?B?TE5wMFVscXM4cE9XeE5qR1l3dzhqSmxCQlNXTmRRbVJEeFdPR29rVmdJbnFw?=
 =?utf-8?B?L0V2aGVMTDZaWTdpeFp3Zm9uR2RYVU0wN0MwZlNodlFKdHJRY2hqNDNEM2pI?=
 =?utf-8?B?TTBRMWM5aSt3WFk2Wmt4ZFZVaWJ4Z2RJYUU4QTl0NW5hcWllVStjZ1ErYnFh?=
 =?utf-8?B?SW1Qb2JXRHkwaldjVE9taFhZSFdYMy84RURkdGRuYk43ZWk4WkFRYkw5QmRu?=
 =?utf-8?B?UGZhRGNlN1BIZjNQc0g4dGJRNUh2Q2lYdTV5Zm9WUC81S1VVUnZFNUcxL3gz?=
 =?utf-8?B?b2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xi9RohkTqgVmGbux2MPPlhIenkaimBYDXYWCyzoCwLhhYu83zcaKcb7uEbo0htoxCV6gNuZMOg9KrknN5I/jLwMd5nlLY5Cyr0mEGaaGZfACLRCcK5UGQEM8g6uCcc8Pjzy7beW2UFb749p22WXut2Cc0WsMUSJ/zWzu4EmeXDhVUnuQD/JqNTzr/4NPvYe4g3f67LBonEEqTnp/ugH2h/hxZeYB3wDJRM0mWp3odXdH5fYJYyMaNCZ2QnZlRsRWt6R8ml4uhwvlJbNbHHsBFCaPU/eT723uXNe0LgmAD+K3nTOvEf/hWeLlZ9+Ti1fLIXDfCVckChkMAIsbywR0bpI4lBjqwhuCmG9AGfyD3B1NxeQGXPV7/dydH76M5Q9XQbnZqwKXW+SLZFfHqVsZ9AX/xG5jTyqVphsLym0asFUa/8GqpXUr1VeKWgLMkmj2RbprZQxkFpima0u9wCVvn37E0v9VOtUGfkwNcICiqKhABfZ80upgH1yLytlDXmJ70OPstoydjkg3KKTEjOVuhAYM/b8Jz0N5dYjNiXVUT3n/xliCE5fpVcBhSufHnNEPoyJTMpIupFgyVjXtZGd//hA5bSrr598l+4EK/BZGfC1fQ7OlddbDJQpxc4RugcambOR+/70MurqaE4nqEWFKsxTyWiQRjaw2ErJJ/I2W23ubpe9A0Qdkd2+kMw05fKmPO9NeQwv7x8lbfLolApjHz4hE7exKUi8W5x89l3SGNs19PxvPlDEesWdlh/hIpt6oqwKwp6Fj8B8YsrmdlCuzKp0Z1k7jgNZELIyShvIogyVHsIl3+EKiGJ3+nrKtmEvvH1FzypMO7Qu5MoFgLPZmn7MuIn4ncfSxdBdJRfzFpD7nWBcywXxktP4tKNFoybOn
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6328.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4d596b-41e9-48be-0639-08db61988a6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 05:33:18.8180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jyO45INtDoqhcAoxGn+bINEqd7xaz5ioZyyZjPte2GpBFoBpeaQH4mDBWp1ben/EGo6/cNCffIU5rxYGBc7WpQ8lKkr1rIqKAG+MSxAwA9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8376
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgSWxwbywNCg0KPiBXaGVuIHJlYWRpbmcgbWVtb3J5IGluIG9yZGVyLCBIVyBwcmVmZXRjaGlu
ZyBvcHRpbWl6YXRpb25zIHdpbGwgaW50ZXJmZXJlDQo+IHdpdGggbWVhc3VyaW5nIGhvdyBjYWNo
ZXMgYW5kIG1lbW9yeSBhcmUgYmVpbmcgYWNjZXNzZWQuIFRoaXMgYWRkcyBub2lzZQ0KPiBpbnRv
IHRoZSByZXN1bHRzLg0KPiANCj4gQ2hhbmdlIHRoZSBmaWxsX2J1ZiByZWFkaW5nIGxvb3AgdG8g
bm90IHVzZSBhbiBvYnZpb3VzIGluLW9yZGVyIGFjY2VzcyB1c2luZw0KPiBtdWx0aXBseSBieSBh
IHByaW1lIGFuZCBtb2R1bG8uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBJbHBvIErDpHJ2aW5lbiA8
aWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5jb20+DQo+IC0tLQ0KPiAgdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvcmVzY3RybC9maWxsX2J1Zi5jIHwgMTcgKysrKysrKysrKy0tLS0tLS0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvZmlsbF9idWYuYw0KPiBi
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvZmlsbF9idWYuYw0KPiBpbmRleCA3ZTBk
M2ExZWE1NTUuLjA0OWE1MjA0OThhOSAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvcmVzY3RybC9maWxsX2J1Zi5jDQo+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L3Jlc2N0cmwvZmlsbF9idWYuYw0KPiBAQCAtODgsMTQgKzg4LDE3IEBAIHN0YXRpYyB2b2lkICpt
YWxsb2NfYW5kX2luaXRfbWVtb3J5KHNpemVfdCBzKQ0KPiANCj4gIHN0YXRpYyBpbnQgZmlsbF9v
bmVfc3Bhbl9yZWFkKHVuc2lnbmVkIGNoYXIgKnN0YXJ0X3B0ciwgdW5zaWduZWQgY2hhcg0KPiAq
ZW5kX3B0cikgIHsNCj4gLQl1bnNpZ25lZCBjaGFyIHN1bSwgKnA7DQo+IC0NCj4gKwl1bnNpZ25l
ZCBpbnQgc2l6ZSA9IChlbmRfcHRyIC0gc3RhcnRfcHRyKSAvIChDTF9TSVpFIC8gMik7DQo+ICsJ
dW5zaWduZWQgaW50IGNvdW50ID0gc2l6ZTsNCj4gKwl1bnNpZ25lZCBjaGFyIHN1bTsNCj4gKw0K
PiArCS8qDQo+ICsJICogUmVhZCB0aGUgYnVmZmVyIGluIGFuIG9yZGVyIHRoYXQgaXMgdW5leHBl
Y3RlZCBieSBIVyBwcmVmZXRjaGluZw0KPiArCSAqIG9wdGltaXphdGlvbnMgdG8gcHJldmVudCB0
aGVtIGludGVyZmVyaW5nIHdpdGggdGhlIGNhY2hpbmcgcGF0dGVybi4NCj4gKwkgKi8NCj4gIAlz
dW0gPSAwOw0KPiAtCXAgPSBzdGFydF9wdHI7DQo+IC0Jd2hpbGUgKHAgPCBlbmRfcHRyKSB7DQo+
IC0JCXN1bSArPSAqcDsNCj4gLQkJcCArPSAoQ0xfU0laRSAvIDIpOw0KPiAtCX0NCj4gKwl3aGls
ZSAoY291bnQtLSkNCj4gKwkJc3VtICs9IHN0YXJ0X3B0clsoKGNvdW50ICogNTkpICUgc2l6ZSkg
KiBDTF9TSVpFIC8gMl07DQpDb3VsZCB5b3UgcGxlYXNlIGVsYWJvcmF0ZSB3aHkgNTkgaXMgdXNl
ZD8NCg0KQmVzdCByZWdhcmRzLA0KU2hhb3BlbmcgVEFODQo=
