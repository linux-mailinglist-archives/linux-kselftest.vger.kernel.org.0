Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723E750FD1C
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Apr 2022 14:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347308AbiDZMiN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Apr 2022 08:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349998AbiDZMiL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Apr 2022 08:38:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D1825A;
        Tue, 26 Apr 2022 05:35:03 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QCMi45020635;
        Tue, 26 Apr 2022 12:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=8fM+Z11fHvZYwZf6gdpIbKeSaYf1czjOyT5gU7GuPaU=;
 b=rxIfZXec0+eguTy9kRc2COrhbUGVdzoomKKATjM2A5Pl3G2ZrWhu5RWfu0lzrX1eMseJ
 8YrgOfL0k3nzfnJad1avYsd4o41Xkh4oSAHyBRwKJ6ODPpvP4N+sK/aEKBDCYs2NgeIB
 tRYaVKs0aTGVJWefYsaq2MYWq+nEZoaaKkVYdP+NE0j1soaJTu5v9NTZdxgg1hJxK4wO
 88X/LNOmXpbEYDuYxYlRWFL2dNCx1ibTVgbilhxJyviDavJZrhh56sBEVUpYYxGQFCdp
 +SdpiGIeA+RB1I7rp1c9fwEiDak4ejZ7H4Eah0hfCFNkulm9rUotd1Aw9ZK53wsZwGAO 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpbrbejcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 12:35:00 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23QCWnHE008282;
        Tue, 26 Apr 2022 12:34:59 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpbrbejc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 12:34:59 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23QCT4DG025188;
        Tue, 26 Apr 2022 12:34:57 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3fm938vcsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 12:34:57 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23QCYskr3801434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 12:34:54 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FFE04C040;
        Tue, 26 Apr 2022 12:34:54 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E203B4C046;
        Tue, 26 Apr 2022 12:34:53 +0000 (GMT)
Received: from [9.145.2.160] (unknown [9.145.2.160])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Apr 2022 12:34:53 +0000 (GMT)
Message-ID: <b6727a68-5918-c13d-d75c-2ea3f1a2469d@linux.ibm.com>
Date:   Tue, 26 Apr 2022 14:34:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/2] Dirtying, failing memop: don't indicate
 suppression
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20220425100147.1755340-1-scgl@linux.ibm.com>
 <8095d0de-dd99-0388-b1d4-e59b01dc4be0@linux.ibm.com>
 <13d0d706-abc4-3e4d-88c3-6447636fd1fd@linux.ibm.com>
 <1ccb1333-2233-8832-4102-a6c082b29108@linux.ibm.com>
 <40038a9a-5647-c355-bad2-297b0a2baf4f@linux.ibm.com>
 <80ca4468-6b0a-e8d9-9922-1fae2a1f0fcc@linux.ibm.com>
