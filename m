Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FA056C0A3
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Jul 2022 20:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238344AbiGHRhr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Jul 2022 13:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238278AbiGHRhq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Jul 2022 13:37:46 -0400
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB276606A4;
        Fri,  8 Jul 2022 10:37:45 -0700 (PDT)
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 268HKswc007701;
        Fri, 8 Jul 2022 17:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=Omd1YZKyw4MrR9AEn3nxHASxTSLD/XlIu7ev/kbn0YM=;
 b=jg+/qn8YyrEr5Dmp4Wl3rUkpU80gr16O3Ovh8XG7sm/1wCZdlgCp+jYnUdeBdbhFQeuP
 HcBueIh5tdm5oggbdgcEv8Pj0CGgfMRt/DaHzgM83ctvFQyeY6PqFCG5RCQxfpplknWJ
 fnrKTk7sl8oZuWRn6TXp8+R3kvU0sOXU+oSiJ/uurFyI2lZXIds9K94YcKnjPdLxwS0w
 mmGHEy7TjE8+vynoJOmeGxOWllcSkZvlmfSzeRmKbg4Rt8E48JK0IJuhjwF0L4g/aU7k
 IQ4CaqWCsLuRZj6eQwaJOVDmEfEURx6tYcRDdUjSN7m06H8aJAzeXjnXbQen4v2AAK9a yg== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3h4ub53ky3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jul 2022 17:37:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gam9qm0RTAfQeQV0IVmSICVNv6oHZHo0kH0xx/nNuljPwEsjAG1+nNOWaNERBw950geqPekZGdhz0DdoHIB9IkzanvMWHpk/a/K3Im+QGOa/QkAEI1OH/A66fb3gesSW9PDgO6o92EbUJJMnKfZMcrFLnv3ERyxd732kvPUAle/yKpo0Q9d2xrLkHXdgSCDG3+aLtDCYiKCpyt36HygXRBTic9+K8I+D6/woReMhqLz6BkM+ASSmGxGV7+4DqEzK2TC/GxoAlOAzLFmSrrwhvPagNJAD8lXUkVcrDH3+aq6xKuwPx1KcksYo57J9wKVcFT+lG778M1hscO3s0iBxHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Omd1YZKyw4MrR9AEn3nxHASxTSLD/XlIu7ev/kbn0YM=;
 b=c7XKGtAj9STLEvKJiXYiOQUqYtBvGmEcUzJIGCgiQYzn4RpXJZwDihIxqZp+0dAPPPvd5GR8nxB8j67S/fVYDdWci4/YVyxqFFeVr9nWboT5m7+uW3/O9FpG6gq/qX55o793Cv2QC0fmdfiTIW1NhzifA7G0ej9Wpih3xbp2Bv4lywOf/ArGYSvT/dP1JjqUa0r6/s3cy973o+uRtandQd75TtPqqhPF6VY29IVsjYeDk8Q8qfb0Q3bdLGGew1e1FSdtlTY7vOAzkbjkrntuKxaKdAE/zjYioCi4MMieAOlotKWOQawRvW+675EnrFKPGkHBDSVgJNUrNkuPxEjH9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2503.namprd13.prod.outlook.com (2603:10b6:a02:cd::33)
 by BN8PR13MB2596.namprd13.prod.outlook.com (2603:10b6:408:85::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.11; Fri, 8 Jul
 2022 17:37:21 +0000
Received: from BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::9894:995e:5f3:f528]) by BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::9894:995e:5f3:f528%7]) with mapi id 15.20.5417.020; Fri, 8 Jul 2022
 17:37:21 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>
CC:     "kernel@collabora.com" <kernel@collabora.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 0/4] Fix kselftest build with sub-directory
Thread-Topic: [PATCH 0/4] Fix kselftest build with sub-directory
Thread-Index: AQHYkue370iKOwWZokebIIjtk9FK2610tpEAgAAAXSA=
Date:   Fri, 8 Jul 2022 17:37:21 +0000
Message-ID: <BYAPR13MB2503278F8246E4F82E0F10ECFD829@BYAPR13MB2503.namprd13.prod.outlook.com>
References: <cover.1657296695.git.guillaume.tucker@collabora.com>
 <b39b9e0b-45f3-1818-39fe-58921182d957@linuxfoundation.org>
