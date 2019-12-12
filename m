Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B58911D188
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2019 16:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbfLLPyV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Dec 2019 10:54:21 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43810 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbfLLPyU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Dec 2019 10:54:20 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCFnTus110391;
        Thu, 12 Dec 2019 15:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=Xn0flDReye6aR5I2+sBndrykdJvUw4tnWd/w/4iOE8I=;
 b=UvraykOmy/BoiCbihwwgJ9btFSG162/cAbspyKksvLqIfIz0sm/fcwN/Gh1TU8kKyEUj
 +khYN0y5CXpHVcYEjqXaSIei8vQ1QgWIWCpgwC1ikZDB8Pha17oHp0GKxmz/UfTGG2W7
 wh3T0gzDIKcrgo1Ge2TS5UL0ec2RBxiWz8xGDixlkp9tDVfocrwpeC8lOHwGD0fd+njU
 dadP0SS6RDLhOsTe/H0rlNOsTA8V3VmSkw2jkHRcYtF8NpqSesV5uk8r3rkQA2G1ocjb
 hg0SYIEQ87hRJEKJKvT4CSDqTnJZSkk1QSJ5GJ4xsT1EFly2YdF5V5A4etvD6eKpJWR7 IQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2wr41qkw18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 15:52:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCFnQJW135560;
        Thu, 12 Dec 2019 15:52:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2wumk6cv32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 15:52:28 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBCFqJbt028969;
        Thu, 12 Dec 2019 15:52:20 GMT
Received: from [192.168.14.112] (/109.65.223.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Dec 2019 07:52:19 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH v4 11/19] x86/cpu: Print VMX flags in /proc/cpuinfo using
 VMX_FEATURES_*
From:   Liran Alon <liran.alon@oracle.com>
In-Reply-To: <d0b21e7e-69f5-09f9-3e1c-14d49fa42b9f@redhat.com>
Date:   Thu, 12 Dec 2019 17:52:12 +0200
Cc:     Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
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
Message-Id: <4A24DE75-4E68-4EC6-B3F3-4ACB0EE82BF0@oracle.com>
References: <20191128014016.4389-1-sean.j.christopherson@intel.com>
 <20191128014016.4389-12-sean.j.christopherson@intel.com>
 <20191212122646.GE4991@zn.tnic>
 <d0b21e7e-69f5-09f9-3e1c-14d49fa42b9f@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=610
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912120123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=677 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912120123
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On 12 Dec 2019, at 16:13, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 12/12/19 13:26, Borislav Petkov wrote:
>>=20
>> vmx flags       : virtual_nmis preemption_timer invvpid ept_x_only =
ept_ad ept_1gb flexpriority tsc_offsetting virtual_tpr mtf =
virt_apic_accesses ept vpid unrestricted_guest ple shadow_vmcs pml =
mode_based_ept_exec
>>=20
>> virtual_nmis		-> vnmis
>=20
> Even vnmi
>=20
>> preemption_timer	-> preempt_tmr
>=20
> I would prefer the full one here.
>=20
>> flexpriority		-> flexprio
>=20
> Full name?
>=20
>> tsc_offsetting		-> tsc_ofs
>=20
> tsc_offset?
>=20
>> virtual_tpr		-> vtpr
>=20
> Do we need this?  It's usually included together with flexpriority.
>=20
>> virt_apic_accesses	-> vapic
>=20
> apicv

Frankly, I dislike APICv terminology. I prefer to enumerate the various =
VMX features which are collectively called APICv by KVM.
APICv currently represents in KVM terminology the combination of =
APIC-register virtualization, virtual-interrupt-delivery and =
posted-interrupts (See cpu_has_vmx_apicv()).

In fact, the coupling of =E2=80=9Cenable_apicv=E2=80=9D module parameter =
have made me multiple times to need to disable entire APICv features =
when there for example was only a bug in posted-interrupts.

Even you got confused as virtualize-apic-access is not part of KVM=E2=80=99=
s APICv terminology but rather it=E2=80=99s enablement depend on =
flexpriority_enabled (See cpu_need_virtualize_apic_accesses()). i.e. It =
can be used for faster intercept handling of accesses to guest xAPIC =
MMIO page.

>=20
>> unrestricted_guest	-> unres_guest
>=20
> Full? Or just unrestricted

I prefer unrestricted_guest.

>=20
> In general I would stick to the same names as kvm_intel module
> parameters (sans "enable_" if applicable) and not even bother =
publishing
> the others.  Some features are either not used by KVM or available on
> all VMX processors.
>=20
> Paolo
>=20
>> and so on. Those are just my examples - I betcha the SDM is more
>> creative here with abbreviations. But you guys are going to grep for
>> them. If it were me, I'd save on typing. :-)
>=20

