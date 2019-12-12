Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B715811D49E
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2019 18:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbfLLRzp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Dec 2019 12:55:45 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60758 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729883AbfLLRzo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Dec 2019 12:55:44 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCHnOgC036659;
        Thu, 12 Dec 2019 17:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=rST6ENnAdZRv2WqfQdDx44BDqgbldHjd9KZkDpog8vg=;
 b=PoQ6r/4MlKkROzkCpqTq0NDBXozpksln20zP8VQ6blzu9iHeDJKruy+x3umD1XycYmvi
 yf2ImrMIR8MUods+0erQvUY7M20550y6cw2ywE2Id9pFxTl7+ylCJLT0s0iHVSNCrX6c
 pbyhq+HpudLGtt3FbbebImclvqVQ1B31hQsYeO/kea2t2FsNJO5oHGhbxlThuVisSv7d
 fUbCXDUTrb+UD88/rZY8L0woWpTS6vSGkNf03eocltQHxEDThUd8waiDXHdVe5NOXyFx
 7GzxjAbMIKmd0UORZnoBsC14766PVtahXkWFPu5PSN9BwUJ0A/O2Vl7zSOcny+1N+bA9 0g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2wrw4nhf07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 17:53:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCHnQqW040983;
        Thu, 12 Dec 2019 17:53:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2wums9rkmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 17:53:08 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBCHr6R0025815;
        Thu, 12 Dec 2019 17:53:06 GMT
Received: from [192.168.14.112] (/109.65.223.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Dec 2019 09:53:06 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH v4 11/19] x86/cpu: Print VMX flags in /proc/cpuinfo using
 VMX_FEATURES_*
From:   Liran Alon <liran.alon@oracle.com>
In-Reply-To: <52dd758d-a590-52a6-4248-22d6852b75cd@redhat.com>
Date:   Thu, 12 Dec 2019 19:52:55 +0200
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
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
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        Len Brown <lenb@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DA429131-7A4C-4B74-A020-6CE7622ED2F8@oracle.com>
References: <20191128014016.4389-1-sean.j.christopherson@intel.com>
 <20191128014016.4389-12-sean.j.christopherson@intel.com>
 <20191212122646.GE4991@zn.tnic>
 <d0b21e7e-69f5-09f9-3e1c-14d49fa42b9f@redhat.com>
 <4A24DE75-4E68-4EC6-B3F3-4ACB0EE82BF0@oracle.com>
 <17c6569e-d0af-539c-6d63-f4c07367d8d1@redhat.com>
 <20191212174357.GE3163@linux.intel.com>
 <52dd758d-a590-52a6-4248-22d6852b75cd@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912120140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912120140
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On 12 Dec 2019, at 19:47, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 12/12/19 18:43, Sean Christopherson wrote:
>> Key word being "usually".  My intent in printing out partially =
redundant
>> flags was to help users debug/understand why the combined feature =
isn't
>> supported.  E.g. userspace can already easily (relatively speaking) =
query
>> flexpriority support via =
/sys/module/kvm_intel/parameters/flexpriority.
>> But if that comes back "N", the user has no way to determine exactly =
why
>> flexpriority is disabled.
>=20
> There are tools such as vmxcap.  It is part of QEMU, but I wouldn't =
mind
> moving it into the kernel tree.
>=20
> Paolo
>=20

True. But it relies on /dev/msr0 (exposed from msr kernel module) to be =
able to read any host arbitrary MSR.
It=E2=80=99s much more elegant to just report CPU VMX features in a =
/proc/cpuinfo pseudo-file and don=E2=80=99t require strong privileges.
Why should CPU VMX features be treated differently than standard CPUID =
deduced features?
CPU SVM features are also present in /proc/cpuinfo today (Because they =
are deduced from CPUID leafs). So it should be similar.

-Liran=
