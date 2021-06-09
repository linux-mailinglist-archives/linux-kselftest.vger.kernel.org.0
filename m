Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EAA3A0BCA
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jun 2021 07:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhFIFVt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Jun 2021 01:21:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:36341 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230266AbhFIFVt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Jun 2021 01:21:49 -0400
IronPort-SDR: Q0JvaYm1jbB0pqMa/G1Qc1Ys8FZUNWrO5cnQmSTE0lq4ORFolw2xAdJsBMylGpJcwdxh39ZIi+
 3sTIeblBFWmg==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="290633811"
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="290633811"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 22:19:55 -0700
IronPort-SDR: HklP5L0za1RUNa7LTes74QT32fjikezrd29HxoMTajDI3zFP3psJDvk1IT5IlbLVKVtZ9ko8is
 +vzWtUs6N3kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="485593708"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 08 Jun 2021 22:19:55 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 8 Jun 2021 22:19:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 8 Jun 2021 22:19:54 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 8 Jun 2021 22:19:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKsatRfEncQWWLW6IolDPtGPTfvkEczyNYBJfEoAGyZcupskKY2EgG5aOYjZqY8HJTrX/E/mhD0oBYV7b+2ib6QXMyDrw89uGLaBsEp8lGEgKklnJoBKuSyN9Rf621y0NO8o30mOzftUBdc4sBQJIEpoP4ZgCMRpgjfs1tShR902keGe4Y3ezKZJ8pJn07aSTNx7AHWwgTtONM/nxrS/gp+UXKn0RiG+g1J0U88m7wJkfE9bEZac/Xf/5FYDDrB1wDP+1fAdr/w2nY2B0MfhKCybBlnGLTp//5/AX+Xq1Aq1fL5aSBA5v6AUbBmAGKXLTC+ZUJSuR9TxffILpoHJoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BC8901sVhsutwmSL/Lf0kYM7vwy5MrFxqTmeUFbD0tU=;
 b=YVGeqhfPqZsNvzTUffObxXqAHDBp+bj9Y3DzggwCgJCk2Kw+Uy8p1DgmXsAt8MsRModvxnQRNesch4k+rPtAAu/diCx4bGloS22BdiKY7wllP0Zfj/jOpJjWtEq2tOxqf5/Xi7r3wxLgwSdkSham69RP9oVhu2OIsSCCqsVaOVRimky0hrs/ThlGnogEeBgH95IGIJQmQk2nw5Om09koPkCMRDSWo9nVaFXMyx6XZWJsI2Z70/I6L7036ey0/VWUcsoGXWDqrwHD3xQ2glSkd3bZV1Qao9frgtJCUnp/R3RRu3qdhINn3+oRj8VO1BIvcgBqCpgka56vjObeQ1/lcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BC8901sVhsutwmSL/Lf0kYM7vwy5MrFxqTmeUFbD0tU=;
 b=eW0BgEQyKtAR1SxvUPMhDY6R+fLK5HGtOp67LmbaWTFOtai9zciLDGUqHNzwYkWJf67DiRcnI9/DonVkaj7gKok3NSLzC71hExThzaKjf+NdPRAfakFJEb6qCLNi+ZYJHV3cR80Ceybeke89OGQaapRWGwlsjBYHMHjaK782k58=
