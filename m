Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F162AE8A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Nov 2020 07:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgKKGL4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Nov 2020 01:11:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18258 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725468AbgKKGL4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Nov 2020 01:11:56 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AB62Uu5172817;
        Wed, 11 Nov 2020 01:11:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=6ci14bMJqkzkgZzYTMvgyWJGvo3as75QRlIc4ZDxb30=;
 b=KZF6d3+AR1pM9icpEd7dsHZm/AyKi/wyrqxHYv+KESVKIrUXHHXbC6tPeiUe0VXHrj3x
 m2u4u79h88p1QqCWOOU6GEtzuwN9p4zLNxfSTdZoInmKLkIC26wKXllTa16gmNZbjd2/
 RBY6sIF/kuRtvaZD/TdnqAYSK06vdl+8IqCFdX2BeUG4TEGT9NjJ71Y/QlRbEOrsdZ9v
 LwYAUP5y0e7Y1gYhJdjtQVI3TlOMhCbJVXyr/QGC4oxfD7osIWemEsE8Q7+2E2lkaTo7
 hzQMXDWp561YsdMTWTT1qOj8BNrY7LHCslNdUFPbRJ3WIWvKhFZgVofipaFilB4tkxYa tQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34qgydd1pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Nov 2020 01:11:49 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AB67Y2d010558;
        Wed, 11 Nov 2020 06:11:47 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 34p26pk7k7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Nov 2020 06:11:47 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AB6Bi0W1376782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Nov 2020 06:11:44 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C833BA4066;
        Wed, 11 Nov 2020 06:11:44 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21F9AA405C;
        Wed, 11 Nov 2020 06:11:43 +0000 (GMT)
Received: from [9.199.52.146] (unknown [9.199.52.146])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 11 Nov 2020 06:11:42 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
Subject: Re: [PATCH V2] selftests/cgroup: Fix build on older distros
From:   Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <50cb30c4-8e8d-7ba0-d429-3f1da4ad1f0b@linuxfoundation.org>
Date:   Wed, 11 Nov 2020 11:41:41 +0530
Cc:     Michael Ellerman <michael@ellerman.id.au>,
        linux-kselftest@vger.kernel.org, christian@brauner.io,
        linux-kernel@vger.kernel.org, keescook@chromium.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A30EBA15-D8DC-4F6B-9FF3-5E6A1BAB9500@linux.vnet.ibm.com>
References: <160464840151.97255.15344214064240834294.sendpatchset@MacBook-Pro.local>
 <50cb30c4-8e8d-7ba0-d429-3f1da4ad1f0b@linuxfoundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: Apple Mail (2.3445.104.17)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-11_01:2020-11-10,2020-11-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011110028
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On 11-Nov-2020, at 3:45 AM, Shuah Khan <skhan@linuxfoundation.org> =
wrote:
>=20
> On 11/6/20 12:40 AM, Sachin Sant wrote:
>> ---
>> V2: Replace all instances of clone_args by __clone_args
>> ---
>> diff --git a/a/tools/testing/selftests/cgroup/cgroup_util.c =
b/b/tools/testing/selftests/cgroup/cgroup_util.c
>> index 05853b0..0270146 100644
>> --- a/a/tools/testing/selftests/cgroup/cgroup_util.c
>> +++ b/b/tools/testing/selftests/cgroup/cgroup_util.c
>=20
> Not sure how you generated the patch. I had to use git am -p2
>=20
Sorry about that. Not sure what happened. Thanks.

-Sachin
