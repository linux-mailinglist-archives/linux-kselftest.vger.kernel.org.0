Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00B0C11D483
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2019 18:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbfLLRtc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Dec 2019 12:49:32 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53738 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbfLLRtc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Dec 2019 12:49:32 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCHijtl032917;
        Thu, 12 Dec 2019 17:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=209O+3Xe8wnGXL8s/3e5RLbnSLi6zch/ZA2bLBFzw5k=;
 b=D9Ypnds+tQTjBQGTQIEeJCcGvTNeF9gbB0luV0hEZsxC6+/RwzXtgkkbWvWUPmInuihf
 7b2NNY071RtRuhyE7nERl7VUh8eMzxFg6Lpa4oRd5MxuE4BW/tTSP9Z4ku2//O0qmI17
 8I3rqYbDY8USDlsxSFsypeDczQV/nf0RlNqmMBnVoqC/iUNozGASW5kTFpe1L079/K0R
 Mz8PsfX0HvRVrvioXCUM4ibgk6rXBboq69ebCwSYwUYv5lp+ZO7DEoIcbmCe/Ll//4rS
 2YSwr0OXT+iRa/umdy6P5bw6arI3aPtFHdrOBt/sOyenQcs//VZk5HYRt/9WDn8nhu2Z 3A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wrw4nhe5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 17:48:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCHhg0D177364;
        Thu, 12 Dec 2019 17:48:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2wumw0nwp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 17:48:00 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBCHm0EX022395;
        Thu, 12 Dec 2019 17:48:00 GMT
Received: from [192.168.14.112] (/109.65.223.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Dec 2019 09:47:59 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH v4 11/19] x86/cpu: Print VMX flags in /proc/cpuinfo using
 VMX_FEATURES_*
From:   Liran Alon <liran.alon@oracle.com>
In-Reply-To: <20191212174357.GE3163@linux.intel.com>
Date:   Thu, 12 Dec 2019 19:47:51 +0200
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
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
Message-Id: <407604A2-354E-4358-91EC-E04A57F506C1@oracle.com>
References: <20191128014016.4389-1-sean.j.christopherson@intel.com>
 <20191128014016.4389-12-sean.j.christopherson@intel.com>
 <20191212122646.GE4991@zn.tnic>
 <d0b21e7e-69f5-09f9-3e1c-14d49fa42b9f@redhat.com>
 <4A24DE75-4E68-4EC6-B3F3-4ACB0EE82BF0@oracle.com>
 <17c6569e-d0af-539c-6d63-f4c07367d8d1@redhat.com>
 <20191212174357.GE3163@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=601
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912120139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=668 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912120139
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On 12 Dec 2019, at 19:43, Sean Christopherson =
<sean.j.christopherson@intel.com> wrote:
>=20
> On Thu, Dec 12, 2019 at 04:57:10PM +0100, Paolo Bonzini wrote:
>> On 12/12/19 16:52, Liran Alon wrote:
>>>>> virt_apic_accesses	-> vapic
>>>> apicv
>>> Frankly, I dislike APICv terminology. I prefer to enumerate the
>>> various VMX features which are collectively called APICv by KVM.=20
>>> APICv currently represents in KVM terminology the combination of
>>> APIC-register virtualization, virtual-interrupt-delivery and
>>> posted-interrupts (See cpu_has_vmx_apicv()).
>>>=20
>>> In fact, the coupling of =E2=80=9Cenable_apicv=E2=80=9D module =
parameter have made me
>>> multiple times to need to disable entire APICv features when there
>>> for example was only a bug in posted-interrupts.
>>>=20
>>> Even you got confused as virtualize-apic-access is not part of =
KVM=E2=80=99s
>>> APICv terminology but rather it=E2=80=99s enablement depend on
>>> flexpriority_enabled (See cpu_need_virtualize_apic_accesses()). i.e.
>>> It can be used for faster intercept handling of accesses to guest
>>> xAPIC MMIO page.
>>=20
>> Right, I got confused with APIC-register virtualization.  Virtualize
>> APIC accesses is another one I wouldn't bother putting in =
/proc/cpuinfo,
>> since it's usually present together with flexpriority.
>=20
> Key word being "usually".  My intent in printing out partially =
redundant
> flags was to help users debug/understand why the combined feature =
isn't
> supported.  E.g. userspace can already easily (relatively speaking) =
query
> flexpriority support via =
/sys/module/kvm_intel/parameters/flexpriority.
> But if that comes back "N", the user has no way to determine exactly =
why
> flexpriority is disabled.

+1 on that.

/proc/cpuinfo should just dump supported VMX features that kernel is =
aware of as exposed from CPU.
Without further processing.

