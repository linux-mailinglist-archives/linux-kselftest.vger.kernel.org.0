Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A862167CB93
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jan 2023 14:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbjAZNCr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Jan 2023 08:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236427AbjAZNC3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Jan 2023 08:02:29 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC705303F8;
        Thu, 26 Jan 2023 05:02:27 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QCEADD016641;
        Thu, 26 Jan 2023 13:02:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : references : from : subject : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Y0XHlamc8W9iTYVKRLyokS5DKfydwfgcjM1o2yxc59E=;
 b=TR3cFUL3X1PYSP9A9eC+MXtSaVZOgOh/gVK7qN4Rb2BC18z49Ohtk0sQuBUL/GaaXC4l
 9vtJY1xE+CaSaHJHZAU5J6/5xml0XAN81ZU7xq6PFy+iRYsTpe9HvLTXFshzu3kiJ4TA
 xWceuIOvOWkz59RvQFQKGmNiHTGWk/9C3Aw+2ZPbKMKPetlbs43I8qe2pKLILXkIffxo
 rFehNK9O8hh4VQ1UByMLimTrNG05eoHO3TRAwgnWoBEX4O06LFYl+O4JWoNd3ZjvSs1b
 3GZzVoedvH54E0Mx0sKzcCoCjQFG7Z9JSarAr3eS7fcim8tSlWK4t6YhjWr9OZkbfSji YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nbsbe127h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 13:02:22 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30QD2LIK002790;
        Thu, 26 Jan 2023 13:02:21 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nbsbe126q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 13:02:21 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30QA1LVW026749;
        Thu, 26 Jan 2023 13:02:19 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3n87p6ee0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 13:02:19 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30QD2FfV39387530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 13:02:15 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A09592004D;
        Thu, 26 Jan 2023 13:02:15 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 659222004B;
        Thu, 26 Jan 2023 13:02:15 +0000 (GMT)
Received: from [9.152.224.253] (unknown [9.152.224.253])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 26 Jan 2023 13:02:15 +0000 (GMT)
Message-ID: <dbd8204a-5413-b593-7ede-1c5ea7ee4425@linux.ibm.com>
Date:   Thu, 26 Jan 2023 14:02:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Thomas Huth <thuth@redhat.com>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20230125212608.1860251-1-scgl@linux.ibm.com>
 <20230125212608.1860251-9-scgl@linux.ibm.com>
 <a1141cf5-8c44-5e9e-688c-c9dab3ebe8d4@redhat.com>
From:   Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v6 08/14] KVM: s390: Move common code of mem_op functions
 into functions
