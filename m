Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 698F7170F99
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2020 05:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgB0EU5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Feb 2020 23:20:57 -0500
Received: from mga12.intel.com ([192.55.52.136]:11313 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727735AbgB0EU5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Feb 2020 23:20:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 20:20:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,490,1574150400"; 
   d="scan'208";a="285209433"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Feb 2020 20:20:55 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 26 Feb 2020 20:20:55 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 26 Feb 2020 20:20:54 -0800
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 26 Feb 2020 20:20:54 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 26 Feb 2020 20:20:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwWm7An01OAwtc65xJWdKcl8tVnsHlI4ayA4xSPQqBRREfj/EAGuST1lIrjQLQBl0M1szQqzg95N2fZVOvH01ALNQRj+hAcZHxbyUO6JsTig2mvPu1XzhEyv4xhQd0Lt6ZuUodmdXswLytWNGEU/ax9d3CKqm8CE9vtr7QMmkX7CitfMT7VrXg9cLno9QxMLlN+FD852tJc1/6pW8GSUpDTlLOTn2FfSBpP6u6kCfSYzlLtjL1+3daBMUngrTWc1Ej4YqJ9W/Pgr16b9G8b41m3Cg9RsykkCaQNV4mIH7F1gfkFiBzh0L0Gn0rsEWmjE5yykvBRrBU5AyeTbLzUasw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNCyphXElOk0D5D8DTf6NepQi7Q4HrS9tS45qIcTiic=;
 b=NHI/+eNNNuyIEIe6d7RXio5Bmv/X+EI4h45mdHiDdaqTSIokyRwDCyleYU9SqyTLrfjKFss7O8XpJTiq3nmXF5KY4lcIdAH2JpF/mrTEZuWncX7M1pncgp/0JmC7+J1JkJ9mXZn3Y4Y+jLtBShO8BN7ig1J/SFX9resuhh9xOS9k/n0bsSCGKhGfROzhUJTaG3AI3fynfifD+C9yyoY169KXggEcDiLvuuO0DJWdwzCffDskpdszWKW94z/g37T4Cm0V63vLC6KUBs7GvLvPWp/fdpaTG76ZfZku8wauD4cOyawFuocDpj0xixrMeJ4oufifuwQ78D+Tv2ZGxRZ4hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNCyphXElOk0D5D8DTf6NepQi7Q4HrS9tS45qIcTiic=;
 b=oCdX/JMhDxRLq2h6ArE2kJL5sSuIX1Zwiu0veNx/CB1d1XgfMaj1NbGVun0YeIQUQoa6BgwAK33ctExW8KgAN1T+niFIMJm5pwURwgexaGk/hq2sjgPEE0FjLIQEWHVbpaP9g+w1JvQ9JuXhLkwxo4Q8ssGuztLdRFY/OJa0am4=
Received: from MWHPR1101MB2157.namprd11.prod.outlook.com
 (2603:10b6:301:51::10) by MWHPR1101MB2285.namprd11.prod.outlook.com
 (2603:10b6:301:57::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Thu, 27 Feb
 2020 04:20:52 +0000
Received: from MWHPR1101MB2157.namprd11.prod.outlook.com
 ([fe80::7d16:3f1d:52c9:3116]) by MWHPR1101MB2157.namprd11.prod.outlook.com
 ([fe80::7d16:3f1d:52c9:3116%5]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 04:20:52 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        "Keller, Jacob E" <jacob.e.keller@intel.com>
CC:     "TonyWWang-oc@zhaoxin.com" <TonyWWang-oc@zhaoxin.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "bp@suse.de" <bp@suse.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v5 13/19] x86/cpufeatures: Add flag to track whether MSR
 IA32_FEAT_CTL is configured
Thread-Topic: [PATCH v5 13/19] x86/cpufeatures: Add flag to track whether MSR
 IA32_FEAT_CTL is configured
Thread-Index: AQHVt7m4HwSK3U3TVkGmKj0nXJjnJqgs22KAgAHb2oCAACKiQA==
Date:   Thu, 27 Feb 2020 04:20:52 +0000
Message-ID: <MWHPR1101MB2157609E21AD5BC5D9E8897AF7EB0@MWHPR1101MB2157.namprd11.prod.outlook.com>
References: <20191221044513.21680-14-sean.j.christopherson@intel.com>
 <e741196d-52aa-0f5e-8f1e-a37ddf2e5025@intel.com>
 <20200227021221.GA14478@linux.intel.com>
In-Reply-To: <20200227021221.GA14478@linux.intel.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kai.huang@intel.com; 
x-originating-ip: [192.198.147.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be41532d-d38e-46be-a85f-08d7bb3c6ea2
x-ms-traffictypediagnostic: MWHPR1101MB2285:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB2285E100289717C52CA33F39F7EB0@MWHPR1101MB2285.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(366004)(39860400002)(346002)(376002)(199004)(189003)(7416002)(9686003)(55016002)(54906003)(110136005)(316002)(4326008)(8936002)(71200400001)(6636002)(81166006)(478600001)(5660300002)(81156014)(33656002)(66446008)(66946007)(66556008)(66476007)(64756008)(2906002)(52536014)(86362001)(76116006)(26005)(7696005)(186003)(8676002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR1101MB2285;H:MWHPR1101MB2157.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zhN92lVh7UvtjPmt9V7rJH8IGhYE2mbWWi/nCd1jT1eqXLwjpJhZ/4OgRCrheM0upTS3JVvt1pz+hAr/qowzZ5qqFHubd9hvctHDGC+esLsofnnHZmuAshFk17NVmRMP+gM3K7JjksU+HQEwttGnTlkanKBkR4+xkL/xRMRxwfou9ThEKr0/wlnb3o0g69+o12bLDOAjVjSvptpeDoxEIC6lgY7jd+vboKUIb3g5sR2vl85kX2jVRn9wgL/hFhoeH3ckdlCTqwqjrGH40sA2N5UPvXSCQil+dWeE0h+3SYVGWSIqGg5CM67kwFCcnMYGwvkg3ez88CRsegMxUh2Q8crsVhDdK7JJOfcK52DjdBlUl17st1S2LjP9MB8ULefk1+AZLgb/EszgEbanSV3n0NGRr87leLoxxhDSmKLeQ0lI6DbIYWlxo2779Nk37bJr
x-ms-exchange-antispam-messagedata: aXkjZpRtvUmxEeoaRJbFJLsAnTRlsCBaRMTaUZl61uWBbJ+0VpRyPcXf6OT8Fzsb66rs8uHvJ0oOi+rmsWQLBopyStqjt/fivptTtl6qIvFgUmPzLal8BkzpSE/f1qRaxBAGj6rPGy9Iv/ni422u4w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: be41532d-d38e-46be-a85f-08d7bb3c6ea2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 04:20:52.3000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aRWlIqVhZUMK/Mo9aixjkFilq/SfbyGIRnwq8gdHbYpMca62j9PVsj9p5Kb0wnDRhl3uf6proSGM+5Uh+yNZzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2285
X-OriginatorOrg: intel.com
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> Subject: Re: [PATCH v5 13/19] x86/cpufeatures: Add flag to track whether =
MSR
> IA32_FEAT_CTL is configured
>=20
> On Tue, Feb 25, 2020 at 01:49:13PM -0800, Jacob Keller wrote:
> > I recently ran into a general protection fault that I believe is the
> > fault of this patch:
> >
> > > [   32.189584] general protection fault, maybe for address
> 0xffffb567801bcf58: 0000 [#1] SMP PTI
> > > [   32.198103] CPU: 1 PID: 2600 Comm: rngd Not tainted 5.6.0-rc2-jk+ =
#2
> > > [   32.204454] Hardware name: Intel Corporation S2600STQ/S2600STQ, BI=
OS
> SE5C620.86B.02.01.0008.031920191559 03/19/2019
> > > [   32.214887] RIP: 0010:hardware_enable+0x100/0x1a0 [kvm_intel]
> > > [   32.220628] Code: <f3> 0f c7 34 24 31 c0 80 3d 59 8d 03 00 00 75 3=
6 48 8b
> 5c 24 10 65
> > > [   32.239373] RSP: 0000:ffffb567801bcf58 EFLAGS: 00010002
> > > [   32.244598] RAX: 0000000000300000 RBX: 0000000000000086 RCX:
> ffff8f2650440000
> > > [   32.251730] RDX: 0000000000300000 RSI: 0000000000000000 RDI:
> ffff8f2650457020
> > > [   32.258862] RBP: 0000000000000007 R08: 000000077ea5d531 R09:
> 0000000000000000
> > > [   32.265986] R10: 000001432bf20982 R11: 0000000000000000 R12:
> ffffd55b80467110
> > > [   32.273118] R13: 0000000000000000 R14: 0000000000000000 R15:
> 0000000000000000
> > > [   32.280243] FS:  00007facfe66f700(0000) GS:ffff8f2650440000(0000)
> knlGS:0000000000000000
> > > [   32.288329] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [   32.294077] CR2: 00007facf0003000 CR3: 0000000b7d402006 CR4:
> 00000000007626e0
> > > [   32.301210] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> > > [   32.308342] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> > > [   32.315474] PKRU: 55555554
> > > [   32.318186] Call Trace:
> > > [   32.320642]  <IRQ>
> > > [   32.322689]  kvm_arch_hardware_enable+0x84/0x240 [kvm]
> > > [   32.327836]  hardware_enable_nolock+0x31/0x60 [kvm]
> > > [   32.332717]  flush_smp_call_function_queue+0x4d/0xe0
> > > [   32.337683]  smp_call_function_interrupt+0x3a/0xd0
> > > [   32.342471]  call_function_interrupt+0xf/0x20
> > > [   32.346830]  </IRQ>
> > > [   32.498314] ---[ end trace bfeeeba337a01208 ]---
> >
> > I noticed that a slightly older commit from before this does not fail.
> > Additionally, the system reports the following during boot:
> >
> > kvm: disabled by bios
>=20
> One other thing that's been bothering me; you mention in a later email th=
at this
> bug resulting in a crash during boot.  The low timestamps also suggest th=
e
> system is fairly early in its bringup.
>=20
> But KVM only does VMXON when it actually creates a VM[*].  During boot I
> would expect the bug to result in KVM being incorrectly loaded/enabled, b=
ut
> that alone wouldn't trigger a crash.
>=20
> I assume/hope your system is automatically running some form of virt proc=
ess
> at boot?  Not that there's anything wrong with that, it's just suprising =
and I want
> to make sure there's not something really funky going on.

I can be wrong but it appears during boot (before you can login) libvirt ma=
y create VM simply to call some qemu monitor APIs to get some info. The VM =
is then destroyed after libvirt gets that info of course.

Thanks,
-Kai
>=20
> [*] KVM also does VMXON when hotplugging a CPU, but only if KVM has activ=
e
>     VMs, and the IPI callback above indicates this isn't the hotplug case=
.
