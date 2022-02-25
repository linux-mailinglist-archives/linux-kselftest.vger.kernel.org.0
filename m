Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7604C50CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 22:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbiBYVim (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 16:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiBYVil (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 16:38:41 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8ACD793A6
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 13:38:06 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-282-rsTMIwefMfiHyc_im_tfFA-1; Fri, 25 Feb 2022 21:38:03 +0000
X-MC-Unique: rsTMIwefMfiHyc_im_tfFA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Fri, 25 Feb 2022 21:38:01 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Fri, 25 Feb 2022 21:38:01 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Guillaume Tucker' <guillaume.tucker@collabora.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] selftests, x86: fix how check_cc.sh is being invoked
Thread-Topic: [PATCH] selftests, x86: fix how check_cc.sh is being invoked
Thread-Index: AQHYKniHz+vlDNOxwkeP2MprKgi3dqykyk5A
Date:   Fri, 25 Feb 2022 21:38:01 +0000
Message-ID: <006c160c1e0240df8a86cc679b2a6678@AcuMS.aculab.com>
References: <9320d88a3a65350d9bfdc5e258742cd0b162f017.1645794882.git.guillaume.tucker@collabora.com>
 <8e88488b-1666-ce1b-6d79-7c6758672ac0@collabora.com>
In-Reply-To: <8e88488b-1666-ce1b-6d79-7c6758672ac0@collabora.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

RnJvbTogR3VpbGxhdW1lIFR1Y2tlcg0KPiBTZW50OiAyNSBGZWJydWFyeSAyMDIyIDE4OjUwDQou
Li4NCj4gPiAtaWYgIiRDQyIgLW8gL2Rldi9udWxsICIkVEVTVFBST0ciIC1PMCAiJEAiIDI+L2Rl
di9udWxsOyB0aGVuDQo+ID4gK2lmICRDQyAtbyAvZGV2L251bGwgIiRURVNUUFJPRyIgLU8wICIk
QCIgMj4vZGV2L251bGw7IHRoZW4NCj4gPiAgICAgIGVjaG8gMQ0KPiA+ICBlbHNlDQo+ID4gICAg
ICBlY2hvIDANCj4gDQo+IEkgc2VlIHRoZSBjaGFuZ2UgaW4gY2hlY2tfY2Muc2ggaXMgYWxyZWFk
eSBjb3ZlcmVkIGJ5IFVzYW1hJ3MgcGF0Y2g6DQo+IA0KPiAgIHNlbGZ0ZXN0cy94ODY6IEFkZCB2
YWxpZGl0eSBjaGVjayBhbmQgYWxsb3cgZmllbGQgc3BsaXR0aW5nDQo+IA0KPiAtaWYgIiRDQyIg
LW8gL2Rldi9udWxsICIkVEVTVFBST0ciIC1PMCAiJEAiIDI+L2Rldi9udWxsOyB0aGVuDQo+ICtp
ZiBbIC1uICIkQ0MiIF0gJiYgJENDIC1vIC9kZXYvbnVsbCAiJFRFU1RQUk9HIiAtTzAgIiRAIiAy
Pi9kZXYvbnVsbDsgdGhlbg0KDQpPcjoNCglpZiAke0NDOi1mYWxzZX0gLW8gL2Rldi9udWxsIC4u
Li4NClRoZXJlJ3MgYWx3YXlzIG9uZSBtb3JlIHdheS4uLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0
ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBL
ZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

