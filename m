Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5F4480EDB
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 03:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238348AbhL2CSe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Dec 2021 21:18:34 -0500
Received: from mga03.intel.com ([134.134.136.65]:3002 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229620AbhL2CSd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Dec 2021 21:18:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640744313; x=1672280313;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rhVvIVGE75a6R//tzns3i0Sh4NAiA/hRdKCrCGYO8lw=;
  b=D3txUkqVsUrxun+MqYBt+IAhsDwfJh1efbA/CpMx41Q96yovlpJPhFj5
   By6sayK20LmQuIMYJ3aNY8D246bcw6U/oyofWXEuGu1vUrySIBZMGlYKc
   lIPdVvdsql/45/oPlXPGKY0X9SWiODIbWfCGLkyEBaEZ5r9jzOmBTu3ht
   pskGJs0BE+ckIv+AsWh2FQSccNTRnyMxsf5nq8yr9r7VbiOxu4MP1SP5q
   Listpg5QaLHv1pg6hostwy3MMHqcO7yqon0X8e+UYpQWRetGQQDUl46lR
   QL6PFsoNn2uTCVkiUTeSRb9EhYcBIeirKpJZolCVs+YprlsR6RcZJT1Qj
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="241404905"
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="241404905"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 18:18:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="524696478"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 28 Dec 2021 18:18:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 18:18:32 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 18:18:31 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 28 Dec 2021 18:18:31 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 28 Dec 2021 18:18:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNopecvwPUVs2Uh2L31ZIVmgwc3cuKJRKtcmBahYEyuNM0rX+GHlwP0ZzOe8v1egrwNMbTEOtlVQfRdr8IlYE6xhbMUYWdRW6E3SrZeWQGv4BjdNnXuX53zreTPbCnkiA2lNTyI52ArBnbs43BRRoCWdomzKCQhcHXLv+QO+z9U3pTu9idkCFKa6KlrpcHs2b3mmX40ZBLAbbpyfXrUAwmcB3cbRxLUKiL2SHc6otAPYFP4jnnEvbLqZOKLOFIZpwr1lXtFQ4DGZExMOgOcVXfcFSWW3OCCLjLQIVf1lNQOGZfG5EyW0l+o+5ZuhIGtPEj5llPUUWugHOpm1G19YkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtDfFzh52Dw5vfhetzvUVesJdwQDK4sb+IjcK80jxWk=;
 b=ZG0niNSYa8NGE4H1ZcaIoBjywLn80XesNJxFSD1tvQRMG8dEAL5t9evTh9rXlt4TPvRR1cO1F5fePmZBoIGB9n8CIp2aOT9H+D3sGgqJGtSKjOrzfrTq9Uc/GeK7iyjfpyx2p0Y7BUnkyRdVaoHTeqhRrISUaofxOfRW3ymju1AhHNO8SmDYhLpjl7WbyZpPwdiILbi2sJkycEevA6eiVDif7KRDlXCOZg4UPFldxA+jvPc/ugLw7nzwsQ6dgFk2IPnydtp1HqVyGErBKlnWeUffAzFVM/c7XTlbZcrT1yEjgpch69Bq7Nf9ydHbK/Z8fljrJXH/e38df1mj8s7BFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN7PR11MB2706.namprd11.prod.outlook.com (2603:10b6:406:b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13; Wed, 29 Dec
 2021 02:18:28 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4844.014; Wed, 29 Dec 2021
 02:18:28 +0000
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
Subject: RE: [PATCH v3 05/22] kvm: x86: Check permitted dynamic xfeatures at
 KVM_SET_CPUID2
Thread-Topic: [PATCH v3 05/22] kvm: x86: Check permitted dynamic xfeatures at
 KVM_SET_CPUID2
Thread-Index: AQHX9zEx73/scnIpjECK4V7v5r/FGqxImcEAgAArYBA=
Date:   Wed, 29 Dec 2021 02:18:28 +0000
Message-ID: <BN9PR11MB52762FBBB5E887385F8DCC038C449@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
 <20211222124052.644626-6-jing2.liu@intel.com> <YcugDN+9d8t4r9bV@google.com>
In-Reply-To: <YcugDN+9d8t4r9bV@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0cffb3b-f5cf-4fa3-b5cc-08d9ca71806d
x-ms-traffictypediagnostic: BN7PR11MB2706:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN7PR11MB2706A377C22B3C0807B816768C449@BN7PR11MB2706.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ATpjhz6jWIZDKXj93B7dGNPQCw8uBUDO2K+tXStXJSWCHqirueVbeK86QXQELdVAe5v2Y/d+nmduLOZwGCr0t/bdt+5OUQxaBrI9HlNqg5HqfefEIFYuiIBZiwv88FXjS9rhFuwu4TsN6OrMGH/zZLgGQSgyyykwNbusN2VlYgA3QTyIZtAKm1QLvry9QLEOEPu1KfUwb30OPXfpv03aIiq+RyNUfmBw84h+Np6l6oTr2MO3gvd1rBTvRiaij5rp3V29taL4P26H5tg/YdsYYQIb7fwAC3Zhz6S+q7CtD20z3ocTd3jbgBWXNwwKzydqYie6ZHyn5/I7HUe2SoYOXsmCbGBw6tlQ469hRPqfXK3856Nb3aQddqsQUG2Rmg7gzkJa8vuvNrkpmsBok15qZDlwVdKPxoc5BczND5rqq0qjwiDKRBEMySI98WwZi3d39QItqLVwCjBz1VGuVQ8aMXqFoLiop3h3GGjjl4w7YNPvwBOVRf5l/qrmNYrVv3BDNR/lPwYfKdu9UePDg824Je4rVWkjd0klS+xU/TVa4c1S6zwFe5IllZoNxo3KoCML8csplkST5W4VfA5k5EiQ3X0VbSdwdNjJan7zqpnb4v/Q08shz9Rw4ljfqkQOtEGE2UNK/20OWRujQpxGxCAhXKYzRjxTQK7gSWGx5iRgPJGepiMK7VjZaQMP0ovrJoBNskuD1wmXKrd/dKGziqLVNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(6506007)(82960400001)(54906003)(76116006)(86362001)(52536014)(122000001)(55016003)(110136005)(8936002)(66946007)(71200400001)(66446008)(9686003)(5660300002)(66556008)(66476007)(508600001)(6636002)(64756008)(26005)(4326008)(33656002)(38100700002)(38070700005)(186003)(316002)(8676002)(7416002)(83380400001)(4744005)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uYanAd8ohKRLWaOBDciFikvXLIUijgK93nO1jwA7RTQQhi9GVYvbCWWtlo95?=
 =?us-ascii?Q?z5PcW7NfNcnmR8SGh3fnQ6YVYFpMBXf8byq4xZ/qoy0ztoTplr+NSHsNYK8K?=
 =?us-ascii?Q?sfrvo3laiP76smZazP2l7DiQzIC+/6Rtx7e2GSCZ8WK7XzFnqMZ5/1SfT5vK?=
 =?us-ascii?Q?XOrFWF5rC5uczUTRUR4F2bFpSzcBOfDLTJXuAa2Cu9s/7GFUPCKN0OMHNEJ9?=
 =?us-ascii?Q?1CMjQ2DS1fF1l2hqoyvFn/VAbCWs+FBWmNToSJQGJK0eN0Vd1tV0S0NvtgGZ?=
 =?us-ascii?Q?SOnjgAyMxRo8f3Dqj/F4/2NCLO9oI8iJAXgcVISGMzce/8MLKOjUzh+clHuh?=
 =?us-ascii?Q?Vx1t0ZUyOeiqTv2V3BPAcalsvAbX7DC/BzSUobKutD8inhXC7SiOz3uJc/Dg?=
 =?us-ascii?Q?QKZl9ZAuWDK+nWvaezNahuYkYHEnWcDrsGFdIXeeXVlxkhAoM8aM/vomDtoI?=
 =?us-ascii?Q?vwKgWTBubmnlWwpWMxRTon/AkZJWpAq2N6SQYQCRsPnkpf+EfGxZ8LIrfAVV?=
 =?us-ascii?Q?1MQ3XLtvI58Jk1+zjDrmH3dQmm2sHiV3Md4PeWZ1+zYzigsXzXN3oHewLDK0?=
 =?us-ascii?Q?4u6Ct/A0SDUXVqCNruNAEBZtpAFBW5Sawqqj+c6ChhlABf1jdratJhqKtiYl?=
 =?us-ascii?Q?vppfKCDIirsJA/1hRqBl/tleKqUIhkX0M3eokVNFq1Hq1/nHaFMRQpVRpAUj?=
 =?us-ascii?Q?mJM7rPsfHi2C9a74xLGZDG8Q8raJbti+p5gIA/5qS/x4DaWYtfbtQTz1LgTb?=
 =?us-ascii?Q?S6DXSW9/dmww4gGdjKGEWmklta/ECimkANWY8P2L3/70+d8Rp+KghJxVBLkn?=
 =?us-ascii?Q?ZHfuNH/6mqMQzeYOFFmjabyTzx5kqkY8Wr6/Or3sHV1TmeOMBC2M1Kc/Jpjj?=
 =?us-ascii?Q?/6q7erPQh2kYrnsiiSaiyPnPbRsPAECjCYuQbMPRdnuMPH9Cs8MpIZoZM67A?=
 =?us-ascii?Q?kue+m9GGcMemoUKrXthlJnoQk32m9aVEdi7abPUpbU2vf9ZfgwiO8yJdNR+J?=
 =?us-ascii?Q?u3QVCbIP2hh5+UpJuuvNg2sxxnct9pk6y0kk2Wq4hJ859kDsC7HdRX1qahf+?=
 =?us-ascii?Q?EHVQDeMmNadzti3ZK5k8hL86R81DXPlCZMnv2HR7wPaaWePTNiTOTqpA13Ni?=
 =?us-ascii?Q?hDSy8QXBbaXiR69Z/qA9ZCiN9BEJXcQK7LQsR0Jg1MgORmGmfnN+uWg4MepI?=
 =?us-ascii?Q?HsctZ7wAfLoHV4s5uRQfzYbRYVDuuN8XyuFdd/vZZ8Igjlc4qQcyIjg0Bzmy?=
 =?us-ascii?Q?YrdbBSbwVD3+6kDoa5knPWZxahE09JxNjubLb7YuismwTR/wbdjFTaLLRe/J?=
 =?us-ascii?Q?Mbieue69DzLf7JxJGVJQiJRpRbuUcaUbPxUnHOxSeyjvx6HqRxfx7HmTz6Gd?=
 =?us-ascii?Q?+E+k3JxzHWbQVfvoKWvTUaqxQKlRBoGLdiMGnRTRqeuPbVIb4YovLBb85ZS4?=
 =?us-ascii?Q?GQ683zZ8qGAVaSRZchOKRLyCtsT1ThoFCT8WqOshUGAVoO915keqgy+QJxO3?=
 =?us-ascii?Q?X1vLDSyDSx9uMqPoCfUWNigficIL0q6mMiFPUz9Aft4ZkID5228BNrmab772?=
 =?us-ascii?Q?UIyFg50pTR7vR4JypsTqVZ01OKpFgfT80vQfh0ubN+GsRWwmz6dQc2DU35yh?=
 =?us-ascii?Q?UDufOEG4dSOgnaZJ3aAzoXI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0cffb3b-f5cf-4fa3-b5cc-08d9ca71806d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2021 02:18:28.3160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y/2Qqsy/eYI7Y5UYG2r3jjW9GjKWCsCsexB1AMUkXk4FZEsLfjEVNGe1rHZdoMSQhm9Mfh+BgbcKxPKcBVasoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2706
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Sean Christopherson <seanjc@google.com>
> Sent: Wednesday, December 29, 2021 7:39 AM
>=20
> On Wed, Dec 22, 2021, Jing Liu wrote:
> > Guest xstate permissions should be set by userspace VMM before vcpu
> > creation. Extend KVM_SET_CPUID2 to verify that every feature reported
> > in CPUID[0xD] has proper permission set.
>=20
> Why?  Nothing in the changelog, code, or comments explains why KVM
> _needs_ to prevent
> userspace from advertising bogus features to the guest.  E.g. the virtual
> address
> width check exists because _KVM_ will do the wrong thing given a width
> other than 48
> or 57, and explicity says as much in a comment.

Advertising a known bogus feature due to lacking of permission does
no good compared to failing it early even before the guest is running. This
also avoids tons of complexity at run-time to deal with permission
violation (e.g. introducing new kvm exit reason if you tracked the v2
discussion).

But yes, we should add a clear comment here.

Thanks
Kevin
