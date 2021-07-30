Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8853DBA87
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jul 2021 16:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239108AbhG3OZF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Jul 2021 10:25:05 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3543 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239691AbhG3OY6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Jul 2021 10:24:58 -0400
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Gbq9c47xbz6L9kH;
        Fri, 30 Jul 2021 22:12:52 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 30 Jul 2021 16:24:51 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Fri, 30 Jul 2021 16:24:51 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>
Subject: RE: [RFC][PATCH v2 06/12] diglim: Interfaces - digest_list_add,
 digest_list_del
Thread-Topic: [RFC][PATCH v2 06/12] diglim: Interfaces - digest_list_add,
 digest_list_del
Thread-Index: AQHXgjzPxJ6WuoGgH0KyG3D/y7w0xqtaWSsAgADBDpCAAD+ygIAAIhjQ///1QYCAACKD8A==
Date:   Fri, 30 Jul 2021 14:24:51 +0000
Message-ID: <bd0787e0ee4f47baa41abf47976e536c@huawei.com>
References: <20210726163700.2092768-1-roberto.sassu@huawei.com>
         <20210726163700.2092768-7-roberto.sassu@huawei.com>
         <c9dffd9d29df095660beaa631ff252c4b33629a0.camel@linux.ibm.com>
         <ef7c85dcb096479e95c8c60ccda4d700@huawei.com>
         <1ef95096bee13578b3f906dd9f708c6af9d6ff18.camel@linux.ibm.com>
         <555bf01bee4b4ea7a9bee658366d535a@huawei.com>
 <2c731f07bd08f01f2a3e032814bc65ae9a8494ad.camel@linux.ibm.com>
In-Reply-To: <2c731f07bd08f01f2a3e032814bc65ae9a8494ad.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.221.98.153]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> Sent: Friday, July 30, 2021 4:03 PM
> Hi Roberto,
> 
> On Fri, 2021-07-30 at 13:16 +0000, Roberto Sassu wrote:
> > > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > > Sent: Friday, July 30, 2021 2:40 PM
> 
> > > "critical data", in this context, should probably be used for verifying
> > > the in memory file digests and other state information haven't been
> > > compromised.
> >
> > Actually, this is what we are doing currently. To keep the
> > implementation simple, once the file or the buffer are uploaded
> > to the kernel, they will not be modified, just accessed through
> > the indexes.
> 
> My main concern about digest lists is their integrity, from loading the
> digest lists to their being stored in memory.  A while back, there was
> some work on defining a write once memory allocator.  I don't recall
> whatever happened to it.  This would be a perfect usecase for that
> memory allocator.

Adding Igor in CC.

Regarding loading, everything uploaded to the kernel is carefully
evaluated. This should not be a concern. Regarding making them
read-only, probably if you can subvert digest lists you can also
remove the read-only protection (unless you use an hypervisor).

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

> thanks,
> 
> Mimi