From:   Janosch Frank <frankja@linux.ibm.com>
In-Reply-To: <80ca4468-6b0a-e8d9-9922-1fae2a1f0fcc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: R38Fzu8Q8zOIqBOVDgHVgTNdO6EbnbhV
X-Proofpoint-ORIG-GUID: NBlS-Q0iTBKBZ5zFnvAoicAtpb5vTP-5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_02,2022-04-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=588
 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015 spamscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260080
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Wy4uLl0NCj4+Pg0KPj4+IFRoZSBvbmx5IHF1ZXN0aW9uIGlzLCBkbyB3ZSBuZWVkIHRvIGNo
YW5nZSB0aGUgc3VwcHJlc3Npb24gcGFyYW1ldGVyIGluDQo+Pj4gYWNjZXNzX2d1ZXN0X3dp
dGhfa2V5DQo+Pj4NCj4+PiAgwqDCoCAobW9kZSAhPSBHQUNDX1NUT1JFKSB8fCAoaWR4ID09
IDApDQo+Pj4NCj4+PiB0byBhbHNvIGNoZWNrIGZvciBwcm90ICE9IFBST1RfVFlQRV9LRVlD
DQo+Pj4gPyBJIHRoaW5rIHdlIGRvIG5vdCBuZWVkIHRoaXMgYXMgd2UgaGF2ZSBjaGVja2Vk
IG90aGVyIHJlYXNvbnMgYmVmb3JlLg0KPiANCj4gWWVzLCBpdCBpcyBub3QgbmVjZXNzYXJ5
LCB0aGUgY29udHJvbCBmbG93IGlzIHN1Y2ggdGhhdCBhIHByb3RlY3Rpb24gZXhjZXB0aW9u
DQo+IGltcGxpZXMgdGhhdCBpcyBkdWUgdG8ga2V5cy4NCj4+DQo+PiBUbyBtZSB0aGlzIG1l
YXN1cmUgbG9va3MgbGlrZSBhIGxhc3QgcmVzb3J0IG9wdGlvbiBhbmQgdGhlIFBPUCBkb2Vz
bid0IHN0YXRlIGEgMTAwJSB3aGF0IGlzIHRvIGJlIGRvbmUuIFNvbWUgaW5zdHJ1Y3Rpb25z
IGNhbiBtYW5kYXRlIHN1cHByZXNzaW9uIGluc3RlYWQgb2YgdGVybWluYXRpb24gYWNjb3Jk
aW5nIHRvIHRoZSBhcmNoaXRlY3RzLg0KPj4NCj4+IE15IGludHVpdGlvbiB0ZWxscyBtZSB0
aGF0IGlmIHdlIGFyZSBpbiBhIHNpdHVhdGlvbiB3aGVyZSB0aGlzIHdvdWxkIGhhcHBlbiB0
aGVuIHdlIHdvdWxkIGJlIG11Y2ggYmV0dGVyIG9mZiBqdXN0IGRvaW5nIGl0IGJ5IGhhbmQg
KGkuZS4gaW4gdGhlIGluc3RydWN0aW9uIGVtdWxhdGlvbiBjb2RlKSBhbmQgbm90IGxldHRp
bmcgdGhpcyBmdW5jdGlvbiBkZWNpZGUuDQo+IA0KPiBGb3IgdGhlIGluc3RydWN0aW9ucyB3
ZSBjdXJyZW50bHkgbmVlZCB0byBlbXVsYXRlIGluIEtWTSB3ZSBzaG91bGQgYmUgZmluZS4N
Cj4gU28gdGhlIHF1ZXN0aW9uIGlzIHdoYXQncyBiZXN0IGZvciB0aGUgZnV0dXJlIGFuZCBm
b3IgaW5zdHJ1Y3Rpb25zIGVtdWxhdGVkIGJ5IHVzZXIgc3BhY2UuDQo+IFVwd2FyZCBpbiB0
aGUgY2FsbCBzdGFjayAoaW5jbHVkaW5nIHVzZXIgc3BhY2UpLCB3ZSBkb24ndCBrbm93IHRo
ZSBmYWlsaW5nIGFkZHJlc3MsDQo+IHdoaWNoIGNvbXBsaWNhdGVzIGhhbmRsaW5nIGl0IGlu
IHRoZSBlbXVsYXRpb24gY29kZS4NCj4gWW91IGNvdWxkIGNob3AgdXAgdGhlIG1lbW9wIGlu
IHBhZ2UgY2h1bmtzIHRvIGZpbmQgb3V0LCBidXQgdGhhdCBtaWdodCBoYXZlIG90aGVyIGlz
c3Vlcy4NCj4gDQo+IFNpbmNlIHRoaXMgYmVoYXZpb3IgaXMgdmVyeSBpbXBsaWNpdCBhbmQg
ZWFzeSB0byBvdmVybG9vayBtYXliZSB3ZSBzaG91bGQgZG9jdW1lbnQgaXQNCj4gaW4gdGhl
IGRlc2NyaXB0aW9uIG9mIHRoZSBtZW1vcCBpb2N0bD8NCg0KWWVhaCwgcHJvcGVybHkgZG9j
dW1lbnRpbmcgdGhpcyBpcyB0aGUgbGVhc3Qgd2UgY2FuIGRvLg0K