In-Reply-To: <a1141cf5-8c44-5e9e-688c-c9dab3ebe8d4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 65Cuw01j-u-E_WQ7VB6xxeQ2zRLFgVbH
X-Proofpoint-GUID: 4LUlyiOQvsnwR2_IGxlKStM4Xv1ak8TN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_04,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 clxscore=1015 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260121
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gMS8yNi8yMyAwNzo0OCwgVGhvbWFzIEh1dGggd3JvdGU6DQo+IE9uIDI1LzAxLzIwMjMg
MjIuMjYsIEphbmlzIFNjaG9ldHRlcmwtR2xhdXNjaCB3cm90ZToNCj4+IFRoZSB2Y3B1IGFu
ZCB2bSBtZW1fb3AgaW9jdGwgaW1wbGVtZW50YXRpb25zIHNoYXJlIHNvbWUgZnVuY3Rpb25h
bGl0eS4NCj4+IE1vdmUgYXJndW1lbnQgY2hlY2tpbmcgYW5kIGJ1ZmZlciBhbGxvY2F0aW9u
IGludG8gZnVuY3Rpb25zIGFuZCBjYWxsDQo+PiB0aGVtIGZyb20gYm90aCBpbXBsZW1lbnRh
dGlvbnMuDQo+PiBUaGlzIGFsbG93cyBjb2RlIHJldXNlIGluIGNhc2Ugb2YgYWRkaXRpb25h
bCBmdXR1cmUgbWVtX29wIG9wZXJhdGlvbnMuDQo+Pg0KPj4gU3VnZ2VzdGVkLWJ5OiBKYW5v
c2NoIEZyYW5rIDxmcmFua2phQGxpbnV4LmlibS5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBK
YW5pcyBTY2hvZXR0ZXJsLUdsYXVzY2ggPHNjZ2xAbGludXguaWJtLmNvbT4NCj4+IC0tLQ0K
Pj4gICAgYXJjaC9zMzkwL2t2bS9rdm0tczM5MC5jIHwgODAgKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gICAgMSBmaWxlIGNoYW5nZWQsIDQyIGluc2Vy
dGlvbnMoKyksIDM4IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL3Mz
OTAva3ZtL2t2bS1zMzkwLmMgYi9hcmNoL3MzOTAva3ZtL2t2bS1zMzkwLmMNCj4+IGluZGV4
IGU0ODkwZTA0YjIxMC4uZTBkZmFhMTk1OTQ5IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9zMzkw
L2t2bS9rdm0tczM5MC5jDQo+PiArKysgYi9hcmNoL3MzOTAva3ZtL2t2bS1zMzkwLmMNCj4+
IEBAIC0yNzY0LDI0ICsyNzY0LDQ0IEBAIHN0YXRpYyBpbnQga3ZtX3MzOTBfaGFuZGxlX3B2
KHN0cnVjdCBrdm0gKmt2bSwgc3RydWN0IGt2bV9wdl9jbWQgKmNtZCkNCj4+ICAgIAlyZXR1
cm4gcjsNCj4+ICAgIH0NCj4+ICAgIA0KPj4gLXN0YXRpYyBib29sIGFjY2Vzc19rZXlfaW52
YWxpZCh1OCBhY2Nlc3Nfa2V5KQ0KPj4gK3N0YXRpYyBpbnQgbWVtX29wX3ZhbGlkYXRlX2Nv
bW1vbihzdHJ1Y3Qga3ZtX3MzOTBfbWVtX29wICptb3AsIHU2NCBzdXBwb3J0ZWRfZmxhZ3Mp
DQo+PiAgICB7DQo+PiAtCXJldHVybiBhY2Nlc3Nfa2V5ID4gMHhmOw0KPj4gKwlpZiAobW9w
LT5mbGFncyAmIH5zdXBwb3J0ZWRfZmxhZ3MgfHwgIW1vcC0+c2l6ZSkNCj4+ICsJCXJldHVy
biAtRUlOVkFMOw0KPj4gKwlpZiAobW9wLT5zaXplID4gTUVNX09QX01BWF9TSVpFKQ0KPj4g
KwkJcmV0dXJuIC1FMkJJRzsNCj4+ICsJaWYgKG1vcC0+ZmxhZ3MgJiBLVk1fUzM5MF9NRU1P
UF9GX1NLRVlfUFJPVEVDVElPTikgew0KPj4gKwkJaWYgKG1vcC0+a2V5ID4gMHhmKQ0KPj4g
KwkJCXJldHVybiAtRUlOVkFMOw0KPj4gKwl9IGVsc2Ugew0KPj4gKwkJbW9wLT5rZXkgPSAw
Ow0KPj4gKwl9DQo+PiArCXJldHVybiAwOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgdm9p
ZCAqbWVtX29wX2FsbG9jX2J1ZihzdHJ1Y3Qga3ZtX3MzOTBfbWVtX29wICptb3ApDQo+PiAr
ew0KPj4gKwl2b2lkICpidWY7DQo+PiArDQo+PiArCWlmIChtb3AtPmZsYWdzICYgS1ZNX1Mz
OTBfTUVNT1BfRl9DSEVDS19PTkxZKQ0KPj4gKwkJcmV0dXJuIE5VTEw7DQo+PiArCWJ1ZiA9
IHZtYWxsb2MobW9wLT5zaXplKTsNCj4+ICsJaWYgKCFidWYpDQo+PiArCQlyZXR1cm4gRVJS
X1BUUigtRU5PTUVNKTsNCj4+ICsJcmV0dXJuIGJ1ZjsNCj4+ICAgIH0NCj4+ICAgIA0KPj4g
ICAgc3RhdGljIGludCBrdm1fczM5MF92bV9tZW1fb3Aoc3RydWN0IGt2bSAqa3ZtLCBzdHJ1
Y3Qga3ZtX3MzOTBfbWVtX29wICptb3ApDQo+PiAgICB7DQo+PiAgICAJdm9pZCBfX3VzZXIg
KnVhZGRyID0gKHZvaWQgX191c2VyICopbW9wLT5idWY7DQo+PiAtCXU2NCBzdXBwb3J0ZWRf
ZmxhZ3M7DQo+PiAgICAJdm9pZCAqdG1wYnVmID0gTlVMTDsNCj4gDQo+IFlvdSBsaWtlbHkg
Y2FuIG5vdyByZW1vdmUgdGhlICI9IE5VTEwiIGhlcmUsIEkgZ3Vlc3M/DQo+IA0KPj4gICAg
CWludCByLCBzcmN1X2lkeDsNCj4+ICAgIA0KPj4gLQlzdXBwb3J0ZWRfZmxhZ3MgPSBLVk1f
UzM5MF9NRU1PUF9GX1NLRVlfUFJPVEVDVElPTg0KPj4gLQkJCSAgfCBLVk1fUzM5MF9NRU1P
UF9GX0NIRUNLX09OTFk7DQo+PiAtCWlmIChtb3AtPmZsYWdzICYgfnN1cHBvcnRlZF9mbGFn
cyB8fCAhbW9wLT5zaXplKQ0KPj4gLQkJcmV0dXJuIC1FSU5WQUw7DQo+PiAtCWlmIChtb3At
PnNpemUgPiBNRU1fT1BfTUFYX1NJWkUpDQo+PiAtCQlyZXR1cm4gLUUyQklHOw0KPj4gKwly
ID0gbWVtX29wX3ZhbGlkYXRlX2NvbW1vbihtb3AsIEtWTV9TMzkwX01FTU9QX0ZfU0tFWV9Q
Uk9URUNUSU9OIHwNCj4+ICsJCQkJCUtWTV9TMzkwX01FTU9QX0ZfQ0hFQ0tfT05MWSk7DQo+
PiArCWlmIChyKQ0KPj4gKwkJcmV0dXJuIHI7DQo+PiArDQo+PiAgICAJLyoNCj4+ICAgIAkg
KiBUaGlzIGlzIHRlY2huaWNhbGx5IGEgaGV1cmlzdGljIG9ubHksIGlmIHRoZSBrdm0tPmxv
Y2sgaXMgbm90DQo+PiAgICAJICogdGFrZW4sIGl0IGlzIG5vdCBndWFyYW50ZWVkIHRoYXQg
dGhlIHZtIGlzL3JlbWFpbnMgbm9uLXByb3RlY3RlZC4NCj4+IEBAIC0yNzkzLDE3ICsyODEz
LDkgQEAgc3RhdGljIGludCBrdm1fczM5MF92bV9tZW1fb3Aoc3RydWN0IGt2bSAqa3ZtLCBz
dHJ1Y3Qga3ZtX3MzOTBfbWVtX29wICptb3ApDQo+PiAgICAJICovDQo+PiAgICAJaWYgKGt2
bV9zMzkwX3B2X2dldF9oYW5kbGUoa3ZtKSkNCj4+ICAgIAkJcmV0dXJuIC1FSU5WQUw7DQo+
PiAtCWlmIChtb3AtPmZsYWdzICYgS1ZNX1MzOTBfTUVNT1BfRl9TS0VZX1BST1RFQ1RJT04p
IHsNCj4+IC0JCWlmIChhY2Nlc3Nfa2V5X2ludmFsaWQobW9wLT5rZXkpKQ0KPj4gLQkJCXJl
dHVybiAtRUlOVkFMOw0KPj4gLQl9IGVsc2Ugew0KPj4gLQkJbW9wLT5rZXkgPSAwOw0KPj4g
LQl9DQo+PiAtCWlmICghKG1vcC0+ZmxhZ3MgJiBLVk1fUzM5MF9NRU1PUF9GX0NIRUNLX09O
TFkpKSB7DQo+PiAtCQl0bXBidWYgPSB2bWFsbG9jKG1vcC0+c2l6ZSk7DQo+PiAtCQlpZiAo
IXRtcGJ1ZikNCj4+IC0JCQlyZXR1cm4gLUVOT01FTTsNCj4+IC0JfQ0KPj4gKwl0bXBidWYg
PSBtZW1fb3BfYWxsb2NfYnVmKG1vcCk7DQo+PiArCWlmIChJU19FUlIodG1wYnVmKSkNCj4+
ICsJCXJldHVybiBQVFJfRVJSKHRtcGJ1Zik7DQo+PiAgICANCj4+ICAgIAlzcmN1X2lkeCA9
IHNyY3VfcmVhZF9sb2NrKCZrdm0tPnNyY3UpOw0KPj4gICAgDQo+PiBAQCAtNTI1MCwyOCAr
NTI2MiwyMCBAQCBzdGF0aWMgbG9uZyBrdm1fczM5MF92Y3B1X21lbV9vcChzdHJ1Y3Qga3Zt
X3ZjcHUgKnZjcHUsDQo+PiAgICB7DQo+PiAgICAJdm9pZCBfX3VzZXIgKnVhZGRyID0gKHZv
aWQgX191c2VyICopbW9wLT5idWY7DQo+PiAgICAJdm9pZCAqdG1wYnVmID0gTlVMTDsNCj4g
DQo+IC4uLiBhbmQgaGVyZSwgdG9vLg0KPiANCj4gQnV0IEkgaGF2ZSB0byBhZG1pdCB0aGF0
IEknbSBhbHNvIG5vdCBzdXJlIHdoZXRoZXIgSSBsaWtlIHRoZQ0KPiBtZW1fb3BfYWxsb2Nf
YnVmKCkgcGFydCBvciBub3QgKHRoZSBtZW1fb3BfdmFsaWRhdGVfY29tbW9uKCkgcGFydCBs
b29rcyBmaW5lDQo+IHRvIG1lKSA6IG1lbV9vcF9hbGxvY19idWYoKSBpcyBhIG5ldyBmdW5j
dGlvbiB3aXRoIDExIGxpbmVzIG9mIGNvZGUsIGFuZCB0aGUNCj4gb2xkIHNwb3RzIHRoYXQg
YWxsb2NhdGUgbWVtb3J5IHdlcmUgb25seSA1IGxpbmVzIG9mIGNvZGUgZWFjaCwgc28geW91
IG5vdw0KPiBpbmNyZWFzZWQgdGhlIExvQyBjb3VudCBhbmQgYWRkaXRpb25hbGx5IGhhdmUg
dG8gZmlkZGx5IHdpdGggSVNfRVJSIGFuZA0KPiBQVFJfRVJSIHdoaWNoIGlzIGFsd2F5cyBh
IGxpdHRsZSBiaXQgdWdseSBpbiBteSBleWVzIC4uLiBJTUhPIEknZCByYXRoZXINCj4ga2Vl
cCB0aGUgb2xkIGNvZGUgaGVyZS4gQnV0IHRoYXQncyBqdXN0IG15IDAuMDIg4oKsLCBpZiB5
b3UgdGhpbmsgaXQncyBuaWNlcg0KPiB3aXRoIG1lbV9vcF9hbGxvY19idWYoKSwgSSB3b24n
dCBpbnNpc3Qgb24ga2VlcGluZyB0aGUgb2xkIGNvZGUuDQo+IA0KPiAgICBUaG9tYXMNCj4g
DQoNCkkndmUgZG9uZSBhIFBvQyB0aGF0IGhhcyBhICoqYnVmZiBhcmd1bWVudCBhbmQgY29t
YmluZXMgdGhlIGNoZWNrIHdpdGggDQp0aGUgYWxsb2MuDQoNCkBOaW5hOiBBbnkgcmVhc29u
IHdoeSB0aGlzIHdhcyBzcGxpdCB1cD8NCg==
