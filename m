Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05ECF597610
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Aug 2022 20:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240243AbiHQSqn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Aug 2022 14:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238703AbiHQSql (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Aug 2022 14:46:41 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8829C225;
        Wed, 17 Aug 2022 11:46:39 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HHrN7X032275;
        Wed, 17 Aug 2022 11:46:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=bAkmiaU6iz63viuFtyZySiTGodEM+cV+fOhSUxsqGAk=;
 b=X5QwIO7oY2DS8bBNKQ3LGLF+zX1CvxCO0pwS3jiT82D7JpN7sEaxmbeCto8M+faEByEL
 1jl5O2tlpU9ra0YpTf8Yg0GgtG2ijC462BOm22w7SGSWrWelolDAh8YRdoEYhT2DGTcX
 ocACzkfl+16CTn1yzwdn6u2ZeKf7DJvj4O4= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j0npd5ccu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 11:46:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4CGYo7BC+oNPGA6H4HKdeK0knvAUiDALHbXIH/H7Zb4+i3NcI0E3zRUQjKZkmrh3lY2jG0t6OSjJ0Qp9A+RS7Yb5lu+34t4PcVe9plv00Qqrn5S7SBAsCvbqR+nd8ijDTKcFrO98jwx8Fy2+HkDnrhSYRgj0ZU4Xdl7lscp2/bGGOrOahB+6YmWiSzODZQtxZw7RGurahg+BJ2sx4C4zfB1vP2ZZsP3sCF8bL/3MBJnMcA49Ok5zzv4CbCLNFLISSvdNXg84fW+D22NqKDPPfr4UVnWPDsZdaGUQMhtarNcZSU7HHRuN/nGS+0b3CFrGzb4joVtBnaPr1Q8B/pFCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAkmiaU6iz63viuFtyZySiTGodEM+cV+fOhSUxsqGAk=;
 b=dGsOtVe1MVkopHAMgqB7yRDKSKqqUq0FMwgsBOx+MayCtskLHEI2DzblRysjHecJHtkmKPz7RFZKJlnKGeo/gFzPjP++MgrtnjsQt+UBtSGg3w5wKLpBtEUz58H8W3QJ0gJMHlCvTjRJOuQ1YLXjWFnkfW8OMDQM8z+esLduo2X3CtAud25Ah6Wn6f3D7U+TtKEqLr3/vuq7VlGNOZ4BYGgCc4V/m0vSNrPUPJN/EPXD7uQV3Jgo+Yxzzd4wM0qa+Arqz+Ns/5TEcqPzDL5L81vOgJc40adj5NPD1oFPsOHT/SkUS2zCI1HqsdzEFGnRnYbxELNUl/jtHF1I1z4R0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5259.namprd15.prod.outlook.com (2603:10b6:806:238::22)
 by CH2PR15MB3557.namprd15.prod.outlook.com (2603:10b6:610:6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 17 Aug
 2022 18:46:32 +0000
Received: from SA1PR15MB5259.namprd15.prod.outlook.com
 ([fe80::3009:f3d:aee:9b06]) by SA1PR15MB5259.namprd15.prod.outlook.com
 ([fe80::3009:f3d:aee:9b06%9]) with mapi id 15.20.5504.025; Wed, 17 Aug 2022
 18:46:32 +0000
From:   Mykola Lysenko <mykolal@fb.com>
To:     Colin Ian King <colin.i.king@gmail.com>
CC:     Mykola Lysenko <mykolal@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] selftests/bpf: Fix spelling mistake "succesful" ->
 "successful"
Thread-Topic: [PATCH][next] selftests/bpf: Fix spelling mistake "succesful" ->
 "successful"
Thread-Index: AQHYshQmats7rX1y6UKVYXLTozRJi62zbyyA
Date:   Wed, 17 Aug 2022 18:46:32 +0000
Message-ID: <818C5CC9-31CA-4DED-90E8-455B03AA9352@fb.com>
References: <20220817083417.50884-1-colin.i.king@gmail.com>
In-Reply-To: <20220817083417.50884-1-colin.i.king@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86349f35-5dff-4aff-09be-08da8080cdb5
x-ms-traffictypediagnostic: CH2PR15MB3557:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M65l3O+q+A3pWPp1yJ5o9Rq0aJ4gbKEKL9R4F4YZM7rx2Lc1H0hugOj1UFJM+MjIiyMDD/o3ivr48PXbjuGllEOE+wbv3qH9YWzoRkxIDLBtxYkt0V/5E1yFvSSn3fZ4rczMdY6bSz3CqtXZjBPaQzxiFQV3g4MRIoZoW0fKUmaoo7nDM2m4D7benujlmr3lMlrewLkN/8ZUnbuBa95jAJObbbyr0gG4bBTfGfvIrOH13SvgTYV5nT10TqYunE+ml3BqipouAD+M+NyI6XlpYSMrBqdEl8rAH9fHDliscBvQIJAanAPVizUKpFza2ympBNs7/W/eGWIzNB6pNmqEZR9JFRL6YC9TNZPalLUR4L0Wf1lRDB/E32LTu1p46BF16hVJmqNYFx5kq7R/vWpV/yby5bbGMtYs0YE4PVI1Ncc7rh/DNnx9fwvgKBv8u3DUjk5q4NxKLuC4GIeVeK+hBhnYuHUWs9Bw7M+zrKPUHV16yGGGE7Ui3lshDNLHL3KyjL5a1X/9sQMvTO3YDjRSiJ5y+4QKQpX8eqTFNq/lZ4kaBx/YZcMTEniLtlFIyZ6iSK1vZ0Y4beBkhEhUlMlBgXs6CjbN1t/M5OdSpQFmFYHSUykdCJ9fOupq3YP4zBSdn2Z1I6UNxeNUMVpfXN6/YUapU0IGcu4yGQEha+mqoCkz/cIXv7ur09TbmsMbCA7/YFspuT96CRX/ZurjCOikniie5t17Lmc6lJK0CCdyKC2/1XXs+xwpxBBFOoGrz14JP/fL9ctFlqCah5g8aday+xyXteRNMQlvRWZ+QAqux9w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5259.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(6512007)(2616005)(53546011)(41300700001)(86362001)(186003)(38070700005)(66446008)(6506007)(478600001)(71200400001)(6486002)(33656002)(54906003)(6916009)(316002)(38100700002)(2906002)(5660300002)(8676002)(83380400001)(7416002)(91956017)(36756003)(4326008)(64756008)(76116006)(66476007)(66556008)(66946007)(8936002)(122000001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzR5Y1B4NFMxWmxEeWJlajFqYW1yL0QwZ2hWa1Q1SVROam5oRGFBMHMzNGVF?=
 =?utf-8?B?ZFFTVzR0bmFCOGdKV2l6dm0rM3JlSjRxb1BReVo2S3J6cm1zdUdoNjJIbkFP?=
 =?utf-8?B?WnQzYWhmSG1ZVHFoUHdSOXJGdGtyZFB2ZG5Ya3hYcytYbzBIOU1WNXN1Uy9N?=
 =?utf-8?B?TWRqeXZEYWdlWmtGUnlXT1pGZld3czFiM3F0NWN4MFc5dWlmSURwMGFONWJG?=
 =?utf-8?B?TWphTXVFemt4SG9rTHhlaDlPWmRsQ1pVc1FvRzVPNWZGY1hodkd2cTAzUlpj?=
 =?utf-8?B?VjB2VGN4N3JrODdaTEF6RCtQRkUvbVZEWFQ5UDlQT3F1N05yY2JSZmFrR0hw?=
 =?utf-8?B?TDNWaUR1NGUrNE1sMXpHRmxpYVkwbTBuT1FiTDNESU1DSXR2ZDZOU090ZGhL?=
 =?utf-8?B?SzhWZTlrR1UyWGM2ekk4bWNtM2VXSE9VYkM4NUhuKzN2dmdObGxTeDdiQ2Ew?=
 =?utf-8?B?VVd5MXVPTG42NlE0YTVHWmtKN25Hbm9kdG5qOFpmZlhYNnhYSzJENVFpTG5Q?=
 =?utf-8?B?K0pwWTM2WHdraVhjWktQNkkzc3k3Z1pBZVBnT29FeWNOMFdGNzg5L1BlL3Rv?=
 =?utf-8?B?MEhvR0NqVlJiOEJzQlJ3WEVLY1I2K0hlZkgwemF4SWJWakF6b2lET1FhaDFX?=
 =?utf-8?B?c0pTWGR4cjd4d3FRK0FKSkMyS2lVTStKS21NSnZzdjVJdHFiRmNzOXBoQXVP?=
 =?utf-8?B?ZDVZT0loL2lrV1VyNU5xOGxybHhEcFJ6Wi9USmRqcVpVM2k1bjY0Y0Z0aVZR?=
 =?utf-8?B?NHp5cUloaHVxd3krZndsWXc3MVRQdHFWQ0p5ckExL0VEYVlBSS9TdURMYWRx?=
 =?utf-8?B?STA5akdTSDFRMlV0enBpNmJqaGRGVTVYSlpYUFBjY0VLMlgvRkFFMk4reFFS?=
 =?utf-8?B?R1hWaDEwZzBaTExESkRWcHNZTGoxMmlnbUIvUTBZTGlGd01aRE83cDM0TnM3?=
 =?utf-8?B?WkpHOFNiQ0twZGpXOGFIQ0ZJQW1mUlZ1SVpqYVNMRmRpZ2ZHVGFvaU5CeHhF?=
 =?utf-8?B?VG1mRGh4NmNReHl4cVYwN0Q0VTF3TkVIdTBoU3cyK256K0k3NU82UkljNGlG?=
 =?utf-8?B?bFZRbEoxSUJaUGcxN1pERjFFVFo5bm4vVVdJem90ajZrRGswVTZ0eFVSdnVZ?=
 =?utf-8?B?bXRqcDVsd1I4SElCZmxUNlpGdGJzU3JvakYwSzRFbGVTbGRtdEhteDV5blQr?=
 =?utf-8?B?Z3gyL3JMMHJFdTZuSmtoWksxeHAvNGFJSlovNUkxalZvNWlnSEJrTzQ1d2di?=
 =?utf-8?B?SUs1eXNGMFV3dVpkemFkaHNGNTF2OWtLU3lsSjd6dzYrY0hqMnZ4TVBiZzNp?=
 =?utf-8?B?Q0xQL3pwczB0TVgxYWtlVXkxQ0dOS3I5Y0RRWUFUQU1nbnFRVGZjWjNzMk1p?=
 =?utf-8?B?dHZKdHdUZlI0dDBEc3ZLU3cvSUNDRTZOVmlWbThRZlIzZnJsejRoaU82cGVw?=
 =?utf-8?B?MWQyRWZ2cXF0YTdIeU5YUmtYWW5ZYXpEblZUWDRvUWpXY1RMSmNUTWxlUXdU?=
 =?utf-8?B?dHNPRXhmQXJ4bWcvNkp1WnNJTHU2WTRDN0hEcGRQYUdrNzJOZEMxRGpQcHpV?=
 =?utf-8?B?aE5xdCtKb2wreURPSGRnVjQrS0hXNG92VGdrem9GMjNWSEFneENXcjRqeWU5?=
 =?utf-8?B?UGZrZHFwRFMxU1J0WnVZcTF5czJnenlTRTdxODdCanVxWFVyek5vcld3dGxR?=
 =?utf-8?B?eDM5YWswa1dQMXBUNXNGak41Z2NkdGMrc3RaRURzVVYxZEExOUluTTlSUzNm?=
 =?utf-8?B?TDIrL3FXT2lyVWJjU0gyS3YrK1Q0MmtHdkZFMHlNaCtoWFpHaDUycXNxTnhw?=
 =?utf-8?B?c0NlNjNYSitxMGc1N0c1TUJxQjhoUzFRZGdRdWJpTitmdVBuTlFQaFBoOGZW?=
 =?utf-8?B?c2NmNmN2SStUTFdaalc1eWM0elVLKytoTytGcmRVYXFtUVJEcS8zZ044dHdX?=
 =?utf-8?B?dGhBT3pSTnZGdUk2NlpuOEd0SEFoV3BZdHJLSUFEY01udkJTOGpCbVZIWXBk?=
 =?utf-8?B?TjFRNkxZQ1E4U0hWMnNuKytPSGU2N2N3WXpId0o0VloyWHltRVpFZTU3SXpI?=
 =?utf-8?B?VWptVlo1WitoWGZpalNPYmlMSldDZlV6a3BUb0o4cVRSK1p6a1dMd2ZIMGk5?=
 =?utf-8?B?TUIzdzYyRXdUSm04WVljSE9mOStMNk5xa20zN2VjeDU3UnFLN1B5Ty9kcito?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A96ABB63142DDC4A804BF4EF39E52D4F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5259.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86349f35-5dff-4aff-09be-08da8080cdb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2022 18:46:32.1553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HIrYrmrwy3UyMuPAjMk5qrHXf+NyxUZFlW3Zws9pWFZr42W7I9De6TCLkspumeba
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3557
X-Proofpoint-GUID: gXt1PCw7_4n97UL0kbu7H1TafMjFcmEd
X-Proofpoint-ORIG-GUID: gXt1PCw7_4n97UL0kbu7H1TafMjFcmEd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_13,2022-08-16_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgQ29saW4sDQoNClRoYW5rcyBmb3IgeW91ciBwYXRjaCENCg0KQ2FuIHlvdSBjaGFuZ2UgcGF0
Y2ggdGl0bGUgdG8gIltQQVRDSCBicGYtbmV4dF0gc2VsZnRlc3RzL2JwZjogRml4IHNwZWxsaW5n
IG1pc3Rha2UgInN1Y2Nlc2Z1bOKAnSAoa2Z1bmNfY2FsbC5jKeKAnT8NCg0KUmVnYXJkcywNCk15
a29sYQ0KDQo+IE9uIEF1ZyAxNywgMjAyMiwgYXQgMTozNCBBTSwgQ29saW4gSWFuIEtpbmcgPGNv
bGluLmkua2luZ0BnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gIS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18DQo+ICBUaGlz
IE1lc3NhZ2UgSXMgRnJvbSBhbiBFeHRlcm5hbCBTZW5kZXINCj4gDQo+IHwtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIQ0K
PiANCj4gVGhlcmUgaXMgYSBzcGVsbGluZyBtaXN0YWtlIGluIGFuIEFTU0VSVF9PSyBsaXRlcmFs
IHN0cmluZy4gRml4IGl0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNv
bGluLmkua2luZ0BnbWFpbC5jb20+DQo+IC0tLQ0KPiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9i
cGYvcHJvZ190ZXN0cy9rZnVuY19jYWxsLmMgfCAyICstDQo+IDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL2tmdW5jX2NhbGwuYyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL2tmdW5jX2NhbGwuYw0KPiBpbmRleCAzNTFmYWZhMDA2
ZmIuLmVlZGU3YzMwNGY4NiAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
YnBmL3Byb2dfdGVzdHMva2Z1bmNfY2FsbC5jDQo+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2JwZi9wcm9nX3Rlc3RzL2tmdW5jX2NhbGwuYw0KPiBAQCAtMTA5LDcgKzEwOSw3IEBAIHN0
YXRpYyB2b2lkIHRlc3RfZGVzdHJ1Y3RpdmUodm9pZCkNCj4gew0KPiAJX191NjQgc2F2ZV9jYXBz
ID0gMDsNCj4gDQo+IC0JQVNTRVJUX09LKHRlc3RfZGVzdHJ1Y3RpdmVfb3Blbl9hbmRfbG9hZCgp
LCAic3VjY2VzZnVsX2xvYWQiKTsNCj4gKwlBU1NFUlRfT0sodGVzdF9kZXN0cnVjdGl2ZV9vcGVu
X2FuZF9sb2FkKCksICJzdWNjZXNzZnVsX2xvYWQiKTsNCj4gDQo+IAlpZiAoIUFTU0VSVF9PSyhj
YXBfZGlzYWJsZV9lZmZlY3RpdmUoMVVMTCA8PCBDQVBfU1lTX0JPT1QsICZzYXZlX2NhcHMpLCAi
ZHJvcF9jYXBzIikpDQo+IAkJcmV0dXJuOw0KPiAtLSANCj4gMi4zNy4xDQo+IA0KDQo=
