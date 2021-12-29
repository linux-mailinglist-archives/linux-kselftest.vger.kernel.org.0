Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06E04810BC
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 08:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239172AbhL2HhW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Dec 2021 02:37:22 -0500
Received: from mga11.intel.com ([192.55.52.93]:5092 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239157AbhL2HhV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Dec 2021 02:37:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640763441; x=1672299441;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XZNULpDl3FI4ANfWortXMiExehF2akNU5tXbX7P9h9k=;
  b=lv6V2/+T/wYRNaZHs+mWXEMOrQKeRB0EcNTDVvst2w2bn0HSUa8BwAha
   J9WQjAy0LCjqcjaqpjXoSeWidIcl71GItQXCSlaAWJVxwdBVh9WnPTNAy
   oPQmJCb5L49yh5AgnswoIem4IrQCVC4qHVb7aaZlN9xn69CGJQ4ghGdMw
   ST3aOwl3vxCC2dZ5SX+7gLwWa1kRq0A/4NzoxE/eQsscZWfAtvMo62fdM
   nlZOPXXNPox1FaLVLxt+/psmiDnf07/cjkMDuHZxroSzg68XjCOWlpRe1
   HoSLSjjlANO9Ihut22Q3uAY2T9XHQ22zx8Bi5uAPKbL8arCdWYb6cX3kx
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="239023629"
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="239023629"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 23:37:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="468403509"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 28 Dec 2021 23:37:20 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 23:37:20 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 28 Dec 2021 23:37:20 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 28 Dec 2021 23:37:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDpGp2HPNCRksauwJOS2ixRJf6PmoB/wld01PhWpBoJruuOZuS7z2sRVQYWWZd6aenDLNizjM4gGZdHKMmNefMZsYgwj0BPKEyhpglIJ3axN9XPKIaZ01cjfNxVenX25OF0SIUJKRmUnJZhbYeWVoJdbYuwD5RYSR3BcHwd6pdkqsZ0yHm4bA03q6NXr4ho+uCMNXnf6NYLrrLH9k57ft3EHi9CRb3S0qSjeXr8zWAn03h3kJRils0ntTA6y5oHjizdyVP/7KNZloThnvXocgemq78kspJDbs1BYVkgMqNVe/jSa07hF3KH+F8m8guQ00tXUdehdcwAIBKvJ4KlnfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SKz0SKJhmzIvGzTsgiHd5kAJxhnhYNcn5kfsnF0FsQ=;
 b=l9NRegdKGxvuKWvE+1Rt4rQqWLkWt53FtLaNUuleN8n2vOfqTXpf6wQ3ryszEZeQKrRr1HZUVzACv7TOPN5yN70fYsqfY9xkbNt8IhlAdNCTH5QBq1pOZvYJ55kaECh6nGIn4hnRRuuDk+2yLviT/f3q5Qd5PGwxSNsxwFE4/48OF1B5WdrWolMLm/Rt5/EaVTX9abuiTJ0HHo3IbB4QmF1aa72TJ0pYu0ir8fZlXqDXUGOS8QC43Ct7pZleoI5Tqh8nk+IraZyRT1AAkqkTxTmX3LQIsIODs1N1+r5tVf8qgXJ+Yd6bW/0HDshfL7b2NZqqQuoRTpQoPz6Q+Jb0cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB1683.namprd11.prod.outlook.com (2603:10b6:404:3f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.21; Wed, 29 Dec
 2021 07:37:14 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4844.014; Wed, 29 Dec 2021
 07:37:14 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Christopherson,, Sean" <seanjc@google.com>,
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
        "jing2.liu@linux.intel.com" <jing2.liu@linux.intel.com>,
        "Zeng, Guang" <guang.zeng@intel.com>,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        "Zhong, Yang" <yang.zhong@intel.com>
Subject: RE: [PATCH v3 22/22] kvm: x86: Disable interception for IA32_XFD on
 demand
Thread-Topic: [PATCH v3 22/22] kvm: x86: Disable interception for IA32_XFD on
 demand
Thread-Index: AQHX9zE4gQJMQm2XFEKlfvGX4m1Fn6xIsbuAgABrvfA=
Date:   Wed, 29 Dec 2021 07:37:14 +0000
Message-ID: <BN9PR11MB5276B64A8F28FF23A71C949A8C449@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
 <20211222124052.644626-23-jing2.liu@intel.com> <Ycu0KVq9PfuygKKx@google.com>
In-Reply-To: <Ycu0KVq9PfuygKKx@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12506385-5f39-4e09-bddf-08d9ca9e087d
x-ms-traffictypediagnostic: BN6PR11MB1683:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB16832F240349D85E3F2F4A8A8C449@BN6PR11MB1683.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: czs9cjGKqxK/VsKk+n3RRWjIv+tbOyCNXFbnERr9jjQrGEaigzcs4tgnoYedDgRxyzVaT8ZmP1YxrhWUzKkfvFShj+cQA9EqsbnqORpcdBMOJnLwhso9hgOnoebkD2MO86TYk8+V60T20SptGsvo6rpjtL6Xm7kv6jxu6NTvIdWCGUaRf2YBWjmy5m5aRVcrhaxRXmftgHSOCugMED89p9/uDlSErPa9byN/2LGZZXVpppLiF8ucTlcx0AtwXwFSHv41pcyVHcynE0PdxZeH35yrOahN0uU2NiKWTlTyhfTsUpVRh59CFvxhfrSIWggXE3/j++DX9Mm1bPzjAEgC25gaRQ6azYPxB4XJJLgynWcmZqj43o/snL+I2nZH+Rg3IdSDXKBCvz+hGwmeHeXL673yP+yTBSiQRbrSeuFJdqQsRaQMUrO0iNzW1L23nFH4Jv+JspQMquTVODmd56J8tEGqidBE+YZU6zQ5shfziBGMuRddhcch0bypOistLBo9R6bnIXSn7AH/Ijld10gS+ITQScE/GGK8OEO71WYsrdQEzcMI2Bhh/50Irzyjqmrj9SpQGFoMGkCYJ7NmAderPe21VLyMbbIN3YBX0l2hn+3zGwDZ5QT+7+zi2GhuYMFVRduMcbJDDIaiDzm3Ib38jQ5gzjZxiHMH4rmpH+elBc108OGNVfhG2uAQaejIotlyx6opUkuX0Ltc2twpXFnKyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4744005)(82960400001)(508600001)(2906002)(52536014)(71200400001)(5660300002)(8936002)(316002)(55016003)(110136005)(54906003)(38100700002)(8676002)(4326008)(9686003)(64756008)(66476007)(186003)(76116006)(66556008)(122000001)(26005)(7696005)(66946007)(6636002)(38070700005)(7416002)(6506007)(86362001)(33656002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YmSyqy8z0QpKoWQHFhQKXMsUDGgCNmvgSew1fnUeZRU6P/+rXAotyIZVbWTL?=
 =?us-ascii?Q?wvavuhzKftzE3GmyrVv4efYYLYHjgzcMfSzA1FwvEtBLkV1RFp69ff4VAJPd?=
 =?us-ascii?Q?1cK2Xap7CAK6VikvtczCUTzFrlcDDa1zmnNG4vgAjFC2TmTZl4xnXOH9qVdO?=
 =?us-ascii?Q?nx3CXBq7uGoDYR6GujSE4Eg0O4TxAnH5vJKoXx4/AYDdNb0kwwWqCHhrt7VF?=
 =?us-ascii?Q?L76rwiBerl2KVMl8B+JzzYZug7XFVIWNJxmgb7XfT6furps0dwJ+KOSXnuys?=
 =?us-ascii?Q?NwTPIKBUNU8+CRQt1xuHiZ/WAotSkOUETAmwv/kcNJ6YpC6ieI+SUqSRJNtP?=
 =?us-ascii?Q?VZqiZcr1/syxnGuUsCMbHYSqrNBas7UDtxk3hfzKda8+ZRwo8wr43ALcEsvn?=
 =?us-ascii?Q?3R7p56rhHQcsqcEzVeaCLkRJL/AyRgNrnzEvBLudaPyiOsFLR7kw6XQS0bhX?=
 =?us-ascii?Q?EB+u+7kztDqhTFQ958WjqUulnhbwOmuPHjwSPI9f/JahI5fF33ExqD8V4avE?=
 =?us-ascii?Q?claKNRavw0fvkrEQ36Y31FuXtK95jTolwFmxMN2cUeh30t4XGVWEr1s758OA?=
 =?us-ascii?Q?E0jMPbbBiaHt8Sdle+JZ8B/BCbQMq4oEZee7TCToRgi1kafO8U8WbXPpii5P?=
 =?us-ascii?Q?8NEJ5mH1KDorpWSu2NU+IhYC/hzfxqFajAbGOpjfJspgZCeEzkv44PH9L2F3?=
 =?us-ascii?Q?ZxYEgIxg8UdhQDSBj1NZaAph91ytE94Cp9HUhXYdCw9H8i2GotmkFHfapKBA?=
 =?us-ascii?Q?PCo0gKuHI/IqCm+F0FNj8p6BPVtsJwItJlno/vx2AuidHpZUERnipeYWwRro?=
 =?us-ascii?Q?OJo+2P2DpWJVD//NGyBo7gTUZf1TjoHrTobps6B9OFY/Gjyo65OGls36K4Mv?=
 =?us-ascii?Q?K9dXbrS0mo5tqD1hFDBOA3Rm2eAQMSzNhhGsN+VehSVpLSoMWa1bwOtq78+G?=
 =?us-ascii?Q?OFdT6E+7U3j2N2m5lOjIcOXYf//pE/zNb20DLcC13gXSmibgBriVrCwziFEf?=
 =?us-ascii?Q?JQpgisUsflrZYWe/TFR5G9T98gouNSRRYmnxwItjFYp/JVToRzOO8JvULUXh?=
 =?us-ascii?Q?XKwnBfuK7D2azBcIcD6dyMPelmC8PnEMxvrg14r768IHJ24Iq9Zb63A8OyUV?=
 =?us-ascii?Q?9pdztR3mI4nEKC4yidbn1dioGRUOXXsQSBUCqBq6eYOfcatMUoaFG5VpzFeh?=
 =?us-ascii?Q?QbmhWqG4uNVpI074KQVb+5TaEHaAE+keuPY3Eq5dxKVB0aPehWwr/BgpAAJp?=
 =?us-ascii?Q?no8dhptOZ4g6Sen3RG2fO10eB/eeIxF+EsVrnirId4mxqKWS//5qM9ki/u1I?=
 =?us-ascii?Q?z63tahIxTisAlGEqrJmTgDrHn8GTPozRDLy3awS4UEDI45XBUCEXxrDbZ/gG?=
 =?us-ascii?Q?lsw0jPZruEbi1HI48nswaRC7vGqc1uj7SAhDSebH5oC4xOk3rCqkw48bKM0E?=
 =?us-ascii?Q?KM+8JoqnIO4oDNqGc3gavoV/1D1bupnD/LFJ7SCgqW9B2XP4VDo+SRICsejs?=
 =?us-ascii?Q?QHGo1fRHU/Pa9E/FBH2o++NkUXFS2UJALdxkMsnTnk5iJzOrqQB4Nhn3oSN6?=
 =?us-ascii?Q?bkC8mneWCsOCN0azO62JkZnizlnmalBWc4HOiAnjXyEoDUT0vdwlR7Qk3y8W?=
 =?us-ascii?Q?pL5puOQ0isemsIb2GXaDOiw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12506385-5f39-4e09-bddf-08d9ca9e087d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2021 07:37:14.4861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HbxOW6FZBquMfYRZJoeBsGD3jFH88HHF0gR1qX5wgbI8y4D0cLvSxJGgaZ7FzEeQklyR/mH0myUxmnnRRVUidQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1683
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Sean Christopherson <seanjc@google.com>
> Sent: Wednesday, December 29, 2021 9:05 AM
> > +	if (vcpu->arch.xfd_out_of_sync)
>=20
> Rather than adding a flag that tracks whether or not the MSR can be writt=
en
> by
> the guest, can't this be:
>=20
> 	if (!vmx_test_msr_bitmap_write(vcpu->loaded_vmcs->msr_bitmap))
> 		fpu_sync_guest_vmexit_xfd_state();
>=20

and forgot to mention a change different from above. It's in x86
common exit path but above is vmx specific check. I'm not sure
whether it's worthy of introducing another kvm_x86_ops callback
just for this minor usage.

Introducing an extra flag (e.g. vcpu->arch.xfd_disable_interception)
sounds simpler here.

Thanks
Kevin

