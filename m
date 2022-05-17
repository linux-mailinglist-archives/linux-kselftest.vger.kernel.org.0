Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0102252A1C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 May 2022 14:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346236AbiEQMlW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 May 2022 08:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346279AbiEQMlS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 May 2022 08:41:18 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D6D1EAEB;
        Tue, 17 May 2022 05:41:15 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HC7RvY011076;
        Tue, 17 May 2022 12:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=b/7OR8TI5chbNwFvrnM+gSWzYdcco2plrrSNiw9zh7c=;
 b=i2DTaI64cVwWqnJ7iovZeA0h1C54WcSV5SvYkKKJByvcOB/vqQEX23hk4x/lGQ+mRHz6
 QD2WgyIRd7Rb8Lq7SVHlHdN2sO7BvLnhDJpwg83aUmSOlRJZbRY4ugsv6u6/LE3w+g/X
 tGJ86X0a6JLvyJ4LQxWKWfHKF8gLoiyhaelOVJ0G5HqH4tkRUleFtK8AoL7lXHDC2dsC
 vSzWIt5r8PFUpIybR4G6YrQncJ8CnoixIE2uVg/LqMRPwFjIqyK/PLEb1H5oYomI4ErZ
 yk2LxAyDeTxYeeBCBc5NOqFzjOLjnJWJ44xLtko/sHQ+z1kKO3GR38+UjgeM/yCtYGYS YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g4be8ruye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 12:41:09 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24HCUI9E028398;
        Tue, 17 May 2022 12:41:09 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g4be8ruxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 12:41:09 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24HCY4AV028037;
        Tue, 17 May 2022 12:41:07 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3g23pjc7h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 12:41:07 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24HCf3K510748328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 12:41:03 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79063A4055;
        Tue, 17 May 2022 12:41:03 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1AF3A404D;
        Tue, 17 May 2022 12:41:02 +0000 (GMT)
Received: from [9.145.157.61] (unknown [9.145.157.61])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 17 May 2022 12:41:02 +0000 (GMT)
Message-ID: <6a82b7b5-df80-8b8e-33f8-ce9e6192347f@linux.ibm.com>
Date:   Tue, 17 May 2022 14:41:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 1/2] drivers/s390/char: Add Ultravisor io device
Content-Language: en-US
To:     Steffen Eiden <seiden@linux.ibm.com>, Greg KH <greg@kroah.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nico Boehr <nrb@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
References: <20220510144724.3321985-1-seiden@linux.ibm.com>
 <20220510144724.3321985-2-seiden@linux.ibm.com>
 <bae6b9f0-dd4d-f109-b220-f6b118c889ad@linux.ibm.com>
 <78acfe88-97e3-92f9-29ef-736530179758@linux.ibm.com>
