Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8070C11D4E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2019 19:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbfLLSHO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Dec 2019 13:07:14 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:49638 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730082AbfLLSHO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Dec 2019 13:07:14 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCHn5xg022218;
        Thu, 12 Dec 2019 18:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=6nE9TIG7gNozX0c5JrZbeLjKkq4aQbbrTaX/7iiac6M=;
 b=QoHqsVEgjltKrKrKhFjzmk9Zn/ASebnNcXuELwwEQ/5cS9mmVSmps2rX7hNKBuX6pXMT
 sdm52YxuW5sfixN5za1MBMEg4vDiUE7Ym7hbqI5IRT43WbebTKsJ9n0AxIBczDbozi9o
 25fjX4Es42jQ+8e+O/zXdxDvS78UjmxyO0C9iMChc/hEBLLSXsOUyQlwpdvQcjjTNDLu
 BmMHZPmMADobfwXrXMVsBhCx9Wmch2cHttWSr4ZuY50Y3L+3Xkh7gwQrC/nRPzeQEBZ0
 OylEEo/4AeVjb9eIjVz/2atdPhT3gHhIU63AWXR+laKZYf27RZgzk0Fzi3vuOfQLYdZ0 uA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wr41qmpbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 18:04:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCHnNUj192570;
        Thu, 12 Dec 2019 18:04:32 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2wumw0r9f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 18:04:32 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBCI4SXO006421;
        Thu, 12 Dec 2019 18:04:28 GMT
Received: from [192.168.14.112] (/109.65.223.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Dec 2019 10:04:27 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH v4 11/19] x86/cpu: Print VMX flags in /proc/cpuinfo using
 VMX_FEATURES_*
From:   Liran Alon <liran.alon@oracle.com>
In-Reply-To: <CALMp9eRAYj=dKDtnPymkUA_OOMv+9a4WdPNt4hdpFtBgzwNA9w@mail.gmail.com>
Date:   Thu, 12 Dec 2019 20:04:19 +0200
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        Len Brown <lenb@kernel.org>, Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, linux-edac@vger.kernel.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EA5BE610-6E9C-4357-AD62-5678C7E81043@oracle.com>
References: <20191128014016.4389-1-sean.j.christopherson@intel.com>
 <20191128014016.4389-12-sean.j.christopherson@intel.com>
 <20191212122646.GE4991@zn.tnic>
 <d0b21e7e-69f5-09f9-3e1c-14d49fa42b9f@redhat.com>
 <4A24DE75-4E68-4EC6-B3F3-4ACB0EE82BF0@oracle.com>
 <17c6569e-d0af-539c-6d63-f4c07367d8d1@redhat.com>
 <20191212174357.GE3163@linux.intel.com>
 <52dd758d-a590-52a6-4248-22d6852b75cd@redhat.com>
 <DA429131-7A4C-4B74-A020-6CE7622ED2F8@oracle.com>
 <CALMp9eRAYj=dKDtnPymkUA_OOMv+9a4WdPNt4hdpFtBgzwNA9w@mail.gmail.com>
To:     Jim Mattson <jmattson@google.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=869
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912120140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=926 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912120140
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On 12 Dec 2019, at 19:57, Jim Mattson <jmattson@google.com> wrote:
>=20
> On Thu, Dec 12, 2019 at 9:53 AM Liran Alon <liran.alon@oracle.com> =
wrote:
>=20
>> Why should CPU VMX features be treated differently than standard =
CPUID deduced features?
>=20
> Do we have the right Intel people on the recipient list to answer this
> question? Presumably, Intel felt that this information should be
> available in supervisor mode only.
>=20
> Sean?

Good question. Probably because it just makes sense that Ring3 will =
never need to use
this info as all VMX instructions are privileged. i.e. Can only be =
executed in Ring0.

De-facto in KVM we have discovered this assumption to be problematic =
BTW,
as KVM created an interface to query VMX MSRs values to properly define =
the requested
vCPU model. :P (See kvm_get_msr_feature())


