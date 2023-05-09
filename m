Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5F36FC65B
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 May 2023 14:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbjEIM3a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 May 2023 08:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjEIM33 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 May 2023 08:29:29 -0400
Received: from CO1PR02CU002.outbound.protection.outlook.com (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142E318C;
        Tue,  9 May 2023 05:29:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3KGiwowr3ZbQFLCU9b7kw+jZqOyzcHs3j95iDSJKy6ObuUaxdlrK4KFmGs7is+je/L9AajaKEWYFhDSlzKkBlt2x7co7zIfEQc/2VSmX2+5nIORTa8Qm7m+I9+twcemp4xpEZBuHsU5KxydIkY4zWt9JdU2miNIfd/jYmvcFrw5URcUCc1EfaSG2b+0KurAewQ0GfM9qESP8ZwXC/lwRfJRvDdJYIdGwG/qNXhvqbPJ0Rf0m9+Mil9AGOIU03IpJ3kvUBAeUGiwPTByUQZweSmbTFhPNwmYl9EhGcjjE3qT7QboUW4vspvzCoEzKhYIHEet/728vrtyDCwKTtqkWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zG+wFCCqozncMLmDSxfKpG1Iz4tyQd7z9zLQlHwW7EI=;
 b=gCEJttRX5JTOZAIy6O2X02SbAE/68tj9Cbns/HlxdtjN51Y44kUMoFz21wjRiMPl5RhgHTaS+mwoJq02WBlljhEr3kRYcoviMHvxKSp7sbleQy/PDsJHlyJP7lV06YgeZmIo0lTt9PAtkTa+Khtg0m3Z37xoV+Hs4zLKrzvMDFTk3iC+ZKGnsS5evr+LgafZcwYrIIuWVDUHsrAHgXnec3BP6dwd823mvFCuvJERI3yOfR+R5NaP6qV+0yS1WMon1YxS6XiyfEkdmuVg8Zb5pn+4CZvRXZblBFe+GzDXgjMyO9cy1hYv6pgp98sEWk6rf2urZ1KJhaLRHAVOipk0Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zG+wFCCqozncMLmDSxfKpG1Iz4tyQd7z9zLQlHwW7EI=;
 b=ZkC0qKIpxeJUGABWKocLiZ1aGoaWY5Iu/dH2KKoC5MpC6Exc8dMkoqrf137dCc7nQBBPJikBEHCfxt/8JVoSBbrNFQ7KKlF2aW6h8zydXKzkQUYXndAWpvCorfNTDQ7NZtjSKi5bL2f36rfLFvoEjyGEL6VTDAp4Ts2lJa4CLQs=
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by DM6PR05MB5548.namprd05.prod.outlook.com (2603:10b6:5:b::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.32; Tue, 9 May 2023 12:29:23 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66%7]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 12:29:23 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     kernel test robot <lkp@intel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>
CC:     "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "chinglinyu@google.com" <chinglinyu@google.com>,
        Nadav Amit <namit@vmware.com>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Tapas Kundu <tkundu@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>
Subject: Re: [PATCH v2 8/9] eventfs: moving tracing/events to eventfs
Thread-Topic: [PATCH v2 8/9] eventfs: moving tracing/events to eventfs
Thread-Index: AQHZfOilHbAIv3gBO0Sfrm8lUvOVTK9HSCgAgAr9/YA=
Date:   Tue, 9 May 2023 12:29:23 +0000
Message-ID: <1CAC8265-A4F3-4AF6-80E4-8F264ED670A9@vmware.com>
References: <1683026600-13485-9-git-send-email-akaher@vmware.com>
 <202305030116.Gu6yyvKj-lkp@intel.com>
In-Reply-To: <202305030116.Gu6yyvKj-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.61.22050700
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR05MB8703:EE_|DM6PR05MB5548:EE_
x-ms-office365-filtering-correlation-id: f30befd7-e85e-4776-8a76-08db5089057b
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fQCisApShOnFArDNbW+MU1LSE6Va/LWZZnPT7iLb/9av7fOxqWYMwfH3yvroi9x62BOPJXtY7tjJo3hJVpjjgZKAvN6nU0J8o49y1wNYcEcYE9jmxw+vRaJCXPzU4Qsvop689IlkmkuxLlqepyAZaEhBOS52T1m4y4u7yg+ijNA+rfm+MQzdLkqTUumJMIzRF42ZFzDolad9Ukj0cdX8FZGo9/+dL0059eOQCovAeTgw43Lm1mkL9JhhGOQ4iGMIFz4knNzkZb6iHD7Ab/JFS9zU6XI/ARmj8PIdrDoCNtgtKwuFGQyqK+gMHakAunde5XQe7QYhH9BEqcHxWYgA36IEfaAo95+zJyamjX3DHaT+eRNqyCt2zF+ZmTqWc/6XnRfvdcWKGnwQMuCDRzx1y7saeRaaGDE1NUB7ZCMWlY4dN2NhIDklC8SwD+Rl8SGUKsnP9ymlO+KWgHRL+Kjl5RzqkpdRKsRBYdnjL0JoFGH+b4ty3DCevJuWLElE/YexAiTSsu9y21jDlxnhWJnWmw+KyOpsyn5OGLs/fEbVsy4S1f86fmNmEVKWitT3r8FWvX8OH5PRHM4/eMCbzsY/xV5KdeIMaBSoO2k+xxDLKxd28RxvOJ/wtj3FNJx1cW9yrVw79KWBdpYNeNQ/13t+MQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(66446008)(64756008)(4326008)(86362001)(316002)(478600001)(76116006)(66946007)(6486002)(66556008)(91956017)(54906003)(110136005)(66476007)(36756003)(53546011)(33656002)(83380400001)(2616005)(6506007)(26005)(6512007)(2906002)(71200400001)(5660300002)(41300700001)(8936002)(7416002)(8676002)(122000001)(38100700002)(38070700005)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2QxYk9wQ1dTMU9mdVczbUt6VG93YkFoUUtHRzlDbCtma3dmTU91aE43Zm94?=
 =?utf-8?B?ZUFhS2dDQVRQR3lsSzlMZzhBek4vVytsNFFaSHZ4L1Q2Yy8zVnVKU3FiZERR?=
 =?utf-8?B?OGlTWVJaOE9CMkZCK1BLMzQ2OE53Mk9NcVFVMmhWWkhIVHFPVTFGOVNmdTFp?=
 =?utf-8?B?L2lSWjRvUWtpcUxwRVhzNHM3OWNIeWtSSDE1eC84YmhnRVN2M0tGWlJTRDNh?=
 =?utf-8?B?MzFNYldUMHgzYno5UGRONzRhWUZ6TkttMVdDVU55RDVUdndTWmsyN3lTcUhF?=
 =?utf-8?B?L1dwNGdXa0pwbm8zRGw3RHc5MnRhZjJkUXdPaURGZVlDTkdCaGpPaTY4KzVF?=
 =?utf-8?B?WEJlTTMyTkNRRzBHd1ZnSitRUkNyZDlhVnpKKzRGRWVQclYxbUdXMG13ME9m?=
 =?utf-8?B?RjBjOWlXa21nTjNMVHhkRHRmZjJVMk9kMkZVclhidWlkN2xPWXFoUDBVRStB?=
 =?utf-8?B?L3IvWnYrdStBaCtDRDZEeDNmSFpyc2Z0bm5wYUl0TTFKcmJKb2QxMVdCYjZG?=
 =?utf-8?B?VlhDbGRpVFh4RlBQYXpUTk4zb0ZpRU9HMERlYVk4VTVxZEJqZTBDUHNlSWVS?=
 =?utf-8?B?SmpCQzBNeDNJQkNTTmpoV0tjWlhjQkFGUDc3V2IwL1ppVm53TURmVngvelNj?=
 =?utf-8?B?NjJkbElYV3hIQW1qUHNGT053OCt2VWRBN0l5SWhCcmxZNWZJaGcyZWloK2th?=
 =?utf-8?B?U1BUT1Z2WUN2U2wwUUlZVTEzaVJJSTF5b3lsZDdyQmRiQ3VLZUJhT3ZCYmQw?=
 =?utf-8?B?b1BZTlpyYjVxS3VIeEZ0K0RGcmtHMzN6alEwSU81eDlFMGFYZ1ZNVit2a2lt?=
 =?utf-8?B?Z3MzM0h0YTBSamcxb3k5SnlydEdIZEVOa3dWMkNncWdKbGdhenZ0VUFmSUN0?=
 =?utf-8?B?UEhwNWVNbEVveFFjRVZoNnhtYnZ0cEtHZVgrVHFZK0dJT29KSngxVCtuamRX?=
 =?utf-8?B?NWl2VE5VVkZBWFA3NTEyejMzc2ZRZDkyUkp4dGJnQmpPQzNsaVdVMXQybGJq?=
 =?utf-8?B?d3Mvb1J6dFgvRTZUbVdndUdjTlVkcHJEWVZ2TEFxRnp1Q2ZtVkVHckVpdVQx?=
 =?utf-8?B?dXprTW1HVW02NzdnOElESUZJL3c5VmV5dzZKVVpWSzQ1dkF3NDhRaWVFdGlT?=
 =?utf-8?B?MmZ3OGgzK0ZKS1BlcE4ybzNaTkhBM1hYb09neTJWS2hrL1ZYK3dTbGJGU2pG?=
 =?utf-8?B?VXNXaUoyMkRqV3g1T3B0THl6N0tqUTRuS3kxVzJBdzQ0dmJpb3NqaGJWUTNW?=
 =?utf-8?B?WWQrTFhCSDRlaG9FNkpvQ0hBb0krN1dxMGtnR3VPVmdERVNPMGJibVRqaVpY?=
 =?utf-8?B?dGRsWkZRYVIxTzUrbSt1aW1XcGkzejk2K1IrRG9ScjEwQlV4NmFmTHIzcE5J?=
 =?utf-8?B?M1ZoeWQrTWVUL1V1Q0lBa1hhTmZsMW04VXBDeFJURG1ZT0JGT013WWtKd1dL?=
 =?utf-8?B?eUhOVmkwSzFBd3VEeXR4N0JEUVFuQmlTWUMybGdBL3AxSXBsclE4YjZ3TXQv?=
 =?utf-8?B?Z25HWWRXRmtreEUvaStsL05qRkxETG9uZk5FTE9JdjJMMjNNMVlxQjRic0hU?=
 =?utf-8?B?bXQzK0ZrV0NEaHlBeEQvNDhOb1JkUzhLS0dGUFdRaktqRm9jN2NlVHhBVUtR?=
 =?utf-8?B?MVdramRneXFCOUlDUTdWUXNYYXllV0dCWTZ6bmhsOEozU3pPQ2tweW4rdXZP?=
 =?utf-8?B?aThaRERCV0s1S040N0FrSXpmdU1tTHhwY2FyUFgyR0NuOWU1d2w2aU1jUTBy?=
 =?utf-8?B?R05hVjZJNndCUC81UTIyd3luWllqTEplQ2djbWJSaFpuRm1xLytHN0ZJTFk2?=
 =?utf-8?B?RmZkaGJZWVhLcisrWWd2OXJPbHJ2dVVRLzFCSUpuTGpreTcvVHBoSksxRW9I?=
 =?utf-8?B?cGVIT0pCdXJxanplR3RuSnR3R2NYcVlKeVJYQ3JMc0lJUk56TDBRMGpkTnYv?=
 =?utf-8?B?YkZZckNZWVBVQjQzWWVXM1JJMXA0YkQ1ckJmWktWR2ZoZnNtNDlSOHczVmFt?=
 =?utf-8?B?SXB3SXVnYUJEK3djanQrZXFzWDhuOWtxVkZTUXV6SGVOalJ5UC9tck0vY3pQ?=
 =?utf-8?B?WGpnN0xydkFlL2dUb0QzcnJydlZ5bkVTMlN2Qnd1dGNxcGNsY2Q3NENCQXpY?=
 =?utf-8?Q?c8mMX1qTHAEWhz9ZKhclDWk4B?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BBD84E96C9A1D499AE57FE9DD1FD989@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30befd7-e85e-4776-8a76-08db5089057b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 12:29:23.5365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pzA8BLsrFCLh6LtVASez1Eqyjg/LEeO9O7kSaJVS8dzdOsJiHz2rf8WM2zkcRB+wb68W+FjAsccaV5WF94Kw1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB5548
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQrvu78+IE9uIDAyLzA1LzIzLCAxMTo0MiBQTSwgImtlcm5lbCB0ZXN0IHJvYm90IiA8bGtwQGlu
dGVsLmNvbT4gd3JvdGU6DQo+ICAgPj4ga2VybmVsL3RyYWNlL3RyYWNlX2V2ZW50cy5jOjI0MjQ6
MTc6IHdhcm5pbmc6IHZhcmlhYmxlICdkX2V2ZW50cycgc2V0IGJ1dCBub3QgdXNlZCBbLVd1bnVz
ZWQtYnV0LXNldC12YXJpYWJsZV0NCj4gICAgICAgICAgIHN0cnVjdCBkZW50cnkgKmRfZXZlbnRz
Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgXg0KPiAgICAxIHdhcm5pbmcgZ2VuZXJhdGVkLg0K
Pg0KDQpTdGV2ZSwgd2l0aC1pbiBldmVudF9jcmVhdGVfZGlyKCksIGRvIHdlIGhhdmUgYW55IHNj
ZW5hcmlvIHdoZW4gZmlsZS0+ZXZlbnRfY2FsbC0+Y2xhc3MtPnN5c3RlbQ0KZG9lc24ndCBoYXZl
IFRSQUNFX1NZU1RFTT8gQW5kIG5lZWQgdG8gZXhlY3V0ZSBmb2xsb3dpbmc6DQoNCmFlNjNiMzFl
NGQwZTJlIFN0ZXZlbiBSb3N0ZWR0ICAgICAgICAgICAyMDEyLTA1LTAzICAyNDM3ICAgICAgICAg
ICAgICAgIGRfZXZlbnRzID0gcGFyZW50Ow0KDQpsb29raW5nIGZvciB5b3VyIGlucHV0IGlmIHdl
IGNvdWxkIHJlbW92ZSBkX2V2ZW50cyBmcm9tIGV2ZW50X2NyZWF0ZV9kaXIoKS4NCg0KLSBBamF5
DQoNCj4gICAgdmltICsvZF9ldmVudHMgKzI0MjQga2VybmVsL3RyYWNlL3RyYWNlX2V2ZW50cy5j
DQo+DQo+IGFjMzQzZGE3YmM5MDQ4IE1hc2FtaSBIaXJhbWF0c3UgICAgICAgICAyMDIwLTA5LTEw
ICAyNDE3DQo+IDE0NzNlNDQxN2M3OWYxIFN0ZXZlbiBSb3N0ZWR0ICAgICAgICAgICAyMDA5LTAy
LTI0ICAyNDE4ICBzdGF0aWMgaW50DQo+IDdmMWQyZjgyMTAxOTVjIFN0ZXZlbiBSb3N0ZWR0IChS
ZWQgSGF0ICAyMDE1LTA1LTA1ICAyNDE5KSBldmVudF9jcmVhdGVfZGlyKHN0cnVjdCBkZW50cnkg
KnBhcmVudCwgc3RydWN0IHRyYWNlX2V2ZW50X2ZpbGUgKmZpbGUpDQo+IDE0NzNlNDQxN2M3OWYx
IFN0ZXZlbiBSb3N0ZWR0ICAgICAgICAgICAyMDA5LTAyLTI0ICAyNDIwICB7DQo+IDI0MjViY2I5
MjQwZjhjIFN0ZXZlbiBSb3N0ZWR0IChSZWQgSGF0ICAyMDE1LTA1LTA1ICAyNDIxKSAgICAgICBz
dHJ1Y3QgdHJhY2VfZXZlbnRfY2FsbCAqY2FsbCA9IGZpbGUtPmV2ZW50X2NhbGw7DQo+IGFlNjNi
MzFlNGQwZTJlIFN0ZXZlbiBSb3N0ZWR0ICAgICAgICAgICAyMDEyLTA1LTAzICAyNDIyICAgICAg
ICBzdHJ1Y3QgdHJhY2VfYXJyYXkgKnRyID0gZmlsZS0+dHI7DQo+IDJmZTIwMDJlZmIyM2E3IEFq
YXkgS2FoZXIgICAgICAgICAgICAgICAyMDIzLTA1LTAyICAyNDIzICAgICAgICBzdHJ1Y3QgZXZl
bnRmc19maWxlICplZl9zdWJzeXN0ZW0gPSBOVUxMOw0KPiBhZTYzYjMxZTRkMGUyZSBTdGV2ZW4g
Um9zdGVkdCAgICAgICAgICAgMjAxMi0wNS0wMyBAMjQyNCAgICAgICAgc3RydWN0IGRlbnRyeSAq
ZF9ldmVudHM7DQo+IGRlN2IyOTczOTAzYzZjIE1hdGhpZXUgRGVzbm95ZXJzICAgICAgICAyMDE0
LTA0LTA4ICAyNDI1ICAgICAgICBjb25zdCBjaGFyICpuYW1lOw0KPiBmZDk5NDk4OTg5ZjNiMyBT
dGV2ZW4gUm9zdGVkdCAgICAgICAgICAgMjAwOS0wMi0yOCAgMjQyNiAgICAgICAgaW50IHJldDsN
Cj4gMTQ3M2U0NDE3Yzc5ZjEgU3RldmVuIFJvc3RlZHQgICAgICAgICAgIDIwMDktMDItMjQgIDI0
MjcNCj4gNmVjYzJkMWNhMzkxNzcgU3RldmVuIFJvc3RlZHQgICAgICAgICAgIDIwMDktMDItMjcg
IDI0MjggICAgICAgIC8qDQo+IDZlY2MyZDFjYTM5MTc3IFN0ZXZlbiBSb3N0ZWR0ICAgICAgICAg
ICAyMDA5LTAyLTI3ICAyNDI5ICAgICAgICAgKiBJZiB0aGUgdHJhY2UgcG9pbnQgaGVhZGVyIGRp
ZCBub3QgZGVmaW5lIFRSQUNFX1NZU1RFTQ0KPiA2ZWNjMmQxY2EzOTE3NyBTdGV2ZW4gUm9zdGVk
dCAgICAgICAgICAgMjAwOS0wMi0yNyAgMjQzMCAgICAgICAgICogdGhlbiB0aGUgc3lzdGVtIHdv
dWxkIGJlIGNhbGxlZCAiVFJBQ0VfU1lTVEVNIi4NCj4gNmVjYzJkMWNhMzkxNzcgU3RldmVuIFJv
c3RlZHQgICAgICAgICAgIDIwMDktMDItMjcgIDI0MzEgICAgICAgICAqLw0KPiBhZTYzYjMxZTRk
MGUyZSBTdGV2ZW4gUm9zdGVkdCAgICAgICAgICAgMjAxMi0wNS0wMyAgMjQzMiAgICAgICAgaWYg
KHN0cmNtcChjYWxsLT5jbGFzcy0+c3lzdGVtLCBUUkFDRV9TWVNURU0pICE9IDApIHsNCj4gMmZl
MjAwMmVmYjIzYTcgQWpheSBLYWhlciAgICAgICAgICAgICAgIDIwMjMtMDUtMDIgIDI0MzMgICAg
ICAgICAgICAgICAgZWZfc3Vic3lzdGVtID0gZXZlbnRfc3Vic3lzdGVtX2Rpcih0ciwgY2FsbC0+
Y2xhc3MtPnN5c3RlbSwgZmlsZSwgcGFyZW50KTsNCj4gMmZlMjAwMmVmYjIzYTcgQWpheSBLYWhl
ciAgICAgICAgICAgICAgIDIwMjMtMDUtMDIgIDI0MzQgICAgICAgICAgICAgICAgaWYgKCFlZl9z
dWJzeXN0ZW0pDQo+IGFlNjNiMzFlNGQwZTJlIFN0ZXZlbiBSb3N0ZWR0ICAgICAgICAgICAyMDEy
LTA1LTAzICAyNDM1ICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+IGFl
NjNiMzFlNGQwZTJlIFN0ZXZlbiBSb3N0ZWR0ICAgICAgICAgICAyMDEyLTA1LTAzICAyNDM2ICAg
ICAgICB9IGVsc2UNCj4gYWU2M2IzMWU0ZDBlMmUgU3RldmVuIFJvc3RlZHQgICAgICAgICAgIDIw
MTItMDUtMDMgIDI0MzcgICAgICAgICAgICAgICAgZF9ldmVudHMgPSBwYXJlbnQ7DQo+IDZlY2My
ZDFjYTM5MTc3IFN0ZXZlbiBSb3N0ZWR0ICAgICAgICAgICAyMDA5LTAyLTI3ICAyNDM4DQo+IDY4
N2ZjYzRhZWU0NTY3IFN0ZXZlbiBSb3N0ZWR0IChSZWQgSGF0ICAyMDE1LTA1LTEzICAyNDM5KSAg
ICAgICBuYW1lID0gdHJhY2VfZXZlbnRfbmFtZShjYWxsKTsNCj4gMmZlMjAwMmVmYjIzYTcgQWph
eSBLYWhlciAgICAgICAgICAgICAgIDIwMjMtMDUtMDIgIDI0NDAgICAgICAgIGZpbGUtPmVmID0g
ZXZlbnRmc19hZGRfZGlyKG5hbWUsIGVmX3N1YnN5c3RlbSwgJnRyLT5ldmVudGZzX3J3c2VtKTsN
Cj4gMmZlMjAwMmVmYjIzYTcgQWpheSBLYWhlciAgICAgICAgICAgICAgIDIwMjMtMDUtMDIgIDI0
NDEgICAgICAgIGlmIChJU19FUlIoZmlsZS0+ZWYpKSB7DQo+IDg0MzRkYzkzNDBjZDJlIFN0ZXZl
biBSb3N0ZWR0IChSZWQgSGF0ICAyMDE1LTAxLTIwICAyNDQyKSAgICAgICAgICAgICAgIHByX3dh
cm4oIkNvdWxkIG5vdCBjcmVhdGUgdHJhY2VmcyAnJXMnIGRpcmVjdG9yeVxuIiwgbmFtZSk7DQo+
IDE0NzNlNDQxN2M3OWYxIFN0ZXZlbiBSb3N0ZWR0ICAgICAgICAgICAyMDA5LTAyLTI0ICAyNDQz
ICAgICAgICAgICAgICAgIHJldHVybiAtMTsNCj4gMTQ3M2U0NDE3Yzc5ZjEgU3RldmVuIFJvc3Rl
ZHQgICAgICAgICAgIDIwMDktMDItMjQgIDI0NDQgICAgICAgIH0NCj4gMTQ3M2U0NDE3Yzc5ZjEg
U3RldmVuIFJvc3RlZHQgICAgICAgICAgIDIwMDktMDItMjQgIDI0NDUNCj4gOWI2Mzc3NmZhM2Nh
OTYgU3RldmVuIFJvc3RlZHQgICAgICAgICAgIDIwMTItMDUtMTAgIDI0NDYgICAgICAgIGlmIChj
YWxsLT5jbGFzcy0+cmVnICYmICEoY2FsbC0+ZmxhZ3MgJiBUUkFDRV9FVkVOVF9GTF9JR05PUkVf
RU5BQkxFKSkNCj4gMmZlMjAwMmVmYjIzYTcgQWpheSBLYWhlciAgICAgICAgICAgICAgIDIwMjMt
MDUtMDIgIDI0NDcgICAgICAgICAgICAgICAgZXZlbnRmc19hZGRfZmlsZSgiZW5hYmxlIiwgVFJB
Q0VfTU9ERV9XUklURSwgZmlsZS0+ZWYsIGZpbGUsDQo+IDYyMGEzMGU5N2ZlYmM4IE9sZWcgTmVz
dGVyb3YgICAgICAgICAgICAyMDEzLTA3LTMxICAyNDQ4ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICZmdHJhY2VfZW5hYmxlX2ZvcHMpOw0KPiAxNDczZTQ0MTdjNzlmMSBTdGV2ZW4g
Um9zdGVkdCAgICAgICAgICAgMjAwOS0wMi0yNCAgMjQ0OQ0KDQoNCg==
