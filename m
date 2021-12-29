Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E8B480F17
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 03:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238420AbhL2C6K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Dec 2021 21:58:10 -0500
Received: from mga02.intel.com ([134.134.136.20]:39773 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231184AbhL2C6J (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Dec 2021 21:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640746689; x=1672282689;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dLd9bymtguQzaaQyxOlkg16XognIcziZvgKLUagk66I=;
  b=jpjbiEcyuht9IlcP1voWYKLlQKgPeits3XHWBc0RshgrFipRQ+oId7DV
   mNiWNbMZzmZoar6CS7UmG/rm++oQqLhRBGeM5PKAoGy0/R/gqJruDD0t9
   dlrajId7DzS6+8VLKxFY3PfRpho8Mk/iUP+pKjJwp1MvJKhXDCsjYlkDf
   IUTvdJ0zhkIGPVIPuaFj+0mhKunEJs7ccltTGIhYKH7D5fvv42qo9PrO8
   vaEHrC4CXEeWgQVs3MLoM9cnWn5ZRpuZTFMq88t+PRRnitjVWmqN69N+G
   stjwl2crCG+DAl0o/WdLSwlBBqCu6FKJI1JsUGYTde8dj4znQHoQULFmV
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="228759006"
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="228759006"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 18:58:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="468351312"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 28 Dec 2021 18:58:08 -0800
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 18:58:07 -0800
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 SHSMSX605.ccr.corp.intel.com (10.109.6.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 29 Dec 2021 10:57:58 +0800
Received: from shsmsx601.ccr.corp.intel.com ([10.109.6.141]) by
 SHSMSX601.ccr.corp.intel.com ([10.109.6.141]) with mapi id 15.01.2308.020;
 Wed, 29 Dec 2021 10:57:58 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     Sean Christopherson <seanjc@google.com>,
        "Liu, Jing2" <jing2.liu@intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "jing2.liu@linux.intel.com" <jing2.liu@linux.intel.com>,
        "Zeng, Guang" <guang.zeng@intel.com>,
        "Zhong, Yang" <yang.zhong@intel.com>
Subject: RE: [PATCH v3 19/22] kvm: x86: Get/set expanded xstate buffer
Thread-Topic: [PATCH v3 19/22] kvm: x86: Get/set expanded xstate buffer
Thread-Index: AQHX9zEzSlOQN5qoiU+4/XO83sogbaxIJFAAgACYqxA=
Date:   Wed, 29 Dec 2021 02:57:58 +0000
Message-ID: <96d1266eeeb8434f9e23f9a051e252e6@intel.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
 <20211222124052.644626-20-jing2.liu@intel.com> <YcuuCMCQryzUFoAZ@google.com>
In-Reply-To: <YcuuCMCQryzUFoAZ@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wednesday, December 29, 2021 8:39 AM, Sean Christopherson wrote:
> To: Liu, Jing2 <jing2.liu@intel.com>
> Cc: x86@kernel.org; kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-doc@vger.kernel.org; linux-kselftest@vger.kernel.org; tglx@linutron=
ix.de;
> mingo@redhat.com; bp@alien8.de; dave.hansen@linux.intel.com;
> pbonzini@redhat.com; corbet@lwn.net; shuah@kernel.org; Nakajima, Jun
> <jun.nakajima@intel.com>; Tian, Kevin <kevin.tian@intel.com>;
> jing2.liu@linux.intel.com; Zeng, Guang <guang.zeng@intel.com>; Wang, Wei
> W <wei.w.wang@intel.com>; Zhong, Yang <yang.zhong@intel.com>
> Subject: Re: [PATCH v3 19/22] kvm: x86: Get/set expanded xstate buffer
>=20
> Shortlog needs to have a verb somewhere.
>=20
> On Wed, Dec 22, 2021, Jing Liu wrote:
> > From: Guang Zeng <guang.zeng@intel.com>
> >
> > When AMX is enabled it requires a larger xstate buffer than the legacy
> > hardcoded 4KB one. Exising kvm ioctls
>=20
> Existing
>=20
> > (KVM_[G|S]ET_XSAVE under KVM_CAP_XSAVE) are not suitable for this
> > purpose.
>=20
> ...
>=20
> > Reuse KVM_SET_XSAVE for both old/new formats by reimplementing it to
> > do properly-sized memdup_user() based on the guest fpu container.
>=20
> I'm confused, the first sentence says KVM_SET_XSAVE isn't suitable, the
> second says it can be reused with minimal effort.

Probably "doesn't support" sounds better than "isn't suitable" above. But p=
lan to reword a bit:

With KVM_CAP_XSAVE, userspace uses a hardcoded 4KB buffer to get/set xstate=
 data from/to
KVM. This doesn't work when dynamic features (e.g. AMX) are used by the gue=
st, as KVM uses
a full expanded xstate buffer for the guest fpu emulation, which is larger =
than 4KB.

Add KVM_CAP_XSAVE2, and userspace gets the required xstate buffer size from=
 KVM via
KVM_CHECK_EXTENSION(KVM_CAP_XSAVE2). KVM_SET_XSAVE is extended with the sup=
port to
work with larger xstate data size passed from userspace. KVM_GET_XSAVE2 is =
preferred to
extending KVM_GET_XSAVE to work with large buffer size for backward-compati=
ble considerations.
(Link: https://lkml.org/lkml/2021/12/15/510)

Also, update the api doc with the new KVM_GET_XSAVE2 ioctl.




>=20
> > Also, update the api doc with the new KVM_GET_XSAVE2 ioctl.
>=20
> ...
>=20
> > @@ -5367,7 +5382,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
> >  		break;
> >  	}
> >  	case KVM_SET_XSAVE: {
> > -		u.xsave =3D memdup_user(argp, sizeof(*u.xsave));
> > +		int size =3D vcpu->arch.guest_fpu.uabi_size;
>=20
> IIUC, reusing KVM_SET_XSAVE works by requiring that userspace use
> KVM_GET_XSAVE2 if userspace has expanded the guest FPU size by exposing
> relevant features to the guest via guest CPUID.  If so, then that needs t=
o be
> enforced in KVM_GET_XSAVE, otherwise userspace will get subtle corruption
> by invoking the wrong ioctl, e.g.
>=20
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c index
> 2c9606380bca..5d2acbd52df5 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5386,6 +5386,10 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>                 break;
>         }
>         case KVM_GET_XSAVE: {
> +               r -EINVAL;
> +               if (vcpu->arch.guest_fpu.uabi_size > sizeof(struct
> kvm_xsave))
> +                       break;
> +

Looks good to me.

Thanks,
Wei