In-Reply-To: <b39b9e0b-45f3-1818-39fe-58921182d957@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce5ae486-75c7-4648-df99-08da610882ee
x-ms-traffictypediagnostic: BN8PR13MB2596:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SEeysWYSHYbSDZ8SqTZuPtn0owqY5DOzHDswIxvTB9A6OooDlPjjT8/Croykl/0g9SSlIHl3qkSooAHHo7+/B2z41PO4PhRWdtF3DNikHURD0bImPIpy+brMI8VPV1F0tWuUhvnOAG3vZl0zIf9/U5v+TOYyzU4aYcNl3+I1ikswkODfJIOqGcgCl29upAFdNRlVFoaI6HGeeyZxCdlW9pGWdaI6wry1YMeNYsmZuy4tBHjmFLDIStyzn2W+dgm0SV7eaV/6AId2mCm7bsYmcCsN0q7GoCoeXfzTN7lG5NfQPNtlBZCNaJX/wTErHRN+UhnIz/E8mP65nQQUe9HYcEWVsQcdR8X0hM0JHX9uPzKWs7GF2zDOh3fIXVGHALPz6ss9DGrVlU3BXGQxXfODjkaHvmw2q7PSVoWakPCA8a0i7Wsn85I4I9XLRqEUjqhQgaX42qLH4Ce0uw28P8pW/yMgHp49Ix/HGJX5R49stJ7qmOqYy9qrg6yUAFGOP7sJ0txYzXDCFIH/5i6SxhP04wZLd8Ir954KyVWUngJlLtW/3RCODIFDabFuUY0JmbZgg/Ww4szJX2rL/3/KoqDrQBlPByExySyjaGlF7UEFmFL3i/pW4w6lgMTii3BiLQCD1I+oBzNg2JpyE82+/qYjAQ+YMfmQ/SLl4ZgEY8gNjdn+jjHVP3K573jgEXLMgw6tqbIpnUoc0DnVQ4YGOuoXEDzB1LbP8V4P/pAMDy/90Gc6pccwKMixoGQqNPVVVjQRRXYhLhkbUMFN3MK3+mofozDM/BJyd9SJatCk5f734L5teh+9o5ouNiFXf0+R3e8vUkV1zS4Tr7XxDEPMQwcgg+b+2eRuWLKhUxVEv0Uls4/PuYJpXadPK+QFNkDe78f5f4u0hBayP/espLMGhENttlhPgzdfr/8IrXDiT/PxTOkRB2HQhQyQwKTpxplWggiG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2503.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(186003)(7696005)(55016003)(8676002)(76116006)(66476007)(66556008)(4326008)(66946007)(64756008)(54906003)(110136005)(66446008)(83380400001)(9686003)(53546011)(6506007)(71200400001)(26005)(33656002)(86362001)(478600001)(38100700002)(41300700001)(38070700005)(122000001)(5660300002)(316002)(7416002)(82960400001)(52536014)(966005)(2906002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTEzQ3ZuUm9DbzBsMFVjVThnUlF1NjFJVjFzNWdlREtnWVhYbXZ1OU92YTZj?=
 =?utf-8?B?eXlvMHV6TVdIbU1JQVpvOGptTEpyTmw0TkVSTkhzbCtraEZYVVFVMVg0MWxH?=
 =?utf-8?B?aEVkMVlRVXQybk1ETVpkK25jMVhhTzBqT3JvLzhMd092bVJxRldRMTVhZlNi?=
 =?utf-8?B?Z0c0TTdFTVRmeDY1TmxQQXFtRFVMVjlLaGordTlWN0tkZW9lNEZ4Vk5vUTgv?=
 =?utf-8?B?TVdUUko5OVBiT1FEa0hzT0VCaEJFQlNwOEVQOGdSRFM4eVFhSjhnY2ZSVGcw?=
 =?utf-8?B?QmlxanhmbU9GQ00wcVM3VWJ4YVpnRkp5c2ZiZXZ6R0ZnTWhtaUlRaTBJSTM0?=
 =?utf-8?B?eE1KSC8yQm8wSTVLT01HZStOYlFTdXB5aSt6N1AxSHkrZUdmR0ZNZ3ZHWTJn?=
 =?utf-8?B?NHRtUzc5M0xNaENTZG9JSTBjRC92aDJ6SHlMT0crbC9neHhSQmRwbHh1QXVk?=
 =?utf-8?B?N2E4YUNkSVY4VHVPN3puSjZsR3NYSU9YdjVmeHFadUdudFpxN0g3ekRqZUp4?=
 =?utf-8?B?MkRacDFDVHJ3UStGMDd2eElYekJ5QStVdUxSUEFzUUI0eDdLcnE5R1ZSYXFz?=
 =?utf-8?B?Q1EvVzBKdXpOckYrRDg5ZEE1T2w3Mk9ENSszcEx2V280a05jZVJkcGxva01I?=
 =?utf-8?B?V1IzWXpiL2ZnUytmd3JqVkVURDJ3eFhmV2JBZmpSK2psc25PVXVJL0paYWRV?=
 =?utf-8?B?OU0zZ2RJbWdBbFljTitHcEwwNXZHTE1NQXhzOHh4RkFrVW45bFVsN3gxeTBX?=
 =?utf-8?B?MzJaMG1HZzZaUVZYMmlaQnY1QXpMUnVESG1PTWNteWZWaVF2NC9Pb1lZVkRi?=
 =?utf-8?B?TlFWTCtjMEhKdE11dDVGckJyS3RGRCtCMWRmem8wbXQ5Yk9pYXhla1krS3Yv?=
 =?utf-8?B?c25pdExUem9rYUQrV1JCUUtNakk0bXUvaEttamhDR1BtTk11N0h4R1h6UlFv?=
 =?utf-8?B?Wi9ia29GcHpWSWd2eVl4Yndna28zMmlibEgvdHNvMUJGRzUyVG94Z2JuQjdo?=
 =?utf-8?B?NGVTOVNaVC8vVWxuYlBCZzJBL2wzMXFWcTFsdHhiM1F2cXUrQ0NmZnVPdVpw?=
 =?utf-8?B?TlIzZ295ZTNNLzE3cjJmckgwOW51dzJWaUp4a2tqZE5JUzhYMmFqcWJocmxV?=
 =?utf-8?B?cVBObFVQYkZrUWQvWW1UOUZidERxNzIzU3BSbG5YTUE2by9VYUJrWk9FZUEx?=
 =?utf-8?B?SXpESnNXZ3N2U01UbFNZRTRhKzBEYXkwZGxzZm1PaXhXUWp5OU9VMUFCRkcw?=
 =?utf-8?B?cmorbTlmUDZUT3R3YXVvRlE5ZmNDVjhORDN6bll0Sk1DeGZMaEV1cG1FczUw?=
 =?utf-8?B?MmI2SlVxN1RZeFdnK3RDcDMyaU16d0xBSFlBank4NlIzbjFXUERjTStFcElR?=
 =?utf-8?B?SXFGTUNWbVRoVlBQUlhPRGhjUC9tajhxYlJoZnRnWmJDaWVUaElvc2ZOd04w?=
 =?utf-8?B?ZlVLVGlCR0dqMG9UVmF2NFNmb1BrSVNGSGR1bytVVUhhUCt2RkZKUjhrb0xv?=
 =?utf-8?B?UWNtUElHOXQ2NDRRSVB4cS9SU1p4QWErZVhLWVcrS2ZuZlBTWUpBMmZMOStq?=
 =?utf-8?B?NWlFTTN4enJnUlRsdm5yOFBlUDM3cHNLRW9QUE1scVN6cXUxYVo2Z2xlRXRJ?=
 =?utf-8?B?eDhBalkvNy9BbVgvcVhrR2QyZkN1Zk1KQm9HZWpWK29lbzhUV3ZLODdzTFNT?=
 =?utf-8?B?V0VSR2JxT3RlNmQ5YTlpamZwUk0vYkVjYllrU3lNTXRKZU9xYmltaWt4dHMz?=
 =?utf-8?B?UnhnYS9OenBrUnBIZmwyZmNsTFhoRmhlSS92NEVVRkV4TkFUN2xia05VWEI2?=
 =?utf-8?B?NVhUeVdQR0FVamlGY3NaN01RVGV4ZTFRT0gzSVVaM0JkYWtXR2NHdGtKMCtr?=
 =?utf-8?B?RDMwUUMrWUhMNGtxamxSYkRUN1FLb1Nsa2wrd0tyQ2JSZm9oVHA4cmRWM1lR?=
 =?utf-8?B?d2ZtdncrTEc3VGJpSHNnTjY0M3gvdXdaSzUzR25kdk1aS0dnQUFhTzJrZFdI?=
 =?utf-8?B?QjBpWC9xaXI0Vy9EekJvSXIyYUNkWEdjMjNiVmltVkFabktQdkt4UWJDRjRX?=
 =?utf-8?B?dStSMk9zUWgzNzhIbWVvRXFIQWVuUG9kTDFUQ1N3eTBXWVY5bzg4dm9lclRF?=
 =?utf-8?Q?8KOu5HZiwep6+FkFrIZGx8bjv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2503.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5ae486-75c7-4648-df99-08da610882ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 17:37:21.0359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N+a1zCt7gZzS3dd0y4Cox15h4P+TlzlAn81/QzH/GVEDixiyi/aSYQa9ml100iIJevAqi8i5nIaX9U54/vujGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR13MB2596
X-Proofpoint-ORIG-GUID: fqP3KUWig07QUPv944ovUPq6CRy1Sb_a
X-Proofpoint-GUID: fqP3KUWig07QUPv944ovUPq6CRy1Sb_a
X-Sony-Outbound-GUID: fqP3KUWig07QUPv944ovUPq6CRy1Sb_a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-08_14,2022-07-08_01,2022-06-22_01
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2h1YWggS2hhbiA8c2to
YW5AbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gDQo+IE9uIDcvOC8yMiAxMDoyMyBBTSwgR3VpbGxh
dW1lIFR1Y2tlciB3cm90ZToNCj4gPiBFYXJsaWVyIGF0dGVtcHRzIHRvIGdldCAibWFrZSBPPWJ1
aWxkIGtzZWxmdGVzdC1hbGwiIHRvIHdvcmsgd2VyZQ0KPiA+IG5vdCBzdWNjZXNzZnVsIGFzIHRo
ZXkgbWFkZSB1bmRlc2lyYWJsZSBjaGFuZ2VzIHRvIHNvbWUgZnVuY3Rpb25zDQo+ID4gaW4gdGhl
IHRvcC1sZXZlbCBNYWtlZmlsZS4gIFRoaXMgc2VyaWVzIHRha2VzIGEgZGlmZmVyZW50DQo+ID4g
YXBwcm9hY2ggYnkgcmVtb3ZpbmcgdGhlIHJvb3QgY2F1c2Ugb2YgdGhlIHByb2JsZW0gd2l0aGlu
DQo+ID4ga3NlbGZ0ZXN0LCB3aGljaCBpcyB3aGVuIHRoZSBzdWItTWFrZWZpbGUgdHJpZXMgdG8g
aW5zdGFsbCBrZXJuZWwNCj4gPiBoZWFkZXJzICJiYWNrd2FyZHMiIGJ5IGNhbGxpbmcgbWFrZSB3
aXRoIHRoZSB0b3AtbGV2ZWwgTWFrZWZpbGUuDQo+ID4gVGhlIGFjdHVhbCBpc3N1ZSBjb21lcyBm
cm9tIHRoZSBmYWN0IHRoYXQgJChzcmN0cmVlKSBpcyAiLi4iIHdoZW4NCj4gPiBidWlsZGluZyBp
biBhIHN1Yi1kaXJlY3Rvcnkgd2l0aCAiTz1idWlsZCIgd2hpY2ggdGhlbiBvYnZpb3VzbHkNCj4g
PiBtYWtlcyAiLUMgJCh0b3Bfc3JjZGlyKSIgcG9pbnQgb3V0c2lkZSBvZiB0aGUgcmVhbCBzb3Vy
Y2UgdHJlZS4NCj4gPg0KPiA+IFdpdGggdGhpcyBzZXJpZXMsIHRoZSBnZW5lcmljIGtzZWxmdGVz
dCB0YXJnZXRzIHdvcmsgYXMgZXhwZWN0ZWQNCj4gPiBmcm9tIHRoZSB0b3AgbGV2ZWwgd2l0aCBv
ciB3aXRob3V0IGEgYnVpbGQgZGlyZWN0b3J5IGUuZy46DQo+ID4NCj4gPiAgICAkIG1ha2Uga3Nl
bGZ0ZXN0LWFsbA0KPiA+DQo+ID4gICAgJCBtYWtlIE89YnVpbGQga3NlbGZ0ZXN0LWFsbA0KPiA+
DQo+ID4gVGhlbiBpbiBvcmRlciB0byBidWlsZCB1c2luZyB0aGUgc3ViLU1ha2VmaWxlIGV4cGxp
Y2l0bHksIHRoZQ0KPiA+IGhlYWRlcnMgaGF2ZSB0byBiZSBpbnN0YWxsZWQgZmlyc3QuICBUaGlz
IGlzIGFyZ3VhYmx5IGEgdmFsaWQNCj4gPiByZXF1aXJlbWVudCB0byBoYXZlIHdoZW4gYnVpbGRp
bmcgYSB0b29sIGZyb20gYSBzdWItTWFrZWZpbGUuDQo+ID4gRm9yIGV4YW1wbGUsICJtYWtlIC1D
IHRvb2xzL3Rlc3RpbmcvbnZkaW1tLyIgZmFpbHMgaW4gYSBzaW1pbGFyDQo+ID4gd2F5IHVudGls
IDxhc20vcndvbmNlLmg+IGhhcyBiZWVuIGdlbmVyYXRlZCBieSBhIGtlcm5lbCBidWlsZC4NCj4g
Pg0KPiA+IEd1aWxsYXVtZSBUdWNrZXIgKDQpOg0KPiA+ICAgIHNlbGZ0ZXN0czogZHJvcCBraGRy
IG1ha2UgdGFyZ2V0DQo+ID4gICAgc2VsZnRlc3RzOiBzdG9wIHVzaW5nIEtTRlRfS0hEUl9JTlNU
QUxMDQo+ID4gICAgc2VsZnRlc3RzOiBkcm9wIEtTRlRfS0hEUl9JTlNUQUxMIG1ha2UgdGFyZ2V0
DQo+ID4gICAgTWFrZWZpbGU6IGFkZCBoZWFkZXJzX2luc3RhbGwgdG8ga3NlbGZ0ZXN0IHRhcmdl
dHMNCj4gPg0KPiANCj4gVGhpcyB0YWtlcyB1cyB0byBiYWNrIHRvIHRoZSBzdGF0ZSBiZWZvcmUg
YjJkMzVmYTVmYzgwIGFkZGVkDQo+IGtoZHIgc3VwcG9ydC4gSSByZWx1Y3RhbnRseSBhZ3JlZWQg
dG8gdGhlIGNoYW5nZSBhbmQgaXQgaGFzDQo+IHByb3ZlbiB0byBiZSBhIHByb2JsZW1hdGljIGNo
YW5nZS4gSSB3b3VsZCByYXRoZXIgaGF2ZSBoYWQgdGhlDQo+IGRlcGVuZGVuY3kgc3RhdGVkIHRo
YXQgaGVhZGVycyBzaG91bGQgYmUgaW5zdGFsbGVkIHByaW9yIHRvDQo+IGJ1aWxkaW5nIHRlc3Rz
IC0gdGVzdCBidWlsZCBkZXBlbmRzIG9uIGtlcm5lbCBidWlsZCBhbnl3YXkgYW5kDQo+IGhhdmlu
ZyBkZXBlbmRlbmN5IG9uIGhlYWRlcnMgaGF2aW5nIGJ1aWxkIGlzbid0IGEgaHVnZSBkZWFsLg0K
PiANCj4gU28gSSBhbSBpbiBmYXZvciBvZiBnZXR0aW5nIHJpZCBvZiBraGRyIHN1cHBvcnQuIEhv
d2V2ZXIsIHRoaXMNCj4ga2hkciBzdXBwb3J0IHdhcyBhIGNoYW5nZSBvcmlnaW5hdGVkIGZyb20g
TGluYXJvIHRlc3QgcmluZy4gVW5kb2luZw0KPiB0aGlzIG1pZ2h0IGhhdmUgaW1wbGljYXRpb24g
b24gdGhlaXIgd29ya2Zsb3cuDQo+IA0KPiBJIHdpbGwgcHVsbCB0aGVtIGludG8gdGhlIGRpc2N1
c3Npb24gc28gdGhleSBhcmUgYXdhcmUgb2YgaXQgYW5kDQo+IGJlIHByZXBhcmVkIGZvciB0aGlz
IGNoYW5nZS4NCg0KSSByYW4gaW50byB0aGlzIGJ1ZyBxdWl0ZSBhIHdoaWxlIGFnby4gIEkgcmVw
b3J0ZWQgaXQgaGVyZToNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9FQ0FERkYzRkQ3NjdD
MTQ5QUQ5NkE5MjRFN0VBNkVBRjk3N0JEMjE0QFVTQ1VMWE1TRzAxLmFtLnNvbnkuY29tLw0KaXQg
d2FzIGZpeGVkIGhlcmU6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAxOTEwMTUwMTQ1
MDUuMTQyNTktMS1za2hhbkBsaW51eGZvdW5kYXRpb24ub3JnLw0KYnV0IGFwcGFyZW50bHkgcmV2
ZXJ0aW5nIGl0IHdhcyBkaXNjdXNzZWQsIGJhc2VkIG9uIHRoaXM6DQpodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9hbGwvOGQzNGE5YjktZjhmMy0wZTM3LTAwYmYtYzM0MmNmM2Q0MDc0QGFybS5jb20v
DQoNCkknbSBub3Qgc3VyZSB3aGF0IGhhcHBlbmVkIGFmdGVyIHRoYXQuDQoNCkkgd2FzIGFibGUg
dG8gd29yayBhcm91bmQgaXQgYnkgYXZvaWRpbmcNCnB1dHRpbmcgdGhlIGJ1aWxkIGRpcmVjdG9y
eSBpbnNpZGUgdGhlIHNvdXJjZSB0cmVlLg0KDQpJIHN0cm9uZ2x5IHN1cHBvcnQgZ2V0dGluZyBy
aWQgb2YgdGhlIGtoZHIgc3R1ZmYsIGFzIGl0J3MgcXVpdGUgaGFyZA0KdG8gZm9sbG93LiAgSSB0
aGluayBteSB3b3JrZmxvdyB3b3VsZCBub3QgYmUgYWZmZWN0ZWQgKGJ1dCBJIHNob3VsZA0KcnVu
IG9mZiBhbmQgdGVzdCBpdC4pDQoNClRoYW5rcyBmb3Igd29ya2luZyBvbiB0aGlzIEd1aWxsYXVt
ZSENCiAtLSBUaW0NCg0K
