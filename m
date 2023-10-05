Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5F97BA57F
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Oct 2023 18:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237054AbjJEQRb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Oct 2023 12:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240540AbjJEQPb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Oct 2023 12:15:31 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FFD6583;
        Thu,  5 Oct 2023 07:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1696516314; x=1728052314;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KNsgJKVtfW/6tqXCTYQy2d+p879NaKFC9pGCz3GK+C4=;
  b=FeV9wbMRI0IJz1R4lla/E0M3RVNQFEFkWE6mzNjm5iNlfX67UUAorbZA
   8Hle3cFkU1/8u2FKXWUjx44Q9FxMYzNRbTs7UTjMRKt/a+WP5UTSVAU9P
   1l1k7U6RSMl8w1eWo0Kv9ODx6LgjtRiH4X/UcbMmw8IcAKkV0AEfGJPwX
   pxRqgMmOVSuQA31TDvSJvn547mT5FGwLukHqUm6w3kfiMN8zoQXBzJciB
   kH4OybTdPg5j2cBq/Fs9vSzHt1byS6FxhQy59NIFBX+uUeIkbUa9JZ5dr
   t2aAbDrk5v9cYycsRuJD5ycww8/wUNpis4zJFqBblsZdzI4e/du12kUqo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="97968392"
X-IronPort-AV: E=Sophos;i="6.03,202,1694703600"; 
   d="scan'208";a="97968392"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 16:53:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oc0cWymTVAqLnut5jR+J6/XVz33BjqUy+XWgZQ5DY2gwPHzysG44UJvgqbDM0JsJvArcv8o9PB4NHzQvlNuRsbQ5Q4cC6B2IqtxAwrMSZoWOf7bwsdsdFzT/oVzVUzaIVlbMBp+1HCk6vqMtfHHbxdGxxN76B8M3FDPBTxjdfx2y8SGcFd5Q2KreoqN7TKIhDOJVM2EJRAYUs+Nz67oDZLqVhCiMqMD275G8sqey0smLZsZ6wC5Ch23RWdm1liXQAQ9OdiQp/lKBmQgD5JoNgORNrPyW+uNxu8OYXXHTGkms5QqidqvJtSsP/7jYtF9Rxs1zODfb5EperRqaQRuBvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNsgJKVtfW/6tqXCTYQy2d+p879NaKFC9pGCz3GK+C4=;
 b=ZzMTMRPj9duomLrk3t4apkk8LpPcob3pQIRjDkg9o3Gv0Zo92bp/XF7aDSdbCDmS3Y3bPK8n8smRH+11j0hxdp6hQ2xwYOL+R3B8cTk6efPOJsumGSnVNaZi86lrt1U+68X82vRNmYbUwFuIn5hL/hXm27EBhrJtewIHJ6o5YkVVHKZZ+aQZ8fknX6IWjq6KhVr9Ze5YdN1jsRmPsLAV+zu2N4KYePstjXf3i2aVeZHOrPX6qV1yLef8LzOZHCg50Opf37MTGyraordsV0jRsyVWI+wJBvbPTQyPUELOsWG5TCtzjv1kDl2Ffw8kpYQt6+pZs2h3vbSnGmcJh6LL9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYAPR01MB6012.jpnprd01.prod.outlook.com (2603:1096:402:38::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 07:53:29 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::59bd:366a:131b:3f26]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::59bd:366a:131b:3f26%3]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 07:53:29 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     'Reinette Chatre' <reinette.chatre@intel.com>,
        =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        =?utf-8?B?TWFjaWVqIFdpZWN6w7NyLVJldG1hbg==?= 
        <maciej.wieczor-retman@intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2 1/6] selftests/resctrl: Extend signal handler coverage
 to unmount on receiving signal
Thread-Topic: [PATCH v2 1/6] selftests/resctrl: Extend signal handler coverage
 to unmount on receiving signal
Thread-Index: AQHZ5+uWrWWhOFDDhk+rvyPKF/LMXrAts8aAgAJA9XCACg/hAIAA6g0Q
Date:   Thu, 5 Oct 2023 07:53:29 +0000
Message-ID: <TYAPR01MB6330FD62ED8A752ECDA8AF948BCAA@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20230915154438.82931-1-ilpo.jarvinen@linux.intel.com>
 <20230915154438.82931-2-ilpo.jarvinen@linux.intel.com>
 <d2d94def-742d-7661-3632-b9f7e4996415@intel.com>
 <TYAPR01MB6330F248767F48A2A649CDE58BC1A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <0033ee44-5383-4e69-b85d-ed88592bee94@intel.com>
