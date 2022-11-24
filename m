Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334D26373BA
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Nov 2022 09:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiKXITP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Nov 2022 03:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiKXITD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Nov 2022 03:19:03 -0500
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430A5BF45;
        Thu, 24 Nov 2022 00:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1669277863; x=1700813863;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j9132sknI1wq1OoSPsJLNJu4h4eDLloW29lCKTwoM24=;
  b=fpyr30gb3f8lg+UaxujSdPSVA5WJ08amN92UWn8yuprn64loToVqtUR9
   sH0bCMh9y1tvZEuurDGdI/dVLXbVNPDubIOo8vyKCX0O1+lcwNmm5Hnxu
   dmvpuSMooI6y+HXy7/wZDunsQ8Lo3iyJbTf0DYWTcyhtCGzG0W137/d0j
   IC/EJOqon+9f2n76ShOjpJYVou9IcAcl0KAdErcifJxjOtFv9VmIylVtc
   naUhG23EvNAcv0sBuTqeAHlS2iL5M2yjgkLqZyg6ttC/2Z0JMMcIrrtp4
   DALLhW1jEuX35OGKd5Jdqra2eHZ2qBtCKFujDDfCN0zGyD2n2ZHhsC9x4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="70391277"
X-IronPort-AV: E=Sophos;i="5.96,189,1665414000"; 
   d="scan'208";a="70391277"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 17:17:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4ST8gCGFbwlR9rQFIB8sj4qfpkQsoRz1MWEyjpMiuO42SGbqzPZ45vL8HOdph0lPOV48fZzEPHQEV1rLJ13/j7tjXixqDF+mxhFwK8XMh8W4v4/lwuTp+STCZv+SXc085n50u0XCROPlXqxoEln+/GoC9MSOuHnibwu28HYPghCNRhGQd8pjLFT+VR9LXoXBpUPGPqAZTHYzlBQynQFfmwXBDkhrACQfvK9LnZfbNgsWHG2Qie04OjirrsadiUMS/nr7DwTnNdshdVPsrUHJzvAecjJD3NEaxd2DkCPtZDnhGtnedPtBDGsHQVp2UrGFR6ezXSeZjNeMEfZuI4Mzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9132sknI1wq1OoSPsJLNJu4h4eDLloW29lCKTwoM24=;
 b=fcSPuAmxJMDK9rKTbgkctOUmWIEgEVeOfStV/q5Qt8laHsspdi+SGDFsfZRCCXRzMrJFYuhk5mCgeBlchPTcTa4g+Lxv1RWlaeEqu9aRuytOYYl+b++kpB5goRxjNrWuEUVBvHYlSooM+nq0yNtJXXOCB9NyG5nD9OpkYMVOm78L49w2V3T8JulqgXtaj8Tuu43PgN0Anox5b91Pv7xMlPxx0MafP2OQ0/lKQpY9I0I5LtIRU6v5m1xvxnHyD5bqf6lhCaBb/U14ak6j3rwqNsf0yEv4kbrxPi3hGsCa58v4LDHZZWfXD1ELKC7kLHhmiRtXP/iXvU/YVUIlkAv8pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYCPR01MB9538.jpnprd01.prod.outlook.com (2603:1096:400:192::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 24 Nov
 2022 08:17:34 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::2d81:9d85:cd8d:e41a]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::2d81:9d85:cd8d:e41a%6]) with mapi id 15.20.5857.019; Thu, 24 Nov 2022
 08:17:34 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     'Reinette Chatre' <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: RE: [PATCH v4 4/5] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
Thread-Topic: [PATCH v4 4/5] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
Thread-Index: AQHY+iGKVtajSkrGmEuJ9jg67HQSRq5M00IAgADx+yA=
Date:   Thu, 24 Nov 2022 08:17:34 +0000
Message-ID: <TYAPR01MB6330CDB2C59C58EE77B912538B0F9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20221117010541.1014481-1-tan.shaopeng@jp.fujitsu.com>
 <20221117010541.1014481-5-tan.shaopeng@jp.fujitsu.com>
 <af1b4e59-2b4b-ddbb-2218-0e2808b718a3@intel.com>