Received: from DM8PR11MB5670.namprd11.prod.outlook.com (2603:10b6:8:37::12) by
 DM8PR11MB5624.namprd11.prod.outlook.com (2603:10b6:8:35::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.23; Wed, 9 Jun 2021 05:19:53 +0000
Received: from DM8PR11MB5670.namprd11.prod.outlook.com
 ([fe80::ccbb:37d7:aba8:2f8e]) by DM8PR11MB5670.namprd11.prod.outlook.com
 ([fe80::ccbb:37d7:aba8:2f8e%8]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 05:19:53 +0000
From:   "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "maciej.szmigiero@oracle.com" <maciej.szmigiero@oracle.com>,
        "drjones@redhat.com" <drjones@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>
Subject: RE: [PATCH 0/3] Restore extra_mem_pages and add slot0_mem_pages
Thread-Topic: [PATCH 0/3] Restore extra_mem_pages and add slot0_mem_pages
Thread-Index: AQHXXDkibxi49uDT/UqPnpuhGn6NS6sKX2mAgADFwbA=
Date:   Wed, 9 Jun 2021 05:19:53 +0000
Message-ID: <DM8PR11MB5670F0CD88BE8FDB0CCA568092369@DM8PR11MB5670.namprd11.prod.outlook.com>
References: <20210608233816.423958-1-zhenzhong.duan@intel.com>
 <356f17eb-8357-9863-6655-d1a737e587fd@redhat.com>
In-Reply-To: <356f17eb-8357-9863-6655-d1a737e587fd@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.5.1.3
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [111.205.14.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f048a0a-c60d-4893-d949-08d92b063680
x-ms-traffictypediagnostic: DM8PR11MB5624:
x-microsoft-antispam-prvs: <DM8PR11MB5624B226B7A2B86F2236C0D292369@DM8PR11MB5624.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3dDiAiERldKP070WU2A+ADmUFnv/Zc9vj5o28uJI+6Mg8GXbHn9sbF2is4ER5IVpm3mFCAGf6I5YQhOC71Yv6aNlCfTErWsNNmStGqW+1dwU2XzPOjZ+1xiO3KAfFNYXZyQajVxKP+D+T89CnW5qlafhvpzwd0pfZqkOxgAXBw7UOC5/VyNgcFaNM0h6hJSq667kEdZBB3azZsqIutmhG1QCQFCyspmy8K1DhP/n+GraeLZTx/JhnCzuBb4flD4qqPJtPT58EjlNYxYEbptc1pDh23VmgAo2Ao5HIXTN1WUo2q59ogz3jGeHyDwkqQE3G6KKeyuRFgyMc8baAA3pnccy6/fsDtv7i8W67jRo4Zv761MIWxePpThgHdPkjPIngbU18Yrn3mVRXZHnuI1E5UtQ5oLk07BqPL9KGEY4i6gejvZ/jexhv0sUK5erBSbIzy3lxWF11ywqg92uCUY1JVhaLbSUduD7xBntHFjc8D1My1uc2f6h9J59inEFwBf9t1leIyaSyKIV3A02oBp/vYZQKwC86lo7vFvMuR/0tcQXdidGQXtc7bmRPh2akLlh4He7t15TuQc8t4CqobsPx0CsWf7FoXBs0Fq4L/9sfwBxh6Oe0uTefZiwRiDhNY9M+v9JJ9b4NLp+Q91Rk7tvTcNdDQ+w7vQzTrnIf6eJTARrNFjoUlUzmo/SqZ0r14nWcLbLJ4oHrjJdQk9xgY2bH6JuF2Az0K3Wb6Tf6rQpsA3DCSmcBteBHxc+UqqUMLAa1ysqDz3M4gFdvJ2HqJCiTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5670.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(376002)(136003)(346002)(9686003)(4326008)(66946007)(7696005)(122000001)(478600001)(54906003)(8936002)(966005)(66476007)(66556008)(64756008)(52536014)(76116006)(38100700002)(66446008)(33656002)(2906002)(5660300002)(71200400001)(110136005)(8676002)(83380400001)(86362001)(6506007)(53546011)(316002)(186003)(55016002)(26005)(13296009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUhaR2JpWDF1Wm1ONStyb3Q3ZzcwbjJlcHgwZlVtUUZ3aGlkNlJObzZWTDl6?=
 =?utf-8?B?SER3WFZ1YkFPTTJVSndJSnRobmMyUFUxNnNxOERkMmpscHlDcnNrZ2lrVjdV?=
 =?utf-8?B?OGtndGRzcnNqd3QwcDFPK0k0bHRuZ0RmaHM3NlA3NWFzUVJTbUZQczhuRTUv?=
 =?utf-8?B?QmlVVmg1L3Zrc0IwTkowZGxKWDZDR3ZBZ1o4a1A1S01zcVRRbWxqYkxVZU4r?=
 =?utf-8?B?ajNaTjlIdE52Qm1FTE5YL1ByNXZ3VThLSSsyRmhzTCt4dlM5aWJvcjgzQ2x2?=
 =?utf-8?B?K1gzVmdhVWU3ODFrOWVpbVd3bE1YMTlXeENRLzNnTC9VUkZkamdhOEs5Y2U5?=
 =?utf-8?B?THNjN0owUWZaMG1BVkxoZnpIMXpQdEdobTMzUEs4QjVmZVY1MWZjL1dQdUZw?=
 =?utf-8?B?dkNpZmRkUERNMnhhRFFsTGtaNUxoU1Y5NW9YVGUrTUJnZERCZUVQamNFUEFw?=
 =?utf-8?B?M2xYUGlaM05hRER0OU90L0srT1JrOFNXall3TDQrOTd4YnIyQURmV09zM1ZH?=
 =?utf-8?B?SEtybis4TjdiOWgzdHhwUjh4eUg3SEl3cjYyTUZ3ZURNbWxOSk5Qd2pCSFlZ?=
 =?utf-8?B?bHpldlAvRWJuTFp3SWZVMk5ORExDQk00Z0l3MjBvTjJNSlRZUGw1bHZabWdR?=
 =?utf-8?B?YU5IZEt1RTNnWkNBd1QyVzlQMGZtcmNRNi85VmxqdWp1b0N2dWMxUW15NnZq?=
 =?utf-8?B?c2tRcCsxVXBWSXAvKzBnQ0phMzlKa3RqdjZTTTlrWXdDaDNzbkcybjNGc2xM?=
 =?utf-8?B?WDBtQlhoWkRZZWdLSFZIS3Z6VmpEa25lRWJiY0NQeWZHRVNqODNTcnRvQWFJ?=
 =?utf-8?B?eWVQM2ZqZndsR251QnQrVXNlR0p3VTRLaDBxMlQ4NmtLU2c2ZjRaTEtyb21x?=
 =?utf-8?B?MHJ6MzEvdHAxWXlTWFFGZ2RoYUVqbVkvY3FJR0REMGlqcThLaHA2VXJMbzd3?=
 =?utf-8?B?VktLSG5EN0IwTEUzSXVkSk1tRGVrRkUvZ2NoRCs5TWZpZEFHNzZja3FjbVpO?=
 =?utf-8?B?clJTbzR2bStLUVRVa1czSGJKNjNxcGVWR2hHcjdPWDJ4Q29GT3lBR2w0Qjda?=
 =?utf-8?B?clUyQyt5alplcDNNb3dUWDJDaWRIbTB3c1pENW9pQlIvRmU5V1NQbWIzaVNT?=
 =?utf-8?B?SytSQUVYT3QweUJUdS9oNWRmN3gxY0d3S1VEVml6OURmWTlEd1V1TDAvTFlN?=
 =?utf-8?B?TVU1Z0VoSER5MnlVTG82WUxvMlBzSmNQaTZjbUJjMXRiN3RkcE1GaGFRQnZM?=
 =?utf-8?B?Z0svL1NQZVYvbzBnekFrdFF3VWtOTTRrVnZGTVJ1UVl2eHQyNW9Kb1RDNk5w?=
 =?utf-8?B?YzNGN2Fzb1pXSURXbm5UWEJkK0dUZ0VVZjF4TWl2VG9DMGw3cWNTZkdZcXVp?=
 =?utf-8?B?dXJ2WDJvNUxjOWwxYmdoVnBSQW1yR0xrWDFjNnRiRnNiRHNNaEFSZnJrZ1U5?=
 =?utf-8?B?NWZpc0J1WlJRR01DUmdyOXVvdXh1WCtONVhZRjlwTXltcFRRV0w2NGtWY2U1?=
 =?utf-8?B?RmdZcFgxemtLUWFiVTYxVUFWQTRTRk0zYjhFREhSVkxtVitFWHJBYjgrZnZy?=
 =?utf-8?B?SHZkK09OZW53NDlRaE1oZmg5cGVXZ3BUNWd6NUE5YXBEVzBQalhtZE5Wd3dM?=
 =?utf-8?B?UkVQeDJQYVpzdUJGZkpQd3E0M29EN1FYbUV6OUVVOWFVc2FTTHM0bmlvd3NH?=
 =?utf-8?B?Q0tkTFpub3lCY2d6Vm5QWDFZSWxVajRlZmVDNGI1UUpQMzJSbCtiVWJrNHZo?=
 =?utf-8?Q?CKm55SP897SgXVY35A=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5670.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f048a0a-c60d-4893-d949-08d92b063680
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 05:19:53.3280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zOfl3DDXJK5qm0gPTSTV1krgrBbWwwIqgJipN20ebkocgneUGiQNAh/OojR20q4falZRjsjTubFh33nHKe7R5AB+c0p4wHKixT7NMPwC7R4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5624
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQm9uemluaSA8
cGJvbnppbmlAcmVkaGF0LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDksIDIwMjEgMToz
MCBBTQ0KPiBUbzogRHVhbiwgWmhlbnpob25nIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+OyBs
aW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogbGludXgta3NlbGZ0ZXN0QHZn
ZXIua2VybmVsLm9yZzsga3ZtQHZnZXIua2VybmVsLm9yZzsNCj4gbWFjaWVqLnN6bWlnaWVyb0Bv
cmFjbGUuY29tOyBkcmpvbmVzQHJlZGhhdC5jb207IHNodWFoQGtlcm5lbC5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSCAwLzNdIFJlc3RvcmUgZXh0cmFfbWVtX3BhZ2VzIGFuZCBhZGQNCj4gc2xv
dDBfbWVtX3BhZ2VzDQo+IA0KPiBPbiAwOS8wNi8yMSAwMTozOCwgWmhlbnpob25nIER1YW4gd3Jv
dGU6DQo+ID4gKDM5ZmUyZmM5NjY5NCAic2VsZnRlc3RzOiBrdm06IG1ha2UgYWxsb2NhdGlvbiBv
ZiBleHRyYSBtZW1vcnkgdGFrZQ0KPiA+IGVmZmVjdCIpIGNoYW5nZWQgdGhlIG1lYW5pbmcgb2Yg
ZXh0cmFfbWVtX3BhZ2VzIGFuZCB0cmVhdGVkIGl0IGFzIHNsb3QwDQo+IG1lbW9yeSBzaXplLg0K
PiA+DQo+ID4gSW4gZmFjdCBleHRyYV9tZW1fcGFnZXMgaXMgdXNlZCBmb3Igbm9uLXNsb3QwIG1l
bW9yeSBzaXplLCB0aGVyZSBpcyBubw0KPiA+IGN1c3RvbQ0KPiA+IHNsb3QwIG1lbW9yeSBzaXpl
IHN1cHBvcnQuIFNlZSBkaXNjdXNzIGluDQo+ID4gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjEv
Ni8zLzU1MQ0KPiA+IGZvciBtb3JlIGRldGFpbHMuDQo+ID4NCj4gPiBUaGlzIHBhdGNoc2V0IHJl
c3RvcmVzIGV4dHJhX21lbV9wYWdlcydzIG9yaWdpbmFsIG1lYW5pbmcgYW5kIGFkZHMNCj4gPiBz
dXBwb3J0IGZvciBjdXN0b20gc2xvdDAgbWVtb3J5IHdpdGggYSBuZXcgcGFyYW1ldGVyIHNsb3Qw
X21lbV9wYWdlcy4NCj4gDQo+IEJlY2F1c2UgdGhlIHR3byByZXZlcnRzIGFyZSBzbyBzbWFsbCwg
SSBzcXVhc2hlZCBldmVyeXRoaW5nIGluIGEgc2luZ2xlIHBhdGNoDQo+IHdpdGggdGhlIGZvbGxv
d2luZyBtZXNzYWdlOg0KPiANCj4gICAgICBVbnRpbCBjb21taXQgMzlmZTJmYzk2Njk0ICgic2Vs
ZnRlc3RzOiBrdm06IG1ha2UgYWxsb2NhdGlvbiBvZiBleHRyYQ0KPiAgICAgIG1lbW9yeSB0YWtl
IGVmZmVjdCIsIDIwMjEtMDUtMjcpLCBwYXJhbWV0ZXIgZXh0cmFfbWVtX3BhZ2VzIHdhcyB1c2Vk
DQo+ICAgICAgb25seSB0byBjYWxjdWxhdGUgdGhlIHBhZ2UgdGFibGUgc2l6ZSBmb3IgYWxsIHRo
ZSBtZW1vcnkgY2h1bmtzLA0KPiAgICAgIGJlY2F1c2UgcmVhbCBtZW1vcnkgYWxsb2NhdGlvbiBo
YXBwZW5lZCB3aXRoIGNhbGxzIG9mDQo+ICAgICAgdm1fdXNlcnNwYWNlX21lbV9yZWdpb25fYWRk
KCkgYWZ0ZXIgdm1fY3JlYXRlX2RlZmF1bHQoKS4NCj4gDQo+ICAgICAgQ29tbWl0IDM5ZmUyZmM5
NjY5NCBob3dldmVyIGNoYW5nZWQgdGhlIG1lYW5pbmcgb2YNCj4gZXh0cmFfbWVtX3BhZ2VzIHRv
DQo+ICAgICAgdGhlIHNpemUgb2YgbWVtb3J5IHNsb3QgMC4gIFRoaXMgbWFrZXMgdGhlIG1lbW9y
eSBhbGxvY2F0aW9uIG1vcmUNCj4gICAgICBmbGV4aWJsZSwgYnV0IG1ha2VzIGl0IGhhcmRlciB0
byBhY2NvdW50IGZvciB0aGUgbnVtYmVyIG9mDQo+ICAgICAgcGFnZXMgbmVlZGVkIGZvciB0aGUg
cGFnZSB0YWJsZXMuICBGb3IgZXhhbXBsZSwgbWVtc2xvdF9wZXJmX3Rlc3QNCj4gICAgICBoYXMg
YSBzbWFsbCBhbW91bnQgb2YgbWVtb3J5IGluIHNsb3QgMCBidXQgYSBsb3QgaW4gb3RoZXIgc2xv
dHMsDQo+ICAgICAgYW5kIGFkZGluZyB0aGF0IG1lbW9yeSB0d2ljZSAoYm90aCBpbiBzbG90IDAg
YW5kIHdpdGggbGF0ZXINCj4gICAgICBjYWxscyB0byB2bV91c2Vyc3BhY2VfbWVtX3JlZ2lvbl9h
ZGQoKSkgY2F1c2VzIGFuIGVycm9yIHRoYXQNCj4gICAgICB3YXMgZml4ZWQgaW4gY29tbWl0IDAw
MGFjNDI5NTMzOSAoInNlbGZ0ZXN0czoga3ZtOiBmaXggb3ZlcmxhcHBpbmcNCj4gICAgICBhZGRy
ZXNzZXMgaW4gbWVtc2xvdF9wZXJmX3Rlc3QiLCAyMDIxLTA1LTI5KQ0KPiANCj4gICAgICBTaW5j
ZSBib3RoIHVzZXMgYXJlIHNlbnNpYmxlLCBhZGQgYSBuZXcgcGFyYW1ldGVyIHNsb3QwX21lbV9w
YWdlcw0KPiAgICAgIHRvIHZtX2NyZWF0ZV93aXRoX3ZjcHVzKCkgYW5kIHNvbWUgY29tbWVudHMg
dG8gY2xhcmlmeSB0aGUgbWVhbmluZyBvZg0KPiAgICAgIHNsb3QwX21lbV9wYWdlcyBhbmQgZXh0
cmFfbWVtX3BhZ2VzLiAgV2l0aCB0aGlzIGNoYW5nZSwNCj4gICAgICBtZW1zbG90X3BlcmZfdGVz
dCBjYW4gZ28gYmFjayB0byBwYXNzaW5nIHRoZSBudW1iZXIgb2YgbWVtb3J5DQo+ICAgICAgcGFn
ZXMgYXMgZXh0cmFfbWVtX3BhZ2VzLg0KPiANCg0KVGhpcyBsb29rcyBtb3JlIGNsZWFyLCB0aGFu
a3MgZm9yIGRvaW5nIHRoYXQuDQoNClJlZ2FyZHMNClpoZW56aG9uZw0K
