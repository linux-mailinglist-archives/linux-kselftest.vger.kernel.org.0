Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9DB281FDC
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Oct 2020 02:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbgJCAs4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 20:48:56 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:6834 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725283AbgJCAs4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 20:48:56 -0400
X-Greylist: delayed 4942 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Oct 2020 20:48:55 EDT
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 092NNn6u026132;
        Sat, 3 Oct 2020 00:25:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=jan2016.eng;
 bh=QkGqoqC57AUJwO3z6/p3ypBKSby7UUfX4Z/QC16CsrM=;
 b=kufoFTR1IjDsPgi+CLGpSP2IqkKL7HKcnqeKaAWRjcQgQA75iJs6BDJg6YPuqv+q2Nlb
 R++l+58+5i9AsF+9tf7WXjOZgZtjcxxNRqijyVJZsmOP/6FY2GqfZ3Kob5cjUf/dXCQO
 77IfRCch6Hpw/5tjF6ZLeu+Q92Ap9JG3L1Z7JHRH88ikq70/vvdx4uIAO4aLKRLyDbF4
 O6Y61abD0mprQbEuEjgjF/mf7KsSijuf9hPJ6YRt5hwBsBbrO5zF1N65aUrnlWQqeky3
 lm2zFO5jayEgLk+2dnAOeqfKJxTwx/raQ2L098YP/wUUH23GVpWa6xBkch60Mkb0+sOA 0w== 
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60] (may be forged))
        by mx0a-00190b01.pphosted.com with ESMTP id 33svwjvheg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 03 Oct 2020 00:25:27 +0100
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
        by prod-mail-ppoint5.akamai.com (8.16.0.42/8.16.0.42) with SMTP id 092N23PV009413;
        Fri, 2 Oct 2020 16:25:26 -0700
Received: from email.msg.corp.akamai.com ([172.27.123.30])
        by prod-mail-ppoint5.akamai.com with ESMTP id 33t3mb359m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 02 Oct 2020 16:25:26 -0700
Received: from usma1ex-dag1mb6.msg.corp.akamai.com (172.27.123.65) by
 usma1ex-dag1mb2.msg.corp.akamai.com (172.27.123.102) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Fri, 2 Oct 2020 19:25:25 -0400
Received: from usma1ex-dag1mb6.msg.corp.akamai.com ([172.27.123.65]) by
 usma1ex-dag1mb6.msg.corp.akamai.com ([172.27.123.65]) with mapi id
 15.00.1497.006; Fri, 2 Oct 2020 19:25:25 -0400
From:   "Jayaramappa, Srilakshmi" <sjayaram@akamai.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>
CC:     Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 1/1] selftests/vm: 8x compaction_test speedup
Thread-Topic: [PATCH 1/1] selftests/vm: 8x compaction_test speedup
Thread-Index: AQHWmQghQfWhsaODLEKsEX7Nj7R8+6mE9IyA
Date:   Fri, 2 Oct 2020 23:25:25 +0000
Message-ID: <050F889A-AE47-47E4-8334-0D6FC7170721@akamai.com>
References: <20201002080621.551044-1-jhubbard@nvidia.com>
 <20201002080621.551044-2-jhubbard@nvidia.com>
 <20201002150520.2ea3db53d88f8d10ba8348c9@linux-foundation.org>
In-Reply-To: <20201002150520.2ea3db53d88f8d10ba8348c9@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.41.20091302
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.19.112.71]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AFFAE2D00926F479C7BED904B92EF2D@akamai.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-02_14:2020-10-02,2020-10-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=791 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010020174
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-02_14:2020-10-02,2020-10-02 signatures=0
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQrvu79PbiAxMC8yLzIwLCA2OjA1IFBNLCAiQW5kcmV3IE1vcnRvbiIgPGFrcG1AbGludXgtZm91
bmRhdGlvbi5vcmc+IHdyb3RlOg0KDQogICAgT24gRnJpLCAyIE9jdCAyMDIwIDAxOjA2OjIxIC0w
NzAwIEpvaG4gSHViYmFyZCA8amh1YmJhcmRAbnZpZGlhLmNvbT4gd3JvdGU6DQoNCiAgICA+IFRo
aXMgcGF0Y2ggcmVkdWNlcyB0aGUgcnVubmluZyB0aW1lIGZvciBjb21wYWN0aW9uX3Rlc3QgZnJv
bSBhYm91dCAyNw0KICAgID4gc2VjLCB0byAzLjMgc2VjLCB3aGljaCBpcyBhYm91dCBhbiA4eCBz
cGVlZHVwLg0KICAgID4gDQogICAgPiBUaGVzZSBudW1iZXJzIGFyZSBmb3IgYW4gSW50ZWwgeDg2
XzY0IHN5c3RlbSB3aXRoIDMyIEdCIG9mIERSQU0uDQogICAgPiANCiAgICA+IFRoZSBjb21wYWN0
aW9uX3Rlc3QuYyBwcm9ncmFtIHdhcyBzcGVuZGluZyBtb3N0IG9mIGl0cyB0aW1lIGRvaW5nDQog
ICAgPiBtbWFwKCksIDEgTUIgYXQgYSB0aW1lLCBvbiBhYm91dCAyNSBHQiBvZiBtZW1vcnkuDQog
ICAgPiANCiAgICA+IEluc3RlYWQsIGRvIHRoZSBtbWFwcyAxMDAgTUIgYXQgYSB0aW1lLiAoR29p
bmcgcGFzdCAxMDAgTUIgZG9lc24ndCBtYWtlDQogICAgPiB0aGluZ3MgZ28gbXVjaCBmYXN0ZXIs
IGJlY2F1c2Ugb3RoZXIgcGFydHMgb2YgdGhlIHByb2dyYW0gYXJlIHVzaW5nIHRoZQ0KICAgID4g
cmVtYWluaW5nIHRpbWUuKQ0KDQogICAgU2VlbXMgbmljZS4gIEl0J3MgYmVlbiA1IHllYXJzLCBi
dXQgaG9wZWZ1bGx5IFNyaSBpcyBzdGlsbCBhdCBBa2FtYWk/DQoNCiAgICBMb29rcyBnb29kIHRv
IG1lLg0KDQogICAgVGhhbmtzDQogICAgLVNyaQ0KDQoNCg==