From:   Janosch Frank <frankja@linux.ibm.com>
In-Reply-To: <78acfe88-97e3-92f9-29ef-736530179758@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: j_qA0qzqN__lvQc9lsiUnjFg0e-pxkRw
X-Proofpoint-ORIG-GUID: MyCezTjgTJy7iXiref5hw8dPn08alrG-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_02,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205170073
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gNS8xNy8yMiAxMDo0MiwgU3RlZmZlbiBFaWRlbiB3cm90ZToNCj4gDQo+IA0KPiBPbiA1
LzE3LzIyIDEwOjM4LCBKYW5vc2NoIEZyYW5rIHdyb3RlOg0KPj4gT24gNS8xMC8yMiAxNjo0
NywgU3RlZmZlbiBFaWRlbiB3cm90ZToNCj4+PiBUaGlzIHBhdGNoIGFkZHMgYSBuZXcgbWlz
Y2RldmljZSB0byBleHBvc2Ugc29tZSBVbHRyYXZpc29yIGZ1bmN0aW9ucw0KPj4+IHRvIHVz
ZXJzcGFjZS4gVXNlcnNwYWNlIGNhbiBzZW5kIElPQ1RMcyB0byB0aGUgdXZkZXZpY2UgdGhh
dCB3aWxsIHRoZW4NCj4+PiBlbWl0IGEgY29ycmVzcG9uZGluZyBVbHRyYXZpc29yIENhbGwg
YW5kIGhhbmRzIHRoZSByZXN1bHQgb3ZlciB0bw0KPj4+IHVzZXJzcGFjZS4gVGhlIHV2ZGV2
aWNlIGlzIGF2YWlsYWJsZSBpZiB0aGUgVWx0cmF2aXNvciBDYWxsIGZhY2lsaXR5IGlzDQo+
Pj4gcHJlc2VudC4NCj4+PiBVc2Vyc3BhY2UgY2FuIGNhbGwgdGhlIFJldHJpZXZlIEF0dGVz
dGF0aW9uIE1lYXN1cmVtZW50DQo+Pj4gVWx0cmF2aXNvciBDYWxsIHVzaW5nIElPQ1RMcyBv
biB0aGUgdXZkZXZpY2UuDQo+Pj4NCj4+PiBUaGUgdXZkZXZpY2Ugd2lsbCBkbyBzb21lIHNh
bml0eSBjaGVja3MgZmlyc3QuDQo+Pj4gVGhlbiwgY29weSB0aGUgcmVxdWVzdCBkYXRhIHRv
IGtlcm5lbCBzcGFjZSwgYnVpbGQgdGhlIFVWQ0IsDQo+Pj4gcGVyZm9ybSB0aGUgVVYgY2Fs
bCwgYW5kIGNvcHkgdGhlIHJlc3VsdCBiYWNrIHRvIHVzZXJzcGFjZS4NCj4+Pg0KPj4+IFNp
Z25lZC1vZmYtYnk6IFN0ZWZmZW4gRWlkZW4gPHNlaWRlbkBsaW51eC5pYm0uY29tPg0KPj4+
IFJldmlld2VkLWJ5OiBKYW5vc2NoIEZyYW5rIDxmcmFua2phQGxpbnV4LmlibS5jb20+DQo+
Pg0KPj4gSSdkIGxpa2UgdG8gcGljayB0aGlzIGlmIEknbSBhbGxvd2VkIHRvIGZpeCB0aGUg
dHdvIHdoaXRlIHNwYWNlIHByb2JsZW1zDQo+PiBiZWxvdy4NCj4gSSBhbSBmaW5lIHdpdGgg
dGhhdC4NCg0KVGhhbmtzLCBwaWNrZWQNCg0KPiANCj4gVGhhbmsgeW91Lg0KPiANCj4+DQo+
Pj4gLS0tDQo+Pj4gIMKgIE1BSU5UQUlORVJTwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAyICsNCj4+PiAgwqAgYXJjaC9zMzkw
L2luY2x1ZGUvYXNtL3V2LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyMyArKy0NCj4+
PiAgwqAgYXJjaC9zMzkwL2luY2x1ZGUvdWFwaS9hc20vdXZkZXZpY2UuaCB8wqAgNTEgKysr
KysNCj4+PiAgwqAgZHJpdmVycy9zMzkwL2NoYXIvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8wqAgMTAgKw0KPj4+ICDCoCBkcml2ZXJzL3MzOTAvY2hhci9NYWtlZmlsZcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArDQo+Pj4gIMKgIGRyaXZlcnMvczM5MC9j
aGFyL3V2ZGV2aWNlLmPCoMKgwqDCoMKgwqDCoMKgwqAgfCAyNjQgKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4+PiAgwqAgNiBmaWxlcyBjaGFuZ2VkLCAzNTAgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPj4+ICDCoCBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9zMzkw
L2luY2x1ZGUvdWFwaS9hc20vdXZkZXZpY2UuaA0KPj4+ICDCoCBjcmVhdGUgbW9kZSAxMDA2
NDQgZHJpdmVycy9zMzkwL2NoYXIvdXZkZXZpY2UuYw0KPj4+DQo+Pg0KPj4+ICsjZW5kaWbC
oCAvKiBfX1MzOTBfQVNNX1VWREVWSUNFX0ggKi8NCj4+DQo+PiBUaGVyZSBhcmUgdHdvIHNw
YWNlcyBiZXR3ZWVuIHRoZSAiZW5kaWYiIGFuZCB0aGUgIi8iDQo+Pg0KPj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3MzOTAvY2hhci9LY29uZmlnIGIvZHJpdmVycy9zMzkwL2NoYXIvS2Nv
bmZpZw0KPj4+IGluZGV4IDZjYzRiMTlhY2Y4NS4uZTliOTkwMmFiYmFmIDEwMDY0NA0KPj4+
IC0tLSBhL2RyaXZlcnMvczM5MC9jaGFyL0tjb25maWcNCj4+PiArKysgYi9kcml2ZXJzL3Mz
OTAvY2hhci9LY29uZmlnDQo+Pj4gQEAgLTEwMCw2ICsxMDAsMTYgQEAgY29uZmlnIFNDTFBf
T0ZCDQo+Pj4gIMKgwqDCoMKgwqDCoMKgIFRoaXMgb3B0aW9uIGVuYWJsZXMgdGhlIE9wZW4t
Zm9yLUJ1c2luZXNzIGludGVyZmFjZSB0byB0aGUgczM5MA0KPj4+ICDCoMKgwqDCoMKgwqDC
oCBTZXJ2aWNlIEVsZW1lbnQuDQo+PiBbLi4uXQ0KPj4+ICsgKiB1dmlvX2F0dGVzdGF0aW9u
KCkgZG9lcyBhwqAgUmV0cmlldmUgQXR0ZXN0YXRpb24gTWVhc3VyZW1lbnQNCj4+PiBVbHRy
YXZpc29yIENhbGwuDQo+Pg0KPj4gRG91YmxlIHNwYWNlDQo+Pg0KPj4+ICsgKiBJdCB2ZXJp
ZmllcyB0aGF0IHRoZSBnaXZlbiB1c2Vyc3BhY2UgYWRkcmVzc2VzIGFyZSB2YWxpZCBhbmQN
Cj4+PiByZXF1ZXN0IHNpemVzDQo+Pj4gKyAqIGFyZSBzYW5lLiBFdmVyeSBvdGhlciBjaGVj
ayBpcyBtYWRlIGJ5IHRoZSBVbHRyYXZpc29yIChVVikgYW5kDQo+Pj4gd29uJ3QgcmVzdWx0
DQo+Pj4gKyAqIGluIGEgbmVnYXRpdmUgcmV0dXJuIHZhbHVlLiBJdCBjb3BpZXMgdGhlIGlu
cHV0IHRvIGtlcm5lbHNwYWNlLA0KPj4+IGJ1aWxkcyB0aGUNCj4+PiArICogcmVxdWVzdCwg
c2VuZHMgdGhlIFVWLWNhbGwsIGFuZCBjb3BpZXMgdGhlIHJlc3VsdCB0byB1c2Vyc3BhY2Uu
DQo+Pj4gKyAqDQo+Pg0KDQo=