In-Reply-To: <af1b4e59-2b4b-ddbb-2218-0e2808b718a3@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMTEtMjRUMDg6MTQ6?=
 =?utf-8?B?MTlaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD0yNzcxNjAxYi0xMWI5LTQ0YzAt?=
 =?utf-8?B?ODkxYS0yZjk2MDJkNzc3NzQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 6a3aa227a55948c78e42dd2f3dbdd87c
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TYCPR01MB9538:EE_
x-ms-office365-filtering-correlation-id: 9716ad64-cd73-4342-fad0-08dacdf4572a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JogZuN+uz8krEyblaHIUt9YQUERM/5DnqgAutaptfS1hm4vm978JcUvu0ZZluuEGY0NY53ZPgCGdoeGuEvnYdgDUKczSmslibSD/hdVyiwzEgzq3o8Phys41HOgZsPot1ocNsFPWc2yf++njBLyQ7UmwcD7cksQJOxbzJ3KEq1gpbjoe0GRZsI9tJllWI/GRkCypbndy2c0WNE0tx0miXV0TG3YYdD17RYfvpkA7zfbdvvJgN91c3+aFhQXlFclI3udIQf7FRgR4cpOf7DXnMnvc81VEw9Gr/e7BYOS3l++e1xzEoQqPBlHo4eoNRrhwod1hstbmE1Jt9TaVFVN4osm0/68OdNeElkKGfDF/gSlfK5VAqmZtKgEsmuH+S6zSwsAbni8ZCO97iEyp0kdvJ6z+r8++2riEpikUNlUQnS/vyCl89sfUw5WWV+eUHluQP9sxvRpFIk64l9dBTjDcJ3kL107gWPart7BZNCp7gckdV/AzG2tt0gY+m+DO66i93+WPwgobywEjPw3AVGIEbYpldJPn8s90umXWgL0/BTDTS75JuJjWHYUTP3brG9OK1amKkcfRGcSBYgxsGivtw1WsTyiRV5+qw6bpoZ6OE/81K6v05X9CHJr0hJ5ztSx9kjbaS/cMpRnbJfw1giflmWMZpPlC3qtm97TASh1rirVgc5CgcWw1N5DMZaESvqZ6AbGkZ5c9Df239Q1QfF2vgaywBR6f0VIndyUTAOIy5Cs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199015)(1590799012)(76116006)(316002)(8676002)(64756008)(66446008)(85182001)(66476007)(4326008)(52536014)(86362001)(66946007)(5660300002)(41300700001)(9686003)(8936002)(33656002)(38100700002)(7696005)(53546011)(82960400001)(186003)(26005)(122000001)(478600001)(6506007)(55016003)(71200400001)(66556008)(83380400001)(110136005)(38070700005)(54906003)(1580799009)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXFlZFZIcTU5WkVmVkx5cHlUUWhybzR5UGxtY0ZXZ1U0NHZYVzlCNXdGZ2Uz?=
 =?utf-8?B?RXJ0eVY4cVBBZE9OL2FmUDEycndPZ0FrZVBLN0kvWjh5SWp2VXBuL0xKakJP?=
 =?utf-8?B?VG84VDRJeTZxVksyQng5U0Y1L0Z6aG5RSWhZd1dPQWtNRFc2YkNIdE9TVzVJ?=
 =?utf-8?B?eFE2RkJxSjZOT3UvN0RIbGNIZmlrVlBOWnpkM0JYS3liaDdzUUJQMzJPYkVw?=
 =?utf-8?B?Zy9lV1dTT2RmNlh5UVBNRWNsN0t0TWsxQnhxRVdDc05SZ1dBS2xKbG54dnlK?=
 =?utf-8?B?Tnoxd1pVWGxncDVXdGxzUXVVL0g0cDJ3eTJwQXNKS0owTUU5Zk5RcHRrSjAv?=
 =?utf-8?B?OG14NEVnbDdPZksyY3BLUzFZTFZWenVHdUJhY3N0R2VsS1FpQnFzOHNYOXZv?=
 =?utf-8?B?dUtDUC8zbVBETk1tK2pWMmZpTnoyTDFDbWFadnZzV3Y0N0ZoZkhac3VFby9j?=
 =?utf-8?B?eDhXM1dyZEQvODZZYW9uTTVSV09hMTkwelgvam9XcUxrc3JCVzlmQUZOcm5q?=
 =?utf-8?B?RThqUGRyTXI3Nlh1azV1cjBFdFBRYmdPOHR5UjduQTIyQ2xyMkFYSndvV01V?=
 =?utf-8?B?akVMZHR5K0xGbGJmZGxpQ3JBKzhtQk9BVm84SnZpRmVVejRLL05TVzJ4aUgv?=
 =?utf-8?B?TWN1WG10eUxvOVFJWHVBM2lGUXNwWkJvOGovYnE1bmIxUGpUa3huSXV3WWpq?=
 =?utf-8?B?SmNRczhVcVNpQ1l1M1BuRzlWMVpCME5yQlQrd3M0ekgvM05VTlI3V1NCNzg1?=
 =?utf-8?B?VEo2ZlZzSDE2RGVITDA0NXpHRmF6RkFrUVM3V2htZ1pzdk9qMkZnVHM5bVlW?=
 =?utf-8?B?VGJOdzBsb3BZbzdFTlFTUFgwbGwyT1l4dGZhS24zTU5RZzcrWk0rOUhpTVNM?=
 =?utf-8?B?VXhTK2Zqc2Qxczd0QWdjejlDTUwxemc2MkxrVkRkakExanZURTlFcTJ1eHZQ?=
 =?utf-8?B?citia2I4SGdaM3pjZjNTZSt2TkR2Nmd5eUJiVDhUTHhkYi8wZTdWM2VXaGZL?=
 =?utf-8?B?cXdCNDZmSmhNRVYybC9WS0NQMTlhellGeXA2TjhpZEd5dHdwR3M1V0lEMTZU?=
 =?utf-8?B?RzNFNDlMSm1nNkNGNm1wQ3RQTG9GSTgyd3FYSDE1OHVuWVlVMk1rRThEc0FS?=
 =?utf-8?B?S2JpNDVqc3ZDN0FRbERPbndHNWhCUnZOQm03dFRKekNBdWtJNnBOL1dsSXJR?=
 =?utf-8?B?WWVKeTRVbDUzTE5JYWcvUDRwekMyQ3c0OGtBMlQ2cUVpY3pCUW1RNURFSEdI?=
 =?utf-8?B?Z3U2ZnRkRnFIYkQybHAxcUcrUHg1SzdsYU43eFk2TEtmc1d6b09FMlIrdUxt?=
 =?utf-8?B?YUFLZDc5cy9lQnVCem1tb0FZT203akVmcTJub0YrZVRlUE5kVU1EeS9CbTJt?=
 =?utf-8?B?NXI4bHlmWHYxanJhNDhSSFc1eS9MV3N6dUV3QXU0MmdEbWpDcDZRbFlmSUsw?=
 =?utf-8?B?amVJelgvNWFTOW1FcFpoeHM0WmlWRVRjaElydm5RQmxjUVpIYnlXU0VmZnha?=
 =?utf-8?B?TWk2Skl3WnhTLyt6Q0ozNENBUENYdVFTTE0zaHJjbGUydGIwS2ZPTFRDOXl4?=
 =?utf-8?B?RlVVT2JNKzVmNnVWVXhRelFpUE5VOU9QVlRpRzA5L1A0T0hob0pYb1lrMjQ3?=
 =?utf-8?B?VklmUCtlNHdjbFVqYlcvNWJJdjJJdEs2MVRaY1E5Mnp0dFpST1gvQWRmcFIr?=
 =?utf-8?B?NUNZbFkyM210TDkxOE1DNi9YV2FxLzliRDdITVZydXVpN1hBek9mL3ZpTW9j?=
 =?utf-8?B?YmVrSUlvU1daeFpvVkZMZTh5aUgzcy9jRHlWWU1VVkFobklhRCtnRFFoeFRR?=
 =?utf-8?B?ems3YmREZFduYWYyUTlIWXRObmZmODhuNnBtSTRRSm9GVXlWUjlGQ0NxcEpE?=
 =?utf-8?B?Y2w3T2JtYkhJYXZwNGRxS2J0T0FBSlNmSDNUWHFJd3gxcGdCa1FLK3FQTkNq?=
 =?utf-8?B?Q3Vmb2RmMFBBaFRxRFVJeHNOZXJianNuYU1scGNRbXFweGhqZXA1U3YrM1VP?=
 =?utf-8?B?VnhHajdOcS9lblVNN2RJR1R5SlEwK2NWeTZkMzVKSm52ZFI1UHNuSFhEOHRH?=
 =?utf-8?B?MENOUkUrcU1DRDdvaUo4UkNSQXZxaDVMZW4vRlF4L3NDSTBFV0k5SFo4RUVj?=
 =?utf-8?B?WHRiR1hwVjRlZlF5VWZ3UUV5Tzg5ak9xNk01aytzczUrbXlPdTdnT0Q2SHNO?=
 =?utf-8?B?RGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dXRVYXB1ejR2T1Z5RWFEUHFxVmFoalZvWXJtV05LYUdCUUU2ZGcyRUc1Tlgz?=
 =?utf-8?B?NW1kODIvcGw2WDY4VTl4Zk5ncitjRjlNUllSWkFIQXVOSVZrRzMvZHYzV3NJ?=
 =?utf-8?B?ZHg1d3k5Q3RqYVE1am5KdWkrY2JQTjN0ZDV6SXhFa01nV0hqVEM4ei9FMHJI?=
 =?utf-8?B?ZjMwSWRhcUcxcy9saEZ4MHozejFDL0V5YkRuUXdRYXMyZWhxbkpoM3NTb1dz?=
 =?utf-8?B?aUdNUFgzY2xjQjI0WGd1WEd2TFhzR3JHbEVtaXg5d0pZMVpzQlFtQ29TKzZB?=
 =?utf-8?B?T1RXQVoxWHphaVlIbTE0cG1xWENDVnNaMEpVL0FnSzE4SXRZUjA4MVN0NERM?=
 =?utf-8?B?S3EvaERHWGZpem0zRmphWm1IUWJEaXdMOWkvQnBZR2huS2krOTM5dFpEZVRn?=
 =?utf-8?B?UkxyaU90Q3NUYlFRK1VWeko5dkYzNG1aMzdORDlyMDBuaGJ0aVpOV0gyVW9t?=
 =?utf-8?B?TkkyUHpERUllTHlhbC9BeDBQY0Y5aDBkSGRSQk9lMStkV1hyMXJ5Q1BYcG9K?=
 =?utf-8?B?U2hqUFR5akVpTDVNZnhyR1pyK2hidEJ3SFV3MFRBSWR0cTFMY2tzSGRNdzcv?=
 =?utf-8?B?dE1OVjBPNUdSQ3NzbzlNL3hCRzlVQjluaVBGRTlPT0hzeWdyZDA0Z011L29q?=
 =?utf-8?B?R1VIVWViS3pPdngzQ0JibWwyaHZISlRpQ1pYbVNRY1V6NFRTaFB4Yi9qblVn?=
 =?utf-8?B?czRpaVRzSXBRWmhzN29uUkdVWUd1YmlXVzMyYWJoUTV4N3FhekhxZkdlZ1d3?=
 =?utf-8?B?d2xILzBzVUd1K3c2eXN3Tnhwak5KcDRMeVlmaXVhODVPTkQvb3BwQjlRMmxw?=
 =?utf-8?B?bFM0VEpLRjNxRm8rRTM5clB2a0d1bmxrRGR3ZWQ5MXpRaFdOV3dlbzBUaEZz?=
 =?utf-8?B?RXdDTzZ3SjRuSmdtTmVoOFhHTkExRG12dXNDdlU2UE9mYmNOdEg2VmNzaGZM?=
 =?utf-8?B?YVRxSVJ4NE9FVVZRaGgzUER2bHgzdXlDbnV3dkRkbkpLNXljQnJOcU9WeDU4?=
 =?utf-8?B?TVFJZ21SRHdROEtnQ1BPc3R4ZmNpL1IvY2NNdWRoaXo4TmpuV3lDSmh6cHNt?=
 =?utf-8?B?ZVlmbUxyTFpiUmZHV0lBWFNtN2t1K2NhZlhhUzdsZ2V2R3h1WFFsTjA1ZDZm?=
 =?utf-8?B?US9oOFlDK2NmUE5mZXVQNWN5U2RpSG1FalBlS2NJVWdLYTlGMXB4VERBT0l1?=
 =?utf-8?B?ZG5TNFk5V1VXRENpdmxGeFVrWXRXSGlpbUhrbnNvdGRZV0k2Zks4bHAyTVJL?=
 =?utf-8?B?eUVUcWFVY3g5S1Q5NzVaNi9GVzBSNEMrcjdBZDBPWGZoMmFvUT09?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9716ad64-cd73-4342-fad0-08dacdf4572a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 08:17:34.4182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cU5KB+wwJeFkTlgXoSyCUIvDKOSt5wEiIUNuku+Y8gYQMQIVzxZzzXnCMc0uRjV0Y+4oQ0UGlCNefw3G42ZeSBeHA816WYRuOUzWg9B/pSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9538
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgUmVpbmV0dGUsDQoNCj4gT24gMTEvMTYvMjAyMiA1OjA1IFBNLCBTaGFvcGVuZyBUYW4gd3Jv
dGU6DQo+ID4gQWZ0ZXIgY3JlYXRpbmcgYSBjaGlsZCBwcm9jZXNzIHdpdGggZm9yaygpIGluIENB
VCB0ZXN0LCBpZiB0aGVyZSBpcw0KPiA+IGFuIGVycm9yIG9jY3VycyBvciBzdWNoIGFzIGEgU0lH
SU5UIHNpZ25hbCBpcyByZWNlaXZlZCwgdGhlIHBhcmVudA0KPiA+IHByb2Nlc3Mgd2lsbCBiZSB0
ZXJtaW5hdGVkIGltbWVkaWF0ZWx5LCBidXQgdGhlIGNoaWxkIHByb2Nlc3Mgd2lsbCBub3QNCj4g
PiBiZSBraWxsZWQgYW5kIGFsc28gdW1vdW50X3Jlc2N0cmxmcygpIHdpbGwgbm90IGJlIGNhbGxl
ZC4NCj4gPg0KPiA+IEFkZCBhIHNpZ25hbCBoYW5kbGVyIGxpa2Ugb3RoZXIgdGVzdHMgdG8ga2ls
bCBjaGlsZCBwcm9jZXNzLCB1bW91bnQNCj4gPiByZXNjdHJsZnMsIGNsZWFudXAgcmVzdWx0IGZp
bGVzLCBldGMuIGlmIGFuIGVycm9yIG9jY3VycyBpbiBwYXJlbnQNCj4gPiBwcm9jZXNzLiBUbyB1
c2UgY3RybGNfaGFuZGxlcigpIG9mIG90aGVyIHRlc3RzIHRvIGtpbGwgY2hpbGQNCj4gPiBwcm9j
ZXNzKGJtX3BpZCksIHVzaW5nIGdsb2JhbCBibV9waWQgaW5zdGVhZCBvZiBsb2NhbCBibV9waWQu
DQo+ID4NCj4gPiBXYWl0IGZvciBjaGlsZCBwcm9jZXNzIHRvIGJlIGtpbGxlZCBpZiBhbiBlcnJv
ciBvY2N1cnMgaW4gY2hpbGQgcHJvY2Vzcy4NCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBTaHVhaCBL
aGFuIDxza2hhbkBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoYW9w
ZW5nIFRhbiA8dGFuLnNoYW9wZW5nQGpwLmZ1aml0c3UuY29tPg0KPiA+IC0tLQ0KPiA+ICB0b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL2NhdF90ZXN0LmMgfCAzMA0KPiArKysrKysrKysr
KysrKy0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxMCBk
ZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9yZXNjdHJsL2NhdF90ZXN0LmMNCj4gYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJs
L2NhdF90ZXN0LmMNCj4gPiBpbmRleCA2YTgzMDZiMGExMDkuLjFmOGY1Y2Y5NGU5NSAxMDA2NDQN
Cj4gPiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL2NhdF90ZXN0LmMNCj4g
PiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL2NhdF90ZXN0LmMNCj4gPiBA
QCAtMTAwLDEwICsxMDAsMTAgQEAgdm9pZCBjYXRfdGVzdF9jbGVhbnVwKHZvaWQpDQo+ID4NCj4g
PiAgaW50IGNhdF9wZXJmX21pc3NfdmFsKGludCBjcHVfbm8sIGludCBuLCBjaGFyICpjYWNoZV90
eXBlKQ0KPiA+ICB7DQo+ID4gKwlzdHJ1Y3Qgc2lnYWN0aW9uIHNpZ2FjdDsNCj4gPiAgCXVuc2ln
bmVkIGxvbmcgbF9tYXNrLCBsX21hc2tfMTsNCj4gPiAgCWludCByZXQsIHBpcGVmZFsyXSwgc2li
bGluZ19jcHVfbm87DQo+ID4gIAljaGFyIHBpcGVfbWVzc2FnZTsNCj4gPiAtCXBpZF90IGJtX3Bp
ZDsNCj4gPg0KPiA+ICAJY2FjaGVfc2l6ZSA9IDA7DQo+ID4NCj4gPiBAQCAtMTgxLDE3ICsxODEs
MjUgQEAgaW50IGNhdF9wZXJmX21pc3NfdmFsKGludCBjcHVfbm8sIGludCBuLCBjaGFyDQo+ICpj
YWNoZV90eXBlKQ0KPiA+ICAJCXN0cmNweShwYXJhbS5maWxlbmFtZSwgUkVTVUxUX0ZJTEVfTkFN
RTEpOw0KPiA+ICAJCXBhcmFtLm51bV9vZl9ydW5zID0gMDsNCj4gPiAgCQlwYXJhbS5jcHVfbm8g
PSBzaWJsaW5nX2NwdV9ubzsNCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJLyoNCj4gPiArCQkgKiBS
ZWdpc3RlciBDVFJMLUMgaGFuZGxlciBmb3IgcGFyZW50LCBhcyBpdCBoYXMgdG8ga2lsbA0KPiA+
ICsJCSAqIGNoaWxkIHByb2Nlc3MgYmVmb3JlIGV4aXRpbmcNCj4gPiArCQkgKi8NCj4gPiArCQlz
aWdhY3Quc2Ffc2lnYWN0aW9uID0gY3RybGNfaGFuZGxlcjsNCj4gPiArCQlzaWdlbXB0eXNldCgm
c2lnYWN0LnNhX21hc2spOw0KPiA+ICsJCXNpZ2FjdC5zYV9mbGFncyA9IFNBX1NJR0lORk87DQo+
ID4gKwkJaWYgKHNpZ2FjdGlvbihTSUdJTlQsICZzaWdhY3QsIE5VTEwpIHx8DQo+ID4gKwkJICAg
IHNpZ2FjdGlvbihTSUdURVJNLCAmc2lnYWN0LCBOVUxMKSB8fA0KPiA+ICsJCSAgICBzaWdhY3Rp
b24oU0lHSFVQLCAmc2lnYWN0LCBOVUxMKSkNCj4gPiArCQkJcGVycm9yKCIjIHNpZ2FjdGlvbiIp
Ow0KPiANCj4gV2h5IGtlZXAgZ29pbmcgYXQgdGhpcyBwb2ludD8NCj4gDQo+IEkgdHJpZWQgdGhp
cyBjaGFuZ2UgYnV0IEkgd2FzIG5vdCBhYmxlIHRvIHRyaWdnZXIgY3RybGNfaGFuZGxlcigpLiBJ
dA0KDQpJIHRlc3RlZCB0aGlzIGNoYW5nZSB1c2luZyBrc2VsZnRlc3QgZnJhbWV3b3JrLA0KSW4g
dGhpcyBjYXNlLCB0aGUgdGltZW91dCBjb21tYW5kIHNlbnQgYSBTSUdURVJNIHNpZ25hbCwNCmFu
ZCB0aGVuIGN0cmxjX2hhbmRsZXIoKSB3YXMgdHJpZ2dlcmVkLg0KU2luY2UgdGhlIGhhbmRsaW5n
IG9mIFNJR0lOVCBhbmQgU0lHSFVQIHNpZ25hbHMgaXMgb3ZlcnJpZGRlbiBpbiBydW5fZmlsbF9i
dWYoKSwgDQpjdHJsX2hhbmRsZXIoKSBtYXkgYmUgY2FsbGVkIGlmIGN0cmwtYyBpcyByZWNlaXZl
ZC4NCg0KPiBzZWVtcyB0aGF0IHRoZSBoYW5kbGVyIGlzIGNoYW5nZWQgc29vbiBhZnRlciAoc2Vl
IGNhdF92YWwoKS0+cnVuX2ZpbGxfYnVmKCkpDQo+IGFuZCBjdHJsX2hhbmRsZXIoKSAobm90ZSB0
aGUgc3VidGxlIG5hbWUgZGlmZmVyZW5jZSkgaXMgcnVuIGluc3RlYWQgd2hlbg0KPiBhIFNJR0lO
VCBpcyByZWNlaXZlZC4gVGhlIHZhbHVlIG9mIGN0cmxfaGFuZGxlcigpIGlzIG5vdCBjbGVhciB0
byBtZSB0aG91Z2gsDQo+IGFuZCBpdCBjb3VsZCBldmVuIGJlIGFyZ3VlZCB0aGF0IGl0IGlzIGJy
b2tlbiBiZWNhdXNlIGl0IHN0YXJ0cyB3aXRoDQo+IGZyZWUoc3RhcnRwdHIpIGFuZCBzdGFydHB0
ciB3b3VsZCBsaWtlbHkgYWxyZWFkeSBiZSBmcmVlJ2QgYXQgdGhpcyBwb2ludA0KPiB3aXRob3V0
IHJlc2V0dGluZyBpdHMgdmFsdWUgdG8gTlVMTC4NCj4gDQo+IEZyb20gd2hhdCBJIHVuZGVyc3Rh
bmQgY3RybF9oYW5kbGVyKCkgYW5kIGl0cyBpbnN0YWxsYXRpb24gZnJvbQ0KPiBydW5fZmlsbF9i
dWYoKSBjb3VsZCBiZSByZW1vdmVkIHNvIHRoYXQgaXQgZG9lcyBub3Qgb3ZlcnJpZGUgd2hhdCBp
cyBiZWluZw0KPiBkb25lIHdpdGggdGhpcyBjaGFuZ2UuIE90aGVyd2lzZSwgZnJvbSB3aGF0IEkg
Y2FuIHRlbGwsIHRoaXMgbmV3IGhhbmRsZXINCj4gd2lsbCBuZXZlciBydW4uDQoNCkkgdGhpbmsg
cmVtb3ZpbmcgY3RybF9oYW5kbGVyKCkgaXMgZmluZS4gDQpJbiBDQVQgdGVzdCwgaXQgb3ZlcnJp
ZGVzIGN0cmxjX2hhbmRsZXIoKS4NCkluIG90aGVyIHRlc3RzKENNVCxNQkEsTUJNKSwgdGhlIGNo
aWxkIHByb2Nlc3MgdXNlZCBjdHJsX2hhbmRsZXIoKSB0byBjbGVhbnVwIGl0c2VsZiwNCmJ1dCB0
aGUgcGFyZW50IHByb2Nlc3MgY2xlYW51cCB0aGUgY2hpbGQgcHJvY2VzcyB3aXRoIGN0cmxjX2hh
bmRsZXIoKSBwcm9wZXJseS4NCkFsc28sIGF2b2lkIHVzaW5nIHNpZ25hbCgpLg0KIGZpbGxfYnVm
LmPvvJpydW5fZmlsbF9idWYoKQ0KIDIwMSAgICAgICAgIC8qIHNldCB1cCBjdHJsLWMgaGFuZGxl
ciAqLw0KIDIwMiAgICAgICAgIGlmIChzaWduYWwoU0lHSU5ULCBjdHJsX2hhbmRsZXIpID09IFNJ
R19FUlIpDQogMjAzICAgICAgICAgICAgICAgICBwcmludGYoIkZhaWxlZCB0byBjYXRjaCBTSUdJ
TlQhXG4iKTsNCg0KSSByZW1vdmVkIGN0cmxfaGFuZGxlcigpIGFuZCByYW4gcmVzY3RybF90ZXN0
cyB3aXRoIGFuZCB3aXRob3V0IHRoZSBrc2VsZnRlc3QgZnJhbWV3b3JrLg0KVGhlcmUgaXMgbm8g
cHJvYmxlbS4NCg0KQmVzdCByZWdhcmRzLA0KU2hhb3BlbmcgVGFuDQo=
