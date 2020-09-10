Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCBE2646F6
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Sep 2020 15:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbgIJN2L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Sep 2020 09:28:11 -0400
Received: from mx08-001d1705.pphosted.com ([185.183.30.70]:46671 "EHLO
        mx08-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730650AbgIJN1p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Sep 2020 09:27:45 -0400
Received: from pps.filterd (m0209323.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08ADO8WN015850;
        Thu, 10 Sep 2020 13:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=arcA9O00QGAee96fxt+qaG2HVn1O98qDtc24cNsTEVg=;
 b=cgc4R62Jbfp9KS5ybfE35zFCtDqQW5n2/FO+yMUiJcbRvMtxmwtQCpLoDFJz0mIVgPQ1
 GER5/7CNL87dvTuEQkcbndF8g0ZWdDpUgYUw8HYTnf3IMAKVeuE1TVh30gvgKauATsb4
 aCIRU/vB2PIeIa58PjMGz6pTsKrZ0jWulLlvyKmQ3DqujDkhnjwee94YqIz5CLBtSLdG
 lBBkOyIXzdaJxmY+PEMg57mvQkr0b3ZQciKUcCQECgVVSFQ1bcvGxHMnmrpP1LbNLMSY
 zgV0EAdZCI+h5g4M/tDVyhvX84uSp0jm/xJlCvUIqH/Bv4zF9GjBL4NqbJxgSeKY5IdN fw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by mx08-001d1705.pphosted.com with ESMTP id 33f5wj8ghw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Sep 2020 13:26:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFLD3H0W9eSXzYyqkG9l402G3C6Kq+VA2djq2npS1294LGqEd89vaOXd7vrNJUB31EZ5xVoo4ynrejgyPR0nXvqxnh2T9/G6WnKjvV2kHb10ulyuFdujgOG+AWxvatIMD7lo4byJoEzhxGr0JHW6Ho1pbFOfr4ctFe8mP6jT01Z0R9jrPa4Do+3TA9AMBjTr7Bh7yOcmtuS/CtMTyaExUvOP4JqFFHtmSZOW6DqCXbmvbZCmw/3nG1s1FdESB8qzZB4m1euey8a83ghzBC+hBmWK93q0vGyTbajP/nBa4KkNwOpdDgafRkDhXenIgYlpfOrpeBD3w5GoqRR03NYPdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arcA9O00QGAee96fxt+qaG2HVn1O98qDtc24cNsTEVg=;
 b=gKDBZYBiOEQNmEHhhy+QTnAn+6NuxOXiFOE5oK5kGjcp59DxISLrwS0qqqfHpkaeXI+mGMebF44yyeIbcueR86wanbN5omEzKPotAVn7vdEFhuL68ZbDsZXXoVpjvhcxq3fWPx5htwsHQRyxG+S2CmEYVaxZBNaBVm5e2wbY4/4khWivRIxPpSsuX5TcwH0pevET5w+9HH/Nts0OFWyHfW7COGJYlSu8t1Lxy7pkA7e+Tt2oAw2vErwJZGm7iE0JmZXhdiZ5kITs2860PxCrhVKk/0ZB/q9FTNPVbRbQ0UCLqJeGnObaQrBIsBCxtTAI4FGmuKUd56bhCLGRKNqKtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from CY4PR13MB1175.namprd13.prod.outlook.com (2603:10b6:903:40::23)
 by CY4PR13MB1638.namprd13.prod.outlook.com (2603:10b6:903:156::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.8; Thu, 10 Sep
 2020 13:26:05 +0000
Received: from CY4PR13MB1175.namprd13.prod.outlook.com
 ([fe80::5c0c:3d3a:c493:efa]) by CY4PR13MB1175.namprd13.prod.outlook.com
 ([fe80::5c0c:3d3a:c493:efa%11]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 13:26:05 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v3 3/8] Documentation: tracing: Add tracing_on option to
 boot-time tracer
Thread-Topic: [PATCH v3 3/8] Documentation: tracing: Add tracing_on option to
 boot-time tracer
Thread-Index: AQHWh1BRWsK5gHw3hE2ET0CGqzU6s6lh3Oig
Date:   Thu, 10 Sep 2020 13:26:05 +0000
Message-ID: <CY4PR13MB1175F981AB2931C228EBF42FFD270@CY4PR13MB1175.namprd13.prod.outlook.com>
References: <159972809455.428528.4737752126800169128.stgit@devnote2>
 <159972812521.428528.4047280962991773996.stgit@devnote2>
In-Reply-To: <159972812521.428528.4047280962991773996.stgit@devnote2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=sony.com;
x-originating-ip: [192.34.114.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e77ec83b-6c92-40d9-5eea-08d8558d121e
x-ms-traffictypediagnostic: CY4PR13MB1638:
x-microsoft-antispam-prvs: <CY4PR13MB1638B87A15E3E2F97A6D7DF3FD270@CY4PR13MB1638.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HMlD4yx8GoEOCIhORJILDEadD2GUkp5qS9MD5kN7HvJWgxiWUY3OKj9GRhC3fNGmE/LhVjcP0R07fuL9ha4CO2/5bDkJQcMZpWGWThJgTdoJSJ16+Wo07OO6Hww2JVS3UjsYvf9PDg8Ef9UfDV5FNQkGqsYjDiAcO0ek6lmeSY+5Qg/jgSOdnKyYaOMHw0AG3bLh8Zf2lOu4TIXWRIkqd7gfk6V5bmnRKL4l+cN5mNibmZ427ILIReTuRKx2V84LqtAHpta3MWmB7THY1Z3ecbxvAjMvodipK0NTelhs8UD5rQc10WJhVyZFv2o4vfqQNsCYUmwzVqf7Zl0otKP6JQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR13MB1175.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(64756008)(33656002)(66946007)(66476007)(66446008)(71200400001)(54906003)(110136005)(83380400001)(4326008)(4744005)(86362001)(5660300002)(478600001)(66556008)(9686003)(52536014)(76116006)(55016002)(8676002)(316002)(26005)(2906002)(186003)(7696005)(8936002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: o7kVbAfPk5ns2QzKPziGuLJYMdNZjrfBFqpDGYJeVXzz6xPylukcHQz4KrDOI3TTdOAnxfn9dM7JaVJOzQ8wJOOL7vhqTSimmrd1AhZWi1dUaoQL2JiiLgXd5IsaOw+GU4pUzjcGyfnKXzAGOA5uTgFc78jxU+xb4nD9DZwSTeAflEYRuJ7c/+r1hDPQOpHPWrNx0L7G6HFuBAb/7nwIPLrAbxQpVRNoD+4O7GTO8eyPhylMyp3tCerJYAKiHXXYRXyPVWI978+SpRFpJjNwi+dboWPmvLYfXQ6PUHaQT3BkK8vN8X2HeokxM1WFOa9FQNHI+0ipMqN5KLLxfqNmL1uQ1PaclaobsE0tEzcwoWSAJUZylVF84SbB8qSJZn9PmAPIqeDN6gyTQ+eI+FjxXlzcQGkrAgxxyK0W2iywt7M/JHY1DKjpQfGUaYez6lPh4x+Ybk2qyrHoCiiIIyaucifxH2DU16pGkyh0+I0sXLq0nr32loI2PKh1lN4njYajPx8Y4Y6FVTo+Meon7zY++jDiT3lY6mspe9L4mKGpIkatgqLSFp7NFxKTsTYBmkwo5vV2WD0mcgRXKfY7a+cXD2B0BBudFupxpPHnevfRlraMekbUaZUNi8jFW+zTe3D80ZRo+mqzcGZbZohjISPZuw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR13MB1175.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e77ec83b-6c92-40d9-5eea-08d8558d121e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2020 13:26:05.4875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NbeQVxcjqKjPcp22ZKRFSYjhf4V1e4HQ4EKFVKDkpY1KgJfrdOuAHVOs9JdTwec/6KgKdKKH64dEfjNO9e/Fzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR13MB1638
X-Sony-Outbound-GUID: sjd35qng0o4dlAc5ymtIGR9KlUpY5e3X
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-10_03:2020-09-10,2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 clxscore=1011 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009100123
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFzYW1pIEhpcmFtYXRz
dQ0KID4gDQo+IEFkZCB0cmFjaW5nX29uIG9wdGlvbiBkZXNjcmlwdGlvbiB0byB0aGUgYm9vdC10
aW1lIHRyYWNlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hc2FtaSBIaXJhbWF0c3UgPG1oaXJh
bWF0QGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiAgRG9jdW1lbnRhdGlvbi90cmFjZS9ib290dGltZS10
cmFjZS5yc3QgfCAgICA0ICsrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3RyYWNlL2Jvb3R0aW1lLXRyYWNlLnJz
dCBiL0RvY3VtZW50YXRpb24vdHJhY2UvYm9vdHRpbWUtdHJhY2UucnN0DQo+IGluZGV4IGRjYjM5
MDA3NWNhMS4uMTM0MWI0NDlhY2FhIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL3RyYWNl
L2Jvb3R0aW1lLXRyYWNlLnJzdA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL3RyYWNlL2Jvb3R0aW1l
LXRyYWNlLnJzdA0KPiBAQCAtNjEsNiArNjEsMTAgQEAgVGhlc2Ugb3B0aW9ucyBjYW4gYmUgdXNl
ZCBmb3IgZWFjaCBpbnN0YW5jZSBpbmNsdWRpbmcgZ2xvYmFsIGZ0cmFjZSBub2RlLg0KPiAgZnRy
YWNlLltpbnN0YW5jZS5JTlNUQU5DRS5db3B0aW9ucyA9IE9QVDFbLCBPUFQyWy4uLl1dDQo+ICAg
ICBFbmFibGUgZ2l2ZW4gZnRyYWNlIG9wdGlvbnMuDQo+IA0KPiArZnRyYWNlLltpbnN0YW5jZS5J
TlNUQU5DRS5ddHJhY2luZ19vbiA9IDB8MQ0KPiArICAgRW5hYmxlL0Rpc2FibGUgdHJhY2luZyBv
biB0aGlzIGluc3RhbmNlIHdoZW4gYm9vdC4NCg0Kd2hlbiBib290LiAtPiB3aGVuIGJvb3Rpbmcu
DQoob3Igd2hlbiBib290LiAtPiBvbiBib290LikNCiAtLSBUaW0NCg0KPiArICAgKHlvdSBjYW4g
ZW5hYmxlIGl0IGJ5IHRoZSAidHJhY2VvbiIgZXZlbnQgdHJpZ2dlciBhY3Rpb24pDQo+ICsNCj4g
IGZ0cmFjZS5baW5zdGFuY2UuSU5TVEFOQ0UuXXRyYWNlX2Nsb2NrID0gQ0xPQ0sNCj4gICAgIFNl
dCBnaXZlbiBDTE9DSyB0byBmdHJhY2UncyB0cmFjZV9jbG9jay4NCj4gDQoNCg==