In-Reply-To: <0033ee44-5383-4e69-b85d-ed88592bee94@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9YzU0YWFkMDUtNDg0OC00YTc1LWE0OWYtNGQ3NDdlOGYx?=
 =?utf-8?B?Nzk4O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMy0xMC0wNVQwNzo0MDo0NVo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 38061419133f447cb91dd61e2378f8d2
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TYAPR01MB6012:EE_
x-ms-office365-filtering-correlation-id: 553e9f06-edf5-462a-36fb-08dbc5782a42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GwuJzYCvMO9HuQRNqiW3X0QVxuRt7VS94ONqPS/vv1PtPhTGjbCDYO8CBrgbXGrxqiDmOgFIrjR30pUIjbLDCT9kAQE9Yf8s6/nKMIoDKASn085i7FOMBoC6anb/ES7MmFYwtTG4E/s3lOQTxM75cw1zX4RhObEUOglYTmhwsfFkAl2G90uJSwvdtFFbE4awCkddmqUvooNCu7v2BSPgGPbbn8M5jNLZmK24yI56TWT628F+PY/4lZ/TPymovKdlPKVCCOFGTenBpP2z1c66H+XYJn5sTCPtyiXXxrygV66ZkHW5N8Jnqn/k3i4fEljqSrAwTss5wE4rnXdVZjCuU7+Y2Ra2dKn75aiZnkYyPl5cZsyviKI3+O7Fv6s24ZDn5EnhzrVDvHhOzHKmjOoRWv7yRcXK25MZGFlPdeUnXz4jILauGoh8/eDB/EHJY/oUuTMoXLVH4Lfdvj6NnHCDe2o/QpmSfaaVyN9AeaIIc9npdhNPz5b+aq1j0iJfnjEsP4i3QPrPPBW9cDxGbWKBE/8YMUgCtxqqZfaGpzA+uILkic9Fpk3Ef+EtWXAiI8JuDJW3tJgnlZ6pjwVKXBKar6sxdeq65JdrilRCc29b5Xt0wZ7CHNoKmW5OewHufSZQDnASjkRKkzSTnUoJbmi/Rg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(346002)(136003)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(1590799021)(186009)(1580799018)(26005)(9686003)(2906002)(82960400001)(33656002)(122000001)(85182001)(86362001)(38100700002)(38070700005)(66574015)(55016003)(66946007)(66476007)(5660300002)(66556008)(110136005)(66446008)(64756008)(54906003)(83380400001)(76116006)(52536014)(478600001)(41300700001)(316002)(4326008)(8676002)(8936002)(53546011)(6506007)(7696005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkRMTytFZVRsdVFhRE1ZVjFleXloRjNJZFVrajRDZU5YK3BPQmJxR3dESjFY?=
 =?utf-8?B?SmRFYVJHUnllcGpVa291bEZWeXBtaktkMllGZTFEZVM4TEdtSjlGUTVwM1R1?=
 =?utf-8?B?emMwclI4UEE2WXRRSDU1Ly92T3RDdTZaOXpFamUrU3BLYTB0NnVoTlFTcGtn?=
 =?utf-8?B?Y0pUT0hXdkJocnF2TEF4REdrVnlaNEY2OXR6YXRnOWczSmNWS0VYRDM0b1E0?=
 =?utf-8?B?Y05qZXljdFlZNXBhUUw5eTlIVXlJTWUvN3YzYWtJVk81cGI4TTNNdkNUdW9P?=
 =?utf-8?B?U2pocy9GWEpQRS8yWlBpVSsxUkIxSGdoNWw2a2srVjc4ZVVNWGcyaW9LcWkx?=
 =?utf-8?B?VGhlRXJlaXhJbnpjUThZTG40S2UxT2FNWXU3UXpmYllJcDM1N3N4SjBITitN?=
 =?utf-8?B?dXA1b29pbld6VUJCa1E0YTlJQ3NZV2tEVnhlTC8yRURsamdOMlFkWlJBV2tN?=
 =?utf-8?B?bTNRS0hDK1dFcGVkRE5WYm8rQ1l2NG1sclFBcDVsdFBYTFlpMCswTFNuZEdJ?=
 =?utf-8?B?OEFNaDQ0UlJBK00vQlgwZC9PUWlNU2ZoSlo3bnlCeEM3WC9RODR6R3BkbDFo?=
 =?utf-8?B?aWZXSXFxbWwrU1hqa1FLL1hUaU8rcGtwYzN6T3dWKy9XVWVxekVHZ2l5dFJW?=
 =?utf-8?B?ZUgwbmpWbURST05sRWcybXZodkRrNUV5WXE0MzQydjB6UUxMeURhQWlOMDEy?=
 =?utf-8?B?VWJWYmxnNU42cEtLMlFjMzM4QytyaDFYUUs1N3NadlI1S2F5bXZld2lRK2M1?=
 =?utf-8?B?TlE3RWQzb0tJV0FVUEM4K25ZTTN6Q0lFMnRGc3VmU3VtN0IxT2FOb0FIZXBX?=
 =?utf-8?B?UDZYcXRlVytTV2lnQ2dSdEx0TVcyWkczQStjQWtRUDdLWG9kYUJCeUxET1A4?=
 =?utf-8?B?V05YdUI0STRmK0l2NjN3ekxHUDg0cjVDbkQ3enhEb3ZIZ2Uxdk5iUFl3VzYy?=
 =?utf-8?B?aWtuYmsyVTA4b2FEU1pLbkdyVTVTYWZSQ2pJUTVzL3FJMWExYm93bEZ1STNB?=
 =?utf-8?B?WGIvYXUrV2ZDK1prWWU0ZGRWcWNlZkpObzQ2VzMwQXgrd2FZbzRRRXFsK28x?=
 =?utf-8?B?cDdyUk1maG5FRTNVMkdZVGR3L0NpaStOaVZoT1Q2N1Nqa1VqK2tHMDBjYU11?=
 =?utf-8?B?SjZCeTV4M1FRZmV1VEdQSXAzY3J0TWVET1picWljbkNJdTFPUjBIbE5oS2pN?=
 =?utf-8?B?eFJvUVpqaXY5QXU1Q0I5bzlhdmR6cnhpTFZ0bk1UaWxvNkg3NzNJOGhCVVZL?=
 =?utf-8?B?em1zQnRyVjhLbnhheVlOemExQTlUdUQvaCs5SVhyZlAzNzhtZkRrc2xNdjhy?=
 =?utf-8?B?NmpRM1d5c0NOcm5YdWRVWHVrRExDditTalVoSW0raEtLclAzWmVTVFRnQ29w?=
 =?utf-8?B?RElPdXNmRWp2ZnFsU3RZMXFQcCtqSUJGVURkUVhCcGVQK3V2cWIvYmdtS0Fv?=
 =?utf-8?B?NnRqWnUvWjl0Z1Q5cWhXTnlyZ0dMNmJEMEk1OUxiMlkycjExVEkrTVVlckFw?=
 =?utf-8?B?VHRrcHR3TGR4UWtGYnoreVZTeHNTWHl3ZkNYV1RlR1NmSXQ4b2NJS042NWdm?=
 =?utf-8?B?TUJyYllESzRJOXBDSUN4aWVjRFR5M3laT000WXJERDFJYVdaT2FVek9MYkli?=
 =?utf-8?B?SWZMR2lRcnVNTnBPbC8vZitaOHozakRIRzQ4Ym9kenhNWm5oVkdSU3lVNGdq?=
 =?utf-8?B?ZG9id3VCMWRqV05SU2I3MXFlYVlGQTRGSEU2eU1IWlhKa3dpWlFDMHowaDNa?=
 =?utf-8?B?U0ZoMW1KVVpNSFZXai83MXNUc3M3YkVGSUZ1YU5aV01rdmlUMGdFNy80T2RS?=
 =?utf-8?B?VHVsY2htcmZXN2tJRWZjNy96RXJDeFpVTy84N3BnR2hZVlh3bkdpNGx0bmhj?=
 =?utf-8?B?SVpZUUZVUDZTeEp6N3dRKzY5TDFvNnJYTEYrYUowa0RXNkl3U3lzZGxvUGNv?=
 =?utf-8?B?TzJjQXY1MFFIRW9FcStlSnRkR05RU3g2TFFwa1ErcE01SkhrMHh5d1lwRE04?=
 =?utf-8?B?VkxqOTZpUWV2MmJqNThndjk1RDY1eVVVdGRPTzhxTGhCY1BLdytibmFseWNz?=
 =?utf-8?B?aWc3bkhOQ2d4elFtU0NFbkdldmdzUTdoVktQV0drdXRTd3hVREI2Q0FYa1BD?=
 =?utf-8?B?bHdDcnNQbjVNUkhSMjV0Mm55c1ZlSDNRc1dQWGlEdlRQdUZiVFhYZDIydHFX?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZOYX0khN5q4uQTobIkjE2kqD9PxQRKgui0DnSVhBjBYc87sNGeY2xWj9epDRSBU9hLtxw23oEZuuNE9+cfS+jNzxUnWakfagMIqQ7IAVmgxVZRZ6F+j2TG3xFN4D8kJllYwaykZvI1XLxESZMiTcbN3Ns2oRP7IohmdgMZ1gF8sNny4Ia/quQMp6yJjFlVUT5x0D8+YRUfLEya8vamgT6G0xhtGd2T+5IqK+/VTtwWTZaqLnjZiAvq0m2NQCNcMBsCmY8KpRPap93dOmQqhyJVY8Yap/tsrjS6xQicKkXA+YHFOKoKLnYKHgbFdiMI0UIOuPkmD9TmhQFO+rUTg+ymlkOa1q/H+92vLzwrIekGd6RX6VJ4cI+hZpAUC+0m1sQ09YiNLGQ/b05Y+evJxUMADLMmROM9brJRQPKbY9wxjMgIvOemjFZ912gTJ7pjAOr4E5tjqx1mMSVGNct2eFWCtJ9KP94OYXHvTXzrq2v8wo9+XoZRHnVtq/LdSiXa4SFoSX+zQJkcIhQDTtlNaOVp5Mbibm8moq0ejoMQb2UpY73/DdxOhEW/syab7nt+mz2d/H9l2/kCa+H1xB9u0pNV41O5JWPsTyNI6F83/sQ0E76FxfDnQuD555wl/G2pQcu/BnLDGF7z0Esw4WyKnBQjHuBjWAcEnOiZKAWsphQ3HEEAW+awQ9r36bs3GMfljmoBdlldEMjt3jD6XPjemYzL+/ObRGuhjK8luQO7anzdt03HypBrN2dM1wm15PkPdEU+OeveuFbr1tCH7kbNYQYJlwdWms/PswbP5BcDZJm4abDpllonXndF9U8uPZxDQmE8csTzJCNP35ESQqu8Yqd2Kso73IAQ5lP3mhIf+0VPEUBaPnVkZzfdbWgZQD+42X1KjIgI321g0LSjfvPgM+iQ9CTSfUA/YymYrfybcC9Jg=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 553e9f06-edf5-462a-36fb-08dbc5782a42
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 07:53:29.8757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RWJEpoZ7uRsKp4ixQAixiBt8a+vLYybeXNWaurPac/tgghp4wyL+Vejbf2N4T09Kq7TNmrTilwMpDJ0hNxve3Q3P5Jotq94dDU2eyYkkXHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6012
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGVsbG8gUmVpbmV0dGUsDQoNCj4gT24gOS8yOC8yMDIzIDE6MTAgQU0sIFNoYW9wZW5nIFRhbiAo
RnVqaXRzdSkgd3JvdGU6DQo+ID4+IE9uIDkvMTUvMjAyMyA4OjQ0IEFNLCBJbHBvIErDpHJ2aW5l
biB3cm90ZToNCj4gDQo+IC4uLg0KPiANCj4gPj4+ICtzdGF0aWMgdm9pZCBydW5fbWJtX3Rlc3Qo
Y29uc3QgY2hhciAqIGNvbnN0ICpiZW5jaG1hcmtfY21kLCBpbnQNCj4gPj4+ICtjcHVfbm8pIHsN
Cj4gPj4+ICsJaW50IHJlczsNCj4gPj4+ICsNCj4gPj4+ICsJa3NmdF9wcmludF9tc2coIlN0YXJ0
aW5nIE1CTSBCVyBjaGFuZ2UgLi4uXG4iKTsNCj4gPj4+ICsNCj4gPj4+ICsJaWYgKHRlc3RfcHJl
cGFyZSgpKQ0KPiA+Pj4gKwkJcmV0dXJuOw0KPiA+Pj4NCj4gPj4NCj4gPj4gSSBhbSBub3Qgc3Vy
ZSBhYm91dCB0aGlzLiBXaXRoIHRoaXMgZXhpdCB0aGUga3NlbGZ0ZXN0IG1hY2hpbmVyeSBpcw0K
PiA+PiBub3QgYXdhcmUgb2YgdGhlIHRlc3QgcGFzc2luZyBvciBmYWlsaW5nLiBJIHdvbmRlciBp
ZiB0aGVyZSBzaG91bGQNCj4gPj4gbm90IHJhdGhlciBiZSBhICJnb3RvIiBoZXJlIHRoYXQgdHJp
Z2dlcnMga3NmdF90ZXN0X3Jlc3VsdCgpPyBUaGlzDQo+ID4+IG5lZWRzIHNvbWUgbW9yZSB0aG91
Z2h0IHRob3VnaC4gRmlyc3QsIHdpdGggdGhpcyBjaGFuZ2UNCj4gPj4gdGVzdF9wcmVwYXJlKCkg
b2ZmaWNpYWxseSBnYWlucyByZXNwb25zaWJpbGl0eSB0byBkZXRlcm1pbmUgaWYgYQ0KPiA+PiBm
YWlsdXJlIGlzIHRyYW5zaWVudCAoanVzdCBhIHNpbmdsZSB0ZXN0DQo+ID4+IGZhaWxzKSBvciBw
ZXJtYW5lbnQgKG5vIHVzZSB0cnlpbmcgYW55IG90aGVyIHRlc3RzIGlmIHRoaXMgZmFpbHMpLg0K
PiA+PiBGb3IgdGhlIGZvcm1lciBpdCB3b3VsZCB0aGVuIGJlIHVwIHRvIHRoZSBjYWxsZXIgdG8g
Y2FsbA0KPiA+PiBrc2Z0X3Rlc3RfcmVzdWx0KCkgYW5kIGZvciB0aGUgbGF0dGVyDQo+ID4+IHRl
c3RfcHJlcGFyZSgpIHdpbGwgY2FsbCBrc2Z0X2V4aXRfZmFpbF9tc2coKS4NCj4gPj4gU2Vjb25k
LCB0aGF0IFNOQyB3YXJuaW5nIG1heSBiZSBhbiBpbmNvbnZlbmllbmNlIHdpdGggYSBuZXcgZ290
by4NCj4gPj4gSGVyZSBpdCBtYXkgYmUgb2sgdG8gcHJpbnQgdGhhdCBtZXNzYWdlIGJlZm9yZSB0
aGUgdGVzdCBmYWlsdXJlPw0KPiA+DQo+ID4gSWYgYSBmYWlsdXJlIG1heSBiZSBwZXJtYW5lbnQs
IGl0IG1heSBiZSBiZXN0IHRvIGRldGVjdCBpdCBiZWZvcmUgcnVubmluZyBhbGwNCj4gdGVzdHMs
IHJhdGhlciB0aGFuIGluIHRlc3RfcHJlcGFyZSgpLg0KPiA+IE5vdyBzb21lIGRldGVjdGlvbnMg
YXJlIGNvbXBsZXRlZCBiZWZvcmUgcnVubmluZyBhbGwgdGVzdHMuIEZvciBleGFtcGxlOg0KPiA+
IDI3MyAgICAgICAgIGlmIChnZXRldWlkKCkgIT0gMCkNCj4gPiAyNzQgICAgICAgICAgICAgICAg
IHJldHVybiBrc2Z0X2V4aXRfc2tpcCgiTm90IHJ1bm5pbmcgYXMgcm9vdC4NCj4gU2tpcHBpbmcu
Li5cbiIpOw0KPiA+IDI3NQ0KPiA+IDI3NiAgICAgICAgIGlmICghY2hlY2tfcmVzY3RybGZzX3N1
cHBvcnQoKSkNCj4gPiAyNzcgICAgICAgICAgICAgICAgIHJldHVybiBrc2Z0X2V4aXRfc2tpcCgi
cmVzY3RybCBGUyBkb2VzIG5vdCBleGlzdC4gRW5hYmxlDQo+IFg4Nl9DUFVfUkVTQ1RSTCBjb25m
aWcgb3B0aW9uLlxuIik7DQo+ID4gMjc4DQo+ID4gMjc5ICAgICAgICAgaWYgKHVtb3VudF9yZXNj
dHJsZnMoKSkNCj4gPiAyODAgICAgICAgICAgICAgICAgIHJldHVybiBrc2Z0X2V4aXRfc2tpcCgi
cmVzY3RybCBGUyB1bm1vdW50IGZhaWxlZC5cbiIpOw0KPiA+DQo+IA0KPiBZb3UgYXJlIGNvcnJl
Y3QgdGhhdCB0aGUgdGVzdHMgc2hvdWxkIGFpbSB0byBkZXRlY3QgYXMgZWFybHkgYXMgcG9zc2li
bGUgaWYgbm8gdGVzdA0KPiBoYXMgYSBjaGFuY2Ugb2Ygc3VjY2VlZGluZy4gVGhpcyBpcyBjb3Zl
cmVkIGluIHRoZSBjaGVja3MgeW91IG1lbnRpb24uDQo+IFRoZSBwdXJwb3NlIG9mIHRlc3RfcHJl
cGFyZSgpL3Rlc3RfY2xlYW51cCgpIHBhaXIgaXMgdG8gcGVyZm9ybSBhY3Rpb25zIHRoYXQNCj4g
c2hvdWxkIGJlIGRvbmUgZm9yIGV2ZXJ5IHRlc3QuIEZvciBleGFtcGxlLCByZXNjdHJsIGlzIG1v
dW50ZWQgYmVmb3JlIGVhY2ggdGVzdA0KPiBhbmQgdW5tb3VudGVkIGFmdGVyIGVhY2ggdGVzdC4g
U2luY2UgdGhlc2UgYWN0aW9ucyBhcmUgcmVxdWlyZWQgdG8gYmUgZG9uZSBmb3INCj4gZXZlcnkg
dGVzdCBpdCBjYW5ub3QgYmUgYSBzaW5nbGUgY2FsbCBiZWZvcmUgYWxsIHRlc3RzIGFyZSBydW4u
DQo+IA0KPiBJdCBtYXkgYmUgcG9zc2libGUgdG8gYWRkIGEgdGVzdF9wcmVwYXJlKCkgZGlyZWN0
bHkgZm9sbG93ZWQgYnkgYSB0ZXN0X2NsZWFudXAoKQ0KPiBiZWZvcmUgYW55IHRlc3QgaXMgcnVu
IHRvIGJlIG1vcmUgZXhwbGljaXQgYWJvdXQgZWFybHkgZGV0ZWN0aW9uIGJ1dCB0aGF0IGRvZXMg
bm90DQo+IHNlZW0gbmVjZXNzYXJ5IGNvbnNpZGVyaW5nIHRoZSBjaGVja3Mgd291bGQgYmUgZG9u
ZSBhbnl3YXkgd2hlbiB0aGUgZmlyc3QNCj4gdGVzdCBpcyBydW4uIEV2ZW4gd2hlbiBkb2luZyBz
byBpdCB3b3VsZCBub3QgZWxpbWluYXRlIHRoZSBuZWVkIGZvcg0KPiB0ZXN0X3ByZXBhcmUoKS90
ZXN0X2NsZWFudXAoKSB0byBmb3JtIHBhcnQgb2YgZXZlcnkgdGVzdCBydW4gYW5kIG5lZWRpbmcg
dG8gZXhpdA0KPiBpZiwgZm9yIGV4YW1wbGUsIGEgcHJldmlvdXMgdGVzdCB0cmlnZ2VyZWQgYSBm
YXVsdCBwcmV2ZW50aW5nIHJlc2N0cmwgZnJvbSBiZWluZw0KPiBtb3VudGVkLg0KDQpUaGFua3Mg
Zm9yIHlvdXIgZXhwbGFuYXRpb24uIEkgdW5kZXJzdGFuZA0KDQpCZXN0IHJlZ2FyZHMsDQpTaGFv
cGVuZyBUQU4NCg0KDQo=
